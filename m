Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932421AbeBVMQm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:16:42 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:61671 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932077AbeBVMQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:16:34 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w1MCFdUE020774
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] linux/const.h: prefix include guard of uapi/linux/const.h with _UAPI
Date: Thu, 22 Feb 2018 21:15:11 +0900
Message-Id: <1519301715-31798-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519301715-31798-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519301715-31798-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am going to add include/linux/const.h for the kernel space.

Add _UAPI to the include guard of include/uapi/linux/const.h to
prepare for that.

Please notice the guard name of the exported one will be kept as-is.
So, this commit has no impact to the userspace even if some userspace
stuff depends on the guard macro names.

scripts/headers_install.sh processes exported headers by SED, and
rips off "_UAPI" from guard macro names.

  #ifndef _UAPI_LINUX_CONST_H
  #define _UAPI_LINUX_CONST_H

will be turned into

  #ifndef _LINUX_CONST_H
  #define _LINUX_CONST_H

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - Split out as a prerequisite patch and describe detailed information

Changes in v2: None

 include/uapi/linux/const.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
index 9253775..c5a60eb 100644
--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /* const.h: Macros for dealing with constants.  */
 
-#ifndef _LINUX_CONST_H
-#define _LINUX_CONST_H
+#ifndef _UAPI_LINUX_CONST_H
+#define _UAPI_LINUX_CONST_H
 
 /* Some constant macros are used in both assembler and
  * C code.  Therefore we cannot annotate them always with
@@ -25,4 +25,4 @@
 #define _BITUL(x)	(_AC(1,UL) << (x))
 #define _BITULL(x)	(_AC(1,ULL) << (x))
 
-#endif /* !(_LINUX_CONST_H) */
+#endif /* _UAPI_LINUX_CONST_H */
-- 
2.7.4
