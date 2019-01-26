Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB2DC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC94217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfAZKAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:00:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40177 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZKAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:00:07 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0QA00WM510502
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 02:00:00 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0QA00rp510499;
        Sat, 26 Jan 2019 02:00:00 -0800
Date:   Sat, 26 Jan 2019 02:00:00 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-vr1jnwwujh99skrgldtimpmu@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
        mingo@kernel.org, namhyung@kernel.org, jolsa@kernel.org
Reply-To: acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf comm: Remove needless headers from comm.h
Git-Commit-ID: f0049f2c3ee80d0808efe6fb4400b572e6858cb9
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

Commit-ID:  f0049f2c3ee80d0808efe6fb4400b572e6858cb9
Gitweb:     https://git.kernel.org/tip/f0049f2c3ee80d0808efe6fb4400b572e6858cb9
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 22 Jan 2019 11:28:42 -0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:09 +0100

perf comm: Remove needless headers from comm.h

There we don't need rbtree, only in comm.c, also ditch perf.h, not
needed at all.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-vr1jnwwujh99skrgldtimpmu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/comm.c | 1 +
 tools/perf/util/comm.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 31279a7bd919..1066de92af12 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <linux/refcount.h>
+#include <linux/rbtree.h>
 #include "rwsem.h"
 
 struct comm_str {
diff --git a/tools/perf/util/comm.h b/tools/perf/util/comm.h
index 3e5c438fe85e..f35d8fbfa2dd 100644
--- a/tools/perf/util/comm.h
+++ b/tools/perf/util/comm.h
@@ -2,9 +2,9 @@
 #ifndef __PERF_COMM_H
 #define __PERF_COMM_H
 
-#include "../perf.h"
-#include <linux/rbtree.h>
 #include <linux/list.h>
+#include <linux/types.h>
+#include <stdbool.h>
 
 struct comm_str;
 
