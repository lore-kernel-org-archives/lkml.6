Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B857C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A05E21901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550532271;
	bh=5uehcSbTaS5B7AoOBaMBaM+nzCt6xmoUWnkaTXxhcY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vtv/0uyuILt0qr8QbVsZ6LCXmGTwPI7sSfR12uOqrwHwgQ0g+T65/vnJ3qA2HlVRM
	 kaW6DFV+4tkrvj3Z5cGQFWgQHzxULnAkQ5jBiHnXCDhyPR6+EmWb1G8CbMLcivtYTV
	 gBPn7L5AN5243L+ENf9+BDr1VagesjR1K4tj5vVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbfBRXY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 18:24:29 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:40361 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730730AbfBRXYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 18:24:22 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 2D7563481;
        Mon, 18 Feb 2019 18:24:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 18 Feb 2019 18:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=GesfR975C7GXSJuXJWymo3Fhv9NK44xbOlcyXlyCbOk=; b=xgx287FH
        AMLAl4CUQUxjIcz2psOOAw5omubl//MhTw4uG6dJGsqEV++XoO6ZP9YSlUGXEt16
        B20pUZ3ZoDcpEW28JWWFmCK/wH7y7STITc0PEfViZ631UsTh/+PmzHPiYEZgtWjJ
        iUiYh8mW2KvNtmqs4Ib03TEwQH+CFpPadEoGuFCIU0igdLBcHmBKkthFyLd+EBIZ
        ukQKC3xEfWHeX6QB/AUw7XgC8snS94pWkBaRvi6N2q/9wpBn0I/q8BtNiYtD8/hP
        b3xjdYD8kCkw86ATJndWaIUYd31HzQ9Z9Brsr7MhDwgIzf6KLsaWeTRGLokr3h1M
        W3E8LwgW8zE9wA==
X-ME-Sender: <xms:pD5rXN0Itq-6ZlDcdzJhmkh6NV3Hg6tuOjUWsjOxgVf0_tg8HGpVNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtddvgddtjeculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghi
    nhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukf
    hppeduvddurdeggedrvddtvddrudeftdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:pD5rXIAT68kBSgY1G0oFei_rvEuTewDse1ZQD0x1mVZdDqwu634M3w>
    <xmx:pD5rXCcEkyo39scEeYIVUoqKJuzEFrJChxXHhi7x3NY6gxy354XS6g>
    <xmx:pD5rXCzY7fHbjaDYBFzLkJO2Mc-p_yZJI5ju9Ij0uz_p9qRCiLMoNQ>
    <xmx:pD5rXF_-xJWrcpXzX9QOnUgdDwc-8PN8d-vIfhcSJxROXfT87yGm4w>
Received: from eros.localdomain (ppp121-44-202-130.bras1.syd2.internode.on.net [121.44.202.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id CF248100E5;
        Mon, 18 Feb 2019 18:24:17 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] lib: Add function strscpy_from_user()
Date:   Tue, 19 Feb 2019 10:23:08 +1100
Message-Id: <20190218232308.11241-7-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218232308.11241-1-tobin@kernel.org>
References: <20190218232308.11241-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have strncpy_from_userspace().  If the user string is
longer than the destination kernel buffer we get an error code -EFAULT.
We are unable to recover from here because this is the same error
returned if the access to userspace fails totally.

There is no reason we cannot continue execution with the user string
truncated.

Add a function strscpy_from_user() that guarantees the string written is
null-terminated.  If user string is longer than destination buffer
truncates the string.  Returns the number of characters written
excluding the null-terminator.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 lib/strncpy_from_user.c | 43 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 11fe9a4a00fd..6bd603ccec7a 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -120,3 +120,46 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	return -EFAULT;
 }
 EXPORT_SYMBOL(strncpy_from_user);
+
+/**
+ * strscpy_from_user() - Copy a NUL terminated string from userspace.
+ * @dst:   Destination address, in kernel space.  This buffer must be at
+ *         least @count bytes long.
+ * @src:   Source address, in user space.
+ * @count: Maximum number of bytes to copy, including the trailing %NUL.
+ *
+ * Copies a NUL-terminated string from userspace to kernel space.  When
+ * the function returns @dst is guaranteed to be null terminated.
+ *
+ * Return: If access to userspace fails, returns -EFAULT.  Otherwise,
+ *         return the number of characters copied excluding the trailing
+ *         %NUL.
+ */
+long strscpy_from_user(char *dst, const char __user *src, long count)
+{
+	unsigned long max_addr, src_addr;
+
+	if (unlikely(count <= 0))
+		return 0;
+
+	max_addr = user_addr_max();
+	src_addr = (unsigned long)src;
+	if (likely(src_addr < max_addr)) {
+		unsigned long max = max_addr - src_addr;
+		long retval;
+
+		kasan_check_write(dst, count);
+		check_object_size(dst, count, false);
+		if (user_access_begin(src, max)) {
+			retval = do_strncpy_from_user(dst, src, count, max);
+			user_access_end();
+			if (retval == -EFAULT) {
+				dst[count-1] = '\0';
+				return count - 1;
+			}
+			return retval;
+		}
+	}
+	return -EFAULT;
+}
+EXPORT_SYMBOL(strscpy_from_user);
-- 
2.20.1

