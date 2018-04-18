Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754001AbeDRNSt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:18:49 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:33888 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753766AbeDRNSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:18:09 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 2/4] mfd: bd9571mwv: Add DDR Backup Power register bit definitions
Date: Wed, 18 Apr 2018 15:18:02 +0200
Message-Id: <1524057484-25350-3-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524057484-25350-1-git-send-email-geert+renesas@glider.be>
References: <1524057484-25350-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definitions for the KEEPON_* bits in the "BKUP Mode Cnt" register,
which control the DDR rails to be kept powered when backup mode is
enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
v3:
  - No changes,

v2:
  - Add Acked-by.
---
 include/linux/mfd/bd9571mwv.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mfd/bd9571mwv.h b/include/linux/mfd/bd9571mwv.h
index f0708ba4cbbae2dc..eb05569f752bb089 100644
--- a/include/linux/mfd/bd9571mwv.h
+++ b/include/linux/mfd/bd9571mwv.h
@@ -33,6 +33,11 @@
 #define BD9571MWV_I2C_MD2_E1_BIT_2		0x12
 
 #define BD9571MWV_BKUP_MODE_CNT			0x20
+#define BD9571MWV_BKUP_MODE_CNT_KEEPON_MASK	GENMASK(3, 0)
+#define BD9571MWV_BKUP_MODE_CNT_KEEPON_DDR0	BIT(0)
+#define BD9571MWV_BKUP_MODE_CNT_KEEPON_DDR1	BIT(1)
+#define BD9571MWV_BKUP_MODE_CNT_KEEPON_DDR0C	BIT(2)
+#define BD9571MWV_BKUP_MODE_CNT_KEEPON_DDR1C	BIT(3)
 #define BD9571MWV_BKUP_MODE_STATUS		0x21
 #define BD9571MWV_BKUP_RECOVERY_CNT		0x22
 #define BD9571MWV_BKUP_CTRL_TIM_CNT		0x23
-- 
2.7.4
