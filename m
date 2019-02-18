Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A0AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEF621901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550532262;
	bh=JwIQF2ouCes3Rq8CDXefH5ISvwDDLRTTBG9PgF2ptFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vWkg1Ok0VZIO9AW6VnGk+VwWS4dupsQ9cU16a2ad/1tFXGLxmdt+c1uJM6ljUNtib
	 OEDSmPiddTDnB8C/9s52Ng3kORfSWcEofyGnRhXyQVBzRt/TEo4ISabX7Z/z02Czn0
	 XVgkt9lqFQPjnH4uWc06z988W+HADe9ck/bGDxkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbfBRXYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 18:24:19 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:43959 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730730AbfBRXYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 18:24:15 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id EF318345F;
        Mon, 18 Feb 2019 18:24:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 18 Feb 2019 18:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=w3SU4u4HWNHuX1tPAKs+oZt1jVykzBguylycKMLAXFA=; b=PW9yqsvk
        9dfYbiIsTA3bZ4rwBOGtN1aQbQlZtA3WK/1OyFTFoPRJWkb07JqHmTpvkx5THvc+
        0I3GjPHCMk1weivf7uIWrUp5c1QSSpxJTDqdq1UhsDeynhcBm1SUldc1/R8ENYvz
        YDx7PjKYBhUeBfWTt1TiLc6VXwcI77hAjKvXPKrHX663Zm89Pe5feGaFhCdMexHb
        b2bf9xN1haJLsbarBBoCdm1Q9aUJxPtDwz0KtZbBbk44Te8+GI56/qKhkHr+1GMn
        gdlxninAwzOzqovaxsf20Y9DhrUOsO1iYClbx6TAZRPm7l+xdH4o74ell1H5Yvdl
        P+/WsjbEUI2nng==
X-ME-Sender: <xms:nT5rXMRfFxCHTeJuxZOCLEuq_tgiHw4XMn7DlnNSotTqgbH43foY0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtddvgddtjeculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghi
    nhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukf
    hppeduvddurdeggedrvddtvddrudeftdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:nT5rXBZXZRIU9s1sv8FEJ_AtxSDlDNoYctujM63fb_3vLZnH1F_osA>
    <xmx:nT5rXKDfdFMYMFgHQps5p7kLaWc8MYyU8DB3oh5tek2WXYze5cBCfQ>
    <xmx:nT5rXIDc7tdTEDR_ab6Syu6XsztjwrASCyYcnCOBKWYlOd81RI-WBQ>
    <xmx:nT5rXLVrmqN2I-NHu6HR88Q6Cc5FraWpvgKDQP6yh8CoQ6LCGGvEAQ>
Received: from eros.localdomain (ppp121-44-202-130.bras1.syd2.internode.on.net [121.44.202.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id 95629100E5;
        Mon, 18 Feb 2019 18:24:10 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] lib/string: Add string copy/zero function
Date:   Tue, 19 Feb 2019 10:23:06 +1100
Message-Id: <20190218232308.11241-5-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218232308.11241-1-tobin@kernel.org>
References: <20190218232308.11241-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a function to copy strings safely and we have a function to copy
strings _and_ zero the tail of the destination (if source string is
shorter than destination buffer) but we do not have a function to do
both at once.  This means developers must write this themselves if they
desire this functionality.  This is a chore, and also leaves us open to
off by one errors unnecessarily.

Add a function that calls strscpy() then memset()s the tail to zero if
the source string is shorter than the destination buffer.

Add testing via kselftest.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/string.h |  4 ++++
 lib/Kconfig.debug      |  2 +-
 lib/string.c           | 30 ++++++++++++++++++++++++++++--
 lib/test_string.c      | 31 +++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 7927b875f80c..695a5e6a31e3 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -31,6 +31,10 @@ size_t strlcpy(char *, const char *, size_t);
 #ifndef __HAVE_ARCH_STRSCPY
 ssize_t strscpy(char *, const char *, size_t);
 #endif
+
+/* Wrapper function, no arch specific code required */
+ssize_t strscpy_zeroed(char *dest, const char *src, size_t count);
+
 #ifndef __HAVE_ARCH_STRCAT
 extern char * strcat(char *, const char *);
 #endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0dca64c1d8a4..faa15ff47c4f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1807,7 +1807,7 @@ config TEST_STRING
        default n
        help
         Enable this option to test string manipulation functions.
-	Currently this only tests memset_{16,32,64}.
+	Currently this only tests memset_{16,32,64} and strscpy_zeroed().
 
 	If unsure, say N.
 
diff --git a/lib/string.c b/lib/string.c
index 65969cf32f5d..ff5106e8249f 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -171,8 +171,7 @@ EXPORT_SYMBOL(strlcpy);
  *
  * Preferred to strncpy() since it always returns a valid string, and
  * doesn't unnecessarily force the tail of the destination buffer to be
- * zeroed.  If the zeroing is desired, it's likely cleaner to use strscpy(),
- * check the return size, then just memset() the tail of the dest buffer.
+ * zeroed.  If the zeroing is desired use strscpy_zeroed().
  *
  * Return: The number of characters copied (not including the trailing
  *         NUL) or -E2BIG if the destination buffer wasn't big enough.
@@ -238,6 +237,33 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 EXPORT_SYMBOL(strscpy);
 #endif
 
+/**
+ * strscopy_zeroed() - Copy a C-string into a sized buffer
+ * @dest: Where to copy the string to
+ * @src: Where to copy the string from
+ * @count: Size of destination buffer
+ *
+ * If the source string is shorter than the destination buffer, zeros
+ * the tail of the destination buffer.
+ *
+ * Return: The number of characters copied (not including the trailing
+ *         NUL) or -E2BIG if the destination buffer wasn't big enough.
+ */
+ssize_t strscpy_zeroed(char *dest, const char *src, size_t count)
+{
+	ssize_t written;
+
+	written = strscpy(dest, src, count);
+	if (written < 0)
+		return written;
+
+	if (written < count)
+		memset(dest + written, 0, count - written);
+
+	return written;
+}
+EXPORT_SYMBOL(strscpy_zeroed);
+
 #ifndef __HAVE_ARCH_STRCAT
 /**
  * strcat - Append one %NUL-terminated string to another
diff --git a/lib/test_string.c b/lib/test_string.c
index a9cba442389a..cc4eef51a395 100644
--- a/lib/test_string.c
+++ b/lib/test_string.c
@@ -111,6 +111,32 @@ static __init int memset64_selftest(void)
 	return 0;
 }
 
+static __init int strscpy_zeroed_selftest(void)
+{
+	char buf[6];
+	int written;
+
+	memset(buf, 'a', sizeof(buf));
+
+	written = strscpy_zeroed(buf, "bb", 4);
+	if (written != 2)
+		return 1;
+
+	/* Copied correctly */
+	if (buf[0] != 'b' || buf[1] != 'b')
+		return 2;
+
+	/* Zeroed correctly */
+	if (buf[2] != '\0' || buf[3] != '\0')
+		return 3;
+
+	/* Only touched what it was supposed to */
+	if (buf[4] != 'a' || buf[5] != 'a')
+		return 4;
+
+	return 0;
+}
+
 static __init int test_string_init(void)
 {
 	int test, subtest;
@@ -130,6 +156,11 @@ static __init int test_string_init(void)
 	if (subtest)
 		goto fail;
 
+	test = 4;
+	subtest = strscpy_zeroed_selftest();
+	if (subtest)
+		goto fail;
+
 	pr_info("String selftests succeeded\n");
 	return 0;
 fail:
-- 
2.20.1

