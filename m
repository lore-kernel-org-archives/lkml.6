Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5CEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFE321871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fyl+vxoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeLRV3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:29:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36694 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbeLRV3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so16445164wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lh3sCoQnHdMfpD8fOEoK0bAy5YMLicHLNk46Xrw66/8=;
        b=fyl+vxoTll6hhyE4Xmv6PhdYvjTcnFAsPYLimWBOgJk1ZSRTZHdWiOScHg/emoUaFb
         qu8UsscVTFuvzdHt7zNGTMWEr1LpNRQJpAaCYDvnt29WrCOK6EwYhDbZacaPMq+uP0a6
         e57sE8IKEuI3oUAkuFtxJDVdjFm4c8skmg5+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lh3sCoQnHdMfpD8fOEoK0bAy5YMLicHLNk46Xrw66/8=;
        b=JQHm7fFX4QrApUFVkGAKuSJ+ECOtYbT1S3t9ZPo8QnT+fOwN/gVX7elhWbRlMlVrLJ
         S89U/d9ZKCZsgnRRzlz1cJknRuaEmTcAA3vX1fAFfd39SkpTuxVXQyDKkBLr+Q0DcV+j
         /QjR1OV9u5YEAWJJL9OrydJtAi+i1riswaYEAhJK9A6Eb8/ubo8esA3/Y9rPjZiOM04F
         2RP51H07no9xW1AnNlPS4GImrp67PKU2yKMkqwcPaYuqEA9ko6wS0S6JKl4dCK5Lkya8
         oLP/vfCgHMM2iAK4S5XD8fiq7V3vU+9WaTnSVhWvu5jlB+gWuw60aUJPwPI1hu/t0NEe
         8uSQ==
X-Gm-Message-State: AA+aEWYwiaZp9N5+MBMXR9zDvEkx3TiTt53jZJ54bh7zXOU6sliLLv4F
        OVkKS/9mzBpdDKcB5/dkzCEXSA==
X-Google-Smtp-Source: AFSGD/XWyXDrgh5RfioAiVh7WHvWABGKq+e14wEOiY+AE2DIuC2LinhUrxkPV9C6nejyBgPjzCQFnQ==
X-Received: by 2002:adf:f605:: with SMTP id t5mr15167814wrp.229.1545168582927;
        Tue, 18 Dec 2018 13:29:42 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:42 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 22/25] clocksource/drivers/tegra20: Change name tegra20_timer to timer-tegra20
Date:   Tue, 18 Dec 2018 22:28:40 +0100
Message-Id: <20181218212844.30445-22-daniel.lezcano@linaro.org>
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
 drivers/clocksource/Makefile                             | 2 +-
 drivers/clocksource/{tegra20_timer.c => timer-tegra20.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/clocksource/{tegra20_timer.c => timer-tegra20.c} (100%)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 9d0c0fa0d69b..e02c1af0c716 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -35,7 +35,7 @@ obj-$(CONFIG_U300_TIMER)	+= timer-u300.o
 obj-$(CONFIG_SUN4I_TIMER)	+= sun4i_timer.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
 obj-$(CONFIG_MESON6_TIMER)	+= meson6_timer.o
-obj-$(CONFIG_TEGRA_TIMER)	+= tegra20_timer.o
+obj-$(CONFIG_TEGRA_TIMER)	+= timer-tegra20.o
 obj-$(CONFIG_VT8500_TIMER)	+= timer-vt8500.o
 obj-$(CONFIG_NSPIRE_TIMER)	+= timer-zevio.o
 obj-$(CONFIG_BCM_KONA_TIMER)	+= bcm_kona_timer.o
diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/timer-tegra20.c
similarity index 100%
rename from drivers/clocksource/tegra20_timer.c
rename to drivers/clocksource/timer-tegra20.c
-- 
2.17.1

