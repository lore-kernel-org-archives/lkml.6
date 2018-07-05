Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD464C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887AF2156B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887AF2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754338AbeGEPOv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:14:51 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:57377 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754004AbeGEPOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:14:47 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w65F9FVj017072;
        Thu, 5 Jul 2018 17:14:23 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2k1k1j0twu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 17:14:23 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E543D34;
        Thu,  5 Jul 2018 15:14:22 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B1CEC26DC;
        Thu,  5 Jul 2018 15:14:22 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 5 Jul
 2018 17:14:22 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 5 Jul 2018 17:14:22 +0200
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
CC:     Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH 1/8] dt-bindings: mfd: document stpmu1 pmic
Thread-Topic: [PATCH 1/8] dt-bindings: mfd: document stpmu1 pmic
Thread-Index: AQHUFHLaBR9//vlFr0qcgonUrwaf9A==
Date:   Thu, 5 Jul 2018 15:14:22 +0000
Message-ID: <1530803657-17684-2-git-send-email-p.paillet@st.com>
References: <1530803657-17684-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1530803657-17684-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: pascal paillet <p.paillet@st.com>

stpmu1 is a pmic from STMicroelectronics. The stpmu1 integrates 10
regulators and 3 switches with various capabilities.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
 .../devicetree/bindings/mfd/st,stpmu1.txt          | 138 +++++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmu1.txt

diff --git a/Documentation/devicetree/bindings/mfd/st,stpmu1.txt b/Documentation/devicetree/bindings/mfd/st,stpmu1.txt
new file mode 100644
index 0000000..53bdab4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/st,stpmu1.txt
@@ -0,0 +1,138 @@
+* STMicroelectronics STPMU1 Power Management IC
+
+Required parent device properties:
+- compatible: "st,stpmu1"
+- reg: the I2C slave address for the stpmu1 chip
+- interrupts-extended: interrupt lines to use: second irq is for wakeup.
+- #interrupt-cells: should be 2.
+- interrupt-controller: describes the STPMU1 as an interrupt
+  controller (has its own domain). interrupt number are the following:
+	/* Interrupt Register 1 (0x50 for latch) */
+	IT_SWOUT_R=0
+	IT_SWOUT_F=1
+	IT_VBUS_OTG_R=2
+	IT_VBUS_OTG_F=3
+	IT_WAKEUP_R=4
+	IT_WAKEUP_F=5
+	IT_PONKEY_R=6
+	IT_PONKEY_F=7
+	/* Interrupt Register 2 (0x51 for latch) */
+	IT_OVP_BOOST=8
+	IT_OCP_BOOST=9
+	IT_OCP_SWOUT=10
+	IT_OCP_OTG=11
+	IT_CURLIM_BUCK4=12
+	IT_CURLIM_BUCK3=13
+	IT_CURLIM_BUCK2=14
+	IT_CURLIM_BUCK1=15
+	/* Interrupt Register 3 (0x52 for latch) */
+	IT_SHORT_SWOUT=16
+	IT_SHORT_SWOTG=17
+	IT_CURLIM_LDO6=18
+	IT_CURLIM_LDO5=19
+	IT_CURLIM_LDO4=20
+	IT_CURLIM_LDO3=21
+	IT_CURLIM_LDO2=22
+	IT_CURLIM_LDO1=23
+	/* Interrupt Register 3 (0x52 for latch) */
+	IT_SWIN_R=24
+	IT_SWIN_F=25
+	IT_RESERVED_1=26
+	IT_RESERVED_2=27
+	IT_VINLOW_R=28
+	IT_VINLOW_F=29
+	IT_TWARN_R=30
+	IT_TWARN_F=31
+
+Optional parent device properties:
+- st,main_control_register:
+	-bit 1: Power cycling will be performed on turn OFF condition
+	-bit 2: PWRCTRL is functional
+	-bit 3: PWRCTRL active high
+- st,pads_pull_register:
+	-bit 1: WAKEUP pull down is not active
+	-bit 2: PWRCTRL pull up is active
+	-bit 3: PWRCTRL pull down is active
+	-bit 4: WAKEUP detector is disabled
+- st,vin_control_register:
+	-bit 0: VINLOW monitoring is enabled
+	-bit [1...3]: VINLOW rising threshold
+		000 VINOK_f + 50mV
+		001 VINOK_f + 100mV
+		010 VINOK_f + 150mV
+		011 VINOK_f + 200mV
+		100 VINOK_f + 250mV
+		101 VINOK_f + 300mV
+		110 VINOK_f + 350mV
+		111 VINOK_f + 400mV
+	-bit [4...5]: VINLOW hyst
+		00 100mV
+		01 200mV
+		10 300mV
+		11 400mV
+	-bit 6: SW_OUT detector is disabled
+	-bit 7: SW_IN detector is enabled.
+- st,usb_control_register:
+	-bit 3: SW_OUT current limit
+		0: 600mA
+		1: 1.1A
+	-bit 4: VBUS_OTG discharge is enabled
+	-bit 5: SW_OUT discharge is enabled
+	-bit 6: VBUS_OTG detection is enabled
+	-bit 7: BOOST_OVP is disabled
+
+
+stpmu1 consists is a varied group of sub-devices:
+
+Device			 Description
+------			------------
+stpmu1-onkey		: On key
+stpmu1-regulators	: Regulators
+stpmu1-wdt		: Watchdog
+
+each sub-device bindings is be described in associated driver
+documentation section.
+
+Example:
+
+pmic: stpmu1@33 {
+	compatible = "st,stpmu1";
+	reg = <0x33>;
+	interrupts = <0 2>;
+	interrupts-extended = <&intc GIC_SPI 149 IRQ_TYPE_NONE>,
+			      <&exti 55 1>;
+	st,version_status = <0x10>;
+	st,main_control_register=<0x0c>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+	onkey {
+		compatible = "st,stpmu1-onkey";
+		interrupt-parent = <&pmic>;
+		interrupts = <7 0>,<6 1>;
+		st,onkey-pwroff-enabled;
+		st,onkey-press-seconds = <10>;
+	};
+
+	watchdog {
+		compatible = "st,stpmu1-wdt";
+	};
+
+	regulators {
+		compatible = "st,stpmu1-regulators";
+
+		vdd_core: regulator@0 {
+			regulator-compatible = "buck1";
+			regulator-name = "vdd_core";
+			regulator-boot-on;
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <1200000>;
+		};
+		vdd: regulator@1 {
+			regulator-compatible = "buck3";
+			regulator-name = "vdd";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+			regulator-pull-down;
+		};
+	};
-- 
1.9.1
