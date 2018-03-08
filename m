Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbeCHTxG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:53:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbeCHTw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:52:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97440205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 48/54] perf build: Add llvm/clang/cxx make tests into FEATURE_TESTS_EXTRA
Date: Thu,  8 Mar 2018 16:50:23 -0300
Message-Id: <20180308195029.14991-49-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

So we can see the status when we build perf, like:

  $ make LIBCLANGLLVM=1 VF=1
  ...                           cxx: [ on  ]
  ...                          llvm: [ on  ]
  ...                  llvm-version: [ on  ]
  ...                         clang: [ on  ]

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180307155020.32613-18-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.3
