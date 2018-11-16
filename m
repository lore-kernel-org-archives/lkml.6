Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4075C04EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712552251C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n04Pgmrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712552251C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389985AbeKPXI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:08:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbeKPXI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:08:27 -0500
Received: from ziggy.de (unknown [93.176.133.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B651122513;
        Fri, 16 Nov 2018 12:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542372970;
        bh=zcIYayK/x2veA+f/cfKszd/YU1GREEj9WyGnLQtE2/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n04Pgmrbi90U5qIQr3eTt5qf9U6nhjBKPy1MzAm5BKF6latwnLvkfBQs8cgQ+B23A
         Y1jWA3JCZb1qo8QZ/3a5ZzNB0NV4Zbm1Vg7C5WXJrbe0MoBFb3YfqgnqPIaPqrOnrx
         /ys+eOxEGCcpWmeJrNt0LQs193Iquaa7EXZQYLys=
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
Subject: [PATCH v5 10/12] arm64: dts: mt6797: Use the new mmsys clock compatible
Date:   Fri, 16 Nov 2018 13:54:47 +0100
Message-Id: <20181116125449.23581-11-matthias.bgg@kernel.org>
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

Move the clock part of mmsys in a child node.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 arch/arm64/boot/dts/mediatek/mt6797.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 4beaa71107d7..3ca635c81de1 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -206,9 +206,13 @@
 	};
 
 	mmsys: mmsys_config@14000000 {
-		compatible = "mediatek,mt6797-mmsys", "syscon";
+		compatible = "mediatek,mt6797-mmsys", "syscon", "simple-mfd";
 		reg = <0 0x14000000 0 0x1000>;
-		#clock-cells = <1>;
+
+		mmsys_clk: clock-controller@14000000 {
+			compatible = "mediatek,mt6797-mmsys-clk";
+			#clock-cells = <1>;
+		};
 	};
 
 	imgsys: imgsys_config@15000000  {
-- 
2.19.1

