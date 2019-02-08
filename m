Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A17C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858A0217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfBHNUu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:20:50 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.132]:22118 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726585AbfBHNUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:20:50 -0500
Received: from [46.226.53.50] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-c.eu-west-1.aws.symcld.net id 80/95-07510-D228D5C5; Fri, 08 Feb 2019 13:20:45 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRWlGSWpSXmKPExsVy8+3OTbq6TbE
  xBmcOaFssuXiV3aL93TJ2i8u75rBZHFt9hc2BxWPemmqP6fN+Mnl83iQXwBzFmpmXlF+RwJqx
  9Ox2loK1ChVNLV+YGxhfSXUxcnEICTxllDiy5ycbhPOTUeL71OOsEM4sRolLl24ydTFycrAJy
  Ej8fn6THcQWEVCWOHi4hQ3EZhYokDj6dDdYjbBAjMTjM7+YIGoSJa5P3w9UzwFk60mcW68GEm
  YRUJHYeK4JrIRXwFli0uWtYGMYBcQkvp9awwQxUlzi1pP5YLaEgIDEkj3nmSFsUYmXj/+xgoy
  UEFCQaGoSgggbSqyadoAFwpaWeNOzjg3CNpU4fPMwC8RIPYkbU6dAXawtsWzha2aIEwQlTs58
  AlYjJKAosfTmOqi1mhINy7ZB2fYS099fhTrBRuLQ31a4+a9+TGaawCg9C8nVs5Csm4Vk3Swk6
  xYwsqxiNEsqykzPKMlNzMzRNTQw0DU0NNI1MjDUNdZLrNJN1kst1S1PLS7RNdRLLC/WK67MTc
  5J0ctLLdnECEwEKQUnmXcwPluRfohRkoNJSZRXrTg2RogvKT+lMiOxOCO+qDQntfgQowwHh5I
  E77QGoJxgUWp6akVaZg4wJcGkJTh4lER4b4KkeYsLEnOLM9MhUqcYFaXEeZfUAyUEQBIZpXlw
  bbA0eIlRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMO9GkPE8mXklcNNfAS1mAlmsFQOyuCQRI
  SXVwJij8vJm/BuX3sfev3+trFmhXdPAIV5kwbHHMH+9O+PkKa7sP+47/5r+SyB6x1TbFzrXDR
  WWb2Z+5uHKOG3TdMbIaokfbcuXdWzazd/66OCuM92hL78afTOVmrXHs2uafVF16JnoONXSlzc
  W8kRFSzo8sXG/dujP7bSXNTPfTlyUlud49FXQPWklluKMREMt5qLiRAD10fEefgMAAA==
X-Env-Sender: Oliver.Rohe@wago.com
X-Msg-Ref: server-25.tower-302.messagelabs.com!1549632045!1430767!1
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21757 invoked from network); 8 Feb 2019 13:20:45 -0000
Received: from unknown (HELO mail.wago.com) (217.237.185.178)
  by server-25.tower-302.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 8 Feb 2019 13:20:45 -0000
Received: from SVEX01011.wago.local (10.1.103.229) by SVEX01009.wago.local
 (10.1.103.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Fri, 8 Feb 2019
 14:20:45 +0100
Received: from SVEX01005.wago.local (10.1.101.121) by SVEX01011.wago.local
 (10.1.103.229) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1531.3 via Frontend
 Transport; Fri, 8 Feb 2019 14:20:45 +0100
Received: from SVEX01006.wago.local ([10.1.101.122]) by SVEX01005.wago.local
 ([169.254.1.23]) with mapi id 14.03.0415.000; Fri, 8 Feb 2019 14:20:44 +0100
From:   <Oliver.Rohe@wago.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <a.zummo@towertech.it>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Oliver.Rohe@wago.com>
Subject: [PATCH v2] rtc: rs5c372: Fix reading from rtc when the oscillator
 got interrupted.
Thread-Topic: [PATCH v2] rtc: rs5c372: Fix reading from rtc when the
 oscillator got interrupted.
Thread-Index: AQHUv7EYL4syJ08/n0KkXYUo5Vbq4g==
Date:   Fri, 8 Feb 2019 13:20:44 +0000
Message-ID: <1549632034-9195-1-git-send-email-oliver.rohe@wago.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.103.232]
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean
x-pp-proceessed: 8707ce24-8c4e-4a04-80f2-2a31f9152b06
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: SVEX01009.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: 81a9f692-418a-4f33-bb70-032f75efc73b
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the oscillator of the rtc gets interrupted,
e.g. due to an empty battery, reading from the rtc will now return an error
and the oscillator bit will be cleared, once the rtc is successfully reset.

Signed-off-by: Oliver Rohe <oliver.rohe@wago.com>
---
 drivers/rtc/rtc-rs5c372.c | 54 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index 2ad5976..66a473a 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -52,8 +52,10 @@
 #	define RS5C_CTRL1_CT4		(4 << 0)	/* 1 Hz level irq */
 #define RS5C_REG_CTRL2		15
 #	define RS5C372_CTRL2_24		(1 << 5)
