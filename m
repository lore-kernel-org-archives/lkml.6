Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A00C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C22B205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="u9Oxphti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C22B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeH3Bcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:32:41 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53184 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeH3BcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:32:09 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 16/18] MIPS: JZ4780: DTS: Update DMA node to match driver changes
Date:   Wed, 29 Aug 2018 23:32:58 +0200
Message-Id: <20180829213300.22829-17-paul@crapouillou.net>
In-Reply-To: <20180829213300.22829-1-paul@crapouillou.net>
References: <20180829213300.22829-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535578401; bh=+89+tAsgauTjZPoNWXUCE4GvHZ9D0R/Qb5ZaYzWIDwo=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=u9OxphtiYQ5/+M5u1xUdAIxGgj6mgl/cCHawuqflz/OeUpTeLI2ReiZIakJkj8LrZjo4/byqgfSnbAnInhsavdpMOuB5cdqPbgoQwvRXKopNquebCLoeP1ZUCgnHzZzCZe41hAXGs2cyKgiPpG61GKDI4Z9k/UypZRo9CBaZz3s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver now accepts two memory resources, the first one for the
channel-specific registers, the second one for the controller-specific
registers.

Note that older devicetrees, without this commit, will still work with
the jz4780-dma driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
---

Notes:
     v2: Update info about devicetree ABI compatibility in commit message
    
     v3: No change
    
     v4: No change
    
     v5: No change

 arch/mips/boot/dts/ingenic/jz4780.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index ce93d57f1b4d..b03cdec56de9 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -266,7 +266,8 @@
 
 	dma: dma@13420000 {
 		compatible = "ingenic,jz4780-dma";
-		reg = <0x13420000 0x10000>;
+		reg = <0x13420000 0x400
+		       0x13421000 0x40>;
 		#dma-cells = <2>;
 
 		interrupt-parent = <&intc>;
-- 
2.11.0

