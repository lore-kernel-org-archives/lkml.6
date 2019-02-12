Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E530AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39D820842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Yf9NbJAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfBLKjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:39:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38882 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbfBLKjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so2442507wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=USRlKAODwGBhkc4t0PSLqGy7lcGY6/I2eL77kpLurCo=;
        b=Yf9NbJApVtLWNLVYUeLEcKq5Da86bYDRitPJ5CVjAw+GpyU7YtU0b6nUhwdngeIXYX
         w5bobTS4xxf6vGlL87Rq8qgBTnjvYOsj8svkDmPCz/znvYdjMUZEA5R2bLiCjsA/Krg+
         nQOatKBQUzUUZLX74chDaoFzRTVfimf4U9+yqUALMNmFNZq/Vx6DPfc4DbBLoPtgdoNr
         aV4V2Ln0TLXZEjakUs86jHvu44Z5SVTizA8Vy1DOvXfvroeDynAP80z8uiQT8QvzLsWY
         wr3pZVYolc449TeOYXnqosxNLdmgVAB+LM/a/84YFX6dJhVSknleet7EmLo3W1ktYZcZ
         hZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=USRlKAODwGBhkc4t0PSLqGy7lcGY6/I2eL77kpLurCo=;
        b=Y/kWgbXuq4RJAiV0lGlpbE+tDGOwXuYoJPgZ/ApEeJM4mDvmamK8YDnyeFr8QA9jSy
         HT2gSiNarPk/X/iR2LYRBAesLpe+TyQJ3aBhpdrweu/hjl2D4NIotBgISDCJgPKb+V8G
         nK6sSDIu0vVwTGSS62GNxJO4MVd5gNg8UCyzYGkgOMGt2nr/D8V4x15KmgviVt5b+80j
         YN1H0DA3sf7M1XM7x1xxsUjtratlS4YUDO9d5yafv+I8X4bNjSDEUEf0E56NBvMHbWZt
         YVO4qH8TNDyfi5IWC2guQHWJHfwof5B0uY6jszAOTzOSIaL3F8pwX/N7OBFj3z0/KN+Q
         YCbA==
X-Gm-Message-State: AHQUAuYEXJhRwdz2gn8DpEKLVUj2CADlsF0c9/er2FqrLorvZasIq/Sr
        YMkukCXg8Vyb/WuGoJtJaccc4N+7Ezw=
X-Google-Smtp-Source: AHgI3IY33oqmLWPySwliC2gvpnXPIS7TecwKtWsdiQwm9jvsGx0XaNxXkSjjO8YOjEgUmkP8T/e4+Q==
X-Received: by 2002:a1c:f701:: with SMTP id v1mr2251393wmh.153.1549967953310;
        Tue, 12 Feb 2019 02:39:13 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:12 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 14/37] ARM: davinci: aintc: use readl/writel_relaxed()
Date:   Tue, 12 Feb 2019 11:38:12 +0100
Message-Id: <20190212103835.7768-15-brgl@bgdev.pl>
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

Raplace all calls to __raw_readl() & __raw_writel() with readl_relaxed()
and writel_relaxed() respectively. It's safe to do as there's no
endianness conversion being done in the code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 2df91fc0dade..509be44eda22 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -36,7 +36,7 @@ static struct irq_domain *davinci_aintc_irq_domain;
 
 static inline void davinci_aintc_writel(unsigned long value, int offset)
 {
-	__raw_writel(value, davinci_aintc_base + offset);
+	writel_relaxed(value, davinci_aintc_base + offset);
 }
 
 static inline unsigned long davinci_aintc_readl(int offset)
-- 
2.20.1

