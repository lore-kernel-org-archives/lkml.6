Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DA5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D66A20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D66A20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbeK1Bzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:55:48 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:21389 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726435AbeK1Bzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:55:48 -0500
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 27 Nov 2018 23:57:36 +0900
Received: from vbox.ree.adwin.renesas.com (unknown [10.226.37.67])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3550E402A1E5;
        Tue, 27 Nov 2018 23:57:34 +0900 (JST)
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH] arm64: dts: alpine: Correct the GIC DT node name
Date:   Tue, 27 Nov 2018 14:57:31 +0000
Message-Id: <20181127145731.7283-1-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Harmless mistake, but it's incorrect. The DT spec provides recommendations
for the node names:
"The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming model. If appropriate, the
name should be one of the following choices:
...
interrupt-controller"

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm64/boot/dts/al/alpine-v2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/al/alpine-v2.dtsi b/arch/arm64/boot/dts/al/alpine-v2.dtsi
index 5b7bef684256..6f35bab10e9d 100644
--- a/arch/arm64/boot/dts/al/alpine-v2.dtsi
+++ b/arch/arm64/boot/dts/al/alpine-v2.dtsi
@@ -113,7 +113,7 @@
 				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		gic: gic@f0100000 {
+		gic: interrupt-controller@f0100000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0xf0200000 0x0 0x10000>,	/* GIC Dist */
 			      <0x0 0xf0280000 0x0 0x200000>,	/* GICR */
-- 
2.17.1

