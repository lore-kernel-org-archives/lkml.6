Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98595C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA8020C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA8020C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeJIMr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:47:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46563 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeJIMr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:47:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w995Wb8M910373
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Oct 2018 22:32:37 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w995WbaQ910366;
        Mon, 8 Oct 2018 22:32:37 -0700
Date:   Mon, 8 Oct 2018 22:32:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Eduardo Habkost <tipbot@zytor.com>
Message-ID: <tip-8b2f245faa6238e28a1d801e8633515251d1acfc@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        wangnan0@huawei.com, hpa@zytor.com, jolsa@kernel.org,
        namhyung@kernel.org, ehabkost@redhat.com, dsahern@gmail.com,
        adrian.hunter@intel.com, acme@redhat.com, mingo@kernel.org
Reply-To: mingo@kernel.org, adrian.hunter@intel.com, acme@redhat.com,
          ehabkost@redhat.com, dsahern@gmail.com, tglx@linutronix.de,
          namhyung@kernel.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, wangnan0@huawei.com
In-Reply-To: <20181005204058.7966-3-ehabkost@redhat.com>
References: <20181005204058.7966-3-ehabkost@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf python: More portable way to make CFLAGS work
 with clang
Git-Commit-ID: 8b2f245faa6238e28a1d801e8633515251d1acfc
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

Commit-ID:  8b2f245faa6238e28a1d801e8633515251d1acfc
Gitweb:     https://git.kernel.org/tip/8b2f245faa6238e28a1d801e8633515251d1acfc
Author:     Eduardo Habkost <ehabkost@redhat.com>
AuthorDate: Fri, 5 Oct 2018 17:40:58 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 8 Oct 2018 14:30:45 -0300

perf python: More portable way to make CFLAGS work with clang

The existing code that tries to make CFLAGS compatible with clang
doesn't work with Python 3.

Instead of trying to touch _sysconfigdata.build_time_vars directly,
change the dictionary returned by disutils.sysconfig.get_config_vars().
This works on both Python 2 and Python 3.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20181005204058.7966-3-ehabkost@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 261a55e7e1b2..63f758c655d5 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -9,12 +9,14 @@ def clang_has_option(option):
 
 cc = getenv("CC")
 if cc == "clang":
-    from _sysconfigdata import build_time_vars
-    build_time_vars["CFLAGS"] = sub("-specs=[^ ]+", "", build_time_vars["CFLAGS"])
-    if not clang_has_option("-mcet"):
-        build_time_vars["CFLAGS"] = sub("-mcet", "", build_time_vars["CFLAGS"])
-    if not clang_has_option("-fcf-protection"):
-        build_time_vars["CFLAGS"] = sub("-fcf-protection", "", build_time_vars["CFLAGS"])
+    from distutils.sysconfig import get_config_vars
+    vars = get_config_vars()
+    for var in ('CFLAGS', 'OPT'):
+        vars[var] = sub("-specs=[^ ]+", "", vars[var])
+        if not clang_has_option("-mcet"):
+            vars[var] = sub("-mcet", "", vars[var])
+        if not clang_has_option("-fcf-protection"):
+            vars[var] = sub("-fcf-protection", "", vars[var])
 
 from distutils.core import setup, Extension
 
