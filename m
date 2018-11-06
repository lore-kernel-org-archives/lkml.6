Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8B2C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D2420869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pmL2zpVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D2420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbeKFS7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:59:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40057 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbeKFS7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:59:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id b203-v6so10852864wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 01:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=KDqEXZM3w+csIzjnxMmBHNHjfzIeqE3gI4KtCaOk0j0=;
        b=pmL2zpVSBnifTkFiTyK0yKRJgTnXFpjBNNd9GuNRtJnRm/Ch+WKVL0MjkqavlwRsdG
         JQtF+IRmfG52hD/yF+1JFgVXZPHLIIzZXe9HlpZbT6tAk8AQOYWSXu/ZneeSwV/rVPww
         kr38RvhQ2soCdEye1zDgCz8wEm6M5hAVTQgfjjsIlFQ9DbDqbRrWWIbMV0LciLdpUV3W
         hTCXIiF7C8xcjwDXPI0Cn8/aVMQhacKX2qNxphvEfj4trnFhV74qpfRT5A1MIfm6XBPz
         eZw3edX6O2EqM0CAoTN77k7s8cnJhfB0RGRcVVcsGkjECjB9oTNlEs0zgip0nKTi5Ufo
         /H4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KDqEXZM3w+csIzjnxMmBHNHjfzIeqE3gI4KtCaOk0j0=;
        b=uDf//x3y6M7kp6QwMKF/LfVhtgWVmZ2t5BEgtjKji3BFHUnhKvun8hDH23PR9PMH/z
         cFQG6fxMPp/cIsAiv9EyxhRMGxqe/nbhpSHPntCAx89RlcLRlU2ND2Tl/qC72b1uo1Np
         gRVkuaAW7DeNXSQPiJyND/PeJR19IxcEHqx6R+m1qrQnGbXrmjBPbYrjvysDB06fPRmW
         YXC38t4JDjB8Y8usPkfK8YN46/aaGqddI3KzFf8O+P1ahYzBVeaO/Yy1xwxm0nAXtsBJ
         9k+Ukzk/NeupmJbUT6yxUaCKw5aXLhz6SOZ7gYHLf3BGux2xYM1vdLsqxHQb1Hb1i0tq
         ellA==
X-Gm-Message-State: AGRZ1gJ3ezJKEsUhupXgtGc8y9LU3tICuFI24ubzz7lq1SA8RPn0zKXI
        yOpyMt6QlXRPHXuOfNLiMrYtUg==
X-Google-Smtp-Source: AJdET5fYQDCGzUdu6yYhAH94fgRAic9dgYaaAIU4Tn64F/9XiuSEdmi7PCn2tMvASakC5cCfXl0HdA==
X-Received: by 2002:a1c:ef15:: with SMTP id n21-v6mr1235921wmh.151.1541496913807;
        Tue, 06 Nov 2018 01:35:13 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i7-v6sm70402183wrb.30.2018.11.06.01.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 01:35:13 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/meson: Add HDMI 1.4 4k modes
Date:   Tue,  6 Nov 2018 10:35:09 +0100
Message-Id: <1541496909-19625-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the timings for the HDMI 1.4 4K modes support :
- 3840x2160@30
- 3840x2160@25
- 3840x2160@24

Since the 297000Hz pixel clock is already managed and the modes are
compatible with the HDMI 1.4 current HDMI PHY+Controller support, only
the missing timings values needs to be added.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_venc.c | 129 +++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 514245e..bcffe8e 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -697,6 +697,132 @@ union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080p60 = {
 	},
 };
 
