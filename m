Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BA6C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C5A2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K6+0YQ2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C5A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeLJQyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:54:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55679 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbeLJQww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:52:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so11621117wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lh3sCoQnHdMfpD8fOEoK0bAy5YMLicHLNk46Xrw66/8=;
        b=K6+0YQ2Fiox/lxukPVq/fEV4HMCQwDKAYv7EciKzm49ulU4Tqnmr8makME83jZBjNm
         LqaNH/fpz1cO4FPldXdNKAnoYdFLapS3MVYlIyXlrOuOJ6vbouT1CjA9p/4wyL6GDa35
         /J5K8vcdF5bw/qEPKmhP5hUopt771KRiTmfHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lh3sCoQnHdMfpD8fOEoK0bAy5YMLicHLNk46Xrw66/8=;
        b=M2H40PnXbkpi9vFm+jHrV68PNBAqxCWR/ms0dqgJYbWlonfUIWfCvWOMPjbKj7MGDV
         xtShwRenkljaTntjT8Svvx8UbLFwRtEAkmzbBfGE19vfTjA8BI7rIpIqLPQlSuhMbKmF
         xhO6raU/oyNCzJzv5esrzORf0gHhwx3TmuXzI0kCUtfC+vuPQ4gz8NCnN2xuT5YI+WBC
         p0d4RMu5lQ0grUyXvGFsGtrr9DpJVxjeLXG+PE0Tp5cUKT2D2F1m/HtnnWx+i0mL6jJ8
         buSr0gIWYQ5wuPESsruM789d6z5yMT+8posWN6LSSWCbs1B5iC3uSFzqvOQf6yeJ3NCm
         ndKw==
X-Gm-Message-State: AA+aEWaOIU2/txuPqc62ZEMFJGNQC9OddRKhv8qLFGQf3eCqiohTs/MI
        +SrIsgVshxidukvS+8/CCwG3A6iXbhM=
X-Google-Smtp-Source: AFSGD/U34fiVY3dmbhbI+GE3mpuAzSSYM5aCtkJWAw7iqyBeOMHnyy0S6ymtYdlVkwb8khDAvgQSvA==
X-Received: by 2002:a1c:ad43:: with SMTP id w64mr10825581wme.32.1544460770201;
        Mon, 10 Dec 2018 08:52:50 -0800 (PST)
Received: from localhost.localdomain (73.59.88.92.rev.sfr.net. [92.88.59.73])
        by smtp.gmail.com with ESMTPSA id c77sm12877833wmh.12.2018.12.10.08.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:52:49 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS)
Subject: [PATCH 3/5] clocksource/drivers/tegra20: Change name tegra20_timer to timer-tegra20
Date:   Mon, 10 Dec 2018 17:52:40 +0100
Message-Id: <20181210165243.5625-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210165243.5625-1-daniel.lezcano@linaro.org>
References: <20181210165243.5625-1-daniel.lezcano@linaro.org>
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

