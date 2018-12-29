Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57331C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3739E20873
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeL2SC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 13:02:59 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:33031 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbeL2SC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 13:02:58 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id wBTI2OvD015843;
        Sat, 29 Dec 2018 19:02:24 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     mingo@kernel.org, paulmck@linux.vnet.ibm.com
Cc:     rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 2/4] rcutorture/nolibc: fix some poor indentation and alignment
Date:   Sat, 29 Dec 2018 19:02:17 +0100
Message-Id: <20181229180218.15798-3-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20181229180218.15798-1-w@1wt.eu>
References: <20181229180218.15798-1-w@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few macros had their rightmost backslash misaligned, and the pollfd
struct definition resisted the previous code reindent. Nothing else
changed.

Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/rcutorture/bin/nolibc.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/nolibc.h b/tools/testing/selftests/rcutorture/bin/nolibc.h
index 30bd27b..985364c 100644
--- a/tools/testing/selftests/rcutorture/bin/nolibc.h
+++ b/tools/testing/selftests/rcutorture/bin/nolibc.h
@@ -81,9 +81,9 @@ typedef   signed long        time_t;
 
 /* for poll() */
 struct pollfd {
-    int fd;
-    short int events;
-    short int revents;
+	int fd;
+	short int events;
+	short int revents;
 };
 
 /* for select() */
@@ -239,7 +239,7 @@ struct stat {
 		"syscall\n"                                                   \
 		: "=a" (_ret)                                                 \
 		: "0"(_num)                                                   \
-		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"                                \
+		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
 	);                                                                    \
 	_ret;                                                                 \
 })
@@ -255,7 +255,7 @@ struct stat {
 		: "=a" (_ret)                                                 \
 		: "r"(_arg1),                                                 \
 		  "0"(_num)                                                   \
-		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"                                \
+		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
 	);                                                                    \
 	_ret;                                                                 \
 })
@@ -272,7 +272,7 @@ struct stat {
 		: "=a" (_ret)                                                 \
 		: "r"(_arg1), "r"(_arg2),                                     \
 		  "0"(_num)                                                   \
-		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"                                \
+		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
 	);                                                                    \
 	_ret;                                                                 \
 })
@@ -290,7 +290,7 @@ struct stat {
 		: "=a" (_ret)                                                 \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3),                         \
 		  "0"(_num)                                                   \
-		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"                                \
+		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
 	);                                                                    \
 	_ret;                                                                 \
 })
-- 
2.9.0

