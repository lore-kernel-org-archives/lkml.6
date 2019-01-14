Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9B7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098D62086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfANOmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:42:51 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39821 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726678AbfANOmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:42:47 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0EEaRXf029846;
        Mon, 14 Jan 2019 15:42:42 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2pyby10gr9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 14 Jan 2019 15:42:42 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F3EFC31;
        Mon, 14 Jan 2019 14:42:41 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D4DCC53D0;
        Mon, 14 Jan 2019 14:42:41 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 14 Jan
 2019 15:42:41 +0100
Received: from localhost (10.201.20.122) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 14 Jan 2019 15:42:40
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <broonie@kernel.org>, <robh@kernel.org>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <loic.pallardy@st.com>,
        <benjamin.gaignard@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [RFC 4/7] devicetree: bindings: domainsctrl: Add STM32 ETZPC bindings
Date:   Mon, 14 Jan 2019 15:41:59 +0100
Message-ID: <20190114144202.27315-5-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190114144202.27315-1-benjamin.gaignard@st.com>
References: <20190114144202.27315-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe STM32 Extended TrustZone Protection bindings.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../devicetree/bindings/bus/domains/st,stm32-etzpc.txt     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/domains/st,stm32-etzpc.txt

diff --git a/Documentation/devicetree/bindings/bus/domains/st,stm32-etzpc.txt b/Documentation/devicetree/bindings/bus/domains/st,stm32-etzpc.txt
new file mode 100644
index 000000000000..8f0a990ab59c
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/domains/st,stm32-etzpc.txt
@@ -0,0 +1,14 @@
+STMicroelectronics STM32 Extended TrustZone Protection driver
+
+Required properties:
+ - compatible : must be "st,stm32-etzpc"
+ - reg : physical base address of the IP registers and length of memory
+         mapped region.
+ - #domainctrl-cells : must be 2
+
+Example:
+	etzpc@5c007000 {
+		compatible = "st,stm32-etzpc";
+		reg = <0x5c007000 0x400>;
+		#domainctrl-cells = <2>;
+	};
-- 
2.15.0

