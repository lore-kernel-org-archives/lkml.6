Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0D7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC6B21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5rY8VCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeLRV3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:29:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40583 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeLRV3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id f188so3586595wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rr8ilS5R2vpccRIsS+2N6f0DuRbVwp+GBmj6taBD1mY=;
        b=O5rY8VCFJBLsJjZEfMJpQbik9HuaGYFaN58CoKBHTdjKAhQV3d8PHLhhsCSB2hzRdi
         WoH6JlYqCXGLUpQyUnT3B22Wp4yON6pwtsOaqov4kQl1uA+GtS+VMcu6phk6qfTM1uvn
         HEPUzSfUTTHyJf1UhX2wmCROtZSxPYjlEy8cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rr8ilS5R2vpccRIsS+2N6f0DuRbVwp+GBmj6taBD1mY=;
        b=g6Yf/7yJ96LjY7roF73YXeZj8ZLre2C7PsejR/h3MprDXmYKRthz6OBpQBet///xS6
         Cc2+BgI3+M8rCkI3YtTI9Yt+QS/wVE9zXmaqEp5T3P8WNvBRWXP2XRUMbqUGo3FzAECH
         132AuPnec6q45ixS4gYVBq6DZMqYBTD47xh+nlUTk3qWYFCyFYKnAfcCQAy5zvmdep0i
         iqBLZYsaPA0i6FXIJQVQP7xkOZxg1n/CLn52j7pEO8CBMvWTwMgRaIH1LKfxYC+IoFEe
         MeWVhOxvGYw3OSiKWlS9qAzsIp/JGsZX/ZRazffPd3Y9lUVx57/c3LIlAwPTnvcfSM4K
         u58g==
X-Gm-Message-State: AA+aEWarOtL/d9eyPuXc6VZJtMq8eYqj5WOVHjYnVll5KhZpflHR1tmn
        +Hn0VhamEhEM6sLwxthKKNvIyw==
X-Google-Smtp-Source: AFSGD/XBMcbGYHJexD92ZRoywtxkABvAWeCghfEYJx0q57OeF172iSaCilTJqoOUlutEheoahdvxzg==
X-Received: by 2002:a1c:a8d2:: with SMTP id r201mr3689046wme.81.1545168556553;
        Tue, 18 Dec 2018 13:29:16 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:16 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <treding@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH 05/25] clockevents/drivers/tegra20: Remove obsolete inclusion of <asm/smp_twd.h>
Date:   Tue, 18 Dec 2018 22:28:23 +0100
Message-Id: <20181218212844.30445-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

As of commit da4a686a2cfb077a ("ARM: smp_twd: convert to use CLKSRC_OF
init"), this header file is no longer used.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/tegra20_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index aa624885e0e2..4293943f4e2b 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -30,7 +30,6 @@
 #include <linux/delay.h>
 
 #include <asm/mach/time.h>
-#include <asm/smp_twd.h>
 
 #define RTC_SECONDS            0x08
 #define RTC_SHADOW_SECONDS     0x0c
-- 
2.17.1

