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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9086EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9A12173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hksXfd2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfBZKD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:03:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42786 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbfBZKDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:03:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id n74so5996779pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 02:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kyl9qadJ2nNRAqq9IwbQU519mOSkkmNpab6IRKfgh0Q=;
        b=hksXfd2JvvExXDVKIxjWyOX0a9WbYJCnn4JyPdnm58ILG6lI+/5+dDqXKRfTYDOTjE
         RsaxB99IJtlCBIqPuij0chj9ZFeREKXddnY73xZOXk1AxUPAOn0GOs8XOx2mh3NZ/pMl
         hWeb8QFob/f4xaiFUc2uwHt+x9+LdIq9J2Y+29epftjzL8MIDw92enNoPpOjp0kg3GxP
         O+rfsj1lPxrB8cLzRP2t+ohbKIV1hVNp0rNbv115WpdgJcAtsB1vg/CzqSNvdBPGdH/1
         6v2dDO99RH/Pgffbbo3x0xHk1YvDRxSVrTs84k/Q4S8p8sEhBpiRRJJnRY7y4e3GBOJc
         1Nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kyl9qadJ2nNRAqq9IwbQU519mOSkkmNpab6IRKfgh0Q=;
        b=Y/9Oxq/D1SxjM65UjjhaUDJ6njHKHAetEJy4YJ/pXfhCy1WVaCZkm0muZUTJHQXGqH
         QxNsRJo6JNxl172t0K+JoNcZ0c5W8Jq01zTWN855f4Bvl8iLwJIb7xKcXpFKocLCv/70
         4K+ZuON7WhuWF0gpYXvwCx4KQPlBNM7EeMZypS69XS5GvfZrmZIw3EKt1z596sKpQ6LA
         JxlRWIc5V6wZVTqSlz2ilre+hsiWEbkvCMu4q8h9pOpzY70tqa47oOaVpmfjEZx8muuM
         DuJznZ+XuKZA/uPJZs1OQGmxxz1jZnW1fBoZ2/XnSKvt4UjMlM0HI46nqDp+emwdixtD
         CzQA==
X-Gm-Message-State: AHQUAuaVgsBKlBqnYE+N2xVqsVgAPInt3YVzBRJmSOy2g4rcgEXu466o
        3QN5PIDZOvioCKIasy7qkz8=
X-Google-Smtp-Source: AHgI3IaHIl8IG83U9Jg2N2+zj20B2uBUDZ8vgB9rWaNOfg8O9jVfp2HHhZP8/+dZ7BkKnIQ4Xeca7A==
X-Received: by 2002:a62:2ad1:: with SMTP id q200mr24857246pfq.34.1551175433283;
        Tue, 26 Feb 2019 02:03:53 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id y6sm12045520pfy.87.2019.02.26.02.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 02:03:52 -0800 (PST)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 7/8] locking/lockdep: Update obsolete struct field description
Date:   Tue, 26 Feb 2019 18:03:26 +0800
Message-Id: <20190226100327.19340-8-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190226100327.19340-1-duyuyang@gmail.com>
References: <20190226100327.19340-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lock_chain struct definition has outdated comment, so update it.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index c5335df..128f276 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -192,7 +192,11 @@ struct lock_list {
  * We record lock dependency chains, so that we can cache them:
  */
 struct lock_chain {
-	/* see BUILD_BUG_ON()s in lookup_chain_cache() */
+	/*
+	 * irq_context: the same as irq_context in held_lock below
+	 * depth:       the number of held locks in this chain
+	 * base:        the index in chain_hlocks for this chain
+	 */
 	unsigned int			irq_context :  2,
 					depth       :  6,
 					base	    : 24;
-- 
1.8.3.1

