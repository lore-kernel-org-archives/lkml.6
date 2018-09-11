Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7172AC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3F420839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=az8.co header.i=afonsobordado@az8.co header.b="LKd3wImH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3F420839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=az8.co
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeIKUAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:00:35 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21401 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeIKUAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:00:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1536678027; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=JIcrrf/2FIewE6C8GK6a5tzX2coryMBmafT7yhNiyIuqss9VwNzpCgjWIdZ5lH2H8Z92h3+XufnghJf/Dn5y7zJh+G+2dSBvIG+hGOOO0pjywaXHc3gYL/l6GqHfB1nzNtMsmZvDWbOTlDmd/RuKPOYfxSLQi6+dJdAW29uhBcE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1536678027; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=9G3x+PNll/uFQgPFi2pIBK2BDE9clu4T1TiRWNUVNNY=; 
        b=kMN1bOsYfrNW9mtOE5W9ZbbjgDNEM6CReVvEcV+wRytsK12Dakekm+c8KA2nedjHMZQnAhdTrrMheFDkx5j/qsjKzx9LLQBwe420d0u7aGRMDlcbRPa3G9Gr7Zyp6ReFWPlAegncaO3bD8F0/2MQarNMyUOsSnC4+7wPPouW/DI=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=az8.co;
        spf=pass  smtp.mailfrom=afonsobordado@az8.co;
        dmarc=pass header.from=<afonsobordado@az8.co> header.from=<afonsobordado@az8.co>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1536678027;
        s=dkimmail; d=az8.co; i=afonsobordado@az8.co;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1649; bh=9G3x+PNll/uFQgPFi2pIBK2BDE9clu4T1TiRWNUVNNY=;
        b=LKd3wImH1izuDGzdTOGUG/6+Jnzxy0rYlhUHOGixmo/tHnMtyRmmUjzXRjDSEctZ
        teE2Rq9GVHTCnWLQK92vtXKOJC0WV2N05iC89BAQr9qkkpHEKGsQSD/ujyQ36zZpL41
        aCIjU1Y4WrkKTy/Izexw79mXacprxN5Q+0eqotMY=
Received: from localhost (bl9-77-228.dsl.telepac.pt [85.242.77.228]) by mx.zohomail.com
        with SMTPS id 1536678027167132.88179067181272; Tue, 11 Sep 2018 08:00:27 -0700 (PDT)
From:   Afonso Bordado <afonsobordado@az8.co>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 3/5] dt-bindings: fxas21002c: Document the fxas21002c I2C bindings
Date:   Tue, 11 Sep 2018 16:00:09 +0100
Message-Id: <20180911150011.31964-3-afonsobordado@az8.co>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180911150011.31964-1-afonsobordado@az8.co>
References: <20180911150011.31964-1-afonsobordado@az8.co>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the fxas21002c I2C bindings.

Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
---
 .../bindings/iio/gyroscope/fsl,fxas21002c.txt | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
new file mode 100644
index 000000000000..9e5cdf0c0b69
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
@@ -0,0 +1,33 @@
+* Freescale FXAS21002C Digital Angular Rate Gyroscope
+
+Required properties:
+
+  - compatible: must be "fsl,fxas21002c"
+  - reg : the I2C address of the sensor
+
+Optional properties:
+
+  - interrupts		: The first interrupt listed must be the one
+			  connected to the INT1 pin, the second interrupt
+			  listed must be the one connected to the INT2 pin.
+			  The interrupts can be triggered on rising or falling
+			  edges alike.
+			  see interrupt-controller/interrupts.txt
+  - vdd-supply		: The main voltage regulator
+  - iovdd-supply	: The IO voltage regulator
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
-- 
2.18.0


