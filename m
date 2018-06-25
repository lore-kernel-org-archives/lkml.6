Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE487C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CF9246AC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CF9246AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbeFYPoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:44:04 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22687 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751381AbeFYPoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:44:01 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5PFdKXc018437;
        Mon, 25 Jun 2018 17:43:17 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2jtujuacc7-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 25 Jun 2018 17:43:17 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4D7A331;
        Mon, 25 Jun 2018 15:43:17 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 22E102872;
        Mon, 25 Jun 2018 15:43:17 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.94) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 25 Jun
 2018 17:43:17 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 25 Jun
 2018 17:43:16 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH V5 1/5] dt-bindings: watchdog: add stm32mp1 support
Date:   Mon, 25 Jun 2018 17:42:59 +0200
Message-ID: <1529941383-8653-2-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
References: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds support of stm32mp1.
stm32mp1 requires 2 clocks lsi and pclk.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 .../devicetree/bindings/watchdog/st,stm32-iwdg.txt          | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
index cc13b10a..d8f4430 100644
--- a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
+++ b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
@@ -2,9 +2,15 @@ STM32 Independent WatchDoG (IWDG)
 ---------------------------------
 
 Required properties:
-- compatible: "st,stm32-iwdg"
-- reg: physical base address and length of the registers set for the device
-- clocks: must contain a single entry describing the clock input
+- compatible: Should be either:
+  - "st,stm32-iwdg"
+  - "st,stm32mp1-iwdg"
+- reg: Physical base address and length of the registers set for the device
+- clocks: Reference to the clock entry lsi. Additional pclk clock entry
+  is required only for st,stm32mp1-iwdg.
+- clock-names: Name of the clocks used.
+  "lsi" for st,stm32-iwdg
+  "lsi", "pclk" for st,stm32mp1-iwdg
 
 Optional Properties:
 - timeout-sec: Watchdog timeout value in seconds.
@@ -15,5 +21,6 @@ iwdg: watchdog@40003000 {
 	compatible = "st,stm32-iwdg";
 	reg = <0x40003000 0x400>;
 	clocks = <&clk_lsi>;
+	clock-names = "lsi";
 	timeout-sec = <32>;
 };
-- 
2.7.4

