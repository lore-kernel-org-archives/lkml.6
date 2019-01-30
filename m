Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C647C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D6321473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbfA3QjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:39:15 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40648 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728377AbfA3QjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:39:14 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0UGQxRi005461;
        Wed, 30 Jan 2019 17:39:01 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2q8dw3aapn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 30 Jan 2019 17:39:01 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2D24338;
        Wed, 30 Jan 2019 16:39:01 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 06274A71D;
        Wed, 30 Jan 2019 16:39:01 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 30 Jan 2019 17:39:00
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <alexandre.torgue@st.com>
CC:     <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <fabrice.gasnier@st.com>, <lionel.debieve@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] dt-bindings: nvmem: Add STM32 factory-programmed romem
Date:   Wed, 30 Jan 2019 17:38:53 +0100
Message-ID: <1548866336-14765-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
References: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for STMicroelectronics STM32 Factory-programmed
read only memory area.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../devicetree/bindings/nvmem/st,stm32-romem.txt   | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt

diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
new file mode 100644
index 0000000..fbff52e
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
@@ -0,0 +1,31 @@
+STMicroelectronics STM32 Factory-programmed data device tree bindings
+
+This represents STM32 Factory-programmed read only non-volatile area: locked
+flash, OTP, read-only HW regs... This contains various information such as:
+analog calibration data for temperature sensor (e.g. TS_CAL1, TS_CAL2),
+internal vref (VREFIN_CAL), unique device ID...
+
+Required properties:
+- compatible:		Should be one of:
+			"st,stm32-romem"
+			"st,stm32mp15-bsec"
+- reg:			Offset and length of factory-programmed area.
+- #address-cells:	Should be '<1>'.
+- #size-cells:		Should be '<1>'.
+
+Optional Data cells:
+- Must be child nodes as described in nvmem.txt.
+
+Example on stm32f4:
+	romem: nvmem@1fff7800 {
+		compatible = "st,stm32-romem";
+		reg = <0x1fff7800 0x400>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/* Data cells: ts_cal1 at 0x1fff7a2c */
+		ts_cal1: calib@22c {
+			reg = <0x22c 0x2>;
+		};
+		...
+	};
-- 
1.9.1

