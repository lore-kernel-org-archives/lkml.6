Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F880C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C7F20664
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzrHGPn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C7F20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeKYSeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 13:34:19 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34354 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeKYSeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 13:34:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so10244122wmd.1;
        Sat, 24 Nov 2018 23:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Djjq1nRc3F7KdYio0IVcGJ34k3H9NlNQupH0SjqgVhc=;
        b=ZzrHGPn9EhcB4qpV5zcHrtewI1h6zQt2u8t2UwMEe+bJVXG5WOYafk31QwGQxehtJg
         a66IoFWbva3ayXtkUQZd46wVwgF8phSXKmltbPXh26B7wzAYh5DFCX9IPABxFen6T3AW
         +4LqQ8G/SROowBIGChoEHipBR0jsZF4hjSqijg58/Rb2ZMwxFe6eGop4VnsZIn/3ktl0
         oNyLBdiHRJ1dLoOs7n1q3emj68P5w6oFXqQ1h+po1K0lVM4jkrefxnF5BVXCUtkHgMXO
         sw/HyJk6Foi0KJvWhfCt6TCWaWM/tqpcCvDHLcbitocxNw1GYAf1sZe1PNcDPaDS6r1H
         RQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Djjq1nRc3F7KdYio0IVcGJ34k3H9NlNQupH0SjqgVhc=;
        b=jG0aHo2fPiAZ8ldXFecSMl1WxkQjYbNXIgKm7Y02zxiap14pCyXV0esd28/j3lmU5z
         QNH6g8/CYysUDQ/DtzRD/J3sqVeZ6IOM1KINWWM7/3tYkHeoFx/7cL08UzwMsTiTS85O
         Bt/Uwc3Cv9iKS6bi5uM3CLtJb3n/7J8J5z9XkxkP82vviKvADPGN3Womqf6ElD5DG16L
         6JX1b3WJpABZZ45tOuToGFnhutLoRNxgMHkFnSyIBkigu9PvGze36Ki6djx9kiKUqlDe
         7uqbFgJ48YF8EVg8H1FPIuRuzjvjTQ0847zweObKW1jlwU67v5fUiX0RL9xy6KqdopHI
         +T2Q==
X-Gm-Message-State: AA+aEWaJbr20GGEg7KOFCMcKAAbPW6sVgeN8OfZAWT0SHYTpWodRbjgk
        d5KE2St1Q1djPFL6Z7EqyHwc9fMSSaQ=
X-Google-Smtp-Source: AJdET5f0/1VwxW9owJi746HDwt8Fdn/zaedJvAqCytaQUGU0TggBvm1X7kYgz3H1fDgBl0LxAIXWbQ==
X-Received: by 2002:a1c:d912:: with SMTP id q18mr19308099wmg.122.1543131828836;
        Sat, 24 Nov 2018 23:43:48 -0800 (PST)
Received: from localhost.localdomain ([185.219.177.224])
        by smtp.gmail.com with ESMTPSA id 6-v6sm12296780wmg.19.2018.11.24.23.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Nov 2018 23:43:48 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: [RFC PATCH v4 02/17] dt-bindings: arm: Add new Allwinner ARMv5 F1C100s SoC
Date:   Sun, 25 Nov 2018 10:43:05 +0300
Message-Id: <a038c5ba853cc2534a8ee9b51de3cab5539726cd.1543131714.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new Allwinner ARMv5 F1C100s SoC's compatible string

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
index e4beec3..f9ddc05 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.txt
+++ b/Documentation/devicetree/bindings/arm/sunxi.txt
@@ -18,4 +18,5 @@ using one of the following compatible strings:
   allwinner,sun8i-v3s
   allwinner,sun9i-a80
   allwinner,sun50i-a64
+  allwinner,suniv-f1c100s
   nextthing,gr8
-- 
2.7.4

