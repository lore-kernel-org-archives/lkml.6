Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4866BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E8724658
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LGldYwe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E8724658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754776AbeFVREi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:04:38 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34227 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754314AbeFVRB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:01:57 -0400
Received: by mail-pf0-f194.google.com with SMTP id a63-v6so3506121pfl.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=otYr7TQZHqhiSjOgFmTHNL4jAFEirhqc4NoVnkYDhoc=;
        b=LGldYwe2KwXUIL2MQRKDwyGJxx1SpnOGCBEBZ5QSqPk0KHicNlDl4NFdpLQI6O/O3K
         SAFWHPpEGOYQh9QR+Y9h9zs8NkMW/eKu0ZzF3lpwDTYzi+M1duDpK3X5BZu5f9YqXRES
         gureOJ40zJHCoxmU+2yjISbvbZp2Zbro9bUjVUd9teadSHVJmlEWdYG0BSGb4Fqs6J9I
         8EwZwn4xuaWSFDYDVFJSnW0srtD+sBiyH9Fbs2qtng3WEKJcOwmvIi8kZGucN0B/7KI8
         KwuhqWU4ETeIAyk9dKLCTR1RPvCOd8fgRrPlKbtJe+AJki8hjynYGwr42qmeJAGrKk3f
         gZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=otYr7TQZHqhiSjOgFmTHNL4jAFEirhqc4NoVnkYDhoc=;
        b=Gs0SHsV5JgXkKKx86IomvHaXgBu+JMb3zdYr8jhJPVUyK6hLuMSRhki/W3LAIFJC7k
         xTxH3EmBhdrJYRUi9hW/2JGPqQ+5npqqUDygJ3ut7AotUlxNBWWefPI8ZPvw+q9bp3Gf
         oSxG5GNzsodzD9C4FbQWHwUXiT24tZ6CbuZa6SouFlmSgvR6hNfqTI8HSaQi6lAF9FdF
         ZhQPSIUXdsZNHmZIzsuM5Pzplvp2VeGjVIam9eW+HMqYDunqjGsPmz5NVHvHtb3+kovX
         mr5y7XbhhzQj6beUbGQeBnodubPZVN+DBVdc5NkJu8O5X5gqeBHoAfjfemGMfLGqbYjV
         IJRA==
X-Gm-Message-State: APt69E3kzbpy7/JAavc7znPuuAeTKpne0oHGnfCvQVSc8NQkq5eof3e7
        OtWmUF+rQZsWJHE/4fJxhWb3f/ACxlY=
X-Google-Smtp-Source: ADUXVKKO1DxhznwrUyw6nIqXWQ26oZeFRfncpgiuIZD9PtkknR2bCGORZpN7W+K2i5bx12H8iFjhpA==
X-Received: by 2002:a63:b307:: with SMTP id i7-v6mr2119105pgf.448.1529686917223;
        Fri, 22 Jun 2018 10:01:57 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id b83-v6sm23123835pfe.159.2018.06.22.10.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 10:01:56 -0700 (PDT)
Subject: [PATCH 1/5] irq: Port the ARM IRQ drivers to GENERIC_IRQ_MULTI_HANDLER
Date:   Fri, 22 Jun 2018 10:01:22 -0700
Message-Id: <20180622170126.6308-2-palmer@sifive.com>
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
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
        Shea Levy <shea@shealevy.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GENERIC_IRQ_MULTI_HANDLER is incompatible with MULTI_IRQ_HANDLER because
they define the same symbols.  Multiple generic irqchip drivers select
MULTI_IRQ_HANDLER, which is now defined on all architectures that
provide set_handle_irq().  This patch selects GENERIC_IRQ_MULTI_HANDLER
for all drivers that used to select MULTI_IRQ_HANDLER, but only when
MULTI_IRQ_HANDLER doesn't exist.  I'll then convert every architecture
over from MULTI_IRQ_HANDLER to GENERIC_IRQ_MULTI_HANDLER before removing
the extra MULTI_IRQ_HANDLER scaffolding.

CC: Shea Levy <shea@shealevy.com>
CC: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 drivers/irqchip/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e9233db16e03..7527f6a9adae 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -9,6 +9,7 @@ config ARM_GIC
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
 config ARM_GIC_PM
@@ -35,6 +36,7 @@ config ARM_GIC_V3
 	bool
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select IRQ_DOMAIN_HIERARCHY
 	select PARTITION_PERCPU
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
@@ -67,6 +69,7 @@ config ARM_VIC
 	bool
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 
 config ARM_VIC_NR
 	int
@@ -94,6 +97,7 @@ config ATMEL_AIC_IRQ
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 
 config ATMEL_AIC5_IRQ
@@ -101,6 +105,7 @@ config ATMEL_AIC5_IRQ
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 
 config I8259
@@ -138,6 +143,7 @@ config FARADAY_FTINTC010
 	bool
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 
 config HISILICON_IRQ_MBIGEN
@@ -163,6 +169,7 @@ config CLPS711X_IRQCHIP
 	depends on ARCH_CLPS711X
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	default y
 
@@ -182,6 +189,7 @@ config ORION_IRQCHIP
 	bool
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 
 config PIC32_EVIC
 	bool
-- 
2.16.4

