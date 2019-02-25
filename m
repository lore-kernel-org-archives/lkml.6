Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDF5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBD22087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551068188;
	bh=9/VcgJlF0VeLjXynAniKI2PtvOmDmrVXdPKmJZvWQ2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hnKeoL5oFp7q0aK2BjMlMJKlvLHEcbzRvJlnTC0cpH7pGLj4R/MTIBdZycaSh8PHU
	 vSjvt3A3xZZ/qqFlLN3J+3pPIWUI+labiHJrQqgplFfRf7tybLYFwqvCmMRWlpdQDB
	 A47uipA/pTD8ab2hrsRTypd+EIHvg+0AKwh8JqJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfBYEQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 23:16:26 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60623 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbfBYEQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 23:16:25 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 955892236C;
        Sun, 24 Feb 2019 23:16:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 24 Feb 2019 23:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=dT+FSjzlDoxAWbQ9BkLod3KwMclhmHGPjsGLU0mSpEc=; b=K7rymXkA
        I/5wZueIWxKfVv6qP/PbZ6X4BtbFG4qBJ2wjbvtYe6nyJsrHjoUSnuwWeDY60Hsa
        6jJhjvnkonDhBA4YWOotjipGsCnYMY8gCKEymT3LDl+qPCCmGc8YvpshP29bo8bd
        nx0i0xOlsNi6Kt9B6euhZsyUy6VaWIWytkIUX/2BRN+BAQjyHAZSR1DrY9FetkSU
        Ygw767udZYZ6zzNtt9k/mguflGaFI+JgrVal6zYlYs8VmFWNyrZ/9cvH6OoPUR4O
        AuHh4qyF7qtop3CdA7i4jwNuPFB7obuGjtJBjAxdJ6a/kIvFA5sPQoe7EP3JWikN
        agmRXtMssqs7YA==
X-ME-Sender: <xms:FmxzXAXrcvmsygXMjIl8WyFsfpmrvq51f5R24KU6-Z5IK4cUZjadow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrudehgdeijeculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghi
    nhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukf
    hppeduvdegrddugeelrdduvddvrdefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:FmxzXJ2Yr4KuCPSP4oYDOmORhRn9RFWnnrslIgEp4MlM05Fu8zXORw>
    <xmx:FmxzXGGoMBcsYk7rtuN_d9gNjE-75AZiD_IxFHwkGkVtkstoz023fQ>
    <xmx:FmxzXHjNsyLrErh1lqoLVBRxDQlYSksUAJ0surcXVJ9Wl9Hun1rd1w>
    <xmx:FmxzXH17xS5jFzmvkPRPCy8hkvlvi2YnL3DkxN-IaRVhRs8Gb9yNWA>
