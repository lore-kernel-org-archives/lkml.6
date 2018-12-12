Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5268DC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1738C20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1738C20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pschenker.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbeLLNHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:07:08 -0500
Received: from mxout013.mail.hostpoint.ch ([217.26.49.173]:51030 "EHLO
        mxout013.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726232AbeLLNHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:07:07 -0500
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout013.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1gX4EA-0006kR-JP; Wed, 12 Dec 2018 14:07:02 +0100
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1gX4EA-000IXM-Dm; Wed, 12 Dec 2018 14:07:02 +0100
X-Authenticated-Sender-Id: dev@pschenker.ch
From:   Philippe Schenker <dev@pschenker.ch>
To:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch
Cc:     thierry.reding@gmail.com,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v4 6/8] iio: adc: add STMPE ADC devicetree bindings
Date:   Wed, 12 Dec 2018 14:06:47 +0100
Message-Id: <20181212130649.15146-6-dev@pschenker.ch>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212130649.15146-1-dev@pschenker.ch>
References: <20181212130649.15146-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

This adds the devicetree bindings for the STMPE ADC. And corrects a
typo in st,sample-time it is rather "6 -> 124 clocks" according
to the datasheet and not 144.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

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

 .../devicetree/bindings/iio/adc/stmpe-adc.txt | 21 ++++++++++++
 .../bindings/input/touchscreen/stmpe.txt      | 32 +++++++++----------
 .../devicetree/bindings/mfd/stmpe.txt         | 14 ++++++++
 3 files changed, 51 insertions(+), 16 deletions(-)
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
index 1d3f84308142..8e2b240882fa 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
@@ -5,18 +5,6 @@ Required properties:
  - compatible: "st,stmpe-ts"
 
 Optional properties:
-- st,sample-time	: ADC conversion time in number of clock.
-				0 -> 36 clocks		4 -> 80 clocks (recommended)
-				1 -> 44 clocks		5 -> 96 clocks
-				2 -> 56 clocks		6 -> 144 clocks
-				3 -> 64 clocks
-- st,mod-12b		: ADC Bit mode
-				0 -> 10bit ADC		1 -> 12bit ADC
-- st,ref-sel		: ADC reference source
-				0 -> internal		1 -> external
-- st,adc-freq		: ADC Clock speed
-				0 -> 1.625 MHz		2 || 3 -> 6.5 MHz
-				1 -> 3.25 MHz
 - st,ave-ctrl		: Sample average control
 				0 -> 1 sample
 				1 -> 2 samples
@@ -40,17 +28,29 @@ Optional properties:
 				0 -> 20 mA (typical 35mA max)
 				1 -> 50 mA (typical 80 mA max)
 
+Optional properties common with MFD (deprecated):
+ - st,sample-time	: ADC conversion time in number of clock.
+				0 -> 36 clocks		4 -> 80 clocks (recommended)
+				1 -> 44 clocks		5 -> 96 clocks
+				2 -> 56 clocks		6 -> 124 clocks
+				3 -> 64 clocks
+ - st,mod-12b		: ADC Bit mode
+				0 -> 10bit ADC		1 -> 12bit ADC
+ - st,ref-sel		: ADC reference source
+				0 -> internal		1 -> external
+ - st,adc-freq		: ADC Clock speed
+				0 -> 1.625 MHz		2 || 3 -> 6.5 MHz
+				1 -> 3.25 MHz
+
 Node name must be stmpe_touchscreen and should be child node of stmpe node to
 which it belongs.
 
+Note that common ADC settings of stmpe_touchscreen will take precedence.
+
 Example:
 
 	stmpe_touchscreen {
 		compatible = "st,stmpe-ts";
-		st,sample-time = <4>;
-		st,mod-12b = <1>;
-		st,ref-sel = <0>;
-		st,adc-freq = <1>;
 		st,ave-ctrl = <1>;
 		st,touch-det-delay = <2>;
 		st,settling = <2>;
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
2.19.2

