Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9718C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C0D206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731242AbfAINmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:42:37 -0500
Received: from mxout014.mail.hostpoint.ch ([217.26.49.174]:49467 "EHLO
        mxout014.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730795AbfAINme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:42:34 -0500
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout014.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1ghE7o-0007Zg-8M; Wed, 09 Jan 2019 14:42:28 +0100
Received: from 252.222.41.212.static.wline.lns.sme.cust.swisscom.ch ([212.41.222.252] helo=philippe-pc.toradex.int)
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1ghE7o-0006KA-24; Wed, 09 Jan 2019 14:42:28 +0100
X-Authenticated-Sender-Id: dev@pschenker.ch
From:   Philippe Schenker <dev@pschenker.ch>
To:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch
Cc:     robh@kernel.org, alexandre.torgue@st.com, shawnguo@kernel.org,
        dmitry.torokhov@gmail.com, thierry.reding@gmail.com,
        mcoquelin.stm32@gmail.com, digetx@gmail.com, lee.jones@linaro.org,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v6 6/8] iio: adc: add STMPE ADC devicetree bindings
Date:   Wed,  9 Jan 2019 14:42:05 +0100
Message-Id: <20190109134208.5660-7-dev@pschenker.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109134208.5660-1-dev@pschenker.ch>
References: <20190109134208.5660-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

This adds the devicetree bindings for the STMPE ADC. This also corrects
a typo in st,sample-time it is rather "6 -> 124 clocks" according
to the datasheet and not 144.
We need to use the naming stmpe_adc in devicetree because this is given
by the mfd device.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes in v6:
 - Added Rob's Reviewed-by

Changes in v5:
 - Made a one column list
 - Cleared note about precedence
 - Changed example to a full STMPE811 device with MFD, touchscreen, and the new
   stmpe_adc driver.
 - Added Jonathan Cameron's Reviewed-by

Changes in v4:
 - Put reformatting in a separate precursor patch.

Changes in v3:
 - Reformatted documentation for touchscreen to use tabs and have a better
   overview of the settings.
 - Added note which adc-settings will take precedence.
 - changed typo in sample-time setting from 144 clocks to 124 clocks, as stated
   in the datasheet.

Changes in v2:
 - Moved the bindings for ADC to the overlying mfd.
 - Reformatted for better readability

 .../devicetree/bindings/iio/adc/stmpe-adc.txt | 21 +++++
 .../bindings/input/touchscreen/stmpe.txt      | 88 +++++++++++++------
 .../devicetree/bindings/mfd/stmpe.txt         | 14 +++
 3 files changed, 98 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt b/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
new file mode 100644
index 000000000000..480e66422625
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
@@ -0,0 +1,21 @@
+STMPE ADC driver
+----------------
+
+Required properties:
+ - compatible: "st,stmpe-adc"
+
+Optional properties:
+Note that the ADC is shared with the STMPE touchscreen. ADC related settings
+have to be done in the mfd.
+- st,norequest-mask: bitmask specifying which ADC channels should _not_ be
+  requestable due to different usage (e.g. touch)
+
+Node name must be stmpe_adc and should be child node of stmpe node to
+which it belongs.
+
+Example:
+
+	stmpe_adc {
+		compatible = "st,stmpe-adc";
+		st,norequest-mask = <0x0F>; /* dont use ADC CH3-0 */
+	};
diff --git a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
index bf66a55a7de5..c549924603d2 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
@@ -5,24 +5,6 @@ Required properties:
  - compatible: "st,stmpe-ts"
 
 Optional properties:
-- st,sample-time	: ADC conversion time in number of clock.
-				0 -> 36 clocks
-				1 -> 44 clocks
-				2 -> 56 clocks
-				3 -> 64 clocks
-				4 -> 80 clocks (recommended)
-				5 -> 96 clocks
-				6 -> 144 clocks
-- st,mod-12b		: ADC Bit mode
-				0 -> 10bit ADC
-				1 -> 12bit ADC
-- st,ref-sel		: ADC reference source
-				0 -> internal
-				1 -> external
-- st,adc-freq		: ADC Clock speed
-				0 -> 1.625 MHz
-				1 -> 3.25 MHz
-				2 || 3 -> 6.5 MHz
 - st,ave-ctrl		: Sample average control
 				0 -> 1 sample
 				1 -> 2 samples
