Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3ADC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866452087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548764708;
	bh=FCgzsQ3/xoEcb54X4qxFqLCwiny/D5yEOWKuc8yVz6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NXts+IMuTXrXC4WlcwuEE1Ky5NlIl6WOzEer7Je9CTtTT5QJ3zjydzqeYsWkOxRvj
	 xbVSH9Y55bAuyWJoP9QanebvJjY6f/RB14zkJOU31yHBOyS6X/dL+SKHYbnUqSV/e3
	 NNdZ+/pvF/vUbHkvGdCVAv/lXXzXoucblIDutXJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfA2MZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:25:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbfA2MZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:25:06 -0500
Received: from localhost.localdomain (unknown [60.186.218.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A78D12087E;
        Tue, 29 Jan 2019 12:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548764705;
        bh=FCgzsQ3/xoEcb54X4qxFqLCwiny/D5yEOWKuc8yVz6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WxDTEk2IpirA+ialh8X6t8abdcs/KvvkWyB2Os/bEfn9O6A98X+1GXFXqoRgipXCH
         UQC4db51QrloJqsiCZEZ5PIK6OoBJApWUcZPgi6wmDwxcADzjFa12jm6UZnZzVJJ4Z
         FLj7+18hJVp7xKFgfiLzfhh9Ox2LA0K9ctjyJ2JE=
From:   guoren@kernel.org
To:     arnd@arndb.de, robh+dt@kernel.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 06/10] dt-bindings: interrupt-controller: Update csky mpintc
Date:   Tue, 29 Jan 2019 20:24:25 +0800
Message-Id: <1548764669-16656-6-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548764669-16656-1-git-send-email-guoren@kernel.org>
References: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Add trigger type and priority setting for csky,mpintc.

Changelog:
 - change #interrupt-cells to <3>

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
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

