Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182CBC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0302145D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qex5YzYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0302145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeLALNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:13:18 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39542 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLALNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:13:18 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so6200051edt.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OLSeUXZWPiLpVNgtUryyQYdNnf4Rl6/UQHX0BL1gdBE=;
        b=qex5YzYaGMRrHTasV9FB5+MkLHaiBmJsFpacltp2AgyaGW7Ji1RnsyPTOcOy6EdjOm
         F2YCayAOE8NTRxvDSSpPe5cAAjwwjWEuG1oyKEBnnNstDUb1iltDGiTVl9svElLeBRh/
         xGonPs4lfNOD8cJumUXNnSlaeJEJ95/jWYbkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OLSeUXZWPiLpVNgtUryyQYdNnf4Rl6/UQHX0BL1gdBE=;
        b=LidEjAiChWXYr+IbV9I6Hv6HuOPW+W3i4okp+FPngENCyLrDjJZJ3Z6BEFKPlK9HLc
         sBFhpzMuZiyTQ7tq4eyUhMvjouKc+xMvi3Mp83nekD6SQkWYRLhNUlZ01Oe9oXq4Ey80
         LvMA0hGAsZ/Ndiau5NhnK65MStMNTQpBRTfto7cHkSfedzFYUGiokkz4bh1qqit0BVaZ
         FbUbLzkZcxVL5XQubSQq7cPl9Yba0Lb1fl7K8o/JjEiyZXGpi7QqKAj5z4l+ou0MNZEb
         zwYP7FS5vUIe0lKAL/01SdijNhNq4r/Y84iqdZWTZPm19ClyBn7JTQjY6eqlrR88w5Yx
         dyPA==
X-Gm-Message-State: AA+aEWa/bzLLQ7BnCbcuJ+9x4TgZ1CJEqwt4qcB5a2/nYNye2h/3XK2b
        WP4JIar9dBpqkqCYiQFeedEfFji83RMOKw==
X-Google-Smtp-Source: AFSGD/VmwqdFJFgNvUHrmAOw/PNQJ+bheEpPhgYAPC0xAJY36zKz0q+iAm8PdEIzyiMwnH7WF6kzow==
X-Received: by 2002:a50:b2e1:: with SMTP id p88mr6719797edd.254.1543622532505;
        Fri, 30 Nov 2018 16:02:12 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8386-da8a-eacb-c188-78b9-634c.ipv6.broadband.iol.cz. [2a00:1028:8386:da8a:eacb:c188:78b9:634c])
        by smtp.gmail.com with ESMTPSA id k32sm1764304edb.42.2018.11.30.16.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 16:02:11 -0800 (PST)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] riscv, atomic: Add #define's for the atomic_{cmp,}xchg_*() variants
Date:   Sat,  1 Dec 2018 01:01:56 +0100
Message-Id: <20181201000156.5366-1-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an architecture does not define the atomic_{cmp,}xchg_*() variants,
the generic implementation defaults them to the fully-ordered version.

riscv's had its own variants since "the beginning", but it never told
(#define-d these for) the generic implementation: it is time to do so.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
TBH, the delay was not intentional: I've just become aware of it while
working on moving riscv over to queued rwlocks.  There's currently one
callsite for the non-fully-ordered variants mentioned above for riscv:
for atomic_cmpxchg_acquire() in kernel/sched/rt.c:rto_start_trylock(),

[before]

     51a:	100726af          	lr.w	a3,(a4)
     51e:	00069763          	bnez	a3,52c <.L17>
     522:	1af7262f          	sc.w.rl	a2,a5,(a4)
     526:	fa75                	bnez	a2,51a <.L1>
     528:	0330000f          	fence	rw,rw

[after]

     51a:	100726af          	lr.w	a3,(a4)
     51e:	00069763          	bnez	a3,52c <.L17>
     522:	18f7262f          	sc.w	a2,a5,(a4)
     526:	fa75                	bnez	a2,51a <.L1>
     528:	0230000f          	fence	r,rw

---
 arch/riscv/include/asm/atomic.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index c452359c9cb8a..93826771b616a 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -303,6 +303,15 @@ c_t atomic##prefix##_cmpxchg(atomic##prefix##_t *v, c_t o, c_t n)	\
 
 ATOMIC_OPS()
 
+#define atomic_xchg_relaxed atomic_xchg_relaxed
+#define atomic_xchg_acquire atomic_xchg_acquire
+#define atomic_xchg_release atomic_xchg_release
+#define atomic_xchg atomic_xchg
+#define atomic_cmpxchg_relaxed atomic_cmpxchg_relaxed
+#define atomic_cmpxchg_acquire atomic_cmpxchg_acquire
+#define atomic_cmpxchg_release atomic_cmpxchg_release
+#define atomic_cmpxchg atomic_cmpxchg
+
 #undef ATOMIC_OPS
 #undef ATOMIC_OP
 
-- 
2.17.1

