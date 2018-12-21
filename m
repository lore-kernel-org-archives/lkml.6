Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6444EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FB321903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLZtvqA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389189AbeLUH27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:28:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43348 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389094AbeLUH24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:28:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so2174728pfk.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 23:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oDlspMEXY11pfuqnXgV8Ua5/Uhfl1wFudJcG8S4/wow=;
        b=dLZtvqA4mEk8wQmafr7J6dgJ5cx1PK6/B1CcO7UIJU3awqykyTxb1ndk31kSJtl25f
         080zWhemTbzwSqvOs5VRLMb/k4CP69TJpNBg7UcmyEW8t6tHqqKpWZmcfEf3cN64uX6B
         8cZ2jLGfVUrsihZjBBhGEywKIqj4MAe/rOyXUSjLC4/ik98GmhD5KnF2YFFUiRPjYpR8
         6Ls4HUCCm5SQWRtZO/iFsfkr/IKHjEuG9HdjFcN3jr62KuSz7to0ZjSZwxBO8hS76Jyd
         KWdiFsBZA8qxlZ9chcxyznBBXmRCQJwsjABTiQwAt7nZkU2OrpK4aSxO1OAOwVd8FxrD
         FBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oDlspMEXY11pfuqnXgV8Ua5/Uhfl1wFudJcG8S4/wow=;
        b=h+9GAAXDgseA42eiI2sVwDrzf2qub3h/ptDJG9KX/tLA7mXw39+hby2Sek4t3Ti5XN
         vF5o1UjF+jhiIw3h579X+b7qR8eVB/XWfNVNS72AghXjKMd2WzitYPgH+9fDktdk/J5J
         asSwMWAkz+75KHX9nzG416EMqdHy5hJAQkIiLseVpSFvWKBYM+BD+klZEnMOBUt6q+ny
         QK+CE4woiXQ7nG62FAywPqhdxFBMxRvLMQq6s8hs44G+T75l1MHgI8qk9C952FN+n/8z
         Cq3NjUq2+8UbGhO3CqTBzjpXavE9Z0L6+kq16ytYtrFFk41y4W+1oABfIzwX7pXbRL0Q
         P5cQ==
X-Gm-Message-State: AA+aEWY3kia4MOxJ/t+Qo7z9S3QRXrjDpXVgdqPVJWr/2DRfWONbQ3hm
        9ihC5zd9y02G6T2+uqGAhveptpRV
X-Google-Smtp-Source: AFSGD/XDaMP55AZlZ778x+Z4TEe82nLbX+s2Mkp6fg1Lqpzbh4TlhIRR0g6xEuJERFK7N3opnvTamQ==
X-Received: by 2002:a62:442:: with SMTP id 63mr1399337pfe.156.1545377335613;
        Thu, 20 Dec 2018 23:28:55 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id f20sm27688275pfn.177.2018.12.20.23.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:28:54 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Kyle McMartin <kyle@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/5] ihex: Simplify next record offset calculation
Date:   Thu, 20 Dec 2018 23:28:39 -0800
Message-Id: <20181221072841.30199-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072841.30199-1-andrew.smirnov@gmail.com>
References: <20181221072841.30199-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next record calucaltion can be reduced to a much more tivial ALIGN
operation as follows:

1. Splitting 5 into 2 + 3 we get

   next = ((be16_to_cpu(rec->len) + 2 + 3) & ~3) - 2            (1)

2. Using ALIGN macro we reduce (1) to:

   ALIGN(be16_to_cpu(rec->len) + 2, 4) - 2                      (2)

3. Subsituting 'next' in original next record calucation we get:

   (void *)&rec->data[ALIGN(be16_to_cpu(rec->len) + 2, 4) - 2]  (3)

4. Converting array index to pointer arithmetic we convert (3) into:

   (void *)rec + sizeof(*rec) +
   	 ALIGN(be16_to_cpu(rec->len) + 2, 4) - 2		(4)

5. Subsituting sizeof(*rec) with its value, 6, and substracting 2,
   in (4) we get:

   (void *)rec + ALIGN(be16_to_cpu(rec->len) + 2, 4) + 4        (5)

6. Since ALIGN(X, 4) + 4 == ALIGN(X + 4, 4), (5) can be converted to:

   (void *)rec + ALIGN(be16_to_cpu(rec->len) + 6, 4)            (6)

5. Subsituting 6 in (6) to sizeof(*rec) we get:

   (void *)rec + ALIGN(be16_to_cpu(rec->len) + sizeof(*rec), 4) (7)

Using expression (7) should make it more clear that next record is
located by adding full size of the current record (payload + auxiliary
data) aligned to 4 bytes, to the location of the current one. No
functional change intended.

Cc: Chris Healy <cphealy@gmail.com>
Cc: Kyle McMartin <kyle@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 include/linux/ihex.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/ihex.h b/include/linux/ihex.h
index 9130f307a420..98cb5ce0b0a0 100644
--- a/include/linux/ihex.h
+++ b/include/linux/ihex.h
@@ -21,14 +21,18 @@ struct ihex_binrec {
 	uint8_t data[0];
 } __attribute__((packed));
 
+static inline uint16_t ihex_binrec_size(const struct ihex_binrec *p)
+{
+	return be16_to_cpu(p->len) + sizeof(*p);
+}
+
 /* Find the next record, taking into account the 4-byte alignment */
 static inline const struct ihex_binrec *
 __ihex_next_binrec(const struct ihex_binrec *rec)
 {
-	int next = ((be16_to_cpu(rec->len) + 5) & ~3) - 2;
-	rec = (void *)&rec->data[next];
+	const void *p = rec;
 
-	return rec;
+	return p + ALIGN(ihex_binrec_size(rec), 4);
 }
 
 static inline const struct ihex_binrec *
-- 
2.19.1

