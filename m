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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6495C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2A6206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljCuQCRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2A6206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeJCM1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:27:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44504 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJCM1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:27:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id p25-v6so2877597pli.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 22:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=E/Mfv8nCJWeeyQlp/XUi0bPWD1GB9UX6UcF/dUzBp5o=;
        b=ljCuQCRZ677QCGk1mXe3hedVicVAiDtDCetS8GKR+hn4R2zXwSGoFxy6FoEHxmxhWj
         3roCV0fxITwsqWxQYOpFcolDo8216D/OV8uhRNgZ6fM/P2oAq8DG5mdYcdlfgYvWQKKC
         ainXISduKtZllD97OhTTn6CPTsAhQ1cuSs5z+TMwM5sApmwpCVk6rdFA69TCg5/Fkmlp
         L/iVejiXgWmVhZP66RmsEu+7WhaN/6AXtp6mQYKVl7i30Cys3rKqJ4owArLospCU19ao
         ddve/ZVgaofNadf9hujBXhKQKR8HW63r+anOXUUu5HkMxMjQnx1g3Ji6TcrHncg4+eLe
         Tu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=E/Mfv8nCJWeeyQlp/XUi0bPWD1GB9UX6UcF/dUzBp5o=;
        b=SzBS+K1Zq4Hsu75mBLZsk37t7qdDUpJpge62ydRtdAgd36kKGAXIB5+OPMaQhy1+Lv
         2sFO2yrl63ioAsg9eSx+CKJSKvVHZGgQbe0C/ovpq93KUOrvy3odnIfFD1v8rbY4XlDu
         ctabDvL6gG0it8iWdRHKqu0B05e6dNgKTusJ5npq4i8etjvXBjkPbN6FKnjU7qC8gYPG
         +tzOWyFU4fmYY059YXG7L8KZvTee0NRe0IT+bni9WuIlf4uebEYaJleiuEUFghGrTGiE
         K5vptGIFn29bo994cxRV2FJ56ZO9bc+l5ia2OxqhcmZSN8oSTDpCGJ/cp2Wxe+u8qz5h
         7lvw==
X-Gm-Message-State: ABuFfoibV4TFv2IvrW5TSSZXJtR1wcPmWijHNSBUvi2lTFWDsbPmoPb1
        HpwYo1xn8qCaepFB/9Q22Q0=
X-Google-Smtp-Source: ACcGV62hGGMMkI8aHfcLrw7EVmx/8fLleoq8qMk9qhc4XN5mSr3aXRdOnnuLUfOtHVpAk1xXz7sd5g==
X-Received: by 2002:a17:902:6b45:: with SMTP id g5-v6mr7651740plt.41.1538545212211;
        Tue, 02 Oct 2018 22:40:12 -0700 (PDT)
Received: from E570.localdomain (c-24-21-68-121.hsd1.or.comcast.net. [24.21.68.121])
        by smtp.gmail.com with ESMTPSA id x20-v6sm691340pfe.131.2018.10.02.22.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:40:11 -0700 (PDT)
Received: by E570.localdomain (Postfix, from userid 1000)
        id 056391643D0; Tue,  2 Oct 2018 22:40:11 -0700 (PDT)
From:   Lance Roy <ldr709@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Lance Roy <ldr709@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 12/16] locking/mutex: Replace spin_is_locked() with lockdep
Date:   Tue,  2 Oct 2018 22:38:58 -0700
Message-Id: <20181003053902.6910-13-ldr709@gmail.com>
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
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/mutex-debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index 9aa713629387..771d4ca96dda 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -36,7 +36,7 @@ void debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
 
 void debug_mutex_wake_waiter(struct mutex *lock, struct mutex_waiter *waiter)
 {
-	SMP_DEBUG_LOCKS_WARN_ON(!spin_is_locked(&lock->wait_lock));
+	lockdep_assert_held(&lock->wait_lock);
 	DEBUG_LOCKS_WARN_ON(list_empty(&lock->wait_list));
 	DEBUG_LOCKS_WARN_ON(waiter->magic != waiter);
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
@@ -51,7 +51,7 @@ void debug_mutex_free_waiter(struct mutex_waiter *waiter)
 void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 			    struct task_struct *task)
 {
-	SMP_DEBUG_LOCKS_WARN_ON(!spin_is_locked(&lock->wait_lock));
+	lockdep_assert_held(&lock->wait_lock);
 
 	/* Mark the current thread as blocked on the lock: */
 	task->blocked_on = waiter;
-- 
2.19.0

