Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2DAC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08662082B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08662082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeH2H2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 03:28:53 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54738 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725199AbeH2H2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 03:28:53 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3AD181A0154;
        Wed, 29 Aug 2018 05:34:08 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3BEC11A002D;
        Wed, 29 Aug 2018 05:34:00 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1A2C0402AE;
        Wed, 29 Aug 2018 11:33:50 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     yinbo.zhu@nxp.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ran Wang <ran.wang_1@nxp.com>, linux-kernel@vger.kernel.org
Cc:     xiaobo.xie@nxp.com, Shawn Guo <shawnguo@kernel.org>,
        Minghuan Lian <Minghuan.Lian@nxp.com>,
        Yuantian Tang <andy.tang@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Changming Huang <jerry.huang@nxp.com>,
        Sumit Garg <sumit.garg@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rajesh Bhagat <rajesh.bhagat@freescale.com>
Subject: [PATCH v2] arm64: dts: ls1043a: Add configure-gfladj property to USB3 node
Date:   Wed, 29 Aug 2018 11:30:55 +0800
Message-Id: <20180829033055.22245-1-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajesh Bhagat <rajesh.bhagat@freescale.com>

Add "configure-gfladj" boolean property to USB3 node. This property
is used to determine whether frame length adjustment is required or
not

Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
Change in v2:
		Modified some word misspellings in commit information

 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 7881e3d..ed3fa79 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -609,6 +609,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			configure-gfladj;
 		};
 
 		usb1: usb3@3000000 {
@@ -618,6 +619,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			configure-gfladj;
 		};
 
 		usb2: usb3@3100000 {
@@ -627,6 +629,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			configure-gfladj;
 		};
 
 		sata: sata@3200000 {
-- 
1.7.1

