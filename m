Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE31C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604B220854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604B220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387492AbeKEDni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 22:43:38 -0500
Received: from mailoutvs53.siol.net ([185.57.226.244]:47128 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387432AbeKEDni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 22:43:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 2FF00521293;
        Sun,  4 Nov 2018 19:27:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mC-cEIl2kKDV; Sun,  4 Nov 2018 19:27:43 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id C0C0F521270;
        Sun,  4 Nov 2018 19:27:43 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 5306F521292;
        Sun,  4 Nov 2018 19:27:41 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, jernej.skrabec@siol.net
Subject: [PATCH v3 05/28] dt-bindings: clock: sun8i-de2: Add H6 DE3 clock description
Date:   Sun,  4 Nov 2018 19:26:42 +0100
Message-Id: <20181104182705.18047-6-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds necessary description and dt includes for H6 DE3 clock.
It is very similar to others, but memory region has some additional
registers not found in DE2.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 Documentation/devicetree/bindings/clock/sun8i-de2.txt | 5 +++--
 include/dt-bindings/clock/sun8i-de2.h                 | 3 +++
 include/dt-bindings/reset/sun8i-de2.h                 | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/sun8i-de2.txt b/Docu=
mentation/devicetree/bindings/clock/sun8i-de2.txt
index e94582e8b8a9..41a52c2acffd 100644
--- a/Documentation/devicetree/bindings/clock/sun8i-de2.txt
+++ b/Documentation/devicetree/bindings/clock/sun8i-de2.txt
@@ -1,5 +1,5 @@
-Allwinner Display Engine 2.0 Clock Control Binding
---------------------------------------------------
+Allwinner Display Engine 2.0/3.0 Clock Control Binding
+------------------------------------------------------
=20
 Required properties :
 - compatible: must contain one of the following compatibles:
@@ -8,6 +8,7 @@ Required properties :
 		- "allwinner,sun8i-v3s-de2-clk"
 		- "allwinner,sun50i-a64-de2-clk"
 		- "allwinner,sun50i-h5-de2-clk"
+		- "allwinner,sun50i-h6-de3-clk"
=20
 - reg: Must contain the registers base address and length
 - clocks: phandle to the clocks feeding the display engine subsystem.
diff --git a/include/dt-bindings/clock/sun8i-de2.h b/include/dt-bindings/=
clock/sun8i-de2.h
index 3bed63b524aa..7768f73b051e 100644
--- a/include/dt-bindings/clock/sun8i-de2.h
+++ b/include/dt-bindings/clock/sun8i-de2.h
@@ -15,4 +15,7 @@
 #define CLK_MIXER1		7
 #define CLK_WB			8
=20
+#define CLK_BUS_ROT		9
+#define CLK_ROT			10
+
 #endif /* _DT_BINDINGS_CLOCK_SUN8I_DE2_H_ */
diff --git a/include/dt-bindings/reset/sun8i-de2.h b/include/dt-bindings/=
reset/sun8i-de2.h
index 9526017432f0..1c36a6ac86d6 100644
--- a/include/dt-bindings/reset/sun8i-de2.h
+++ b/include/dt-bindings/reset/sun8i-de2.h
@@ -10,5 +10,6 @@
 #define RST_MIXER0	0
 #define RST_MIXER1	1
 #define RST_WB		2
+#define RST_ROT		3
=20
 #endif /* _DT_BINDINGS_RESET_SUN8I_DE2_H_ */
--=20
2.19.1

