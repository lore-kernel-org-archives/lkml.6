Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeC1HCy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:02:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:31659 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbeC1HCw (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:02:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,370,1517904000";
   d="scan'208";a="32013313"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 0/4] Support perf -vv
Date: Wed, 28 Mar 2018 22:57:04 +0800
Message-Id: <1522249028-15099-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We keep having bug reports that when users build perf on their own,
but they don't install some needed libraries such as libelf,
libbfd/libibery.

The perf can build, but it is missing important functionality. And
users may complain that perf has issue or bug.

This patch-set support 'perf -vv' and 'perf -version --build-options'
which will print the compiled-in status of libraries.

Once users think perf missing some functionality, it should be very
easy for them to check the libraries status.

For example:

    $ ./perf -vv or ./perf -version --build-options
    perf version 4.13.rc5.gcb1183
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
    [ on  ]: library is compiled-in
    [ OFF ]: library is disabled in make configuration
             OR library is not installed in build environment

Jin Yao (3):
  perf config: Add some new -DHAVE_XXX to CFLAGS
  perf version: Print the compiled-in status of libraries
  perf: Support perf -vv

Jiri Olsa (1):
  tools include: Add config.h header file

 tools/include/tools/config.h | 34 ++++++++++++++++++++++
 tools/perf/Makefile.config   | 16 +++++++++++
 tools/perf/builtin-version.c | 68 ++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/perf.c            | 22 +++++++++++---
 tools/perf/perf.h            |  1 +
 5 files changed, 137 insertions(+), 4 deletions(-)
 create mode 100644 tools/include/tools/config.h

-- 
2.7.4
