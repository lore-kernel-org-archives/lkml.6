Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF50C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28D221919
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfBIMfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:35:31 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34121 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:35:30 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CZLEA2628522
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:35:21 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CZKuM2628517;
        Sat, 9 Feb 2019 04:35:20 -0800
Date:   Sat, 9 Feb 2019 04:35:20 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-8vx5396phynuxhdsxxfbdhsk@git.kernel.org>
Cc:     hpa@zytor.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
          acme@redhat.com, namhyung@kernel.org, adrian.hunter@intel.com,
          mingo@kernel.org, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf thread: Don't include symbol.h, symbol_conf.h
 is enough
Git-Commit-ID: e22c1c751140aeacc5bba9596d7d5a21c5acbd8c
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

Commit-ID:  e22c1c751140aeacc5bba9596d7d5a21c5acbd8c
Gitweb:     https://git.kernel.org/tip/e22c1c751140aeacc5bba9596d7d5a21c5acbd8c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 28 Jan 2019 00:07:40 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:38 -0300

perf thread: Don't include symbol.h, symbol_conf.h is enough

Also add stdio.h to get the FILE definition.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8vx5396phynuxhdsxxfbdhsk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 856cf1a9040a..8276ffeec556 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -5,14 +5,17 @@
 #include <linux/refcount.h>
 #include <linux/rbtree.h>
 #include <linux/list.h>
+#include <stdio.h>
 #include <unistd.h>
 #include <sys/types.h>
 #include "srccode.h"
-#include "symbol.h"
+#include "symbol_conf.h"
 #include <strlist.h>
 #include <intlist.h>
 #include "rwsem.h"
 
+struct addr_location;
+struct map;
 struct namespaces_event;
 struct thread_stack;
 struct unwind_libunwind_ops;
