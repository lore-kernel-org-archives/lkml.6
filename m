Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B795AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D1720869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D1720869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeIGJHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 05:07:43 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:39958 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbeIGJHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 05:07:42 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id BB73A5FD0F; Fri,  7 Sep 2018 12:19:50 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Jonathan Liu <net147@gmail.com>
Subject: [PATCH v2 2/6] drm/sun4i: tcon: Rename Dithering related register macros
Date:   Fri,  7 Sep 2018 12:19:44 +0800
Message-Id: <20180907041948.19913-3-wens@csie.org>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <20180907041948.19913-1-wens@csie.org>
References: <20180907041948.19913-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dithering is only supported for TCON channel 0. Throughout the datasheet
all the names associated with these register are prefixed "TCON0",
instead of "TCON". The only exception is the control register
"TCON_FRM_CTL_REG".

Rename the macros to reflect this.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index f6a071cd5a6f..3d492c8be1fc 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -37,18 +37,21 @@
 #define SUN4I_TCON_GINT1_REG			0x8
 
 #define SUN4I_TCON_FRM_CTL_REG			0x10
-#define SUN4I_TCON_FRM_CTL_EN				BIT(31)
-
-#define SUN4I_TCON_FRM_SEED_PR_REG		0x14
-#define SUN4I_TCON_FRM_SEED_PG_REG		0x18
-#define SUN4I_TCON_FRM_SEED_PB_REG		0x1c
-#define SUN4I_TCON_FRM_SEED_LR_REG		0x20
-#define SUN4I_TCON_FRM_SEED_LG_REG		0x24
-#define SUN4I_TCON_FRM_SEED_LB_REG		0x28
-#define SUN4I_TCON_FRM_TBL0_REG			0x2c
-#define SUN4I_TCON_FRM_TBL1_REG			0x30
-#define SUN4I_TCON_FRM_TBL2_REG			0x34
-#define SUN4I_TCON_FRM_TBL3_REG			0x38
+#define SUN4I_TCON0_FRM_CTL_EN				BIT(31)
+#define SUN4I_TCON0_FRM_CTL_MODE_R			BIT(6)
+#define SUN4I_TCON0_FRM_CTL_MODE_G			BIT(5)
+#define SUN4I_TCON0_FRM_CTL_MODE_B			BIT(4)
+
+#define SUN4I_TCON0_FRM_SEED_PR_REG		0x14
+#define SUN4I_TCON0_FRM_SEED_PG_REG		0x18
+#define SUN4I_TCON0_FRM_SEED_PB_REG		0x1c
+#define SUN4I_TCON0_FRM_SEED_LR_REG		0x20
+#define SUN4I_TCON0_FRM_SEED_LG_REG		0x24
+#define SUN4I_TCON0_FRM_SEED_LB_REG		0x28
+#define SUN4I_TCON0_FRM_TBL0_REG		0x2c
+#define SUN4I_TCON0_FRM_TBL1_REG		0x30
+#define SUN4I_TCON0_FRM_TBL2_REG		0x34
+#define SUN4I_TCON0_FRM_TBL3_REG		0x38
 
 #define SUN4I_TCON0_CTL_REG			0x40
 #define SUN4I_TCON0_CTL_TCON_ENABLE			BIT(31)
-- 
2.19.0.rc1

