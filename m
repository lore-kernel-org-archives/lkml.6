Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D76C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77EE22533
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="MgpgiVyr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WabPF2TC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77EE22533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934052AbeFUXQB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:16:01 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40601 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933996AbeFUXP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:15:58 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DC80222092;
        Thu, 21 Jun 2018 19:15:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 21 Jun 2018 19:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=X9f16w5jbDY0AGj12
        bqazCA5F6tTBBebSjDlgQzs9Zg=; b=MgpgiVyrliBq3y7rqh9LELO2A5piwJJu9
        Lss/oMS7oNrSJdKRmYfwMju2tnemS2RjcfjegeOJOQukbDLSupjKv6/EH6AnPSGP
        ha08ByaRBSCi9LleDe2rjLA6xoEwBiynNPJ0jQallqco0CoX6Rw1aJ2DaiuNOiKh
        LdsXTP2omYihFOctKvAapKsxA/FBSaw8l5xSsOuRRCO/lPoz4YILhIZhGSkshc1+
        fHrswBNVETPTsvA4YgtnMJH/Cr9xMgLKasZl51uKCq/9q9nm6BRkpyWuEVnvPjnV
        +IV/71ozcxhDKyj0v5uT0Ye7vSM84ZBxAxpM42XPpAvkUgAgIspDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=X9f16w5jbDY0AGj12bqazCA5F6tTBBebSjDlgQzs9Zg=; b=WabPF2TC
        Lh6Xpqawt07K2YL7H5HibeAMYhM9douvk8Waa5wEMNXNlrTAzpOrYrCl6s6BE8zp
        W5LRKylEsIBWqbZEGImvNk6KbEtGXqbRY5ICYhDeH8Zee9egZYfljAd7PooOhoXR
        GFqnrYjVcqNHxiuJznJnRcSJKNcbogGF7b5E2bBbpSlMNctImIVGl+8w2qIKiYxl
        YVd1nEYe+FlmLi2WWteGg8ki5aR82QlqTyOWZXTXw5g0m5ciWnPb/9NNsn1jPHqd
        1ehG9H4yHZygOiAOEUP2zluLG3RmXp6FQTR9nh2kuVtT+BrdhA7+abjnBk3U3M2q
        +ZhTEIq5f4sdcw==
X-ME-Proxy: <xmx:rTEsW9X45l94zfGwRgiEMvjIOPzIUmvmDJj6z_VVepzngDj-FIcPoA>
    <xmx:rTEsW2bAVsqTFF1s4CAQhjbwPyRNXYv3l8lGg7vB_vUX7hoYtY6DWA>
    <xmx:rTEsWwVKqOuzffRd-kRENivC7xN61ztAox46_hkzVcupK4PE7ngEyg>
    <xmx:rTEsW543N-YAq2lBNjOnff4aCc7NP8PaJz-7IAAUg2vouTtcK3-38A>
    <xmx:rTEsWwea8EdLMAUP0CVQErUoV5p9wW0ba3pVz4ddCnqBwyUcgpYjnQ>
    <xmx:rTEsWw1zMKQul3NHMc_7BdjxSEJL9rrhIUHBT931lcbd_u7YSJe2Og>
X-ME-Sender: <xms:rTEsW5_1vFigSGsUMsYIZdRl69A8KZM7cDAPaGrBEbUQBsMJwagnkQ>
Received: from localhost (124-169-15-204.dyn.iinet.net.au [124.169.15.204])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1AB9810252;
        Thu, 21 Jun 2018 19:15:56 -0400 (EDT)
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
Subject: [PATCH v9 3/4] vsprintf: Use hw RNG for ptr_key
Date:   Fri, 22 Jun 2018 09:15:33 +1000
Message-Id: <20180621231534.32278-4-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621231534.32278-1-me@tobin.cc>
References: <20180621231534.32278-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we must wait for enough entropy to become available before
hashed pointers can be printed.  We can remove this wait by using the
hw RNG if available.

Use hw RNG to get keying material.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/vsprintf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index a48aaa79d352..6c1fb395bddf 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1675,8 +1675,16 @@ static struct random_ready_callback random_ready = {
 
 static int __init initialize_ptr_random(void)
 {
-	int ret = add_random_ready_callback(&random_ready);
+	int key_size = sizeof(ptr_key);
+	int ret;
+
+	/* Use hw RNG if available. */
+	if (get_random_bytes_arch(&ptr_key, key_size) == key_size) {
+		static_branch_disable(&not_filled_random_ptr_key);
+		return 0;
+	}
 
+	ret = add_random_ready_callback(&random_ready);
 	if (!ret) {
 		return 0;
 	} else if (ret == -EALREADY) {
-- 
2.17.1

