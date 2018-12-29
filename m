Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95798C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 15:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5542087F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 15:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeL2P6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 10:58:36 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:33001 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbeL2P6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 10:58:34 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id wBTFwJ9L012693;
        Sat, 29 Dec 2018 16:58:19 +0100
From:   Willy Tarreau <w@1wt.eu>
Cc:     mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 1/3] rcutorture/nolibc: fix the clobbered registers in the MIPS syscall definition
Date:   Sat, 29 Dec 2018 16:58:15 +0100
Message-Id: <20181229155817.12647-2-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20181229155817.12647-1-w@1wt.eu>
References: <20181229155817.12647-1-w@1wt.eu>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A last-minute checkpatch cleanup caused most of list of clobbered
registers to be lost in the MIPS syscall definition. As it is right
now the code is not used on MIPS, but it's better to fix it before
it gets used.

Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/rcutorture/bin/nolibc.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/nolibc.h b/tools/testing/selftests/rcutorture/bin/nolibc.h
index f98f5b9..30bd27b 100644
--- a/tools/testing/selftests/rcutorture/bin/nolibc.h
+++ b/tools/testing/selftests/rcutorture/bin/nolibc.h
@@ -1006,7 +1006,7 @@ struct sys_stat_struct {
 		: "=r"(_num), "=r"(_arg4)                                     \
 		: "r"(_num)                                                   \
 		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-									      \
+	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -1025,7 +1025,7 @@ struct sys_stat_struct {
 		: "0"(_num),                                                  \
 		  "r"(_arg1)                                                  \
 		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-									      \
+	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -1045,7 +1045,7 @@ struct sys_stat_struct {
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2)                                      \
 		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-									      \
+	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -1066,7 +1066,7 @@ struct sys_stat_struct {
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3)                          \
 		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-									      \
+	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -1087,7 +1087,7 @@ struct sys_stat_struct {
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4)              \
 		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-									      \
+	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -1110,7 +1110,7 @@ struct sys_stat_struct {
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5)  \
 		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-									      \
+	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
-- 
2.9.0

