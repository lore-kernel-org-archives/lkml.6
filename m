Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB526C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 19:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6134E2075A
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 19:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeUFOD8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6134E2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeIHXw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 19:52:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38976 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeIHXw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 19:52:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id q8-v6so17587056wmq.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 12:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=ZEPih0QR8mjuDmR3KcX3/Hlr3j46S6yG50/4VjpsI9g=;
        b=LeUFOD8/ZJNg6QtQC3YPW5Ye0r6+2/2FXtjgVJkcjscKwkfwRaAbWLUju5Qf5oERxA
         enpaqfN4t6MpGgjdqLq5Tt9EeJmvl0Jwz59rOSgj58G6AreSfdujKDTymVLfvTx4K4Sl
         4+Pw+xJB0zf+oa2GvOy12GTzPFQwUT/ORCuNGm/IwTCbitgOFZijzzIOvGb6alKeMgGq
         Dnr44tO22zRlMuzQBDfkHZhYY/VhItmfkVent1yCXzy+/aLBZ8v+/T2+GWgpHgF+dgx0
         5RKMBycGrYz1Q6cm/vweyRgUdpzJP6Ba++EyyhBZZlOZz+l8fVG7tndA5jZfvv6yoMLl
         oGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=ZEPih0QR8mjuDmR3KcX3/Hlr3j46S6yG50/4VjpsI9g=;
        b=RRLaI0hfEPzkW61ptRK+vhBQj9nFijTVsvaPpwEOD8r0dKAHUm740KGDi+Iz3G1vVE
         JCnzryHBHUJn1RQosAUH6sEqn10F7eujlxdzK/wq7KqNiSjd+km75bY/xKuQXXnH72Ag
         yhgkZ8ufDtcyeiLK7BhT2dXiIHEF0b6tUX0YokPPanki8Y0uBYBIWDs3yRvuaXkPM1Ft
         0eKNtG5Geq8rk3uvqRSiOTx7w8X4nz2uSjRToxvksrHn6V8TpgtH65rkjd0R6zZhpWLU
         1eHWOpInWGgg4ruAPRi/h94PwKLDlEcBqYCkPaSYhvD+rGhKh2GRwsJpMJHj69zQyGik
         Pfaw==
X-Gm-Message-State: APzg51BvVRwsFVx87DhuK2bT8IPGQCtPPTNNgvy2bfUkHkvjo560O9xk
        oNCPVfZxWKh8uFeuOwo0nQQ=
X-Google-Smtp-Source: ANB0Vdaw0S7Sj0VcgliCstMxRGKotCIUUgdXAN2cGGx6oaR2LX1mIu5TykPKVGqQSKfhmjzCn0v5Gw==
X-Received: by 2002:a1c:1748:: with SMTP id 69-v6mr8339012wmx.75.1536433572312;
        Sat, 08 Sep 2018 12:06:12 -0700 (PDT)
Received: from gmail.com (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id u1-v6sm8600370wrt.59.2018.09.08.12.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Sep 2018 12:06:11 -0700 (PDT)
Date:   Sat, 8 Sep 2018 21:05:53 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/sched/core.c: Avoid unused variable on non-SMP configs
Message-ID: <20180908190553.GA4573@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On non-SMP configs, when only one of CONFIG_{PARAVIRT,IRQ_TIME}_ACCOUNTING
is defined, we are declaring a variable (irq_delta or steal) which
is not used:

    kernel/sched/core.c: In function ‘update_rq_clock_task’:
    kernel/sched/core.c:139:17: warning: unused variable ‘irq_delta’ [-Wunused-variable]
      s64 steal = 0, irq_delta = 0;

The reason is that CONFIG_SMP guards HAVE_SCHED_AVG_IRQ, which in turn
disables the code guarded by HAVE_SCHED_AVG_IRQ.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 kernel/sched/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625bc9897f62..d662d1e11843 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -135,8 +135,11 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
  * In theory, the compile should just see 0 here, and optimize out the call
  * to sched_rt_avg_update. But I don't trust it...
  */
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
-	s64 steal = 0, irq_delta = 0;
+#if defined(HAVE_SCHED_AVG_IRQ) || defined(CONFIG_IRQ_TIME_ACCOUNTING)
+	s64 irq_delta = 0;
+#endif
+#if defined(HAVE_SCHED_AVG_IRQ) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+	s64 steal = 0;
 #endif
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
-- 
2.17.1

