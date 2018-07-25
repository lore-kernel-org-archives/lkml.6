Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6267CC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2265820671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2265820671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbeGYWEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:04:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33847 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730604AbeGYWEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:04:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKoWoq501309
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:50:32 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKoWBg501306;
        Wed, 25 Jul 2018 13:50:32 -0700
Date:   Wed, 25 Jul 2018 13:50:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-f8b2ebb532e0553b60ae5ad1b84d1d4f0c285752@git.kernel.org>
Cc:     peterz@infradead.org, wangnan0@huawei.com, mingo@kernel.org,
        tglx@linutronix.de, dsahern@gmail.com, namhyung@kernel.org,
        lukasz.odzioba@intel.com, hpa@zytor.com, kan.liang@linux.intel.com,
        jolsa@kernel.org, acme@redhat.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
Reply-To: linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          acme@redhat.com, ak@linux.intel.com, jolsa@kernel.org,
          kan.liang@linux.intel.com, hpa@zytor.com,
          lukasz.odzioba@intel.com, namhyung@kernel.org, dsahern@gmail.com,
          tglx@linutronix.de, mingo@kernel.org, wangnan0@huawei.com,
          peterz@infradead.org
In-Reply-To: <20180719143345.12963-2-jolsa@kernel.org>
References: <20180719143345.12963-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Add threads__get_last_match function
Git-Commit-ID: f8b2ebb532e0553b60ae5ad1b84d1d4f0c285752
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

Commit-ID:  f8b2ebb532e0553b60ae5ad1b84d1d4f0c285752
Gitweb:     https://git.kernel.org/tip/f8b2ebb532e0553b60ae5ad1b84d1d4f0c285752
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 19 Jul 2018 16:33:42 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:53:31 -0300

perf machine: Add threads__get_last_match function

Separating threads::last_match cache read/check into separate
threads__get_last_match function. This will be useful in following
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
Link: http://lkml.kernel.org/r/20180719143345.12963-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 22dbb6612b41..df41aa1a4cf9 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -408,23 +408,16 @@ out_err:
 }
 
 /*
- * Caller must eventually drop thread->refcnt returned with a successful
- * lookup/new thread inserted.
+ * Front-end cache - TID lookups come in blocks,
+ * so most of the time we dont have to look up
+ * the full rbtree:
  */
-static struct thread *____machine__findnew_thread(struct machine *machine,
-						  struct threads *threads,
-						  pid_t pid, pid_t tid,
-						  bool create)
+static struct thread*
+threads__get_last_match(struct threads *threads, struct machine *machine,
+			int pid, int tid)
 {
-	struct rb_node **p = &threads->entries.rb_node;
-	struct rb_node *parent = NULL;
 	struct thread *th;
 
-	/*
-	 * Front-end cache - TID lookups come in blocks,
-	 * so most of the time we dont have to look up
-	 * the full rbtree:
-	 */
 	th = threads->last_match;
 	if (th != NULL) {
 		if (th->tid == tid) {
@@ -435,6 +428,26 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 		threads->last_match = NULL;
 	}
 
+	return NULL;
+}
+
+/*
+ * Caller must eventually drop thread->refcnt returned with a successful
+ * lookup/new thread inserted.
+ */
+static struct thread *____machine__findnew_thread(struct machine *machine,
+						  struct threads *threads,
+						  pid_t pid, pid_t tid,
+						  bool create)
+{
+	struct rb_node **p = &threads->entries.rb_node;
+	struct rb_node *parent = NULL;
+	struct thread *th;
+
+	th = threads__get_last_match(threads, machine, pid, tid);
+	if (th)
+		return th;
+
 	while (*p != NULL) {
 		parent = *p;
 		th = rb_entry(parent, struct thread, rb_node);
