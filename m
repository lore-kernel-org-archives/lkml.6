Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BFBC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7612146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Ys1vvydU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfBHRfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:35:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53249 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbfBHRfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so4362252wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8q3N9QJP0kKocjZRYLcTGHxt0dwwrAq7qRa8kv+RaP8=;
        b=Ys1vvydUDNUwYU0gnGhIbva3qTjPZgvstL7sGj/YsImLr8eKWr7p0uejyveVOoeokf
         OWRiVgMbJRk5U9jqmESOg/H/Tw4/sPGJv3loDyu9dx7DkBreqq0+91YAulwOgLA/8fla
         8/3TAqsHz8UF0w/Im1IS8rmLiWYicOKrdpq1sfTE19rDWDafGfNLhr48vhPjVKKxeAxQ
         mZzsiLALwHFoyQLj59LZj8b4J6RoXtwg2Mswykb28yoDrv4yB6fA7GkLy/uYorzem0a8
         VdoIr70qZJlvViCES4BTk+17ePhPo0w7YDdjDUfagJP4aCCM5y4Fejytxq0HI210WnXT
         PoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8q3N9QJP0kKocjZRYLcTGHxt0dwwrAq7qRa8kv+RaP8=;
        b=GMRmmOUnraRinTfcBwmMoic8YmxujWLafIPiIYnT6LQznsPYjoqexglg9/9yBeHkKK
         jvVF9nYyVFonRadamIwfKb+hKRUIIc+3pJo2Kp9ebcIC2AlPh2BAD0uRkiBx/Mncq14o
         OexG8qGRf3XIQSlMALHs+8Osd33TDXg3PDVa3fQDy6Of/OrPC/WXLoit7F2lbK8oOUp8
         fsudRdJ9JPQS+TIUWF0Wv/SMo4SRwO7tkSSr/wadOv4QqFc17nK8uw1ll2MYm7TK9fiD
         XD1kO3/6dWkCfQKNjpvMA6xgyk+NxAGQdY6wDbh0oCQUfYOkctaXdoVb1CEhbaqmhDyT
         wjIw==
X-Gm-Message-State: AHQUAuaDNn2FIvlf49uk19qh0QaTd7btVxpW6JDyyOVxiXZTamXhctCN
        bJ1KXF+U1yIlICS6E6syCxiaxg==
X-Google-Smtp-Source: AHgI3IbE5KQZmttEIyCq1i7LT+z8O/TFFXbvvsRh+JMd473EfKmLu2i2/yM8joHbI6LAJJg8XvuvmA==
X-Received: by 2002:a5d:63c3:: with SMTP id c3mr17249223wrw.215.1549647336272;
        Fri, 08 Feb 2019 09:35:36 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:35 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 25/33] ARM: davinci: cp-intc: convert all hex numbers to lowercase
Date:   Fri,  8 Feb 2019 18:34:50 +0100
Message-Id: <20190208173458.4801-26-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
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

