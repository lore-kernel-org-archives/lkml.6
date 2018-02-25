Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeBYFWS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 00:22:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeBYFWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 00:22:17 -0500
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] headers: linux/mutex.h: drop linkage.h
To: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Message-ID: <582b3892-4e4c-06b2-a368-5c2d439de7fc@infradead.org>
Date: Sat, 24 Feb 2018 21:22:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

<linux/mutex.h> does not use nor need <linux/linkage.h>, so drop that
one header file from mutex.h.

<linux/mutex.h> is currently #included in around 1250 C source files
(oops, I didn't count other header files that #include it), making it
the 27th most-used header file.

Build tested on i386 and x86_64 * (allnoconfig, tiny.config, defconfig,
allyesconfig, and allmodconfig) and x64_64 allmodconfig + SMP=disabled.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Ingo/Thomas, please include this in tip.git for more thorough testing.

 include/linux/mutex.h |    1 -
 1 file changed, 1 deletion(-)

--- linux.orig/include/linux/mutex.h
+++ linux.next/include/linux/mutex.h
@@ -14,7 +14,6 @@
 #include <asm/current.h>
 #include <linux/list.h>
 #include <linux/spinlock_types.h>
-#include <linux/linkage.h>
 #include <linux/lockdep.h>
 #include <linux/atomic.h>
 #include <asm/processor.h>
