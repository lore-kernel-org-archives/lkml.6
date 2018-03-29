Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeC2HCK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:02:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:44564 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbeC2HCJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:02:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,375,1517904000";
   d="scan'208";a="29381114"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 0/5] Support perf -vv
Date: Thu, 29 Mar 2018 22:56:17 +0800
Message-Id: <1522335382-11983-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We keep having bug reports that when users build perf on their own,
but they don't install some needed libraries such as libelf,
libbfd/libibery.

The perf can build, but it is missing important functionality. And
users may complain that perf has issue or bug.

This patch-set support to print the status of compiled-in libraries.

Once users think perf missing some functionality, it should be very
easy for them to check the libraries status.

For example:

$ ./perf version --build-options
    or
  ./perf --version --build-options
    or
  ./perf -v --build-options
    or
  ./perf -vv

perf version 4.13.rc5.g4c1df1
                 dwarf: [ on  ]
    dwarf_getlocations: [ on  ]
                 glibc: [ on  ]
                  gtk2: [ on  ]
              libaudit: [ OFF ]
                libbfd: [ on  ]
                libelf: [ on  ]
               libnuma: [ on  ]
numa_num_possible_cpus: [ on  ]
               libperl: [ on  ]
             libpython: [ on  ]
              libslang: [ on  ]
             libcrypto: [ on  ]
             libunwind: [ on  ]
    libdw-dwarf-unwind: [ on  ]
                  zlib: [ on  ]
                  lzma: [ on  ]
             get_cpuid: [ on  ]
                   bpf: [ on  ]

Jin Yao (4):
  perf config: Add some new -DHAVE_XXX to CFLAGS
  perf version: Print the compiled-in status of libraries
  perf: Support perf -vv
  perf Documentation: Create perf-version.txt

Jiri Olsa (1):
  tools include: Add config.h header file

 tools/include/tools/config.h              | 34 +++++++++++++
 tools/perf/Documentation/perf-version.txt | 24 +++++++++
 tools/perf/Makefile.config                |  6 +++
 tools/perf/builtin-version.c              | 81 ++++++++++++++++++++++++++++++-
 tools/perf/perf.c                         |  6 +++
 tools/perf/perf.h                         |  1 +
 6 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100644 tools/include/tools/config.h
 create mode 100644 tools/perf/Documentation/perf-version.txt

-- 
2.7.4
