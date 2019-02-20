Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2117FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D684E20685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCpAlVzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfBTIhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:37:24 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46276 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfBTIhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:37:21 -0500
Received: by mail-lf1-f68.google.com with SMTP id g12so7310926lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 00:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pgm13xQDVdh6f1ItI9BlK3SwDsK7b1WuKu3DzjgNyiA=;
        b=RCpAlVzL1Rj9vwOlORDSlHA6f6MWZOM/f2sXpdY55W0/Qx9m0v7yurQegyLcK2QPmO
         JeWR/MPEyS+XYfN9R9f0i8QSDMU1/gggTx7QbWaeoNz6e7AIBG0KCU3PYBvc4u2ryFi6
         VOYfR2IfagsSxEm3hmdkdNxYCrdl/b8RW/kg2fQxtsPrXfgNmljvIssjowK9CXf3fXB7
         21wZHwLO6CSyos156WQDJsvEDtuWwyOsGL61SLbMjqH7XC5/Y2WzfypwYkSNcyRoQBV7
         GYWMqi6WHC3dDLX9CoPM5xNhydCJ2wBnfZBDOhCVMuNqraf2s+QpeMnsDdbcNIGQ7tAv
         gyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pgm13xQDVdh6f1ItI9BlK3SwDsK7b1WuKu3DzjgNyiA=;
        b=I8zynzoUThOAI5zUtlJv1V2J6IpFWu1UVP4Bi2/4Do7XiaxxDNn+XijZK5G0mTjTEl
         bvfaeCz12pS4DZ3XWfCw2S8BpOgbAkcj1IUjqOg3Flf/QrioSGmvV6x0WCY+NOGhSNC5
         wjpO8WLJS2Gsa8O/ZEhpSyhD7r6Q2/Fjf0xlUx5wASvifd2be85JCxOOKNinziaiJta8
         MiGaWGdXtE4cyBOm8mOUSV/6M0iHkHhvGYAPPSzSSRK+kWo8SIzPB2WcSzY7WJu8m4j7
         vF0AQqfORPm89duNVdXfCFXfPIMxbalIYiadDjm91PoP8ijGhvPlSNPuLHXlap9oNyac
         DmLg==
X-Gm-Message-State: AHQUAuZQGiThRghk+G5RRszAn0YZJz3ueTAFY4V4/hX/RVC11emXpAOg
        oCsfDN7Ol4GU6REOGN3bwro=
X-Google-Smtp-Source: AHgI3IbNBr8qcBQAMVfnIGyu26PQe5cmPeXePjS1CU6ilffW5kRkLCOd5A6Ld+RXtOg6Fc2KdBBJ2w==
X-Received: by 2002:a19:c942:: with SMTP id z63mr19365176lff.162.1550651837745;
        Wed, 20 Feb 2019 00:37:17 -0800 (PST)
Received: from localhost ([188.162.52.148])
        by smtp.gmail.com with ESMTPSA id r11sm5032418ljb.29.2019.02.20.00.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 00:37:17 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 3/6] bitmap_parselist: rework input string parser
Date:   Wed, 20 Feb 2019 11:37:02 +0300
Message-Id: <20190220083705.14050-4-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190220083705.14050-1-ynorov@marvell.com>
References: <20190220083705.14050-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The requirement for this rework is to keep the __bitmap_parselist()
copy-less and single-pass but make it more readable and maintainable by
splitting into logical parts and removing explicit nested cycles and
opaque local variables.

__bitmap_parselist() can parse userspace inputs and therefore we cannot
use simple_strtoul() to parse numbers.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/bitmap.c | 246 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 148 insertions(+), 98 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 307a1b20bead..f1c42ee8b8f2 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -513,6 +513,139 @@ static int bitmap_check_region(const struct region *r)
 	return 0;
 }
 
