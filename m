Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53A4C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B51F2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFTO4KWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B51F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbeLBVXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:23:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33719 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbeLBVXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:23:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so5569988wmh.0;
        Sun, 02 Dec 2018 13:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aCJ1z19r/p/cSDddgTolGHUMO2TTDXswzYQqVhNA790=;
        b=lFTO4KWPi9FiaUr9oLQPf9b29u/miq1SdnbmOvssdCKfwBKe6jP5VZUKt6DZHtE5O0
         g0AEQ+DEo17d9kt9sLmE53AApa8n9zRZXC72/QbA3i0+B4duGgsE8begYpV0I0xI7Q7H
         xzasHza3UlZTgppnNk4TtJv0bIRyXMSTV9ry6/5uUcCWTHIi4NZdgKTHBK1FyCC1zAC/
         lZi11nmbF5OGnKw5nJ6j1CF0jECZoL1TO1Yafcrq3kW7ymYMkxRjCzllDa+Bt3QOES88
         9BwLmVK4clUiQYSzMl+cXooxFGfCBwoiBlyOtL/VtKf+u2njTPBR8rWh55/xT8nroZs0
         OP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aCJ1z19r/p/cSDddgTolGHUMO2TTDXswzYQqVhNA790=;
        b=cutIR/R7XevZw1mKlvpbsTZKWssXDXwz83BRMubcrKa78gjt0qZHGaxsyDAbC3l7j8
         D72kU4DPaSlwjblR5UkqAeUkrt/3A0eKAYNU4/fvS682DWIhp+j9bKVFOsnru00yicr1
         j3kp6Q9fYW583MlAikzUO/6i6AnGt9OvdsPFBU8YrAUcR3AvWBWXlsfV6HrlhcND0Nn7
         RLkUPiNebGUDQ6rpBG4gGbZDIcXCIq5l3Vsn5uIGg3lXQIMVkw+mEZTlhj/hu075Nt/4
         aC0+kY4XkZEJ+/C/3HZof8UlWu0YBuCn/A7pCwfzfwR6pOv1rkRG3WIocUofyDM2q08T
         9org==
X-Gm-Message-State: AA+aEWbAhIt4ZCIrUCT4Pa8Gnwz3dt+3TDmspP7SiBDHxminfisKzLn2
        6eIeslliIgH5W4AAYWGS9PBI7R8S31I=
X-Google-Smtp-Source: AFSGD/URYtpwGQQ1e0uaq+sdvPfANESyrrrgCsmkZgfNFOHi/ctrQE4YdaN8VQqTCX71llmaosEXTQ==
X-Received: by 2002:a1c:8fc2:: with SMTP id r185mr5876417wmd.54.1543785815775;
        Sun, 02 Dec 2018 13:23:35 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id d2sm9551043wrs.97.2018.12.02.13.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 13:23:35 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [RFC PATCH 03/10] dt-bindings: dmaengine: Add Allwinner suniv F1C100s DMA
Date:   Mon,  3 Dec 2018 00:23:10 +0300
Message-Id: <7322bdfcd38cdcd8ccec56fea25492e4945d498f.1543782328.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543782328.git.mesihkilinc@gmail.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Allwinner suniv F1C100s DMA.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 Documentation/devicetree/bindings/dma/sun4i-dma.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/sun4i-dma.txt b/Documentation/devicetree/bindings/dma/sun4i-dma.txt
index 8ad556a..ceeb41e 100644
--- a/Documentation/devicetree/bindings/dma/sun4i-dma.txt
+++ b/Documentation/devicetree/bindings/dma/sun4i-dma.txt
@@ -4,7 +4,9 @@ This driver follows the generic DMA bindings defined in dma.txt.
 
 Required properties:
 
-- compatible:	Must be "allwinner,sun4i-a10-dma"
+- compatible:	Should be one of the following:
+		"allwinner,sun4i-a10-dma"
+		"allwinner,suniv-f1c100s-dma"
 - reg:		Should contain the registers base address and length
 - interrupts:	Should contain a reference to the interrupt used by this device
 - clocks:	Should contain a reference to the parent AHB clock
-- 
2.7.4

