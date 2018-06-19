Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC39C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF3520874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF3520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756484AbeFSIWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:22:51 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50825 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756451AbeFSIWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:22:49 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Md4Bm-1fnPVr0NSU-00IFt7; Tue, 19 Jun 2018 10:22:25 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Willy Tarreau <w@1wt.eu>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] leds: ledtrig-activity: use ktime_get_boot_ns()
Date:   Tue, 19 Jun 2018 10:18:56 +0200
Message-Id: <20180619082215.2990745-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:6B9Kc0gW1wWG6RrWqxclm+xuFsTarDW1MoaWpneIQ7FF45wS/7I
 uyyFueouU4q2nhevhMOvyMOxF3iQZ2zHzubvBfpg3pePplCn5SaJQagaRe3N1X0WGGZ5Ki3
 Qnaa1sNfOKqGGNolMufY2lF4eSnK/vMbJT9W5lk2rLjpUSzSEw5+YMeu9T6Bn1yMqeSwaMQ
 kjblgsfE96MLIEB8FtroA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ByOyyQaY3tc=:c0fxuJZ6ei8JoLHqidmJYk
 DD1aHM2feWvhcLAG+zhlmEKX1LydSp6gYm9vIdg0+Wz7vgZJJJkuke7OSbDaIIPuQKoEugE+/
 Tvap5C2bvcal86a7ND5DhNyMR/4oSW4sTUeSbWqw7VoTSGrFlpSX3uwvNYcBTiKptruBZt55o
 NJp5Mf8YnZaL/y9wU2jWuzcjgELXb56WEVW3aGOHDi6uX16kImX8TAMogvSJwjiiYvD5CbSB+
 KIg3Kq2Gc5TkxdGRwbdePbRY+xagQToW0mEovDpalQY1k4OG/P+aUddbFw45JFQHKxWJl68gq
 Nadr9aFJ6SuC3uZmgxKYbdP0EdSmSktshbuoHVD/+lZr4h3dDQjcpFfIGbMv0+24n/qYZmyge
 NHkMZdpg4y5w1e1Gqq+JTTswMtw/M5NaJ0O7cMMW4Tdsglpy6Vr3sm0kQVfU0q+mEu4yVS4JF
 PSwZkyXHe/zJIB/vM4aPayyQxdlM03+P6W2Gecwy3hIzXqqg4I5tLsD7eQ7OGL3VaI2Rq+bAY
 73HM5wXzENd7rnGc5l5+PG1UwXdipxror1TTTc4HPPmZJ4aOQN73u/67p+vUD+KIivwmWYroj
 MvpboScuFuk/KNf1LZnY//aKXCBsZmKUdn670zlBGEKLKfV8zEmUwO7uKJKoJaE3z6q8xUTPS
 GweTrs8AYMswURZcibmEpwWuavjaXj9aXYDX5MdWBkdodcCGB3Tw0aZKQaEyZQmNMFAI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_monotonic_boottime() is deprecated, so let's convert this to
the simpler ktime_get_boot_ns().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: don't drop 'cpus' multiplication, as Pavel and Willy point out
    that needs to be kept
---
 drivers/leds/trigger/ledtrig-activity.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigger/ledtrig-activity.c
index 5081894082bd..6c6f8a9b8d9a 100644
--- a/drivers/leds/trigger/ledtrig-activity.c
+++ b/drivers/leds/trigger/ledtrig-activity.c
@@ -37,7 +37,6 @@ static void led_activity_function(struct timer_list *t)
 	struct activity_data *activity_data = from_timer(activity_data, t,
 							 timer);
 	struct led_classdev *led_cdev = activity_data->led_cdev;
-	struct timespec boot_time;
 	unsigned int target;
 	unsigned int usage;
 	int delay;
@@ -57,8 +56,6 @@ static void led_activity_function(struct timer_list *t)
 		return;
 	}
 
-	get_monotonic_boottime(&boot_time);
-
 	cpus = 0;
 	curr_used = 0;
 
@@ -76,7 +73,7 @@ static void led_activity_function(struct timer_list *t)
 	 * down to 16us, ensuring we won't overflow 32-bit computations below
 	 * even up to 3k CPUs, while keeping divides cheap on smaller systems.
 	 */
-	curr_boot = timespec_to_ns(&boot_time) * cpus;
+	curr_boot = ktime_get_boot_ns() * cpus;
 	diff_boot = (curr_boot - activity_data->last_boot) >> 16;
 	diff_used = (curr_used - activity_data->last_used) >> 16;
 	activity_data->last_boot = curr_boot;
-- 
2.9.0

