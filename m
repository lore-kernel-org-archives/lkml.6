Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE95C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F08220849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F08220849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeLKPXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:23:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41063 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbeLKPXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:23:48 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFNF2f4038981
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:23:15 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFNEG64038978;
        Tue, 11 Dec 2018 07:23:14 -0800
Date:   Tue, 11 Dec 2018 07:23:14 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-7e9798871a9186cb831cf693d7ff58085384ccbd@git.kernel.org>
Cc:     tglx@linutronix.de, johannes@sipsolutions.net, longman@redhat.com,
        sasha.levin@oracle.com, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, bvanassche@acm.org
Reply-To: bvanassche@acm.org, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          torvalds@linux-foundation.org, longman@redhat.com,
          sasha.levin@oracle.com, johannes@sipsolutions.net,
          tglx@linutronix.de
In-Reply-To: <20181207011148.251812-3-bvanassche@acm.org>
References: <20181207011148.251812-3-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/lib/lockdep/tests: Fix shellcheck warnings
Git-Commit-ID: 7e9798871a9186cb831cf693d7ff58085384ccbd
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

Commit-ID:  7e9798871a9186cb831cf693d7ff58085384ccbd
Gitweb:     https://git.kernel.org/tip/7e9798871a9186cb831cf693d7ff58085384ccbd
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 6 Dec 2018 17:11:26 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 14:54:48 +0100

tools/lib/lockdep/tests: Fix shellcheck warnings

Use find instead of ls to avoid splitting filenames that contain spaces.
Use rm -f instead of if ... then rm ...; fi. This patch addresses all
shellcheck complaints about the run_tests.sh shell script.

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
Link: https://lkml.kernel.org/r/20181207011148.251812-3-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/lib/lockdep/run_tests.sh | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/lib/lockdep/run_tests.sh b/tools/lib/lockdep/run_tests.sh
index 9f31f84e7fac..253719ee6377 100755
--- a/tools/lib/lockdep/run_tests.sh
+++ b/tools/lib/lockdep/run_tests.sh
@@ -7,7 +7,7 @@ if ! make >/dev/null; then
     exit 1
 fi
 
-for i in `ls tests/*.c`; do
+find tests -name '*.c' | sort | while read -r i; do
 	testname=$(basename "$i" .c)
 	echo -ne "$testname... "
 	if gcc -o "tests/$testname" -pthread "$i" liblockdep.a -Iinclude -D__USE_LIBLOCKDEP &&
@@ -16,12 +16,10 @@ for i in `ls tests/*.c`; do
 	else
 		echo "FAILED!"
 	fi
-	if [ -f "tests/$testname" ]; then
-		rm tests/$testname
-	fi
+	rm -f "tests/$testname"
 done
 
-for i in `ls tests/*.c`; do
+find tests -name '*.c' | sort | while read -r i; do
 	testname=$(basename "$i" .c)
 	echo -ne "(PRELOAD) $testname... "
 	if gcc -o "tests/$testname" -pthread -Iinclude "$i" &&
@@ -30,7 +28,5 @@ for i in `ls tests/*.c`; do
 	else
 		echo "FAILED!"
 	fi
-	if [ -f "tests/$testname" ]; then
-		rm tests/$testname
-	fi
+	rm -f "tests/$testname"
 done
