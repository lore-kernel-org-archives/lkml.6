Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CF1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5570C21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jc3XPI7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5570C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbeKVDuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:50:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54580 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732115AbeKVDup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:50:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so6327005wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 09:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ba68y4wLR6loGecAWkIYOUD+p3jd3X1twbGoOsozgM=;
        b=jc3XPI7nR5BAOdABwsPebLOW2uu4H7ZrrlIcjv71CL0b3S8ZdTK4MxVHymEH7b3tnW
         4s2wO0b77bAKlmLM74lRm+rCbwOqsRUZ4gS6ukWFcaye//bLnMA6zrbK9nMAGpnhOOY9
         knuPfqCTfoA/dG9M2tM5ILkEw1O1UJ/r6hMhCFECL2P8mJ8OX/chTN6j1OySUhFoECsV
         dfSxnm03xxvvx/8qGYH+qPjtDIfxZ9AxiC8f1uP8H3BI52iL+nBzc42vLnDoJweKDpw0
         WP5L6VJbROguOrTiXIGFgHA7lyWgkX6UXxJHR3Ufhu6tjJWhSNMq4aU0ToYgy/5a+0G4
         FECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ba68y4wLR6loGecAWkIYOUD+p3jd3X1twbGoOsozgM=;
        b=h4/hwk59HAkYcYyPC4JESlTnk5eoTjphIALD5LR8VlUH4JNmIO19M9J/u1FTJru7gS
         lbjzpsc6aldx/NBCvuVJCXMW0zLeAV1jn/32Kh27LfEBGl5bx0bltFTOB36w+zW0UeFT
         HQKmfPPte+/Xde0Q3Vm7bKcQDN1Jjm4qkio/Mn+kBnTLiAN3a/M3KfKNsuuO8LwOgyHs
         2r9V9sS6YKuWI92gRf8uGJJmmGybyQeZyzB9yyIthM5Hm/lHIjPW7D8SAhUzvzz5useP
         MSRQCWAl29AdS87vp5vcSqSP6MldTcIHq33VQLX9+5Tketq1Xfx09myxDnwxqAw2zmCy
         CdWg==
X-Gm-Message-State: AGRZ1gJ+J1NPBB8tQACEWN4LECfrk9Cd7SgSOZvqloGOIC5cXiMTboEt
        Om2ZDeyTdHLgwjEGnU6m66Kfvw==
X-Google-Smtp-Source: AFSGD/WtNgiSvKut1Py/FS+efe6xkiehrZ1iDydZKhI+amFHDJcckAnX5gJKk4Bt7XsmS4CLEGtS+w==
X-Received: by 2002:a1c:307:: with SMTP id 7-v6mr6553392wmd.146.1542820528291;
        Wed, 21 Nov 2018 09:15:28 -0800 (PST)
Received: from bender.home (lfbn-nic-1-206-198.w2-15.abo.wanadoo.fr. [2.15.53.198])
        by smtp.gmail.com with ESMTPSA id 194sm2311398wmn.18.2018.11.21.09.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 09:15:27 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/meson: Fixes for drm_crtc_vblank_on/off support
Date:   Wed, 21 Nov 2018 18:15:25 +0100
Message-Id: <20181121171525.6593-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Linux 4.17, calls to drm_crtc_vblank_on/off are mandatory, and we get
a warning when ctrc is disabled :
" driver forgot to call drm_crtc_vblank_off()"

But, the vsync IRQ was not totally disabled due the transient hardware
state and specific interrupt line thus adding proper IRQ masking from
the HHI system control registers.

Finally, due to changed in the atomic_disable code path with the updated
fbdev emulation, checking the crct state with an atomic_disable call
leads to warning in further atomic_begin() with a leftover event not cleared.

To Summarize :
- Make sure that the CRTC code will call the enable/disable_vblank hooks.
- *Really* mask the Vsync IRQ
- Allways consume the state event in atomic_disable()

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_crtc.c | 6 +++++-
 drivers/gpu/drm/meson/meson_venc.c | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index d78168f979db..a300556248fe 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -107,6 +107,8 @@ static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
 			    priv->io_base + _REG(VPP_MISC));
 
 	priv->viu.osd1_enabled = true;
+
+	drm_crtc_vblank_on(crtc);
 }
 
 static void meson_crtc_atomic_disable(struct drm_crtc *crtc,
@@ -117,6 +119,8 @@ static void meson_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	DRM_DEBUG_DRIVER("\n");
 
+	drm_crtc_vblank_off(crtc);
+
 	priv->viu.osd1_enabled = false;
 	priv->viu.osd1_commit = false;
 
@@ -128,7 +132,7 @@ static void meson_crtc_atomic_disable(struct drm_crtc *crtc,
 			    VPP_VD1_PREBLEND | VPP_POSTBLEND_ENABLE, 0,
 			    priv->io_base + _REG(VPP_MISC));
 
-	if (crtc->state->event && !crtc->state->active) {
+	if (crtc->state->event) {
 		spin_lock_irq(&crtc->dev->event_lock);
 		drm_crtc_send_vblank_event(crtc, crtc->state->event);
 		spin_unlock_irq(&crtc->dev->event_lock);
diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 9be0376e0329..ab72ddda242d 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -71,6 +71,7 @@
  */
 
 /* HHI Registers */
+#define HHI_GCLK_MPEG2		0x148 /* 0x52 offset in data sheet */
 #define HHI_VDAC_CNTL0		0x2F4 /* 0xbd offset in data sheet */
 #define HHI_VDAC_CNTL1		0x2F8 /* 0xbe offset in data sheet */
 #define HHI_HDMI_PHY_CNTL0	0x3a0 /* 0xe8 offset in data sheet */
@@ -1663,10 +1664,12 @@ unsigned int meson_venci_get_field(struct meson_drm *priv)
 void meson_venc_enable_vsync(struct meson_drm *priv)
 {
 	writel_relaxed(2, priv->io_base + _REG(VENC_INTCTRL));
+	regmap_update_bits(priv->hhi, HHI_GCLK_MPEG2, BIT(25), BIT(25));
 }
 
 void meson_venc_disable_vsync(struct meson_drm *priv)
 {
+	regmap_update_bits(priv->hhi, HHI_GCLK_MPEG2, BIT(25), 0);
 	writel_relaxed(0, priv->io_base + _REG(VENC_INTCTRL));
 }
 
-- 
2.19.1

