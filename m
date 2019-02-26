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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CF8C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B9D217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOR8TDW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfBZKDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:03:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43087 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbfBZKDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:03:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id q17so5991648pfh.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 02:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n+jUDdI2PpKwpVRi6ruVp/981RSiWdh1cpdFbLlcUpk=;
        b=qOR8TDW77OYZA/VuM5grouRb4TSg2OQQuC7xQdm13KF1CIOyNoAvgdH3NWrWYs4taQ
         /6FUk/cLD+SeuUz/L69gg3QUjY8W5Z8ln65ymJNaHM2ZyOJx+n28mOekxCn9CJVUOHPg
         80ndxiLaFPAVxIttc6BUs8yVMASP1KIs0TsENXlnXtDdpUJc6VL4R4gx6i0kzXU16zLn
         pbyV/D0VCRNtXo9QiGjX/0c5BMuMZPxah2BS1SuuPWJGt3Y4JJPzc5Fiux2hd2cd9OFr
         2sK8SzlWwfv/GoWCpZwhB3LrnEFPRpGjUHFNQGEfgxe/+cmeKhQOgqgBhCeOAHz/O+By
         yLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n+jUDdI2PpKwpVRi6ruVp/981RSiWdh1cpdFbLlcUpk=;
        b=rJty7BZM10PWh3mOoY0pDIm6AipgJzaTHmT3q6zHZO+IuPkaXFNxZjMkhLYuxQyCbq
         bF6u2D9XEyfYZXjI08CLP+UTWqaucej3YUP3drNbEGTUbGJRRkBzTSfRs9bLMGIUipBi
         aAkrgG9jOv3StZnwChNtT0UmX12ZxbLTT7k1nBvcEGdwH5imcoSQAs2gvWZphQa2A6/p
         K0dZxK/DxvTfW9hs73CAxjvtoB3NrVdJBwJco9wEFeUpRjnPE6Pytg55CTl/8RNney0I
         KShPV5FQwBZHj3pJc696jNORENYruG8ozgeU49w1q2BC1FOUx/K0tvaVC+PIbogPlQPS
         MEMA==
X-Gm-Message-State: AHQUAuaewuHZYpQ9HcxmGqK8T4FEreN7gTNZYWdIqF6BtGN/Zr0reX7E
        CZJGvB5jCSU3ilUgzhVqUnU=
X-Google-Smtp-Source: AHgI3IZJPgM2368eDfw4TenkAte59qfGOWd0l7Lg5pTca6kGRd4vGSd4LwGMI2ux2SaMhwb0+W5L3w==
X-Received: by 2002:a62:6702:: with SMTP id b2mr24856732pfc.244.1551175421819;
        Tue, 26 Feb 2019 02:03:41 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id y6sm12045520pfy.87.2019.02.26.02.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 02:03:41 -0800 (PST)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 2/8] locking/lockdep: Add description and explanation in lockdep design doc
Date:   Tue, 26 Feb 2019 18:03:21 +0800
Message-Id: <20190226100327.19340-3-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190226100327.19340-1-duyuyang@gmail.com>
References: <20190226100327.19340-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More words are added to lockdep design document regarding the key concepts,
which can help to understand the design as well as to read the reports.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 Documentation/locking/lockdep-design.txt | 89 +++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 25 deletions(-)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index 49f58a0..621d8f4 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.txt
@@ -10,56 +10,95 @@ Lock-class
 The basic object the validator operates upon is a 'class' of locks.
 
 A class of locks is a group of locks that are logically the same with