@@ -52,20 +34,76 @@ Optional properties:
 				0 -> 20 mA (typical 35mA max)
 				1 -> 50 mA (typical 80 mA max)
 
+Optional properties common with MFD (deprecated):
+ - st,sample-time	: ADC conversion time in number of clock.
+				0 -> 36 clocks
+				1 -> 44 clocks
+				2 -> 56 clocks
+				3 -> 64 clocks
+				4 -> 80 clocks (recommended)
+				5 -> 96 clocks
+				6 -> 124 clocks
+ - st,mod-12b		: ADC Bit mode
+				0 -> 10bit ADC
+				1 -> 12bit ADC
+ - st,ref-sel		: ADC reference source
+				0 -> internal
+				1 -> external
+ - st,adc-freq		: ADC Clock speed
+				0 -> 1.625 MHz
+				1 -> 3.25 MHz
+				2 || 3 -> 6.5 MHz
+
 Node name must be stmpe_touchscreen and should be child node of stmpe node to
 which it belongs.
 
+Note that common ADC settings of stmpe_touchscreen (child) will take precedence
+over the settings done in MFD.
+
 Example:
 
+stmpe811@41 {
+	compatible = "st,stmpe811";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_touch_int>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x41>;
+	interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+	interrupt-parent = <&gpio4>;
+	interrupt-controller;
+	id = <0>;
+	blocks = <0x5>;
+	irq-trigger = <0x1>;
+	/* Common ADC settings */
+	/* 3.25 MHz ADC clock speed */
+	st,adc-freq = <1>;
+	/* 12-bit ADC */
+	st,mod-12b = <1>;
+	/* internal ADC reference */
+	st,ref-sel = <0>;
+	/* ADC converstion time: 80 clocks */
+	st,sample-time = <4>;
+
 	stmpe_touchscreen {
 		compatible = "st,stmpe-ts";
-		st,sample-time = <4>;
-		st,mod-12b = <1>;
-		st,ref-sel = <0>;
-		st,adc-freq = <1>;
-		st,ave-ctrl = <1>;
-		st,touch-det-delay = <2>;
-		st,settling = <2>;
+		reg = <0>;
+		/* 8 sample average control */
+		st,ave-ctrl = <3>;
+		/* 5 ms touch detect interrupt delay */
+		st,touch-det-delay = <5>;
+		/* 1 ms panel driver settling time */
+		st,settling = <3>;
+		/* 7 length fractional part in z */
 		st,fraction-z = <7>;
+		/*
+		 * 50 mA typical 80 mA max touchscreen drivers
+		 * current limit value
+		 */
 		st,i-drive = <1>;
 	};
+	stmpe_adc {
+		compatible = "st,stmpe-adc";
+		st,norequest-mask = <0x0F>;
+	};
+};
diff --git a/Documentation/devicetree/bindings/mfd/stmpe.txt b/Documentation/devicetree/bindings/mfd/stmpe.txt
index a46e7177195d..d4408a417193 100644
--- a/Documentation/devicetree/bindings/mfd/stmpe.txt
+++ b/Documentation/devicetree/bindings/mfd/stmpe.txt
@@ -14,6 +14,20 @@ Optional properties:
  - st,autosleep-timeout		: Valid entries (ms); 4, 16, 32, 64, 128, 256, 512 and 1024
  - irq-gpio			: If present, which GPIO to use for event IRQ
 
+Optional properties for devices with touch and ADC (STMPE811|STMPE610):
+ - st,sample-time		: ADC conversion time in number of clock.
+					0 -> 36 clocks		4 -> 80 clocks (recommended)
+					1 -> 44 clocks		5 -> 96 clocks
+					2 -> 56 clocks		6 -> 124 clocks
+					3 -> 64 clocks
+ - st,mod-12b			: ADC Bit mode
+					0 -> 10bit ADC		1 -> 12bit ADC
+ - st,ref-sel			: ADC reference source
+					0 -> internal		1 -> external
+ - st,adc-freq			: ADC Clock speed
+					0 -> 1.625 MHz		2 || 3 -> 6.5 MHz
+					1 -> 3.25 MHz
+
 Example:
 
 	stmpe1601: stmpe1601@40 {
-- 
2.20.1

