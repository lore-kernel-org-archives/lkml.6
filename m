Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbeBPT3z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:29:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:32804 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751357AbeBPT2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:28:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="201741320"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Tobin C. Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/7] lib/test_printf: Mark big constant with ULL
Date: Fri, 16 Feb 2018 21:28:00 +0200
Message-Id: <20180216192806.68914-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse complains that constant is so bit for unsigned long on 64-bit
architecture.

lib/test_printf.c:217:54: warning: constant 0xffff0123456789ab is so big it is unsigned long
lib/test_printf.c:246:54: warning: constant 0xffff0123456789ab is so big it is unsigned long

To satisfy everyone, mark the constant with ULL.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test_printf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 71ebfa43ad05..309cf8d7e6d4 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -204,7 +204,7 @@ test_string(void)
 #if BITS_PER_LONG == 64
 
 #define PTR_WIDTH 16
-#define PTR ((void *)0xffff0123456789ab)
+#define PTR ((void *)0xffff0123456789abULL)
 #define PTR_STR "ffff0123456789ab"
 #define ZEROS "00000000"	/* hex 32 zero bits */
 
-- 
2.15.1
