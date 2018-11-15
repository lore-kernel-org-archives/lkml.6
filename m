Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D19C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129C022419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129C022419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbeKOVc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:32:27 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:51064 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388030AbeKOVc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 16:32:26 -0500
Received: from ramsan.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id 0BQu1z00j3XaVaC06BQvdD; Thu, 15 Nov 2018 12:24:58 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1gNFlW-00087u-U8; Thu, 15 Nov 2018 12:24:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gNES1-0004cJ-QF; Thu, 15 Nov 2018 11:00:41 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] clockevents/drivers/tegra20: Remove obsolete inclusion of <asm/smp_twd.h>
Date:   Thu, 15 Nov 2018 11:00:37 +0100
Message-Id: <20181115100037.17706-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit da4a686a2cfb077a ("ARM: smp_twd: convert to use CLKSRC_OF
init"), this header file is no longer used.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clocksource/tegra20_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index aa624885e0e239df..4293943f4e2b471e 100644
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

