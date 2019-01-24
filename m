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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D0DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC43A2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="B0AjGESV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfAXSVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:21:11 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:37433 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfAXSVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:21:10 -0500
Received: by mail-wm1-f52.google.com with SMTP id g67so4104433wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 10:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+Pf3TnHcm8kpGnVLte97cs4+Wkq2CTZAq/GU1HnU1Y8=;
        b=B0AjGESVM1e4MpumA3HNsCEHvSI64XqiMibt/v44yOLB+cjHgh6hTNI2AcowkFOXsZ
         VfQ72xMnghnmtlPjkwWH3PyLhg7DCytQej1+hwZrrjl82eutxkR/HOUMt8QvUmiNSYbI
         YfRpW6PBo0D4lU0Qg/jGmoCp6PFBmLm8IhvYEuR0aSZ/b6XUM10/Gt0qeI7eRigBeZBL
         OlY52wNVqmpF+VEbp1WxXTHqPAfCEjn4gkQeAhcpQsWmmUjdcOkvuuwvhApjvxjYHPuh
         0Ygp2IEWaBqv30bz1ODKtCpIV3F2Sz5znfxU9kfSvDXKAh3ldXetW7Q7HSHyPPNj528P
         +cwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+Pf3TnHcm8kpGnVLte97cs4+Wkq2CTZAq/GU1HnU1Y8=;
        b=jjMHbtZfdMdYFbwXUWAQZ+OMUNJovL5gdaC8oKM144lmNDUZ+h+j0yiAhZhXZYqrJj
         +qrMGr97NfLtMG2c88sMnSMkHJ3bq+dQV+RBBJA8iad8odbMfZnKyGtu4aHdYGbDBaln
         c9sz67wQGzrihmpv2NHJx7s0DP4TdoJJj7wPLXbiOZsgtwST1nefMOU6qCABWJLbqh1j
         QTBvwuM6GTDUR8wpLzI9S2k0FCAEZ7+gbgXG7fFOXUHQR5WH9y1ZvjnfIDubOQaMMJmJ
         IdJZtoVgu88COjo3nVByI2XgAYjDOGOpfrUw8gKCcfW3zJpOBO5B6T/7iOAHl8jz6z8G
         A8pQ==
X-Gm-Message-State: AJcUukdZ1PasM4CeM26/0pFv0JaEjfBQVpp/txczEKzsosIDO6WoaoVp
        RkpNskIE3WVDGErL3U2bB5KLlwGQUtRGFMvV
X-Google-Smtp-Source: ALg8bN7uU1z/RNuKCtNmp5nLrD6h3afoOon0M/oEpb5YORutHazM5COQ9n9RCvT0X8xDu33/lci1Jg==
X-Received: by 2002:a1c:7c07:: with SMTP id x7mr3770710wmc.82.1548354068871;
        Thu, 24 Jan 2019 10:21:08 -0800 (PST)
Received: from winie.fritz.box (i59F4F430.versanet.de. [89.244.244.48])
        by smtp.gmail.com with ESMTPSA id 143sm129956087wml.14.2019.01.24.10.21.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 10:21:07 -0800 (PST)
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
Date:   Thu, 24 Jan 2019 19:21:04 +0100
Message-Id: <20190124182104.18022-1-Florian.LaRoche@googlemail.com>
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
+	m = 1UL << ((fls(x) - 1) & ~1L);
 	while (m != 0) {
 		b = y + m;
 		y >>= 1;
@@ -52,7 +52,7 @@ u32 int_sqrt64(u64 x)
 	if (x <= ULONG_MAX)
 		return int_sqrt((unsigned long) x);
 
-	m = 1ULL << ((fls64(x) - 1) & ~1ULL);
+	m = 1ULL << ((fls64(x) - 1) & ~1LL);
 	while (m != 0) {
 		b = y + m;
 		y >>= 1;
-- 
2.17.1

