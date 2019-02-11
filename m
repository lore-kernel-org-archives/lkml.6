Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123CAC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F6B2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="G4hk+Onz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfBKM1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:27:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52519 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfBKM0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so17486267wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8q3N9QJP0kKocjZRYLcTGHxt0dwwrAq7qRa8kv+RaP8=;
        b=G4hk+Onz7gZcvgSYg0Zr5+/mm768DifKcmh7HQJXbmiMi+XAl1Bil4m8X3KjOkLQEY
         l1/Im4dyraPFkQBE/uufiL5zSZodyZsGZWKz30hGNFZZpra71Now21tl41jTpOOLTTRZ
         btobsynMlDlKYCfeUosW9bQWTcFxNt7XWBEBP9T3EP1kqDAzHcZlan9+xZB0Xo6Fs967
         Qjk4XcftC3qjV8MORW3g5JMEgnvMpU0Yt8Y5ol66wKOMbo9f0g8uZIEu70MdkLiwSTo8
         f+wQX1X3myt25dFxhXmoJ6oIakq4Jf2Jvh9Qg701ZSKvnO5u9H4EsccWX9DjGLTKO3qa
         PCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8q3N9QJP0kKocjZRYLcTGHxt0dwwrAq7qRa8kv+RaP8=;
        b=QrjJcjRQIWx1ZyM5NOG14tH2RefM9HtYEg8BhLZeuDL9PQoB8B7Qcr/PoKv4IkWYPQ
         olinVZHVkep38HWn3TSfAMx77V2sEQ5LkcARnrsgc2lqUGC5Hlqz6TbHAoeMovDtIay1
         cyqU45F3OTm1snXL8k9mEIMg7APB8QN6YEEL0+OOeAZC/bjlKWI13x1w5stNW/u0whqH
         K2eFE22pnrFjDksVdpj5nuheVR/e0kKwNJthWk08flg8EpgvfLwlvzXv/lqFdMpJacbO
         q0NKvbn6nkM0GYD5W79pqGmY9dOv4n0IC8Dp5rvHLmA5j9ng3ClAlMsCRicrzolriU+V
         QTQA==
X-Gm-Message-State: AHQUAuZf59tvy7AEC3eavXIUQ++0sPO0oEcfdp3vG3V8kW/XDEXA0UhG
        l2/XTHDRYCDuqXtjRdS9bjBwCA==
X-Google-Smtp-Source: AHgI3IZYS4gxKl9Si7JH5QZM38ZIE/i8h8HTjvrFh2lJMk3GXbuojDqcRm71UPvwu9/+/LsyLucPKg==
X-Received: by 2002:a1c:b40b:: with SMTP id d11mr5433674wmf.80.1549888003973;
        Mon, 11 Feb 2019 04:26:43 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:43 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 25/33] ARM: davinci: cp-intc: convert all hex numbers to lowercase
Date:   Mon, 11 Feb 2019 13:25:58 +0100
Message-Id: <20190211122606.8662-26-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
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

