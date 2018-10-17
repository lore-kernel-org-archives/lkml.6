Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38911C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EF72150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5EF72150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJQN6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:58:05 -0400
Received: from inva020.nxp.com ([92.121.34.13]:58708 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbeJQN6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 09:58:05 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B17AD1A01C4;
        Wed, 17 Oct 2018 08:04:03 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 615D81A01E2;
        Wed, 17 Oct 2018 08:03:57 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 19D5840326;
        Wed, 17 Oct 2018 14:03:46 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     vkoul@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, dan.j.williams@intel.com, zw@zh-kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Peng Ma <peng.ma@nxp.com>,
        Wen He <wen.he_1@nxp.com>
Subject: [v9 5/7] arm64: dts: ls1043a: add qdma device tree nodes
Date:   Wed, 17 Oct 2018 13:59:55 +0800
Message-Id: <20181017055957.542-5-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181017055957.542-1-peng.ma@nxp.com>
References: <20181017055957.542-1-peng.ma@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add the qDMA device tree nodes for LS1043A devices.

Signed-off-by: Wen He <wen.he_1@nxp.com>
Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
change in v9:
	- add interrupts for each virtual block 
	- add block-number
	- add block-offset

 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 7881e3d..e798c4c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -734,6 +734,28 @@
 					<0000 0 0 3 &gic 0 156 0x4>,
 					<0000 0 0 4 &gic 0 157 0x4>;
 		};
+
+		qdma: dma-controller@8380000 {
+			compatible = "fsl,ls1021a-qdma", "fsl,ls1043a-qdma";
+			reg = <0x0 0x8380000 0x0 0x1000>, /* Controller regs */
+			      <0x0 0x8390000 0x0 0x10000>, /* Status regs */
+			      <0x0 0x83a0000 0x0 0x40000>; /* Block regs */
+			interrupts = <0 153 0x4>,
+				     <0 39 0x4>,
+				     <0 40 0x4>,
+				     <0 41 0x4>,
+				     <0 42 0x4>;
+			interrupt-names = "qdma-error", "qdma-queue0",
+				"qdma-queue1", "qdma-queue2", "qdma-queue3";
+			dma-channels = <8>;
+			block-number = <1>;
+			block-offset = <0x10000>;
+			fsl,dma-queues = <2>;
+			status-sizes = <64>;
+			queue-sizes = <64 64>;
+			big-endian;
+		};
+
 	};
 
 	firmware {
-- 
1.7.1

