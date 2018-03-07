Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934190AbeCGPya (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:54:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934124AbeCGPvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:51:54 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 17/19] perf build: Add llvm/clang/cxx make tests into FEATURE_TESTS_EXTRA
Date: Wed,  7 Mar 2018 16:50:18 +0100
Message-Id: <20180307155020.32613-18-jolsa@kernel.org>
In-Reply-To: <20180307155020.32613-1-jolsa@kernel.org>
References: <20180307155020.32613-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we can see the status when we build perf, like:

  $ make LIBCLANGLLVM=1 VF=1
  ...                           cxx: [ on  ]
  ...                          llvm: [ on  ]
  ...                  llvm-version: [ on  ]
  ...                         clang: [ on  ]

Link: http://lkml.kernel.org/n/tip-geuvqz2pe5hh75bgbvar9sio@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/build/Makefile.feature | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index c378f003b007..5b6dda3b1ca8 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -82,7 +82,11 @@ FEATURE_TESTS_EXTRA :=                  \
          liberty-z                      \
          libunwind-debug-frame          \
          libunwind-debug-frame-arm      \
-         libunwind-debug-frame-aarch64
+         libunwind-debug-frame-aarch64  \
+         cxx                            \
+         llvm                           \
+         llvm-version                   \
+         clang
 
 FEATURE_TESTS ?= $(FEATURE_TESTS_BASIC)
 
-- 
2.13.6
