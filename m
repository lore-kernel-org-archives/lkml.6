Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BB0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F83208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F83208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeH1OGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:06:24 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37896 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbeH1OGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:06:24 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BCABF1A0156;
        Tue, 28 Aug 2018 12:15:26 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B914E1A011F;
        Tue, 28 Aug 2018 12:15:18 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 95ABF402B8;
        Tue, 28 Aug 2018 18:15:08 +0800 (SGT)
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
Subject: [PATCH v1] arm64: dts: ls1043a: Add configure-gfladj property to USB3 node
Date:   Tue, 28 Aug 2018 18:12:13 +0800
Message-Id: <20180828101213.25750-1-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajesh Bhagat <rajesh.bhagat@freescale.com>

Add "configure-gfladj" boolean property to USB3 node. This property
is used to determine whether frame length adjustent is required or
not

Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index a830a2e..a3c5165 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -610,6 +610,7 @@
 			snps,dis-u1u2-when-u3-quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			dma-coherent;
+			configure-gfladj;
 		};
 
 		usb1: usb3@3000000 {
@@ -623,6 +624,7 @@
 			snps,dis-u1u2-when-u3-quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			dma-coherent;
+			configure-gfladj;
 		};
 
 		usb2: usb3@3100000 {
@@ -636,6 +638,7 @@
 			snps,dis-u1u2-when-u3-quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			dma-coherent;
+			configure-gfladj;
 		};
 
 		sata: sata@3200000 {
-- 
1.7.1

