Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640ECC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10214256D1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgLsVQT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10214256D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933933AbeFYMIv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:08:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37925 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933896AbeFYMIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:08:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so9706315wmf.3;
        Mon, 25 Jun 2018 05:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=paIrNhwsINTWGKsiQSTItVXUyK+5yWJpp1m5pz5Mkd8=;
        b=BgLsVQT+E4ProMUdZbb0/bCCPTY3Wo2okTBoE0Yvup1r6wWJyXZd9RgNmxgLe1WqFn
         7PTzG/3x+bq6UJe6RfhK0quco+MeYZtlQB0nZV4Dds5ZrsDZUmGYeirLlVdMgjzr49m/
         KygTSgbS2mtjW0/dYNkX7R2xdlGw8JYGxqEGX4bUHwlgcV30uWc2jfWq3+KJDpty2afi
         UhpR11Y2kAGNvj3BhlbiBqKUU5luWb73nB+q4xSV+xvQzg6PXRy+fSl3iRnv2HkMiecm
         aAuXQ6yvsmj8q/o1pfBgBMtJX7Dl9ZraDnxroCgGdX3Tqj/+YcXgCxmpmsZqwiv5qjBe
         QbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=paIrNhwsINTWGKsiQSTItVXUyK+5yWJpp1m5pz5Mkd8=;
        b=lgWZkWavYTxWShqMFhf1S+7LoPCCrKO/N1NjlVC6ejz5rHVAyZZgaONq79vfLiXfs/
         p+xX7CqotrrS5hi7XUojsJJ7Hc0ws9+IWOLkh/m36NK0pDo3KT8ohV+Bmg2ApIDoxpEy
         tVzQ23d44DKPNT3XFPXsIjgSnbsRn1IwzVZd0IzPRtt4aliHXFqQe7iUg496avEBQBiT
         g6GCvVOdKgyefL7dwZOQriz7t3pA8mBJ+/ID2iCltSQALZA1qa26ENEIrhY9LqtjdLSy
         +TA1AGhrv9UQbh+2odfLxxPe/hy5z0+pPRzHIct2bWdNn/QG4DgW4zUH3yD9E9pLehfX
         6XKw==
X-Gm-Message-State: APt69E1xFnshv/YkwDMZB+v9G5b8g2jlAyyxqp/yZjBmPD5vpse2ceoU
        v85GKOYXqL4aEVfEJat5qyo=
X-Google-Smtp-Source: AAOMgpeVUepYZCveodI/W19Y4+9q7RYvu2ImAtjWnZDLIwP2mI59RhRs4cot9FSb5u+W7wMNBF7/VA==
X-Received: by 2002:a1c:d391:: with SMTP id k139-v6mr779508wmg.45.1529928524652;
        Mon, 25 Jun 2018 05:08:44 -0700 (PDT)
Received: from jernej-laptop.localnet ([194.152.15.144])
        by smtp.gmail.com with ESMTPSA id o131-v6sm1113270wmo.22.2018.06.25.05.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 05:08:43 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com
Cc:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [linux-sunxi] [PATCH v3 00/24] Add support for R40 HDMI pipeline
Date:   Mon, 25 Jun 2018 14:07:22 +0200
Message-ID: <2662242.Y24NoxnheK@jernej-laptop>
In-Reply-To: <20180625120304.7543-1-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 25. junij 2018 ob 14:02:40 CEST je Jernej Skrabec napisal(a):
> This series adds support for R40 HDMI pipeline. It is a bit special
> than other already supported pipelines because it has additional unit
> called TCON TOP responsible for relationship configuration between
> mixers, TCONs and HDMI. Additionally, it has additional gates for DSI
> and TV TCONs, TV encoder clock settings and pin muxing between LCD
> and TV encoders.
> 
> However, it seems that TCON TOP will become a norm, since newer
> Allwinner SoCs like H6 also have this unit.
> 
> I tested different possible configurations:
> - mixer0 <> TCON-TV0 <> HDMI
> - mixer0 <> TCON-TV1 <> HDMI
> - mixer1 <> TCON-TV0 <> HDMI
> - mixer1 <> TCON-TV1 <> HDMI
> 
> Please review.
> 
> Best regards,
> Jernej
> 
> Changes from v2:
> - Collected tags
> - Exported drm_crtc_port_mask() symbol
> - Removed TCON TOP reset name
> - TCON TOP gates have now right parents
> - updated TCON TOP bindings
> - dropped new TCON quirk due TCON TOP rework

