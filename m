Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB155C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32CD21783
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfAIK7p convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:59:45 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:43478 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729752AbfAIK7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:59:45 -0500
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id B3/D1-19000-D14D53C5; Wed, 09 Jan 2019 10:59:41 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRWlGSWpSXmKPExsVy8+3OTbqyV0x
  jDF6dVbRYcvEqu0X7u2XsFpd3zWGzOLb6CpsDi8e8NdUe0+f9ZPL4vEkugDmKNTMvKb8igTWj
  /dcd1oJdAhW/V7QyNzA+4+1i5OIQEpjFKLFx8X2WLkZODjYBGYnfz2+yg9giAtYSnVMnMYLYz
  AIREhdfbgarERZwlTgyfRcjRI2XRPufR1C2nsSylg6mLkYODhYBFYkNsxVBwrwCzhItjw6AjW
  QUEJP4fmoNE8RIcYlbT+aD2RICAhJL9pxnhrBFJV4+/scKMkZCQEFidZsCRNhQYtW0AywQtrT
  Em551bBC2qcThm4dZIEbqSdyYOoUNwtaWWLbwNTPECYISJ2c+YZnAKDILyeZZSFpmIWmZhaRl
  ASPLKkbLpKLM9IyS3MTMHF1DAwNdQ0NjXTMgaaaXWKWbpJdaqpucmldSlAiU1UssL9YrrsxNz
  knRy0st2cQIjLGUQraSHYyLlqcfYpTkYFIS5U3ZZxojxJeUn1KZkVicEV9UmpNafIhRhoNDSY
  J34WWgnGBRanpqRVpmDjDaYdISHDxKIrz3LgGleYsLEnOLM9MhUqcYFaXEeX+AJARAEhmleXB
  tsARziVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5IwbzvIFJ7MvBK46a+AFjMBLT7EaAKyuCQR
  ISXVwJj9fdsv2yNZSp9FpER+fw1/8mNtdOzX2/JTUrfVZDdMZ90qEto9SVVUS1fiof1SuxX3W
  2YuvhlxtqlhQ/48bw3+x19yD317c/Ykh/+Vo0rv9KV1w7z254p5Pcw7mrysVaPMqHtq5bqN83
  d+ZtK9rXJhcqrq0Sk/t85gbX9U5nyvStHN9Ino1adKLMUZiYZazEXFiQAN812nKwMAAA==
X-Env-Sender: Oliver.Rohe@wago.com
X-Msg-Ref: server-8.tower-246.messagelabs.com!1547031581!82250!1
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8093 invoked from network); 9 Jan 2019 10:59:41 -0000
Received: from unknown (HELO SVEX01005.wago.local) (217.237.185.178)
  by server-8.tower-246.messagelabs.com with AES128-SHA encrypted SMTP; 9 Jan 2019 10:59:41 -0000
Received: from SVEX01006.wago.local ([10.1.101.122]) by SVEX01005.wago.local
 ([169.254.1.23]) with mapi id 14.03.0415.000; Wed, 9 Jan 2019 11:59:40 +0100
From:   <Oliver.Rohe@wago.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Oliver.Rohe@wago.com>
Subject: [PATCH] rtc: rs5c372: r2221: fix to use the correct XSTP bit
Thread-Topic: [PATCH] rtc: rs5c372: r2221: fix to use the correct XSTP bit
Thread-Index: AQHUqAprCBGfFZN+P06IC9NgtvqzIg==
Date:   Wed, 9 Jan 2019 10:59:40 +0000
Message-ID: <1547031572-7097-1-git-send-email-oliver.rohe@wago.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.101.133]
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean
x-pp-proceessed: 8707ce24-8c4e-4a04-80f2-2a31f9152b06
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ricoh chips have slightly different register layouts
and the r2221 chip uses bit 5 as the oscillator halt sensor bit.

Signed-off-by: Olive Rohe <oliver.rohe@wago.com>
---
 drivers/rtc/rtc-rs5c372.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index c503832..ff35dce 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -52,8 +52,8 @@
 #	define RS5C_CTRL1_CT4		(4 << 0)	/* 1 Hz level irq */
 #define RS5C_REG_CTRL2		15
 #	define RS5C372_CTRL2_24		(1 << 5)
-#	define R2025_CTRL2_XST		(1 << 5)
-#	define RS5C_CTRL2_XSTP		(1 << 4)	/* only if !R2025S/D */
+#	define R2x2x_CTRL2_XSTP		(1 << 5)	/* only if R2x2x */
+#	define RS5C_CTRL2_XSTP		(1 << 4)	/* only if !R2x2x */
 #	define RS5C_CTRL2_CTFG		(1 << 2)
 #	define RS5C_CTRL2_AAFG		(1 << 1)	/* or WAFG */
 #	define RS5C_CTRL2_BAFG		(1 << 0)	/* or DAFG */
@@ -519,20 +519,30 @@ static int rs5c_oscillator_setup(struct rs5c372 *rs5c372)
 	unsigned char buf[2];
 	int addr, i, ret = 0;
 
-	if (rs5c372->type == rtc_r2025sd) {
-		if (rs5c372->regs[RS5C_REG_CTRL2] & R2025_CTRL2_XST)
+	addr   = RS5C_ADDR(RS5C_REG_CTRL1);
+	buf[0] = rs5c372->regs[RS5C_REG_CTRL1];
+	buf[1] = rs5c372->regs[RS5C_REG_CTRL2];
+
+	/* handle xstp bit */
+	switch (rs5c372->type) {
+	case rtc_r2025sd:
+		if (buf[1] & R2x2x_CTRL2_XSTP)
 			return ret;
-		rs5c372->regs[RS5C_REG_CTRL2] |= R2025_CTRL2_XST;
-	} else {
-		if (!(rs5c372->regs[RS5C_REG_CTRL2] & RS5C_CTRL2_XSTP))
+		rs5c372->regs[RS5C_REG_CTRL2] |= R2x2x_CTRL2_XSTP;
+		break;
+	case rtc_r2221tl:
+		if (!(buf[1] & R2x2x_CTRL2_XSTP))
+			return ret;
+		rs5c372->regs[RS5C_REG_CTRL2] &= ~R2x2x_CTRL2_XSTP;
+		break;
+
+	default:
+		if (!(buf[1] & RS5C_CTRL2_XSTP))
 			return ret;
 		rs5c372->regs[RS5C_REG_CTRL2] &= ~RS5C_CTRL2_XSTP;
+		break;
 	}
 
-	addr   = RS5C_ADDR(RS5C_REG_CTRL1);
-	buf[0] = rs5c372->regs[RS5C_REG_CTRL1];
-	buf[1] = rs5c372->regs[RS5C_REG_CTRL2];
-
 	/* use 24hr mode */
 	switch (rs5c372->type) {
 	case rtc_rs5c372a:
-- 
2.7.4
