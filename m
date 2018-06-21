Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1F1C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EE022535
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="g+cQTX/V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z82J7Nw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EE022535
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934104AbeFUXQF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:16:05 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42707 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933996AbeFUXQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:16:02 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9525F21AEF;
        Thu, 21 Jun 2018 19:16:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Jun 2018 19:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hRh8DhN/VTnApqBPr
        9aQSxCnJuYDQ7v5Rpxp7Szz0ag=; b=g+cQTX/VpKsMr1c2fPKmSfYAr05QCg3VP
        R64A7wHFoGQx1XvUdk9KlMdIMWt5wyTt85WLxYwj3mD7IXcAdv0TwQx9sNHdOpOC
        dxPNfHpx3J+BlaMIiqNq58muD4uzTqjE/F+tHvXpYFZ9am9rfVwbZKYmTJ75eWPA
        IY5e5dXY0fEeaSYRTKDvJLWpvxrH62Hx9ir/PJ8qA2tv0PWIGExtD3fpKzCAzyMH
        59X5nlEtXztgadqFYxmMMQigYqK/Y2vGeuquTBzK6Hgo9eMWUay1q93UGPKCtXWQ
        /zlQP/7q85AULqpFpKmwr0aehB0Mzo/qRjXqZNUZzfXluEpMrQxXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=hRh8DhN/VTnApqBPr9aQSxCnJuYDQ7v5Rpxp7Szz0ag=; b=Z82J7Nw8
        OhYYhw/X07CyGpIK3qhYI3aa2gDUhDfq4h/oBZ8TpaDaeUvLbTyQQC5yrc4eS+ga
        yk2nlTBYtlkbpWKDwBnAFgWhwcochAo9E15UzXQKK1RmO/hE3B5F/31mY6FE2YmJ
        T8XFx3uSSbnwlqsSTUL6opXofGppdQjajqWWAxlIY2huKvnl9VY7iBNmHSA/725d
        /hwakyC2QVX0oaH1KnReCiiT10EUAsNCPPmqFBZs5QSM5hqfAzCCOJp3tCoyzCoR
        ARl6ArlCYMPta8/UkUrlnMifkWqDlk8W8IeFFLD8Lv6xcWChOKNnxHoCfAwvUy21
        hS1oidjSpfrwnQ==
X-ME-Proxy: <xmx:sTEsW81U4HYjemeQPh6k9p6hL16n68t2LuPpovgMbwLXxlsWwxr5YA>
    <xmx:sTEsW95k7IAt3KL6Qlk8LBxKQCzJU-NHptTUOHOR14eoxq5ICP8Q1A>
    <xmx:sTEsW5LZWX1OWEY9NItWD--JPM308Vduk0eNlZ4dHZlGWkEkezZ9cQ>
    <xmx:sTEsW-lSP051jCPe6d16lMY1gpifQpiwZPhFD4CikV0g_jjYBZ344Q>
    <xmx:sTEsWyj-IYLnzAzLUAMX_-tMgV_ZO-7DI23ZmqLeEedOXh6dR-5R7g>
    <xmx:sTEsW3ni9u8o_BFNgNDnyJ459HA2QcO2jcWwpZ5emoN_08-oqhZIJQ>
X-ME-Sender: <xms:sTEsWzW2orqPWj1CNlRYVIyHfrgG041wZqQuhW7236YbtO6WX5LkaQ>
Received: from localhost (124-169-15-204.dyn.iinet.net.au [124.169.15.204])
        by mail.messagingengine.com (Postfix) with ESMTPA id C16D3E4449;
        Thu, 21 Jun 2018 19:16:00 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/4] vsprintf: Add command line option debug_boot_weak_hash
Date:   Fri, 22 Jun 2018 09:15:34 +1000
Message-Id: <20180621231534.32278-5-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621231534.32278-1-me@tobin.cc>
References: <20180621231534.32278-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently printing [hashed] pointers requires enough entropy to be
available.  Early in the boot sequence this may not be the case
resulting in a dummy string '(____ptrval____)' being printed.  This
makes debugging the early boot sequence difficult.  We can relax the
requirement to use cryptographically secure hashing during debugging.
This enables debugging while keeping development/production kernel
behaviour the same.

If new command line option debug_boot_weak_hash is enabled use
cryptographically insecure hashing and hash pointer value immediately.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
 lib/vsprintf.c                                  | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 638342d0a095..c47b5efbef82 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -748,6 +748,14 @@
 
 	debug		[KNL] Enable kernel debugging (events log level).
 
+	debug_boot_weak_hash
+			[KNL] Enable printing [hashed] pointers early in the
+			boot sequence.  If enabled, we use a weak hash instead
+			of siphash to hash pointers.  Use this option if you are
+			seeing instances of '(___ptrval___)') and need to see a
+			value (hashed pointer) instead. Cryptographically
+			insecure, please do not use on production kernels.
+
 	debug_locks_verbose=
 			[KNL] verbose self-tests
 			Format=<0|1>
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 6c1fb395bddf..1ee2829f3b54 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1651,6 +1651,17 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
 
+/* Make pointers available for printing early in the boot sequence. */
+static int debug_boot_weak_hash __ro_after_init;
+
+static int __init debug_boot_weak_hash_enable(char *str)
+{
+	debug_boot_weak_hash = 1;
+	pr_info("debug_boot_weak_hash enabled\n");
+	return 0;
+}
+early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
+
 static DEFINE_STATIC_KEY_TRUE(not_filled_random_ptr_key);
 static siphash_key_t ptr_key __read_mostly;
 
@@ -1703,6 +1714,12 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
 	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
 	unsigned long hashval;
 
+	/* When debugging early boot use non-cryptographically secure hash. */
+	if (unlikely(debug_boot_weak_hash)) {
+		hashval = hash_long((unsigned long)ptr, 32);
+		return pointer_string(buf, end, (const void *)hashval, spec);
+	}
+
 	if (static_branch_unlikely(&not_filled_random_ptr_key)) {
 		spec.field_width = 2 * sizeof(ptr);
 		/* string length must be less than default_width */
-- 
2.17.1

