Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3220C64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90433206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVE26/aY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90433206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbeJBUO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41450 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730770AbeJBUOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id u21-v6so1746143lja.8;
        Tue, 02 Oct 2018 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VoStpOfgMghdrSWHWRQ3lMWqy9WJBz4CRK6PBB7KvpI=;
        b=ZVE26/aYKEt0LaK2rXvHpl9R2VA9EsPeCNmFvkGp+Lclbf5jPPnAzdYihEwCP/Nlsc
         nSd8X2RGtyj6WDu30gOoq96hXAHbP21f0V2AJX8FDIjs92Y771vNOOJdqp0+yA1kJQLB
         Gexp4AJUV6JhGplgpqxKuNLhOJujtNPXNi5LUT+TH5IEy0i0glLQZDd/Vjat4toPEw4j
         d0phQsdCSIgGGJUL2j1LfDrHC2pHLgxSGrrZaYd9dRWlfYCzUn1n1hHSwd1YxFs7hMMA
         dB1XGoeRqnwjNrB9jb2dGIFZQIJQC5OnRi/8TAgIZABL4FxGbj7JMO5l2U7FbXU+0woh
         Wgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VoStpOfgMghdrSWHWRQ3lMWqy9WJBz4CRK6PBB7KvpI=;
        b=l4yV3JeSzmjy37x1NFiwavMetONMjYyyl8pKEPkOBai2IiuwNWT6zniugI1hPmHZ4k
         Mq8C2lgOLziXB+430xXhsgWeWBqUeqyycC5PUugVA8Fk/U4BI0MHIifucTot5On6+KOF
         g3Vpyxj2roqi6O+kijYLd6+4LPX7scuMEuhbJp3/GytTFwti6texhnMwVUFABt+7eOBZ
         4fOX4g4PToQSqqfEA5LJrDAumPlnTSe4dYXWm0GQWpN01RH60cmG08OfVs2wYc8mTOlc
         VVL16i0HEgq29c6fpDlKSL2YDesabMlu2DaArUeb6fgBdXja7Gsm6widkbJXTagM5YHV
         IZGw==
X-Gm-Message-State: ABuFfoj+NQkZZxAWLMPKh38oIXhPqw3fjV1hQeHdsGR5IsMWHUdpwl1B
        AvsGTccFpTHl9TqwkuyDLxg=
X-Google-Smtp-Source: ACcGV60xQCmXvxObc7DPaVxFTkZDW+g13up2vwV+i7Zb4siPP/FahvyVCtSDm/JZQkSlPGQyusX+cQ==
X-Received: by 2002:a2e:9a4d:: with SMTP id k13-v6mr9430202ljj.17.1538487060958;
        Tue, 02 Oct 2018 06:31:00 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id 3-v6sm3367801ljs.69.2018.10.02.06.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 06:30:59 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        jacopo@jmondi.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] [media] imx214: device tree binding
Date:   Tue,  2 Oct 2018 15:30:57 +0200
Message-Id: <20181002133058.12942-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document bindings for imx214 camera sensor

Cc: devicetree@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
Changelog v2:
Laurent Pinchart:

-Spell checks
-Remove frequency
-Identation
-Data lanes order

Thanks!

 .../devicetree/bindings/media/i2c/imx214.txt  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/imx214.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/imx214.txt b/Documentation/devicetree/bindings/media/i2c/imx214.txt
new file mode 100644
index 000000000000..bf3cac731eca
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/imx214.txt
@@ -0,0 +1,52 @@
+* Sony 1/3.06-Inch 13.13Mp CMOS Digital Image Sensor
+
+The Sony imx214 is a 1/3.06-inch CMOS active pixel digital image sensor with
+an active array size of 4224H x 3200V. It is programmable through an I2C
+interface. The I2C address can be configured to to 0x1a or 0x10, depending on
+how the hardware is wired.
+Image data is sent through MIPI CSI-2, which is configured as 4 lanes
+at 1440 Mbps.
+
+
+Required Properties:
+- compatible: value should be "sony,imx214" for imx214 sensor
+- reg: I2C bus address of the device
+- enable-gpios: GPIO descriptor for the enable pin.
+- vdddo-supply: Chip digital IO regulator (1.8V).
+- vdda-supply: Chip analog regulator (2.7V).
+- vddd-supply: Chip digital core regulator (1.12V).
+- clocks = Reference to the xclk clock.
+- clock-names = Clock name, e.g. "xclk".
+- clock-frequency = Frequency of the xclk clock. (Currently the
+	driver only supports <24000000>).
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
+			imx214_ep: endpoint {
+				clock-lanes = <0>;
+				data-lanes = <1 2 3 4>;
+				link-frequencies = /bits/ 64 <480000000>;
+				remote-endpoint = <&csiphy0_ep>;
+			};
+		};
+	};
-- 
2.19.0

