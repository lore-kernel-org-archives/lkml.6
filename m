Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4684C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8434B20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="E4KOvwZp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YMeSPcwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8434B20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754172AbeFTEVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:21:24 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53357 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751629AbeFTEVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:21:13 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5D65221BB9;
        Wed, 20 Jun 2018 00:21:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 20 Jun 2018 00:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rujDf7o9LixDU/Ads
        V+/5mDR5ROiUtOeCesyIvHzAuE=; b=E4KOvwZpSjc6VhIJo2l0muajutdI7Ki2w
        /f7wXbNjGolaOtNRceVNU6pF4NcKmR4ugVaFVvA34KBk/vEB2TmFzUfY6qZI+GGG
        UvM/j+q2dIBchVo4YIelfoX7BQpsBkH2M+HYpybDLRxgw+1qx2WCp40UB9DNxuLh
        xPY8E95MnE9ynjI7qBt1vpofkIgIT45m7KZrixRjgly79pd8TaVl9Kk+3SHghpoJ
        BHapADvJJRaGep8jAWvUqRYyOeduVFqSHnM9sEMLBSRzSgr03haYf7xSIxHyXeQC
        WTKFXG2Lu2z/L8kz83slIzjnz3s/7BKxqfuTK0Bl0gA7sJGk9Cy6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=rujDf7o9LixDU/AdsV+/5mDR5ROiUtOeCesyIvHzAuE=; b=YMeSPcwD
        QQoy4LTqSQ6uaQ7K1t4/gbIlo149dMx5NH4h2ogOvG6WM7T0SZyBKRKnP8ojepu4
        fXh6yeO3896bQuLyrK4lDLvHb+wwtXTutJufJsz2+vsInLKUrUp6U0h/rnBWgQsD
        zn5Iu4l6P3zJ8n7PrIvuFZKt8S0U1lThUtTgri4mD16u1xk+sps/Fpr9n0Yt0GSU
        Frk/0Nr5CopeoIDAWO8Gc7D0ReOLqiGUIvitLEBuNoEaD2nyNic5csT8ydb1zkp1
        hbt3/B9JlySzZdnRzefiVh5+Kl49Qcm/htLQ14Lhnxy9/sfo8yiWzunsvVVU1r9l
        waS0EJ1z6ob5QQ==
X-ME-Proxy: <xmx:ONYpWzRsryY7D4vLlmCKodXqWtcIGhBL6avODx7nP7zaibPocHdt8w>
    <xmx:ONYpW0xmszL_uGt31t-sFSQCQK-xcvCEPR0bleTCqw7GQiAoroumew>
    <xmx:ONYpWz3kLYQLMrPhp62JsNen6-e_hklTbPyOLXX-d8niYQoveGWtUw>
    <xmx:ONYpW9rHUU6XtKGoOxTTj43ZDbcmYl1wJkHx4DGFIY_SpTmB59Purg>
    <xmx:ONYpW_dvBiMcP9FBLQ7axP5uQNn_2x1jbJOpqkNCbdYY4-ZlrLlDdw>
    <xmx:ONYpWxcvHFxuyquBva4YQpHSYYziXe1_r9I3YQFkcVaBa0IjsmaFIA>
X-ME-Sender: <xms:ONYpW-0xQEDDMq0cRw4V-pyZ9_uwBGR5H26zn20FXIIS2W_dfc8g9A>
Received: from localhost (ppp118-211-207-6.bras1.syd2.internode.on.net [118.211.207.6])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8ADEFE4076;
        Wed, 20 Jun 2018 00:21:11 -0400 (EDT)
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
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/4] vsprintf: Add command line option debug_boot_weak_hash
Date:   Wed, 20 Jun 2018 14:20:46 +1000
Message-Id: <20180620042046.30806-5-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620042046.30806-1-me@tobin.cc>
References: <20180620042046.30806-1-me@tobin.cc>
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

Signed-off-by: Tobin C. Harding <me@tobin.cc>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
 lib/vsprintf.c                                  | 17 +++++++++++++++++
 2 files changed, 26 insertions(+)

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
index c445f9f28760..17ebe076ae41 100644
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
2.17.1

