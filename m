Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CE2C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE6621502
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zsz7neUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE6621502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932236AbeGCAJM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 20:09:12 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33650 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932100AbeGCAJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 20:09:10 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so94566plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 17:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=kiGPGwNZ4IUkNPqITG5crCOZrcsIuNCmTWRzqfgxC1Q=;
        b=Zsz7neUmi4LdbmrV7KtW98Y4B7UFiK954a1hHJBf5auZ3pb7cKr8KRjmMRhqROeV31
         WxrN587Rxwndg4u+QbrNexcHb+hKTyNiLXkepE/h7um48rHfo+IoL5yAqCn/9e/csQVQ
         8v8/2CUdFp8+ExqZO3q29UkFoYas/0yBC8yEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=kiGPGwNZ4IUkNPqITG5crCOZrcsIuNCmTWRzqfgxC1Q=;
        b=MNDD1KLcn6UzKUDA48HL+vQVCDpwG7ahTR6/j3T1oiWr8u6LAmnyJmIXGeSJ0+4NuT
         Voq5QFEwdDeyqRgYYCSG0tMQ2br4LNzZVKRu0uJmEeQLhhZj3rnoMAWbLugO45ajcLwu
         1RynOOqW8dYxwJTvlc1N3ztWwzk9hFfRzlTzirCBHXVc+sqF1pevHFLxPcussaDAaMbE
         V6+8M8vgaxr9IZPaiw40xvjefrb4XcYvbiALOaM6J7sicrHDPu57BrGyN9ci3QHRu6k/
         2LD0do+N7qlTD+EB98FLg6i+5/R7DQ/GlpeYUjrsc3k5W9fPfbQiUgz5fnUpOugB1iKy
         TKOQ==
X-Gm-Message-State: APt69E3LeaaKsIDHYUMS2wwpI8ADr837CIRFOHV8LCYprjlBl5UmSkcV
        cRgC7d/q1QGb6R3J7JxTEq+TcA==
X-Google-Smtp-Source: ADUXVKLGP5IXshUq7KgfRZg9Zmc0Tegqyslcikw2J/m8+sju69kKbzY/0xrxNHiMWhxpV4exP4kHeA==
X-Received: by 2002:a17:902:381:: with SMTP id d1-v6mr27760110pld.309.1530576550366;
        Mon, 02 Jul 2018 17:09:10 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id b1-v6sm1338426pff.141.2018.07.02.17.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 17:09:08 -0700 (PDT)
Date:   Mon, 2 Jul 2018 17:09:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: [PATCH] kernel.h: Documentation for roundup() vs round_up()
Message-ID: <20180703000907.GA27014@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Things like commit 3619dec5103d ("dh key: fix rounding up KDF output
length") expose the lack of explicit documentation for roundup() vs
round_up(). At least we can try to document it better if anyone goes
looking.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/kernel.h | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 941dc0a5a877..28f8830e1b3c 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -85,7 +85,23 @@
  * arguments just once each.
  */
 #define __round_mask(x, y) ((__typeof__(x))((y)-1))
+/**
+ * round_up - round up to next specified power of 2
+ * @x: the value to round
+ * @y: multiple to round up to (must be a power of 2)
+ *
+ * Rounds @x up to next multiple of @y (which must be a power of 2).
+ * To perform arbitrary rounding up, use roundup() below.
+ */
 #define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
+/**
+ * round_down - round down to next specified power of 2
+ * @x: the value to round
+ * @y: multiple to round down to (must be a power of 2)
+ *
+ * Rounds @x down to next multiple of @y (which must be a power of 2).
+ * To perform arbitrary rounding down, use rounddown() below.
+ */
 #define round_down(x, y) ((x) & ~__round_mask(x, y))
 
 /**
@@ -110,13 +126,30 @@
 # define DIV_ROUND_UP_SECTOR_T(ll,d) DIV_ROUND_UP(ll,d)
 #endif
 
-/* The `const' in roundup() prevents gcc-3.3 from calling __divdi3 */
+/**
+ * roundup - round up to the next specified multiple
+ * @x: the value to up
+ * @y: multiple to round up to (must be a power of 2)
+ *
+ * Rounds @x up to next multiple of @y. If @y will always be a power
+ * of 2, consider using the faster round_up().
+ *
+ * The `const' hereprevents gcc-3.3 from calling __divdi3
+ */
 #define roundup(x, y) (					\
 {							\
 	const typeof(y) __y = y;			\
 	(((x) + (__y - 1)) / __y) * __y;		\
 }							\
 )
+/**
+ * rounddown - round down to next specified multiple
+ * @x: the value to round
+ * @y: multiple to round down to
+ *
+ * Rounds @x down to next multiple of @y. If @y will always be a power
+ * of 2, consider using the faster round_down().
+ */
 #define rounddown(x, y) (				\
 {							\
 	typeof(x) __x = (x);				\
-- 
2.17.1


-- 
Kees Cook
Pixel Security
