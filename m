Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EB1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139CF21848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kfhQSPA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfBZOzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:55:14 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37022 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbfBZOyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:54:39 -0500
Received: by mail-lf1-f66.google.com with SMTP id z196so9144848lff.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 06:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CizRMe2YmHoMDQUcJ8913XbNFEFzGgJHDQtzao5WKiM=;
        b=kfhQSPA9AMik5mPi+zuWznWRU+Lb20kx5Yl1pd6vQyrPRfnG2ZYWVm4Hs9i5AjRK0b
         GnRrB3iYlXym2YsokbhWJCIunemOZzuO9vuqHFOLcbCrDm3wSn0ZApSiB3kPmMZT4ZVe
         dmDlZ3gGNBUQRE0rvOZn3OW2DWmlz6edcGX8vVCXxzAE2yqcdM3MZffJJb7PJBdYLj5l
         5oQcGO+AlfUyq47Vsk9LJnj3r6W/fZpU73n4kFJDER7GNwbFFwflAQ8+q7a+UCe6ax7Z
         8ZJPmf7ugZk/AuUGSuMdngYkcUPATcadWzlgy7bJo/HoChaXuWSMnkbwXRIT90W6tXrv
         Rugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CizRMe2YmHoMDQUcJ8913XbNFEFzGgJHDQtzao5WKiM=;
        b=jVw27NpbYNqlTXWXOddInuTqmXAKHW/tCh0FjKLakiRqqy2cdJVx9HD2Lf0e7wFFHo
         I9HzsYqyuvYj5bS/FRlY5vmyYtLGL3KiSqA5hTPYDnXaXTyF/TXNQTo4B+r5ZOW8nvjK
         e0if7FU7oyKcPqZXX29z9/7OEgUmruojoYuxHxiQ36yuPoNbAUhL2BH/xzgjxZriSd14
         1g3inZVZ0yBJ+mSQD1eFDkqbRUe1sRsx/S1UNMvlcjKeHthAkW95aCRO4oj4sCL/aQBD
         0JdxQw02khQaNgLT/lSpOFHYGd+W/SlT4sCu/kDjaXvGr5UWWcr8+voANKgjt2kvpr2y
         f5+Q==
X-Gm-Message-State: AHQUAuYIZEvEELWMjpBsUUzNhFMMpn43R16m/nf+qtneYKn6lv2buiF+
        N1ZSUhx+4ONb1DVxH6SC4x4gBA==
X-Google-Smtp-Source: AHgI3Iaxn87jYxFUqbmB5XhLkCIJqJ/F1RTwFyjp9WrstSdbqh+lc5QmyHlpoFkyjdolp9R2+2X54Q==
X-Received: by 2002:ac2:4154:: with SMTP id c20mr1623972lfi.74.1551192877411;
        Tue, 26 Feb 2019 06:54:37 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t11sm2206554ljj.92.2019.02.26.06.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 06:54:36 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 4/8] cpuidle: menu: Convert to tick_nohz_get_next_timer|hrtimer()
Date:   Tue, 26 Feb 2019 15:54:11 +0100
Message-Id: <20190226145415.19411-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226145415.19411-1-ulf.hansson@linaro.org>
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

Rather than using tick_nohz_get_sleep_length(), let's convert to use the
more flexible tick_nohz_get_next_timer|hrtimer() APIs. This should have no
functional change, but allows following changes to later drop the
tick_nohz_get_sleep_length() API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
[Ulf: Clarified information in changelog]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v11:
	- New patch.

---
 drivers/cpuidle/governors/menu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 61316fc51548..95e9122d6047 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -286,14 +286,26 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	unsigned int predicted_us;
 	unsigned long nr_iowaiters;
 	ktime_t delta_next;
+	ktime_t now = ktime_get();
+	ktime_t next_hrtimer = tick_nohz_get_next_hrtimer();
+	ktime_t next_timer = tick_nohz_get_next_timer();
 
 	if (data->needs_update) {
 		menu_update(drv, dev);
 		data->needs_update = 0;
 	}
 
-	/* determine the expected residency time, round up */
-	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
+	/*
+	 * Compute the duration before the next timer, whatever the origin
+	 */
+	delta_next = ktime_sub(next_timer, now);
+	data->next_timer_us = ktime_to_us(delta_next);
+
+	/*
+	 * Compute the duration before next hrtimer which is the tick
+	 * or an earliest hrtimer
+	 */
+	delta_next = ktime_sub(next_hrtimer, now);
 
 	nr_iowaiters = nr_iowait_cpu(dev->cpu);
 	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
-- 
2.17.1

