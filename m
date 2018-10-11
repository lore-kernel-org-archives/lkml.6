Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B239C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6609020841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6609020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbeJKRRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:17:23 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34406 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbeJKRRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:17:22 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2732E20002C;
        Thu, 11 Oct 2018 11:50:49 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5ABA820017B;
        Thu, 11 Oct 2018 11:50:43 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5CA9740326;
        Thu, 11 Oct 2018 17:50:36 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     vkoul@kernel.org, leoyang.li@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        dan.j.williams@intel.com, zw@zh-kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Peng Ma <peng.ma@nxp.com>
Subject: [PATCH 4/7] arm: dts: ls1021a: add qdma device tree nodes
Date:   Thu, 11 Oct 2018 17:46:52 +0800
Message-Id: <20181011094655.45707-4-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181011094655.45707-1-peng.ma@nxp.com>
References: <20181011094655.45707-1-peng.ma@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add the qDMA device tree nodes for LS1021A devices.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index f184905..abc50da 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -806,5 +806,21 @@
 			#size-cells = <1>;
 			ranges = <0x0 0x0 0x10010000 0x10000>;
 		};
+
+		qdma: qdma@8390000 {
+			compatible = "fsl,ls1021a-qdma";
+			reg = <0x0 0x8398000 0x0 0x1000>, /* Controller regs */
+			      <0x0 0x8399000 0x0 0x1000>, /* Status regs */
+			      <0x0 0x839a000 0x0 0x2000>; /* Block regs */
+			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "qdma-error", "qdma-queue";
+			channels = <8>;
+			queues = <2>;
+			status-sizes = <64>;
+			queue-sizes = <64 64>;
+			big-endian;
+		};
+
 	};
 };
-- 
1.7.1

