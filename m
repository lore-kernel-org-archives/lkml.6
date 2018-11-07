Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBA0C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CE92081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mfa1cG7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CE92081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeKHFsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:48:16 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38110 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbeKHFsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:48:15 -0500
Received: by mail-lf1-f68.google.com with SMTP id p86so12455105lfg.5;
        Wed, 07 Nov 2018 12:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=416eiwFkeOJKBgKw/6aUOwBCVOCx0Nx8xUrBJhRseNI=;
        b=Mfa1cG7pCFaa99gAqxdQv6n0eLTg78TX9wc0fbtN7nr7fO6utbXLfjqWviV65o7vDk
         r3npqUYmltblj3PZD+/ZWLfqXZCPNwKfNWSJmtLQ3cVM3ExNuue7d6f1CMmEfYlyfxqh
         PVH52ntT4A8skySgzd/qxCA705oqXP7GYQy8FUIkudOz1nb5+ccQALlfl/k91wJWAI01
         9HZEGJO9qeIEZzV44YagSR4G3TMseMVbcxajLXrGlMv5PewyvX5Yh64NMdea6wp66VAn
         v96mDdEzQvJ5JOSlrcgRCRI99bdlSS6ddzq2wAz+l2dBqXCJVg17lsGSpTRGH8qdxQXR
         DWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=416eiwFkeOJKBgKw/6aUOwBCVOCx0Nx8xUrBJhRseNI=;
        b=BXrDTMkgYdzVftolO5CaJvC2e4WrTPwyQ8k4NSDhSLj7LeLTTbL11U9fPcz5uxh6vD
         I5DRffoTn7WR2IjaipNKkLrFzaBcFdLzL6+Dn1fdS+ZbpYIkrAxWbmT82KsGwjjEynjg
         GneHjuJ3c15+KTYHZYU1HyIZSRkXa7vs1UmMXC8b48fQ+64d3bHEQw3DNj7fYTlI/i2G
         TUifRcuLMdiv9JogM+8C2O7xwhcJcIcgrwhvELNmIgpihX4Z4ats3vwcez7lEvK7T+nw
         BcnKPEcY0nc92mUWos/hE9zUScQog1F6NT2XqXJz5QI92GdinWw1aBcZUmvlLDpCDbvc
         IadQ==
X-Gm-Message-State: AGRZ1gIwY3RskFlan1lJZRpqwYiSa8rPePn6n4zQVzHpWi0KoCu3WqQ9
        0iX79WaCHzoCfGFolcCHzKQ=
X-Google-Smtp-Source: AJdET5chGSsKC72Zjfe1yGzRqQ2BBaU0AtzTEsrizo1wdgw82MmUqomxTTNfYNKhnQG2V70x+5bKjQ==
X-Received: by 2002:ac2:4188:: with SMTP id z8-v6mr1027273lfh.3.1541621777535;
        Wed, 07 Nov 2018 12:16:17 -0800 (PST)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id c19sm285650lfg.86.2018.11.07.12.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 12:16:16 -0800 (PST)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 3/3] ARM: OMAP1: ams-delta: Move AMS_DELTA_LATCH2_NGPIO to the board file
Date:   Wed,  7 Nov 2018 21:17:46 +0100
Message-Id: <20181107201746.14705-4-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181107201746.14705-1-jmkrzyszt@gmail.com>
References: <20181107201746.14705-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That symbol is not used outside the board file, there is no need to
keep it in the board header.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 6 ++++--
 arch/arm/mach-omap1/board-ams-delta.h | 2 --
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index a6986a83a916..1947bc63074e 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -204,11 +204,13 @@ static struct platform_device latch1_gpio_device = {
 #define LATCH1_PIN_DOCKIT1		6
 #define LATCH1_PIN_DOCKIT2		7
 
+#define LATCH2_NGPIO			16
+
 static struct resource latch2_resources[] = {
 	[0] = {
 		.name	= "dat",
 		.start	= LATCH2_PHYS,
-		.end	= LATCH2_PHYS + (AMS_DELTA_LATCH2_NGPIO - 1) / 8,
+		.end	= LATCH2_PHYS + (LATCH2_NGPIO - 1) / 8,
 		.flags	= IORESOURCE_MEM,
 	},
 };
@@ -217,7 +219,7 @@ static struct resource latch2_resources[] = {
 
 static struct bgpio_pdata latch2_pdata = {
 	.label	= LATCH2_LABEL,
-	.ngpio	= AMS_DELTA_LATCH2_NGPIO,
+	.ngpio	= LATCH2_NGPIO,
 };
 
 static struct platform_device latch2_gpio_device = {
diff --git a/arch/arm/mach-omap1/board-ams-delta.h b/arch/arm/mach-omap1/board-ams-delta.h
index 2c3aff824cf0..b5c4a373b905 100644
--- a/arch/arm/mach-omap1/board-ams-delta.h
+++ b/arch/arm/mach-omap1/board-ams-delta.h
@@ -37,8 +37,6 @@
 #define AMS_DELTA_GPIO_PIN_CONFIG	11
 #define AMS_DELTA_GPIO_PIN_NAND_RB	12
 
-#define AMS_DELTA_LATCH2_NGPIO		16
-
 #endif /* CONFIG_MACH_AMS_DELTA */
 
 #endif /* __ASM_ARCH_OMAP_AMS_DELTA_H */
-- 
2.16.4

