Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB36ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306BD2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306BD2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=skidata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeJRAAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:00:39 -0400
Received: from mail1.skidata.com ([91.230.2.99]:30634 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbeJRAAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:00:38 -0400
X-IronPort-AV: E=Sophos;i="5.54,393,1534802400"; 
   d="scan'208";a="12919620"
From:   Richard Leitner <richard.leitner@skidata.com>
To:     <dmitry.torokhov@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v2 8/8] Input: sx8654 - convert #defined flags to BIT(x)
Date:   Wed, 17 Oct 2018 14:51:16 +0200
Message-ID: <20181017125116.20077-9-richard.leitner@skidata.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181017125116.20077-1-richard.leitner@skidata.com>
References: <20181017125116.20077-1-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex5srv.skidata.net (192.168.111.83) To
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

