Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7F2C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D582820867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D582820867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbeIYPkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:40:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36431 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeIYPkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:40:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8P9XKxY3386400
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Sep 2018 02:33:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8P9XKue3386397;
        Tue, 25 Sep 2018 02:33:20 -0700
Date:   Tue, 25 Sep 2018 02:33:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ed93d0a26012a4a12231c16b18628a324079dc45@git.kernel.org>
Cc:     jolsa@kernel.org, acme@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, alexey.budankov@linux.intel.com,
        tglx@linutronix.de, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        andi@firstfloor.org, hpa@zytor.com
Reply-To: hpa@zytor.com, alexander.shishkin@linux.intel.com,
          andi@firstfloor.org, mingo@kernel.org,
          alexey.budankov@linux.intel.com, tglx@linutronix.de,
          namhyung@kernel.org, acme@redhat.com, jolsa@kernel.org,
          peterz@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180913125450.21342-10-jolsa@kernel.org>
References: <20180913125450.21342-10-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf util: Make copyfile_offset() global
Git-Commit-ID: ed93d0a26012a4a12231c16b18628a324079dc45
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

Commit-ID:  ed93d0a26012a4a12231c16b18628a324079dc45
Gitweb:     https://git.kernel.org/tip/ed93d0a26012a4a12231c16b18628a324079dc45
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 13 Sep 2018 14:54:11 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 19 Sep 2018 10:25:12 -0300

perf util: Make copyfile_offset() global

It will be used outside of util object in following patches.

Committer note:

We need to have the header with the definition for loff_t in util.h
since we now use it in the copyfile_offset() signature.

Also move that prototype closer to the other copyfile_ prefixed
functions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180913125450.21342-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.c | 2 +-
 tools/perf/util/util.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index eac5b858a371..093352e93d50 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -221,7 +221,7 @@ out:
 	return err;
 }
 
-static int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size)
+int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size)
 {
 	void *ptr;
 	loff_t pgoff;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index dc58254a2b69..14508ee7707a 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -6,6 +6,7 @@
 /* glibc 2.20 deprecates _BSD_SOURCE in favour of _DEFAULT_SOURCE */
 #define _DEFAULT_SOURCE 1
 
+#include <fcntl.h>
 #include <stdbool.h>
 #include <stddef.h>
 #include <stdlib.h>
@@ -35,6 +36,7 @@ bool lsdir_no_dot_filter(const char *name, struct dirent *d);
 int copyfile(const char *from, const char *to);
 int copyfile_mode(const char *from, const char *to, mode_t mode);
 int copyfile_ns(const char *from, const char *to, struct nsinfo *nsi);
+int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size);
 
 ssize_t readn(int fd, void *buf, size_t n);
 ssize_t writen(int fd, const void *buf, size_t n);
