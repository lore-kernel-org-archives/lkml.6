Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD68CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AC6208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AC6208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935150AbeFROmj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:42:39 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:55119 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934109AbeFROmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:42:37 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LjODj-1g4GZn3bKx-00daJU; Mon, 18 Jun 2018 16:42:12 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>, Willy Tarreau <w@1wt.eu>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] leds: ledtrig-activity: use ktime_get_boot_ns()
Date:   Mon, 18 Jun 2018 16:41:44 +0200
Message-Id: <20180618144210.72367-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:9A33qaBXXy9tzEbZfQ8vgBxKsvDiV+++sRqTUvligdOlcDdsdyp
 rABB29DQycDJYKEI1flmQmZHqxgbSdBuGNALJCLeOETamVM1KkACA6mI/NV1zq3wsCcD3u4
 1NZMZVARx7wiG1g3CuJE3HgM8dqhBFoxFRKlGMFFFZj6Tx7fjFo+ozlsbRJRmH4EwiAq2Ft
 yCc5q2jGbOGbyaP2nO5QA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G150xayh6Os=:SdW/y1z+8HAjiVBnQoPwAP
 MUZ7jUtGIYE8lafnpo/UG127x38CzNmN9hzIVxjJuBExw+zu8oWpjz0TUxlXGvy7O0sM7hjX0
 VzrkyMM4O+bN8zqemnB+oA4wLM2pgZbTe8HFzeVonKkYA6F/HatAWR1L8Br6vgulTkthOQWoj
 c74wCm7m2SXQ2IXsoWBoT12wCcOzsbIu/JgCMfFlQOoZkjbBTx5IQHYBXhFx4eUYqzYVZ53O2
 nbq6gMPnUFIPYbwjOZyA0vDyP2A3zvIPaHMcW0yuZlYLNTrsaWwDJDgd4fB049FQmbLIA55zB
 AlYgtaNe9KE3KkXVNEnu3VSGFD01mHHK6BX4Z4aHARfSwtSq5MVzuNYuISwwbqEx43VKAnPNT
 m3XPDpwmRFBD0tJC/HgiQaK3tmm7Yq5DGB3WxRt+kqKZCxipqakxY98vxRrEOPNo0Cb9e1+Lp
 R+qLqTFscchEwtBMPlRDF8DLZchrJUnm9tpJgMMdSKQjVklu6dRp1lY3S4wa4BlnnOcsPUrxX
 pUQb94zYwTMmxHicdVXX7rmwVmHF9eLYYC0KBnxL0hslP4P5EvJvYx3g5BKaDp12LK1+vE1xP
 ZZi+kQx7XPLUEYo8OHTBa+W8ZIZbZVd7tU8ShJ5n4ddhmMSdiYq8mAwUQA5hAbFP5/IR/4iaN
 5N0bQqZ3R2zJhdB2rhPduu7Wy4xgGl20hBq/oJZj+eObcxciJQiI+8S+x8UTuYdzDkDc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_monotonic_boottime() is deprecated, so let's convert this to
the simpler ktime_get_boot_ns().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/leds/trigger/ledtrig-activity.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigger/ledtrig-activity.c
index 5081894082bd..589c1bc4d0b9 100644
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
@@ -57,7 +56,7 @@ static void led_activity_function(struct timer_list *t)
 		return;
 	}
 
-	get_monotonic_boottime(&boot_time);
+	curr_boot = ktime_get_boot_ns();
 
 	cpus = 0;
 	curr_used = 0;
@@ -76,7 +75,6 @@ static void led_activity_function(struct timer_list *t)
 	 * down to 16us, ensuring we won't overflow 32-bit computations below
 	 * even up to 3k CPUs, while keeping divides cheap on smaller systems.
 	 */
-	curr_boot = timespec_to_ns(&boot_time) * cpus;
 	diff_boot = (curr_boot - activity_data->last_boot) >> 16;
 	diff_used = (curr_used - activity_data->last_used) >> 16;
 	activity_data->last_boot = curr_boot;
-- 
2.9.0

