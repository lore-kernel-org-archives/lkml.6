Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753443AbeDPGrg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:47:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55205 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeDPGre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:47:34 -0400
Date: Sun, 15 Apr 2018 23:46:13 -0700
From: tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-8a812bf552d98f6f887f860d3910f201b4a97b26@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, jolsa@kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com, acme@redhat.com, yao.jin@linux.intel.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org
Reply-To: ak@linux.intel.com, acme@redhat.com, yao.jin@linux.intel.com,
        kan.liang@linux.intel.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@kernel.org
In-Reply-To: <1523269609-28824-4-git-send-email-yao.jin@linux.intel.com>
References: <1523269609-28824-4-git-send-email-yao.jin@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf version: Print status for syscall_table
Git-Commit-ID: 8a812bf552d98f6f887f860d3910f201b4a97b26
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

Commit-ID:  8a812bf552d98f6f887f860d3910f201b4a97b26
Gitweb:     https://git.kernel.org/tip/8a812bf552d98f6f887f860d3910f201b4a97b26
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Mon, 9 Apr 2018 18:26:49 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 12 Apr 2018 10:33:34 -0300

perf version: Print status for syscall_table

This patch doesn't print "libaudit" line if HAVE_SYSCALL_TABLE_SUPPORT
is available and add a line for HAVE_SYSCALL_TABLE_SUPPORT.

For example,

$ ./perf -vv
perf version 4.13.rc5.gc2f8af9
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                 glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                  gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT

The line "syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT" is
new created.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1523269609-28824-4-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-version.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 2abe3910d6b6..50df168be326 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -60,7 +60,10 @@ static void library_status(void)
 	STATUS(HAVE_DWARF_GETLOCATIONS_SUPPORT, dwarf_getlocations);
 	STATUS(HAVE_GLIBC_SUPPORT, glibc);
 	STATUS(HAVE_GTK2_SUPPORT, gtk2);
+#ifndef HAVE_SYSCALL_TABLE_SUPPORT
 	STATUS(HAVE_LIBAUDIT_SUPPORT, libaudit);
+#endif
+	STATUS(HAVE_SYSCALL_TABLE_SUPPORT, syscall_table);
 	STATUS(HAVE_LIBBFD_SUPPORT, libbfd);
 	STATUS(HAVE_LIBELF_SUPPORT, libelf);
 	STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
