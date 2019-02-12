Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEA1C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1145220449
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Neb+urI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfBLKjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:39:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33982 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbfBLKjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id f14so2125925wrg.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8q3N9QJP0kKocjZRYLcTGHxt0dwwrAq7qRa8kv+RaP8=;
        b=Neb+urI21I0HLEAyckGEuIVN34/XdQJ3dLtZjhvLvZSZkNhOSD506mPMhDr2RmO204
         cnM0r4q4hlXesLC3DTzuJtXOcGffnhDZT0obfcI+3GRTitLjiwODX4oNlWRsrX+BHAls
         O93qnNX/xhT0cBu2URQrlEfe8jjJGt2mp4LAHR5mmdes8N1pk8O9BKWToCPHNUMIIeNK
         eQQjoOtSwIvOxi5F74CLCiuxQcpHWpl5fqeVJ2vcw6dS0WZB1Nl7t34n/DMZNdfYeUWL
         C0qY2N+6dDqU7207jS2CDFRGqG0zTgUyqlEPrd7ENsfJYxpViFQipwz404A/i9c/tXbf
         hIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8q3N9QJP0kKocjZRYLcTGHxt0dwwrAq7qRa8kv+RaP8=;
        b=bWxPKp/iCVLHrOEB/tiMRPA4s9ZCfLTtuoYqdwu4kRSf9P7qHcq2TcVacVQ7aesKgN
         3EmOPM6P4yNLicNwP/QzrGqn0a6Iy9GNIyJoxv8sQv0kSJGfNSvwmEKGExY1+X7E91kq
         NMFioxqyiharbfeXsJ84p9SwOFVlKC1crsrK5uACV1e2Z/WN6h/EKJ13Gf9UxIvIlBDa
         wIYczUDX/7vnbYWZlfGuuzSFxBpI68YM+Y/n1FwMk/N/WmPR7mPvWwjWaK0vpinMnLFk
         Tzh1sdKfL55VYI6Zsvj7/3N7r5bveY4XEVCG3lH/nNi5qxme1D8EdH7Cd+OjHuX0FtAm
         Yb7g==
X-Gm-Message-State: AHQUAuZY1vS3aW/Ajna6JEqUV1kvltcAkHsvS9IuZqfl2f14+ceBCa+Y
        ZlYg2AaidZz/Y5MKZyHEr7TV9A==
X-Google-Smtp-Source: AHgI3Ibtg5Uyn8iJDbrCmsGH9KS5wPuVnCgbYmpMY9BakQZBNW/xdDAtNRuK3HRSWE/k+zCWcr8Igw==
X-Received: by 2002:a5d:4fc5:: with SMTP id h5mr2264960wrw.84.1549967969283;
        Tue, 12 Feb 2019 02:39:29 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:28 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 28/37] ARM: davinci: cp-intc: convert all hex numbers to lowercase
Date:   Tue, 12 Feb 2019 11:38:26 +0100
Message-Id: <20190212103835.7768-29-brgl@bgdev.pl>
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

Use lowercase letters in hexadecimal numbers in the cp-intc driver as
is done in most of the kernel code base.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/cp_intc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index bf77b6950273..dcd43b067a6a 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -23,19 +23,19 @@
 #include <mach/common.h>
 
 #define DAVINCI_CP_INTC_CTRL			0x04
-#define DAVINCI_CP_INTC_HOST_CTRL		0x0C
+#define DAVINCI_CP_INTC_HOST_CTRL		0x0c
 #define DAVINCI_CP_INTC_GLOBAL_ENABLE		0x10
 #define DAVINCI_CP_INTC_SYS_STAT_IDX_CLR	0x24
 #define DAVINCI_CP_INTC_SYS_ENABLE_IDX_SET	0x28
-#define DAVINCI_CP_INTC_SYS_ENABLE_IDX_CLR	0x2C
+#define DAVINCI_CP_INTC_SYS_ENABLE_IDX_CLR	0x2c
 #define DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET	0x34
 #define DAVINCI_CP_INTC_HOST_ENABLE_IDX_CLR	0x38
 #define DAVINCI_CP_INTC_PRIO_IDX		0x80
 #define DAVINCI_CP_INTC_SYS_STAT_CLR(n)		(0x0280 + (n << 2))
 #define DAVINCI_CP_INTC_SYS_ENABLE_CLR(n)	(0x0380 + (n << 2))
 #define DAVINCI_CP_INTC_CHAN_MAP(n)		(0x0400 + (n << 2))
-#define DAVINCI_CP_INTC_SYS_POLARITY(n)		(0x0D00 + (n << 2))
-#define DAVINCI_CP_INTC_SYS_TYPE(n)		(0x0D80 + (n << 2))
+#define DAVINCI_CP_INTC_SYS_POLARITY(n)		(0x0d00 + (n << 2))
+#define DAVINCI_CP_INTC_SYS_TYPE(n)		(0x0d80 + (n << 2))
 #define DAVINCI_CP_INTC_HOST_ENABLE(n)		(0x1500 + (n << 2))
 #define DAVINCI_CP_INTC_PRI_INDX_MASK		GENMASK(9, 0)
 #define DAVINCI_CP_INTC_GPIR_NONE		BIT(31)
-- 
2.20.1

