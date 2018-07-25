Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEDEC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF6D20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF6D20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbeGYWFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:05:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56061 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbeGYWFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:05:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKp3RY501508
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:51:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKp38R501505;
        Wed, 25 Jul 2018 13:51:03 -0700
Date:   Wed, 25 Jul 2018 13:51:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-67fda0f32cd9428cb9a3166796162097d7fcbcbf@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        peterz@infradead.org, tglx@linutronix.de, ak@linux.intel.com,
        lukasz.odzioba@intel.com, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        dsahern@gmail.com, hpa@zytor.com, wangnan0@huawei.com,
        namhyung@kernel.org, mingo@kernel.org
Reply-To: hpa@zytor.com, dsahern@gmail.com, mingo@kernel.org,
          wangnan0@huawei.com, namhyung@kernel.org, acme@redhat.com,
          jolsa@kernel.org, lukasz.odzioba@intel.com,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          peterz@infradead.org, kan.liang@linux.intel.com,
          linux-kernel@vger.kernel.org, ak@linux.intel.com
In-Reply-To: <20180719143345.12963-3-jolsa@kernel.org>
References: <20180719143345.12963-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Add threads__set_last_match function
Git-Commit-ID: 67fda0f32cd9428cb9a3166796162097d7fcbcbf
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

Commit-ID:  67fda0f32cd9428cb9a3166796162097d7fcbcbf
Gitweb:     https://git.kernel.org/tip/67fda0f32cd9428cb9a3166796162097d7fcbcbf
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 19 Jul 2018 16:33:43 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:53:42 -0300

perf machine: Add threads__set_last_match function

Separating threads::last_match cache set into separate
threads__set_last_match function.  This will be useful in following
patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Lukasz Odzioba <lukasz.odzioba@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20180719143345.12963-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index df41aa1a4cf9..8992fcf42257 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -431,6 +431,12 @@ threads__get_last_match(struct threads *threads, struct machine *machine,
 	return NULL;
 }
 
+static void
+threads__set_last_match(struct threads *threads, struct thread *th)
+{
+	threads->last_match = th;
+}
+
 /*
  * Caller must eventually drop thread->refcnt returned with a successful
  * lookup/new thread inserted.
@@ -453,7 +459,7 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 		th = rb_entry(parent, struct thread, rb_node);
 
 		if (th->tid == tid) {
-			threads->last_match = th;
+			threads__set_last_match(threads, th);
 			machine__update_thread_pid(machine, th, pid);
 			return thread__get(th);
 		}
@@ -490,7 +496,7 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 		 * It is now in the rbtree, get a ref
 		 */
 		thread__get(th);
-		threads->last_match = th;
+		threads__set_last_match(threads, th);
 		++threads->nr;
 	}
 
@@ -1648,7 +1654,7 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
 	struct threads *threads = machine__threads(machine, th->tid);
 
 	if (threads->last_match == th)
-		threads->last_match = NULL;
+		threads__set_last_match(threads, NULL);
 
 	BUG_ON(refcount_read(&th->refcnt) == 0);
 	if (lock)
