Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CAAC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE769216C1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="JBrk0RSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE769216C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbeHOLrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 07:47:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45336 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeHOLrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 07:47:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id j143-v6so380414lfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 01:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OE03XtrezUtb6fHO0qsKlqzVjfPZ7sDUaKr9K2vRXyc=;
        b=JBrk0RSM20f5CaYKlqKD8K1JSaCuyKjkVBTPOjj68wNU1iV5vCst6LhsXjLQcPhIqV
         gz0xzuM1Ga6VUaCDxOIiOiSIYTQb0e1Xge9QAYvCn6Q+PkR5rcZukK73ASvjHd4sYnf7
         06zB/Gz1ZMjOFbgElz6xZBBvsO/blyhyGaM+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OE03XtrezUtb6fHO0qsKlqzVjfPZ7sDUaKr9K2vRXyc=;
        b=E4Wojv+0MYQ9eqA1Bmo436xiAdNGH2BJYp0DRNfXgiDH+w6/aY+dR1U4vlvN+zUiAU
         ULbAqkDgvz6Q2ilINdlKOnydeU1X1F3sSZRO0J312CvmjwQEwFgMwuM3LLjxMSUpy0O+
         AM4G2GkHK4UcWJP+FDaUvX7nJj1t1E1D5gBaIwiwStpa/rJQ5zwCEAR2te1FpbzoSF5Q
         V1zH/C/06nxMhlrnY/vSd2SR/9QJLbMbtNzgUJo5VlOgjT+Gpft1op19/EdByKLkPnWP
         fNBSwChCL0HlhorNGpKcvuxwk8FiOmeMiDN3DyqjWE0CFLJXpz6NjG4Da6AXgkh+BYrH
         oo4Q==
X-Gm-Message-State: AOUpUlE5ueZemN1iYEGaX9hf++C+fzG8BB/cDdgp+nBi8hBHEDLIKe0n
        ZhP+6Yop7rewsJLY35jqs0Nc0++LGvjSSA==
X-Google-Smtp-Source: AA+uWPxUNAZOxfFlyG7rB5kUK4cH++Uuf4tO98zmLKHbllMFDuwfVu8i0wzNoWp/4yZDiZyA2uBWhA==
X-Received: by 2002:a19:2043:: with SMTP id g64-v6mr15354068lfg.66.1534323342649;
        Wed, 15 Aug 2018 01:55:42 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a140-v6sm4361283lfb.21.2018.08.15.01.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Aug 2018 01:55:42 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-kernel@vger.kernel.org, lkp@lists.01.org
Cc:     akpm@linux-foundation.org, ynorov@caviumnetworks.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] linux/bitmap.h: (buildbot-only) check if we have any compile-time zero-size bitmaps
Date:   Wed, 15 Aug 2018 10:55:39 +0200
Message-Id: <20180815085539.27485-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the inline bitmap functions are buggy if passed a compile-time
constant nbits==0. The convention is that the caller only guarantees
BITS_TO_LONGS(nbits) words can be accessed, which for nbits==0 is of
course 0. However, all the small_const_nbits() cases proceed to
dereferencing the passed src or dst pointers unconditionally.

Of course, nobody passes a literal 0 as nbits, but it could come about
from some odd CONFIG_ combination, or because the compiler is smart
enough to reduce some expression to 0, or... In any case, this patch is
just for the build-bots to chew on for various .config and arches to see
if we have any.

Since most (if not all, I'll check) of the out-of-line implementations
handle nbits==0 correctly, I'll probably just unconditionally add the
nbits>0 clause to small_const_nbits() to force the ool versions to be
used if any compile-time zero-size bitmap should turn up.

Not-really-signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/bitmap.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 1ee46f492267..a5879cb45687 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -196,8 +196,10 @@ extern int bitmap_print_to_pagebuf(bool list, char *buf,
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
 
+int const_zero_size_bitmaps_are_buggy(void);
 #define small_const_nbits(nbits) \
-	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
+	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && \
+	 ((nbits) > 0 || const_zero_size_bitmaps_are_buggy()))
 
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
-- 
2.16.4

