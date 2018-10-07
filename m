Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B64C677F5
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D892084D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D892084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeJGQqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 12:46:16 -0400
Received: from mailoutvs19.siol.net ([185.57.226.210]:39654 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727752AbeJGQqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 12:46:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 3F4C3520BE6;
        Sun,  7 Oct 2018 11:39:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id U35zmzVMJ-Ah; Sun,  7 Oct 2018 11:39:30 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 962BE520BEB;
        Sun,  7 Oct 2018 11:39:29 +0200 (CEST)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 00ABB520BE6;
        Sun,  7 Oct 2018 11:39:26 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, airlied@linux.ie,
        architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 05/29] dt-bindings: clock: sun8i-de2: Add H6 DE3 clock description
Date:   Sun,  7 Oct 2018 11:38:41 +0200
Message-Id: <20181007093905.11253-6-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007093905.11253-1-jernej.skrabec@siol.net>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
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
2.19.0

