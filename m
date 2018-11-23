Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB111C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A793220685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BnPoblrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A793220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504583AbeKXAqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:46:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42328 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388620AbeKXAqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:46:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so12434418wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 06:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SBmppH38OVH2AL+qLX8VZBR0Ght2UdBHG/b/H8EkRfM=;
        b=BnPoblrGfpAXeSB2c2q4cjk/S2H1XYxx5zQL7Vh7IaqWVTktA2QENvl+cgGaQgTnbb
         es1bb+slgwbzOQ2FdALttu6Vx8PMLZe31pogbtCwPpVnyfeKoaRaLpwWDUrsjtLH/Lka
         yKhpBMZRj+VRkbJtpjHaGOlRqGfg6K1cRfPieEFp+Hw8qvGAqebiz8Qj2ia9Rw1Pj2ov
         h9jxJniVVW2GDYgU7uznJ9eFuZzP/CYUpgFmowfPu8TapJWk8Dep831pnOemwNLebHoW
         wIEzf94sY68d24Hxe7wTxe4SABgXvTIJpCvLz9vsZvkjMi+4Kxvq/zbv3uweRq5CUbLj
         yCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SBmppH38OVH2AL+qLX8VZBR0Ght2UdBHG/b/H8EkRfM=;
        b=b0DAOh0Cq39JlTqY6LCfQmYgQU1yNh4L15sSAZ/AD8O4fsUSUhcMSdIfbif/sGYQ2S
         WCnvs3QmmSj/PqokxJ6B3D1wfg7Hju0fOzftJ2tUHnSyOZD60PZKqGkT92nOKo6TjkOK
         Iz8ueZxOidXDWkR0zc3el5D0TUrtocQSL8aefy7fzp0SutIey9wzrT5Vz3W2S0XbiaG1
         5OMX66Hj+xu1ZoceljxZTcmVZODs5dZ9WZQb2SZocq0IeqmidqGGJ9BNQHMjGd5FO0kJ
         jSeJGLSsBUNOKwdv5MWHenVphdFbGXwCalYq9A5Ha74VnDp3gc8C6y0tX7k8s0fa6Xks
         txnA==
X-Gm-Message-State: AA+aEWZElqgR6HZNXcSrpM6yVJdQaGFXK3JTLttpSw/Wl3aYX11XaA4V
        /Ud9s46vFEUYnKSvWO4zVjLOcQ==
X-Google-Smtp-Source: AFSGD/U4R3XMB1oc9qfv9KSLaghIF6UEifTHEO3CbXSLR+Gs5Yc9Jvx6KHYozzaDr0trSRarI9Md6w==
X-Received: by 2002:a5d:4e4a:: with SMTP id r10mr4538476wrt.54.1542981744788;
        Fri, 23 Nov 2018 06:02:24 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x8sm15172185wrd.53.2018.11.23.06.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 06:02:23 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/8] drm/meson: Add support for HDMI2.0 4k60
Date:   Fri, 23 Nov 2018 15:02:13 +0100
Message-Id: <20181123140221.15700-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.1
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

The second mode is implemented by added the missing 4:2:0 bypass handling
in the dw-hdmi bridge driver and adding a "mtmdsclock" separating the
pixel clock from the tmds clock in the mode setup phase.
We also enable support for these modes in the connector only if the platform
glue code explicits the support.

The remaining patches adds support for :
- 1/40 TMDS rate aka DIV40 in the dw-hdmi meson PHY setup
- 4:2:0 output and clock setup

The dw-hdmi support re-uses the support done by Rockchip engineers on the
Linux 4.4 BSP kernel.

These modes has been validated using a MuxLab HDMI Signal Analyser in
addition to different UHD TVs supporting full 4k60 or the 4:2:0 variant.

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

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 136 ++++++++++++++++++----
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |   1 +
 drivers/gpu/drm/meson/meson_dw_hdmi.c     | 129 +++++++++++++++++---
 drivers/gpu/drm/meson/meson_vclk.c        |  95 +++++++++++----
 drivers/gpu/drm/meson/meson_vclk.h        |   7 +-
 drivers/gpu/drm/meson/meson_venc.c        |   8 +-
 drivers/gpu/drm/meson/meson_venc.h        |  11 ++
 drivers/gpu/drm/meson/meson_venc_cvbs.c   |   3 +-
 include/drm/bridge/dw_hdmi.h              |   7 ++
 9 files changed, 330 insertions(+), 67 deletions(-)

-- 
2.19.1

