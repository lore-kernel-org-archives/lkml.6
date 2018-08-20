Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFF1C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FD121581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EREIaQL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FD121581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeHUCSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 22:18:08 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37499 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbeHUCSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 22:18:08 -0400
Received: by mail-pl0-f68.google.com with SMTP id c6-v6so2986694pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 16:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:cc:from:to;
        bh=3FBCLPv8LOT78WtewumroIhDt5+9a/MxhbD75rsuI8w=;
        b=EREIaQL6tT6CpglwJAG0Wj0GdW5B1KArDkoGjRHM6LbdBq2bglFPPx6svpaEIhmApQ
         XIEAZTnwD9/knMdKFD5MVIKyOGi/tdc+NQ9jXxz61gUg/Ir0wY+Pi4b8QxJTbgW7YpyN
         5MObHAT3Me2eAQcXjlGJD6oKnfV+bSoc5NrdqecTfoXg6H6FAdkkDt82niRcWRXFloSy
         89qJGsbqRAsgI42Xx7U32xAMZSEM08qpaNQTQC8RJyIf9GHePnytu0CS6rkAyd3S2dZq
         g06yjNTMlaezdaxp2Qq4zSespeLfs+U1Xyc3KbqS9rperZExg5gC7Iuy2dSyzHJVM8E2
         A8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:cc:from:to;
        bh=3FBCLPv8LOT78WtewumroIhDt5+9a/MxhbD75rsuI8w=;
        b=bik7NETYx2M4B4n0dBKvoKZNIgDLc0AoY6pBGjccXSGLrI0Ze3ZqfzCxM8CqitTc0P
         VkFTkHUPBpfY0fI2Nb8TMBm2FbLJJuYzGZL35QS+uyUlOUg2A//cz3zrUG2BeibuR6U2
         TCnPFFbfjwn+E8N/xo/rUtjDOjEJFWUZ+ZOIuyUeTKfle2uP/fuh3Dwqd/38zQ0OCgKY
         yuBKAPF4FBSNsEJyCxt10hgi+90Ko47bCuYOqf/ErvyZ0bkdsfXoNN/Pr5Uunn4v2jeI
         rT6/4Luyppvi0BdPXv012a3ZrBDLlmccaXgYCIiLuD+5Vk/kf1FH/NjQqmQIUSzdelQX
         O5Mg==
X-Gm-Message-State: AOUpUlG8gLA3tPPcyb9GAIjXseITvNh/Dhums7F+DCEYkDwoCDjSAIvN
        aakqvzKBosYx/BycFEdpGdblEA==
X-Google-Smtp-Source: AA+uWPxPVpqonl7zE/gzKzTQuyA5jiWDRAvlvXmiaVInYk/Yhwsoe2zLWrCV+Z+ywEftjBiokbDNTw==
X-Received: by 2002:a17:902:2e01:: with SMTP id q1-v6mr47583863plb.40.1534806034213;
        Mon, 20 Aug 2018 16:00:34 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id v19-v6sm22222092pgn.94.2018.08.20.16.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 16:00:33 -0700 (PDT)
Subject: [PATCH] dt-bindings: riscv,cpu-intc: Cleanups from a missed review
Date:   Mon, 20 Aug 2018 16:00:11 -0700
Message-Id: <20180820230011.25368-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Karsten Merker <merker@debian.org>
From:   Palmer Dabbelt <palmer@sifive.com>
To:      linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I managed to miss one of Rob's code reviews on the mailing list
<http://lists.infradead.org/pipermail/linux-riscv/2018-August/001139.html>.
The patch has already been merged, so I'm submitting a fixup.

Sorry!

Fixes: b67bc7cb4088 ("dt-bindings: interrupt-controller: RISC-V local interrupt controller")
Cc: Rob Herring <robh@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Karsten Merker <merker@debian.org>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 .../bindings/interrupt-controller/riscv,cpu-intc.txt       | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
index b0a8af51c388..265b223cd978 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
@@ -11,7 +11,7 @@ The RISC-V supervisor ISA manual specifies three interrupt sources that are
 attached to every HLIC: software interrupts, the timer interrupt, and external
 interrupts.  Software interrupts are used to send IPIs between cores.  The
 timer interrupt comes from an architecturally mandated real-time timer that is
-controller via Supervisor Binary Interface (SBI) calls and CSR reads.  External
+controlled via Supervisor Binary Interface (SBI) calls and CSR reads.  External
 interrupts connect all other device interrupts to the HLIC, which are routed
 via the platform-level interrupt controller (PLIC).
 
@@ -25,7 +25,15 @@ in the system.
 
 Required properties:
 - compatible : "riscv,cpu-intc"
-- #interrupt-cells : should be <1>
+- #interrupt-cells : should be <1>.  The interrupt sources are defined by the
+  RISC-V supervisor ISA manual, with only the following three interrupts being
+  defined for supervisor mode:
+    - Source 1 is the supervisor software interrupt, which can be sent by an SBI
+      call and is reserved for use by software.
+    - Source 5 is the supervisor timer interrupt, which can be configured by
+      SBI calls and implements a one-shot timer.
+    - Source 9 is the supervisor external interrupt, which chains to all other
+      device interrupts.
 - interrupt-controller : Identifies the node as an interrupt controller
 
 Furthermore, this interrupt-controller MUST be embedded inside the cpu
@@ -38,7 +46,7 @@ An example device tree entry for a HLIC is show below.
 		...
 		cpu1-intc: interrupt-controller {
 			#interrupt-cells = <1>;
-			compatible = "riscv,cpu-intc", "sifive,fu540-c000-cpu-intc";
+			compatible = "sifive,fu540-c000-cpu-intc", "riscv,cpu-intc";
 			interrupt-controller;
 		};
 	};
-- 
2.16.4

