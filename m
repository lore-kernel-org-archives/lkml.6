Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64FAECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D6E2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D6E2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efe-gmbh.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeIQSFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:05:19 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:53311 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbeIQSFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:05:19 -0400
Received: from EFESN2455.efe.local ([217.94.30.50]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1McpeM-1fS04a1JTu-00ZtZo; Mon, 17 Sep 2018 14:38:06 +0200
From:   Karsten Mueller <mueller.k@efe-gmbh.de>
To:     mueller.k@efe-gmbh.de
Cc:     renner@efe-gmbh.de, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: power: supply: bq2416x driver
Date:   Mon, 17 Sep 2018 14:37:28 +0200
Message-Id: <20180917123729.23461-2-mueller.k@efe-gmbh.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180917123729.23461-1-mueller.k@efe-gmbh.de>
References: <20180917123729.23461-1-mueller.k@efe-gmbh.de>
X-Provags-ID: V03:K1:fmj4tgRY8hVBY7kJSWH1BJfDG2Oy+rMoLSfqNyzcJrgIA4UUpm8
 2H28gEGCoLdwTlCdgkOKospnH1SFl7LKiYheSPXeqys/r67Gv7V4grzQqVZXmbGXiEp/YAO
 o7IHQYd8/77euqTrQXhXOVd+fw2lJ8ygWTe8rk4XXN3pwaH6rCkwgZpQn3J14EacSK3Ypq+
 o3zClXRgAOS7OhpiJEqIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l0WUBQ7cR5s=:olUGau3RON1BxzaksgfFfE
 yRgA3AhK/afjpNP/RFEhndwKYy43dtIFH8gW5JqzZiUvLkqkOF1teIB1Kx+f/pAb+NKPJ0KJb
 4HyyvMybEh3E19IUV5AJVWE5WiaqyFJoGwxMwvWP8GmE2Ju9WHAd1cYWg2M1cE6O+RJg5U1JY
 m1JAenNJe1S/T9JTpFujh1SiVRpMQ+XUbAx47P1Anv+hsARE94kfXdJ+u6qN+6Q5dUWW0Rol9
 muboLZBq5XEYCzBu1/iMk2RDdEuMAjLh1FbHxAQS6o7kePk23+fwCDFaXtkCwVpwKZcNfovGj
 4T0/n5Zv1Z4YLf11Vlp9fhVjgdoOGd1DiPuaaR6Yaid5gQJ/+h3MwaPGgFhFcAern/9O/dmcQ
 0AKnu4JyRlj3bNjRMvCBGp2DdRWiJFXzeIielOdHhX4rB2AATVJQk/xvqJ2pLPfofsmHLZ06i
 zJovqaz7kOKbE41Bkw/v/X8djEQKwfdR+jcbzbxBlspd54N2TJzP+T0IpMXudhCOhX6KVEDA8
 yMB/JwAzSazK8Jis0Ns+mdEgRcxowA1TuvmrBSdeU7NFcA381CoKeKr2/6tHooBwAPGlkOmXl
 TmsbSd7qrpx7aZxv4bkmkDmWUDhAHTgwD7R9TJHhzk6X6WkujrLWussEJpqVHyyqP9UmW/Dfm
 7mjlh64641BuE0yRS/ZIwK8NOvjzJUUalO9qITFTQC9mgOQFVdPAEXHolKHYDlo0chV8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Karsten Mueller <mueller.k@efe-gmbh.de>
---
 .../bindings/power/supply/bq2416x.txt         | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2416x.txt

diff --git a/Documentation/devicetree/bindings/power/supply/bq2416x.txt b/Documentation/devicetree/bindings/power/supply/bq2416x.txt
new file mode 100644
index 000000000..742d41642
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq2416x.txt
@@ -0,0 +1,75 @@
+Binding for TI bq2416x Li-Ion Charger
+
+Required properties:
+====================
+- compatible: one of the following:
+ * "ti,bq24160"
+ * "ti,bq24160a"
+ * "ti,bq24161"
+ * "ti,bq24161b"
+ * "ti,bq24163"
+ * "ti,bq24168"
+
+- reg:			I2C address of the device.
+- interrupt-parent:	The IRQ controller (phandle) connected to the INT pin of
+			the bq2416x
+- interrupts:		The IRQ number assigned for INT pin.
+
+Optional properties:
+====================
+
+- ti,in-current-limit-microamp:	IN source current limit.
+	Possible values: 1500000 (default), 2500000
+
+- ti,usb-current-limit-microamp: USB source current limit.
+	If not specified, auto detection of USB (D+/D- based) is used (for
+	BQ24160/0A/3 only) or settings of default mode are kept (BQ24161/1B/8).
+	Both pre-select only 100 mA or 1500 mA (refer to datasheet).
+	Possible values: 100000, 150000, 500000, 800000, 90000, 1500000
+
+- ti,usb-dpm-voltage-microvolt:	USB threshold for dynamic power path management.
+	Configures the threshold input voltage (usb input) for the dynamic power
+	path management. If not specified a default of 4,200,000 (= 4.2V) is
+	used.
+
+- ti,in-dpm-voltage-microvolt: IN threshold for dynamic power path management.
+	Configures the threshold input voltage (in input) for the dynamic power
+	path management. If not specified a default of 4,200,000 (= 4.2V) is
+	used.
+
+- monitored-battery: phandle of battery information devicetree node
+	If not specified, no battery is assumed (charge disable, nobat operation
+	mode, no NTC check of battery), Vsys output voltage is set to 4.2V. The
+	charger uses the following battery properties:
+	+ constant_charge_current_max_microamp: maximum current in fast charge
+	  mode
+	+ constant_charge_voltage_max_microvolt: maximum constant charging
+	  voltage / output voltage (refer to datasheet)
+	+ charge-term-current-microamp: a charge cycle terminates when the
+	  battery voltage is above recharge threshold, and the current is below
+	  this setting (typically 10% of battery capacity). If not specified,
+	  termination of current detection is disabled (refer to datasheet).
+
+Example:
+========
+
+bat: battery {
+		compatible = "simple-battery";
+		charge-term-current-microamp = <128000>;
+		constant-charge-current-max-microamp = <900000>;
+		constant-charge-voltage-max-microvolt = <4200000>;
+	};
+
+bq24160@6b {
+	compatible = "ti,bq24160";
+	reg = <0x6b>;
+
+	interrupt-parent = <&gpio5>;
+	interrupts = <31 IRQ_TYPE_EDGE_RISING>;
+
+	monitored-battery = <&bat>;
+	ti,in-current-limit-microamp = <1500000>;
+	ti,usb-current-limit-microamp = <500000>;
+	ti,usb-dpm-voltage-microvolt = <4300000>;
+	ti,in-dpm-voltage-microvolt = <4300000>;
+};
-- 
2.17.1

