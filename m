Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCCAECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F3E20856
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lsitec-org-br.20150623.gappssmtp.com header.i=@lsitec-org-br.20150623.gappssmtp.com header.b="IoGRvHA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F3E20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lsitec.org.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbeGRQGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:06:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34869 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbeGRQGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:06:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id b10-v6so4599559edi.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lsitec-org-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=F7+oGE5RUvap16ocpYdmnUtCQ73ScOEIE+oLmhoLXQw=;
        b=IoGRvHA3pZNClA6h2FvBIu0kPSbpm+EfKY6jAwkxHFuwjaPQRgRgXAMqr1dUh7XnpN
         /CCIMmTQoZ0+y3p73JvCOPcvGTsxPbB4j5UvcBaQmhXjCfFVDGo9xCt3MH7K95LeuBsC
         f2shR2RvV/pLJn8z5io1k5+ZYWLDTZVF4VSRf1ftSy2votEIbsHShNBPWBDa6T48BJfk
         Eo7LnUFsqLlWY1JbBeYntSJ0dSHRRg0cdDjx8bHxRopIZW7ex4hsBjqxD0gBtddUSYa8
         zks3FnejlPcMJ+ELb3R2tb7/WVhCzXkCrm4P1cMBS6Gq7F7O4Fjx6wJEEqIECD2g8KqM
         hU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=F7+oGE5RUvap16ocpYdmnUtCQ73ScOEIE+oLmhoLXQw=;
        b=Nn8hJWznHTTScN20upDxDNA9LSYZBLtb8pi8YnVr2o5Tasbm0DYDjNxvg5XocvDmTd
         ht73/5YYchcR1pupWhxGnpry+WY4mZ6cltKPqo10UJpwVI1Jt1mPXXZc2xtw0+33Uo7Q
         NrrSjHWYFIFSDGdgGLBneypo+CnrvKRm68QQg6G0662jtEq4cfT0pMHC0hpbgnBKNW/f
         CFxQJMlyulaFKceClWMQWXxYC2yTQ1qWZNgJzrY2TxhRwOaB20nqpEGRE9VSpG8oSDs5
         9WHZ22PBtxCiMyvpEGnpELKxINJsgiZdIPfaGxYhqWGoJuxDVC2D2smV9dv0KI0YlSg8
         F1rw==
X-Gm-Message-State: AOUpUlEyxfXJekLZRq1vw6onmHJUo/MfHmKwc6830jWqZQWatecsglXl
        FkurrbxgV2+ZayY1cn1ZsYv1tZs0WidUSA61gcw1Lw==
X-Google-Smtp-Source: AAOMgpfJ7X49t3ukprlz9pfDgaTaILnKZNvP7ZtQ4rwIwvdbiD34rCsdMgOo2IMpA5gi7ECpe9M391E5YTda4x5cA6E=
X-Received: by 2002:a50:a666:: with SMTP id d93-v6mr7706420edc.244.1531927676880;
 Wed, 18 Jul 2018 08:27:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:d1cd:0:0:0:0 with HTTP; Wed, 18 Jul 2018 08:27:56
 -0700 (PDT)
From:   Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Date:   Wed, 18 Jul 2018 12:27:56 -0300
Message-ID: <CADHB5bA2KiPSN32+G-Oyf9AfOkFrOB48sc54K5rFem9+xyWtAQ@mail.gmail.com>
Subject: [PATCH v1 00/04] Add clock driver for Actions Semi S500 SoC
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, linux@armlinux.org.uk,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Guilherme_G=2E_Sim=C3=B5es?= 
        <guilherme.simoes@lsitec.org.br>,
        Jon maddog Hall <jon.maddog.hall@gmail.com>,
        mkzuffo@lsi.usp.br,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        sboyd@kernel.org, mark.rutland@arm.com, linux@cubietech.com,
        support@cubietech.com, catalin.marinas@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        will.deacon@arm.com, thomas liau <thomas.liau@actions-semi.com>,
        darren@cubietech.com, robh+dt@kernel.org,
        jeff.chen@actions-semi.com, pn@denx.de, mp-cs@actions-semi.com,
        Laisa Costa - LSI-TEC <laisa.costa@lsitec.org.br>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds clock support for Actions Semi Owl series S500 SoC
with relevant clock bindings and device tree info.

This patchset depends on patch "[PATCH v6 1/5] clk: actions: Add
missing REGMAP_MMIO dependency" by Saravanan Sekar.
This patchset depends on patch "[PATCH] clk: actions: Add custom delay
option to Actions Semi OWL pll clock driver" by Edgar Bernardi Righi.

Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
