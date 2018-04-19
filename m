Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeDSInB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 04:43:01 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33753 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeDSIm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 04:42:58 -0400
X-Google-Smtp-Source: AIpwx4/ZtBfmMyoeBCq6VM4G0fCYA0qjbb4fpq/Y4FDFM5M+eQRGLOVAAhMftCRejVSxMYZCc1blDg==
From: SeongJae Park <sj38.park@gmail.com>
To: paulmck@linux.vnet.ibm.com, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 1/2] atomic_ops.rst: Fix wrong example code
Date: Thu, 19 Apr 2018 17:42:44 +0900
Message-Id: <20180419084245.17096-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Example code snippets for necessary of READ_ONCE() and WRITE_ONCE() has
an unnecessary line of code and wrong condition.  This commit fixes
them.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 Documentation/core-api/atomic_ops.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-api/atomic_ops.rst
index fce929144ccd..4ea4af71e68a 100644
--- a/Documentation/core-api/atomic_ops.rst
+++ b/Documentation/core-api/atomic_ops.rst
@@ -111,7 +111,6 @@ If the compiler can prove that do_something() does not store to the
 variable a, then the compiler is within its rights transforming this to
 the following::
 
-	tmp = a;
 	if (a > 0)
 		for (;;)
 			do_something();
@@ -119,7 +118,7 @@ the following::
 If you don't want the compiler to do this (and you probably don't), then
 you should use something like the following::
 
-	while (READ_ONCE(a) < 0)
+	while (READ_ONCE(a) > 0)
 		do_something();
 
 Alternatively, you could place a barrier() call in the loop.
-- 
2.13.0
