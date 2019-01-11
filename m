Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D341DC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCC0214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbfAKNPo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:15:44 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.67]:6755 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731970AbfAKNPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:15:44 -0500
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id 4A/C9-01171-CF6983C5; Fri, 11 Jan 2019 13:15:40 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRWlGSWpSXmKPExsVy8+3OTbp/pln
  EGGzdJm6x5OJVdov2d8vYLS7vmsNmcWz1FTYHFo95a6o9ps/7yeTxeZNcAHMUa2ZeUn5FAmtG
  b9sUtoLDShVvdt1na2C8JNPFyMUhJDCbUWJi11HmLkZODjYBGYnfz2+yg9giAtYSb/o+s4HYz
  AIREhdfbmYBsYUFIiWWrZ4GVRMnMe3iZCYIW0/i0LdWsBoWAVWJhhmzwWxeAReJC8cegs1nFB
  CT+H5qDRPETHGJW0/mg9kSAgISS/acZ4awRSVePv7H2sXIAWQrSKxuU4AIG0qsmnaABcKWlnj
  Ts44NwjaVOHzzMAvESD2JG1OnQJ2sLbFs4WtmiBMEJU7OfMIygVFkFpLNs5C0zELSMgtJywJG
  llWMFklFmekZJbmJmTm6hgYGuoaGRrqGlma6RoZmeolVukl6qaW65anFJbqGeonlxXrFlbnJO
  Sl6eaklmxiBMZZScOTGDsYvy9MPMUpyMCmJ8v6ebBEjxJeUn1KZkVicEV9UmpNafIhRhoNDSY
  LXbSpQTrAoNT21Ii0zBxjtMGkJDh4lEV4ekDRvcUFibnFmOkTqFKOilDhvM0hCACSRUZoH1wZ
  LMJcYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfOWg0zhycwrgZv+CmgxE9Di4G/mIItLEhFS
  Ug2MIUxqoqE2qq/ZckSEf99mZjNbv/zzi8Da5EyLWTEvxCsDj8eekTy06Hp0y7rDhpuUp+pLP
  Dtybkvug5rnn1v3SK/ZHX1++4Xr1lkbQpcXrj227/vVezH/Xlp+OtZ603DdkqkL2BIm6x2Z4r
  D++w2TR9psb5wXbGf9ZW6qVJpy9dSVA0surjl3/YgSS3FGoqEWc1FxIgAG0I9zKwMAAA==
X-Env-Sender: Oliver.Rohe@wago.com
X-Msg-Ref: server-12.tower-288.messagelabs.com!1547212539!332796!1
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6526 invoked from network); 11 Jan 2019 13:15:40 -0000
Received: from unknown (HELO SVEX01005.wago.local) (217.237.185.178)
  by server-12.tower-288.messagelabs.com with AES128-SHA encrypted SMTP; 11 Jan 2019 13:15:40 -0000
Received: from SVEX01006.wago.local ([10.1.101.122]) by SVEX01005.wago.local
 ([169.254.1.23]) with mapi id 14.03.0415.000; Fri, 11 Jan 2019 14:15:39 +0100
From:   <Oliver.Rohe@wago.com>
To:     <alexandre.belloni@bootlin.com>, <a.zummo@towertech.it>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Oliver.Rohe@wago.com>
Subject: [PATCH] rtc: rs5c372: Fix reading from rtc when the oscillator got
 interrupted.
Thread-Topic: [PATCH] rtc: rs5c372: Fix reading from rtc when the oscillator
 got interrupted.
Thread-Index: AQHUqa+/rXqeQIxzX0+LFpkiw+8xxQ==
Date:   Fri, 11 Jan 2019 13:15:39 +0000
Message-ID: <1547212521-14871-1-git-send-email-oliver.rohe@wago.com>
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

When the oscillator of the rtc gets interrupted,
e.g. due to an empty battery, reading from the rtc will now return an error
and the oscillator bit will be cleared, once the rtc is successfully reset.

Signed-off-by: Oliver Rohe <oliver.rohe@wago.com>
---
 drivers/rtc/rtc-rs5c372.c | 60 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index ff35dce..91d1475 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -52,8 +52,10 @@
 #	define RS5C_CTRL1_CT4		(4 << 0)	/* 1 Hz level irq */
 #define RS5C_REG_CTRL2		15
 #	define RS5C372_CTRL2_24		(1 << 5)
-#	define R2x2x_CTRL2_XSTP		(1 << 5)	/* only if R2x2x */
-#	define RS5C_CTRL2_XSTP		(1 << 4)	/* only if !R2x2x */
+#	define RS5C_CTRL2_XSTP          (1 << 4)        /* only if !R2x2x */
+#	define R2x2x_CTRL2_VDET		(1 << 6)	/* only if  R2x2x */
+#	define R2x2x_CTRL2_XSTP		(1 << 5)	/* only if  R2x2x */
+#	define R2x2x_CTRL2_PON		(1 << 4)	/* only if  R2x2x */
 #	define RS5C_CTRL2_CTFG		(1 << 2)
 #	define RS5C_CTRL2_AAFG		(1 << 1)	/* or WAFG */
 #	define RS5C_CTRL2_BAFG		(1 << 0)	/* or DAFG */
@@ -212,10 +214,31 @@ static int rs5c372_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct rs5c372	*rs5c = i2c_get_clientdata(client);
 	int		status = rs5c_get_regs(rs5c);
+	unsigned char ctrl2 = rs5c->regs[RS5C_REG_CTRL2];
 
 	if (status < 0)
 		return status;
 
+	switch (rs5c->type) {
+	case rtc_r2025sd:
+	case rtc_r2221tl:
+		if (ctrl2 & R2x2x_CTRL2_VDET)
+			dev_warn(&client->dev, "rtc battery voltage drop below threshold detected.\n");
+		if (ctrl2 & R2x2x_CTRL2_PON)
+			dev_warn(&client->dev, "rtc battery voltage drop to zero detected.\n");
+		if ((rs5c->type == rtc_r2025sd && !(ctrl2 & R2x2x_CTRL2_XSTP)) ||
+		    (rs5c->type == rtc_r2221tl &&  (ctrl2 & R2x2x_CTRL2_XSTP))) {
+			dev_warn(&client->dev, "rtc oscillator interruption detected. Please reset the rtc clock.\n");
+			return -EIO;
+		}
+		break;
+	default:
+		if (ctrl2 & RS5C_CTRL2_XSTP) {
+			dev_warn(&client->dev, "rtc oscillator interruption detected. Please reset the rtc clock.\n");
+			return -EIO;
+		}
+	}
+
 	tm->tm_sec = bcd2bin(rs5c->regs[RS5C372_REG_SECS] & 0x7f);
 	tm->tm_min = bcd2bin(rs5c->regs[RS5C372_REG_MINS] & 0x7f);
 	tm->tm_hour = rs5c_reg2hr(rs5c, rs5c->regs[RS5C372_REG_HOURS]);
@@ -243,6 +266,7 @@ static int rs5c372_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct rs5c372	*rs5c = i2c_get_clientdata(client);
 	unsigned char	buf[7];
+	unsigned char	ctrl2;
 	int		addr;
 
 	dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d "
@@ -261,7 +285,32 @@ static int rs5c372_rtc_set_time(struct device *dev, struct rtc_time *tm)
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
 
@@ -523,23 +572,18 @@ static int rs5c_oscillator_setup(struct rs5c372 *rs5c372)
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
