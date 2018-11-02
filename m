Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028C1C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16882081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dZ0fWXrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16882081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeKCAzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:55:02 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:47868 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbeKCAzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:55:02 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9A4841A4A;
        Fri,  2 Nov 2018 16:47:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1541173649;
        bh=rV4SVkdaL6T+xEGcgSu7LeAhG2Hr8c9gUy/8Loshhjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZ0fWXrxeiuVPuvT+qNNSVDFzkxgtQoGa+lHZ8Pp2sXt5iPEDgSGIo/a9MJ9e1dRh
         PmKpo4Bd/KBwNTBMRS38CumMfckIRQ5avLF3IsxzT7C+VALHnonJX/xUvy0tV5IOSQ
         sV7yG+jxEPnAh25WkZRq1UyqkGQYHOaBuoH67Nts=
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, sakari.ailus@iki.fi
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v4 1/4] dt-bindings: media: i2c: Add bindings for Maxim Integrated MAX9286
Date:   Fri,  2 Nov 2018 15:47:20 +0000
Message-Id: <20181102154723.23662-2-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181102154723.23662-1-kieran.bingham@ideasonboard.com>
References: <20181102154723.23662-1-kieran.bingham@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The MAX9286 deserializes video data received on up to 4 Gigabit
Multimedia Serial Links (GMSL) and outputs them on a CSI-2 port using up
to 4 data lanes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

---
v3:
 - Update binding descriptions

v4:
 - Define the use of a CSI2 D-PHY
 - Rename pwdn-gpios to enable-gpios (with inverted polarity)
 - Remove clock-lanes mapping support
 - rewrap text blocks
 - Fix typos
---
 .../bindings/media/i2c/maxim,max9286.txt      | 182 ++++++++++++++++++
 1 file changed, 182 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max9286.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max9286.txt b/Documentation/devicetree/bindings/media/i2c/maxim,max9286.txt
new file mode 100644
index 000000000000..672f6a4d417d
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/maxim,max9286.txt
@@ -0,0 +1,182 @@
+Maxim Integrated Quad GMSL Deserializer
+---------------------------------------
+
+The MAX9286 deserializer receives video data on up to 4 Gigabit Multimedia
+Serial Links (GMSL) and outputs them on a CSI-2 D-PHY port using up to 4 data
+lanes.
+
+In addition to video data, the GMSL links carry a bidirectional control channel
+that encapsulates I2C messages. The MAX9286 forwards all I2C traffic not
+addressed to itself to the other side of the links, where a GMSL serializer
+will output it on a local I2C bus. In the other direction all I2C traffic
+received over GMSL by the MAX9286 is output on the local I2C bus.
+
+Required Properties:
+
+- compatible: Shall be "maxim,max9286"
+- reg: I2C device address
+
+Optional Properties:
+
+- poc-supply: Regulator providing Power over Coax to the cameras
+- enable-gpios: GPIO connected to the #PWDN pin with inverted polarity
+
+Required endpoint nodes:
+-----------------------
+
+The connections to the MAX9286 GMSL and its endpoint nodes are modeled using
+the OF graph bindings in accordance with the video interface bindings defined
+in Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+The following table lists the port number corresponding to each device port.
+
+        Port            Description
+        ----------------------------------------
+        Port 0          GMSL Input 0
+        Port 1          GMSL Input 1
+        Port 2          GMSL Input 2
+        Port 3          GMSL Input 3
+        Port 4          CSI-2 Output
+
+Optional Endpoint Properties for GMSL Input Ports (Port [0-3]):
+
+- remote-endpoint: phandle to the remote GMSL source endpoint subnode in the
+  remote node port.
+
+Required Endpoint Properties for CSI-2 Output Port (Port 4):
+
+- remote-endpoint: phandle to the remote CSI-2 sink endpoint node.
+- data-lanes: array of physical CSI-2 data lane indexes.
+
+Required i2c-mux nodes:
+----------------------
+
+Each GMSL link is modeled as a child bus of an i2c bus multiplexer/switch, in
+accordance with bindings described in
+Documentation/devicetree/bindings/i2c/i2c-mux.txt. The serializer device on the
+remote end of the GMSL link shall be modelled as a child node of the
+corresponding I2C bus.
+
+Required i2c child bus properties:
+- all properties described as required i2c child bus nodes properties in
+  Documentation/devicetree/bindings/i2c/i2c-mux.txt.
+
+Example:
+-------
+
+	gmsl-deserializer@2c {
+		compatible = "maxim,max9286";
+		reg = <0x2c>;
+		poc-supply = <&camera_poc_12v>;
+		enable-gpios = <&gpio 13 GPIO_ACTIVE_LOW>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				max9286_in0: endpoint {
+					remote-endpoint = <&rdacm20_out0>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				max9286_in1: endpoint {
+					remote-endpoint = <&rdacm20_out1>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+				max9286_in2: endpoint {
+					remote-endpoint = <&rdacm20_out2>;
+				};
+			};
+
+			port@3 {
+				reg = <3>;
+				max9286_in3: endpoint {
+					remote-endpoint = <&rdacm20_out3>;
+				};
+			};
+
+			port@4 {
+				reg = <4>;
+				max9286_out: endpoint {
+					data-lanes = <1 2 3 4>;
+					remote-endpoint = <&csi40_in>;
+				};
+			};
+		};
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			camera@51 {
+				compatible = "imi,rdacm20";
+				reg = <0x51 0x61>;
+
+				port {
+					rdacm20_out0: endpoint {
+						remote-endpoint = <&max9286_in0>;
+					};
+				};
+
+			};
+		};
+
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			camera@52 {
+				compatible = "imi,rdacm20";
+				reg = <0x52 0x62>;
+				port {
+					rdacm20_out1: endpoint {
+						remote-endpoint = <&max9286_in1>;
+					};
+				};
+			};
+		};
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			camera@53 {
+				compatible = "imi,rdacm20";
+				reg = <0x53 0x63>;
+				port {
+					rdacm20_out2: endpoint {
+						remote-endpoint = <&max9286_in2>;
+					};
+				};
+			};
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			camera@54 {
+				compatible = "imi,rdacm20";
+				reg = <0x54 0x64>;
+				port {
+					rdacm20_out3: endpoint {
+						remote-endpoint = <&max9286_in3>;
+					};
+				};
+			};
+		};
+	};
-- 
2.17.1