Forgot to add:
- in "drm/sun4i: Don't change clock bits in DW HDMI PHY driver" patch, only 
parent selection bit is reset to 0. Previously whole register was set to 0. 
Previous version broke H3 HDMI.

> 
> Changes from v1:
> - Split DT bindings patch and updated description
> - Split HDMI PHY patch
> - Move header file from TCON TOP patch to dt bindings patch
> - Added Rob reviewed-by tag
> - Used clk_hw_register_gate() instead of custom gate registration code
> - Reworked TCON TOP to be part of of-graph. Because of that, a lot of
>   new patches were added.
> - Droped mixer index quirk patch
> - Reworked TCON support for TCON TOP
> - Updated commit messages
> 
> Jernej Skrabec (24):
>   clk: sunxi-ng: r40: Add minimal rate for video PLLs
>   clk: sunxi-ng: r40: Allow setting parent rate to display related
>     clocks
>   clk: sunxi-ng: r40: Export video PLLs
>   dt-bindings: display: sunxi-drm: Add TCON TOP description
>   drm/sun4i: Add TCON TOP driver
>   drm/sun4i: Fix releasing node when enumerating enpoints
>   drm/sun4i: Split out code for enumerating endpoints in output port
>   drm/sun4i: Add support for traversing graph with TCON TOP
>   drm/sun4i: Don't skip TCONs if they don't have channel 0
>   drm/sun4i: tcon: Generalize engine search algorithm
>   drm/sun4i: Don't check for LVDS and RGB when TCON has only ch1
>   drm/sun4i: Don't check for panel or bridge on TV TCONs
>   dt-bindings: display: sun4i-drm: Add R40 mixer compatibles
>   drm/sun4i: Add support for R40 mixers
>   dt-bindings: display: sun4i-drm: Add description of A64 HDMI PHY
>   drm/sun4i: Enable DW HDMI PHY clock
>   drm/sun4i: Don't change clock bits in DW HDMI PHY driver
>   drm/sun4i: DW HDMI PHY: Add support for second PLL
>   drm/sun4i: Add support for second clock parent to DW HDMI PHY clk
>     driver
>   drm/sun4i: Add support for A64 HDMI PHY
>   drm: of: Export drm_crtc_port_mask()
>   drm/sun4i: DW HDMI: Expand algorithm for possible crtcs
>   ARM: dts: sun8i: r40: Add HDMI pipeline
>   ARM: dts: sun8i: r40: Enable HDMI output on BananaPi M2 Ultra
> 
>  .../bindings/display/sunxi/sun4i-drm.txt      |  62 +++-
>  .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  45 +++
>  arch/arm/boot/dts/sun8i-r40.dtsi              | 269 ++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun8i-r40.c          |  58 ++--
>  drivers/clk/sunxi-ng/ccu-sun8i-r40.h          |   8 +-
>  drivers/gpu/drm/drm_of.c                      |   5 +-
>  drivers/gpu/drm/sun4i/Makefile                |   3 +-
>  drivers/gpu/drm/sun4i/sun4i_drv.c             | 121 +++++--
>  drivers/gpu/drm/sun4i/sun4i_tcon.c            |  66 ++--
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c         |  46 ++-
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h         |   8 +-
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c        |  54 +++-
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c    |  90 ++++--
>  drivers/gpu/drm/sun4i/sun8i_mixer.c           |  24 ++
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.c        | 300 ++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.h        |  40 +++
>  include/drm/drm_of.h                          |   8 +
>  include/dt-bindings/clock/sun8i-r40-ccu.h     |   4 +
>  include/dt-bindings/clock/sun8i-tcon-top.h    |  11 +
>  19 files changed, 1100 insertions(+), 122 deletions(-)
>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_tcon_top.c
>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_tcon_top.h
>  create mode 100644 include/dt-bindings/clock/sun8i-tcon-top.h




