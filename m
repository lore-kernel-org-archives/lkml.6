Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8CCC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39C520849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39C520849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeLKPYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:24:30 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47903 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLKPY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:24:29 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFNnOt4039028
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:23:49 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFNm5b4039022;
        Tue, 11 Dec 2018 07:23:48 -0800
Date:   Tue, 11 Dec 2018 07:23:48 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-5ecb8e94b494af0df8de4ca9b9ef88d87b30a9c1@git.kernel.org>
Cc:     mingo@kernel.org, sasha.levin@oracle.com, tglx@linutronix.de,
        longman@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bvanassche@acm.org,
        torvalds@linux-foundation.org, johannes@sipsolutions.net,
        hpa@zytor.com
Reply-To: longman@redhat.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          bvanassche@acm.org, johannes@sipsolutions.net, hpa@zytor.com,
          mingo@kernel.org, tglx@linutronix.de, sasha.levin@oracle.com
In-Reply-To: <20181207011148.251812-4-bvanassche@acm.org>
References: <20181207011148.251812-4-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/lib/lockdep/tests: Improve testing
 accuracy
Git-Commit-ID: 5ecb8e94b494af0df8de4ca9b9ef88d87b30a9c1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5ecb8e94b494af0df8de4ca9b9ef88d87b30a9c1
Gitweb:     https://git.kernel.org/tip/5ecb8e94b494af0df8de4ca9b9ef88d87b30a9c1
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 6 Dec 2018 17:11:27 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 14:54:49 +0100

tools/lib/lockdep/tests: Improve testing accuracy

Instead of checking whether the tests produced any output, check the
output itself. This patch avoids that e.g. debug output causes the
message "PASSED!" to be reported for failed tests.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: johannes.berg@intel.com
Cc: tj@kernel.org
Link: https://lkml.kernel.org/r/20181207011148.251812-4-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/lib/lockdep/run_tests.sh            | 5 +++--
 tools/lib/lockdep/tests/AA.sh             | 2 ++
 tools/lib/lockdep/tests/ABA.sh            | 2 ++
 tools/lib/lockdep/tests/ABBA.sh           | 2 ++
 tools/lib/lockdep/tests/ABBA_2threads.sh  | 2 ++
 tools/lib/lockdep/tests/ABBCCA.sh         | 2 ++
 tools/lib/lockdep/tests/ABBCCDDA.sh       | 2 ++
 tools/lib/lockdep/tests/ABCABC.sh         | 2 ++
 tools/lib/lockdep/tests/ABCDBCDA.sh       | 2 ++
 tools/lib/lockdep/tests/ABCDBDDA.sh       | 2 ++
 tools/lib/lockdep/tests/WW.sh             | 2 ++
 tools/lib/lockdep/tests/unlock_balance.sh | 2 ++
 12 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/lib/lockdep/run_tests.sh b/tools/lib/lockdep/run_tests.sh
index 253719ee6377..bc36178329a8 100755
--- a/tools/lib/lockdep/run_tests.sh
+++ b/tools/lib/lockdep/run_tests.sh
@@ -11,7 +11,7 @@ find tests -name '*.c' | sort | while read -r i; do
 	testname=$(basename "$i" .c)
 	echo -ne "$testname... "
 	if gcc -o "tests/$testname" -pthread "$i" liblockdep.a -Iinclude -D__USE_LIBLOCKDEP &&
-		[ "$(timeout 1 "./tests/$testname" 2>&1 | wc -l)" -gt 0 ]; then
+		timeout 1 "tests/$testname" 2>&1 | "tests/${testname}.sh"; then
 		echo "PASSED!"
 	else
 		echo "FAILED!"
@@ -23,7 +23,8 @@ find tests -name '*.c' | sort | while read -r i; do
 	testname=$(basename "$i" .c)
 	echo -ne "(PRELOAD) $testname... "
 	if gcc -o "tests/$testname" -pthread -Iinclude "$i" &&
-		[ "$(timeout 1 ./lockdep "./tests/$testname" 2>&1 | wc -l)" -gt 0 ]; then
+		timeout 1 ./lockdep "tests/$testname" 2>&1 |
+		"tests/${testname}.sh"; then
 		echo "PASSED!"
 	else
 		echo "FAILED!"
diff --git a/tools/lib/lockdep/tests/AA.sh b/tools/lib/lockdep/tests/AA.sh
new file mode 100644
index 000000000000..f39b32865074
--- /dev/null
+++ b/tools/lib/lockdep/tests/AA.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible recursive locking detected'
diff --git a/tools/lib/lockdep/tests/ABA.sh b/tools/lib/lockdep/tests/ABA.sh
new file mode 100644
index 000000000000..f39b32865074
--- /dev/null
+++ b/tools/lib/lockdep/tests/ABA.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible recursive locking detected'
diff --git a/tools/lib/lockdep/tests/ABBA.sh b/tools/lib/lockdep/tests/ABBA.sh
new file mode 100644
index 000000000000..fc31c607a5a8
--- /dev/null
+++ b/tools/lib/lockdep/tests/ABBA.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/ABBA_2threads.sh b/tools/lib/lockdep/tests/ABBA_2threads.sh
new file mode 100644
index 000000000000..fc31c607a5a8
--- /dev/null
+++ b/tools/lib/lockdep/tests/ABBA_2threads.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/ABBCCA.sh b/tools/lib/lockdep/tests/ABBCCA.sh
new file mode 100644
index 000000000000..fc31c607a5a8
--- /dev/null
+++ b/tools/lib/lockdep/tests/ABBCCA.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/ABBCCDDA.sh b/tools/lib/lockdep/tests/ABBCCDDA.sh
new file mode 100644
index 000000000000..fc31c607a5a8
--- /dev/null
+++ b/tools/lib/lockdep/tests/ABBCCDDA.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/ABCABC.sh b/tools/lib/lockdep/tests/ABCABC.sh
new file mode 100644
index 000000000000..fc31c607a5a8
--- /dev/null
+++ b/tools/lib/lockdep/tests/ABCABC.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/ABCDBCDA.sh b/tools/lib/lockdep/tests/ABCDBCDA.sh
new file mode 100644
index 000000000000..fc31c607a5a8
--- /dev/null
+++ b/tools/lib/lockdep/tests/ABCDBCDA.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/ABCDBDDA.sh b/tools/lib/lockdep/tests/ABCDBDDA.sh
new file mode 100644
index 000000000000..fc31c607a5a8
--- /dev/null
+++ b/tools/lib/lockdep/tests/ABCDBDDA.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible circular locking dependency detected'
diff --git a/tools/lib/lockdep/tests/WW.sh b/tools/lib/lockdep/tests/WW.sh
new file mode 100644
index 000000000000..f39b32865074
--- /dev/null
+++ b/tools/lib/lockdep/tests/WW.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: possible recursive locking detected'
diff --git a/tools/lib/lockdep/tests/unlock_balance.sh b/tools/lib/lockdep/tests/unlock_balance.sh
new file mode 100644
index 000000000000..c6e3952303fe
--- /dev/null
+++ b/tools/lib/lockdep/tests/unlock_balance.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+grep -q 'WARNING: bad unlock balance detected'
