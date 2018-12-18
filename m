Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B799EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EB621871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NhWBv41U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeLRVaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:30:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43154 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbeLRV3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so17394079wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qjdnO2DNnqjz1/W8KEFUahSKSMHQuREy7uvLbg+oEK0=;
        b=NhWBv41U0b9TvcFoepiSDva/yz65qxyZ+OuqdvQCx3sS2HNa+BqzYYdWbQkDNtqpOI
         /donnEpZSPwN1Nb8yb8ZWJSaL2QgZJX7ao1pLoWe+OhD4KlUXuAjRzxAKS/8XGJjvZwt
         zCgIk1D9NKMljk8j8UTOJekxLnEXu72LJMr8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qjdnO2DNnqjz1/W8KEFUahSKSMHQuREy7uvLbg+oEK0=;
        b=TaFKtbxCBt11RJ1sLypt6dsr4abA+6U4QoVXEBBSoK7BWIAlBcu4d4zDOz5POj1ikx
         gm8lfGkvtfvGxAZPGb36QDbgGQeh/fEGNegMt0Gx+2q6oz3SMuhZwer/Le5g7SOLVmqG
         dPu9GQbr1fTOb3UTE+vDcUiyPOMjWRMYdqWtX79XwYe0vJ+mXFhoTNRl1pPJGYDhfU1v
         ANlJMpMKRjiUKJpryvqYJEzxmoKvBna8uObBA8s0w51Nxzz4OQ85s7wYpQCzVUqw6HM7
         TE7IRmqas1zKI6m6sT1yPJNcp3og4g6OFZ/MUOk29nIv7trWX366czZ4QsCYR/OXw+6K
         lkug==
X-Gm-Message-State: AA+aEWaPNozjeMgiVMAa7tqPK5wgyh4sGw4iCV6APrrkn5GQj4WnVZ6z
        57vHngTwkT6RBQ2c8Xw9KM2fUCqG+3s=
X-Google-Smtp-Source: AFSGD/UmJhqESlQBHcpgIaimW9zhNDulaI7tj9VSRDXFaKCku54c737HHjN5/LY16on+cAnUkSo2rw==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr16845725wro.262.1545168585716;
        Tue, 18 Dec 2018 13:29:45 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:45 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 24/25] clocksource/drivers/meson6: Change name meson6_timer timer-meson6
Date:   Tue, 18 Dec 2018 22:28:42 +0100
Message-Id: <20181218212844.30445-24-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to unify the names in this directory, let's rename the driver to be
prefixed with timer-*

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Makefile                           | 2 +-
 drivers/clocksource/{meson6_timer.c => timer-meson6.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/clocksource/{meson6_timer.c => timer-meson6.c} (100%)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 37732cb5710c..f475927d5140 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -34,7 +34,7 @@ obj-$(CONFIG_PRIMA2_TIMER)	+= timer-prima2.o
 obj-$(CONFIG_U300_TIMER)	+= timer-u300.o
 obj-$(CONFIG_SUN4I_TIMER)	+= timer-sun4i.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
-obj-$(CONFIG_MESON6_TIMER)	+= meson6_timer.o
+obj-$(CONFIG_MESON6_TIMER)	+= timer-meson6.o
 obj-$(CONFIG_TEGRA_TIMER)	+= timer-tegra20.o
 obj-$(CONFIG_VT8500_TIMER)	+= timer-vt8500.o
 obj-$(CONFIG_NSPIRE_TIMER)	+= timer-zevio.o
diff --git a/drivers/clocksource/meson6_timer.c b/drivers/clocksource/timer-meson6.c
similarity index 100%
rename from drivers/clocksource/meson6_timer.c
rename to drivers/clocksource/timer-meson6.c
-- 
2.17.1

