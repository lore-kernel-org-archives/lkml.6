Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87C1C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC0220881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="E38t3rXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388019AbfAaNmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:42:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36203 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfAaNjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:39:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so2603236wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MTJcyASTfjESmwjpiKMY5IRrOr8j9890nwSQZijPI4M=;
        b=E38t3rXwqEYMCfiMuuw4AUZYZJVU+suUix6WOB/ONx+b47GSAOyocC75dTAg/3A2cL
         3RP5VeKWo9jC1V9iSHYJ/o/iJGG12UPN2pwbLoMS5Fh6jn9C3GjlZ1qT4LFAC0fi9y8a
         Aodz8VO9wmktqlSn02PrssdPMBnu/0CBSMJBYTSsAYmiPLuNDu2Z7+xJ0VCLX0UAiItu
         U3BIwbI4F+U0N0IREVn4+6j9slvFSSASHIr4WWH8mzapctrI2G+Ck2a4s3iv63F+9m5I
         PPoxncBJhf9pWE3nPKMXyQinrOpzcLv6LzVUf9p6cOyDP+12Niuwj4gcNJT2Owr6K9o0
         uYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MTJcyASTfjESmwjpiKMY5IRrOr8j9890nwSQZijPI4M=;
        b=QmbfvEJ8dI8SQ17SdQYdwJTkhiqkvI7AZVKBx8iGVJbOodWR/D3xWAF0DJKa5wrHMM
         8mAPosC39gCi3QGDbz4f4e0XJcIHVRcOUckOX4O40Ce/nY1V7SV70XRqddeo0cDzANN6
         QoCD0ERBnddtRav1dgTqoHZqLmZM8p04kJnTXJflM1vG8wC7I0lWg0VRpPH2nnVAwfq1
         GDUOjgmhZUTk/2GCd+MU5m2oImiK8+VX86H66GFh4bw+VmMSRgDmlkG49LMi+Zq8eUk6
         FXaFKXIxi2M9Td9iFjBQzT0sSQJlKqObILqOMLEHwh1vsf9aeBDUhdGYZX6MFVUpJNzr
         CedQ==
X-Gm-Message-State: AJcUukd4+A+KTtuVfL31SPqZz7gn3fZX3rhTiw4cUMRDBGuRnUg3RPYa
        Wmtf8Gw2UXvcr3tykZKDeTU93w==
X-Google-Smtp-Source: ALg8bN7v7ty/JFXRjSxxNNQVfvMj+rMkRFQJGHxWOmUDB8RyJBZPHgbMPaYEr9XCOBTVASd3TPaRqg==
X-Received: by 2002:a1c:7c07:: with SMTP id x7mr29821411wmc.82.1548941985516;
        Thu, 31 Jan 2019 05:39:45 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:39:44 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 04/35] ARM: davinci: pull davinci_intc_base into the respective intc drivers
Date:   Thu, 31 Jan 2019 14:38:57 +0100
Message-Id: <20190131133928.17985-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This variable is defined globally in common.c. Define separate local
variables for the aintc and cp-intc drivers and remove the global one.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/common.c              | 2 --
 arch/arm/mach-davinci/cp_intc.c             | 2 ++
 arch/arm/mach-davinci/include/mach/common.h | 1 -
 arch/arm/mach-davinci/irq.c                 | 2 ++
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index a87e158a709b..2850ae02aaa4 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -23,8 +23,6 @@
 struct davinci_soc_info davinci_soc_info;
 EXPORT_SYMBOL(davinci_soc_info);
 
-void __iomem *davinci_intc_base;
-
 void davinci_get_mac_addr(struct nvmem_device *nvmem, void *context)
 {
 	char *mac_addr = davinci_soc_info.emac_pdata->mac_addr;
diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index fef39d5988d9..384b72fbefca 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -23,6 +23,8 @@
 #include <mach/common.h>
 #include "cp_intc.h"
 
+static void __iomem *davinci_intc_base;
+
 static inline unsigned int cp_intc_read(unsigned offset)
 {
 	return __raw_readl(davinci_intc_base + offset);
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 34e48de92dcc..3d45b73b9a64 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -20,7 +20,6 @@
 void davinci_timer_init(struct clk *clk);
 
 extern void davinci_irq_init(void);
-extern void __iomem *davinci_intc_base;
 
 struct davinci_timer_instance {
 	u32		base;
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 3658235c8ee7..e539bc65d4ef 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -42,6 +42,8 @@
 #define IRQ_INTPRI0_REG_OFFSET	0x0030
 #define IRQ_INTPRI7_REG_OFFSET	0x004C
 
+static void __iomem *davinci_intc_base;
+
 static inline void davinci_irq_writel(unsigned long value, int offset)
 {
 	__raw_writel(value, davinci_intc_base + offset);
-- 
2.20.1

