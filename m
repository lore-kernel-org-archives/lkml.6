Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FC8C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589532064D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589532064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeIBLl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 07:41:57 -0400
Received: from mailoutvs11.siol.net ([185.57.226.202]:54512 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725905AbeIBLl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 07:41:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 82B71520920;
        Sun,  2 Sep 2018 09:27:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1K984D-BA13u; Sun,  2 Sep 2018 09:27:06 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 15738520B05;
        Sun,  2 Sep 2018 09:27:06 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 86EDC520AE7;
        Sun,  2 Sep 2018 09:27:03 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     robh+dt@kernel.org, maxime.ripard@bootlin.com, wens@csie.org
Cc:     mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 03/27] dt-bindings: bus: add H6 DE3 bus binding
Date:   Sun,  2 Sep 2018 09:26:19 +0200
Message-Id: <20180902072643.4917-4-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180902072643.4917-1-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

The Allwinner H6 DE3 bus is similar to the A64 DE2 one.

Add its compatible string with the A64 string as fallback to the
binding.

Some description of the binding is modified to make it more generic.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt b/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
index 87dfb33fb3be..ac1445b95f41 100644
--- a/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
+++ b/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
@@ -1,11 +1,14 @@
-Device tree bindings for Allwinner A64 DE2 bus
+Device tree bindings for Allwinner DE2/3 bus
 
 The Allwinner A64 DE2 is on a special bus, which needs a SRAM region (SRAM C)
-to be claimed for enabling the access.
+to be claimed for enabling the access. The DE3 on Allwinner H6 is at the same
+situation, and the binding also applies.
 
 Required properties:
 
- - compatible:		Should contain "allwinner,sun50i-a64-de2"
+ - compatible:		Should be one of:
+				- "allwinner,sun50i-a64-de2"
+				- "allwinner,sun50i-a6-de3", "allwinner,sun50i-a64-de2"
  - reg:			A resource specifier for the register space
  - #address-cells:	Must be set to 1
  - #size-cells:		Must be set to 1
-- 
2.18.0

