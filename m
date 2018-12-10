Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7098EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2214E2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2214E2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbeLJVUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:20:21 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:42657 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLJVUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:20:21 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MmU1H-1hEdUW2RU1-00iULu; Mon, 10 Dec 2018 22:20:01 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        NeilBrown <neilb@suse.com>, Tom Herbert <tom@quantonium.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Blakey <paulb@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] test_rhashtable: remove semaphore usage
Date:   Mon, 10 Dec 2018 22:17:20 +0100
Message-Id: <20181210211957.210189-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ALCGaFg58WW3NSexPPpdxDr/NdIoNswdvn4CB7H4luNuXNDt0Sv
 VfX64FYnokCrVab+K8AT9C6ubv6/NZjomRTjWzZ7jwZl4YcUUesJ0DPUekui1OLOCwKvCco
 WXUYjZiS92yOvXhLGp7G0cVYHH2IXU5RfGIs/kqBYibZ3jmWQco7aSYb6ttcCwwRY7jU3zU
 hJMHNsBVPDezhgdQZ5T9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0Hmo5bsPMg4=:NABrAQ+hJlwADHEEFE9SEe
 VyVGxBvbw1zyk1UjNs92Amjr5hMiVBFTD2obpR70bzqT8PtmDFvBXs5FfOAwZ97ict8m+wQtV
 +S+jLwUhQKToy2Jq3sn5eJ2KXrSdeAsXJtB9y33RExIsXpUyShtUZY8F+Knx4Dz58S4uOvhrj
 7LDbzT4wN/eAO5di7oIh7ha18CV8xYD7uxfRKLWdhGLt9KVfXVBrcSaby7FTscRRXTIiYnbJM
 8vrOK11XqsSYa8n3Ts3QQDX45IBTYsLGTlzuZgJ8ylM28A7sm0swSXyA+Sp/eFNmhjLvByT1M
 j9SqZ48tiAIgmtNtGiEr64GBlbgDz8AWRmqrgsZtduQ+vxf1SypwXnzVCLoSKvRk5mZFznQo6
 KVOO75AK6v8CEu6hAFK3YkZYVcCmKQclvOoSFkD3pUgIJsR3MWRyVT4uTew6QU8Cqaf95D5CJ
 J94Dbqy14QKP9e/HkV8+OQd+6FrhW1ck5BEZZ4NbQCJUcMrAissXw7eCivD+kxODDsXkX6IFL
 LfeZBuHNgJ7pqsePV6zxYHasIHjiY/vF6Kn25kIkFWTbvYV1OwMRaFIauQNjoZXf3feG3XPqN
 wvHZhPSGYZmFlcqVSK9G8VpBMhA6ci0Y+m7nZlAtmOgsLhdFjECe847DPGw08dvKFrVDeIvxO
 MTNmB1NYbNgJFxq0mRWUR4iVLZqRDbfX9z7yHtkSuDDLzEu3enWjnaclhoIrpm7jHv99gEiQF
 Kty4mvWFCyN8Wq5RnfiRoKJkoOub/wzoYnl9+g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is one of only two files that initialize a semaphore to a negative
value. We don't really need the two semaphores here at all, but can do
the same thing in more conventional and more effient way, by using a
single waitqueue and an atomic thread counter.

This gets us a little bit closer to eliminating classic semaphores from
the kernel. It also fixes a corner case where we fail to continue after
one of the threads fails to start up.

An alternative would be to use a split kthread_create()+wake_up_process()
and completely eliminate the separate synchronization.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is part of a longer, untested, series to remove semaphores
from the kernel, please review as such before applying.
---
 lib/test_rhashtable.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index 18de5ff1255b..12bdea4f6c20 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -20,11 +20,11 @@
 #include <linux/module.h>
 #include <linux/rcupdate.h>
 #include <linux/rhashtable.h>
-#include <linux/semaphore.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/random.h>
 #include <linux/vmalloc.h>
+#include <linux/wait.h>
 
 #define MAX_ENTRIES	1000000
 #define TEST_INSERT_FAIL INT_MAX
@@ -112,7 +112,8 @@ static struct rhashtable_params test_rht_params_dup = {
 	.automatic_shrinking = false,
 };
 
-static struct semaphore prestart_sem, startup_sem;
+static atomic_t startup_count;
+static DECLARE_WAIT_QUEUE_HEAD(startup_wait);
 
 static int insert_retry(struct rhashtable *ht, struct test_obj *obj,
                         const struct rhashtable_params params)
@@ -635,8 +636,9 @@ static int threadfunc(void *data)
 	int i, step, err = 0, insert_retries = 0;
 	struct thread_data *tdata = data;
 
-	up(&prestart_sem);
-	if (down_interruptible(&startup_sem))
+	if (atomic_dec_and_test(&startup_count))
+		wake_up(&startup_wait);
+	if (wait_event_interruptible(startup_wait, atomic_read(&startup_count) == -1))
 		pr_err("  thread[%d]: down_interruptible failed\n", tdata->id);
 
 	for (i = 0; i < tdata->entries; i++) {
@@ -756,8 +758,7 @@ static int __init test_rht_init(void)
 
 	pr_info("Testing concurrent rhashtable access from %d threads\n",
 	        tcount);
-	sema_init(&prestart_sem, 1 - tcount);
-	sema_init(&startup_sem, 0);
+	atomic_set(&startup_count, tcount);
 	tdata = vzalloc(array_size(tcount, sizeof(struct thread_data)));
 	if (!tdata)
 		return -ENOMEM;
@@ -783,15 +784,18 @@ static int __init test_rht_init(void)
 		tdata[i].objs = objs + i * entries;
 		tdata[i].task = kthread_run(threadfunc, &tdata[i],
 		                            "rhashtable_thrad[%d]", i);
-		if (IS_ERR(tdata[i].task))
+		if (IS_ERR(tdata[i].task)) {
 			pr_err(" kthread_run failed for thread %d\n", i);
-		else
+			atomic_dec(&startup_count);
+		} else {
 			started_threads++;
+		}
 	}
-	if (down_interruptible(&prestart_sem))
-		pr_err("  down interruptible failed\n");
-	for (i = 0; i < tcount; i++)
-		up(&startup_sem);
+	if (wait_event_interruptible(startup_wait, atomic_read(&startup_count) == 0))
+		pr_err("  wait_event interruptible failed\n");
+	/* count is 0 now, set it to -1 and wake up all threads together */
+	atomic_dec(&startup_count);
+	wake_up_all(&startup_wait);
 	for (i = 0; i < tcount; i++) {
 		if (IS_ERR(tdata[i].task))
 			continue;
-- 
2.20.0

