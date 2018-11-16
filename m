Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998D3C04EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629622250F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGxqY6XB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629622250F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389917AbeKPXIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:08:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbeKPXIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:08:15 -0500
Received: from ziggy.de (unknown [93.176.133.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8D0E22506;
        Fri, 16 Nov 2018 12:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542372957;
        bh=tDEAlsylVZO9hif7491ZHF3PmtTIgfoHM6y+tkqc+DU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGxqY6XBB4cMMZP7qXUbjq+FnFtC9eN0X7xakyTsaORqob8wDFkyiTp0vKl8/npuj
         3PnDkUhICZNy9vgxOMyZoo/gHuVauVrqJv0Kp8NXoxlnw4K6kSJy8xcbrDQ1tm29SZ
         paduSrz4tCPuh06zBR7Bxd/h9IFA1tbo6ti1yFMw=
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
Subject: [PATCH v5 07/12] dt-bindings: clock: mediatek: delete mmsys clocks
Date:   Fri, 16 Nov 2018 13:54:44 +0100
Message-Id: <20181116125449.23581-8-matthias.bgg@kernel.org>
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

Some SoCs will now load the clock part of mmsys via
a platform device from the dsiplay driver.
Remove the compatible from the clock bindings description.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt        | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
index 15d977afad31..4468345f8b1a 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
@@ -6,11 +6,8 @@ The Mediatek mmsys controller provides various clocks to the system.
 Required Properties:
 
 - compatible: Should be one of:
-	- "mediatek,mt2701-mmsys", "syscon"
 	- "mediatek,mt2712-mmsys", "syscon"
 	- "mediatek,mt6797-mmsys", "syscon"
-	- "mediatek,mt7623-mmsys", "mediatek,mt2701-mmsys", "syscon"
-	- "mediatek,mt8173-mmsys", "syscon"
 - #clock-cells: Must be 1
 
 The mmsys controller uses the common clk binding from
-- 
2.19.1

