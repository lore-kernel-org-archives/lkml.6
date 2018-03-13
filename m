Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeCMTeR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 15:34:17 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36315 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752625AbeCMTeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 15:34:15 -0400
X-Google-Smtp-Source: AG47ELuhd55DjZ6JgWfevoVjkj9/veh+0RY/2PM+zqxGN+IGSUiyGIwYwWmhgLuQPL8OxiMjWibKMw==
Date: Tue, 13 Mar 2018 22:34:10 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org
Subject: [PATCH] refcount: trim headers
Message-ID: <20180313193410.GA12260@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel.h is not needed, but compiler.h is.

mutex.h is not needed only a forward declaration.

spinlock.h is not needed, spinlock_types.h is enough.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/refcount.h |    7 ++++---
 lib/refcount.c           |    2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -3,9 +3,10 @@
 #define _LINUX_REFCOUNT_H
 
 #include <linux/atomic.h>
-#include <linux/mutex.h>
-#include <linux/spinlock.h>
-#include <linux/kernel.h>
+#include <linux/compiler.h>
+#include <linux/spinlock_types.h>
+
+struct mutex;
 
 /**
  * struct refcount_t - variant of atomic_t specialized for reference counts
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -35,7 +35,9 @@
  *
  */
 
+#include <linux/mutex.h>
 #include <linux/refcount.h>
+#include <linux/spinlock.h>
 #include <linux/bug.h>
 
 #ifdef CONFIG_REFCOUNT_FULL
