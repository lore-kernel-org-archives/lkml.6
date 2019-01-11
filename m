Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7EFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18B721872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="P4Zaqs3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389178AbfAKRWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:22:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50654 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388963AbfAKRWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:22:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so3142094wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n0bVZLgHbmzlF03gwgM80KrrXfKmVICzK0GHI6qGu7k=;
        b=P4Zaqs3dsRMJPeYeCFa7pQy39C0RU5Nxi1+EcHbOFpAvPiWdHx5IuJl0TqhOKz4BEZ
         43n1l1P+Jzb7d9PSwCXTajQ5YVhlCDZJ/wVeIKJ25obXdtjn4x7PiuPLl0faHKyDevgg
         +kb7Uyo2vtNGi+emB8APf8bpuuGzpcY/ZAPtdqOlksIkUza0pHwvGifUt0deIJNf+OxJ
         OUjJ8H26si9xpxrFBIesEGQfEfp03dlGQFyGVO75+P4HV8tmjfz6xGMW6DvcPtkXUKXH
         JQVJobCw6GubRj8ElpNLlKosPYRC/T9wUm86JxGGyNHufj1L3b6JfJBUlJBp5PWAiJ0a
         o1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0bVZLgHbmzlF03gwgM80KrrXfKmVICzK0GHI6qGu7k=;
        b=TeMLOZUo4x9ArRUsweskEst5Vuz1gn9bEWt7VW/oyTIPVqG8x9A+H7XXKkjkK1hZlb
         xPG+dVQ6gFBUIr6/PIb3KAWDVxhspOuyz8K5HSi+hVXb3POMTbiqct6PpU6a42YOl8oK
         46fizOdpV3RK4dGE3T1tB625ZdbwNNp9VKuQs+hmcRzb6ECLsym3r5/1XzntTpgeE9Er
         b44MnT7mhaGqgc15Pa+dWr8+23zkoHbuLth8OnNge1o2omTgJgmFgas+N+BeJ8zfklAM
         pTpVxcsSre5Qje2sbIIk8DGgfnXCgwEVtce/ZyLYBnEaLCUEPBSmiVUdaKpOEPDDUoXe
         4+XQ==
X-Gm-Message-State: AJcUukcZGhuSaQ3hYgMFSkFXeYCEleqa/PxgRRdzSUzklG0tEZmQgnqV
        7GrrnujqYpRvqzvQYaq/8qllvQ==
X-Google-Smtp-Source: ALg8bN5J+hjbdWKxB7wzxjnbO+WQR5qkiW3Or0dYV5k+JRvpiMPQ8kb9bkUExWE9fXq7QNWC8PRwqQ==
X-Received: by 2002:a1c:85d2:: with SMTP id h201mr2933588wmd.151.1547227325088;
        Fri, 11 Jan 2019 09:22:05 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:22:04 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 12/17] ARM: davinci: move timer definitions to davinci.h
Date:   Fri, 11 Jan 2019 18:21:29 +0100
Message-Id: <20190111172134.30147-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Boards from the dm* family rely on register offset definitions from
arch/arm/mach-davinci/include/mach/time.h. We'll be removing this file
soon, so move the required defines to davinci.h where the rest of such
constants live.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/davinci.h           | 3 +++
 arch/arm/mach-davinci/include/mach/time.h | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index db4c95ef4d5c..dfd1b1ab7b59 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -60,6 +60,9 @@ void davinci_map_sysmod(void);
 #define DAVINCI_GPIO_BASE 0x01C67000
 int davinci_gpio_register(struct resource *res, int size, void *pdata);
 
+#define DAVINCI_TIMER0_BASE		(IO_PHYS + 0x21400)
+#define DAVINCI_WDOG_BASE		(IO_PHYS + 0x21C00)
+
 /* DM355 base addresses */
 #define DM355_ASYNC_EMIF_CONTROL_BASE	0x01e10000
 #define DM355_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
diff --git a/arch/arm/mach-davinci/include/mach/time.h b/arch/arm/mach-davinci/include/mach/time.h
index 1c971d8d8ba8..ba913736990f 100644
--- a/arch/arm/mach-davinci/include/mach/time.h
+++ b/arch/arm/mach-davinci/include/mach/time.h
@@ -11,9 +11,7 @@
 #ifndef __ARCH_ARM_MACH_DAVINCI_TIME_H
 #define __ARCH_ARM_MACH_DAVINCI_TIME_H
 
-#define DAVINCI_TIMER0_BASE		(IO_PHYS + 0x21400)
 #define DAVINCI_TIMER1_BASE		(IO_PHYS + 0x21800)
-#define DAVINCI_WDOG_BASE		(IO_PHYS + 0x21C00)
 
 enum {
 	T0_BOT,
-- 
2.19.1