+union meson_hdmi_venc_mode meson_hdmi_encp_mode_2160p24 = {
+	.encp = {
+		.dvi_settings = 0x1,
+		.video_mode = 0x4040,
+		.video_mode_adv = 0x8,
+		/* video_sync_mode */
+		/* video_yc_dly */
+		/* video_rgb_ctrl */
+		.video_filt_ctrl = 0x1000,
+		.video_filt_ctrl_present = true,
+		/* video_ofld_voav_ofst */
+		.yfp1_htime = 140,
+		.yfp2_htime = 140+3840,
+		.max_pxcnt = 3840+1660-1,
+		.hspuls_begin = 2156+1920,
+		.hspuls_end = 44,
+		.hspuls_switch = 44,
+		.vspuls_begin = 140,
+		.vspuls_end = 2059+1920,
+		.vspuls_bline = 0,
+		.vspuls_eline = 4,
+		.havon_begin = 148,
+		.havon_end = 3987,
+		.vavon_bline = 89,
+		.vavon_eline = 2248,
+		/* eqpuls_begin */
+		/* eqpuls_end */
+		/* eqpuls_bline */
+		/* eqpuls_eline */
+		.hso_begin = 44,
+		.hso_end = 2156+1920,
+		.vso_begin = 2100+1920,
+		.vso_end = 2164+1920,
+		.vso_bline = 51,
+		.vso_eline = 53,
+		.vso_eline_present = true,
+		/* sy_val */
+		/* sy2_val */
+		.max_lncnt = 2249,
+	},
+};
+
+union meson_hdmi_venc_mode meson_hdmi_encp_mode_2160p25 = {
+	.encp = {
+		.dvi_settings = 0x1,
+		.video_mode = 0x4040,
+		.video_mode_adv = 0x8,
+		/* video_sync_mode */
+		/* video_yc_dly */
+		/* video_rgb_ctrl */
+		.video_filt_ctrl = 0x1000,
+		.video_filt_ctrl_present = true,
+		/* video_ofld_voav_ofst */
+		.yfp1_htime = 140,
+		.yfp2_htime = 140+3840,
+		.max_pxcnt = 3840+1440-1,
+		.hspuls_begin = 2156+1920,
+		.hspuls_end = 44,
+		.hspuls_switch = 44,
+		.vspuls_begin = 140,
+		.vspuls_end = 2059+1920,
+		.vspuls_bline = 0,
+		.vspuls_eline = 4,
+		.havon_begin = 148,
+		.havon_end = 3987,
+		.vavon_bline = 89,
+		.vavon_eline = 2248,
+		/* eqpuls_begin */
+		/* eqpuls_end */
+		/* eqpuls_bline */
+		/* eqpuls_eline */
+		.hso_begin = 44,
+		.hso_end = 2156+1920,
+		.vso_begin = 2100+1920,
+		.vso_end = 2164+1920,
+		.vso_bline = 51,
+		.vso_eline = 53,
+		.vso_eline_present = true,
+		/* sy_val */
+		/* sy2_val */
+		.max_lncnt = 2249,
+	},
+};
+
+union meson_hdmi_venc_mode meson_hdmi_encp_mode_2160p30 = {
+	.encp = {
+		.dvi_settings = 0x1,
+		.video_mode = 0x4040,
+		.video_mode_adv = 0x8,
+		/* video_sync_mode */
+		/* video_yc_dly */
+		/* video_rgb_ctrl */
+		.video_filt_ctrl = 0x1000,
+		.video_filt_ctrl_present = true,
+		/* video_ofld_voav_ofst */
+		.yfp1_htime = 140,
+		.yfp2_htime = 140+3840,
+		.max_pxcnt = 3840+560-1,
+		.hspuls_begin = 2156+1920,
+		.hspuls_end = 44,
+		.hspuls_switch = 44,
+		.vspuls_begin = 140,
+		.vspuls_end = 2059+1920,
+		.vspuls_bline = 0,
+		.vspuls_eline = 4,
+		.havon_begin = 148,
+		.havon_end = 3987,
+		.vavon_bline = 89,
+		.vavon_eline = 2248,
+		/* eqpuls_begin */
+		/* eqpuls_end */
+		/* eqpuls_bline */
+		/* eqpuls_eline */
+		.hso_begin = 44,
+		.hso_end = 2156+1920,
+		.vso_begin = 2100+1920,
+		.vso_end = 2164+1920,
+		.vso_bline = 51,
+		.vso_eline = 53,
+		.vso_eline_present = true,
+		/* sy_val */
+		/* sy2_val */
+		.max_lncnt = 2249,
+	},
+};
+
 struct meson_hdmi_venc_vic_mode {
 	unsigned int vic;
 	union meson_hdmi_venc_mode *mode;
@@ -717,6 +843,9 @@ struct meson_hdmi_venc_vic_mode {
 	{ 34, &meson_hdmi_encp_mode_1080p30 },
 	{ 31, &meson_hdmi_encp_mode_1080p50 },
 	{ 16, &meson_hdmi_encp_mode_1080p60 },
+	{ 93, &meson_hdmi_encp_mode_2160p24 },
+	{ 94, &meson_hdmi_encp_mode_2160p25 },
+	{ 95, &meson_hdmi_encp_mode_2160p30 },
 	{ 0, NULL}, /* sentinel */
 };
 
-- 
2.7.4

