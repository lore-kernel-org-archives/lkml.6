Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E78C71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0F32089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aWPBO7FO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0F32089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeJOTvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:51:48 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43216 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726400AbeJOTvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:51:48 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9FC4sfZ015460;
        Mon, 15 Oct 2018 05:05:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=8S0yvpyTaF+hZAAs43LQRkviKi67EUXC99AchBod+6Y=;
 b=aWPBO7FOVlCkChHUFvCEj98a9kxa9K271he7ZRDfPLSOaIOjpFPB5R+PtlVnK4fzk0xQ
 zboaKXwW9U+Vysgcp6NWm7mlAfVNFvu1w3kZC+U/rGpU4PGTiHdKBrCDDKNeW7caxtRf
 EM+zQh7DNgLUqSehaF9Anqqd01/bNnO1nkWtYnkrh03WRusiNE+RjnpzFgI7ZEA5meZD
 FDjvvltbL9vMfnA1IM9+lzhbrtjNTWyZ0gR6m6NOr89JnGBdwRMh/jEjxGABgTtXvy8F
 0wlU/wdsOQe1xA/W+Y3ai466hx8z0yVuPoHuyKItTnqu4K+W58bs1o1XpyB/YVstJttU 8g== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2n4pmqgrf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 15 Oct 2018 05:05:55 -0700
Received: from IL-EXCH03.marvell.com (10.5.102.220) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Mon, 15 Oct
 2018 05:05:53 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by IL-EXCH03.marvell.com
 (10.5.102.220) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 15 Oct
 2018 15:05:36 +0300
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 15 Oct 2018 05:05:35 -0700
Received: from hannah.il.marvell.com (unknown [10.4.50.2])
        by maili.marvell.com (Postfix) with ESMTP id 2B74B3F703F;
        Mon, 15 Oct 2018 05:05:30 -0700 (PDT)
From:   <hannah@marvell.com>
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>, <corbet@lwn.net>,
        <joro@8bytes.org>, <robh+dt@kernel.org>,
        <gregory.clement@bootlin.com>, <mark.rutland@arm.com>,
        <jason@lakedaemon.net>, <andrew@lunn.ch>,
        <sebastian.hesselbarth@gmail.com>, <robin.murphy@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>, <nadavh@marvell.com>,
        <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>
Subject: [PATCH 4/4] arm64: dts: marvell: add smmu node for Armada-AP806
Date:   Mon, 15 Oct 2018 15:00:46 +0300
Message-ID: <1539604846-21151-5-git-send-email-hannah@marvell.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539604846-21151-1-git-send-email-hannah@marvell.com>
References: <1539604846-21151-1-git-send-email-hannah@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_08:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=576 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810150111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hanna Hawa <hannah@marvell.com>

Add SMMU node for Marvell Armada-AP806 SOC.

Signed-off-by: Hanna Hawa <hannah@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 176e38d..b5758b6 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -97,6 +97,23 @@
 				interrupts = <17>;
 			};
 
+			smmu: iommu@5000000 {
+				compatible = "marvell,mmu-500";
+				reg = <0x100000 0x100000>;
+				dma-coherent;
+				#iommu-cells = <1>;
+				#global-interrupts = <1>;
+				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			odmi: odmi@300000 {
 				compatible = "marvell,odmi-controller";
 				interrupt-controller;
-- 
1.9.1

