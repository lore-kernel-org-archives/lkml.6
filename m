Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ED7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729612173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m91qCFRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfBZKDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:03:54 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34761 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfBZKDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:03:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id d15so6020556plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 02:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=70NA6I+KaNwoJWkboM2n35K+1R5PJ0p/4kTJUUd+ebg=;
        b=m91qCFReD0ELM0HYpIcHLKo1wuhKavEVtvl1WQ3vI7s7JONhAHxGfQIsTGB/f4sfhn
         IVplvtFJv8b/KqxDZHh0tUbjhLGrM05fOWUvXiQI1dc+3AT5fOn2PGtqN49xvNEKxdD+
         q7nodTYHEU7LrJcmMGvc7KZB3hKyvBs7XqRHDR2EfqBoKcvrqexwWIeq20mjlbHEzNZe
         qoek8h4mJc0b/f6impX7PY6h6SH1n7APi03c8XkE6N5YS45SvLtlnyL/XGKZH1BgBqfv
         h/vaRwZ1BD7FMB86ZQkD6CJlIz43fSsWXICi6QAAY5sIz73PutHoP778QL0z/XeF+Gny
         91lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=70NA6I+KaNwoJWkboM2n35K+1R5PJ0p/4kTJUUd+ebg=;
        b=GI5RFn1W2WwQZu8zYwBdL/gksRQZnBE5NaFqF47iZM0yFAdIUn3xYi14y8Pa1qPvet
         tOJ+mKxZ1Ck7c9yh66fIsrSmiHqRXRr4BrVD2IGTcj3e+5SmkLpqmCIjRBCj7F4qlFTL
         PWOBxsvZKKCYoQQnQbkUYIwrivzAUtlhSsTPx42SGRAoALw6bwDK+Is2um4JvrHQw7th
         J6jyAkcvojowmw4oMRKjyblOfWzTN3Rk5GCyi8PsM0BX3E8Jynrfl+d2Ku5YVHtWpdxm
         W+cltTgB97f4RZSWfYNmV4KlJvhrtAU21sPtBUCiMShnlhMlG8DbnzMHl0qA+0k1LWJZ
         HzWA==
X-Gm-Message-State: AHQUAuZqlqYLiXT7Iirbuo3VPDN843ZAgBrpHWh4ZmoPE/PMuZb715wv
        hEuvrcVWuC/KtTla9QkIQpU=
X-Google-Smtp-Source: AHgI3IY2+ZA27+Cnmi42eXjadfqo42a5753eLl/5hhXmwR/w30UvNYNvz7Yv5M2tPg0IeLO3/kNIlw==
X-Received: by 2002:a17:902:bd96:: with SMTP id q22mr25406895pls.7.1551175430930;
        Tue, 26 Feb 2019 02:03:50 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id y6sm12045520pfy.87.2019.02.26.02.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 02:03:50 -0800 (PST)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 6/8] locking/lockdep: Print right depth for chain key colission
Date:   Tue, 26 Feb 2019 18:03:25 +0800
Message-Id: <20190226100327.19340-7-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190226100327.19340-1-duyuyang@gmail.com>
References: <20190226100327.19340-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since chains are separated by irq context, so when printing a chain the
depth should be consistent with it.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 55270938..ec4f0c6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2061,10 +2061,11 @@ static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
 	struct held_lock *hlock;
 	u64 chain_key = 0;
 	int depth = curr->lockdep_depth;
-	int i;
+	int i = get_first_held_lock(curr, hlock_next);
 
-	printk("depth: %u\n", depth + 1);
-	for (i = get_first_held_lock(curr, hlock_next); i < depth; i++) {
+	printk("depth: %u (irq_context %u)\n", depth - i + 1,
+		hlock_next->irq_context);
+	for (i; i < depth; i++) {
 		hlock = curr->held_locks + i;
 		chain_key = print_chain_key_iteration(hlock->class_idx, chain_key);
 
-- 
1.8.3.1

