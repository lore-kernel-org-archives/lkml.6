Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C4DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E8C206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OR9MU8uL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E8C206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503556AbeKWViJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:38:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40937 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbeKWViJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:38:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so11894884wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 02:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pdjP6CMwF8MoU202HfkVVAc9P1Ady+SUoMveJuphXes=;
        b=OR9MU8uLov0ipEnMBoNLktCKsdXQv/CJRkXuPcR136YPvI2LMaJmyvebFgDbys2sz9
         lGiQQyNM0JH1bTipi0qQ+21sfK0EbDGqBql02L8YEq1S1kX8iI41Wr/3ORe9D7maHp6g
         lvBVAoTg/EM/6MYyAOhpos5Gtb6LpTmNSyPyAX0ADy1k985WhFUvNMgjeuq8TfXghqIn
         8yz3H6aaaENOv7DnObRtu8E9JHl3uVZPVbzd6jvyuNNHivWEcjvZ345BlQC/80oz0ZYt
         D6r5HHkTOgsk9SMUShqHzgJa5gXGqZo3zc/MSS8jw5xnNnrUBM7usVpDX+FfXKPOsWti
         eHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pdjP6CMwF8MoU202HfkVVAc9P1Ady+SUoMveJuphXes=;
        b=WR7huz9KmLwt6Kq461clx9dSomnhdSEEvGC5RFJWI1oeDyAOZzgRTmDN1WT5m4JINn
         hzLNnDMmeUPgkOxQfxfjSzF7lBOhYLuuY40C9MTV6uaFgT9hiK211HGuZmiZlgE3do64
         jyGYMV9JGkoQb+9yZfj1iGV0TgBVED6ZfQOs46yF4rIZwGZ87RbGnBCA38jUjOtlXGg3
         dAEPBygaOHoUadoYSP81TZ9q+PCzO9726z1P72oL8gTDoNr9MVudNQQo6V6mLtPydwM9
         a6PqVMIgORvhUlYvPo3aIFrTFFv3miEIB3PnE45C+gGSqoyo9obKCFfTYSNFVJ3u2cJ9
         uh/w==
X-Gm-Message-State: AA+aEWa7QKORntS1xkaZi9X6DsjLwBgdEMGs+BbcZsU9hiz3VYU+mweE
        ttmaBCMYrTvYSG83dbDRh5lyqQ==
X-Google-Smtp-Source: AFSGD/WTLcbYCb68uXxftX0MoIwa6oB7uhNg1dqpMhMh/r2EkYWb6aM1jcdEKY1NZ1zr0sGxbSlwmA==
X-Received: by 2002:adf:e08c:: with SMTP id c12mr12704532wri.199.1542970460346;
        Fri, 23 Nov 2018 02:54:20 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o81sm2559776wmd.10.2018.11.23.02.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 02:54:19 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/meson: Fix an Alpha Primary Plane bug on Meson GXL/GXM SoCs
Date:   Fri, 23 Nov 2018 11:54:17 +0100
Message-Id: <20181123105417.18948-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Amlogic GXL & GXM SoCs, a bug occurs on the OSD1 primaty plane when
alpha is used where the alpha is not aligned with the pixel content.

The woraround Amlogic implemented is to reset the OSD1 plane hardware
block each time the plane is updated, solving the issue.

In the reset, we still need to save the content of 2 registers which
depends on the status of the plane, in addition to reload the scaler
conversion matrix at the same time.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_crtc.c |  6 ++++++
 drivers/gpu/drm/meson/meson_viu.c  | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/meson/meson_viu.h  |  1 +
 3 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index 75d97f1b2e8f..2f9dfb1d408f 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -200,6 +200,12 @@ void meson_crtc_irq(struct meson_drm *priv)
 
 	/* Update the OSD registers */
 	if (priv->viu.osd1_enabled && priv->viu.osd1_commit) {
+
+		/* Reset OSD1 at updates on GXL+ SoCs */
+		if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
+		    meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
+			meson_viu_reset(priv);
+
 		writel_relaxed(priv->viu.osd1_ctrl_stat,
 				priv->io_base + _REG(VIU_OSD1_CTRL_STAT));
 		writel_relaxed(priv->viu.osd1_blk0_cfg[0],
diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
index 2dffb987ec65..a41dd6cc343e 100644
--- a/drivers/gpu/drm/meson/meson_viu.c
+++ b/drivers/gpu/drm/meson/meson_viu.c
@@ -296,6 +296,33 @@ static void meson_viu_load_matrix(struct meson_drm *priv)
 				 true);
 }
 
+/* VIU OSD1 Reset as workaround for GXL+ Alpha OSD Bug */
+void meson_viu_reset(struct meson_drm *priv)
+{
+	uint32_t osd1_fifo_ctrl_stat, osd1_ctrl_stat2;
+
+	/* Save these 2 registers state */
+	osd1_fifo_ctrl_stat = readl_relaxed(
+				priv->io_base + _REG(VIU_OSD1_FIFO_CTRL_STAT));
+	osd1_ctrl_stat2 = readl_relaxed(
+				priv->io_base + _REG(VIU_OSD1_CTRL_STAT2));
+
+	/* Reset OSD1 */
+	writel_bits_relaxed(BIT(0), BIT(0),
+			    priv->io_base + _REG(VIU_SW_RESET));
+	writel_bits_relaxed(BIT(0), 0,
+			    priv->io_base + _REG(VIU_SW_RESET));
+
+	/* Rewrite these registers state lost in the reset */
+	writel_relaxed(osd1_fifo_ctrl_stat,
+		       priv->io_base + _REG(VIU_OSD1_FIFO_CTRL_STAT));
+	writel_relaxed(osd1_ctrl_stat2,
+		       priv->io_base + _REG(VIU_OSD1_CTRL_STAT2));
+
+	/* Reload the conversion matrix */
+	meson_viu_load_matrix(priv);
+}
+
 void meson_viu_init(struct meson_drm *priv)
 {
 	uint32_t reg;
diff --git a/drivers/gpu/drm/meson/meson_viu.h b/drivers/gpu/drm/meson/meson_viu.h
index 073b1910bd1b..e4a6e2fba8fb 100644
--- a/drivers/gpu/drm/meson/meson_viu.h
+++ b/drivers/gpu/drm/meson/meson_viu.h
@@ -59,6 +59,7 @@
 #define OSD_REPLACE_EN		BIT(14)
 #define OSD_REPLACE_SHIFT	6
 
+void meson_viu_reset(struct meson_drm *priv);
 void meson_viu_init(struct meson_drm *priv);
 
 #endif /* __MESON_VIU_H */
-- 
2.19.1