-#	define RS5C_CTRL2_XSTP          (1 << 4)        /* only if !R2x2x */
+#	define RS5C_CTRL2_XSTP		(1 << 4)	/* only if !R2x2x */
+#	define R2x2x_CTRL2_VDET		(1 << 6)	/* only if  R2x2x */
 #	define R2x2x_CTRL2_XSTP		(1 << 5)	/* only if  R2x2x */
+#	define R2x2x_CTRL2_PON		(1 << 4)	/* only if  R2x2x */
 #	define RS5C_CTRL2_CTFG		(1 << 2)
 #	define RS5C_CTRL2_AAFG		(1 << 1)	/* or WAFG */
 #	define RS5C_CTRL2_BAFG		(1 << 0)	/* or DAFG */
@@ -212,10 +214,27 @@ static int rs5c372_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct rs5c372	*rs5c = i2c_get_clientdata(client);
 	int		status = rs5c_get_regs(rs5c);
+	unsigned char ctrl2 = rs5c->regs[RS5C_REG_CTRL2];
 
 	if (status < 0)
 		return status;
 
+	switch (rs5c->type) {
+	case rtc_r2025sd:
+	case rtc_r2221tl:
+		if ((rs5c->type == rtc_r2025sd && !(ctrl2 & R2x2x_CTRL2_XSTP)) ||
+		    (rs5c->type == rtc_r2221tl &&  (ctrl2 & R2x2x_CTRL2_XSTP))) {
+			dev_warn(&client->dev, "rtc oscillator interruption detected. Please reset the rtc clock.\n");
+			return -EINVAL;
+		}
+		break;
+	default:
+		if (ctrl2 & RS5C_CTRL2_XSTP) {
+			dev_warn(&client->dev, "rtc oscillator interruption detected. Please reset the rtc clock.\n");
+			return -EINVAL;
+		}
+	}
+
 	tm->tm_sec = bcd2bin(rs5c->regs[RS5C372_REG_SECS] & 0x7f);
 	tm->tm_min = bcd2bin(rs5c->regs[RS5C372_REG_MINS] & 0x7f);
 	tm->tm_hour = rs5c_reg2hr(rs5c, rs5c->regs[RS5C372_REG_HOURS]);
@@ -243,6 +262,7 @@ static int rs5c372_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct rs5c372	*rs5c = i2c_get_clientdata(client);
 	unsigned char	buf[7];
+	unsigned char	ctrl2;
 	int		addr;
 
 	dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d "
@@ -261,7 +281,32 @@ static int rs5c372_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	buf[6] = bin2bcd(tm->tm_year - 100);
 
 	if (i2c_smbus_write_i2c_block_data(client, addr, sizeof(buf), buf) < 0) {
-		dev_err(&client->dev, "%s: write error\n", __func__);
+		dev_dbg(&client->dev, "%s: write error in line %i\n",
+			__func__, __LINE__);
+		return -EIO;
+	}
+
+	addr = RS5C_ADDR(RS5C_REG_CTRL2);
+	ctrl2 = i2c_smbus_read_byte_data(client, addr);
+
+	/* clear rtc warning bits */
+	switch (rs5c->type) {
+	case rtc_r2025sd:
+	case rtc_r2221tl:
+		ctrl2 &= ~(R2x2x_CTRL2_VDET | R2x2x_CTRL2_PON);
+		if (rs5c->type == rtc_r2025sd)
+			ctrl2 |= R2x2x_CTRL2_XSTP;
+		else
+			ctrl2 &= ~R2x2x_CTRL2_XSTP;
+		break;
+	default:
+		ctrl2 &= ~RS5C_CTRL2_XSTP;
+		break;
+	}
+
+	if (i2c_smbus_write_byte_data(client, addr, ctrl2) < 0) {
+		dev_dbg(&client->dev, "%s: write error in line %i\n",
+			__func__, __LINE__);
 		return -EIO;
 	}
 
@@ -523,23 +568,18 @@ static int rs5c_oscillator_setup(struct rs5c372 *rs5c372)
 	buf[0] = rs5c372->regs[RS5C_REG_CTRL1];
 	buf[1] = rs5c372->regs[RS5C_REG_CTRL2];
 
-	/* handle xstp bit */
 	switch (rs5c372->type) {
 	case rtc_r2025sd:
 		if (buf[1] & R2x2x_CTRL2_XSTP)
 			return ret;
-		rs5c372->regs[RS5C_REG_CTRL2] |= R2x2x_CTRL2_XSTP;
 		break;
 	case rtc_r2221tl:
 		if (!(buf[1] & R2x2x_CTRL2_XSTP))
 			return ret;
-		rs5c372->regs[RS5C_REG_CTRL2] &= ~R2x2x_CTRL2_XSTP;
 		break;
-
 	default:
 		if (!(buf[1] & RS5C_CTRL2_XSTP))
 			return ret;
-		rs5c372->regs[RS5C_REG_CTRL2] &= ~RS5C_CTRL2_XSTP;
 		break;
 	}
 
-- 
2.7.4
