Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeCZIMt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:12:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:56660 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbeCZIMs (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:12:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="214862079"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 0/3] Support perf -vv
Date: Tue, 27 Mar 2018 00:07:01 +0800
Message-Id: <1522080424-12912-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We keep having bug reports that when users build perf on their own,
but they don't install some needed libraries such as libelf,
libbfd/libibery.

The perf can build, but it is missing important functionality. And
users may complain that perf has issue or bug. 

This patch-set support 'perf -vv' which will print the compiled-in
status of libraries. Once users think perf missing some functionality,
it should be very easy for them to check the libraries status.

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

Jin Yao (3):
  perf config: Add -DNO_GLIBC to CFLAGS
  perf version: Print the status of compiled-in libraries
  perf: Support perf -vv

 tools/perf/Makefile.config   |   2 +
 tools/perf/builtin-version.c | 125 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/builtin.h         |   1 +
 tools/perf/perf.c            |   6 +++
 4 files changed, 134 insertions(+)

-- 
2.7.4
