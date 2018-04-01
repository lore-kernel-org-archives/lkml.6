Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754096AbeDAUky (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:40:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754082AbeDAUkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:40:52 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/45] C++: Do some basic C++ type definition
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:40:51 +0100
Message-ID: <152261525140.30503.4153878451546376512.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NULL should be defined as nullptr rather than (void *)0 as nullptr is a
special compiler type.

Don't define bool, true and false as these are defined by the compiler.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/stddef.h |   12 ++++++------
 include/linux/types.h  |    2 --
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 998a4ba28eba..470cf32e9119 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -4,13 +4,13 @@
 
 #include <uapi/linux/stddef.h>
 
-#undef NULL
-#define NULL ((void *)0)
+/*
+ * The type of the NULL pointer.  This is a special C++ pointer type.
+ */
+typedef decltype(nullptr) nullptr_t;
 
-enum {
-	false	= 0,
-	true	= 1
-};
+#undef NULL
+#define NULL nullptr
 
 #undef offsetof
 #ifdef __compiler_offsetof
diff --git a/include/linux/types.h b/include/linux/types.h
index 31e8258ac048..68323cb03910 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -31,8 +31,6 @@ typedef __kernel_timer_t	timer_t;
 typedef __kernel_clockid_t	clockid_t;
 typedef __kernel_mqd_t		mqd_t;
 
-typedef _Bool			bool;
-
 typedef __kernel_uid32_t	uid_t;
 typedef __kernel_gid32_t	gid_t;
 typedef __kernel_uid16_t        uid16_t;