Received: from eros.localdomain (124-149-122-3.dyn.iinet.net.au [124.149.122.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 99327E40C2;
        Sun, 24 Feb 2019 23:16:16 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] lib/string: Add strscpy_pad() function
Date:   Mon, 25 Feb 2019 15:15:34 +1100
Message-Id: <20190225041534.27186-2-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225041534.27186-1-tobin@kernel.org>
References: <20190225041534.27186-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a function to copy strings safely and we have a function to copy
strings and zero the tail of the destination (if source string is
shorter than destination buffer) but we do not have a function to do
both at once.  This means developers must write this themselves if they
desire this functionality.  This is a chore, and also leaves us open to
off by one errors unnecessarily.

Add a function that calls strscpy() then memset()s the tail to zero if
the source string is shorter than the destination buffer.

Add test module for the new code.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/string.h |   4 +
 lib/Kconfig.debug      |   3 +
 lib/Makefile           |   1 +
 lib/string.c           |  47 +++++++++--
 lib/test_strscpy.c     | 175 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 223 insertions(+), 7 deletions(-)
 create mode 100644 lib/test_strscpy.c

diff --git a/include/linux/string.h b/include/linux/string.h
index 7927b875f80c..bfe95bf5d07e 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -31,6 +31,10 @@ size_t strlcpy(char *, const char *, size_t);
 #ifndef __HAVE_ARCH_STRSCPY
 ssize_t strscpy(char *, const char *, size_t);
 #endif
+
+/* Wraps calls to strscpy()/memset(), no arch specific code required */
+ssize_t strscpy_pad(char *dest, const char *src, size_t count);
+
 #ifndef __HAVE_ARCH_STRCAT
 extern char * strcat(char *, const char *);
 #endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d4df5b24d75e..fb629a0c6272 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1805,6 +1805,9 @@ config TEST_HEXDUMP
 config TEST_STRING_HELPERS
 	tristate "Test functions located in the string_helpers module at runtime"
 
+config TEST_STRSCPY
+	tristate "Test strscpy*() family of functions  at runtime"
+
 config TEST_KSTRTOX
 	tristate "Test kstrto*() family of functions at runtime"
 
diff --git a/lib/Makefile b/lib/Makefile
index e1b59da71418..59519926cbc6 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -42,6 +42,7 @@ obj-y += bcd.o div64.o sort.o parser.o debug_locks.o random32.o \
 obj-$(CONFIG_STRING_SELFTEST) += test_string.o
 obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
+obj-$(CONFIG_TEST_STRSCPY) += test_strscpy.o
 obj-y += hexdump.o
 obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
 obj-y += kstrtox.o
diff --git a/lib/string.c b/lib/string.c
index 38e4ca08e757..209444cb36d6 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -159,11 +159,9 @@ EXPORT_SYMBOL(strlcpy);
  * @src: Where to copy the string from
  * @count: Size of destination buffer
  *
- * Copy the string, or as much of it as fits, into the dest buffer.
- * The routine returns the number of characters copied (not including
- * the trailing NUL) or -E2BIG if the destination buffer wasn't big enough.
- * The behavior is undefined if the string buffers overlap.
- * The destination buffer is always NUL terminated, unless it's zero-sized.
+ * Copy the string, or as much of it as fits, into the dest buffer.  The
+ * behavior is undefined if the string buffers overlap.  The destination
+ * buffer is always NUL terminated, unless it's zero-sized.
  *
  * Preferred to strlcpy() since the API doesn't require reading memory
  * from the src string beyond the specified "count" bytes, and since
@@ -173,8 +171,10 @@ EXPORT_SYMBOL(strlcpy);
  *
  * Preferred to strncpy() since it always returns a valid string, and
  * doesn't unnecessarily force the tail of the destination buffer to be
- * zeroed.  If the zeroing is desired, it's likely cleaner to use strscpy()
- * with an overflow test, then just memset() the tail of the dest buffer.
+ * zeroed.  If zeroing is desired please use strscpy_pad().
+ *
+ * Return: The number of characters copied (not including the trailing
+ *         %NUL) or -E2BIG if the destination buffer wasn't big enough.
  */
 ssize_t strscpy(char *dest, const char *src, size_t count)
 {
@@ -237,6 +237,39 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 EXPORT_SYMBOL(strscpy);
 #endif
 
+/**
+ * strscpy_pad() - Copy a C-string into a sized buffer
+ * @dest: Where to copy the string to
+ * @src: Where to copy the string from
+ * @count: Size of destination buffer
+ *
+ * Copy the string, or as much of it as fits, into the dest buffer.  The
+ * behavior is undefined if the string buffers overlap.  The destination
+ * buffer is always NUL terminated, unless it's zero-sized.
+ *
+ * If the source string is shorter than the destination buffer, zeros
+ * the tail of the destination buffer.
+ *
+ * For full explanation of why you may want to consider using the
+ * 'strscpy' functions please see the function docstring for strscpy().
+ *
+ * Return: The number of characters copied (not including the trailing
+ *         %NUL) or -E2BIG if the destination buffer wasn't big enough.
+ */
+ssize_t strscpy_pad(char *dest, const char *src, size_t count)
+{
+	ssize_t written;
+
+	written = strscpy(dest, src, count);
+	if (written < 0 || written == count - 1)
+		return written;
+
+	memset(dest + written + 1, 0, count - written - 1);
+
+	return written;
+}
+EXPORT_SYMBOL(strscpy_pad);
+
 #ifndef __HAVE_ARCH_STRCAT
 /**
  * strcat - Append one %NUL-terminated string to another
diff --git a/lib/test_strscpy.c b/lib/test_strscpy.c
new file mode 100644
index 000000000000..5ec6a196f4e2
--- /dev/null
+++ b/lib/test_strscpy.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/string.h>
+
+/*
+ * Kernel module for testing 'strscpy' family of functions.
+ */
+
+static unsigned total_tests __initdata;
+static unsigned failed_tests __initdata;
+
+static void __init do_test(int count, char *src, int expected,
+			   int chars, int terminator, int pad)
+{
+	char buf[6];
+	int written;
+	int poison;
+	int index;
+	int i;
+	const char POISON = 'z';
+
+	total_tests++;
+	memset(buf, POISON, sizeof(buf));
+
+	/* Verify the return value */
+
+	written = strscpy_pad(buf, src, count);
+	if ((written) != (expected)) {
+		pr_err("%d != %d (written, expected)\n", written, expected);
+		goto fail;
+	}
+
+	/* Verify the state of the buffer */
+
+	if (count && written == -E2BIG) {
+		if (strncmp(buf, src, count - 1) != 0) {
+			pr_err("buffer state invalid for -E2BIG\n");
+			goto fail;
+		}
+		if (buf[count - 1] != '\0') {
+			pr_err("too big string is not null terminated correctly\n");
+			goto fail;
+		}
+	}
+
+	/* Verify the copied content */
+	for (i = 0; i < chars; i++) {
+		if (buf[i] != src[i]) {
+			pr_err("buf[i]==%c != src[i]==%c\n", buf[i], src[i]);
+			goto fail;
+		}
+	}
+
+	/* Verify the null terminator */
+	if (terminator) {
+		if (buf[count - 1] != '\0') {
+			pr_err("string is not null terminated correctly\n");
+			goto fail;
+		}
+	}
+
+	/* Verify the padding */
+	for (i = 0; i < pad; i++) {
+		index = chars + terminator + i;
+		if (buf[index] != '\0') {
+			pr_err("padding missing at index: %d\n", i);
+			goto fail;
+		}
+	}
+
+	/* Verify the rest is left untouched */
+	poison = 6 - chars - terminator - pad;
+	for (i = 0; i < poison; i++) {
+		index = 6 - 1 - i; /* Check from the end back */
+		if (buf[index] != POISON) {
+			pr_err("poison value missing at index: %d\n", i);
+			goto fail;
+		}
+	}
+
+	return;
+fail:
+	pr_info("%s(%d, '%s', %d, %d, %d, %d)\n", __func__,
+		count, src, expected, chars, terminator, pad);
+	failed_tests++;
+}
+
+static void __init test_fully(void)
+{
+	/* do_test(count, src, expected, chars, terminator, pad) */
+
+	do_test(0, "a", -E2BIG, 0, 0, 0);
+	do_test(0, "", -E2BIG, 0, 0, 0);
+
+	do_test(1, "a", -E2BIG, 0, 1, 0);
+	do_test(1, "", 0, 0, 1, 0);
+
+	do_test(2, "ab", -E2BIG, 1, 1, 0);
+	do_test(2, "a", 1, 1, 1, 0);
+	do_test(2, "", 0, 0, 1, 1);
+
+	do_test(3, "abc", -E2BIG, 2, 1, 0);
+	do_test(3, "ab", 2, 2, 1, 0);
+	do_test(3, "a", 1, 1, 1, 1);
+	do_test(3, "", 0, 0, 1, 2);
+
+	do_test(4, "abcd", -E2BIG, 3, 1, 0);
+	do_test(4, "abc", 3, 3, 1, 0);
+	do_test(4, "ab", 2, 2, 1, 1);
+	do_test(4, "a", 1, 1, 1, 2);
+	do_test(4, "", 0, 0, 1, 3);
+}
+
+static void __init test_basic(void)
+{
+	char buf[6];
+	int written;
+
+	memset(buf, 'a', sizeof(buf));
+
+	total_tests++;
+	written = strscpy_pad(buf, "bb", 4);
+	if (written != 2)
+		failed_tests++;
+
+	/* Correctly copied */
+	total_tests++;
+	if (buf[0] != 'b' || buf[1] != 'b')
+		failed_tests++;
+
+	/* Correctly padded */
+	total_tests++;
+	if (buf[2] != '\0' || buf[3] != '\0')
+		failed_tests++;
+
+	/* Only touched what it was supposed to */
+	total_tests++;
+	if (buf[4] != 'a' || buf[5] != 'a')
+		failed_tests++;
+}
+
+static int __init test_strscpy_init(void)
+{
+	pr_info("loaded.\n");
+
+	test_basic();
+	if (failed_tests)
+		goto out;
+
+	test_fully();
+
+out:
+	if (failed_tests == 0)
+		pr_info("all %u tests passed\n", total_tests);
+	else
+		pr_warn("failed %u out of %u tests\n", failed_tests, total_tests);
+
+	return failed_tests ? -EINVAL : 0;
+}
+module_init(test_strscpy_init);
+
+static void __exit test_strscpy_exit(void)
+{
+	pr_info("unloaded.\n");
+}
+module_exit(test_strscpy_exit);
+
+MODULE_AUTHOR("Tobin C. Harding <tobin@kernel.org>");
+MODULE_LICENSE("GPL");
-- 
2.20.1

