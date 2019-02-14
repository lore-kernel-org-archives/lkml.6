Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87B7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A00222D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XuxCDBvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439572AbfBNOxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:53:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39167 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439518AbfBNOxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:53:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id l5so5704535wrw.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DqM/kM/HaqHLmbONMvp79H2R5kq1gnK2wwY7vOs0ioE=;
        b=XuxCDBvXCWJb+O34mxggfJXC5IN9aM6b7wqvr7NIDh8Q4vOWnnMCYkwad28bhOUU79
         TbJcUHxRWLnHWIp0j2t3jvp+cCwM+cQoXUEA/KyYh8nD4cdf5slVNonQXWT3MMIfZoON
         gj46m9R9S8v9sdVu4WW8fkclzTM78qgmS+Wc+OxLYp5IB7HHi3ZFZKI8Kit1Lw3lDdp9
         GodFoD/ECc3KdBJazjfoLcEQZHN6EJRQBXm1dva231zxf9LiqT3FMVLKAoC+v65zP3E5
         QwfKZeGZSwDb7gYEpGCGsCBoFT3Z33UKTxY86wiQJFH/kmrcPqIKvTrAsoIKLvu1/7Bn
         PitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DqM/kM/HaqHLmbONMvp79H2R5kq1gnK2wwY7vOs0ioE=;
        b=GSjILBvSihTYaUU8a8AejkT0zG9TDDRerBg7yobAJLa+Us6sjkIyZnZxwmatBcUgFw
         52QZ+NmonW41BDS0P5Kd8ZulY+PzZgQ2URJvRkSEKGijCdHo5cEkwKM1wnCBQNMLyKij
         ZELkVpDyCeD6/evdHup+4kskSgO0o+F/Ql4HhTG9GupuIWVXyDQZn+fSG9XqIfZM1H/n
         /aycAfK6FzHNw+zl4hTOWKH4kbQxMQHKRt047T9Ac9HVc7iMyRnAhaa/0rC77BeOz2qR
         vC4e/Cuof+M0Dk1ujoZB33pf3A3+XLePs1XIBhBuhsL5IXKcq/LtSeq2MP+GkInI6K9D
         Qy/g==
X-Gm-Message-State: AHQUAuZwv4kVtAN5fqc4AiVTx5o0/T22fBL+JDstK8pj0DV7MDpIkaP/
        6I4VhlioQWI0FugSpRnSYbxn3w==
X-Google-Smtp-Source: AHgI3Ib6PUDF1c4rjkTwSzYSEU0j99yFVD2iXCnZSoKqpWTjKMwn7CUKBqM/eaTl7BBV5HMVHKNNTQ==
X-Received: by 2002:a5d:434c:: with SMTP id u12mr3249080wrr.14.1550155978941;
        Thu, 14 Feb 2019 06:52:58 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:52:58 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 13/37] ARM: davinci: aintc: drop the 00 prefix from register offsets
Date:   Thu, 14 Feb 2019 15:52:07 +0100
Message-Id: <20190214145231.8750-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
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

