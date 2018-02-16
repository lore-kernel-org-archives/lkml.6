Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbeBPT2U (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:28:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:28230 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751401AbeBPT2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:28:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="27868865"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Tobin C. Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 7/7] lib/vsprintf: Mark expected switch fall-through
Date: Fri, 16 Feb 2018 21:28:06 +0200
Message-Id: <20180216192806.68914-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180216192806.68914-1-andriy.shevchenko@linux.intel.com>
References: <20180216192806.68914-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 20c0ab9faba5..bf0c45788100 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2094,6 +2094,7 @@ int format_decode(const char *fmt, struct printf_spec *spec)
 
 	case 'x':
 		spec->flags |= SMALL;
+		/* fall through */
 
 	case 'X':
 		spec->base = 16;
@@ -3048,8 +3049,10 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 			break;
 		case 'i':
 			base = 0;
+			/* fall through */
 		case 'd':
 			is_sign = true;
+			/* fall through */
 		case 'u':
 			break;
 		case '%':
-- 
2.15.1