-respect to locking rules, even if the locks may have multiple (possibly
-tens of thousands of) instantiations. For example a lock in the inode
-struct is one class, while each inode has its own instantiation of that
-lock class.
-
-The validator tracks the 'state' of lock-classes, and it tracks
-dependencies between different lock-classes. The validator maintains a
-rolling proof that the state and the dependencies are correct.
-
-Unlike an lock instantiation, the lock-class itself never goes away: when
-a lock-class is used for the first time after bootup it gets registered,
-and all subsequent uses of that lock-class will be attached to this
-lock-class.
+respect to locking rules, even if the locks may have multiple (possibly tens
+of thousands of) instantiations. For example a lock in the inode struct is
+one class, while each inode has its own instantiation of that lock class.
+
+The validator tracks the 'usage state' of lock-classes, and it tracks the
+dependencies between different lock-classes. The dependency can be
+understood as lock order, where L1 -> L2 suggests L1 depends on L2, which
+can also be expressed as a forward dependency (L1 -> L2) or a backward
+dependency (L2 <- L1). From lockdep's perspective, the two locks (L1 and L2)
+are not necessarily related as opposed to in some modules an order must be
+followed. Here it just means that order ever happened. The validator
+maintains a continuing effort to prove that the lock usages and their
+dependencies are correct or the validator will shoot a splat if they are
+potentially incorrect.
+
+Unlike a lock instance, a lock-class itself never goes away: when a
+lock-class's instance is used for the first time after bootup the class gets
+registered, and all (subsequent) instances of that lock-class will be mapped
+to the lock-class.
 
 State
 -----
 
-The validator tracks lock-class usage history into 4 * nSTATEs + 1 separate
-state bits:
+The validator tracks lock-class usage history and divides the usage into
+(4 usages * n STATEs + 1) categories:
 
+Where the 4 usages can be:
 - 'ever held in STATE context'
 - 'ever held as readlock in STATE context'
 - 'ever held with STATE enabled'
 - 'ever held as readlock with STATE enabled'
 
-Where STATE can be either one of (kernel/locking/lockdep_states.h)
- - hardirq
- - softirq
+Where the n STATEs are coded in kernel/locking/lockdep_states.h and as of
+now they include:
+- hardirq
+- softirq
 
+Where the last 1 category is:
 - 'ever used'                                       [ == !unused        ]
 
-When locking rules are violated, these state bits are presented in the
-locking error messages, inside curlies. A contrived example:
+When locking rules are violated, these usage bits are presented in the
+locking error messages, inside curlies, with a total of 2 * n STATEs bits.
+See a contrived example:
 
    modprobe/2287 is trying to acquire lock:
-    (&sio_locks[i].lock){-.-...}, at: [<c02867fd>] mutex_lock+0x21/0x24
+    (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
 
    but task is already holding lock:
-    (&sio_locks[i].lock){-.-...}, at: [<c02867fd>] mutex_lock+0x21/0x24
+    (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
 
 
-The bit position indicates STATE, STATE-read, for each of the states listed
-above, and the character displayed in each indicates:
+For a given lock, the bit positions from left to right indicate the usage
+of the lock and readlock (if exists), for each of the n STATEs listed
+above respectively, and the character displayed at each bit position
+indicates:
 
    '.'  acquired while irqs disabled and not in irq context
    '-'  acquired in irq context
    '+'  acquired with irqs enabled
    '?'  acquired in irq context with irqs enabled.
 
-Unused mutexes cannot be part of the cause of an error.
+The bits are illustrated with an example:
+
+    (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
+                         ||||
+                         ||| \-> softirq disabled and not in softirq context
+                         || \--> acquired in softirq context
+                         | \---> hardirq disabled and not in hardirq context
+                          \----> acquired in hardirq context
+
+
+For a given STATE, whether the lock is ever acquired in that STATE context
+and whether that STATE is enabled yields four possible cases as shown in the
+table below. It is worth noting that the bit character is able to indicate
+which exact case is for the lock as of the reporting time.
+
+   -------------------------------------------------
+  |              | enabled in irq | disabled in irq |
+   -------------------------------------------------
+  | ever in irq  |        ?       |        -        |
+   -------------------------------------------------
+  | never in irq |        +       |        .        |
+   -------------------------------------------------
+
+The character '-' suggests irq is disabled because if otherwise, the
+charactor '?' would have been shown instead. Similar deduction can be
+applied for '+' too.
+
+Unused locks (e.g., mutexes) cannot be part of the cause of an error.
 
 
 Single-lock state rules:
-- 
1.8.3.1

