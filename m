Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB18C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C261218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iMd2yUcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfAXS66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:58:58 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:53391 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfAXS66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:58:58 -0500
Received: by mail-wm1-f44.google.com with SMTP id d15so4336067wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 10:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WnojILYOyO4LFBFFRVLcEieCGdHG1xvOy0tZNL/+Y5k=;
        b=iMd2yUcrIW+jQ4ZFdqgd8FKxZ/Fqj/oTZFZAH1dEDE0l2zRCmRgR9W3xNSlq7Zi+uA
         uva2j00uOqfX6g+fvEVDFq5FDXlId9q4RdYfrFm7i0VreOM5jWp7t2yCRL4ZSMbLVDQm
         c1e3y9n81ip6MrXbS/jHpg+BctevjwyZXZ2z8fmaYWFz8gLGPQMJyO4EK2X5cSZGwbK2
         yt1PjY0sCzk9o1+wV9UiNscE+cjjV6OyqiXMLVwYicU50whgutHzaOZyBdea5XWdJaGY
         UT+WmfuFQa0WFGJOf9MNIxH0lZBWWyP+Tbbmqzg8qH0T1gk8bS1SVOKHj3kWHlRpx6I6
         ZhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WnojILYOyO4LFBFFRVLcEieCGdHG1xvOy0tZNL/+Y5k=;
        b=pw03g8ZNHn4P/HKG//B3uaEi6+EjoEOyQRLaKu7knskftMv0/uWitYye2YNiRMz4ep
         k0/Ncx654rxNawcGkioi19625QCHjLCIOucd99QQHMORx5dzrZoGF1h/GdY3qZchMhVb
         HoprLeLrFpS+vMt8fZIA3uwhPy2Ic3gfSzr3bsMqedS2qOPOY5PkFLB8nMjXA5WcFeTg
         OTGT2VfJdQB1xFj15qvug9VkG8P656ett2t3vbgXppNLubnAg2tJkhNaQyWuyvlxrrJP
         SlYJkdgnRZZD9cKjoJ803Q9Y/V7s/nG5obcB3RI9aO4bzmgQzdXPvqqJZ8/Bbi1Z/eVx
         06Pw==
X-Gm-Message-State: AJcUukfTQJVtAuEw5eqtdPgas6MxJNGhjDc5TvVPQIsY5WNKUKjiqfSU
        6mDFdcx1S0OHa7clVuoSiEQnQvFOKISWrbOm
X-Google-Smtp-Source: ALg8bN7XXFfAtRkBYJ8kQ3Buee3pkOsJxqSeXwDsCSnf71eqGEESzTbHd5lVV1m+2wQSqn2fEv9s+g==
X-Received: by 2002:a1c:90d5:: with SMTP id s204mr3860041wmd.148.1548356335998;
        Thu, 24 Jan 2019 10:58:55 -0800 (PST)
Received: from winie.fritz.box (i59F4F430.versanet.de. [89.244.244.48])
        by smtp.gmail.com with ESMTPSA id x3sm99578209wrd.19.2019.01.24.10.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 10:58:54 -0800 (PST)
From:   Florian La Roche <florian.laroche@googlemail.com>
X-Google-Original-From: Florian La Roche <Florian.LaRoche@googlemail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Crt Mori <cmo@melexis.com>, Joe Perches <joe@perches.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Florian La Roche <Florian.LaRoche@googlemail.com>
Subject: int_sqrt() adjustments
Date:   Thu, 24 Jan 2019 19:58:52 +0100
Message-Id: <20190124185852.19423-1-Florian.LaRoche@googlemail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


__fls() is returning an unsigned long, but fls() and fls64() are
both returning a (signed) int.
As we need a signed int as right operand of "<<" (as Linus pointed out),
change __fls() to fls() for 32bit and also adjust masking the lowest bit
to be a signed int.
Now the 32bit and the 64bit version are again similar.

best regards,

Florian La Roche



Signed-off-by: Florian La Roche <Florian.LaRoche@googlemail.com>
---
 lib/int_sqrt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
index 30e0f9770f88..66eb93105812 100644
--- a/lib/int_sqrt.c
+++ b/lib/int_sqrt.c
@@ -23,7 +23,7 @@ unsigned long int_sqrt(unsigned long x)
 	if (x <= 1)
 		return x;
 
-	m = 1UL << (__fls(x) & ~1UL);
+	m = 1UL << ((fls(x) - 1) & ~1);
 	while (m != 0) {
 		b = y + m;
 		y >>= 1;
@@ -52,7 +52,7 @@ u32 int_sqrt64(u64 x)
 	if (x <= ULONG_MAX)
 		return int_sqrt((unsigned long) x);
 
-	m = 1ULL << ((fls64(x) - 1) & ~1ULL);
+	m = 1ULL << ((fls64(x) - 1) & ~1);
 	while (m != 0) {
 		b = y + m;
 		y >>= 1;
-- 
2.17.1

