Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F6DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C5420849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C5420849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeLKPZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:25:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55971 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeLKPY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:24:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFONbk4040734
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:24:23 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFONIR4040731;
        Tue, 11 Dec 2018 07:24:23 -0800
Date:   Tue, 11 Dec 2018 07:24:23 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-2b28a8609ec9891e37607ae20688b4ab34f2778c@git.kernel.org>
Cc:     tglx@linutronix.de, johannes@sipsolutions.net,
        sasha.levin@oracle.com, torvalds@linux-foundation.org,
        hpa@zytor.com, longman@redhat.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, bvanassche@acm.org
Reply-To: sasha.levin@oracle.com, tglx@linutronix.de,
          johannes@sipsolutions.net, torvalds@linux-foundation.org,
          longman@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org, bvanassche@acm.org, mingo@kernel.org
In-Reply-To: <20181207011148.251812-5-bvanassche@acm.org>
References: <20181207011148.251812-5-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/lib/lockdep/tests: Run lockdep tests a
 second time under Valgrind
Git-Commit-ID: 2b28a8609ec9891e37607ae20688b4ab34f2778c
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

Commit-ID:  2b28a8609ec9891e37607ae20688b4ab34f2778c
Gitweb:     https://git.kernel.org/tip/2b28a8609ec9891e37607ae20688b4ab34f2778c
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 6 Dec 2018 17:11:28 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 14:54:49 +0100

tools/lib/lockdep/tests: Run lockdep tests a second time under Valgrind

This improves test coverage.

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
Link: https://lkml.kernel.org/r/20181207011148.251812-5-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/lib/lockdep/run_tests.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/lib/lockdep/run_tests.sh b/tools/lib/lockdep/run_tests.sh
index bc36178329a8..c8fbd0306960 100755
--- a/tools/lib/lockdep/run_tests.sh
+++ b/tools/lib/lockdep/run_tests.sh
@@ -31,3 +31,17 @@ find tests -name '*.c' | sort | while read -r i; do
 	fi
 	rm -f "tests/$testname"
 done
+
+find tests -name '*.c' | sort | while read -r i; do
+	testname=$(basename "$i" .c)
+	echo -ne "(PRELOAD + Valgrind) $testname... "
+	if gcc -o "tests/$testname" -pthread -Iinclude "$i" &&
+		{ timeout 10 valgrind --read-var-info=yes ./lockdep "./tests/$testname" >& "tests/${testname}.vg.out"; true; } &&
+		"tests/${testname}.sh" < "tests/${testname}.vg.out" &&
+		! grep -Eq '(^==[0-9]*== (Invalid |Uninitialised ))|Mismatched free|Source and destination overlap| UME ' "tests/${testname}.vg.out"; then
+		echo "PASSED!"
+	else
+		echo "FAILED!"
+	fi
+	rm -f "tests/$testname"
+done
