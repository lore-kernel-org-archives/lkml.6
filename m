Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB82BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B98B21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeLRNyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:54:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45555 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeLRNyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:54:49 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIDs9In2851388
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 05:54:10 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIDs9i22851385;
        Tue, 18 Dec 2018 05:54:09 -0800
Date:   Tue, 18 Dec 2018 05:54:09 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-x52mx1ybq8128rtg9hjrj5qk@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, namhyung@kernel.org,
        davem@davemloft.net, adrian.hunter@intel.com, ast@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, dsahern@gmail.com,
        daniel@iogearbox.net, ibobrik@gmail.com,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com, jolsa@kernel.org
Reply-To: acme@redhat.com, mingo@kernel.org, ast@kernel.org,
          adrian.hunter@intel.com, davem@davemloft.net,
          namhyung@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          daniel@iogearbox.net, dsahern@gmail.com, ibobrik@gmail.com,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          wangnan0@huawei.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Allow passing a kallsyms file
Git-Commit-ID: 1b3aae90c6abdf8a844da2aa4aed1eb6947a7d39
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
Message-ID: <20181218135409.ZwutOs4hUMJLtp07KUS5xXoQrDoKaZ-ub4sFJv1nxOI@z>

Commit-ID:  1b3aae90c6abdf8a844da2aa4aed1eb6947a7d39
Gitweb:     https://git.kernel.org/tip/1b3aae90c6abdf8a844da2aa4aed1eb6947a7d39
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 27 Nov 2018 10:31:03 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:54:40 -0300

perf top: Allow passing a kallsyms file

This basically replicates what was done for 'perf report' in:

   b226a5a72901 ("perf report: Allow user to specify path to kallsyms file")

This should help with resolving eBPF symbols, that are in kallsyms but,
of course, not in vmlinux.

Reported-by: Ivan Babrou <ibobrik@gmail.com>
Tested-by: Ivan Babrou <ibobrik@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-x52mx1ybq8128rtg9hjrj5qk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt | 3 +++
 tools/perf/builtin-top.c              | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 808b664343c9..44d89fb9c788 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -70,6 +70,9 @@ Default is to monitor all CPUS.
 --ignore-vmlinux::
 	Ignore vmlinux files.
 
+--kallsyms=<file>::
+	kallsyms pathname
+
 -m <pages>::
 --mmap-pages=<pages>::
 	Number of mmap data pages (must be a power of two) or size
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index aa0c73e57924..1252d1759064 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1289,6 +1289,8 @@ int cmd_top(int argc, const char **argv)
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
 		    "don't load vmlinux even if found"),
+	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
+		   "file", "kallsyms pathname"),
 	OPT_BOOLEAN('K', "hide_kernel_symbols", &top.hide_kernel_symbols,
 		    "hide kernel symbols"),
 	OPT_CALLBACK('m', "mmap-pages", &opts->mmap_pages, "pages",
