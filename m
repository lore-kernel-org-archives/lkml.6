Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09C6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7297F20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7297F20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=diehl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbeGXMrO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:47:14 -0400
Received: from enterprise03.smtp.diehl.com ([193.201.238.214]:31107 "EHLO
        enterprise03.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388256AbeGXMrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:47:13 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jul 2018 08:47:11 EDT
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.51,397,1526335200"; 
   d="scan'208";a="1739768"
From:   Denis OSTERLAND <denis.osterland@diehl.com>
To:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Denis OSTERLAND <denis.osterland@diehl.com>
Subject: [PATCH v5 5/5] rtc: isl1219: add device tree docu
Thread-Topic: [PATCH v5 5/5] rtc: isl1219: add device tree docu
Thread-Index: AQHUI0HYWBw2NLUC4U+pSoYH+IFvBg==
Date:   Tue, 24 Jul 2018 11:31:22 +0000
Message-ID: <20180724095437.6016-6-Denis.Osterland@diehl.com>
References: <20180724095437.6016-1-Denis.Osterland@diehl.com>
In-Reply-To: <20180724095437.6016-1-Denis.Osterland@diehl.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
MIME-Version: 1.0
X-TrailerSkip: 1
X-GBS-PROC: byQFdw3ukCM+zy1/poiPc3S+cPOwesVRp3YOtqJ1nLGzDTCHgOUEK+Oxjt5YvNJU
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Osterland <Denis.Osterland@diehl.com>

The devicetree documentation for the ISL1219 device tree
binding is added with an short example. It is not a trivial
device, because it supports two interrupt sources.

Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
---
 .../devicetree/bindings/rtc/isil,isl1219.txt  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1219.txt

diff --git a/Documentation/devicetree/bindings/rtc/isil,isl1219.txt b/Documentation/devicetree/bindings/rtc/isil,isl1219.txt
new file mode 100644
index 000000000000..c3efd48e91c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/isil,isl1219.txt
@@ -0,0 +1,29 @@
+Intersil ISL1219 I2C RTC/Alarm chip with event in
+
+ISL1219 has additional pins EVIN and #EVDET for tamper detection.
+
+Required properties supported by the device:
+
+ - "compatible": must be "isil,isl1219"
+ - "reg": I2C bus address of the device
+
+Optional properties:
+
+ - "interrupt-names": list which may contains "irq" and "evdet"
+ - "interrupts": list of interrupts for "irq" and "evdet"
+ - "isil,ev-evienb": if present EV.EVIENB bit is set to the specified
+                     value for proper operation.
+
+
+Example isl1219 node with #IRQ pin connected to SoC gpio1 pin12
+ and #EVDET pin connected to SoC gpio2 pin 24:
+
+	isl1219: rtc@68 {
+		compatible = "isil,isl1219";
+		reg = <0x68>;
+		interrupt-names = "irq", "evdet";
+		interrupts-extended = <&gpio1 12 IRQ_TYPE_EDGE_FALLING>,
+			<&gpio2 24 IRQ_TYPE_EDGE_FALLING>;
+		isil,ev-evienb = <1>;
+	};
+
-- 
2.18.0



Diehl Connectivity Solutions GmbH
Geschäftsführung: Horst Leonberger
Sitz der Gesellschaft: Nürnberg - Registergericht: Amtsgericht
Nürnberg: HRB 32315
___________________________________________________________________________________________________

Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht.
Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by
mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited. 
