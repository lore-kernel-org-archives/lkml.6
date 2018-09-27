Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B12C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3B0215E5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3B0215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeI0R7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:59:36 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10023 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727292AbeI0R7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:59:10 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8RBY6U4003827;
        Thu, 27 Sep 2018 13:40:12 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mqd47qxp1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 27 Sep 2018 13:40:11 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5E1CE31;
        Thu, 27 Sep 2018 11:40:11 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 363D62986;
        Thu, 27 Sep 2018 11:40:11 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 27 Sep
 2018 13:40:11 +0200
Received: from localhost (10.201.20.5) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 27 Sep 2018 13:40:10 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v3 1/7] dt-bindings: mfd: Add ST Multi-Function eXpander (STMFX) core bindings
Date:   Thu, 27 Sep 2018 13:39:58 +0200
Message-ID: <1538048404-9041-2-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538048404-9041-1-git-send-email-amelie.delaunay@st.com>
References: <1538048404-9041-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-27_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation of device tree bindings for the
STMicroelectronics Multi-Function eXpander (STMFX) MFD core.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/mfd/stmfx.txt | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/stmfx.txt

diff --git a/Documentation/devicetree/bindings/mfd/stmfx.txt b/Documentation/devicetree/bindings/mfd/stmfx.txt
new file mode 100644
index 0000000..f0c2f7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/stmfx.txt
@@ -0,0 +1,28 @@
+STMicroelectonics Multi-Function eXpander (STMFX) Core bindings
+
+ST Multi-Function eXpander (STMFX) is a slave controller using I2C for
+communication with the main MCU. Its main features are GPIO expansion, main
+MCU IDD measurement (IDD is the amount of current that flows through VDD) and
+resistive touchscreen controller.
+
+Required properties:
+- compatible: should be "st,stmfx-0300".
+- reg: I2C slave address of the device.
+- interrupts: interrupt specifier triggered by MFX_IRQ_OUT signal.
+  Please refer to ../interrupt-controller/interrupt.txt
+
+Optional properties:
+- drive-open-drain: configure MFX_IRQ_OUT as open drain.
+- vdd-supply: phandle of the regulator supplying STMFX.
+
+Example:
+
+	stmfx: stmfx@42 {
+		compatible = "st,stmfx-0300";
+		reg = <0x42>;
+		interrupts = <8 IRQ_TYPE_EDGE_RISING>;
+		interrupt-parent = <&gpioi>;
+		vdd-supply = <&v3v3>;
+	};
+
+Please refer to ../pinctrl/pinctrl-stmfx.txt for STMFX GPIO expander function bindings.
-- 
2.7.4

