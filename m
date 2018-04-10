Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeDJFb2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 01:31:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58891 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbeDJFb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 01:31:27 -0400
Date: Mon, 9 Apr 2018 22:31:20 -0700
From: tip-bot for Sandipan Das <tipbot@zytor.com>
Message-ID: <tip-fcbd8fa44664e99a5d8c7ab97f1afdd82472f973@git.kernel.org>
Cc: hpa@zytor.com, sandipan@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, acme@redhat.com, mingo@kernel.org
Reply-To: hpa@zytor.com, sandipan@linux.vnet.ibm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@redhat.com,
        acme@redhat.com, naveen.n.rao@linux.vnet.ibm.com
In-Reply-To: <20180404180419.19056-3-sandipan@linux.vnet.ibm.com>
References: <20180404180419.19056-3-sandipan@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tests clang: Fix function name for clang IR
 test
Git-Commit-ID: fcbd8fa44664e99a5d8c7ab97f1afdd82472f973
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

Commit-ID:  fcbd8fa44664e99a5d8c7ab97f1afdd82472f973
Gitweb:     https://git.kernel.org/tip/fcbd8fa44664e99a5d8c7ab97f1afdd82472f973
Author:     Sandipan Das <sandipan@linux.vnet.ibm.com>
AuthorDate: Wed, 4 Apr 2018 23:34:19 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 9 Apr 2018 11:13:09 -0300

perf tests clang: Fix function name for clang IR test

As stated in tests/llvm-src-base.c, the name of the bpf function should
be "bpf_func__SyS_epoll_pwait" but this clang test fails as it tries to
lookup "bpf_func__SyS_epoll_wait".

Before applying patch:

55: builtin clang support                                 :
55.1: builtin clang compile C source to IR                : FAILED!
55.2: builtin clang compile C source to ELF object        : Skip

After applying patch:

55: builtin clang support                                 :
55.1: builtin clang compile C source to IR                : Ok
55.2: builtin clang compile C source to ELF object        : Ok

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Fixes: e67d52d411c3 ("perf clang: Update test case to use real BPF script")
Link: http://lkml.kernel.org/r/20180404180419.19056-3-sandipan@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/c++/clang-test.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/c++/clang-test.cpp b/tools/perf/util/c++/clang-test.cpp
index a4014d786676..7b042a5ebc68 100644
--- a/tools/perf/util/c++/clang-test.cpp
+++ b/tools/perf/util/c++/clang-test.cpp
@@ -41,7 +41,7 @@ int test__clang_to_IR(void)
 	if (!M)
 		return -1;
 	for (llvm::Function& F : *M)
-		if (F.getName() == "bpf_func__SyS_epoll_wait")
+		if (F.getName() == "bpf_func__SyS_epoll_pwait")
 			return 0;
 	return -1;
 }
