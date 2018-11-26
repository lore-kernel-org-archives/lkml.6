Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14373C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCE720855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcAGnhVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCE720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeK0BQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:16:10 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44408 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeK0BQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:16:10 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so6641498pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 06:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CGdMwR0sKw6CzKU4fRgtQLyppoVW56ZQjD11dAUBNw8=;
        b=QcAGnhVE4saiZ1NQPxaASTzEw95N2l1hScq4zJbb/8MX3eWgy5P3W+L+i6LHUK6c6w
         lsTYWqf/RRmHpIvZXRYTpy2iRtBuUeooivvLnBKqnOWJfQqaC30n5kA1AKrE15i4jqUq
         DaAZGTVioTC1IQ9ckmB/gsw/YRgM1JPv9ulZkskKAb2ay85nLtkqH4b3ygAaDkaU4y0B
         So0f59ATfDw3kw9JT7ohdwaRtTtR6B9MOCeOrCiBx+RgJtJ/Dk/78A2zDE91FzXe3p1I
         kP/aJTcWc1G5cJs7Xcv7AqFPbOte8pjhb5ryRcf2qBtxFpHK4Vzd5Orrm5Agb7wpmmhb
         AS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CGdMwR0sKw6CzKU4fRgtQLyppoVW56ZQjD11dAUBNw8=;
        b=TLukMlAo5ubfh2DNp5dVnDerc8U6nlG8wT4VNhbdjw+3VgXk3iWWtMkefbKtSegwmi
         no9m5MgiMuM8QlVOXQQBTm5MHAimL570E6SfvWiJaAW2vnnBxNl69w2hSxGGvyXupzMF
         9FLEBHJ/xCORkIHAGbh/X0pknOExfoDXWv2d6WBeHo+W6udC8dI3jBHVzulGqhR1jIkb
         zb13bnsmZq23GbQA0nFK2NsDzHzrsyMzYJB51ZjTUZDMpSLBT9F92i0TappYDiiVUH1P
         PaMzFhmF36+x0qG/Ec33rJ5yi5hUry5NKVUySeo/yL5/jXeUTwjamtadwgzzCXCaWl10
         ec5Q==
X-Gm-Message-State: AGRZ1gJ88ocTCxkffkQttm3/Sx9RVy3WzDokBy6DLHX15oBmfcp2Sid2
        PBPXInREAnLeMZgzHgzN+QQ=
X-Google-Smtp-Source: AJdET5fpTg0HAw3TNt/xlLphSR6CvBrTeSu2vTBGbMTJtgMpUmlV8Z686juNOLACghOJvnicidU/lA==
X-Received: by 2002:a62:6a88:: with SMTP id f130mr28495477pfc.201.1543242113507;
        Mon, 26 Nov 2018 06:21:53 -0800 (PST)
Received: from ubuntu.localdomain ([101.87.249.94])
        by smtp.gmail.com with ESMTPSA id u70sm1000849pfa.176.2018.11.26.06.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 06:21:52 -0800 (PST)
From:   Muchun Song <smuchun@gmail.com>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2] sched/core: Remove unnecessary check for next_task in push_{rt,dl}_task()
Date:   Mon, 26 Nov 2018 22:21:16 +0800
Message-Id: <20181126142116.5593-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In push_{rt,dl}_task(), we call pick_next_pushable{_dl}_task() to
pick next_task before the check. If next_task and rq->curr are equal,
which will trigger BUG_ON() in pick_next_pushable{_dl}_task(). See
the following code in pick_next_pushable{_dl}_task().

  static struct task_struct *pick_next_pushable{_dl}_task(struct rq *rq)
  {
	BUG_ON(task_current(rq, p));

	return p;
  }

The task_current() will check if task p and rq->curr are equal.
So, we can remove the unnecessary check in push_{rt,dl}_task().

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 kernel/sched/deadline.c | 5 -----
 kernel/sched/rt.c       | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 470ba6b464fe..4b0189627318 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2042,11 +2042,6 @@ static int push_dl_task(struct rq *rq)
 		return 0;
 
 retry:
-	if (unlikely(next_task == rq->curr)) {
-		WARN_ON(1);
-		return 0;
-	}
-
 	/*
 	 * If next_task preempts rq->curr, and rq->curr
 	 * can move away, it makes sense to just reschedule
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f28157c8212b..efc3fbe205ac 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1824,11 +1824,6 @@ static int push_rt_task(struct rq *rq)
 		return 0;
 
 retry:
-	if (unlikely(next_task == rq->curr)) {
-		WARN_ON(1);
-		return 0;
-	}
-
 	/*
 	 * It's possible that the next_task slipped in of
 	 * higher priority than current. If that's the case
-- 
2.17.1

