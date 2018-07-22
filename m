Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABE9ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 05:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E60520858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 05:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E60520858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeGVGgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 02:36:43 -0400
Received: from hermes.aosc.io ([199.195.250.187]:44831 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbeGVGgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 02:36:43 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id AE1769F536;
        Sun, 22 Jul 2018 05:41:11 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        Corentin Labbe <clabbe@baylibre.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/5] dt-bindings: sunxi-sram: add binding for Allwinner H6 SRAM C
Date:   Sun, 22 Jul 2018 13:39:52 +0800
Message-Id: <20180722053955.25266-3-icenowy@aosc.io>
In-Reply-To: <20180722053955.25266-1-icenowy@aosc.io>
References: <20180722053955.25266-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner H6 SoC's DE3 needs the SRAM C section being claimed in the
system controller to work, like A64 DE2.

As H6 and A64 system controller are quite similar, code is reused now,
and the A64 fallback compatible string is added after the H6 compatible
string.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/sram/sunxi-sram.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
index c51ade86578c..6527a1a535a3 100644
--- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
+++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
@@ -18,6 +18,7 @@ Required properties:
     - "allwinner,sun8i-h3-system-control"
     - "allwinner,sun50i-a64-sram-controller" (deprecated)
     - "allwinner,sun50i-a64-system-control"
+    - "allwinner,sun50i-h6-system-contorl", "allwinner,sun50i-a64-system-control"
 - reg : sram controller register offset + length
 
 SRAM nodes
@@ -54,6 +55,9 @@ The valid sections compatible for H3 are:
 The valid sections compatible for A64 are:
     - allwinner,sun50i-a64-sram-c
 
+The valid sections compatible for H6 are:
+    - allwinner,sun50i-h6-sram-c, allwinner,sun50i-a64-sram-c
+
 Devices using SRAM sections
 ---------------------------
 
-- 
2.18.0

