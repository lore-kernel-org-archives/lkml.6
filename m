Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D1AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD64208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD64208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbeK0Sk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:40:28 -0500
Received: from hermes.aosc.io ([199.195.250.187]:37346 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729143AbeK0Sk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:40:28 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 02DA611E7EF;
        Tue, 27 Nov 2018 07:43:24 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/2] dt-bindings: gpu: add Allwinner H6 Mali Midgard binding
Date:   Tue, 27 Nov 2018 15:42:49 +0800
Message-Id: <20181127074249.15204-2-icenowy@aosc.io>
In-Reply-To: <20181127074249.15204-1-icenowy@aosc.io>
References: <20181127074249.15204-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 SoC uses a Mali T720 GPU, which is one of the GPUs in the
Midgard GPU product line.

Add binding for the H6 Mali Midgard GPU.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../devicetree/bindings/gpu/arm,mali-midgard.txt    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
index 02f870cd60e6..c897dd7be48f 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
@@ -18,6 +18,7 @@ Required properties:
     + "amlogic,meson-gxm-mali"
     + "rockchip,rk3288-mali"
     + "rockchip,rk3399-mali"
+    + "allwinner,sun50i-h6-mali"
 
 - reg : Physical base address of the device and length of the register area.
 
@@ -44,6 +45,18 @@ Optional properties:
   for details.
 
 
+Vendor-specific bindings
+------------------------
+
+The Mali GPU is integrated very differently from one SoC to
+another. In order to accomodate those differences, you have the option
+to specify one more vendor-specific compatible, among:
+
+  - allwinner,sun50i-h6-mali
+    Required properties:
+      * resets: phandle to the reset line for the GPU
+
+
 Example for a Mali-T760:
 
 gpu@ffa30000 {
-- 
2.18.1