+static long get_char(char *c, const char *str, int is_user)
+{
+	if (unlikely(is_user))
+		return __get_user(*c, (const char __force __user *)str);
+
+	*c = *str;
+	return 0;
+}
+
+static const char *bitmap_getnum(unsigned int *num, const char *str,
+			    const char *const end, int is_user)
+{
+	unsigned int n = 0;
+	const char *_str;
+	long ret;
+	char c;
+
+	for (_str = str, *num = 0; _str <= end; _str++) {
+		ret = get_char(&c, _str, is_user);
+		if (ret)
+			return ERR_PTR(ret);
+
+		if (!isdigit(c)) {
+			if (_str == str)
+				return ERR_PTR(-EINVAL);
+
+			return _str;
+		}
+
+		*num = *num * 10 + (c - '0');
+		if (*num < n)
+			return ERR_PTR(-EOVERFLOW);
+
+		n = *num;
+	}
+
+	return _str;
+}
+
+static const char *bitmap_find_region(const char *str,
+			const char *const end, int is_user)
+{
+	long ret;
+	char c;
+
+	for (; str <= end; str++) {
+		ret = get_char(&c, str, is_user);
+		if (ret)
+			return ERR_PTR(ret);
+
+		/* Unexpected end of line. */
+		if (c == 0 || c == '\n')
+			return NULL;
+
+		/*
+		 * The format allows commas and whitespases
+		 * at the beginning of the region, so skip it.
+		 */
+		if (!isspace(c) && c != ',')
+			break;
+	}
+
+	return str <= end ? str : NULL;
+}
+
+static const char *bitmap_parse_region(struct region *r, const char *str,
+				 const char *const end, int is_user)
+{
+	long ret;
+	char c;
+
+	str = bitmap_getnum(&r->start, str, end, is_user);
+	if (IS_ERR(str))
+		return str;
+
+	ret = get_char(&c, str, is_user);
+	if (ret)
+		return (char *)ret;
+
+	if (c == 0 || c == '\n') {
+		str = end + 1;
+		goto no_end;
+	}
+
+	if (isspace(c) || c == ',')
+		goto no_end;
+
+	if (c != '-')
+		return ERR_PTR(-EINVAL);
+
+	str = bitmap_getnum(&r->end, str + 1, end, is_user);
+	if (IS_ERR(str))
+		return str;
+
+	ret = get_char(&c, str, is_user);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (c == 0 || c == '\n') {
+		str = end + 1;
+		goto no_pattern;
+	}
+
+	if (isspace(c) || c == ',')
+		goto no_pattern;
+
+	if (c != ':')
+		return ERR_PTR(-EINVAL);
+
+	str = bitmap_getnum(&r->off, str + 1, end, is_user);
+	if (IS_ERR(str))
+		return str;
+
+	ret = get_char(&c, str, is_user);
+	if (ret)
+		return (char *)ret;
+
+	if (c != '/')
+		return ERR_PTR(-EINVAL);
+
+	str = bitmap_getnum(&r->grlen, str + 1, end, is_user);
+
+	return str;
+
+no_end:
+	r->end = r->start;
+no_pattern:
+	r->off = r->end + 1;
+	r->grlen = r->end + 1;
+
+	return str;
+}
+
 /**
  * __bitmap_parselist - convert list format ASCII string to bitmap
  * @buf: read nul-terminated user string from this buffer
@@ -534,113 +667,29 @@ static int bitmap_check_region(const struct region *r)
  *
  * Returns: 0 on success, -errno on invalid input strings. Error values:
  *
- *   - ``-EINVAL``: second number in range smaller than first
+ *   - ``-EINVAL``: wrong region format
  *   - ``-EINVAL``: invalid character in string
  *   - ``-ERANGE``: bit number specified too large for mask
+ *   - ``-EOVERFLOW``: integer overflow in the input parameters
  */
