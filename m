Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06370C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B440620846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="XU/lZ66K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cWZIAYY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B440620846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754251AbeFTEVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:21:48 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60627 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750842AbeFTEVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:21:05 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A232C21ADA;
        Wed, 20 Jun 2018 00:21:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 20 Jun 2018 00:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=loZHnWsjHYT/D6T7p
        gB8aGTq3jdPdKKvTW+EUwiREOo=; b=XU/lZ66Kw6Obp1av4JLr8SII58Wsudoxh
        eAVsrKcRgsiAjYmFGVcIE9wEhmhTPR43RSJ91qJfJzTc6m3znnm8rWa1sRTgsRn6
        v6biGzjwse0dImT4RY+uINFHLhSETldS2ku4stI5OPnG5XCRzkpgX3E6S61JbPu3
        fs7FKwjH1VbfGR1DmzW+ECw8/8ERPUXTNwLlEbGSXoPkRcv0t/nhagBHJDtPbV3c
        VtyIYeCQivln36JQGqKNRbOwtJg2usbGulMgn58N8bRWlEN+YGWADECFcagYS6q5
        1mGL2MivqJ2OLyScDSoIvbK5S2COmvW/JsmGu/AzgtmVErsM9GAog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=loZHnWsjHYT/D6T7pgB8aGTq3jdPdKKvTW+EUwiREOo=; b=cWZIAYY3
        iUJJOVAtWl1iYjWwYU5n0KpS1UNpkyLsW8uBCLFicyebERZF5ampFr1M80k6GFHy
        bf8HpDASOpmnwNTRaesAKwesxiFL0zVUet56MISJXt4sNIgLSYnRvoIIk0mljR5k
        rzqNDNyCeisxVPFROqxhxkCECGOFKsJIsEI9DNOwMfT2NiWNhatZ7TwLX5vLIuny
        cPQ7kKHR9IXmkYR3bkiKTvMNknHjGtz4UkfXQrhiqCBGh1cOVl8TA5ZNxFL3oTfM
        StG8aQx0zRffCae2G5kej4Y2NKghUKhxiSIzxiM/KFE+q0MhYgA4bVSCsanewKI7
        18dUBxbLMKFvEg==
X-ME-Proxy: <xmx:MNYpWzWaKpwOgTWSds68e-Dt9Rvkmmo9KI_jTmlLQL--76PPQYKA0A>
    <xmx:MNYpW2uv_idk7uKCZ1v6ulppGgWg5H4AYufnFftripuLFUsph4PEUQ>
    <xmx:MNYpW1x5XOzL3QTen6Cejdjjuxn02fHRU-8E0MtZCoHEm20HDJSckA>
    <xmx:MNYpW5REy6NjHTXoEKh7WFraWxohuJFbPMf67s60-weALiZis2ddNA>
    <xmx:MNYpW_9fScE_i3yf1OQqgOtr2NPhChfdaT6NBJxhYFdMXU7DMAE_RA>
    <xmx:MNYpWwoPWjzPn6lGu7pNyUDFfoHRl_BrGWc8V_b4ec8HbE0GhwT7QQ>
X-ME-Sender: <xms:MNYpWzd6ML4OKvleCLNdwsehaOOUCnyBWbxaytZW_7RG2zfbkDgkxw>
Received: from localhost (ppp118-211-207-6.bras1.syd2.internode.on.net [118.211.207.6])
        by mail.messagingengine.com (Postfix) with ESMTPA id D4623E4076;
        Wed, 20 Jun 2018 00:21:03 -0400 (EDT)
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
Subject: [PATCH v8 2/4] random: Return nbytes filled from hw RNG
Date:   Wed, 20 Jun 2018 14:20:44 +1000
Message-Id: <20180620042046.30806-3-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620042046.30806-1-me@tobin.cc>
References: <20180620042046.30806-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the function get_random_bytes_arch() has return value 'void'.
If the hw RNG fails we currently fall back to using get_random_bytes().
This defeats the purpose of requesting random material from the hw RNG
in the first place.

There are currently no intree users of get_random_bytes_arch().

Only get random bytes from the hw RNG, make function return the number
of bytes retrieved from the hw RNG.

Acked-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 drivers/char/random.c  | 16 +++++++++-------
 include/linux/random.h |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index ed679099afba..e98fa03cdb91 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1724,26 +1724,28 @@ EXPORT_SYMBOL(del_random_ready_callback);
  * key known by the NSA).  So it's useful if we need the speed, but
  * only if we're willing to trust the hardware manufacturer not to
  * have put in a back door.
+ *
+ * Return number of bytes filled in.
  */
-void get_random_bytes_arch(void *buf, int nbytes)
+int __must_check get_random_bytes_arch(void *buf, int nbytes)
 {
+	int left = nbytes;
 	char *p = buf;
 
-	trace_get_random_bytes_arch(nbytes, _RET_IP_);
-	while (nbytes) {
+	trace_get_random_bytes_arch(left, _RET_IP_);
+	while (left) {
 		unsigned long v;
-		int chunk = min(nbytes, (int)sizeof(unsigned long));
+		int chunk = min_t(int, left, sizeof(unsigned long));
 
 		if (!arch_get_random_long(&v))
 			break;
 
 		memcpy(p, &v, chunk);
 		p += chunk;
-		nbytes -= chunk;
+		left -= chunk;
 	}
 
-	if (nbytes)
-		get_random_bytes(p, nbytes);
+	return nbytes - left;
 }
 EXPORT_SYMBOL(get_random_bytes_arch);
 
diff --git a/include/linux/random.h b/include/linux/random.h
index 2ddf13b4281e..f1c9bc5cd231 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -38,7 +38,7 @@ extern void get_random_bytes(void *buf, int nbytes);
 extern int wait_for_random_bytes(void);
 extern int add_random_ready_callback(struct random_ready_callback *rdy);
 extern void del_random_ready_callback(struct random_ready_callback *rdy);
-extern void get_random_bytes_arch(void *buf, int nbytes);
+extern int __must_check get_random_bytes_arch(void *buf, int nbytes);
 
 #ifndef MODULE
 extern const struct file_operations random_fops, urandom_fops;
-- 
2.17.1

