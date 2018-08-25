Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C900C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 20:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D914C215E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 20:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=az8.co header.i=afonsobordado@az8.co header.b="j1Ok4HuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D914C215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=az8.co
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeHYX75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 19:59:57 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21372 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeHYX74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 19:59:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1535228371; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=hGgOzZuwGmDyoUGqyoClN4u7E55gH/C62s73DvgaTNQ4ABTTJ+Gtvd9F56LNguMd1WtQ+mI+qq41hkA4HlSAERVk0QB1oP5OVenanZj5ypJ04VdU0hdp7VUnzVlDLlFfxIlWt5CltaeOsXaKQTyLgpHWGwUv6+q1/wDTVevQb/g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1535228371; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=x1y8z1ScXMqMp4dcthOupwjFxZWKxuFePaiKs83yras=; 
        b=GYypH/fKpqejIynW0PYA8uKV5/uli2gL6QD0uLDekIRzFDssOLGfbw7cP2hoqYi4T5C3UZCYFDUX6vAI+O2UQhHLeyaVogTpa/wU4ucSb2kFgBuC4CgKxZ4UoSpWgsic6n3/sJGmmBH6I/x+2n1JbFUsOE+gq2ZzNiwdHtwUdi4=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=az8.co;
        spf=pass  smtp.mailfrom=afonsobordado@az8.co;
        dmarc=pass header.from=<afonsobordado@az8.co> header.from=<afonsobordado@az8.co>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1535228371;
        s=dkimmail; d=az8.co; i=afonsobordado@az8.co;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=2017; bh=x1y8z1ScXMqMp4dcthOupwjFxZWKxuFePaiKs83yras=;
        b=j1Ok4HuFrvIiV6TQtRA2R6i5pxlvSmk2G+egVoXZGsLkZi7qms66SNjwrPdUHmSa
        lRONXPx1uCgH4TrGoQXPXgT4uba6ZkzxvPLlyM4wnNg8fDwEPodP83eh3wB+FFLfsC3
        +hcwuUy2WXksxSlG8nm7ORGZ4MVwvxA00bRPsL0c=
Received: from localhost (bl9-77-228.dsl.telepac.pt [85.242.77.228]) by mx.zohomail.com
        with SMTPS id 1535228370732342.0937789412104; Sat, 25 Aug 2018 13:19:30 -0700 (PDT)
From:   Afonso Bordado <afonsobordado@az8.co>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/4] iio: gyro: add device tree support for fxas21002c
Date:   Sat, 25 Aug 2018 22:19:08 +0100
Message-Id: <20180825211910.22929-2-afonsobordado@az8.co>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180825211910.22929-1-afonsobordado@az8.co>
References: <20180825211910.22929-1-afonsobordado@az8.co>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree support for the fxas21002c driver, including
bindings.

Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
---
 .../bindings/iio/gyroscope/fsl,fxas21002c.txt        | 12 ++++++++++++
 drivers/iio/gyro/fxas21002c.c                        | 10 +++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
new file mode 100644
index 000000000000..62f8c1bad85a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
@@ -0,0 +1,12 @@
+* Freescale FXAS21002C Digital Angular Rate Gyroscope
+
+Required properties:
+
+  - compatible: must be "fsl,fxas21002c"
+  - reg : the I2C address of the sensor
+
+Example:
+gyroscope@0 {
+       compatible = "fsl,fxas21002c";
+       reg = <0x20>;
+};
diff --git a/drivers/iio/gyro/fxas21002c.c b/drivers/iio/gyro/fxas21002c.c
index 7626b2f88d72..6fef210630e0 100644
--- a/drivers/iio/gyro/fxas21002c.c
+++ b/drivers/iio/gyro/fxas21002c.c
@@ -8,7 +8,6 @@
  * Datasheet: https://www.nxp.com/docs/en/data-sheet/FXAS21002.pdf
  * TODO:
  *        ODR / Scale Support
- *        Devicetree
  *        Power management
  *        LowPass/HighPass Filters
  *        Buffers
@@ -340,6 +339,14 @@ static int fxas21002c_remove(struct i2c_client *client)
 	return 0;
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
@@ -350,6 +357,7 @@ MODULE_DEVICE_TABLE(i2c, fxas21002c_id);
 static struct i2c_driver fxas21002c_driver = {
 	.driver = {
 		.name = FXAS21002C_DRV_NAME,
+		.of_match_table = of_match_ptr(fxas21002c_of_ids),
 	},
 	.probe		= fxas21002c_probe,
 	.remove		= fxas21002c_remove,
-- 
2.18.0


