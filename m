Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbeCII4O (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:56:14 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41955 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbeCII4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:56:12 -0500
Date: Fri, 9 Mar 2018 00:55:51 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-bd476684584ecc3e269167d595c6dd5375011ca0@git.kernel.org>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, hpa@zytor.com, acme@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        dsahern@gmail.com, tglx@linutronix.de
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, jolsa@kernel.org, mingo@kernel.org,
        dsahern@gmail.com, tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
        alexander.shishkin@linux.intel.com
In-Reply-To: <20180307155020.32613-18-jolsa@kernel.org>
References: <20180307155020.32613-18-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf build: Add llvm/clang/cxx make tests into
 FEATURE_TESTS_EXTRA
Git-Commit-ID: bd476684584ecc3e269167d595c6dd5375011ca0
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

Commit-ID:  bd476684584ecc3e269167d595c6dd5375011ca0
Gitweb:     https://git.kernel.org/tip/bd476684584ecc3e269167d595c6dd5375011ca0
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 7 Mar 2018 16:50:18 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 11:30:48 -0300

perf build: Add llvm/clang/cxx make tests into FEATURE_TESTS_EXTRA

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
 
