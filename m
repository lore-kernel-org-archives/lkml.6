Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5273FC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169C52082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U0ctYBij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169C52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbeLJQwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:52:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35888 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbeLJQwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:52:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id u3so11242287wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gb4QAzm/KkE/XU1ketpNUvqBhzZcGDx6YZBMsdzWQdg=;
        b=U0ctYBij/4cZvO3yf+/DVe3zwvzV5uO5+SxWngaxhfJmPN6DEbSUb1t6eM54pNants
         bIJW+Gs++VoBaO6pA5qN1fNgEFyYmnP/twr3NThdxNS8AQOoKVpq1ajJpFCCLz2VF82w
         OltcdM79/5utH8nAABBZOPr+36SKQrbZ4Z4As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gb4QAzm/KkE/XU1ketpNUvqBhzZcGDx6YZBMsdzWQdg=;
        b=I5rXtyeB/1Nwaxf/O1w4XaZA8CQkd2xMUFJSY9los/ejuYnWfS68qyDADauMD7BzrG
         gbXy3G9niRVa+C9caZLRgtCq6TGvtHBhZhzSB9GX6PC8Z2P0KnsWcpFQSakQcphNOCdX
         ltpbKypMeIsu6Yg0CGRtzxKrByOxfL9CCDwrbvTgmX9VaDTh2Uq5KJHfmgva2sk8GDXm
         XRo9mQn2Mq1A8nkdhRlwYOGOmlBjylK2OqD/fpYXEaqnV0W7KAyDTJZd5K+J90BJBGao
         kQnD5sQbCA7apDWe2YWfmBkDpXho0R00m4rYBSxkeLFoaNDGUlAMYRiHNKzwc0UIFw5L
         RwjQ==
X-Gm-Message-State: AA+aEWahPjeJfBoHvUnqlgktM90KbMvkN8RC0kBigs8g83BhjPeqSgWS
        R+GQXuLoYxEdi2y+C63xbkn8Bg==
X-Google-Smtp-Source: AFSGD/U3W2rAo3iuNGnMUTA12AmfK8yH6zKQnneopjAec4/bOrT3ZRN2jZFVQfcKJWdF8fgjs7ZWPw==
X-Received: by 2002:adf:9d4c:: with SMTP id o12mr9839454wre.94.1544460771424;
        Mon, 10 Dec 2018 08:52:51 -0800 (PST)
Received: from localhost.localdomain (73.59.88.92.rev.sfr.net. [92.88.59.73])
        by smtp.gmail.com with ESMTPSA id c77sm12877833wmh.12.2018.12.10.08.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:52:50 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS)
Subject: [PATCH 4/5] clocksource/drivers/sun4i: Change name sun4i_timer to timer-sun4i
Date:   Mon, 10 Dec 2018 17:52:41 +0100
Message-Id: <20181210165243.5625-4-daniel.lezcano@linaro.org>
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
 drivers/clocksource/Makefile                         | 2 +-
 drivers/clocksource/{sun4i_timer.c => timer-sun4i.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/clocksource/{sun4i_timer.c => timer-sun4i.c} (100%)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index e02c1af0c716..37732cb5710c 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -32,7 +32,7 @@ obj-$(CONFIG_MXS_TIMER)		+= mxs_timer.o
 obj-$(CONFIG_CLKSRC_PXA)	+= pxa_timer.o
 obj-$(CONFIG_PRIMA2_TIMER)	+= timer-prima2.o
 obj-$(CONFIG_U300_TIMER)	+= timer-u300.o
-obj-$(CONFIG_SUN4I_TIMER)	+= sun4i_timer.o
+obj-$(CONFIG_SUN4I_TIMER)	+= timer-sun4i.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
 obj-$(CONFIG_MESON6_TIMER)	+= meson6_timer.o
 obj-$(CONFIG_TEGRA_TIMER)	+= timer-tegra20.o
diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/timer-sun4i.c
similarity index 100%
rename from drivers/clocksource/sun4i_timer.c
rename to drivers/clocksource/timer-sun4i.c
-- 
2.17.1

