Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbeDNDAQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 23:00:16 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33205 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbeDNDAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 23:00:15 -0400
X-Google-Smtp-Source: AIpwx4+mCtuYqIgFI5c7KQuxjbA2GmfDfBaZsALWvMD+Bb1gSym/NgUCoH3QRn3BalXaTb236iaWaw==
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH 1/2] vsprintf: Tweak pF/pf comment
Date: Sat, 14 Apr 2018 12:00:05 +0900
Message-Id: <20180414030005.25831-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reflect changes that have happened to pf/pF (deprecation)
specifiers in pointer() comment section.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 lib/vsprintf.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 30c0cb8cc9bc..dd18bb2a56ef 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1746,10 +1746,10 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
  *
  * Right now we handle:
  *
- * - 'F' For symbolic function descriptor pointers with offset
- * - 'f' For simple symbolic function names without offset
- * - 'S' For symbolic direct pointers with offset
- * - 's' For symbolic direct pointers without offset
+ * - 'S' For symbolic direct pointers (or function descriptors) with offset
+ * - 's' For symbolic direct pointers (or function descriptors) without offset
+ * - 'F' Same as 'S'
+ * - 'f' Same as 's'
  * - '[FfSs]R' as above with __builtin_extract_return_addr() translation
  * - 'B' For backtraced symbolic direct pointers with offset
  * - 'R' For decoded struct resource, e.g., [mem 0x0-0x1f 64bit pref]
@@ -1846,10 +1846,6 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
  * ** When making changes please also update:
  *	Documentation/core-api/printk-formats.rst
  *
- * Note: The difference between 'S' and 'F' is that on ia64 and ppc64
- * function pointers are really function descriptors, which contain a
- * pointer to the real address.
- *
  * Note: The default behaviour (unadorned %p) is to hash the address,
  * rendering it useful as a unique identifier.
  */
-- 
2.17.0
