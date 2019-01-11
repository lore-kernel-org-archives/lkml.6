Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF82C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7561820874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfAKHtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:49:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45385 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfAKHtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:49:39 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0B7nV0c561610
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 10 Jan 2019 23:49:31 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0B7nV5v561607;
        Thu, 10 Jan 2019 23:49:31 -0800
Date:   Thu, 10 Jan 2019 23:49:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-4q2b5g4p2hrstrhp9t2mrlho@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, tglx@linutronix.de, namhyung@kernel.org,
        mingo@kernel.org, jolsa@kernel.org, acme@redhat.com
Reply-To: namhyung@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
          acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf symbols: Add 'arch_cpu_idle' to the list of
 kernel idle symbols
Git-Commit-ID: 549aff770ccfec368aa8f0652dbce8b1e8e6715a
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

Commit-ID:  549aff770ccfec368aa8f0652dbce8b1e8e6715a
Gitweb:     https://git.kernel.org/tip/549aff770ccfec368aa8f0652dbce8b1e8e6715a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 9 Jan 2019 16:19:24 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 9 Jan 2019 16:21:15 -0300

perf symbols: Add 'arch_cpu_idle' to the list of kernel idle symbols

When testing 'perf top' on a armhf system (32-bit, Orange Pi Zero), I
noticed that 'arch_cpu_idle' dominated, add it to the list of idle
symbols, so that we can see what is that being done when not idle.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-4q2b5g4p2hrstrhp9t2mrlho@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 01f2c7385e38..48efad6d0f90 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -614,6 +614,7 @@ out:
 static bool symbol__is_idle(const char *name)
 {
 	const char * const idle_symbols[] = {
+		"arch_cpu_idle",
 		"cpu_idle",
 		"cpu_startup_entry",
 		"intel_idle",
