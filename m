Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 99667C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8CB208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="gwIS1Gk/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PmC5Pniu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8CB208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934886AbeFLAjt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:39:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51737 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934843AbeFLAjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:39:41 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0752D21D03;
        Mon, 11 Jun 2018 20:39:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 11 Jun 2018 20:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ZZ72QDn5X46qixFLx
        Fam4HSohOZAP8ybWu3r9d+Y2mE=; b=gwIS1Gk/96G4FE0/UHKH5SWoWfDz8IeK5
        qVg6MFIla/9mMLuKwcSPzBJpXbmYA1Hewdpd6rjs7wQz/0VHd/BE7FJswGcRBLHr
        VfItXL5dwr6NVLKckm3C3AVfN7fUGfVVISotTOwSTPm6OK3GTEdLV+yuhm6RBi7L
        9YR5G+MaHc7CnXo4XzvMEFeuFUg5SCo4nGlaXZIqZOCLWGbR+IZ73PFcFvATv1ex
        WI8feTs/Scqdf/wMEDvXdaCnJpcccFOWt1S6t7aAC1FB0KHdIYYUsh/GItiia1kH
        4ckOapCDxt/mJX7KXAYtROatO5HFzfArSXLSkBNUI+6C04I5Xf+ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ZZ72QDn5X46qixFLxFam4HSohOZAP8ybWu3r9d+Y2mE=; b=PmC5Pniu
        Z76TF7fTtciJYIZP1fsMOwJbwangPFAIjOEln3m8l+oSyggg8HxQn/mQ8eE/82ne
        8So0brxFu7l59EYGpL/je+qdckagMveXvyLNT21vs6V6a21zZHyUPzkkIbZWYxrN
        pKnZwdZj9uQokUWroxWfeqXloHc3XmqxeSpz1+63hpTA/QMainEjMOUmvEqiCdlT
        uJcbMyBFnGXzpKiE97RJcDSzmTEbr6dqJTz5ZaXLfHy8OkLzasI5EbYT2L37loBM
        e0F5i4hVMOwb46nHrOgELmnrrwKX0V5T1xFj+KKxROSNAhkck+3O0sxk7m2cu34f
        LjA1ypwU1bb+ZA==
X-ME-Proxy: <xmx:TBYfW0SZq3lH0jw8jO9xIlxq8v_O2skXSSL9_YC1jE_1Zbam6eJdSA>
X-ME-Proxy: <xmx:TBYfW20odSnGlwvQcNO4QXv2Ybu8FXYbXwrbNhbzFOTr8kXvHgBMSg>
X-ME-Proxy: <xmx:TBYfW-1p1p5QoiRQtPVe8wObnhj846TUZyzgGGKFrHDMRChV4jxXOA>
X-ME-Proxy: <xmx:TBYfW1upIOYKFyTMbOcJlXo3PB2-SAPds2H6AQ2CjWP6ZVqb2y9UFg>
X-ME-Proxy: <xmx:TBYfW_B0hBn4YWETutlBOEStZ_Ut1QzaSwXIBQ2n2DUPIxjy8AVhFw>
X-ME-Proxy: <xmx:TBYfW15KifqNc03uT24-0ix8OoPMvkj2yHM9uSzPgXPvPrbU8VoAwg>
X-ME-Sender: <xms:TBYfW_YzC39JbjlzWSlleZjvU-9G8QQddpuoU0-ptAX3MTjFTxPHMQ>
Received: from localhost (124-169-136-87.dyn.iinet.net.au [124.169.136.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3208AE425A;
        Mon, 11 Jun 2018 20:39:39 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/4] vsprintf: Add command line option debug_boot_weak_hash
Date:   Tue, 12 Jun 2018 10:39:14 +1000
Message-Id: <1528763954-27731-5-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528763954-27731-1-git-send-email-me@tobin.cc>
References: <1528763954-27731-1-git-send-email-me@tobin.cc>
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

Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
 lib/vsprintf.c                                  | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 638342d0a095..a116fc0366b0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -748,6 +748,15 @@
 
 	debug		[KNL] Enable kernel debugging (events log level).
 
+	debug_boot_weak_hash
+			[KNL] Enable printing pointers early in the boot
+			sequence.  If enabled, we use a weak hash instead of
+			siphash to hash pointers.  Use this option if you need
+			to see pointer values during early boot (i.e you are
+			seeing instances of '(___ptrval___)').
+			Cryptographically insecure, please do not use on
+			production kernels.
+
 	debug_locks_verbose=
 			[KNL] verbose self-tests
 			Format=<0|1>
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index c445f9f28760..6d2479eb7c2b 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1651,6 +1651,18 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
 
+/* Make pointers available for printing early in the boot sequence. */
+static int debug_boot_weak_hash __ro_after_init;
+EXPORT_SYMBOL(debug_boot_weak_hash);
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
 
@@ -1703,6 +1715,12 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
 	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
 	unsigned long hashval;
 
+	/* When debugging early boot use non-cryptographically secure hash */
+	if (unlikely(debug_boot_weak_hash)) {
+		hashval = hash_long((unsigned long)ptr, 32);
+		return pointer_string(buf, end, (const void *)hashval, spec);
+	}
+
 	if (static_branch_unlikely(&not_filled_random_ptr_key)) {
 		spec.field_width = 2 * sizeof(ptr);
 		/* string length must be less than default_width */
-- 
2.7.4

