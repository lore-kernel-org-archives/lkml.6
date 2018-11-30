Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC360C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758392145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yyumK4eI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758392145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbeLAAw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:52:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40832 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbeLAAw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:52:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so5331686wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 05:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oZJV/qsmAM5gZtjG0Mt+AwQrzLC1ULCsrCDHyIkNEK0=;
        b=yyumK4eIzVxLOIl1BjBOR4aNypcEk3oAeO7W7a42QcgR+nz+Jy8H8WDgOtzMacSSr9
         bAKEJ/+GmmpSLewZpvOr1Xb5NvD2ER5mLDOG/dH8fEmKe2+fiIv9gvTfRUSjkEGz4XSI
         9YZtjIhbs5p6Nq5VhA7l+UDqgTMOEMC2HDy8+XDOJyhQ/8QBKGkImpWWPWTZe1jXDgwg
         g5jQbinkLEk+v2UBG96hFQEw5AWLaV+TTlw8FxJhr/H+U6gCBVHYZDOZPMit9gfXpPnw
         y6dV3zDMI7MIpgnT63M2BIc2DzZRCDZWvHS2SX/0MnooM6TtXXZ3+ULSkeWznoMi0EIZ
         c8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oZJV/qsmAM5gZtjG0Mt+AwQrzLC1ULCsrCDHyIkNEK0=;
        b=ILr68xZh9IS6KS4Tcmj1UgmM7nOGM6jFaqDBIPMlO0kT8f0Rl/S7qBBHn81EZyhWYc
         Iw/KEa8cFRD/2cfMI38ObeJ60jLdPHq/fn1yxauEYtRzvH0zldx+wjUcTJx+U6cHJ8eh
         QsuRGrSffVh3Lq3OejwkNHBRvM5ahsraDSvhZfvZieYpwp9AWliDnkAAL7auP18HZkeb
         y+ATlWSWGtsqeTRYsH39pZzYRJzpBBODIdlqgzLhR+f2DxKMESlHxEIF6r1akbeTevmu
         EK/eygJGPl4JVZCjpV93QknHgJ+qz+wc79wHj+IcN18JZzfz/gDP+cCrOeImjA5EgbFf
         i63A==
X-Gm-Message-State: AA+aEWY+5Fs9wfMKxZNB8Q8oi6B0i+i7S0cQW+dFS0p1gc5mUINSRkCZ
        pZ09Z+4PemItU6ZUj/MvRgVbG5u9CyPvBA==
X-Google-Smtp-Source: AFSGD/WnusZXZmSbQwaQjTPVj8I5aEuPKjTtBDATCHPVA02O75C9vDKod9nE2a8O+5QLzPvBKjKqmw==
X-Received: by 2002:adf:e608:: with SMTP id p8mr5030095wrm.166.1543585384677;
        Fri, 30 Nov 2018 05:43:04 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 125sm6864898wml.35.2018.11.30.05.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 05:43:03 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        maxime.ripard@bootlin.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 0/8] drm/meson: Add support for HDMI2.0 4k60
Date:   Fri, 30 Nov 2018 14:42:53 +0100
Message-Id: <20181130134301.17963-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset aims to add support for the following HDMI2.0 4k60 modes:
- 594Mhz TMDS frequency needing TMDS Scramling and 1/40 rate for RGB/YUV4:4:4
- 297MHz TMDS frequency with YUV4:2:0 encoding

The first mode uses the SCDC helpers introduced by intel to :
- discover where the monitor support SCDC
- setup the SCDC parameters
This is implemented in the dw-hdmi bridge driver by handling scrambling
support during the bridge setup and by exporting an helper for the PHY
setup to setup the SCDC configuration for the 1/40 TMDS rate.
This code will only be active if the encoder support a TMDS rate > 340MHz.

This patch could eventually break support on different SoC when connected
on a 4k60 monitor with SCDC :
- i.MX correctly discards pixel clocks > 216MHz
- R-CAR discards discards pixel clocks > 297MHz since [1]
- Rockchip discards invalid pixel clocks not in the rockchip_mpll_cfg table
- sun8i correctly discards pixel clocks > 297MHz on a83t
- sun8i discards discards pixel clocks > 594Mhz on h6, which is already broken

First patch should fix support for Allwinner H6.

The second mode is implemented by added the missing 4:2:0 bypass handling
in the dw-hdmi bridge driver and adding a "mtmdsclock" separating the
pixel clock from the tmds clock in the mode setup phase.
We also enable support for these modes in the connector only if the platform
glue code explicits the support.

Only the meson DRM dw_hdmi glue allows ycbcr420 modes, so no breakage
is expected here.

The remaining patches adds support for :
- 1/40 TMDS rate aka DIV40 in the dw-hdmi meson PHY setup
- 4:2:0 output and clock setup

The dw-hdmi support re-uses the support done by Rockchip engineers on the
Linux 4.4 BSP kernel.

These modes has been validated using a MuxLab HDMI Signal Analyser in
addition to different UHD TVs supporting full 4k60 or the 4:2:0 variant.

Changes since RFC v1 at [2]:
- Fix all comments from Laurent :
- Add define for HDMI 1.4 max tmds clock and SCDC supported version
- Call dw_hdmi_set_high_tmds_clock_ratio() in dw_hdmi_phy_enable_powerdown()
to unbreak Allwinner H6
- Pass in_t(u8, bytes, SCDC_MIN_SOURCE_VERSION) as SCDC version
- Finally add comments for SCDC and Scrambling process

[1] https://patchwork.freedesktop.org/patch/263616/

Neil Armstrong (7):
  drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support
  drm/meson: add HDMI div40 TMDS mode
  drm/meson: add support for HDMI2.0 2160p modes
  drm/bridge: dw-hdmi: add support for YUV420 output
  drm/bridge: dw-hdmi: allow ycbcr420 modes for >= 0x200a
  drm/meson: Add YUV420 output support
  drm/meson: Output in YUV444 if sink supports it

Zheng Yang (1):
  drm/bridge: dw-hdmi: support dynamically get input/out color info

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 182 +++++++++++++++++++---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |   1 +
 drivers/gpu/drm/meson/meson_dw_hdmi.c     | 129 ++++++++++++---
 drivers/gpu/drm/meson/meson_vclk.c        |  93 ++++++++---
 drivers/gpu/drm/meson/meson_vclk.h        |   7 +-
 drivers/gpu/drm/meson/meson_venc.c        |   8 +-
 drivers/gpu/drm/meson/meson_venc.h        |  11 ++
 drivers/gpu/drm/meson/meson_venc_cvbs.c   |   3 +-
 include/drm/bridge/dw_hdmi.h              |   7 +
 9 files changed, 375 insertions(+), 66 deletions(-)

-- 
2.19.2

