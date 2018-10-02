Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE38C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2125B2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6Ne6b8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2125B2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbeJBUs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:48:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41360 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730574AbeJBUsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:48:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id q39-v6so1499951lfi.8;
        Tue, 02 Oct 2018 07:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ggl7fBCrXBQXD8bD7qZCxeNABuYcLvESethu/VbLop8=;
        b=D6Ne6b8wQ6L7gnZeajnVvvDtdWWvh4jEe9krXrv06cTJhZ1TSBNfmdfJQjIZVA+hwM
         wFNi+HsQXQst7rrEUAeBqJFZ0YQwPrkeZZo9RpYs//RGUmZIFo1NiuchBDcWW3c05d+k
         E3jnPwH+QRyZMhfiZycOAMFWrrJfvWIRTQvJmvzVHaOcW8gZD2Y4pAjxL8XJaJpruA/P
         WhIIOi/z91OSlhG/T/ttytcCM6Xc4heVG+oxKpanBS/jnLo1nwjkqMKcvnxuq0wdasBm
         W50Vt/Cu3qvNff/W3gvtVJJNFMFrIo77fr/Rju6fZqMj6Lt+EfYnbFNuONv/PdavSYii
         XIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ggl7fBCrXBQXD8bD7qZCxeNABuYcLvESethu/VbLop8=;
        b=XU1ohWaxxm68etwaz7SdTxIk8ReoawMsw7oLrg9mKZBK1+9I2wLgXibxJ7sM1WgfIW
         OZ8KySxU1OF0O37W/WelJOFLOCC3hdleQEsfZuZxislVNU9GPUT+Lv7UXEMF+9oJCiRA
         iBerteWthTLUD+RUpebNt3kSrs7R6KWrjuWlpUNif/KKirXsPG5IhV+7oQiZb68bQGb5
         cQdmXlhhrGOE3KrbBG2LWvp32xlI13FRoxi1vAbTKhtxYGaPUCIf/+uEumbQ3+FS1luh
         mE+sNyQFm3ZKvYpU8be3zPNjaBuPYUA9JIqyhM3j7H++fWOEEW2E0fAlSZLP7CAXLJzf
         WQ5g==
X-Gm-Message-State: ABuFfoh7XGgkPWzs7agCMQYzVqI3jkN9ok9wCZZwKHB1esbCMDYzwiLj
        EVDt/a7PIsXiFmq2weLeK5k=
X-Google-Smtp-Source: ACcGV62xIqNfA4pkeqzUgMrwBhfr/DHaEx2Nl0eAld5fCGv5ZGzAdcN14vxzM4HFya/uE2DNqvUZDA==
X-Received: by 2002:a19:1cc3:: with SMTP id c186-v6mr8020211lfc.16.1538489120808;
        Tue, 02 Oct 2018 07:05:20 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id z142-v6sm3188773lff.82.2018.10.02.07.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 07:05:19 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     "\ Hans Verkuil" <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        jacopo@jmondi.org, phdm@macq.eu
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 1/2] [media] imx214: device tree binding
Date:   Tue,  2 Oct 2018 16:05:15 +0200
Message-Id: <20181002140515.16299-1-ricardo.ribalda@gmail.com>
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
Changelog from v3:

Sakari Ailus:
-s/should/shall/
-remove clock-lanes

Philippe De Muyter:
-s/imx274/imx214/

Laurent Pinchart:
-s/to to/to/
-Better description of lanes
-clock-names: Shall be "xclk"
-Drop clock-freq

 .../devicetree/bindings/media/i2c/imx214.txt  | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/imx214.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/imx214.txt b/Documentation/devicetree/bindings/media/i2c/imx214.txt
new file mode 100644
index 000000000000..421a019ab7f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/imx214.txt
@@ -0,0 +1,53 @@
+* Sony 1/3.06-Inch 13.13Mp CMOS Digital Image Sensor
+
+The Sony imx214 is a 1/3.06-inch CMOS active pixel digital image sensor with
+an active array size of 4224H x 3200V. It is programmable through an I2C
+interface. The I2C address can be configured to 0x1a or 0x10, depending on
+how the hardware is wired.
+Image data is sent through MIPI CSI-2, through 2 or 4 lanes at a maximum
+throughput of 1.2Gbps/lane.
+
+
+Required Properties:
+- compatible: value should be "sony,imx214" for imx214 sensor
+- reg: I2C bus address of the device
+- enable-gpios: GPIO descriptor for the enable pin.
+- vdddo-supply: Chip digital IO regulator (1.8V).
+- vdda-supply: Chip analog regulator (2.7V).
+- vddd-supply: Chip digital core regulator (1.12V).
+- clocks: Reference to the xclk clock.
+- clock-names:  Shall be "xclk".
+
+Optional Properties:
+- flash-leds: See ../video-interfaces.txt
+- lens-focus: See ../video-interfaces.txt
+
+The imx214 device node shall contain one 'port' child node with
+an 'endpoint' subnode. For further reading on port node refer to
+Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+Required Properties on endpoint:
+- data-lanes: check ../video-interfaces.txt
+- link-frequencies: check ../video-interfaces.txt
+- remote-endpoint: check ../video-interfaces.txt
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
+		port {
+			imx214_ep: endpoint {
+				data-lanes = <1 2 3 4>;
+				link-frequencies = /bits/ 64 <480000000>;
+				remote-endpoint = <&csiphy0_ep>;
+			};
+		};
+	};
-- 
2.19.0

