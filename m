Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B438C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC3020645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=az8.co header.i=afonsobordado@az8.co header.b="g7olJaaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC3020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=az8.co
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbeIDXbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:31:37 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21406 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIDXbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:31:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1536087886; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=nzgdfEx1mioJBqF6QRH5tjVfh/Jn6RnBwR8yQb0vtsHC+kqO6C+/61evPLhdddn+2c4lQH/b+yMkPqt63eHO0Sw8EvvyfwGdAOLd21fsH8HPoSUDUq5fNe3vLPuUFJ+bs7gyCJyAGEOoCRJvN9NJRO207Nn+o5SYwjyi2niY58c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1536087886; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=YMx5VvmJ8fW6zZHsvaFdHdmEl5xkSGTecAbAMIAh5xM=; 
        b=XG9Tse2VU4p7+gyhksCOMfakmNbnuVs5eCjRgACabjChVkqM82moSBNnMnk2YVxVJ40M0Io4OIzfZnvmjj67VH6GAtnYz4dxIJBjEvdob7hk0qmRKOlee1AQSbtehoHONVy7FcdV9zxiLHhw7I+hsrN4OOTwvnOel3F5WwxVtMU=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=az8.co;
        spf=pass  smtp.mailfrom=afonsobordado@az8.co;
        dmarc=pass header.from=<afonsobordado@az8.co> header.from=<afonsobordado@az8.co>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1536087886;
        s=dkimmail; d=az8.co; i=afonsobordado@az8.co;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=2882; bh=YMx5VvmJ8fW6zZHsvaFdHdmEl5xkSGTecAbAMIAh5xM=;
        b=g7olJaaFgATpb21BdAV/PYMxaJ7LdlaVl8eDCYdfKHePQO8AnLeNJkDu9HQZcKdA
        Ef4oL7O1xCOCdH9Xc7cJ91ZUsrhD8gGp4M3ItR0+UCn0yrJZiLTCLpq5wvE1onrEErm
        rVCBkij0YTF68OgG22Mg+fluE/vbvAuwayV6W4eE=
Received: from localhost (bl9-77-228.dsl.telepac.pt [85.242.77.228]) by mx.zohomail.com
        with SMTPS id 1536087883621993.4434342450922; Tue, 4 Sep 2018 12:04:43 -0700 (PDT)
From:   Afonso Bordado <afonsobordado@az8.co>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 2/4] iio: gyro: add device tree support for fxas21002c
Date:   Tue,  4 Sep 2018 21:04:32 +0100
Message-Id: <20180904200434.10442-2-afonsobordado@az8.co>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904200434.10442-1-afonsobordado@az8.co>
References: <20180904200434.10442-1-afonsobordado@az8.co>
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
 drivers/iio/gyro/fxas21002c.c                 | 10 +++++-
 2 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
new file mode 100644
index 000000000000..5f02cfa5ac82
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
+  - vdd-supply 		: The main voltage regulator
+  - iovdd-supply 	: The IO voltage regulator
+			  see regulator/regulator.txt
+  - reset-gpios		: GPIO used to reset the device.
+			  see gpio/gpio.txt.
+  - mount-matrix	: see iio/mount-matrix.txt
+
+Example:
+gyroscope@20 {
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
index 1668e6f3fe11..18b1f500dd3e 100644
--- a/drivers/iio/gyro/fxas21002c.c
+++ b/drivers/iio/gyro/fxas21002c.c
@@ -8,7 +8,6 @@
  * Datasheet: https://www.nxp.com/docs/en/data-sheet/FXAS21002.pdf
  * TODO:
  *        ODR / Scale Support
- *        Devicetree
  *        Power management
  *        GPIO Reset
  *        Power supplies
@@ -350,6 +349,14 @@ static int fxas21002c_probe(struct i2c_client *client,
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
@@ -360,6 +367,7 @@ MODULE_DEVICE_TABLE(i2c, fxas21002c_id);
 static struct i2c_driver fxas21002c_driver = {
 	.driver = {
 		.name = FXAS21002C_DRV_NAME,
+		.of_match_table = of_match_ptr(fxas21002c_of_ids),
 	},
 	.probe		= fxas21002c_probe,
 	.id_table	= fxas21002c_id,
-- 
2.18.0


