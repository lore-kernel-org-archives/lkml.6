Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22CCC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4AF218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="LHxLZ115"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfBITX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 14:23:29 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:42158 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbfBITX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 14:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549740206; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1Li8TtRZ4NvB0BMR9KYjNdauVthk5yMzr9pBydX64Ag=;
        b=LHxLZ115WHp+AC7BoJHhNW0OK59Ma8tBV3alTKobOkrNkkajsjQqIFNyUY3c8Bp+hrtb49
        qinUqIAxKgXmo4oI+ByyPmRIA3E278HRt9Do1lqTFTf55KdrSukXQaVFpqKepHqqHZwBpU
        jrp0yAtERJ1Nfv3KPEXLULEz6DJOeSk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 2/9] dt-bindings: mtd: ingenic: Change 'BCH' to 'ECC' in documentation
Date:   Sat,  9 Feb 2019 16:22:58 -0300
Message-Id: <20190209192305.4434-2-paul@crapouillou.net>
In-Reply-To: <20190209192305.4434-1-paul@crapouillou.net>
References: <20190209192305.4434-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The JZ4740 ECC hardware is not BCH but Reed-Solomon, so it makes more
sense to use the more generic ECC term.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v3: New patch

v4: No change

 .../devicetree/bindings/mtd/ingenic,jz4780-nand.txt    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
index a5b940f18bf6..5a45cc54f46d 100644
--- a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
@@ -1,4 +1,4 @@
-* Ingenic JZ4780 NAND/BCH
+* Ingenic JZ4780 NAND/ECC
 
 This file documents the device tree bindings for NAND flash devices on the
 JZ4780. NAND devices are connected to the NEMC controller (described in
@@ -14,10 +14,10 @@ Required NAND controller device properties:
   an offset of 0 and a size of 0x1000000 (i.e. the whole NEMC bank).
 
 Optional NAND controller device properties:
-- ingenic,bch-controller: To make use of the hardware BCH controller, this
-  property must contain a phandle for the BCH controller node. The required
+- ingenic,bch-controller: To make use of the hardware ECC controller, this
+  property must contain a phandle for the ECC controller node. The required
   properties for this node are described below. If this is not specified,
-  software BCH will be used instead.
+  software ECC will be used instead.
 
 Optional children nodes:
 - Individual NAND chips are children of the NAND controller node.
@@ -70,17 +70,17 @@ nemc: nemc@13410000 {
 	};
 };
 
-The BCH controller is a separate SoC component used for error correction on
+The ECC controller is a separate SoC component used for error correction on
 NAND devices. The following is a description of the device properties for a
-BCH controller.
+ECC controller.
 
-Required BCH properties:
+Required ECC properties:
 - compatible: Should be one of:
   * ingenic,jz4740-ecc
   * ingenic,jz4725b-bch
   * ingenic,jz4780-bch
-- reg: Should specify the BCH controller registers location and length.
-- clocks: Clock for the BCH controller.
+- reg: Should specify the ECC controller registers location and length.
+- clocks: Clock for the ECC controller.
 
 Example:
 
-- 
2.11.0

