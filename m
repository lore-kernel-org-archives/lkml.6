Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF92FC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8B42086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8JVWBxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8B42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbeJLQBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:01:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32892 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbeJLQBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:01:49 -0400
Received: by mail-io1-f68.google.com with SMTP id l25-v6so8656934ioj.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 01:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OlsVj/nDPSdvnJP+N5JRy0PtPIng+wwb7hGyqCmyRMI=;
        b=U8JVWBxepr/sNF3wpOTxccPKy4uUmiqouO3IozyboEYSNb7fpQOTS+NxL6K7ZJ9WDJ
         6a04iqNibEFCsEVeJ0fuXCgH3ci4AU2UKDQG+Wm02FUrZYgGeyTCpD85E4RV+WQCg57d
         88cBVrq499QpQR+16md9khO3s31o97sZy6gUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OlsVj/nDPSdvnJP+N5JRy0PtPIng+wwb7hGyqCmyRMI=;
        b=tmjgUqg7oDMNYBTkBsAZsI5OIKGuIZrkgWy/81pTtlCuvqfF3jMVSfY+T3dar5HIk4
         GrSeRQ+nPE1X1m/wWo9Ycw97YWYzxfng+JAso4IDuEoh4tuS0uawq343qthgE5ywLpPY
         Q4HrPOwqLoTSoLKcyn6AqcCerzcCzkPtjov11B0RtcXJcE37GNGQ94MgQdrHlTdENeKc
         eL+/tH4Lf/EPpRc7AcPmNCvYf5hJvUX/dcNtyIMM2ahJe+eOGUzMWBVb9EbpGH8tjISb
         xBfF8aMLDrDzbcaqnvZ9PDCN+NP0Z3kjQBUF0hYDNGR86/ZqFFVYfCMyqplX5glrjvQt
         K7uw==
X-Gm-Message-State: ABuFfoheAEhPUv3LNIVE9F4LMS2+j9yVQ4O3898COBxM0UVlGY2Fc5jC
        anNezfRhNkTjaBNkbnS3ZO9Mdf4+EscR9S5gqxDitw==
X-Google-Smtp-Source: ACcGV61R0tWTcXnBDL653GlL1ADSt6D1VU7EsRDj6CSPde9Ek6DQ2YkaQ0VcCsGndxrS68KCDONuqhzGzQPmO7zxxss=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr3313417ioa.277.1539333030065;
 Fri, 12 Oct 2018 01:30:30 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Oct 2018 10:30:18 +0200
Message-ID: <CACRpkdYaWwrwYvOK9PoFE7GvyAZxVA5JqPbCRSpLHLVcQubp6w@mail.gmail.com>
Subject: [GIT PULL] pin control fix for v4.19
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here is a last minute pin control fix for the v4.19 series.

Please pull it in. It fixes interrupts on the MCP23s08.

Yours,
Linus Walleij


The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v4.19-5

for you to fetch changes up to f259f896f2348f0302f6f88d4382378cf9d23a7e:

  pinctrl: mcp23s08: fix irq and irqchip setup order (2018-10-10 14:36:35 +0200)

----------------------------------------------------------------
A single pin control fix for v4.19:
- Interrupt setup in the MCP23S08 driver.

----------------------------------------------------------------
Marco Felsch (1):
      pinctrl: mcp23s08: fix irq and irqchip setup order

 drivers/pinctrl/pinctrl-mcp23s08.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)
