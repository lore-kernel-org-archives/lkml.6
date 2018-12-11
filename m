Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB20C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C781820849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C781820849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbeLKPXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:23:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36729 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbeLKPXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:23:20 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFMfIW4038940
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:22:41 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFMeK24038935;
        Tue, 11 Dec 2018 07:22:40 -0800
Date:   Tue, 11 Dec 2018 07:22:40 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-da087b2229618f78ecea5c203fed8ba2245de636@git.kernel.org>
Cc:     bvanassche@acm.org, sasha.levin@oracle.com,
        linux-kernel@vger.kernel.org, johannes@sipsolutions.net,
        tglx@linutronix.de, mingo@kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        longman@redhat.com, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          johannes@sipsolutions.net, bvanassche@acm.org,
          sasha.levin@oracle.com, peterz@infradead.org, hpa@zytor.com,
          longman@redhat.com, mingo@kernel.org,
          torvalds@linux-foundation.org
In-Reply-To: <20181207011148.251812-2-bvanassche@acm.org>
References: <20181207011148.251812-2-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/lib/lockdep/tests: Display compiler
 warning and error messages
Git-Commit-ID: da087b2229618f78ecea5c203fed8ba2245de636
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

Commit-ID:  da087b2229618f78ecea5c203fed8ba2245de636
Gitweb:     https://git.kernel.org/tip/da087b2229618f78ecea5c203fed8ba2245de636
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 6 Dec 2018 17:11:25 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 14:54:47 +0100

tools/lib/lockdep/tests: Display compiler warning and error messages

If compilation of liblockdep fails, display an error message and exit
immediately. Display compiler warning and error messages that are
generated while building a test. Only run a test if compilation of it
succeeded.

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
Link: https://lkml.kernel.org/r/20181207011148.251812-2-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/lib/lockdep/run_tests.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/lib/lockdep/run_tests.sh b/tools/lib/lockdep/run_tests.sh
index 2e570a188f16..9f31f84e7fac 100755
--- a/tools/lib/lockdep/run_tests.sh
+++ b/tools/lib/lockdep/run_tests.sh
@@ -1,13 +1,17 @@
 #! /bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-make &> /dev/null
+if ! make >/dev/null; then
+    echo "Building liblockdep failed."
+    echo "FAILED!"
+    exit 1
+fi
 
 for i in `ls tests/*.c`; do
 	testname=$(basename "$i" .c)
-	gcc -o tests/$testname -pthread $i liblockdep.a -Iinclude -D__USE_LIBLOCKDEP &> /dev/null
 	echo -ne "$testname... "
-	if [ $(timeout 1 ./tests/$testname 2>&1 | wc -l) -gt 0 ]; then
+	if gcc -o "tests/$testname" -pthread "$i" liblockdep.a -Iinclude -D__USE_LIBLOCKDEP &&
+		[ "$(timeout 1 "./tests/$testname" 2>&1 | wc -l)" -gt 0 ]; then
 		echo "PASSED!"
 	else
 		echo "FAILED!"
@@ -19,9 +23,9 @@ done
 
 for i in `ls tests/*.c`; do
 	testname=$(basename "$i" .c)
-	gcc -o tests/$testname -pthread -Iinclude $i &> /dev/null
 	echo -ne "(PRELOAD) $testname... "
-	if [ $(timeout 1 ./lockdep ./tests/$testname 2>&1 | wc -l) -gt 0 ]; then
+	if gcc -o "tests/$testname" -pthread -Iinclude "$i" &&
+		[ "$(timeout 1 ./lockdep "./tests/$testname" 2>&1 | wc -l)" -gt 0 ]; then
 		echo "PASSED!"
 	else
 		echo "FAILED!"
