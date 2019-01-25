Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB872C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4DD218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="xoITJm6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfAYSNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:13:00 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:48218 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfAYSM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1548439977; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=55vQ14YehGxo3XFSbN/3oFUjriTqNz5RaSOEzMvYXAk=;
        b=xoITJm6NfL7QWKruNAXnY1TIMGuzWhiya8aBs2B38XfNgj2mtFyNPIsDAUPsRr3JGhVl8r
        1RRNlE9Ow4AubZdtOmgBUhGfe2jpASdHJ7St4d80u7WM/8TnBlPkCmr4pR7nSelLfJSVYY
        vKNttLI6xB1McteBryIgWLPM9u9oZCg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] MIPS: DTS: jz4740: Correct interrupt number of DMA core
Date:   Fri, 25 Jan 2019 15:12:45 -0300
Message-Id: <20190125181245.9966-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt number set in the devicetree node of the DMA driver was
wrong.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/jz4740.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index 6fb16fd24035..2beb78a62b7d 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -161,7 +161,7 @@
 		#dma-cells = <2>;
 
 		interrupt-parent = <&intc>;
-		interrupts = <29>;
+		interrupts = <20>;
 
 		clocks = <&cgu JZ4740_CLK_DMA>;
 
-- 
2.11.0

