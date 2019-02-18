Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F412C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FAF218DE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550455508;
	bh=bs1yuBsMRI84VDMJhOqHLUq4GlycWDijQGl4r3MgcYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TbdHcP9KFDKgr0OOhZ8pTD35gnj9KYJmmxhv/7uhTsePZ/eDSbCh36ayXn287DVSE
	 poxBuPwfsR1UFCpQz691KTv93lMFukdbCC6Ue3yrDU0Y2cVC2lQm8Nnm02dPWsurK8
	 o4Xtd8s1LBA3LrtuEjcepnjLI7PHMVRjkZ7/LLfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfBRCFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:05:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:53004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728317AbfBRCFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 21:05:03 -0500
Received: from localhost.localdomain (unknown [122.234.57.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B87C3218C3;
        Mon, 18 Feb 2019 02:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550455502;
        bh=bs1yuBsMRI84VDMJhOqHLUq4GlycWDijQGl4r3MgcYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ig3RvTyaRc7F2XPt0UD942pT5bMoeG0GHqETY4EVLKF0hsBvBrHj+14PovzMc+eqa
         mX69nQ8Q2wawcLO3ovnr+FN2xGpvDTw90d4Hjco1jEhNPKHQwTLGHBgL2wxpAf5thW
         z+iLHV3mLfiZLpYKa3BrNVLHxmpSK6jmNmYNY8Jc=
From:   guoren@kernel.org
To:     marc.zyngier@arm.com, tglx@linutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 5/7] dt-bindings: interrupt-controller: Update csky mpintc
Date:   Mon, 18 Feb 2019 10:04:41 +0800
Message-Id: <1550455483-11710-5-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550455483-11710-1-git-send-email-guoren@kernel.org>
References: <1550455483-11710-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Add trigger type and priority setting for csky,mpintc.

Changelog:
 - change #interrupt-cells to <3>

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 .../bindings/interrupt-controller/csky,mpintc.txt   | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
index ab921f1..dccd913 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
@@ -6,11 +6,18 @@ C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
 SMP soc, and it also could be used in non-SMP system.
 
 Interrupt number definition:
-
   0-15  : software irq, and we use 15 as our IPI_IRQ.
  16-31  : private  irq, and we use 16 as the co-processor timer.
  31-1024: common irq for soc ip.
 
+Interrupt triger mode:
+ IRQ_TYPE_LEVEL_HIGH (default)
+ IRQ_TYPE_LEVEL_LOW
+ IRQ_TYPE_EDGE_RISING
+ IRQ_TYPE_EDGE_FALLING
+
+Interrupt priority range: 0-255
+
 =============================
 intc node bindings definition
 =============================
@@ -26,15 +33,21 @@ intc node bindings definition
 	- #interrupt-cells
 		Usage: required
 		Value type: <u32>
-		Definition: must be <1>
+		Definition: <3>
 	- interrupt-controller:
 		Usage: required
 
-Examples:
+Examples: ("interrupts = <irq_num IRQ_TYPE_XXX priority>")
 ---------
 
 	intc: interrupt-controller {
 		compatible = "csky,mpintc";
-		#interrupt-cells = <1>;
+		#interrupt-cells = <3>;
 		interrupt-controller;
 	};
+
+	device: device-example {
+		...
+		interrupts = <34 IRQ_TYPE_EDGE_RISING 254>;
+		interrupt-parent = <&intc>;
+	};
-- 
2.7.4

