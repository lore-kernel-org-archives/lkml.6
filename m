Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE019C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F35E20675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uUog+D/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501886AbfBNOxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:53:21 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46167 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403823AbfBNOxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:53:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so6754184wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8q3N9QJP0kKocjZRYLcTGHxt0dwwrAq7qRa8kv+RaP8=;
        b=uUog+D/oKttVDMLhRi9vrj67h8wdr6KEtDiMBxibvbdVOe1mGbls+moY9aNn0KD9yd
         vjecMk9hIgSEAulXrDIFFM9LhtqTfG9TfAn5AuwmBHOAE9VijCXzvSO/oYZzLvJ6S3Gd
         vhaLS9aJOyrOe44LtW3hWuaxtZljlVOK8irVyXF/SF+FGubzm6p4Iw3VS3pht56BGop6
         ceUOcbXah87x/Dc7NJueioqHEf375EpEP3Sg/2FBkLJrdP5nvKvZ85z7r27wBs/IZv6e
         cerMyu0rQSS01gl1iip6o/n+vOVfDy7iPfnntvugkqnlf9LTFrAoiUjVomf6Zg/EenFB
         wTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8q3N9QJP0kKocjZRYLcTGHxt0dwwrAq7qRa8kv+RaP8=;
        b=EoQMNSVvmn4/GtVjtq+hmZUtO0rrSd4ckHGInUhM05K0yA6uHQvNpAaRPJ18XeGDOp
         bD8JI0eTf59By2gTYkZC0SSr0bWKPPIjn1KQGJ13BPBPylRR7GrHDgS2AoDueaGGVfu4
         1BiSPQ2H0Zv18aisx/iRjqgbLHzpq8NxC6H9fc0NVPXM9LgGthaJghiG1fo/O/UwMIjH
         FlFiGYHVj8q6z1/lP3hBw0An4XkC08WseKZNuCY77i0wcl6hauRRq+gRDmiZOYNp24yA
         Ml3eWPqiqngDKf2lAiMwX5Tm88fMZljiN1+/1RFqBfYtcDqoSaYzvpwoIDXADYHJxNPF
         dpXw==
X-Gm-Message-State: AHQUAuZNVBUL4743dbh/nBWt1YrF9CG0ygg7miBM5c4o0hu13tAK8MVL
        nPuUeES3mDf7mUuUMdjH/7R7xg==
X-Google-Smtp-Source: AHgI3Ib5IY/5ytavfRpr2jYwXScL14+R1vz3cHJ6ITvL0P1j40cSPlrCaqhcGCab0WXDuqZaqnVAWQ==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr3063733wrx.74.1550155996229;
        Thu, 14 Feb 2019 06:53:16 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:53:15 -0800 (PST)
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
Subject: [PATCH v4 28/37] ARM: davinci: cp-intc: convert all hex numbers to lowercase
Date:   Thu, 14 Feb 2019 15:52:22 +0100
Message-Id: <20190214145231.8750-29-brgl@bgdev.pl>
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

