Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A89C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29D420873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbeLSJqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:46:19 -0500
Received: from inva020.nxp.com ([92.121.34.13]:37616 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728744AbeLSJqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:46:19 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EA2791A0364;
        Wed, 19 Dec 2018 10:46:17 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3E8BB1A034B;
        Wed, 19 Dec 2018 10:46:13 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 243B8402CA;
        Wed, 19 Dec 2018 17:46:07 +0800 (SGT)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH 2/2] arm: dts: ls1021a: Add incr-burst-byte-adjustment property to USB3 node
Date:   Wed, 19 Dec 2018 17:41:09 +0800
Message-Id: <20181219094109.3836-2-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181219094109.3836-1-ran.wang_1@nxp.com>
References: <20181219094109.3836-1-ran.wang_1@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add this property to improve USB read write performance.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index bdd6e66..f788a89 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -713,6 +713,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		pcie@3400000 {
-- 
1.7.1

