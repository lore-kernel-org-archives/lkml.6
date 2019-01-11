Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277ABC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97C420652
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="v0mpWBv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389343AbfAKRX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:23:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43841 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388695AbfAKRVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:21:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so16001332wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Gcim/fCIWXhuVX+s1fGkV+jOQ/IrIz2z47zga20lwo=;
        b=v0mpWBv6XnmUKe2KJf6RtmYvLh6zssMGo/7Ed3ozpbGOTYRh1yFOwAQChb078mvqPX
         OZaSfcTpR1T6yUy1cSjzISI40aI/EGfgn1eE+r4vs3mfScbfe22tG8J8bTdtOQn6xu0l
         WUw2ZmDgZuD7hLnWys90B/oxOBRqK9tMJMgO0Sg2kIZJ2/0AiwkIwa+qIYNyxQ9qtPy+
         n8AJMtZT4yJA2EM/y8KkUqRUtd244OVFhORDzCbxt79Dw/NHcQjdsosyVjErxNLJwZdy
         Xa9F7CNTfxz2+8PnXYrK2UoyYMME+CAKl29gW7M8Sw2/yCPaPG7lJ6Q1zSx3UTHUbd7I
         fp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Gcim/fCIWXhuVX+s1fGkV+jOQ/IrIz2z47zga20lwo=;
        b=HeM17deWOZWFG/GbvtQNNbqBdEWyLbGGizZD0izLe184ccCw2AcB3el3Az7E/oy1xH
         ov8UG8lEizAj6H8Jc03YtjK2zQQ6Cr6yFL9N/WRwwF9KoRNCJLFEBXMWQeiBPz2IM26Z
         YSF7m0ScvGVa2E1oXMzOKI00saBFPJo+dmu95lpkodP1gUyOQiZwJgVaJyIyOW6nhV+d
         0BHHzfCgoKcJvPYPDLCU7fjqYn7dym7egu9Ylwaq+Jj2kgJCrDa5yJdcOE/VK3xHjgr0
         VUgM39rogcjY0wwCri5a4CktwlxnISYxKZZ8xmpD2vbxS5WNP5EPAS4UxiQCFVukI69D
         sUOw==
X-Gm-Message-State: AJcUukeiW93xmXW8NZvW49F5lkSqmtN7JjZBs/EVOHH68XcaxhFqPW0D
        UUxg3iAL80Hp5ztZJvSpc9R1kA==
X-Google-Smtp-Source: ALg8bN7+2jcKNRUdShkaj1KvtoUk8sph9ypjcGAX3tEGOZy2GuzEnYt1/hN+5muPJtVP0f2EK9Exlg==
X-Received: by 2002:adf:ba05:: with SMTP id o5mr13869371wrg.325.1547227313793;
        Fri, 11 Jan 2019 09:21:53 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:21:53 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 03/17] ARM: davinci: enable the clocksource driver for DT mode
Date:   Fri, 11 Jan 2019 18:21:20 +0100
Message-Id: <20190111172134.30147-4-brgl@bgdev.pl>
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

Switch all davinci boards using device tree to using the new
clocksource driver: remove the previous OF_TIMER_DECLARE() from
mach-davinci and select davinci-timer to be built for
davinci_all_defconfig.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/Kconfig             |  1 +
 arch/arm/mach-davinci/time.c | 14 --------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..8a09a0ab0ce2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -586,6 +586,7 @@ config ARCH_DAVINCI
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select COMMON_CLK
 	select CPU_ARM926T
+	select DAVINCI_TIMER
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 5a6de5368ab0..740410a3bb6a 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -398,17 +398,3 @@ void __init davinci_timer_init(struct clk *timer_clk)
 	for (i=0; i< ARRAY_SIZE(timers); i++)
 		timer32_config(&timers[i]);
 }
-
-static int __init of_davinci_timer_init(struct device_node *np)
-{
-	struct clk *clk;
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	davinci_timer_init(clk);
-
-	return 0;
-}
-TIMER_OF_DECLARE(davinci_timer, "ti,da830-timer", of_davinci_timer_init);
-- 
2.19.1

