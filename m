Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3120DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E094C2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E094C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbeIFNiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:38:51 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38562 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727629AbeIFNiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:38:51 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w868xG7K007329;
        Thu, 6 Sep 2018 11:03:44 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2macwsdsqc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 06 Sep 2018 11:03:44 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BB63A31;
        Thu,  6 Sep 2018 09:03:43 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8E8F626ED;
        Thu,  6 Sep 2018 09:03:43 +0000 (GMT)
Received: from localhost (10.75.127.49) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 6 Sep 2018 11:03:43
 +0200
From:   <patrice.chotard@st.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <patrice.chotard@st.com>,
        Christophe Priouzeau <christophe.priouzeau@st.com>
Subject: [PATCH] ARM: dts: stih410: change syntax of multiple DAI
Date:   Thu, 6 Sep 2018 11:03:31 +0200
Message-ID: <1536224611-30979-1-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Priouzeau <christophe.priouzeau@st.com>

With change of syntax for 'simple-audio-card,dai-link' containers,
devicetrees of stih410 must be updated.

This fixes the following error:

[    3.839466] asoc-simple-card sound: asoc_simple_card_dai_link_of:
Can't find simple-audio-card,cpu DT node
[    3.849150] asoc-simple-card sound: parse error -22

Signed-off-by: Christophe Priouzeau <christophe.priouzeau@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih410-b2260.dts  |  5 ++++-
 arch/arm/boot/dts/stihxxx-b2120.dtsi | 11 ++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index 155caa8..4ee6d51 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -61,8 +61,11 @@
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "STI-B2260";
 		status = "okay";
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-		simple-audio-card,dai-link0 {
+		simple-audio-card,dai-link@0 {
+			reg = <0>;
 			/* DAC */
 			format = "i2s";
 			mclk-fs = <128>;
diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 4dedfcb..97e05f5 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -27,8 +27,11 @@
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "STI-B2120";
 		status = "okay";
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-		simple-audio-card,dai-link0 {
+		simple-audio-card,dai-link@0 {
+			reg = <0>;
 			/* HDMI */
 			format = "i2s";
 			mclk-fs = <128>;
@@ -41,7 +44,8 @@
 			};
 		};
 
-		simple-audio-card,dai-link1 {
+		simple-audio-card,dai-link@1 {
+			reg = <1>;
 			/* DAC */
 			format = "i2s";
 			mclk-fs = <256>;
@@ -55,7 +59,8 @@
 			};
 		};
 
-		simple-audio-card,dai-link2 {
+		simple-audio-card,dai-link@2 {
+			reg = <2>;
 			/* SPDIF */
 			format = "left_j";
 			mclk-fs = <128>;
-- 
1.9.1