-static int __bitmap_parselist(const char *buf, unsigned int buflen,
+static int __bitmap_parselist(const char *buf, const char *const end,
 		int is_user, unsigned long *maskp,
 		int nmaskbits)
 {
-	unsigned int a, b, old_a, old_b;
-	unsigned int group_size, used_size;
-	int c, old_c, totaldigits, ndigits;
-	const char __user __force *ubuf = (const char __user __force *)buf;
-	int at_start, in_range, in_partial_range, ret;
 	struct region r;
+	long ret;
 
-	totaldigits = c = 0;
-	old_a = old_b = 0;
-	group_size = used_size = 0;
 	bitmap_zero(maskp, nmaskbits);
-	do {
-		at_start = 1;
-		in_range = 0;
-		in_partial_range = 0;
-		a = b = 0;
-		ndigits = totaldigits;
 
-		/* Get the next cpu# or a range of cpu#'s */
-		while (buflen) {
-			old_c = c;
-			if (is_user) {
-				if (__get_user(c, ubuf++))
-					return -EFAULT;
-			} else
-				c = *buf++;
-			buflen--;
-			if (isspace(c))
-				continue;
 
-			/* A '\0' or a ',' signal the end of a cpu# or range */
-			if (c == '\0' || c == ',')
-				break;
-			/*
-			* whitespaces between digits are not allowed,
-			* but it's ok if whitespaces are on head or tail.
-			* when old_c is whilespace,
-			* if totaldigits == ndigits, whitespace is on head.
-			* if whitespace is on tail, it should not run here.
-			* as c was ',' or '\0',
-			* the last code line has broken the current loop.
-			*/
-			if ((totaldigits != ndigits) && isspace(old_c))
-				return -EINVAL;
-
-			if (c == '/') {
-				used_size = a;
-				at_start = 1;
-				in_range = 0;
-				a = b = 0;
-				continue;
-			}
-
-			if (c == ':') {
-				old_a = a;
-				old_b = b;
-				at_start = 1;
-				in_range = 0;
-				in_partial_range = 1;
-				a = b = 0;
-				continue;
-			}
-
-			if (c == '-') {
-				if (at_start || in_range)
-					return -EINVAL;
-				b = 0;
-				in_range = 1;
-				at_start = 1;
-				continue;
-			}
-
-			if (!isdigit(c))
-				return -EINVAL;
-
-			b = b * 10 + (c - '0');
-			if (!in_range)
-				a = b;
-			at_start = 0;
-			totaldigits++;
-		}
-		if (ndigits == totaldigits)
-			continue;
-		if (in_partial_range) {
-			group_size = a;
-			a = old_a;
-			b = old_b;
-			old_a = old_b = 0;
-		} else {
-			used_size = group_size = b - a + 1;
-		}
-		/* if no digit is after '-', it's wrong*/
-		if (at_start && in_range)
-			return -EINVAL;
+	while (buf && buf <= end) {
+		buf = bitmap_find_region(buf, end, is_user);
+		if (buf == NULL)
+			return 0;
 
-		r.start = a;
-		r.off = used_size;
-		r.grlen = group_size;
-		r.end = b;
+		buf = bitmap_parse_region(&r, buf, end, is_user);
+		if (IS_ERR(buf))
+			return PTR_ERR(buf);
 
 		ret = bitmap_check_region(&r);
 		if (ret)
@@ -649,14 +698,14 @@ static int __bitmap_parselist(const char *buf, unsigned int buflen,
 		ret = bitmap_set_region(&r, maskp, nmaskbits);
 		if (ret)
 			return ret;
+	}
 
-	} while (buflen && c == ',');
 	return 0;
 }
 
 int bitmap_parselist(const char *bp, unsigned long *maskp, int nmaskbits)
 {
-	return __bitmap_parselist(bp, UINT_MAX, 0, maskp, nmaskbits);
+	return __bitmap_parselist(bp, (char *)SIZE_MAX, 0, maskp, nmaskbits);
 }
 EXPORT_SYMBOL(bitmap_parselist);
 
@@ -683,7 +732,8 @@ int bitmap_parselist_user(const char __user *ubuf,
 	if (!access_ok(ubuf, ulen))
 		return -EFAULT;
 	return __bitmap_parselist((const char __force *)ubuf,
-					ulen, 1, maskp, nmaskbits);
+				  (const char __force *)ubuf + ulen - 1,
+				  1, maskp, nmaskbits);
 }
 EXPORT_SYMBOL(bitmap_parselist_user);
 
-- 
2.17.1

