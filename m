Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1C6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B387E2243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="F/tgXOjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B387E2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387431AbeKMXtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:49:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56088 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733196AbeKMXtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:49:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id i73-v6so6705098wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 05:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EqbcBvNIf6iLrXvBJ0RudteC88DgQj0z3czJgabReDo=;
        b=F/tgXOjk8SqibHjxfSKi/GCz3517Y5953cdDAlJqG8w7t+qd4HudPaDJzOW3x4F57q
         skpqT1spCNNy2q8hLlwScb6/4RGP8LwvPuoFqqAki1pvMoKTvrD3iHWkd6Quya40Nl4Y
         qwwuWSNjulS+uR9Zo1xIV5VCks0b0oAbuFKOP22R9QML9GA97OWe6MEvQvnBC99FeHYt
         +pzOfsRrKMRfihxS578zoefbrKbMXFlWsB9K5csxA3XZzVRQcTu0KpI6T7KeGbtz5RVy
         5gUbHtMx/DJx0y4mKwNNxgz/AVSxwhb+CUj74NPbI3HI8Q+WPQLJDV+UTWYcnzCxnUyt
         B9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EqbcBvNIf6iLrXvBJ0RudteC88DgQj0z3czJgabReDo=;
        b=dkTxjRSAuKSgQaVPt7iTr2hNEZL9OPugL0e9LxH61L/OE19q8y0pbtcyk4fAxyMkb3
         FFvnzIGP72pbvNqfyN86Zr5GZe0R8RoMRGUsb0Txq17hu9yacS29gGPZlPGrNSzTUsfL
         B+cNmOCYmI7SSg78b6HwwJui+XZa9SqGHSuMgYmHAHms/DdmZ5vSOonXMPGjY+NEDnYi
         2I9wWw7oL2+QDbG1EqcEG6yVfbzIZMWnDpyGlyRnARyqYJS6Vzn6gRSINzHNp7ylL1Vq
         DqD/ueBif54QQpOfl4EHg/VTfOzjJMln4AfPuX00tVJtnWXVLCidCOWfjN5Z8t5cMrDc
         E4bw==
X-Gm-Message-State: AGRZ1gK98EU8iE3caoWvCwYB7X8E6L6VRvTTmtsV3bwr+DcW9tPphAQ5
        V1e2k5cv+JoQMKBjwLdbX6czIw==
X-Google-Smtp-Source: AJdET5cX3cgrOQjkPXEqQLeqGEnZIJD0uu/3tprn9dF5OcpZDi0uaBxsIz642w85iYymYCgap78vjw==
X-Received: by 2002:a1c:5d41:: with SMTP id r62-v6mr3148449wmb.93.1542117063096;
        Tue, 13 Nov 2018 05:51:03 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id j40-v6sm15170050wre.48.2018.11.13.05.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 05:51:02 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/3] ARM: davinci: define gpio interrupts as separate resources
Date:   Tue, 13 Nov 2018 14:50:49 +0100
Message-Id: <20181113135051.15308-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113135051.15308-1-brgl@bgdev.pl>
References: <20181113135051.15308-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since commit eb3744a2dd01 ("gpio: davinci: Do not assume continuous
IRQ numbering") the davinci GPIO driver fails to probe if we boot
in legacy mode from any of the board files. Since the driver now
expects every interrupt to be defined as a separate resource, split
the definition in devices-da8xx.c instead of having a single continuous
interrupt range.

Fixes: eb3744a2dd01 ("gpio: davinci: Do not assume continuous IRQ numbering")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 42 ++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 1fd3619f6a09..8c4ae9866e3c 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -701,9 +701,49 @@ static struct resource da8xx_gpio_resources[] = {
 	},
 	{ /* interrupt */
 		.start	= IRQ_DA8XX_GPIO0,
-		.end	= IRQ_DA8XX_GPIO8,
+		.end	= IRQ_DA8XX_GPIO0,
 		.flags	= IORESOURCE_IRQ,
 	},
+	{
+		.start	= IRQ_DA8XX_GPIO1,
+		.end	= IRQ_DA8XX_GPIO1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start  = IRQ_DA8XX_GPIO2,
+		.end    = IRQ_DA8XX_GPIO2,
+		.flags  = IORESOURCE_IRQ,
+	},
+	{
+		.start  = IRQ_DA8XX_GPIO3,
+		.end    = IRQ_DA8XX_GPIO3,
+		.flags  = IORESOURCE_IRQ,
+	},
+	{
+		.start  = IRQ_DA8XX_GPIO4,
+		.end    = IRQ_DA8XX_GPIO4,
+		.flags  = IORESOURCE_IRQ,
+	},
+	{
+		.start  = IRQ_DA8XX_GPIO5,
+		.end    = IRQ_DA8XX_GPIO5,
+		.flags  = IORESOURCE_IRQ,
+	},
+	{
+		.start  = IRQ_DA8XX_GPIO6,
+		.end    = IRQ_DA8XX_GPIO6,
+		.flags  = IORESOURCE_IRQ,
+	},
+	{
+		.start  = IRQ_DA8XX_GPIO7,
+		.end    = IRQ_DA8XX_GPIO7,
+		.flags  = IORESOURCE_IRQ,
+	},
+	{
+		.start  = IRQ_DA8XX_GPIO8,
+		.end    = IRQ_DA8XX_GPIO8,
+		.flags  = IORESOURCE_IRQ,
+	}
 };
 
 static struct platform_device da8xx_gpio_device = {
-- 
2.19.1

