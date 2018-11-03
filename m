Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE80C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9DA20848
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mp5yd+CI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9DA20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbeKDCiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 22:38:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38338 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeKDCiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 22:38:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id f8-v6so2348950pgq.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0YWwAMMqiDjM5JRkwFheW4FIHuMEuipJ8KG+gR9CPjo=;
        b=mp5yd+CImxtbA1QdgSl6hY4y2yKExif0OnWx+S1EGPqGjwRWgFYeOtItHj4ZXl9jDA
         dPOn534yck/Nw+yH3qbNmBYyFmTdPXCqjZtqnV2j1PPHX7YWJqprogQxvJLOM0UF04BH
         qjf/wFecvvtF0EzGkhGX5VbHLnLumfnugN8rQqKWz+CxE+iHJGRmONDUYyoCKi6NcXfo
         LCJspSiALMQcdytHJIZVBR6x59biavfgS2vXNijuSXtDLHloeZ2o1EqjZyGENiQDdZGD
         wW9AoF5d9ATWUMcZ9AyPCTl5e6E0FxJj+qe/mKG7eVt5gSrSoyshMP0xRGPiGYbksJHB
         Bh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0YWwAMMqiDjM5JRkwFheW4FIHuMEuipJ8KG+gR9CPjo=;
        b=uEudWBzuvf37e6wKj+D5Fa1prowXtdWz1e+rfRvdZjFifWednX8Zg667Id9wSQto+u
         MAqjG/yE/t+CXlRJ9PsucATah4bncYYtkO2yypc2I9peas0tWOcDqHEt2U8yimv7A8/K
         EntCLZQpFuV/E97KiVZoH/GsFqvsBVwirVHyXgpMVlndEOLv5zkyBtnKu03Bfnl/JtJK
         LwU9JAMHmZHpy+DnZOcbQ+LrqrGcKeMySDjTr+doVLd5XIbtRhW8uIw0oaNVvUS6B6P1
         67CZEV6iOS7sTr2KaM3LnYv3oDgpP6GZr4tD2c3seCR3EtySVFagSl0l6+KuHZdkCi1o
         tY3A==
X-Gm-Message-State: AGRZ1gLkUyrqt++cqwH2Gk9fsivlxnLn9jhLnKMnyfzmxJIGnudU103/
        ehex4eUuLtKLDRdTf5rjOUi8GoVPVqE=
X-Google-Smtp-Source: AJdET5fRKoT9rVVClfG7tDKno/RKRttMxH/LOqgXcgyoHG5uxNMvbJGvFLoemhWgH7RnO0dTXBjwiw==
X-Received: by 2002:a63:df50:: with SMTP id h16mr14838854pgj.421.1541265968661;
        Sat, 03 Nov 2018 10:26:08 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 74-v6sm55704761pfx.182.2018.11.03.10.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 10:26:07 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] sched/core: remove unnecessary unlikely() in push_xx_task
Date:   Sat,  3 Nov 2018 13:26:02 -0400
Message-Id: <20181103172602.1917-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to
use WARN_ON(1).

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/sched/deadline.c | 4 +---
 kernel/sched/rt.c       | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 91e4202b0634..8b5d964d59c5 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2041,10 +2041,8 @@ static int push_dl_task(struct rq *rq)
 		return 0;
 
 retry:
-	if (unlikely(next_task == rq->curr)) {
-		WARN_ON(1);
+	if (WARN_ON(next_task == rq->curr))
 		return 0;
-	}
 
 	/*
 	 * If next_task preempts rq->curr, and rq->curr
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2e2955a8cf8f..0efd58563c80 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1810,10 +1810,8 @@ static int push_rt_task(struct rq *rq)
 		return 0;
 
 retry:
-	if (unlikely(next_task == rq->curr)) {
-		WARN_ON(1);
+	if (WARN_ON(next_task == rq->curr))
 		return 0;
-	}
 
 	/*
 	 * It's possible that the next_task slipped in of
-- 
2.17.0

