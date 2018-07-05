Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB07C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1532156B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1532156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754158AbeGEPPB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:15:01 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:47871 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754378AbeGEPO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:14:57 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w65F4RKT023275;
        Thu, 5 Jul 2018 17:14:27 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2k0dr4hrxn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 17:14:27 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DE6563A;
        Thu,  5 Jul 2018 15:14:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BC57126DC;
        Thu,  5 Jul 2018 15:14:23 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 5 Jul
 2018 17:14:23 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 5 Jul 2018 17:14:23 +0200
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
Subject: [PATCH 3/8] dt-bindings: regulator: document stpmu1 pmic regulators
Thread-Topic: [PATCH 3/8] dt-bindings: regulator: document stpmu1 pmic
 regulators
Thread-Index: AQHUFHLawd6akLRFR0aIjrL33ybRIw==
Date:   Thu, 5 Jul 2018 15:14:23 +0000
Message-ID: <1530803657-17684-4-git-send-email-p.paillet@st.com>
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

The STPMU1 regulators supply power to the application processor as well as
to the external system peripherals such as DDR, Flash memories and system
devices.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
 .../bindings/regulator/st,stpmu1-regulator.txt     | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stpmu1-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/st,stpmu1-regulator.txt b/Documentation/devicetree/bindings/regulator/st,stpmu1-regulator.txt
new file mode 100644
index 0000000..888e759
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/st,stpmu1-regulator.txt
@@ -0,0 +1,72 @@
+STMicroelectronics STPMU1 Voltage regulators
+
+Regulator Nodes are optional depending on needs.
+
+Available Regulators in STPMU1 device are:
+  - buck1 for Buck BUCK1
+  - buck2 for Buck BUCK2
+  - buck3 for Buck BUCK3
+  - buck4 for Buck BUCK4
+  - ldo1 for LDO LDO1
+  - ldo2 for LDO LDO2
+  - ldo3 for LDO LDO3
+  - ldo4 for LDO LDO4
+  - ldo5 for LDO LDO5
+  - ldo6 for LDO LDO6
+  - vref_ddr for LDO Vref DDR
+  - boost for Buck BOOST
+  - pwr_sw1 for VBUS_OTG switch
+  - pwr_sw2 for SW_OUT switch
+
+Switches are fixed voltage regulators with only enable/disable capability.
+
+Optional properties:
+- st,mask_reset: stay on during Reset for particular regulator
+- regulator-pull-down: enable high pull down
+  if not specified light pull down is used
+- regulator-over-current-protection:
+    if set, all regulators are switched off in case of over-current detection
+    on this regulator,
+    if not set, the driver only send an over-current event.
+- interrupt-parent: phandle to the parent interrupt controller
+- interrupts: index of current limit detection interrupt
+- <regulator>-supply: phandle to the parent supply/regulator node
+	each regulator supply can be described except vref_ddr.
+
+Example:
+regulators {
+	compatible = "st,stpmu1-regulators";
+
+	ldo6-supply = <&v3v3>;
+
+	vdd_core: regulator@0 {
+		regulator-compatible = "buck1";
+		regulator-name = "vdd_core";
+		interrupts = <IT_CURLIM_BUCK1 0>;
+		interrupt-parent = <&pmic>;
+		st,mask_reset;
+		regulator-pull-down;
+		st,pulldown_config = <2>;
+		regulator-min-microvolt = <700000>;
+		regulator-max-microvolt = <1200000>;
+	};
+
+	v3v3: buck4 {
+		regulator-compatible = "buck4";
+		regulator-name = "v3v3";
+		interrupts = <IT_CURLIM_BUCK4 0>;
+		interrupt-parent = <&mypmic>;
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	v1v8: ldo6 {
+		regulator-compatible = "ldo6";
+		regulator-name = "v1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-over-current-protection;
+	};
+
+};
-- 
1.9.1
