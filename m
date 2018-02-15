Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518711417-2-7745497412814923059
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518711416; b=gUQzA3zMa8QdnwWCDPUlR7FzSSIjDHnjng7Uh0QJjaNZR0w
    YvLaFV8MAvudJ8/R1rIWrdrZ296QCjQFiZy4is1T7Wk/V+lWnqL09oyOBvgWjnoU
    glBk0GUraQWda8e+IOZqmPhDWBPkZRKUqe0gA7LX5YxTLnlRTR4U9XLOLSE5EMxN
    Vec99YWfQOkMOSY7TVHJ3fofwnLqAcTFacySJ/da0Cu4Uw5DDPJuHwglzJ6uD6Wx
    lppGvo4V+w47gvgOk71peRdDHRmi+34w29bK8mwfmQaD1T2lygWHFb4kIKP2yJUt
    Bp8DjD9dfXtf5xyFZjbxIDuLdxABLs40+rPR9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518711416; bh=FNtzZvI76tIPoZ3YxOKuOQLl0w
    o2r2S0063ZOJjeB/E=; b=iowMWlbMrfkfbGblK2jvcXUxhwKLTKoz/CRbhK+Z+j
    4sjdnlWLnMNj1cuk8gO1llGX001Z1we3/h5h2sq6hWdfEVdgh8irRc7Fcj9QpZm0
    ooF3iuhD6jsLFh9jH6UKP8D2sTDs1FTKh03fMnX0DclGBhy7sDR7aCUZjB7bXsti
    GrHItitaTZgXFbyYzaQebBOxrND/3atzcpkvgUwxyQfpwLfYRwICV1uKpx0yWQrS
    KiDthLLTS+aSzkq5QBbCkCZ1FO6OqjbGyz0Ab/FgyQNtWYNxMg5IhVA0AxHd7Hy/
    jd02/mSVm+kURJbEsbUMOiCHGyyW0eTk+ALK17ixHoGw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165454AbeBOPoV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:44:21 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34342 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165417AbeBOPoU (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:44:20 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 4.15 088/202] mtd: cfi: convert inline functions to macros
Date: Thu, 15 Feb 2018 16:16:28 +0100
Message-Id: <20180215151718.049177847@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 9e343e87d2c4c707ef8fae2844864d4dde3a2d13 upstream.

The map_word_() functions, dating back to linux-2.6.8, try to perform
bitwise operations on a 'map_word' structure. This may have worked
with compilers that were current then (gcc-3.4 or earlier), but end
up being rather inefficient on any version I could try now (gcc-4.4 or
higher). Specifically we hit a problem analyzed in gcc PR81715 where we
fail to reuse the stack space for local variables.

This can be seen immediately in the stack consumption for
cfi_staa_erase_varsize() and other functions that (with CONFIG_KASAN)
can be up to 2200 bytes. Changing the inline functions into macros brings
this down to 1280 bytes.  Without KASAN, the same problem exists, but
the stack consumption is lower to start with, my patch shrinks it from
920 to 496 bytes on with arm-linux-gnueabi-gcc-5.4, and saves around
1KB in .text size for cfi_cmdset_0020.c, as it avoids copying map_word
structures for each call to one of these helpers.

With the latest gcc-8 snapshot, the problem is fixed in upstream gcc,
but nobody uses that yet, so we should still work around it in mainline
kernels and probably backport the workaround to stable kernels as well.
We had a couple of other functions that suffered from the same gcc bug,
and all of those had a simpler workaround involving dummy variables
in the inline function. Unfortunately that did not work here, the
macro hack was the best I could come up with.

It would also be helpful to have someone to a little performance testing
on the patch, to see how much it helps in terms of CPU utilitzation.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/mtd/map.h |  130 ++++++++++++++++++++++--------------------------
 1 file changed, 61 insertions(+), 69 deletions(-)

