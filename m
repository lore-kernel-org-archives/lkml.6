Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9B657C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C698208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="grkwpCPA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PoHOHuJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C698208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934872AbeFLAjq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:39:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49725 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934811AbeFLAje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:39:34 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B61321CA8;
        Mon, 11 Jun 2018 20:39:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 11 Jun 2018 20:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=wVO0ELc2nMmioIWS8
        aWaBXLUwnC2bh10GTjADlU81XU=; b=grkwpCPAfJXn68D6okPTD05ej1rfcAhW/
        7mg1KGLjndh8IDrbwUSFngJ9zYUPfDdHG2j71CpnRBquVxa82sz4I3aLx1VpYkTk
        SComzDaWsu4zyPxjBslWHQ3WnxzPjD9qIHFxflO9xPFCY0IpzytFuL7l1MBBsyTL
        pxWG2Ie+rgOlqR6nYL85dISfAsBHLgZrea/llVW0XdRvulCUFIG0aZuiBOwwVKOv
        SPLMI7WBcAGyBQXwZYzrVlO1eAzhFp9wIV9ptr357EgnEKcVk2mCSnd9BEy+SbsV
        OcH8GdZ7uVfwwM83F3x2NYTU2Re9TTIYWZWRRdujt01OK7znN/2vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=wVO0ELc2nMmioIWS8aWaBXLUwnC2bh10GTjADlU81XU=; b=PoHOHuJU
        uToei8C7q9HnYRWarl/dUJFjfNfDoNw++70ubG4Fq1z5KQllXubILIaFN8OApow5
        6GddpDlNb5nCdQ/a7xwsSk/jDsv9NrFbrSN1vjPODe9UHSuRXZ/VDcV91s8ZI6Un
        EP7IhxE9yEC1tumg8ZSJtfZdFLjfsG6z05RmezTgF2BLmkZJ+3+s8SpVsiUFUSVi
        7Ul6OmP3ffsWhMK9H65nE3OZxdEz+qWBOFr/NzLCFyMWezh8jzzf6/QawD7SmebQ
        64pVKcGQADEMbNFTjKoqWFPEA9O3Ggu4rKaAtULzF6fOqF1LbodNC66ECmGdGMMw
        FHcP0liwPHVl3Q==
X-ME-Proxy: <xmx:RRYfW5DqXg9bsOixKKEcf_rhOuzIpyXlCCFqBKU2xL7BOazhOSdLWQ>
X-ME-Proxy: <xmx:RRYfW-0PrdB0gvrwgnt8S7GIDT2AHmrK9svBr5fCNW3GZCXK3D8N6w>
X-ME-Proxy: <xmx:RRYfW5RyKmW4Y1XACiY8hc1qKZrMioZnc_PD-CnyJRiuY5E3vBJY-A>
X-ME-Proxy: <xmx:RRYfW8yvE0SGk9XVK5YL38scaKzG-AEOgC9WA4rjDbfKt9xQkt5QQQ>
X-ME-Proxy: <xmx:RRYfW44gNUdEFrYIkbrKEu0t-FU9UvjDKFjqZB09Hhth4CIb6KfLGQ>
X-ME-Proxy: <xmx:RRYfW-CT8BVeJZOm42CKU_hMZpo7Fd6tb2gdBheTCUnmOgCPZtT2Lg>
X-ME-Sender: <xms:RRYfW4Lbx69W7cro8_stmR32MdfGhUQ54fQjyJaZ19vSfw0z2KcGaA>
Received: from localhost (124-169-136-87.dyn.iinet.net.au [124.169.136.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id B3891E425A;
        Mon, 11 Jun 2018 20:39:32 -0400 (EDT)
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
Subject: [PATCH v7 2/4] random: Return nbytes filled from hw RNG
Date:   Tue, 12 Jun 2018 10:39:12 +1000
Message-Id: <1528763954-27731-3-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528763954-27731-1-git-send-email-me@tobin.cc>
References: <1528763954-27731-1-git-send-email-me@tobin.cc>
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

Signed-off-by: Tobin C. Harding <me@tobin.cc>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/char/random.c  | 16 +++++++++-------
 include/linux/random.h |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index ed679099afba..bd3d3fbea632 100644
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
+		int chunk = min_t(int, left, (int)sizeof(unsigned long));
 
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
2.7.4

