Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbeBZRzh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:55:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:35287 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750762AbeBZRzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:55:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,397,1515484800";
   d="scan'208";a="30794331"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>, Willy Tarreau <w@1wt.eu>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] kernel.h: Update comment about simple_strto<foo>() functions
Date: Mon, 26 Feb 2018 19:55:32 +0200
Message-Id: <20180226175532.70556-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were discussions in the past about use cases for
simple_strto<foo>() functions and in some rare cases they have a benefit
on kstrto<foo>() ones.

Update a comment to reduce confusing about special use cases.

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/kernel.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 207b0702fad1..07ad6f36b17d 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -326,8 +326,7 @@ int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the obsolete simple_strtoull. Return code must
- * be checked.
+ * Used as a replacement for the simple_strtoull. Return code must be checked.
 */
 static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
 {
@@ -355,8 +354,7 @@ static inline int __must_check kstrtoul(const char *s, unsigned int base, unsign
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the obsolete simple_strtoull. Return code must
- * be checked.
+ * Used as a replacement for the simple_strtoull. Return code must be checked.
  */
 static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
 {
@@ -432,7 +430,15 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
 	return kstrtoint_from_user(s, count, base, res);
 }
 
-/* Obsolete, do not use.  Use kstrto<foo> instead */
+/*
+ * Use kstrto<foo> instead.
+ *
+ * NOTE: The simple_strto<foo> do not check for overflow and depending
+ *       on the input may give interesting results.
+ *
+ * Use these functions if and only if the code will need in place
+ * conversion and otherwise looks very ugly. Keep in mind above caveat.
+ */
 
 extern unsigned long simple_strtoul(const char *,char **,unsigned int);
 extern long simple_strtol(const char *,char **,unsigned int);
-- 
2.16.1
