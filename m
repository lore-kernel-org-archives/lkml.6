Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8E8E1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDCE208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="j8p1D7+n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U2lbMQLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDCE208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934856AbeFLAjl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:39:41 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59759 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933759AbeFLAjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:39:37 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4660B21D9E;
        Mon, 11 Jun 2018 20:39:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 11 Jun 2018 20:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=cEOqTeUC6pHMExbxZ
        8MC8aYvv82+3GK3GTJrC17jR3Y=; b=j8p1D7+n2csM9iNs49qJzMS4RxkRr8Sh5
        LXDKn/vYf3LyJrcL7VFniEhDb+xvOFhDuqU3HVQMkgo2RgdH6D9CXKRnfdnzN/iE
        MBLBjlOXD3uxk2+JRMnu53WaFQ8dHk0WJe4+xFt7+8Q4vBKE/QJcEx+AEU2GcK0+
        KsO37OhT0iLU99GKgxAfuCxxZqsHHQuDxtYZva/mVWWNJ3NzO0tFgulCz2sAinsK
        Sj5aKdOgSRRb2TtVqAvLskmgGaLwDI5qTvnbKfXGSjqcvC/gjzeqMLdPnHRwiefB
        QYxMGHdc6l0GXfCTWiGb5k6W4wFR6pkUk3eB2SV+2CfiXnqFTHIuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=cEOqTeUC6pHMExbxZ8MC8aYvv82+3GK3GTJrC17jR3Y=; b=U2lbMQLI
        h77MBg/m3bOBwok3NiorESO9vaoD86PYOs8koT5eAi129xbnzvPQG9lQCutNNcTo
        sa3z+AayjZwR7haZAlklxZFoYDeDqQBEzyZV62lR9tLUHMvPMQN2iERDsMzP3ZmK
        PESVa8lDmpF0l3pluylrqTT25zgxxje4xb5TOR2XV3SXGu4CQS8r+EnYlIBqIM0g
        4kLLYZBe0txZxfvISq1AsvzqyJVmTEXPrGPtOzUDvalGQ7gX+TbrewqqP5ILtqHb
        Ja2h0ElJKtKTgJjyX8X96JxvxT1GLIduaG0yYJtEBMEirp59HFFW+EfRNmn9ygxW
        edpUE2ggVCdPKw==
X-ME-Proxy: <xmx:SRYfWznqNTnNL7fbybmtc5I2O1WgvYstT0ZIvPcbiJEjvbsSV9Py5w>
X-ME-Proxy: <xmx:SRYfW9zxgiApMrVJdWVgnkK7z8aXozP4tJNWDKT7vIvHcthUFtx69w>
X-ME-Proxy: <xmx:SRYfWwFOncf8JBuegvuvyBMjTV2o-emPudCO7YtkJdlbd7y-u9GWvA>
X-ME-Proxy: <xmx:SRYfW6ElblpxPfkkMFf7dmzY4Q5v-ARv8di4A-fwbxQiEfHDFji7Yg>
X-ME-Proxy: <xmx:SRYfWzDb5fKmieW-pS2Uz72kYf5orLHQhaAnRlWSUFPs-JAdZQF3Zw>
X-ME-Proxy: <xmx:SRYfW1c1cbw2_22rRbBb_bx-5ffs2ua1jmW5brWh8YkhQW-yuetvqg>
X-ME-Sender: <xms:SRYfWx7tJCRFGZzsk4zcfHk6yRaTZJDM8rl_7A-55DN3EOF8ptXTlA>
Received: from localhost (124-169-136-87.dyn.iinet.net.au [124.169.136.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id 73284E4A32;
        Mon, 11 Jun 2018 20:39:36 -0400 (EDT)
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
Subject: [PATCH v7 3/4] vsprintf: Use hw RNG for ptr_key
Date:   Tue, 12 Jun 2018 10:39:13 +1000
Message-Id: <1528763954-27731-4-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528763954-27731-1-git-send-email-me@tobin.cc>
References: <1528763954-27731-1-git-send-email-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we must wait for enough entropy to become available before
hashed pointers can be printed.  We can remove this wait by using the
hw RNG if available.

Use hw RNG to get keying material.

Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/vsprintf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index a48aaa79d352..c445f9f28760 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1675,8 +1675,16 @@ static struct random_ready_callback random_ready = {
 
 static int __init initialize_ptr_random(void)
 {
-	int ret = add_random_ready_callback(&random_ready);
+	int key_size = sizeof(ptr_key);
+	int ret;
+
+	/* Use hw RNG if available */
+	if (get_random_bytes_arch(&ptr_key, key_size) == key_size) {
+		static_branch_disable(&not_filled_random_ptr_key);
+		return 0;
+	}
 
+	ret = add_random_ready_callback(&random_ready);
 	if (!ret) {
 		return 0;
 	} else if (ret == -EALREADY) {
-- 
2.7.4

