Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042DDC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6382098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6382098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeJCWBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:01:01 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:31694 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726811AbeJCWBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:01:00 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w93EwM52010568;
        Wed, 3 Oct 2018 17:11:24 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2msxh6qmma-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 03 Oct 2018 17:11:24 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EEAC63D;
        Wed,  3 Oct 2018 15:11:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CBF954E65;
        Wed,  3 Oct 2018 15:11:23 +0000 (GMT)
Received: from localhost (10.75.127.46) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 3 Oct 2018 17:11:23
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@st.com>
Subject: [PATCH 1/3] ARM: dts: stm32: Add dmas to timer on stm32mp157c
Date:   Wed, 3 Oct 2018 17:11:03 +0200
Message-ID: <1538579465-7854-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538579465-7854-1-git-send-email-fabrice.gasnier@st.com>
References: <1538579465-7854-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-03_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DMAs to enable PWM input capture using STM32 timers on stm32mp157c.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 58 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 661be94..17a748f 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -98,6 +98,12 @@
 			reg = <0x40000000 0x400>;
 			clocks = <&rcc TIM2_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 18 0x400 0x1>,
+			       <&dmamux1 19 0x400 0x1>,
+			       <&dmamux1 20 0x400 0x1>,
+			       <&dmamux1 21 0x400 0x1>,
+			       <&dmamux1 22 0x400 0x1>;
+			dma-names = "ch1", "ch2", "ch3", "ch4", "up";
 			status = "disabled";
 
 			pwm {
@@ -119,6 +125,13 @@
 			reg = <0x40001000 0x400>;
 			clocks = <&rcc TIM3_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 23 0x400 0x1>,
+			       <&dmamux1 24 0x400 0x1>,
+			       <&dmamux1 25 0x400 0x1>,
+			       <&dmamux1 26 0x400 0x1>,
+			       <&dmamux1 27 0x400 0x1>,
+			       <&dmamux1 28 0x400 0x1>;
+			dma-names = "ch1", "ch2", "ch3", "ch4", "up", "trig";
 			status = "disabled";
 
 			pwm {
@@ -140,6 +153,11 @@
 			reg = <0x40002000 0x400>;
 			clocks = <&rcc TIM4_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 29 0x400 0x1>,
+			       <&dmamux1 30 0x400 0x1>,
+			       <&dmamux1 31 0x400 0x1>,
+			       <&dmamux1 32 0x400 0x1>;
+			dma-names = "ch1", "ch2", "ch3", "ch4";
 			status = "disabled";
 
 			pwm {
@@ -161,6 +179,13 @@
 			reg = <0x40003000 0x400>;
 			clocks = <&rcc TIM5_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 55 0x400 0x1>,
+			       <&dmamux1 56 0x400 0x1>,
+			       <&dmamux1 57 0x400 0x1>,
+			       <&dmamux1 58 0x400 0x1>,
+			       <&dmamux1 59 0x400 0x1>,
+			       <&dmamux1 60 0x400 0x1>;
+			dma-names = "ch1", "ch2", "ch3", "ch4", "up", "trig";
 			status = "disabled";
 
 			pwm {
@@ -182,6 +207,8 @@
 			reg = <0x40004000 0x400>;
 			clocks = <&rcc TIM6_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 69 0x400 0x1>;
+			dma-names = "up";
 			status = "disabled";
 
 			timer@5 {
@@ -198,6 +225,8 @@
 			reg = <0x40005000 0x400>;
 			clocks = <&rcc TIM7_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 70 0x400 0x1>;
+			dma-names = "up";
 			status = "disabled";
 
 			timer@6 {
@@ -465,6 +494,15 @@
 			reg = <0x44000000 0x400>;
 			clocks = <&rcc TIM1_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 11 0x400 0x1>,
+			       <&dmamux1 12 0x400 0x1>,
+			       <&dmamux1 13 0x400 0x1>,
+			       <&dmamux1 14 0x400 0x1>,
+			       <&dmamux1 15 0x400 0x1>,
+			       <&dmamux1 16 0x400 0x1>,
+			       <&dmamux1 17 0x400 0x1>;
+			dma-names = "ch1", "ch2", "ch3", "ch4",
+				    "up", "trig", "com";
 			status = "disabled";
 
 			pwm {
@@ -486,6 +524,15 @@
 			reg = <0x44001000 0x400>;
 			clocks = <&rcc TIM8_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 47 0x400 0x1>,
+			       <&dmamux1 48 0x400 0x1>,
+			       <&dmamux1 49 0x400 0x1>,
+			       <&dmamux1 50 0x400 0x1>,
+			       <&dmamux1 51 0x400 0x1>,
+			       <&dmamux1 52 0x400 0x1>,
+			       <&dmamux1 53 0x400 0x1>;
+			dma-names = "ch1", "ch2", "ch3", "ch4",
+				    "up", "trig", "com";
 			status = "disabled";
 
 			pwm {
@@ -543,6 +590,11 @@
 			reg = <0x44006000 0x400>;
 			clocks = <&rcc TIM15_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 105 0x400 0x1>,
+			       <&dmamux1 106 0x400 0x1>,
+			       <&dmamux1 107 0x400 0x1>,
+			       <&dmamux1 108 0x400 0x1>;
+			dma-names = "ch1", "up", "trig", "com";
 			status = "disabled";
 
 			pwm {
@@ -564,6 +616,9 @@
 			reg = <0x44007000 0x400>;
 			clocks = <&rcc TIM16_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 109 0x400 0x1>,
+			       <&dmamux1 110 0x400 0x1>;
+			dma-names = "ch1", "up";
 			status = "disabled";
 
 			pwm {
@@ -584,6 +639,9 @@
 			reg = <0x44008000 0x400>;
 			clocks = <&rcc TIM17_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 111 0x400 0x1>,
+			       <&dmamux1 112 0x400 0x1>;
+			dma-names = "ch1", "up";
 			status = "disabled";
 
 			pwm {
-- 
1.9.1

