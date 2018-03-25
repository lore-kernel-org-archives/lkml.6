Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbeCYWXV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:23:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51107 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbeCYWXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:23:16 -0400
Date: Sun, 25 Mar 2018 15:23:07 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ircpvox4wzsv7gasrpb28fw9@git.kernel.org>
Cc: ak@linux.intel.com, wangnan0@huawei.com, namhyung@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, yao.jin@linux.intel.com, dsahern@gmail.com,
        acme@redhat.com
Reply-To: tglx@linutronix.de, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, yao.jin@linux.intel.com, dsahern@gmail.com,
        acme@redhat.com, mingo@kernel.org, hpa@zytor.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Introduce --ignore-vmlinux command
 line option
Git-Commit-ID: 91340c5184f316d687d4522b9aa41b56d58a49b0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  91340c5184f316d687d4522b9aa41b56d58a49b0
Gitweb:     https://git.kernel.org/tip/91340c5184f316d687d4522b9aa41b56d58a49b0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 16 Mar 2018 16:27:04 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Mar 2018 12:53:42 -0300

perf report: Introduce --ignore-vmlinux command line option

We've had this in 'perf top' for quite a while, useful if one wishes
to force using /proc/kcore to do annotation using the patched kernel
instead of the ELF image it started from, aka vmlinux.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ircpvox4wzsv7gasrpb28fw9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt | 3 +++
 tools/perf/builtin-report.c              | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index cba16d8a970e..e1a660e60849 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -296,6 +296,9 @@ OPTIONS
 --vmlinux=<file>::
         vmlinux pathname
 
+--ignore-vmlinux::
+	Ignore vmlinux files.
+
 --kallsyms=<file>::
         kallsyms pathname
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1a82f38671a8..0f198f6d9b77 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1018,6 +1018,8 @@ int cmd_report(int argc, const char **argv)
 	OPT_BOOLEAN(0, "mmaps", &report.mmaps_mode, "Display recorded tasks memory maps"),
 	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
 		   "file", "vmlinux pathname"),
+	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
+                    "don't load vmlinux even if found"),
 	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
 		   "file", "kallsyms pathname"),
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
