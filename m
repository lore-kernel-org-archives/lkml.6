Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E64C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE1720894
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE1720894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbeGYO4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:56:30 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:55001 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbeGYO4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:56:30 -0400
X-Originating-IP: 2.224.242.101
Received: from w540.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 51B68C0009;
        Wed, 25 Jul 2018 13:44:42 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     mchehab@kernel.org, sakari.ailus@iki.fi,
        kieran.bingham@ideasonboard.com, robh@kernel.org,
        devicetree@vger.kernel.org
Cc:     Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [v2 1/2] dt-bindings: media: i2c: Document MT9V111 bindings
Date:   Wed, 25 Jul 2018 15:44:30 +0200
Message-Id: <1532526271-19639-2-git-send-email-jacopo@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532526271-19639-1-git-send-email-jacopo@jmondi.org>
References: <1532526271-19639-1-git-send-email-jacopo@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Add documentation for Aptina MT9V111 image sensor.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 .../bindings/media/i2c/aptina,mt9v111.txt          | 46 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 ++++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/aptina,mt9v111.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/aptina,mt9v111.txt b/Documentation/devicetree/bindings/media/i2c/aptina,mt9v111.txt
new file mode 100644
index 0000000..bd896e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/aptina,mt9v111.txt
@@ -0,0 +1,46 @@
+* Aptina MT9V111 CMOS sensor
+----------------------------
+
+The Aptina MT9V111 is a 1/4-Inch VGA-format digital image sensor with a core
+based on Aptina MT9V011 sensor and an integrated Image Flow Processor (IFP).
+
+The sensor has an active pixel array of 640x480 pixels and can output a number
+of image resolution and formats controllable through a simple two-wires
+interface.
+
+Required properties:
+--------------------
+
+- compatible: shall be "aptina,mt9v111".
+- clocks: reference to the system clock input provider.
+
+Optional properties:
+--------------------
+
+- enable-gpios: output enable signal, pin name "OE#". Active low.
+- standby-gpios: low power state control signal, pin name "STANDBY".
+  Active high.
+- reset-gpios: chip reset signal, pin name "RESET#". Active low.
+
+The device node must contain one 'port' child node with one 'endpoint' child
+sub-node for its digital output video port, in accordance with the video
+interface bindings defined in:
+Documentation/devicetree/bindings/media/video-interfaces.txt
+
+Example:
+--------
+
+        &i2c1 {
+                camera@48 {
+                        compatible = "aptina,mt9v111";
+                        reg = <0x48>;
+
+                        clocks = <&camera_clk>;
+
+                        port {
+                                mt9v111_out: endpoint {
+                                        remote-endpoint = <&ceu_in>;
+                                };
+                        };
+                };
+        };
diff --git a/MAINTAINERS b/MAINTAINERS
index bbd9b9b..4ab113c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9651,6 +9651,14 @@ F:	Documentation/devicetree/bindings/media/i2c/mt9v032.txt
 F:	drivers/media/i2c/mt9v032.c
 F:	include/media/i2c/mt9v032.h

+MT9V111 APTINA CAMERA SENSOR
+M:	Jacopo Mondi <jacopo@jmondi.org>
+L:	linux-media@vger.kernel.org
+T:	git git://linuxtv.org/media_tree.git
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/i2c/aptina,mt9v111.txt
+F:	drivers/media/i2c/mt9v111.c
+
 MULTIFUNCTION DEVICES (MFD)
 M:	Lee Jones <lee.jones@linaro.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
--
2.7.4

