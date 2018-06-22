Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A34C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100C32463B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bdukNUEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100C32463B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754591AbeFVRCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:02:18 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43951 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeFVRCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:02:05 -0400
Received: by mail-pg0-f68.google.com with SMTP id a14-v6so3224372pgw.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=mHZMubkwfARIjGoZoRJIOavC2pI2i2uWCnke9nxRU9o=;
        b=bdukNUEY3GFRiYRpS4NS2A0VZfK4ixES0kYILDQZpdgbaXZjzZjeZBfhoakbenbgbD
         SQEbRo9PieZOHQta8kK2hQR5xkcC7uTh3atLFv+YrX2O1kuK03/MqjJ4Yjmfvz0f/EJh
         jOrjnuIxWwNjJ6N/aV+R/g5FCdwoU0yCL4ZZCYCjBtCn6stQUtS4lF+aqqP7qBnols9w
         FnmEcQ4zYk6BKrThY3iPCk3HB0QOJj7CUSplJzZZed7aWqf56/0XPh0vrSkKOow6ZrLT
         beOeT1/w7WT7GikhnvaHYchY66XDmGQa8Q8StKqY8Oi8gHGhyxjlGyVYPaIGPHFthR9g
         2uKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=mHZMubkwfARIjGoZoRJIOavC2pI2i2uWCnke9nxRU9o=;
        b=hyz1nWB7soZufFcP2bItDpJ9LdIS9YkXrR8NDGKLvyINSzdupNkwqE/pZZfCP+VTwP
         CD09OmHQQuU4gv6NPt2GkrB8/xZXESQu0HUW2RoZhq5GDa1l8dUElvBglTZ6FQ77gUhv
         vsVllxz+U+F6dcMVeWCgpFn9HwKpaneRLPNb/dXdnosQ9NdtV5O5u+8rvak1bxl3/LOW
         oecemnyHmEFsOrciEp1DMr24gBhVEdCkEN+IY+sEDkXtU7/yHKxD/4H+V0ZEhg0HOkyu
         hzHDCQm1WZ7F+IeHALRsdDQr6vVQNqPd0PWqQWghPkZj5ci+ZMF6Y4m/P6Y1fVlLujnY
         WtEA==
X-Gm-Message-State: APt69E0rw8kLf2HNiHDC/lVvW5NylZdBjjM4zmy4guTBKAhXYg+KxOw6
        k4lYULYrEvPHAwPn4fYjBFnyvg==
X-Google-Smtp-Source: ADUXVKK7Tu0ShDL/YnM55wbW1l/9YmRWikADrXNnKFCOjP31H3l5jOV/YDiHhZqBzmH0J4J4SMTxYA==
X-Received: by 2002:a63:3c07:: with SMTP id j7-v6mr2133300pga.440.1529686923930;
        Fri, 22 Jun 2018 10:02:03 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id k80-v6sm23557079pfa.168.2018.06.22.10.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 10:02:03 -0700 (PDT)
Subject: [PATCH 5/5] irq: Remove MULTI_IRQ_HANDLER as it's now obselete
Date:   Fri, 22 Jun 2018 10:01:26 -0700
Message-Id: <20180622170126.6308-6-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180622170126.6308-1-palmer@sifive.com>
References: <20180621181756.12493-1-palmer@sifive.com>
 <20180622170126.6308-1-palmer@sifive.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        Arnd Bergmann <arnd@arndb.de>, nicolas.pitre@linaro.org,
        vladimir.murzin@arm.com, keescook@chromium.org,
        jinb.park7@gmail.com, yamada.masahiro@socionext.com,
        alexandre.belloni@bootlin.com, Palmer Dabbelt <palmer@sifive.com>,
        pombredanne@nexb.com, Greg KH <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org, jhogan@kernel.org,
        mark.rutland@arm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that every user of MULTI_IRQ_HANDLER has been convereted over to use
GENERIC_IRQ_MULTI_HANDLER we can remove the references to
MULTI_IRQ_HANDLER.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 drivers/irqchip/Kconfig | 24 ++++++++----------------
 kernel/irq/Kconfig      |  1 -
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7527f6a9adae..d564d21245c5 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -8,8 +8,7 @@ config ARM_GIC
 	bool
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
 config ARM_GIC_PM
@@ -35,8 +34,7 @@ config GIC_NON_BANKED
 config ARM_GIC_V3
 	bool
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select IRQ_DOMAIN_HIERARCHY
 	select PARTITION_PERCPU
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
@@ -68,8 +66,7 @@ config ARM_NVIC
 config ARM_VIC
 	bool
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 
 config ARM_VIC_NR
 	int
@@ -96,16 +93,14 @@ config ATMEL_AIC_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config ATMEL_AIC5_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config I8259
@@ -142,8 +137,7 @@ config DW_APB_ICTL
 config FARADAY_FTINTC010
 	bool
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config HISILICON_IRQ_MBIGEN
@@ -168,8 +162,7 @@ config CLPS711X_IRQCHIP
 	bool
 	depends on ARCH_CLPS711X
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 	default y
 
@@ -188,8 +181,7 @@ config OMAP_IRQCHIP
 config ORION_IRQCHIP
 	bool
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 
 config PIC32_EVIC
 	bool
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index c6766f326072..5f3e2baefca9 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -134,7 +134,6 @@ config GENERIC_IRQ_DEBUGFS
 endmenu
 
 config GENERIC_IRQ_MULTI_HANDLER
-	depends on !MULTI_IRQ_HANDLER
 	bool
 	help
 	  Allow to specify the low level IRQ handler at run time.
-- 
2.16.4

