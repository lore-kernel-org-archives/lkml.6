Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A30C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B903D20449
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="phQWJmzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfBLKjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:39:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44900 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbfBLKjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id v16so2056568wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DqM/kM/HaqHLmbONMvp79H2R5kq1gnK2wwY7vOs0ioE=;
        b=phQWJmzxvT+aOTlWTPIKkAPS9dnH6jBzZIYPWR5NJv8gNP05tzasUDAN8d+HVD5PM6
         +WCSBiMqAHN1N9Pom9iYw0CnCotqCokqRpa21UzqGUmmg3KAVEd+xqI61gl3g6bKYF7w
         v94b6TqmYIg2T5AjxIr7ryePs0cQzlH/ul8ra3u3f/DmzZ/b2goz4Rl+uOE5ioNM3O7p
         HwOBnNIe1iR4B6uojl/B6f/oA1SIBFQh7EI53xSst9fGNLPRM4DKOCZXdgpPJpgs9KGf
         uker5NPIzdk275XhZaGFu35mJlZk4wT4wp5meo7KwR3zRc0qHVlnhAMQyNj9CHlcwUZ9
         zpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DqM/kM/HaqHLmbONMvp79H2R5kq1gnK2wwY7vOs0ioE=;
        b=XQRZdxPHk0S/KIx0c6ZvwRfKUTck1gQjHsfRQ3s8B+rIK3VyYT5uNyrINasvu5LPE5
         nsS/VRpUcaJ/2YHsRPAK+DZewEFitoZwZms7cFF5CPOcfk5btNlCj1+L7PhlpHI+whf/
         z1+GJP0CrenWKohTbgwGpk/9FdRF49e3i5GYwkWoLqjovRRRttdQYpUeYztPXiCweihV
         /jmBLCVPIZkfpi0M3EzdEdypYwL3WWu/djaZaTF98IO92MCu6JMQsAL9/7TmTX+Lm422
         Wu2HYoyrYAR0eKhP2G6bCqjxWXs71y5HBJ60FHgSsIdXGoXanlK3NK+RfcBavF/6Dq5m
         +T2g==
X-Gm-Message-State: AHQUAuastTMdvSSgjJgI7BGkoBAqrQwe/nUwdwQ/yCrwIA2UJsqbqyGE
        70wA3uLFflr6g4PYp3Do045s6A==
X-Google-Smtp-Source: AHgI3IYzNaeVJOdbgiA1bsfsq58GmrEm1ldAZawgjwSD2uL2A8sxGeMC6wcnYl17nDfFs9S5NFEekA==
X-Received: by 2002:adf:ba8e:: with SMTP id p14mr2272353wrg.230.1549967951986;
        Tue, 12 Feb 2019 02:39:11 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:11 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 13/37] ARM: davinci: aintc: drop the 00 prefix from register offsets
Date:   Tue, 12 Feb 2019 11:38:11 +0100
Message-Id: <20190212103835.7768-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since no offset goes past 0xff - let's drop the 00 prefix for better
readability. While we're at it: convert all hex numbers to lower-case.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/irq.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 2eb3d9b9f65f..2df91fc0dade 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -19,17 +19,17 @@
 
 #include "irqs.h"
 
-#define DAVINCI_AINTC_FIQ_REG0		0x0000
-#define DAVINCI_AINTC_FIQ_REG1		0x0004
-#define DAVINCI_AINTC_IRQ_REG0		0x0008
-#define DAVINCI_AINTC_IRQ_REG1		0x000C
-#define DAVINCI_AINTC_IRQ_IRQENTRY	0x0014
-#define DAVINCI_AINTC_IRQ_ENT_REG0	0x0018
-#define DAVINCI_AINTC_IRQ_ENT_REG1	0x001C
-#define DAVINCI_AINTC_IRQ_INCTL_REG	0x0020
-#define DAVINCI_AINTC_IRQ_EABASE_REG	0x0024
-#define DAVINCI_AINTC_IRQ_INTPRI0_REG	0x0030
-#define DAVINCI_AINTC_IRQ_INTPRI7_REG	0x004C
+#define DAVINCI_AINTC_FIQ_REG0		0x00
+#define DAVINCI_AINTC_FIQ_REG1		0x04
+#define DAVINCI_AINTC_IRQ_REG0		0x08
+#define DAVINCI_AINTC_IRQ_REG1		0x0c
+#define DAVINCI_AINTC_IRQ_IRQENTRY	0x14
+#define DAVINCI_AINTC_IRQ_ENT_REG0	0x18
+#define DAVINCI_AINTC_IRQ_ENT_REG1	0x1c
+#define DAVINCI_AINTC_IRQ_INCTL_REG	0x20
+#define DAVINCI_AINTC_IRQ_EABASE_REG	0x24
+#define DAVINCI_AINTC_IRQ_INTPRI0_REG	0x30
+#define DAVINCI_AINTC_IRQ_INTPRI7_REG	0x4c
 
 static void __iomem *davinci_aintc_base;
 static struct irq_domain *davinci_aintc_irq_domain;
-- 
2.20.1