--- a/include/linux/mtd/map.h
+++ b/include/linux/mtd/map.h
@@ -270,75 +270,67 @@ void map_destroy(struct mtd_info *mtd);
 #define INVALIDATE_CACHED_RANGE(map, from, size) \
 	do { if (map->inval_cache) map->inval_cache(map, from, size); } while (0)
 
-
-static inline int map_word_equal(struct map_info *map, map_word val1, map_word val2)
-{
-	int i;
-
-	for (i = 0; i < map_words(map); i++) {
-		if (val1.x[i] != val2.x[i])
-			return 0;
-	}
-
-	return 1;
-}
-
-static inline map_word map_word_and(struct map_info *map, map_word val1, map_word val2)
-{
-	map_word r;
-	int i;
-
-	for (i = 0; i < map_words(map); i++)
-		r.x[i] = val1.x[i] & val2.x[i];
-
-	return r;
-}
-
-static inline map_word map_word_clr(struct map_info *map, map_word val1, map_word val2)
-{
-	map_word r;
-	int i;
-
-	for (i = 0; i < map_words(map); i++)
-		r.x[i] = val1.x[i] & ~val2.x[i];
-
-	return r;
-}
-
-static inline map_word map_word_or(struct map_info *map, map_word val1, map_word val2)
-{
-	map_word r;
-	int i;
-
-	for (i = 0; i < map_words(map); i++)
-		r.x[i] = val1.x[i] | val2.x[i];
-
-	return r;
-}
-
-static inline int map_word_andequal(struct map_info *map, map_word val1, map_word val2, map_word val3)
-{
-	int i;
-
-	for (i = 0; i < map_words(map); i++) {
-		if ((val1.x[i] & val2.x[i]) != val3.x[i])
-			return 0;
-	}
-
-	return 1;
-}
-
-static inline int map_word_bitsset(struct map_info *map, map_word val1, map_word val2)
-{
-	int i;
-
-	for (i = 0; i < map_words(map); i++) {
-		if (val1.x[i] & val2.x[i])
-			return 1;
-	}
-
-	return 0;
-}
+#define map_word_equal(map, val1, val2)					\
+({									\
+	int i, ret = 1;							\
+	for (i = 0; i < map_words(map); i++)				\
+		if ((val1).x[i] != (val2).x[i]) {			\
+			ret = 0;					\
+			break;						\
+		}							\
+	ret;								\
+})
+
+#define map_word_and(map, val1, val2)					\
+({									\
+	map_word r;							\
+	int i;								\
+	for (i = 0; i < map_words(map); i++)				\
+		r.x[i] = (val1).x[i] & (val2).x[i];			\
+	r;								\
+})
+
+#define map_word_clr(map, val1, val2)					\
+({									\
+	map_word r;							\
+	int i;								\
+	for (i = 0; i < map_words(map); i++)				\
+		r.x[i] = (val1).x[i] & ~(val2).x[i];			\
+	r;								\
+})
+
+#define map_word_or(map, val1, val2)					\
+({									\
+	map_word r;							\
+	int i;								\
+	for (i = 0; i < map_words(map); i++)				\
+		r.x[i] = (val1).x[i] | (val2).x[i];			\
+	r;								\
+})
+
+#define map_word_andequal(map, val1, val2, val3)			\
+({									\
+	int i, ret = 1;							\
+	for (i = 0; i < map_words(map); i++) {				\
+		if (((val1).x[i] & (val2).x[i]) != (val2).x[i]) {	\
+			ret = 0;					\
+			break;						\
+		}							\
+	}								\
+	ret;								\
+})
+
+#define map_word_bitsset(map, val1, val2)				\
+({									\
+	int i, ret = 0;							\
+	for (i = 0; i < map_words(map); i++) {				\
+		if ((val1).x[i] & (val2).x[i]) {			\
+			ret = 1;					\
+			break;						\
+		}							\
+	}								\
+	ret;								\
+})
 
 static inline map_word map_word_load(struct map_info *map, const void *ptr)
 {
