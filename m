Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B1FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9277321547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5e/08F2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9277321547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389670AbeIUP5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:57:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42932 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeIUP5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:57:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id l5so10250823edw.9;
        Fri, 21 Sep 2018 03:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+xp1tHYgcqmK5vJcXbbULWl6T/5gevxAd+xabl7FRRA=;
        b=U5e/08F2rRvGXoV8XIdXH4tYNY/6P+QtjsObEuaeNKb7Ok66vi98tntC1MN4cILJ+2
         rnYNH2emjkvPC5INYpysn2j8FHlqW/gc1ZLB2V7IdxKvtwykhG92pBHxd7BHqqFQmkSv
         1yaBNUuG+9jIW6KU023b5Hz1XVLAPpOdM7/Z99VFIZAWt5p+MqTUcBNgLlyf+D52oteB
         Aqwb4kZNZXvoIvy5Tunm02Zy5xHq9pp0xRHQPB6DmVwZ4YYFX+TEBNeN8459WdQT/26k
         0ducix8wA8AXu5opdVAdRztdNKlsBXwWPg67jPmapSB5M6cOv+CH/MZ40vttC5FTJMvM
         WZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+xp1tHYgcqmK5vJcXbbULWl6T/5gevxAd+xabl7FRRA=;
        b=HbjtSjSF8be79upQhkJReQ2wW8J+9RfTSmZgoDzEqm2RyalPG6SafddH+2cdPo5btV
         C7GJhMt6R5tx/tdka1WocCbHdUTz2kRRYrNN4wZeGxtXWWxe+Bwi2g3t7KEUtw9fzGp0
         r1TF7lESTKaEpCdlyU7YY8ATzdLJNm/HIleyl+rJRf6hiLSbROlnIGI04yyRPl2lJKe9
         cwX3+hYEibaw4ZoSPe1y00QVeQok6RZBlhSX1s7TkvOzDXwmfNUY34e9UKNhgDE66ftq
         ua2zCCjwmKSSOrnCPzvCAzlzxZ4HgcNm7m0EJprjVcsPORoTWaWRsVkFWPtzIMpyU3Nm
         9i+A==
X-Gm-Message-State: APzg51AvtqdeBMAvV4h3OYaIsrxbygFEBS98IV4M9aHshxfmmsTX6GNd
        PCqUvzQOoAmdsqDvORdrMU0=
X-Google-Smtp-Source: ANB0VdYG15FKeVdHfPvFtBs25Iu0ct01SoN+ehWZVxoW4gh7eDxwSFJJE9t+B9XKizkuz8MS4BE72Q==
X-Received: by 2002:a50:d798:: with SMTP id w24-v6mr11149734edi.19.1537524563557;
        Fri, 21 Sep 2018 03:09:23 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id g38-v6sm2103451edc.40.2018.09.21.03.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 03:09:21 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] [media] imx214: device tree binding
Date:   Fri, 21 Sep 2018 12:09:19 +0200
Message-Id: <20180921100920.8656-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document bindings for imx214 v4l2 driver.

Cc: devicetree@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 .../devicetree/bindings/media/i2c/imx214.txt  | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/imx214.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/imx214.txt b/Documentation/devicetree/bindings/media/i2c/imx214.txt
new file mode 100644
index 000000000000..4ff76d96332e
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/imx214.txt
@@ -0,0 +1,51 @@
+* Sony 1/3.06-Inch 13.13Mp CMOS Digital Image Sensor
+
+The Sony imx214 is a 1/3.06-inch CMOS active pixel digital image sensor with
+an active array size of 4224H x 3176V. It is programmable through I2C
+interface. The I2C address can be configured to to 0x1a or 0x10, depending on
+how is wired.
+Image data is sent through MIPI CSI-2, which is configured as 4 lanes
+at 1440 Mbps.
+
+
+Required Properties:
+- compatible: value should be "sony,imx214" for imx214 sensor
+- reg: I2C bus address of the device
+- enable-gpios: Sensor enable GPIO
+- vdddo-supply: Chip digital IO regulator (1.8V).
+- vdda-supply: Chip analog regulator (2.7V).
+- vddd-supply: Chip digital core regulator (1.12V).
+- clocks = Reference to the xclk clock.
+- clock-names = Should be "xclk".
+- clock-frequency = Frequency of the xclk clock. Should be <24000000>;
+
+Optional Properties:
+- flash-leds: See ../video-interfaces.txt
+- lens-focus: See ../video-interfaces.txt
+
+The imx274 device node should contain one 'port' child node with
+an 'endpoint' subnode. For further reading on port node refer to
+Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+Example:
+
+	camera_rear@1a {
+		status = "okay";
+		compatible = "sony,imx214";
+		reg = <0x1a>;
+		vdddo-supply = <&pm8994_lvs1>;
+		vddd-supply = <&camera_vddd_1v12>;
+		vdda-supply = <&pm8994_l17>;
+		lens-focus = <&ad5820>;
+		enable-gpios = <&msmgpio 25 GPIO_ACTIVE_HIGH>;
+		clocks = <&mmcc CAMSS_MCLK0_CLK>;
+		clock-names = "xclk";
+		clock-frequency = <24000000>;
+		port {
+				imx214_ep: endpoint {
+				clock-lanes = <1>;
+				data-lanes = <0 2 3 4>;
+				remote-endpoint = <&csiphy0_ep>;
+			};
+		};
+	};
-- 
2.18.0

