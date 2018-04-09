Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758020AbeDICdE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 22:33:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:4905 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755007AbeDICdC (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 22:33:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,426,1517904000";
   d="scan'208";a="215038570"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 3/3] perf version: Print status for syscall_table
Date: Mon,  9 Apr 2018 18:26:49 +0800
Message-Id: <1523269609-28824-4-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523269609-28824-1-git-send-email-yao.jin@linux.intel.com>
References: <1523269609-28824-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 tools/perf/builtin-version.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 2abe391..50df168 100644
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
-- 
2.7.4
