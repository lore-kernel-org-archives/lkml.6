Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1748FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAC52229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UvlOOgQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407464AbfBNOzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:55:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37837 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439532AbfBNOxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:53:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so6328030wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=USRlKAODwGBhkc4t0PSLqGy7lcGY6/I2eL77kpLurCo=;
        b=UvlOOgQsPQxHmkJ7szJSM5p54chW53QnoTkbSc3MyZnIj7ziJg93BwDcuBcSDW6Dek
         BewEUQvoGbsMiqyS5xuJ/Qjz7ZShbG4qd1gxlrRCrGTIVgMnPmvBOqX1tMmUcFULRqw6
         O6EL7ZvsoqGEM7pA8YPJ6amyjxJySJ+GKecTKqGbcCK9372HWQGUC3HUFxDzLKJGSAnd
         EFhQHM6CqCAZMnmtkDWwbzzf0v7T1w3zCZ2UN5ffj5E9iqnUOtA6U5VEuIcMO8W/RTe6
         2BBVwcjPGg0BZn1JMERMVG5Zm//RUNLVXPKFq5QJR7h2vD95e3uFW9tGlsr2JS7hvfKI
         vvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=USRlKAODwGBhkc4t0PSLqGy7lcGY6/I2eL77kpLurCo=;
        b=IjaTTh2Uc/fNUtRUJyhFxz/yMh5C1vORo7l9+Fg36FoyM9Mr7LmFW5AvzIQ+nn94qy
         QEjyzJoJY0ta14XG/BOnWYrT2Dn6ODG0OOXW5AFyHBqgIuhsPkDTnmm/lAhG/FnoPour
         29CaTh2cHlAxledNIn/J+EA8CWaTq1Pm1Y2NHdH2xtWpzWqEgcUfuXCSBPYtijN4lmsK
         xakI2w40vnCHbqxsRChuyDmqLL0XdDI86dsv/dbQ7UBiC+pzqguPkLZotIHHE/MAz6w3
         57mpDzxudxFO/4eyS7MXg77+mFfbJG4tHXtECXaBtwpmZzFx/PFm/aG3W9dLq19hKURd
         5YAg==
X-Gm-Message-State: AHQUAubDjcjKUscG0mjyHp4OTGhZJY5ikNkx26nHGYM7eb2NH7bM5+3Z
        hdnhJXa/PgEygW/SDr9D8iXiMQ==
X-Google-Smtp-Source: AHgI3Ia/Zne0eSSbxwIyQn5NbbdsWkhVTDY65hDxiZiitNP5qFnlfOhjP3HvvdEdzUuEa328pRq6ng==
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr2874081wmh.119.1550155980091;
        Thu, 14 Feb 2019 06:53:00 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:52:59 -0800 (PST)
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
Subject: [PATCH v4 14/37] ARM: davinci: aintc: use readl/writel_relaxed()
Date:   Thu, 14 Feb 2019 15:52:08 +0100
Message-Id: <20190214145231.8750-15-brgl@bgdev.pl>
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

