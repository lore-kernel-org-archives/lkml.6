Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC66C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69AC21904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SArucJX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfBGNA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:00:27 -0500
Received: from mail-vk1-f180.google.com ([209.85.221.180]:35521 "EHLO
        mail-vk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfBGNA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:00:27 -0500
Received: by mail-vk1-f180.google.com with SMTP id r127so1078576vkf.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 05:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=SoPLEcxSb2fI/ZxbNtnw3pwiFiA2H4m5HstnGw76ni8=;
        b=SArucJX4hrsliDuYxnBo1e3vFaW1QAwzaiCLuM/BzMOt2MzjceeRvpxDVGJorSfWmU
         47D1npJv5YuaK/78+dCCNRFjZmCXKwnqhI5fQuzEjtnnZRm0uYavDGFXdUuXhD8C+gMm
         tSn0h1+23dcYx49aZjFYr6FPSPn9FgkZb1ZGy0iI+FHIMv/4w9l1A12HXqk6gTVl0NiM
         lrQaa4VwKTlsY/3dHIbR+NDivUIOq7pu1xPfcR4pFKorWG0M5FDs3jsbBYvF9RKnwuMW
         KY28lMNuxz8MfvCz5atQn75yFwwWT0p6/ggRDvegMioOarxkIitUFisrEu7djhCX/ddC
         TorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=SoPLEcxSb2fI/ZxbNtnw3pwiFiA2H4m5HstnGw76ni8=;
        b=peAZ/FKNn/Yce81IECrSnbtgSEAe6yJP42Pl1UCpYiQ1XRwilr7/I2+aMfJzVPSPvf
         M9nNYRCMBCzlWrUVW5ww1S5s80Az0cuXslTSNcyRxho6m/yRTr6aRBttatamnoulr7xK
         /0PSzxra1pnUonq6hOfYVZ9stD0tfqawColNu3irpsboU+UXhTBZnqrkQT+I/cb/IigD
         qU3Sk4e95pCs68IfYTkqcukPI3IfNb2gdGT8Zok15HcItNSWo1WTx8j1wsruCQ47SSwm
         hj0r3eVF3vzVcMGjGzynDJAjnkcRU20U4qfZIW8AbhKy5hHDsX5uQ8lNZ8c0GAJSrv2n
         pVcw==
X-Gm-Message-State: AHQUAubcOCwUCUE44FKLr/G+5sLaGtcOqisqDstGjxvXjXsCNm+gCCSO
        4+g7cvVEDS2+xR7LcjoFz+zJKVay6vDr6wvL4g==
X-Google-Smtp-Source: AHgI3IYwXHLg0Uk6RF/i3IFfSNCzX5D1nPQjIjK/E5JNQg6U0g3XX+Qljv44j2W91cXx+/O0Y+GrIw2u2GoyxkgFOsw=
X-Received: by 2002:a1f:dd45:: with SMTP id u66mr3040554vkg.10.1549544425656;
 Thu, 07 Feb 2019 05:00:25 -0800 (PST)
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
From:   tedheadster <tedheadster@gmail.com>
Date:   Thu, 7 Feb 2019 08:00:14 -0500
Message-ID: <CAP8WD_YG_qirbSoVtyYoWRhZeON6p2RbN06B_yGQk1pA3==UTg@mail.gmail.com>
Subject: [4.17 Regression]: x86/dma: Use DMA-direct
To:     Christoph Hellwig <hch@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,
  in the 4.17 cycle you submitted the patch "x86/dma: Use DMA-direct".
This causes the VGA video on my laptop to stop working, but the system
continues to be up and functioning. Video works until about 3/4 the
way through boot, when I think it is loading a video driver, and then
video hangs. I could ssh to it and the keyboard would respond to
alt-sysrq commands.

Strangely, it started working again in the 4.20 cycle with the
addition of Fenghua's patch "x86/cpufeatures: Enumerate MOVDIRI
instruction". This is odd to me because it looks like a very simple
patch.

I only have CONFIG_VGA_CONSOLE, CONFIG_FRAMEBUFFER_CONSOLE and
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY enabled, with no
hardware-specific framebuffer config option set.

lspci -nn of my VGA adapter gives the following:

00:02.0 VGA compatible controller [0300]: Intel Corporation
82852/855GM Integrated Graphics Device [8086:3582] (rev 02)

Your thoughts? How can I help debug this?

Reported-by: Matthew Whitehead <tedheadster@gmail.com>
