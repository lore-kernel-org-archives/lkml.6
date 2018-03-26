Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeCZINR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:13:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:56660 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752096AbeCZIMw (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:12:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="214862090"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 3/3] perf: Support perf -vv
Date: Tue, 27 Mar 2018 00:07:04 +0800
Message-Id: <1522080424-12912-4-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522080424-12912-1-git-send-email-yao.jin@linux.intel.com>
References: <1522080424-12912-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We keep having bug reports that when users build perf on their own,
but they don't install some needed libraries such as libelf,
libbfd/libibery.

The perf can build, but it is missing important functionality.

This patch provides a new option '-vv' which will print the
compiled-in status of libraries.

For example:

$ ./perf -vv
perf version 4.13.rc5.g9b7a81b
                 dwarf: [  on ]
    dwarf_getlocations: [  on ]
                 glibc: [  on ]
                  gtk2: [  on ]
              libaudit: [ off ]
                libbfd: [  on ]
                libelf: [  on ]
               libnuma: [  on ]
numa_num_possible_cpus: [  on ]
               libperl: [  on ]
             libpython: [  on ]
              libslang: [  on ]
             libcrypto: [  on ]
             libunwind: [  on ]
    libdw-dwarf-unwind: [  on ]
                  zlib: [  on ]
                  lzma: [  on ]
             get_cpuid: [  on ]
                   bpf: [  on ]

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/perf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 1b3fc8e..300c83d 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -64,6 +64,7 @@ static struct cmd_struct commands[] = {
 	{ "top",	cmd_top,	0 },
 	{ "annotate",	cmd_annotate,	0 },
 	{ "version",	cmd_version,	0 },
+	{ "version2",	cmd_version2,	0 },
 	{ "script",	cmd_script,	0 },
 	{ "sched",	cmd_sched,	0 },
 #ifdef HAVE_LIBELF_SUPPORT
@@ -190,6 +191,11 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			break;
 		}
 
+		if (!strcmp(cmd, "-vv")) {
+			(*argv)[0] = "--version2";
+			break;
+		}
+
 		/*
 		 * Check remaining flags.
 		 */
-- 
2.7.4
