Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeBYFWW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 00:22:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48136 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbeBYFWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 00:22:19 -0500
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] headers: linux/irq.h: drop 5 #included header files
To: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Message-ID: <02745e91-c117-74b5-d043-dceb3d4bb4e0@infradead.org>
Date: Sat, 24 Feb 2018 21:22:18 -0800
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

<linux/irq.h> does not use nor need several of its #included files,
so drop those header files from irq.h.

<linux/irq.h> is currently #included in around 1135 C source files
(oops, I didn't count other header files that #include it), making it
the 29th most-used header file.

Build tested on i386 and x86_64 * (allnoconfig, tiny.config, defconfig,
allyesconfig, and allmodconfig) and x64_64 allmodconfig + SMP=disabled.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Ingo/Thomas, please include this in tip.git for more thorough testing.
---
 include/linux/irq.h |    5 -----
 1 file changed, 5 deletions(-)

--- linux.orig/include/linux/irq.h
+++ linux.next/include/linux/irq.h
@@ -10,18 +10,13 @@
  * Thanks. --rmk
  */
 
-#include <linux/smp.h>
-#include <linux/linkage.h>
 #include <linux/cache.h>
 #include <linux/spinlock.h>
 #include <linux/cpumask.h>
-#include <linux/gfp.h>
 #include <linux/irqhandler.h>
 #include <linux/irqreturn.h>
 #include <linux/irqnr.h>
-#include <linux/errno.h>
 #include <linux/topology.h>
-#include <linux/wait.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 
