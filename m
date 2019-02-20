Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6C0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C49120685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV6mJVik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfBTIhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:37:19 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46820 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfBTIhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:37:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id v16so20007736ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 00:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GY0lBb62Z1iVATnV+m0gDyVgNs1C49ML0/XutpXLjs8=;
        b=HV6mJVikUCAAk0eVGcwPQ8xQ+z+7dCmr4mpnhl6QABUWY2uiBL0llkRHowLlVshqGL
         rF4wFuCyhptX/uZrMUzqkcU79Yqi9/J2QW9DCjfZVRFqHUaMmeKWsOn2Z/YeyHA8LQy1
         +2xCjz7Rez0nGWEsofm8/Xs+fueokJ9QlFI9kjtS3cVdlNwdzB+9QjypqJv2FAR8lJFW
         L6yFXvwPrAbKUTVpUSkczDaW9QSgvU1muLJjd0mRFSX8fstz7/7iqK64OGoeqCKsTLc9
         cL0jxW6ZOA+eua57m1hM7PoIrgHxqiOM3Mhtx3YQJjGLufi19lLBbiVBbPuXC/Tu/9cV
         KjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GY0lBb62Z1iVATnV+m0gDyVgNs1C49ML0/XutpXLjs8=;
        b=DyJNctSa/S5t4CUwPjXrdgv+Fe/EAFXq5/JlTn7YVX1z5MO6Jg1j7YzCQv1exP0LLu
         vWic/6PPv5CTxqV4HKAQXZ1DO9CDUL2EXMrbxt6qD9GiMRHzeYBtvKA46yHvXrIDO57R
         pyh3qUpcFRlhCCqhwxlPwSeZF5UC76kXqcq8st/ZKqrNSWWh/DVymrSdV3beVR27LBQS
         aRTTqOAXS373gXYPZQRguCHJXdsmjRN2sDRUdn2wqdGIOHm5XM2ldp0yaH+U5gKu29U1
         4FyYuRl0ChqE+WEgidXegV8YHHZHCpiOEDBXhOcBSIjyML9kpGMiDK+baDFfyb6Eevom
         0ldA==
X-Gm-Message-State: AHQUAuZ6bJP+1fBl0LXDbWknoR5vhUTNryiyrdaj8KT0hH1pE6bEuN7h
        m9QjgKBBEeulz+TuQdk97mE=
X-Google-Smtp-Source: AHgI3IYbCdvB4lBgv5X+uq1H8XTwi3bY6PgJ7v24/3PhD1f1xDmW7Ytavm9CNYsA8fsLRBFvEfkoSw==
X-Received: by 2002:a2e:b014:: with SMTP id y20mr8911973ljk.116.1550651835426;
        Wed, 20 Feb 2019 00:37:15 -0800 (PST)
Received: from localhost ([188.162.52.148])
        by smtp.gmail.com with ESMTPSA id p7sm1106967lfh.87.2019.02.20.00.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 00:37:14 -0800 (PST)
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
Subject: [PATCH 2/6] bitmap_parselist: move non-parser logic to helpers
Date:   Wed, 20 Feb 2019 11:37:01 +0300
Message-Id: <20190220083705.14050-3-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190220083705.14050-1-ynorov@marvell.com>
References: <20190220083705.14050-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move region checking and setting functionality of __bitmap_parselist()
to helpers.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/bitmap.c | 64 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index ad1fb7e6ad0e..307a1b20bead 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -477,6 +477,42 @@ int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
 }
 EXPORT_SYMBOL(bitmap_print_to_pagebuf);
 
+/*
+ * Region 9-38:4/10 describes the following bitmap structure:
+ * 0	   9  12    18			38
+ * .........****......****......****......
+ *	    ^  ^     ^			 ^
+ *      start  off   grlen	       end
+ */
+struct region {
+	unsigned int start;
+	unsigned int off;
+	unsigned int grlen;
+	unsigned int end;
+};
+
+static int bitmap_set_region(const struct region *r,
+				unsigned long *bitmap, int nbits)
+{
+	unsigned int start;
+
+	if (r->end >= nbits)
+		return -ERANGE;
+
+	for (start = r->start; start <= r->end; start += r->grlen)
+		bitmap_set(bitmap, start, min(r->end - start + 1, r->off));
+
+	return 0;
+}
+
+static int bitmap_check_region(const struct region *r)
+{
+	if (r->start > r->end || r->grlen == 0 || r->off > r->grlen)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * __bitmap_parselist - convert list format ASCII string to bitmap
  * @buf: read nul-terminated user string from this buffer
@@ -507,10 +543,11 @@ static int __bitmap_parselist(const char *buf, unsigned int buflen,
 		int nmaskbits)
 {
 	unsigned int a, b, old_a, old_b;
-	unsigned int group_size, used_size, off;
+	unsigned int group_size, used_size;
 	int c, old_c, totaldigits, ndigits;
 	const char __user __force *ubuf = (const char __user __force *)buf;
-	int at_start, in_range, in_partial_range;
+	int at_start, in_range, in_partial_range, ret;
+	struct region r;
 
 	totaldigits = c = 0;
 	old_a = old_b = 0;
@@ -599,15 +636,20 @@ static int __bitmap_parselist(const char *buf, unsigned int buflen,
 		/* if no digit is after '-', it's wrong*/
 		if (at_start && in_range)
 			return -EINVAL;
-		if (!(a <= b) || group_size == 0 || !(used_size <= group_size))
-			return -EINVAL;
-		if (b >= nmaskbits)
-			return -ERANGE;
-		while (a <= b) {
-			off = min(b - a + 1, used_size);
-			bitmap_set(maskp, a, off);
-			a += group_size;
-		}
+
+		r.start = a;
+		r.off = used_size;
+		r.grlen = group_size;
+		r.end = b;
+
+		ret = bitmap_check_region(&r);
+		if (ret)
+			return ret;
+
+		ret = bitmap_set_region(&r, maskp, nmaskbits);
+		if (ret)
+			return ret;
+
 	} while (buflen && c == ',');
 	return 0;
 }
-- 
2.17.1

