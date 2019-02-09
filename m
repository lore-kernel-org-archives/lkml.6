Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231A3C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E863421916
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfBIMgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:36:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60275 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:36:47 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CadmY2628831
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:36:39 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19Cach02628827;
        Sat, 9 Feb 2019 04:36:38 -0800
Date:   Sat, 9 Feb 2019 04:36:38 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-zivvqfx93w5zzur7hr7h0nlh@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, adrian.hunter@intel.com
Reply-To: acme@redhat.com, mingo@kernel.org, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          jolsa@kernel.org, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf hist: Remove the needless callchain.h include
 from hist.h
Git-Commit-ID: 71551288d2fde0c24df3c248e3e80be92783376d
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

Commit-ID:  71551288d2fde0c24df3c248e3e80be92783376d
Gitweb:     https://git.kernel.org/tip/71551288d2fde0c24df3c248e3e80be92783376d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 29 Jan 2019 12:04:58 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:38 -0300

perf hist: Remove the needless callchain.h include from hist.h

Nothing that is provided by callchain.h is used there, just things that
should've be directly included in hist.h, such as rbtree.h and a
map_symbol forward declaration.

Remove it so that we reduce the headers dependency tree.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-zivvqfx93w5zzur7hr7h0nlh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 38a72eb81427..6b872079ead5 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -2,9 +2,9 @@
 #ifndef __PERF_HIST_H
 #define __PERF_HIST_H
 
+#include <linux/rbtree.h>
 #include <linux/types.h>
 #include <pthread.h>
-#include "callchain.h"
 #include "evsel.h"
 #include "header.h"
 #include "color.h"
@@ -13,6 +13,7 @@
 struct hist_entry;
 struct hist_entry_ops;
 struct addr_location;
+struct map_symbol;
 struct mem_info;
 struct branch_info;
 struct symbol;
