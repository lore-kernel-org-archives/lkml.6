Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E4AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015522192C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0hQRI5ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfBHKOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:14:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33331 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfBHKOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:14:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id a16so2983907wrv.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 02:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eO3Voe2p456qMJUTmSfjfToLuBGLaNZbZuGLhlQmyS4=;
        b=0hQRI5ml79BHdo7QVJjEatDn9SdBBjSKQ830hTYMW02cSPmFhpf/6HfDjs3UJR1efv
         /W7A9VjraD0t7gMbW4JHzWIU8h64LyJRPHtYqSNOjFLSl/OZiY6EGDfbnVJ+oNIzIjYB
         U5ECkC0mIK0/jzS7EjH4jn2Un9gs7m/HwJZW0AzfFlU9JfCbY7pn1J1uX6BdM3RwCMxa
         pX5p1Gz4pG1GX+kEfR951JqalAmMI/qE8njq/c7Zz2u982iKnELdvUd6sxaVkTI7bcX2
         XIYkNyPXVTRHbd0u8o4y3iV2/wCMHLtXKfVx4CVqtqmn55bNT9xVBnKSI874rI16kUzS
         H7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eO3Voe2p456qMJUTmSfjfToLuBGLaNZbZuGLhlQmyS4=;
        b=Gr2dTq7sL6yCXZNDoFL3DpT01FSnvJ+arCuxOnuZzD2zl+gAPcSx+//tIT/y1vIsVO
         R/f/7rbUwShpdl3wnht8H8D7/SMIT+QG50lkemLrpetw3YaoA5VbFnu7Ux7rhfKOdaMD
         ijdjIQQNUQhn3PMU47bn/Tj8I8uJtvbaTCSMkwyPs7bbNtoIN7K7B+UPCo4Torz7C2Uq
         KYGzzn+4c4c7ZHb6QUbuw7gb2XA8Z1HTh4jl3qEby4FDoJMX12mrcwt+n6mLF6N3VS3n
         HCH9HN3pWJOaTpwOmNPEQblCnI9Na4yoPU1+cnnr3Rc81M6e+dnDurpVss2jAcFQ1GKu
         LOXQ==
X-Gm-Message-State: AHQUAuZYTfuvV7BRg6rQQsPgqmGWXWQ9DUD2p6EjxLbGOCZXRihHnxKt
        glC1g8YvCBeeZvN5Ew4pCGSlkw==
X-Google-Smtp-Source: AHgI3IYIaI8KHjDTHR5aZF/KcgqtLXoJxT3GFY0QhRtgChxkud4EHMSRI6sHmIX8/tV5dU097KLqxQ==
X-Received: by 2002:adf:84e4:: with SMTP id 91mr15789126wrg.237.1549620855682;
        Fri, 08 Feb 2019 02:14:15 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e35:2e9a:6060:2ed3:c463:803b:b085])
        by smtp.googlemail.com with ESMTPSA id a62sm1901634wmf.47.2019.02.08.02.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 02:14:15 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] arm64: meson: enable g12a clock controller
Date:   Fri,  8 Feb 2019 11:14:04 +0100
Message-Id: <20190208101405.25699-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208101405.25699-1-jbrunet@baylibre.com>
References: <20190208101405.25699-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the g12a clock controller for ARCH_MESON

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/Kconfig.platforms | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 819e74ae9224..d0e0bd4af05d 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -114,9 +114,11 @@ config ARCH_MESON
 	select PINCTRL_MESON
 	select COMMON_CLK_GXBB
 	select COMMON_CLK_AXG
+	select COMMON_CLK_G12A
 	select MESON_IRQ_GPIO
 	help
-	  This enables support for the Amlogic S905 SoCs.
+	  This enables support for the arm64 based Amlogic SoCs
+	  such as the s905, S905X/D, S912, A113X/D or S905X/D2
 
 config ARCH_MVEBU
 	bool "Marvell EBU SoC Family"
-- 
2.20.1

