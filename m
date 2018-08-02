Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B1FC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F8821501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F8821501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbeHBNbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:31:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41505 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387403AbeHBNbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:31:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w72BdrAe3485366
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 04:39:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w72Bdq9J3485363;
        Thu, 2 Aug 2018 04:39:52 -0700
Date:   Thu, 2 Aug 2018 04:39:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Keerthy <tipbot@zytor.com>
Message-ID: <tip-c77aee71bbc67c4b0e56f4ce10406b85d4c929c1@git.kernel.org>
Cc:     j-keerthy@ti.com, hpa@zytor.com, linux-omap@vger.kernel.org,
        t-kristo@ti.com, daniel.lezcano@linaro.org, d-gerlach@ti.com,
        grygorii.strashko@ti.com, tglx@linutronix.de, tony@atomide.com,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org,
        mingo@kernel.org
Reply-To: tglx@linutronix.de, grygorii.strashko@ti.com,
          linux-kernel@vger.kernel.org, baolin.wang@linaro.org,
          tony@atomide.com, mingo@kernel.org, j-keerthy@ti.com,
          hpa@zytor.com, t-kristo@ti.com, d-gerlach@ti.com,
          daniel.lezcano@linaro.org, linux-omap@vger.kernel.org
In-Reply-To: <1533191716-20476-1-git-send-email-j-keerthy@ti.com>
References: <1533191716-20476-1-git-send-email-j-keerthy@ti.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] clocksource: ti-32k: Remove
 CLOCK_SOURCE_SUSPEND_NONSTOP flag
Git-Commit-ID: c77aee71bbc67c4b0e56f4ce10406b85d4c929c1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c77aee71bbc67c4b0e56f4ce10406b85d4c929c1
Gitweb:     https://git.kernel.org/tip/c77aee71bbc67c4b0e56f4ce10406b85d4c929c1
Author:     Keerthy <j-keerthy@ti.com>
AuthorDate: Thu, 2 Aug 2018 12:05:16 +0530
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 2 Aug 2018 13:35:08 +0200

clocksource: ti-32k: Remove CLOCK_SOURCE_SUSPEND_NONSTOP flag

Since commit 39232ed5a179 ("time: Introduce one suspend clocksource to
compensate the suspend time") suspend/resume fails on AM437x platforms as
the clocksource actually stops in suspend.

Hence remove the CLOCK_SOURCE_SUSPEND_NONSTOP flag.

Suggested-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <daniel.lezcano@linaro.org>
Cc: <linux-omap@vger.kernel.org>
Cc: <baolin.wang@linaro.org>
Cc: <d-gerlach@ti.com>
Cc: <tony@atomide.com>
Cc: <t-kristo@ti.com>
Link: https://lkml.kernel.org/r/1533191716-20476-1-git-send-email-j-keerthy@ti.com

---
 drivers/clocksource/timer-ti-32k.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
index 880a861ab3c8..29e2e1a78a43 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -78,8 +78,7 @@ static struct ti_32k ti_32k_timer = {
 		.rating		= 250,
 		.read		= ti_32k_read_cycles,
 		.mask		= CLOCKSOURCE_MASK(32),
-		.flags		= CLOCK_SOURCE_IS_CONTINUOUS |
-				CLOCK_SOURCE_SUSPEND_NONSTOP,
+		.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	},
 };
 
