Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FD2C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A118620840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="WNxLTti2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A118620840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeKITt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:49:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39773 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeKITrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:47:49 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so1095566ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6Wj/Yvn1MPDfpWazWwZIKCiE0nwlA4W2lQxfpzYIE3M=;
        b=WNxLTti2Pj19TKpSwR5XTp73ZAw4APPDXK7EjgbUfMMDBEw5pp1kaVxD5LpqY+TO2l
         KzYPWyREFc5STHblQo6G+FWSXO95c4x1k808PEwxWZ5cV2G/s8Tayw10MnAdISnS7aL+
         On+c0wWK1lPisr7JW2tlAlhcJ2/h+guqpjXo5wBs3JUPhh0/k/hJVB9Sh3l12BaY8tIH
         uzRsssPSK0/VTYAprsnFBa8TdC/zGqUQfIzfIITXFG2By/FeXu7Vm7VzWSWSDHzv+fS3
         BIp0dSBVflBCukIEeSWp65zkqpl+jgcLuIf2p/IW2nUa64MkRbIwkbSX2dXK6+htcPvq
         o5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6Wj/Yvn1MPDfpWazWwZIKCiE0nwlA4W2lQxfpzYIE3M=;
        b=N/xtgwTGlw3iMaYVWLHuxPWwypHgc73IuDwoEkXaM8Ro/5T+1lUhvBrpZHP5aD6Yk8
         +HIi6ZYzugGeRBharuorX5hKNdPZJ5+Krc/7lAURstaTZjBeiaUagFXKHNvCiYVwUCSS
         htwdbb7AyTqaiFH5zW4m/tLt08UpCFvAYWYweaXZXBk1FteWaOnEW4b7WiKwnvHedEEP
         AEjaL/1yXM5Uob2Tzne77KbbarJ/8NfCjYx6UaICN9KO0KcQ9rjqCGYfloRArNb/Sw/H
         qUDcuEh5T85Xx/ddXzeSDa9SyXms0g1bZ1d027L2C2xKVg98x+My+fzAU+jrR4ch4UfN
         u3Ig==
X-Gm-Message-State: AGRZ1gL8EBtRF1t0UVjMpLHRWipZjp72bsu8gaRS4zl6KIR7eKF7VPZq
        KyPv/YfuWSe24l/0UcIqSx9pihYqCUAKMP9x
X-Google-Smtp-Source: AJdET5ekyzDgr+WLt/87euxu0AaFioXUhXyeqS7xA5jgu6ucs/3uaygjnezY0UlUKRFZmmQCKw6Lmg==
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr5466873ljb.52.1541758074526;
        Fri, 09 Nov 2018 02:07:54 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id u65sm1265576lff.54.2018.11.09.02.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 02:07:53 -0800 (PST)
From:   Henrik Austad <henrik@austad.us>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@arm.com,
        bigeasy@linutronix.de, xlpang@redhat.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jdesfossez@efficios.com,
        dvhart@infradead.org, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 02/17] futex: Use smp_store_release() in mark_wake_futex()
Date:   Fri,  9 Nov 2018 11:07:30 +0100
Message-Id: <1541758065-10952-3-git-send-email-henrik@austad.us>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541758065-10952-1-git-send-email-henrik@austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit 1b367ece0d7e696cab1c8501bab282cc6a538b3f upstream.

Since the futex_q can dissapear the instruction after assigning NULL,
this really should be a RELEASE barrier. That stops loads from hitting
dead memory too.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: juri.lelli@arm.com
Cc: bigeasy@linutronix.de
Cc: xlpang@redhat.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: jdesfossez@efficios.com
Cc: dvhart@infradead.org
Cc: bristot@redhat.com
Link: http://lkml.kernel.org/r/20170322104151.604296452@infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Henrik Austad <haustad@cisco.com>
---
 kernel/futex.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index bb87324..9e92f12 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1284,8 +1284,7 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 	 * memory barrier is required here to prevent the following
 	 * store to lock_ptr from getting ahead of the plist_del.
 	 */
-	smp_wmb();
-	q->lock_ptr = NULL;
+	smp_store_release(&q->lock_ptr, NULL);
 }
 
 static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *top_waiter,
-- 
2.7.4

