Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8362EECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494F620673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494F620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shmanahar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbeGTWmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:42:06 -0400
Received: from avasout06.plus.net ([212.159.14.18]:48149 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbeGTWmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:42:06 -0400
Received: from hairyalien ([80.229.148.18])
        by smtp with SMTP
        id gdJZfIgNaWLW2gdJaf5XED; Fri, 20 Jul 2018 22:51:56 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=R9QF1RCXAYgA:10 a=V0UhwjhiAAAA:8 a=h_4YBhKAYfZ9fmwmONsA:9
 a=gDZd9UoHjypZimEJ:21 a=gnZDA-50njveXPI5:21 a=_UVLBGXn8Au_dgoMdIS7:22
Received: by hairyalien (sSMTP sendmail emulation); Fri, 20 Jul 2018 22:51:53 +0100
From:   Nick Dyer <nick@shmanahar.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH v1 02/10] Input: atmel_mxt_ts - use BIT() macro everywhere
Date:   Fri, 20 Jul 2018 22:51:14 +0100
Message-Id: <20180720215122.23558-2-nick@shmanahar.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720215122.23558-1-nick@shmanahar.org>
References: <20180720215122.23558-1-nick@shmanahar.org>
X-CMAE-Envelope: MS4wfBpuZjpeo88Un45Dv84DyKvnqi26pi7D/xx13cw36s3Jz4ycIfGE5FJlF+JmKNQTCZ86UYRvp9oHdlyLhQVv4hRq9iA2yU52m1gYBWliLLP6AMNoEAEQ
 s7JM72Xo5kh35looapeqSvJImC8i6b8TtHUBuFzCK8YVnNGWeqjQ2uHF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 36 ++++++++++++------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 48c5ccab00a0..9555947a2d46 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -88,12 +88,12 @@
 #define MXT_COMMAND_DIAGNOSTIC	5
 
 /* Define for T6 status byte */
-#define MXT_T6_STATUS_RESET	(1 << 7)
-#define MXT_T6_STATUS_OFL	(1 << 6)
-#define MXT_T6_STATUS_SIGERR	(1 << 5)
-#define MXT_T6_STATUS_CAL	(1 << 4)
-#define MXT_T6_STATUS_CFGERR	(1 << 3)
-#define MXT_T6_STATUS_COMSERR	(1 << 2)
+#define MXT_T6_STATUS_RESET	BIT(7)
+#define MXT_T6_STATUS_OFL	BIT(6)
+#define MXT_T6_STATUS_SIGERR	BIT(5)
+#define MXT_T6_STATUS_CAL	BIT(4)
+#define MXT_T6_STATUS_CFGERR	BIT(3)
+#define MXT_T6_STATUS_COMSERR	BIT(2)
 
 /* MXT_GEN_POWER_T7 field */
 struct t7_config {
@@ -112,14 +112,14 @@ struct t7_config {
 #define MXT_T9_RANGE		18
 
 /* MXT_TOUCH_MULTI_T9 status */
-#define MXT_T9_UNGRIP		(1 << 0)
-#define MXT_T9_SUPPRESS		(1 << 1)
-#define MXT_T9_AMP		(1 << 2)
-#define MXT_T9_VECTOR		(1 << 3)
-#define MXT_T9_MOVE		(1 << 4)
-#define MXT_T9_RELEASE		(1 << 5)
-#define MXT_T9_PRESS		(1 << 6)
-#define MXT_T9_DETECT		(1 << 7)
+#define MXT_T9_UNGRIP		BIT(0)
+#define MXT_T9_SUPPRESS		BIT(1)
+#define MXT_T9_AMP		BIT(2)
+#define MXT_T9_VECTOR		BIT(3)
+#define MXT_T9_MOVE		BIT(4)
+#define MXT_T9_RELEASE		BIT(5)
+#define MXT_T9_PRESS		BIT(6)
+#define MXT_T9_DETECT		BIT(7)
 
 struct t9_range {
 	__le16 x;
@@ -127,9 +127,9 @@ struct t9_range {
 } __packed;
 
 /* MXT_TOUCH_MULTI_T9 orient */
-#define MXT_T9_ORIENT_SWITCH	(1 << 0)
-#define MXT_T9_ORIENT_INVERTX	(1 << 1)
-#define MXT_T9_ORIENT_INVERTY	(1 << 2)
+#define MXT_T9_ORIENT_SWITCH	BIT(0)
+#define MXT_T9_ORIENT_INVERTX	BIT(1)
+#define MXT_T9_ORIENT_INVERTY	BIT(2)
 
 /* MXT_SPT_COMMSCONFIG_T18 */
 #define MXT_COMMS_CTRL		0
@@ -214,7 +214,7 @@ enum t100_type {
 #define MXT_FRAME_CRC_PASS	0x04
 #define MXT_APP_CRC_FAIL	0x40	/* valid 7 8 bit only */
 #define MXT_BOOT_STATUS_MASK	0x3f
-#define MXT_BOOT_EXTENDED_ID	(1 << 5)
+#define MXT_BOOT_EXTENDED_ID	BIT(5)
 #define MXT_BOOT_ID_MASK	0x1f
 
 /* Touchscreen absolute values */
-- 
2.17.1

