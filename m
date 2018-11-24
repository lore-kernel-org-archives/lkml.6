Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A0FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 15:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB7B2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 15:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLnPXe4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB7B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeKYCX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 21:23:57 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43283 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeKYCX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 21:23:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id u18so12167300oie.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 07:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/FuY6dgIuspQHr57QcxDIROVOnk4ZxSYqUTFxv9J2GE=;
        b=RLnPXe4JasnPuwQNW7n+lXR4QyKJ4P0OJXGm72UCGchI3wYQCzFxhMMO7upY96Kjcj
         nIciCaHW1OcawVqJf2JfcjNauX6w9crkRI9o/fUqtvh0Ne/wRfKELWRcL1UxVzTsDMD5
         iTEBtfULUMdjH811F1KkV1Pq3bBKcIokv6byt48cEAyRKcdDQDtwd1WyGmG8Gj8Z4069
         Comi1429HuqdyV2PgEcTnDsWJHaXN+QkXgCkbwNyZ6INj6diOcD/H11IVd7AdCf9vzyL
         UFmKBOBHR4vaRYH745eouPC0P9DJOYmMgCs/OZYeRo7mZ/sv9FAcXmTB9cb14oted8y7
         /Z9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/FuY6dgIuspQHr57QcxDIROVOnk4ZxSYqUTFxv9J2GE=;
        b=SBaZ6yv2Cu5Vnild3JoiEyYLXyWwzn2dDR3le3qv3A8uA5HJ54Yr9wSgjyju8eBzUG
         VyZ89PVZx21iVBQYyo17YQsz1dg2iWngIRzI1+t6Qi1JUFed4QgvvVZVPXtwSGF0MJB3
         rEpOxbWWtlTgOV3ofkqh46wKd2Rvi+PTx7+AFuDjZ9G8N1q7VPru3kE5mF+4gkBp2jw1
         KDyRXT4l7BLR8BihO46hkxXIFhiqbfgSeBBLU4qsIZvZQLlc5pe45rtzsXIvC3KaG8Tn
         3V9T6OtOmdo0VxBeFAEusBdsDkhjLlBgjsUrmGcDB8DxyCqouMZTCcsajYmJAGJ2v3aB
         J7ag==
X-Gm-Message-State: AGRZ1gIeTAUr0YIPN0UHRDsmTltCho8MVOKXuy2zq0LmBCLfM6iohQOP
        kybllSjQWdUrKZxq6isGa4MW6h6FAQc9vUbK1WoyKs5j3l0=
X-Google-Smtp-Source: AJdET5fLiicJ7YaubKHHYpOjDsZMU/kLncyJ5XwdRwPU6BW8uUNcK3P1Ld5IxySLeo6JmDCVr/dhtquMrGCdBeHfjS0=
X-Received: by 2002:aca:d509:: with SMTP id m9mr10583311oig.82.1543073716617;
 Sat, 24 Nov 2018 07:35:16 -0800 (PST)
MIME-Version: 1.0
From:   David CARLIER <devnexen@gmail.com>
Date:   Sat, 24 Nov 2018 15:35:05 +0000
Message-ID: <CA+XhMqyP=OZ5=GF1L=1EkNuNWJfk0t=GJWvQd=K46vT-sq9L6A@mail.gmail.com>
Subject: [PATCH] Little memset_explicit optimisation
To:     linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        aryabinin@virtuozzo.com, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] memzero_explicit, optimisation for size.


Using the return value of memset for save/load sake.


Signed-off-by: David Carlier <devnexen@gmail.com>

---

 lib/string.c | 2 +-

 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/lib/string.c b/lib/string.c

index 38e4ca08e757..92da04a0213b 100644

--- a/lib/string.c

+++ b/lib/string.c

@@ -720,7 +720,7 @@ EXPORT_SYMBOL(memset);

  */

 void memzero_explicit(void *s, size_t count)

 {

- memset(s, 0, count);

+ s = memset(s, 0, count);

  barrier_data(s);

 }

 EXPORT_SYMBOL(memzero_explicit);

-- 

2.19.1
