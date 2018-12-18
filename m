Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900ADC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D58217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbeLRIkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:40:09 -0500
Received: from mail1.skidata.com ([91.230.2.99]:20838 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbeLRIkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:40:09 -0500
X-IronPort-AV: E=Sophos;i="5.56,367,1539640800"; 
   d="scan'208";a="14044705"
From:   Richard Leitner <richard.leitner@skidata.com>
To:     <dmitry.torokhov@gmail.com>, <mark.rutland@arm.com>
CC:     <robh+dt@kernel.org>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <richard.leitner@skidata.com>
Subject: [RESEND PATCH v2 8/8] Input: sx8654 - convert #defined flags to BIT(x)
Date:   Tue, 18 Dec 2018 09:40:02 +0100
Message-ID: <20181218084002.19454-1-richard.leitner@skidata.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181218083606.25795-1-richard.leitner@skidata.com>
References: <20181218083606.25795-1-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex3srv.skidata.net (192.168.111.81) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the #defined register values are one-bit flags. Convert them to
use the BIT(x) macro instead of 1 byte hexadecimal values. This improves
readability and clarifies the intent.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/input/touchscreen/sx8654.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index b7b263ed52af..3746ea855f94 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -36,6 +36,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/input/touchscreen.h>
+#include <linux/bitops.h>
 
 /* register addresses */
 #define I2C_REG_TOUCH0			0x00
@@ -46,7 +47,7 @@
 #define I2C_REG_SOFTRESET		0x3f
 
 #define I2C_REG_SX8650_STAT		0x05
-#define SX8650_STAT_CONVIRQ		0x80
+#define SX8650_STAT_CONVIRQ		BIT(7)
 
 /* commands */
 #define CMD_READ_REGISTER		0x40
@@ -56,8 +57,8 @@
 #define SOFTRESET_VALUE			0xde
 
 /* bits for I2C_REG_IRQSRC */
-#define IRQ_PENTOUCH_TOUCHCONVDONE	0x08
-#define IRQ_PENRELEASE			0x04
+#define IRQ_PENTOUCH_TOUCHCONVDONE	BIT(7)
+#define IRQ_PENRELEASE			BIT(6)
 
 /* bits for RegTouch1 */
 #define CONDIRQ				0x20
@@ -65,8 +66,8 @@
 #define FILT_7SA			0x03
 
 /* bits for I2C_REG_CHANMASK */
-#define CONV_X				0x80
-#define CONV_Y				0x40
+#define CONV_X				BIT(7)
+#define CONV_Y				BIT(6)
 
 /* coordinates rate: higher nibble of CTRL0 register */
 #define RATE_MANUAL			0x00
-- 
2.11.0

