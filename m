Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11493C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D214F20831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D214F20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392432AbeKVRsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:48:30 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38485 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733195AbeKVRs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:48:29 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM7A2KS3691855
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:10:02 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM7A1EU3691837;
        Wed, 21 Nov 2018 23:10:01 -0800
Date:   Wed, 21 Nov 2018 23:10:01 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Davidlohr Bueso <tipbot@zytor.com>
Message-ID: <tip-d47d77c3f008d3cf02c6ce92ef4f6e32ca270351@git.kernel.org>
Cc:     jbaron@akamai.com, akpm@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, dbueso@suse.de,
        acme@redhat.com, dave@stgolabs.net, hpa@zytor.com
Reply-To: akpm@linux-foundation.org, tglx@linutronix.de, jbaron@akamai.com,
          dbueso@suse.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
          dave@stgolabs.net, acme@redhat.com, hpa@zytor.com
In-Reply-To: <20181109210719.pr7ohayuwqmfp2wl@linux-r8p5>
References: <20181109210719.pr7ohayuwqmfp2wl@linux-r8p5>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bench: Move HAVE_PTHREAD_ATTR_SETAFFINITY_NP
 into bench.h
Git-Commit-ID: d47d77c3f008d3cf02c6ce92ef4f6e32ca270351
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

Commit-ID:  d47d77c3f008d3cf02c6ce92ef4f6e32ca270351
Gitweb:     https://git.kernel.org/tip/d47d77c3f008d3cf02c6ce92ef4f6e32ca270351
Author:     Davidlohr Bueso <dave@stgolabs.net>
AuthorDate: Fri, 9 Nov 2018 13:07:19 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 12:00:32 -0300

perf bench: Move HAVE_PTHREAD_ATTR_SETAFFINITY_NP into bench.h

Both futex and epoll need this call, and can cause build failure on
systems that don't have it pthread_attr_setaffinity_np().

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Link: http://lkml.kernel.org/r/20181109210719.pr7ohayuwqmfp2wl@linux-r8p5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/bench.h | 11 +++++++++++
 tools/perf/bench/futex.h | 12 ------------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 6c9fcd757f31..8299c76046cd 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -48,4 +48,15 @@ int bench_futex_lock_pi(int argc, const char **argv);
 extern int bench_format;
 extern unsigned int bench_repeat;
 
+#ifndef HAVE_PTHREAD_ATTR_SETAFFINITY_NP
+#include <pthread.h>
+#include <linux/compiler.h>
+static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
+					      size_t cpusetsize __maybe_unused,
+					      cpu_set_t *cpuset __maybe_unused)
+{
+	return 0;
+}
+#endif
+
 #endif
diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index db4853f209c7..31b53cc7d5bc 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -86,16 +86,4 @@ futex_cmp_requeue(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2, int nr_wak
 	return futex(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_requeue, uaddr2,
 		 val, opflags);
 }
-
-#ifndef HAVE_PTHREAD_ATTR_SETAFFINITY_NP
-#include <pthread.h>
-#include <linux/compiler.h>
-static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
-					      size_t cpusetsize __maybe_unused,
-					      cpu_set_t *cpuset __maybe_unused)
-{
-	return 0;
-}
-#endif
-
 #endif /* _FUTEX_H */
