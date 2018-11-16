Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC925C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9636C22507
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="peH0fBne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9636C22507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389894AbeKPXIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:08:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbeKPXIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:08:11 -0500
Received: from ziggy.de (unknown [93.176.133.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93D522245E;
        Fri, 16 Nov 2018 12:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542372953;
        bh=lbNWhWrzsVMcUV8h/M5y1Ivqsz5DutvxGPHnu8cS+4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=peH0fBneMo+nU6C7S7T5mHFnkkETW6a4eVReSgttZ6NtJ5ahSTZHOUzevP9I1vUPa
         n2yn8kAb+kNMpk+LhAQ+SCwfwvRClvInsJOqbfcIH7EExDwEI1a7zqzWnJCnZAwTlR
         VVTBrzvKlzckjXXnPGJz4BLW1JBgdF0vJQPbj7Qs=
From:   matthias.bgg@kernel.org
To:     robh+dt@kernel.org, mark.rutland@arm.com, ck.hu@mediatek.com,
        p.zabel@pengutronix.de, airlied@linux.ie, mturquette@baylibre.com,
        sboyd@codeaurora.org, ulrich.hecht+renesas@gmail.com,
        laurent.pinchart@ideasonboard.com, matthias.bgg@gmail.com
Cc:     sean.wang@mediatek.com, sean.wang@kernel.org,
        rdunlap@infradead.org, wens@csie.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v5 06/12] drm/mediatek: update dt-bindings
Date:   Fri, 16 Nov 2018 13:54:43 +0100
Message-Id: <20181116125449.23581-7-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116125449.23581-1-matthias.bgg@kernel.org>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Add mmsys bindings description.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 .../display/mediatek/mediatek,disp.txt        | 30 +++++++++++--------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
index 8469de510001..4b008d992398 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
@@ -27,20 +27,24 @@ Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt.
 
 Required properties (all function blocks):
 - compatible: "mediatek,<chip>-disp-<function>", one of
-	"mediatek,<chip>-disp-ovl"   - overlay (4 layers, blending, csc)
-	"mediatek,<chip>-disp-rdma"  - read DMA / line buffer
-	"mediatek,<chip>-disp-wdma"  - write DMA
-	"mediatek,<chip>-disp-color" - color processor
-	"mediatek,<chip>-disp-aal"   - adaptive ambient light controller
-	"mediatek,<chip>-disp-gamma" - gamma correction
-	"mediatek,<chip>-disp-merge" - merge streams from two RDMA sources
-	"mediatek,<chip>-disp-split" - split stream to two encoders
-	"mediatek,<chip>-disp-ufoe"  - data compression engine
-	"mediatek,<chip>-dsi"        - DSI controller, see mediatek,dsi.txt
-	"mediatek,<chip>-dpi"        - DPI controller, see mediatek,dpi.txt
-	"mediatek,<chip>-disp-mutex" - display mutex
-	"mediatek,<chip>-disp-od"    - overdrive
+	"mediatek,<chip>-disp-ovl"		- overlay (4 layers, blending, csc)
+	"mediatek,<chip>-disp-rdma"		- read DMA / line buffer
+	"mediatek,<chip>-disp-wdma"		- write DMA
+	"mediatek,<chip>-disp-color"		- color processor
+	"mediatek,<chip>-disp-aal"		- adaptive ambient light controller
+	"mediatek,<chip>-disp-gamma"		- gamma correction
+	"mediatek,<chip>-disp-merge"		- merge streams from two RDMA sources
+	"mediatek,<chip>-disp-split"		- split stream to two encoders
+	"mediatek,<chip>-disp-ufoe"		- data compression engine
+	"mediatek,<chip>-dsi"			- DSI controller, see mediatek,dsi.txt
+	"mediatek,<chip>-dpi"			- DPI controller, see mediatek,dpi.txt
+	"mediatek,<chip>-disp-mutex"		- display mutex
+	"mediatek,<chip>-disp-od"		- overdrive
+	"mediatek,<chip>-mmsys", "syscon"	- provide clocks and components management
   the supported chips are mt2701, mt2712 and mt8173.
+  For mt7623, compatible must be:
+	"mediatek,mt7623-<component>" , "mediatek,mt2701-<component>"
+
 - reg: Physical base address and length of the function block register space
 - interrupts: The interrupt signal from the function block (required, except for
   merge and split function blocks).
-- 
2.19.1

