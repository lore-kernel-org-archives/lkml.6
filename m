Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A33C6783B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70B02082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J8XkXx05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70B02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeLJPvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:51:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38558 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbeLJPvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:51:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so11007103wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 07:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=m6cwT/ocb1B4h1dCoz0etPB+Z06WAAvYdp5kLdPUs0k=;
        b=J8XkXx05v+OxA56TcOPvqY4j7tJwNayyHCmQQxZURBATOeHGGFgknEh0wM7Juk/sDK
         982EVJ8MWF1YhSVeqnlskEcpbxdOOkAA9C2aJvPHYtiKKIQ4ZOl+nj+IU8xL3nEwASB8
         DkOsU//yrD+e0Gj0Sq1+HYPtslVixMogj8VIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=m6cwT/ocb1B4h1dCoz0etPB+Z06WAAvYdp5kLdPUs0k=;
        b=Uon96lkwWjVV7Aj0cqKKWwjyPvcD2h8aVf3oDjTTLd65B1cD0fbjy4Z0zlTBKJpD7G
         g0jaNZuafTZovSjAD2BBVvFr3KwA9AXS+J9YR/vX/LMK746YvYr1Nx4SULCiPcAXB1i5
         d8N60TYEM1F2igKM9LWBKFgFWtGZWUBDc5D8NCfLEEnp/1mQcGkstgX/oOPVoYQel66s
         w7YndEnsQloT+lzmdy0GS7bCYEDXjtfxjqidWdY5689DVBUGdO10sgK+q3ltL8id38Pc
         SBA0UhobjN1Dwsvf7xVJ3RaPGGP1U3hFIhadOINwtU/35ALONxtoIW+BJVZxE/AOw84j
         ZUCQ==
X-Gm-Message-State: AA+aEWa9m6pz5ojV4s+9hpPq89vrIobzeThWQVRPVJzSs0BPKtXZ3Jhe
        8KWSnj8E+wq9vS0y300Dee7FdA==
X-Google-Smtp-Source: AFSGD/XvNQglXiAOrB7s+MHasw5pgApnMnz/cYUcefMRjMG0Cx3EXsa0PZV/0UCRtjbr2UMBPjoczQ==
X-Received: by 2002:adf:c3c9:: with SMTP id d9mr10248434wrg.68.1544457105623;
        Mon, 10 Dec 2018 07:51:45 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id z14sm9504300wrm.48.2018.12.10.07.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 07:51:45 -0800 (PST)
Date:   Mon, 10 Dec 2018 15:51:43 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Backlight fixes for v4.20
Message-ID: <20181210155143.GB4497@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

Enjoy!

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-fixes-4.20

for you to fetch changes up to d347d0c82a99b41efc2770fc01a04066903300df:

  backlight: pwm_bl: Fix brightness levels for non-DT case. (2018-12-10 15:37:47 +0000)

----------------------------------------------------------------
 - Bug fixes
   - Fix brightness levels when !DT

----------------------------------------------------------------
Enric Balletbo i Serra (1):
      backlight: pwm_bl: Fix brightness levels for non-DT case.

 drivers/video/backlight/pwm_bl.c | 41 ++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)
 
-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
