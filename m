Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeB1Gpd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 01:45:33 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37882 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbeB1Gpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 01:45:32 -0500
X-Google-Smtp-Source: AH8x224Zeoq6qMPnC0KKCi3M8QhITntXSh4sBRUi+ZuvgvAztMphMT93GUcAxh0g4VXGdJBiWIFpgQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: lftan@altera.com, arnd@arndb.de
Cc: heiko@sntech.de, daniel.lezcano@linaro.org, linus.walleij@linaro.org,
        viresh.kumar@linaro.org, linux@roeck-us.net,
        nios2-dev@lists.rocketboards.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH] nios2: Use read_persistent_clock64() instead of read_persistent_clock()
Date: Wed, 28 Feb 2018 14:44:51 +0800
Message-Id: <c42b5f610064b37551b155cc8ddebda3cd094f2b.1519800122.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since struct timespec is not y2038 safe on 32bit machines, this patch
converts read_persistent_clock() to read_persistent_clock64() using
struct timespec64, as well as converting mktime() to mktime64().

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/nios2/kernel/time.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/nios2/kernel/time.c b/arch/nios2/kernel/time.c
index 20e8620..ab88b6d 100644
--- a/arch/nios2/kernel/time.c
+++ b/arch/nios2/kernel/time.c
@@ -336,9 +336,9 @@ static int __init nios2_time_init(struct device_node *timer)
 	return ret;
 }
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
-	ts->tv_sec = mktime(2007, 1, 1, 0, 0, 0);
+	ts->tv_sec = mktime64(2007, 1, 1, 0, 0, 0);
 	ts->tv_nsec = 0;
 }
 
-- 
1.7.9.5
