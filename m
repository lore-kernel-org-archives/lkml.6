Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A82C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9B0223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DYicuv+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9B0223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbeKNARV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:17:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33122 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730998AbeKNARU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:17:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id u9-v6so13524159wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Mt9FQZVJ6HnWeTqICvrIigfq2A0j27qZBQUdAOOxtlQ=;
        b=DYicuv+Vu5ace7sdpxHRVZCeI81dOL3MGGzITCc8TQzGYVxj1YgQzf6llei4qqnjgu
         xSxeZkJgivWJMAwf4J+UqdQCMtcJSYUaTcNJXZmc5dTbi0381u/1070wLxBe0n02u6rJ
         n23YaxtZ8tlr7JZAFiwW6rJ0PZM0+R6hFrlU/vvZB8MnhbVN0aa6TIzDobcFjQInXDlC
         beXmTWkejjcITCt0oE5DgyeRDnPcvIfxmP4h4Pqc/5yWAZ4p032itOOYkdGckTtJVc7y
         RJc80WsgEZ+s7da95BRL4G6se4Gvf22VgwsI3LsJPUZ0jDtaNyATq8MNqNEAwd3QLFWf
         UAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Mt9FQZVJ6HnWeTqICvrIigfq2A0j27qZBQUdAOOxtlQ=;
        b=TiC7BRDC3DmsFZC8ZEIQc5AfhDwW0MKqfjjK0+1obTTZBi1sA7SIbp9aHRL7mgRXah
         1bsTp9NqLRzGSwaOPRYfrht6/r3HVW7CVeYssBRgBHCFbXKBON0tHxr1BNF4mLaEJTq+
         b7bah3i73BpXWhIoc6Jaav5bqy2/+jRwtSrQDiwzGfoAzoLS1K69dzu9V+pmwT+awGMH
         V/694wk49CIi2+2g4fHGGyF7rmdH5TpBKnTs5fX+KIwNxXFX4b5u0opZZHhqEndXquIW
         HyRGlTKoJ80znfGrxHg+GZsDJwLPxXjx6Y2sASgHCMxcdjWZVpJbYIyMyKqT8cWw/3Tb
         I0Mg==
X-Gm-Message-State: AGRZ1gKaBWRAy4FVegZyzqEGdqTj6ooXyracmxPmfwOn5/PT2oxXMuL7
        94vBKHyCcAizWdboeZs3c/ptlg==
X-Google-Smtp-Source: AJdET5c3pltttjShzyk4bSplyIXAeF7dbLrktiQ3qjB0XQnfWW4WDTwwI8cVCVkBd7jEvB9selLEMQ==
X-Received: by 2002:adf:f712:: with SMTP id r18-v6mr5836258wrp.166.1542118737973;
        Tue, 13 Nov 2018 06:18:57 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id m9-v6sm23592393wrn.36.2018.11.13.06.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 06:18:57 -0800 (PST)
Message-ID: <f7679f4c93aca9a11b9078611b6c4952e83c9a9e.camel@baylibre.com>
Subject: Re: [PATCH v2 0/4] clk: meson: Add video clocks path
From:   jbrunet@baylibre.com
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 13 Nov 2018 15:18:55 +0100
In-Reply-To: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
References: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-06 at 15:57 +0100, Neil Armstrong wrote:
> This patchset is an attempt to handle the Amlogic Meson GX Video clock
> in the Common Clock Framework in order to move the video pipeline and
> HDMI controller clock management out of the Meson DRM Driver.
> 
> In order :
> - Add support the VID_PLL fully programmable divider used right after the
>   HDMI PLL clock source.
> - Fix the GXL HDMI PLL DCO
> - Add the video clock bindings covering all the video graphics pipeline
>   and the HDMI controller.
> - Add the clocks entries used in the video clock path
> 
> The vid_pll programmable divider is introduced in its R/O form right now,
> but will be extended to be R/W in a next iteration.
> 
> All dividers are flagged with CLK_GET_RATE_NOCACHE, and all gates are
> flagged
> with CLK_IGNORE_UNUSED since they are currently directly handled by the
> Meson DRM Driver.
> 
> Once the DRM Driver is fully migrated to using the Common Clock Framework
> to handle the video clock tree, the CLK_GET_RATE_NOCACHE and
> CLK_IGNORE_UNUSED
> will be dropped.
> 
> Changes since v1 at [1]:
>  - Fixed comments from Martin
>  - Fixed GXL HDMI PLL DCO
>  - Added the missing HDMI controller clock
>  - Moved bindings to a separate patch
>  - Updated the commit logs
> 
> [1] 
> https://lkml.kernel.org/r/1532079581-978-1-git-send-email-narmstrong@baylibre.com
> 
> Neil Armstrong (4):
>   clk: meson: Add vid_pll divider driver
>   clk: meson-gxbb: Fix HDMI PLL for GXL SoCs
>   dt-bindings: clk: meson-gxbb: Add Video clock bindings
>   clk: meson-gxbb: Add video clocks
> 
>  drivers/clk/meson/Makefile            |   2 +-
>  drivers/clk/meson/clkc.h              |   6 +
>  drivers/clk/meson/gxbb.c              | 773
> +++++++++++++++++++++++++++++++++-
>  drivers/clk/meson/gxbb.h              |  26 +-
>  drivers/clk/meson/vid-pll-div.c       |  91 ++++
>  include/dt-bindings/clock/gxbb-clkc.h |  18 +
>  6 files changed, 911 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/clk/meson/vid-pll-div.c
> 

Looks sane enough ;)

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

