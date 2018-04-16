Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx4/ndaCETMOo52cIJgzG9adnSRaA5S9yXCYS6fIgAxSOauMZjP5jpX6oissNFBGIPIP6wa58
ARC-Seal: i=1; a=rsa-sha256; t=1523839394; cv=none;
        d=google.com; s=arc-20160816;
        b=UHpsQHqgBgLxQ1OXFSwKDspoNKYEJxnkLFTCG+yJL1HHzKnauwmJmU7nntgpW/hEV+
         jubYyJSc5DBM0ZOeUdYiVZ29TZGoZ8f5To2T0wx+iLSqljBEcYgpZIkSMQXVOPAGCuiz
         vux2BVjswUm6g0deg7Ar3yGxbIW9olh4OdYSorSBU1BsIludzxz3cItsGVt6+IJKipm6
         JB+y9M/T3siNvgIHdsSR+fhLyxhOnGNRimXiIpX1hasUDBwZe2mXnD0t8e+RdfdjxhJC
         hb/v7FPpYlWzr25mmkMTs+g7wbztsdOrCjUOvS6Clb3DKrbu0CRA2xAKc18ywwf46b4h
         kfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=igJLySw/KBGP6l850CBA91WbqrfN3PXMNw8I7LIconE=;
        b=aWyD+ISU++0Zg9Rn38KeoAk6NAFBpF2a3fiaCzu8Y98NMpgNjOVlwqkXxJZZqSh+lb
         ov5aMrD8ziQs8MabEF29t1W1Nme8oXvxyuIEMN8q3isnmPxCrV2t7nphJFJdq3GeuYhx
         WILVgfuYUyLzXG0vvJ5xx5/tEPQdwODZ0PePFdscFYdZw/jl4s5ETmB1pctr3uYI2Jeg
         TuFPeg1A8668GSyZqOQpqRYeFyvN/LhcjPKJpYPIYQ3B9YEG5DTYTfPuCpr3KPXZGJSV
         6Vt+CtF7mhQ2RwxjTVXdeXJ6E7l4+6AbR/26n6I/sKjHPxw2bGiuMW5j4la0NEVTWUNQ
         S8jA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Mon, 16 Apr 2018 10:42:37 +1000
Subject: [PATCH 2/6] staging: lustre: remove libcfs/linux/libcfs.h
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152383935734.23409.11654775387996961581.stgit@noble>
In-Reply-To: <152383910760.23409.2327082725637657049.stgit@noble>
References: <152383910760.23409.2327082725637657049.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597861416639795430?=
X-GMAIL-MSGID: =?utf-8?q?1597861416639795430?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This include file is only included in one place,
and only contains a list of other include directives.
So just move all those to the place where this file
is included, and discard the file.

One include directive uses a local name ("linux-cpu.h"), so
that needs to be given a proper path.

Probably many of these should be remove from here, and moved to
just the files that need them.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 .../staging/lustre/include/linux/libcfs/libcfs.h   |   43 ++++++++++
 .../lustre/include/linux/libcfs/linux/libcfs.h     |   83 --------------------
 2 files changed, 42 insertions(+), 84 deletions(-)
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
index 62e46aa3c554..e59d107d6482 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
@@ -38,7 +38,48 @@
 #include <linux/list.h>
 
 #include <uapi/linux/lnet/libcfs_ioctl.h>
-#include <linux/libcfs/linux/libcfs.h>
+#include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/ctype.h>
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/highmem.h>
+#include <linux/interrupt.h>
+#include <linux/kallsyms.h>
+#include <linux/kernel.h>
+#include <linux/kmod.h>
+#include <linux/kthread.h>
+#include <linux/mm.h>
+#include <linux/mm_inline.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/pagemap.h>
+#include <linux/random.h>
+#include <linux/rbtree.h>
+#include <linux/rwsem.h>
+#include <linux/scatterlist.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/stat.h>
+#include <linux/string.h>
+#include <linux/time.h>
+#include <linux/timer.h>
+#include <linux/types.h>
+#include <linux/unistd.h>
+#include <linux/vmalloc.h>
+#include <net/sock.h>
+#include <linux/atomic.h>
+#include <asm/div64.h>
+#include <linux/timex.h>
+#include <linux/uaccess.h>
+#include <stdarg.h>
+#include <linux/libcfs/linux/linux-cpu.h>
+
 #include <linux/libcfs/libcfs_debug.h>
 #include <linux/libcfs/libcfs_private.h>
 #include <linux/libcfs/libcfs_cpu.h>
diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
deleted file mode 100644
index 83aec9c7698f..000000000000
--- a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
+++ /dev/null
@@ -1,83 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * GPL HEADER START
- *
- * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 only,
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License version 2 for more details (a copy is included
- * in the LICENSE file that accompanied this code).
- *
- * You should have received a copy of the GNU General Public License
- * version 2 along with this program; If not, see
- * http://www.gnu.org/licenses/gpl-2.0.html
- *
- * GPL HEADER END
- */
-/*
- * Copyright (c) 2008, 2010, Oracle and/or its affiliates. All rights reserved.
- * Use is subject to license terms.
- *
- * Copyright (c) 2012, Intel Corporation.
- */
-/*
- * This file is part of Lustre, http://www.lustre.org/
- * Lustre is a trademark of Sun Microsystems, Inc.
- */
-
-#ifndef __LIBCFS_LINUX_LIBCFS_H__
-#define __LIBCFS_LINUX_LIBCFS_H__
-
-#ifndef __LIBCFS_LIBCFS_H__
-#error Do not #include this file directly. #include <linux/libcfs/libcfs.h> instead
-#endif
-
-#include <linux/bitops.h>
-#include <linux/compiler.h>
-#include <linux/ctype.h>
-#include <linux/errno.h>
-#include <linux/file.h>
-#include <linux/fs.h>
-#include <linux/highmem.h>
-#include <linux/interrupt.h>
-#include <linux/kallsyms.h>
-#include <linux/kernel.h>
-#include <linux/kmod.h>
-#include <linux/kthread.h>
-#include <linux/mm.h>
-#include <linux/mm_inline.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/mutex.h>
-#include <linux/notifier.h>
-#include <linux/pagemap.h>
-#include <linux/random.h>
-#include <linux/rbtree.h>
-#include <linux/rwsem.h>
-#include <linux/scatterlist.h>
-#include <linux/sched.h>
-#include <linux/signal.h>
-#include <linux/slab.h>
-#include <linux/smp.h>
-#include <linux/stat.h>
-#include <linux/string.h>
-#include <linux/time.h>
-#include <linux/timer.h>
-#include <linux/types.h>
-#include <linux/unistd.h>
-#include <linux/vmalloc.h>
-#include <net/sock.h>
-#include <linux/atomic.h>
-#include <asm/div64.h>
-#include <linux/timex.h>
-#include <linux/uaccess.h>
-#include <stdarg.h>
-#include "linux-cpu.h"
-
-#endif /* _LINUX_LIBCFS_H */
