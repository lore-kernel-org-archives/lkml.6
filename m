Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B30C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C3520837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbqdchwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C3520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeH3WIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:08:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43824 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbeH3WIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:08:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id h64-v6so7899760lfi.10;
        Thu, 30 Aug 2018 11:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tcKFedpKwPfw1JlfTbqpZJDN1CaZbc+G2vd2PvtCtNc=;
        b=EbqdchwX8jfqttxqyoqz3SvSqTfR6ixXhWKIzVJajiFsakwjg3L1rVqw21GaVokSb6
         xbdiw2TD14a6R6gibFyD9R6lmApJA+KYGx29F2Q7zfxkcv9CJ9SLdBTQ82PIqCIrLqs0
         GIQvgo5wvStudDFYkAIi40lsjEN9VOwKUm6IX4sKYf9T0K+NOboGd1CLBmj+YSOXG6pi
         llnwGHLL7mFZOc7lb2894+kjgkYzjaMODbZvuG61IYIsMbDbe+c6fEo3Kma9tgxBe9I7
         /sUyvRok4O0h7qhGxfDM4LrXPR/YKS6A3kpPheNodqEfdLwS0nkYwreqGcs3SimRIIWG
         Psqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tcKFedpKwPfw1JlfTbqpZJDN1CaZbc+G2vd2PvtCtNc=;
        b=JWEdG4kSkM2FOjAdURwBwkL/4nUhW8jHQggrPA+jF+J7G9/zAhHQfZVJ6zdxjBLNQF
         aoeLOATyxMmBmt5XlAwJFhdJf2KAocGFnAlFo5z6iK6uZJrYNitgjrjkyvp5V6vZqEVb
         dVanLAN/yOhH/MA1chyco1zGdmN5w7o+IuZbkQQH4Og9hsH0+qRAaY59KkE7MQlqjU3Z
         7krkI3I9dkWmNRBdEtbAZNYhPTJW4YupIAcAAkQc7l2NO9kYIZODvhRmualInbPndJIq
         rJ4CnHTJzW3aRqKELVpdgqHPgcYAPgh4cZ2GSrM2crTYPSSIyuYbymuD/WmJVM7ocXDA
         gedQ==
X-Gm-Message-State: APzg51A2Jc3ai+Z/s/B+TJmTR1B4QracalLQM0gPfnw4gGa+8HsLkJ0o
        myq70rzxnjD/7sdESr0NMJY=
X-Google-Smtp-Source: ANB0Vdbxv7aZL4XC/1eeroHssT9Nml9X/ny3YSGiEX30upk8nCv5jMSNUHEVN4pIdrpbNeELdmF46g==
X-Received: by 2002:a19:c38b:: with SMTP id t133-v6mr8527066lff.7.1535652327705;
        Thu, 30 Aug 2018 11:05:27 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1420789lfy.87.2018.08.30.11.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:05:27 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/8] ARM: tegra: Always boot CPU in ARM-mode
Date:   Thu, 30 Aug 2018 21:04:19 +0300
Message-Id: <20180830180421.6415-7-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830180421.6415-1-digetx@gmail.com>
References: <20180830180421.6415-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU always jumps into reset handler in ARM-mode from the Trusted
Foundations firmware, hence let's make CPU to always jump into kernel
in ARM-mode regardless of the firmware presence to support. This is
required to make  Thumb-2 kernel working with the Trusted Foundations
firmware on Tegra30.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index a9f13230da2f..555c652f5a07 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -20,6 +20,7 @@
 #include <soc/tegra/flowctrl.h>
 #include <soc/tegra/fuse.h>
 
+#include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 
@@ -112,10 +113,20 @@ ENTRY(__tegra_cpu_reset_handler_start)
  * NOTE: This code is copied to IRAM. All code and data accesses
  *       must be position-independent.
  */
-
+	.arm
 	.align L1_CACHE_SHIFT
 ENTRY(__tegra_cpu_reset_handler)
 
+	/*
+	 * Tegra30 ignores first bit of the reset vector and always jumps
+	 * into kernel in .ARM mode from the firmware, hence force the mode
+	 * switch if kernel is compiled in Thumb-2.
+	 */
+ THUMB(	badr	r0, 1f		)
+ THUMB(	bx	r0		)
+ THUMB(	.thumb 			)
+ THUMB(	1: 			)
+
 	cpsid	aif, 0x13			@ SVC mode, interrupts disabled
 
 	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
@@ -215,7 +226,7 @@ __no_cpu0_chk:
 	ldr	lr, [r12, #RESET_DATA(STARTUP_SECONDARY)]
 	cmp	lr, #0
 	bleq	__die				@ no secondary startup handler
-	bx	lr
+	ret	lr
 #endif
 
 /*
-- 
2.18.0

