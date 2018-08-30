Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF1FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5269120839
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=az8.co header.i=afonsobordado@az8.co header.b="jcqHfs69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5269120839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=az8.co
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeHaBXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:23:18 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21495 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeHaBXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:23:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1535663923; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=ZYPYDAkpX0kINHI5IvbMXgiOV64UORq5T59rh1p3meru/twY5cokY6kE1w9XzpcUqyUSGE0gW1z0VIiw+qBxGxK3lHs6EsS8KrqudV2veoHWubX4JJuo6L2PngmOfnAwWMJpItNgmaqutFVH7qBwtsvCwcP2Qz5VfYSZAKCa3vA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1535663923; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=Nl8QpRI8kRY2ytziQ2utk0WWGRFgO1E/sh3rS5jarcs=; 
        b=KOI4BD6eTVlw1acLCY4RpqQJpOAo9s9eALx0r6tSkkUgrQYdmKFTfz3UqrpTrrKMEkdZ0A+rUBXNfg53DUg2JxLFr82T6idJaGvdNW8Q3CyHR7V5QVISRB+o7bkIYSbd3NKXHEhBKL6qBswiE1rLFtmbRG2/v7X21K2hIMpXN8U=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=az8.co;
        spf=pass  smtp.mailfrom=afonsobordado@az8.co;
        dmarc=pass header.from=<afonsobordado@az8.co> header.from=<afonsobordado@az8.co>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1535663923;
        s=dkimmail; d=az8.co; i=afonsobordado@az8.co;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=2959; bh=Nl8QpRI8kRY2ytziQ2utk0WWGRFgO1E/sh3rS5jarcs=;
        b=jcqHfs69BX1NLnC3+ny0suXNEDZ4NBTUu6emjV6tivGUQnCqw7tD7wGqoID0/qdP
        ECG3tBmk7vW7PaGS+Sy+7X3CwvIrx+fEljKBElVR/NC9RPQLMaO1TfFMAUDdTpOX9XI
        NJ9X+751gxnTLRgJscuxeairN5DGHdiDnOumDxIs=
Received: from localhost (bl9-77-228.dsl.telepac.pt [85.242.77.228]) by mx.zohomail.com
        with SMTPS id 1535663921390463.314782828582; Thu, 30 Aug 2018 14:18:41 -0700 (PDT)
From:   Afonso Bordado <afonsobordado@az8.co>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/4] iio: gyro: add device tree support for fxas21002c
Date:   Thu, 30 Aug 2018 22:18:23 +0100
Message-Id: <20180830211825.12202-2-afonsobordado@az8.co>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830211825.12202-1-afonsobordado@az8.co>
References: <20180830211825.12202-1-afonsobordado@az8.co>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree support for the fxas21002c driver, including
bindings.

Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
---
 .../bindings/iio/gyroscope/fsl,fxas21002c.txt | 35 +++++++++++++++++++
 drivers/iio/gyro/fxas21002c.c                 | 13 ++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
new file mode 100644
index 000000000000..2feda6da5566
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
@@ -0,0 +1,35 @@
+* Freescale FXAS21002C Digital Angular Rate Gyroscope
+
+Required properties:
+
+  - compatible: must be "fsl,fxas21002c"
+  - reg : the I2C address of the sensor
+
+Optional properties:
+
+  - interrupt-parent	: phandle to the parent interrupt controller.
+			  see interrupt-controller/interrupts.txt
+  - interrupts		: The first interrupt listed must be the one
+			  connected to the INT1 pin, the second interrupt
+			  listed must be the one connected to the INT2 pin.
+			  The interrupts can be triggered on rising or falling
+			  edges alike.
+			  see interrupt-controller/interrupts.txt
+  - vdd-supply		: The main voltage regulator
+  - iovdd-supply	: The IO voltage regulator
+			  see regulator/regulator.txt
+  - reset-gpios	: GPIO used to reset the device.
+			  see gpio/gpio.txt.
+  - mount-matrix	: see iio/mount-matrix.txt
+
+Example:
+gyroscope@0 {
+	compatible = "fsl,fxas21002c";
+	reg = <0x20>;
+	reset-gpios = <&gpio0 2 0>;
+	vdd-supply = <&vref>;
+	iovdd-supply = <&vref2>;
+	interrupt-parent = <&foo>;
+	interrupts = <0 IRQ_TYPE_EDGE_RISING>,
+		     <1 (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)>;
+};
diff --git a/drivers/iio/gyro/fxas21002c.c b/drivers/iio/gyro/fxas21002c.c
index 261b73629544..7471e9b80010 100644
--- a/drivers/iio/gyro/fxas21002c.c
+++ b/drivers/iio/gyro/fxas21002c.c
@@ -8,8 +8,10 @@
  * Datasheet: https://www.nxp.com/docs/en/data-sheet/FXAS21002.pdf
  * TODO:
  *        ODR / Scale Support
- *        Devicetree
  *        Power management
+ *        GPIO Reset
+ *        Power supplies
+ *        Mount Matrix
  *        LowPass/HighPass Filters
  *        Buffers
  *        Interrupts
@@ -345,6 +347,14 @@ static int fxas21002c_probe(struct i2c_client *client,
 	return ret;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id fxas21002c_of_ids[] = {
+	{.compatible = "fsl,fxas21002c"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, fxas21002c_of_ids);
+#endif
+
 static const struct i2c_device_id fxas21002c_id[] = {
 	{"fxas21002c", ID_FXAS21002C},
 	{}
@@ -355,6 +365,7 @@ MODULE_DEVICE_TABLE(i2c, fxas21002c_id);
 static struct i2c_driver fxas21002c_driver = {
 	.driver = {
 		.name = FXAS21002C_DRV_NAME,
+		.of_match_table = of_match_ptr(fxas21002c_of_ids),
 	},
 	.probe		= fxas21002c_probe,
 	.id_table	= fxas21002c_id,
-- 
2.18.0


