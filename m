Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC2AC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04BAE22532
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="XN9VxaSq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CMLtXRSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BAE22532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934014AbeFUXP6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:15:58 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43037 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933729AbeFUXPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:15:55 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 149F821B32;
        Thu, 21 Jun 2018 19:15:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 21 Jun 2018 19:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=loZHnWsjHYT/D6T7p
        gB8aGTq3jdPdKKvTW+EUwiREOo=; b=XN9VxaSqIkNADxzOWBjDIHX5NjGW4AGAt
        07iziCPm2U7W3LoCEi9n9QpNUJh2I27nDW7Tr3maWx8Ucp3LQceTWeZgfsJC6hyW
        TTPD7Hy7TjOcnHLdHqiEFsN5uA1opRzmT5fxCdq2dYuFd2ttcuQX5YTzphVyZdtQ
        JqsmNc/RvTLsoT4NLclmQ51rCsVnyPaA5ZfRkSjNwcoc+VhyEL5eexRyWJQ4zrs4
        t4qnyCUsDAiL1I5XSu3aoU3aerTd3WoPOGaAV5DTNutoo3tvr5EVryR9CDd6vBZs
        1BtGOEqfV3QE94RmsLF3nQYEXfevis120tnBSgsR+tPd2ygcRlLWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=loZHnWsjHYT/D6T7pgB8aGTq3jdPdKKvTW+EUwiREOo=; b=CMLtXRSV
        lK2oCQOKVWX+1GJKXeXvuh9LgwdKBvaRVW8s6ndf4acOlotuYFWpU9wl1/Z9csr2
        OtZCbpN4UwrEMdX8sVYakWPvx0leXUW4GpTz9y8B1YIupwgKXIgAxEXgwQndUbTf
        ahJREZs46z1rOQvghL5Io2251UbVpRfZdr7AsiVMisbbg5izS1wuyzdNkd80NFKq
        wTgVXG8LTMd6/9bRvF3efv7TDUKSmssgPOj55pLJ5An44ILeYY+W101U1gIHUS3B
        5PyKTn8Ejbwrre77fcf1LWMDa4tACIrHN+fuBfvM2DCmaqbwwCBwxmF4PH1C6sjH
        hgL2Ha36pdRXcg==
X-ME-Proxy: <xmx:qTEsW6P21gInDe9uivl3HOhRgMyASIZ8dB_h4o07R2OB42PLwEbzeA>
    <xmx:qTEsW7vBqzdLzGgsrcYriPtg_yCHYVCfxTXMAv8JplFbUSaI3ZY8ZA>
    <xmx:qjEsW-IZ8FmBrh4hGE2HcD_QJaKnCaQldfGYjdgubIfa8xSnsGovmA>
    <xmx:qjEsWyPC0tfpAZPbKfSrP4Eye_xH-KJG_tw7SUsWcPdQzZS9xshyTA>
    <xmx:qjEsW6AQ2-oVOUUraeL_UqoIesBq5xhtews8AtEgQIB0GxHP-Hw0LQ>
    <xmx:qjEsW-eptBMcEe3ORiGlMQAu2rRM8KesibgZuvNgGyw7n6ET9zN78w>
X-ME-Sender: <xms:qTEsW57ZXRZVEKyhDjTHf9tVPbo_NLCblVEFp6gB_z6WSAI5ceizBA>
Received: from localhost (124-169-15-204.dyn.iinet.net.au [124.169.15.204])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3DF6210293;
        Thu, 21 Jun 2018 19:15:52 -0400 (EDT)
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
Subject: [PATCH v9 2/4] random: Return nbytes filled from hw RNG
Date:   Fri, 22 Jun 2018 09:15:32 +1000
Message-Id: <20180621231534.32278-3-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621231534.32278-1-me@tobin.cc>
References: <20180621231534.32278-1-me@tobin.cc>
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

