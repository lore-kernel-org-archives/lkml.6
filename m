Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87641C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A10B20684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3qMx+Zk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A10B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeJCM1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:27:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42903 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJCM07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:26:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id f26-v6so952849pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 22:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=DBxsHysBh3lZnjuA3F/9N+mg9pNBgy3X6vmX2UgKVI8=;
        b=b3qMx+ZkNPi8XxYKvaxR28GxYMMab829EYJPMI7PkGGfUfXkez3Zj95rvJf3XGn0+g
         i/vI/nfkpUVkcdcs4+HUzCMMwxLd61Kl5K6qHobe77zEj1Y1aI///yjwcKImfo4GVfKV
         UaVnZbWafHfITmhq/7VqEOMQYI2EQtXCF73DHwOynF72TvJQ2LXr4nU+E3m2TtEfeFfX
         DaIm8ZLZBCvdyBS82NQemNKCXdDJ4dueMZUmFze3RisYWEsQKCGlTdZxC3sL5Wzdx2i2
         EFxv5O4+6g0vbt62W0gvlnsypzSnSvoTEHgbVldpdHbXEvV25BuixH52nkg6RUlemU4+
         LM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=DBxsHysBh3lZnjuA3F/9N+mg9pNBgy3X6vmX2UgKVI8=;
        b=Vyv/Xa6o4/1yHZsEx4vsPRaphwzb2FZrYe27tcwrYekwgf8K9L7b+9oHRBfD1HNEY1
         rZXmICA/Yym87Uvd28cYc4Jkxnyo8H5icpmtR+6FGo4gVFMeF2uvyqi+mPw04vT9vUls
         XYHfHdreiHp/In4IOX66UsvYKzrEqbItvBbG3wEsI3fdLBSj/VgEqAakoaYxPbsXVOjW
         relBQRw+QueibrjfL1eT+jnF7rtdAbYZ+KDHeLU1gw6Q3y41QaKD3AwcdEpi+lVKjKD2
         +V1UNufuL+W+CTkR8Cvt/j0dlEEXKfR+WQHAoNlepabIqgEkf+KR4EMQ2/aM5fLUCzDv
         agow==
X-Gm-Message-State: ABuFfoiivygrAWOZ+n9lDSYALbxX9uZQzqqNqSHP5JRrmixHSZS0l/7U
        mq7aHkNs7HjfxihICkiyBHfG/gs/eqI=
X-Google-Smtp-Source: ACcGV62ZPAS6hDpwBqPBZEHk5nCYho0dzDWiz7qhJftZ1wjGq1Xuks+SE+Siw77kuiB5+tBKoSFLyw==
X-Received: by 2002:a65:4548:: with SMTP id x8-v6mr17121484pgr.414.1538545209609;
        Tue, 02 Oct 2018 22:40:09 -0700 (PDT)
Received: from E570.localdomain (c-24-21-68-121.hsd1.or.comcast.net. [24.21.68.121])
        by smtp.gmail.com with ESMTPSA id t11-v6sm708248pgn.38.2018.10.02.22.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:40:09 -0700 (PDT)
Received: by E570.localdomain (Postfix, from userid 1000)
        id 5E2361643D0; Tue,  2 Oct 2018 22:40:08 -0700 (PDT)
From:   Lance Roy <ldr709@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Lance Roy <ldr709@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Subject: [PATCH 11/16] futex: Replace spin_is_locked() with lockdep
Date:   Tue,  2 Oct 2018 22:38:57 -0700
Message-Id: <20181003053902.6910-12-ldr709@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003053902.6910-1-ldr709@gmail.com>
References: <20181003053902.6910-1-ldr709@gmail.com>
Reply-To: Lance Roy <ldr709@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lockdep_assert_held() is better suited to checking locking requirements,
since it won't get confused when someone else holds the lock. This is
also a step towards possibly removing spin_is_locked().

Signed-off-by: Lance Roy <ldr709@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
---
 kernel/futex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 11fc3bb456d6..3e2de8fc1891 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1365,9 +1365,9 @@ static void __unqueue_futex(struct futex_q *q)
 {
 	struct futex_hash_bucket *hb;
 
-	if (WARN_ON_SMP(!q->lock_ptr || !spin_is_locked(q->lock_ptr))
-	    || WARN_ON(plist_node_empty(&q->list)))
+	if (WARN_ON_SMP(!q->lock_ptr) || WARN_ON(plist_node_empty(&q->list)))
 		return;
+	lockdep_assert_held(q->lock_ptr);
 
 	hb = container_of(q->lock_ptr, struct futex_hash_bucket, lock);
 	plist_del(&q->list, &hb->chain);
-- 
2.19.0

