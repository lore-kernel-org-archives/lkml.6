Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeCII6I (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:58:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59175 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeCII6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:58:07 -0500
Date: Fri, 9 Mar 2018 00:56:45 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-5fb3d8b7b50d2101b0c15d2e90264deb7a01c2d8@git.kernel.org>
Cc: tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        jolsa@kernel.org, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, acme@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org
Reply-To: hpa@zytor.com, acme@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, dsahern@gmail.com,
        jolsa@kernel.org, mingo@kernel.org
In-Reply-To: <20180307155020.32613-20-jolsa@kernel.org>
References: <20180307155020.32613-20-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf build: Force llvm/clang test compile output to
 .make.output
Git-Commit-ID: 5fb3d8b7b50d2101b0c15d2e90264deb7a01c2d8
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

Commit-ID:  5fb3d8b7b50d2101b0c15d2e90264deb7a01c2d8
Gitweb:     https://git.kernel.org/tip/5fb3d8b7b50d2101b0c15d2e90264deb7a01c2d8
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 7 Mar 2018 16:50:20 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 11:30:50 -0300

perf build: Force llvm/clang test compile output to .make.output

So we can see the output of feature compile in following files:

  tools/build/feature/test-llvm.make.output
  tools/build/feature/test-llvm-version.make.output
  tools/build/feature/test-clang.make.output

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180307155020.32613-20-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index f8ad640ffe5d..dac9563b5470 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -260,11 +260,13 @@ $(OUTPUT)test-llvm.bin:
 		-I$(shell $(LLVM_CONFIG) --includedir) 		\
 		-L$(shell $(LLVM_CONFIG) --libdir)		\
 		$(shell $(LLVM_CONFIG) --libs Core BPF)		\
-		$(shell $(LLVM_CONFIG) --system-libs)
+		$(shell $(LLVM_CONFIG) --system-libs)		\
+		> $(@:.bin=.make.output) 2>&1
 
 $(OUTPUT)test-llvm-version.bin:
 	$(BUILDXX) -std=gnu++11 				\
-		-I$(shell $(LLVM_CONFIG) --includedir)
+		-I$(shell $(LLVM_CONFIG) --includedir)		\
+		> $(@:.bin=.make.output) 2>&1
 
 $(OUTPUT)test-clang.bin:
 	$(BUILDXX) -std=gnu++11 				\
@@ -274,7 +276,8 @@ $(OUTPUT)test-clang.bin:
 		  -lclangFrontend -lclangEdit -lclangLex	\
 		  -lclangAST -Wl,--end-group 			\
 		$(shell $(LLVM_CONFIG) --libs Core option)	\
-		$(shell $(LLVM_CONFIG) --system-libs)
+		$(shell $(LLVM_CONFIG) --system-libs)		\
+		> $(@:.bin=.make.output) 2>&1
 
 -include $(OUTPUT)*.d
 
