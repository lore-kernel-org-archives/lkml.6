Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2953DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD4B2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="haeWqJJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfARBG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 20:06:58 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:32858 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfARBG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 20:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1547773614; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JXr4LrdpYrvbx6eqNgw1hYdipnO5Jw08K5hEj1tp7cs=;
        b=haeWqJJrrw5/ze4APaWsqVx+Ht3IC47cloF8H4GC1gE9a2F9Ra4hyprH+dlJUbXcjLKn+Q
        XJAJvXqi5Zi6uf5DIfzgAyg2XusuB6fQ9avxQNl0JFkgXeNvFb9fk9OD4izZ3g5VlL6ZgA
        hVFqLHMFTJtV+jKnTgMRAdEu1t+4/Zc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/8] dt-bindings: mtd: ingenic: Add compatible strings for the JZ4725B
Date:   Thu, 17 Jan 2019 22:06:28 -0300
Message-Id: <20190118010634.27399-2-paul@crapouillou.net>
In-Reply-To: <20190118010634.27399-1-paul@crapouillou.net>
References: <20190118010634.27399-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible strings to probe the jz4780-nand and jz4780-bch drivers
from devicetree on the JZ4725B SoC from Ingenic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
index 29ea5853ca91..8ebed442ac55 100644
--- a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
@@ -6,7 +6,9 @@ memory-controllers/ingenic,jz4780-nemc.txt), and thus NAND device nodes must
 be children of the NEMC node.
 
 Required NAND controller device properties:
-- compatible: Should be set to "ingenic,jz4780-nand".
+- compatible: Should be one of:
+  * ingenic,jz4725b-nand
+  * ingenic,jz4780-nand
 - reg: For each bank with a NAND chip attached, should specify a bank number,
   an offset of 0 and a size of 0x1000000 (i.e. the whole NEMC bank).
 
@@ -72,7 +74,9 @@ NAND devices. The following is a description of the device properties for a
 BCH controller.
 
 Required BCH properties:
-- compatible: Should be set to "ingenic,jz4780-bch".
+- compatible: Should be one of:
+  * ingenic,jz4725b-bch
+  * ingenic,jz4780-bch
 - reg: Should specify the BCH controller registers location and length.
 - clocks: Clock for the BCH controller.
 
-- 
2.11.0

