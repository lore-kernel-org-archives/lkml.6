Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E32EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CE1206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfAINml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:42:41 -0500
Received: from mxout017.mail.hostpoint.ch ([217.26.49.177]:42886 "EHLO
        mxout017.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730561AbfAINmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:42:38 -0500
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1ghE7q-0002PM-38; Wed, 09 Jan 2019 14:42:30 +0100
Received: from 252.222.41.212.static.wline.lns.sme.cust.swisscom.ch ([212.41.222.252] helo=philippe-pc.toradex.int)
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1ghE7p-0006KA-Tk; Wed, 09 Jan 2019 14:42:30 +0100
X-Authenticated-Sender-Id: dev@pschenker.ch
From:   Philippe Schenker <dev@pschenker.ch>
To:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch
Cc:     robh@kernel.org, alexandre.torgue@st.com, shawnguo@kernel.org,
        dmitry.torokhov@gmail.com, thierry.reding@gmail.com,
        mcoquelin.stm32@gmail.com, digetx@gmail.com, lee.jones@linaro.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        devicetree@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-tegra@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 8/8] ARM: dts: Add stmpe-adc DT node to Toradex T30 modules
Date:   Wed,  9 Jan 2019 14:42:07 +0100
Message-Id: <20190109134208.5660-9-dev@pschenker.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109134208.5660-1-dev@pschenker.ch>
References: <20190109134208.5660-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Add the stmpe-adc DT node as found on Toradex T30 modules

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v6:
 - Just realized that the comment for st,norequest-mask was at the wrong
   place, fixed.
 - Added also tegra30-apalis-v1.1.dtsi, as I forgot that.

Changes in v5: None
Changes in v4:
 - New separate commit to hold T30 devicetree changes

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi | 22 ++++++++++++++--------
 arch/arm/boot/dts/tegra30-apalis.dtsi      | 22 ++++++++++++++--------
 arch/arm/boot/dts/tegra30-colibri.dtsi     | 22 ++++++++++++++--------
 3 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
index 02f8126481a2..8b7a827d604d 100644
--- a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
@@ -994,11 +994,17 @@
 			id = <0>;
 			blocks = <0x5>;
 			irq-trigger = <0x1>;
+			/* 3.25 MHz ADC clock speed */
+			st,adc-freq = <1>;
+			/* 12-bit ADC */
+			st,mod-12b = <1>;
+			/* internal ADC reference */
+			st,ref-sel = <0>;
+			/* ADC converstion time: 80 clocks */
+			st,sample-time = <4>;
 
 			stmpe_touchscreen {
 				compatible = "st,stmpe-ts";
-				/* 3.25 MHz ADC clock speed */
-				st,adc-freq = <1>;
 				/* 8 sample average control */
 				st,ave-ctrl = <3>;
 				/* 7 length fractional part in z */
@@ -1008,17 +1014,17 @@
 				 * current limit value
 				 */
 				st,i-drive = <1>;
-				/* 12-bit ADC */
-				st,mod-12b = <1>;
-				/* internal ADC reference */
-				st,ref-sel = <0>;
-				/* ADC converstion time: 80 clocks */
-				st,sample-time = <4>;
 				/* 1 ms panel driver settling time */
 				st,settling = <3>;
 				/* 5 ms touch detect interrupt delay */
 				st,touch-det-delay = <5>;
 			};
+
+			stmpe_adc {
+				compatible = "st,stmpe-adc";
+				/* forbid to use ADC channels 3-0 (touch) */
+				st,norequest-mask = <0x0F>;
+			};
 		};
 
 		/*
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 7f112f192fe9..c18f6f61d764 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -976,11 +976,17 @@
 			id = <0>;
 			blocks = <0x5>;
 			irq-trigger = <0x1>;
+			/* 3.25 MHz ADC clock speed */
+			st,adc-freq = <1>;
+			/* 12-bit ADC */
+			st,mod-12b = <1>;
+			/* internal ADC reference */
+			st,ref-sel = <0>;
+			/* ADC converstion time: 80 clocks */
+			st,sample-time = <4>;
 
 			stmpe_touchscreen {
 				compatible = "st,stmpe-ts";
-				/* 3.25 MHz ADC clock speed */
-				st,adc-freq = <1>;
 				/* 8 sample average control */
 				st,ave-ctrl = <3>;
 				/* 7 length fractional part in z */
@@ -990,17 +996,17 @@
 				 * current limit value
 				 */
 				st,i-drive = <1>;
-				/* 12-bit ADC */
-				st,mod-12b = <1>;
-				/* internal ADC reference */
-				st,ref-sel = <0>;
-				/* ADC converstion time: 80 clocks */
-				st,sample-time = <4>;
 				/* 1 ms panel driver settling time */
 				st,settling = <3>;
 				/* 5 ms touch detect interrupt delay */
 				st,touch-det-delay = <5>;
 			};
+
+			stmpe_adc {
+				compatible = "st,stmpe-adc";
+				/* forbid to use ADC channels 3-0 (touch) */
+				st,norequest-mask = <0x0F>;
+			};
 		};
 
 		/*
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 35af03ca9e90..1f9198bb24ff 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -845,11 +845,18 @@
 			id = <0>;
 			blocks = <0x5>;
 			irq-trigger = <0x1>;
+			/* 3.25 MHz ADC clock speed */
+			st,adc-freq = <1>;
+			/* 12-bit ADC */
+			st,mod-12b = <1>;
+			/* internal ADC reference */
+			st,ref-sel = <0>;
+			/* ADC converstion time: 80 clocks */
+			st,sample-time = <4>;
+			/* forbid to use ADC channels 3-0 (touch) */
 
 			stmpe_touchscreen {
 				compatible = "st,stmpe-ts";
-				/* 3.25 MHz ADC clock speed */
-				st,adc-freq = <1>;
 				/* 8 sample average control */
 				st,ave-ctrl = <3>;
 				/* 7 length fractional part in z */
@@ -859,17 +866,16 @@
 				 * current limit value
 				 */
 				st,i-drive = <1>;
-				/* 12-bit ADC */
-				st,mod-12b = <1>;
-				/* internal ADC reference */
-				st,ref-sel = <0>;
-				/* ADC converstion time: 80 clocks */
-				st,sample-time = <4>;
 				/* 1 ms panel driver settling time */
 				st,settling = <3>;
 				/* 5 ms touch detect interrupt delay */
 				st,touch-det-delay = <5>;
 			};
+
+			stmpe_adc {
+				compatible = "st,stmpe-adc";
+				st,norequest-mask = <0x0F>;
+			};
 		};
 
 		/*
-- 
2.20.1

