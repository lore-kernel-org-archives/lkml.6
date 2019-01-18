Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FF5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B14620883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547830404;
	bh=6xvQ4qOWdRutSL+7zqipIpTx5vXa8M+gYj6rbDvREYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y9h6jRHJX/iKILz7iALruDz695egBBT8BFtdP5QkMa8l5oa051U9MZ5BggmRM/460
	 i56VjfxoTejmzorramma5Sr0k2Gzpw+FX8xJLmwPbmY3sKlq3bcFlwIMeTD3acS8L4
	 iaCtRm8jOJCCuvNS4v3H5asmTix3jkPMXx8VMOSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfARQxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:53:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:56418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbfARQxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:53:22 -0500
Received: from localhost.localdomain (unknown [218.0.237.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1890208E4;
        Fri, 18 Jan 2019 16:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547830401;
        bh=6xvQ4qOWdRutSL+7zqipIpTx5vXa8M+gYj6rbDvREYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bASVZK+8lpsPQHeHuUOFbz05Nzi4dUuDDQMQg7YGoujBAcyHeP8Nn/9cjchw5c2O5
         7n45dhxFwbl9oQZOIGE/Pzq2Jb75W38if7ug6JVXXpi7P7fEZUkxteHWJVaICT3Mj4
         CE6gaDKYi1ScWtCimoqu79nyFXlUyXtApxTHVzcs=
From:   guoren@kernel.org
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        guoren@kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 2/2] dt-bindings: interrupt-controller: Update csky mpintc
Date:   Sat, 19 Jan 2019 00:52:51 +0800
Message-Id: <1547830371-22122-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547830371-22122-1-git-send-email-guoren@kernel.org>
References: <1547830371-22122-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Add trigger type and priority setting for csky,mpintc.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 .../bindings/interrupt-controller/csky,mpintc.txt  | 33 +++++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
index ab921f1..badbd38 100644
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
@@ -26,15 +33,33 @@ intc node bindings definition
 	- #interrupt-cells
 		Usage: required
 		Value type: <u32>
-		Definition: must be <1>
+		Definition: could be <1> or <2> or <3>
 	- interrupt-controller:
 		Usage: required
 
-Examples:
+Examples: ("interrupts = <irq IRQ_TYPE_XXX priority>")
 ---------
 
 	intc: interrupt-controller {
 		compatible = "csky,mpintc";
-		#interrupt-cells = <1>;
+		#interrupt-cells = <3>;
 		interrupt-controller;
 	};
+
+	0: device-example0 {
+		...
+		interrupts = <33>;
+		interrupt-parent = <&intc>;
+	};
+
+	1: device-example1 {
+		...
+		interrupts = <33 IRQ_TYPE_EDGE_RISING>;
+		interrupt-parent = <&intc>;
+	};
+
+	2: device-example2 {
+		...
+		interrupts = <34 IRQ_TYPE_EDGE_RISING 254>;
+		interrupt-parent = <&intc>;
+	};
-- 
2.7.4

