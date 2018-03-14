Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeCNOia (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:38:30 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:36877 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeCNOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:38:07 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH 08/16] procfs: remove CONFIG_HARDWALL dependency
Date: Wed, 14 Mar 2018 15:37:37 +0100
Message-Id: <20180314143755.1508262-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:AXUlWKWpazw1MU5qDOm/5Iw2itM6jY69g4J0UvZM2rCbPnkPhBm
 ooFEmfq3dUv/BcD6cT/H5Fk2BTjkZPfMomeBU9/Aqzkmn/6CwEXqipFlIYmYzC/niHW5BQy
 jnUpbxqmRsYrnbWC+oG05x4Bd3W2Un2aSiHbPGC1GbYl3ZLw7zgZKlix5lbet5KPsNmMbnU
 8/gMTVnOdp0Rf+V6OMxfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jL+UXyUKafk=:vi3jYFSsa8wWYJQykVRVtu
 dvvuvz6yjpnpCj/N32S3oPqnreI9tIuqIuBfMb8zJ8rw2mjzgln0PEWpDkNr2jwZvR6epDZYV
 PrH25Z+hn4cqZz//q1iF/bX7XI7Bi4tDk7fa9oYUTZfW6SuhP6Yi1OW2k8WIqpr0JjzsHsC0g
 SxB8heUFGzMg1Wtp5cnBPaVDJx2lkjm6dCXHb/YyTl+EcyU8KKg5IFpvgOWB1a3bweqlzDp52
 0TgE4BSSqCeNs2C1NgzeXEvLuYyqWKXICw/4kFZ3dsdh6BaKg+CakfcNNYcybq/Y4EEnO077g
 ZD0PYhlrBUmobdCZIAoJ3YhRV+dBi2bBeNbndbZzWeq4/C0gZ795Yv1NvI5R4/duNIASKVzxe
 ry3hNwSSwSsAmtFYwKij9eaqz616QJP82vfwRKpfI2WCFAGrhrwaQCQsURJMiop8DPOq9D/0s
 6GAPGaJI2gu7OTufeKFzS75ragUDknlqYGO9ZAbKGBYNU0sBNzCzt5tq63N2tX5FgxcBhpP8u
 919RVXTFnTv6FjPL+PbwP9ZTMPcw7xtgUrN5p7NFun2gI74lDMO3DF0qvVmiHVmJO3+/LwU0+
 YHgQRlaa35IH396nv2sp2q75qgzbZiCbaoxEotAMn6BAA2UPhleH3FOz9/6VJBN6UBAJ0kbQ0
 qH/MCeh+B/bm+2zBbiD27Lte30L5js+KrGdAbN4iitj1qIeZv5GYTaAmSti9+BNFznOA7Udo2
 a6giwRq7Tj2cYHj3qL+qCqTvh6JKJ7BtnuloGQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardwall is a tile specific feature, and with the removal of the
tile architecture, this has become dead code, so let's remove it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/proc/base.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9298324325ed..d53246863cfb 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -94,9 +94,6 @@
 #include <linux/sched/stat.h>
 #include <linux/flex_array.h>
 #include <linux/posix-timers.h>
-#ifdef CONFIG_HARDWALL
-#include <asm/hardwall.h>
-#endif
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -3002,9 +2999,6 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_TASK_IO_ACCOUNTING
 	ONE("io",	S_IRUSR, proc_tgid_io_accounting),
 #endif
-#ifdef CONFIG_HARDWALL
-	ONE("hardwall",   S_IRUGO, proc_pid_hardwall),
-#endif
 #ifdef CONFIG_USER_NS
 	REG("uid_map",    S_IRUGO|S_IWUSR, proc_uid_map_operations),
 	REG("gid_map",    S_IRUGO|S_IWUSR, proc_gid_map_operations),
@@ -3393,9 +3387,6 @@ static const struct pid_entry tid_base_stuff[] = {
 #ifdef CONFIG_TASK_IO_ACCOUNTING
 	ONE("io",	S_IRUSR, proc_tid_io_accounting),
 #endif
-#ifdef CONFIG_HARDWALL
-	ONE("hardwall",   S_IRUGO, proc_pid_hardwall),
-#endif
 #ifdef CONFIG_USER_NS
 	REG("uid_map",    S_IRUGO|S_IWUSR, proc_uid_map_operations),
 	REG("gid_map",    S_IRUGO|S_IWUSR, proc_gid_map_operations),
-- 
2.9.0
