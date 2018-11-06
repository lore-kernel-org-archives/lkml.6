Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A65AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4251920869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc8Z+rCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4251920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389111AbeKGBX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:23:58 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37198 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388422AbeKGBX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:23:58 -0500
Received: by mail-pl1-f196.google.com with SMTP id p6-v6so6396862pll.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 07:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vzwN+R1wmxSpPdafDC3/WoRuAjJIADs1nCYaGN/ER74=;
        b=kc8Z+rCN51QLpV7tWkx19orAoZK+n8OQ/fsrCqTIjZCXpXrTyMtJ7VdVL5AUL0ZiGw
         GhLmo5exeBOtKC2nmLTOFCyed8OB5a52/CDet6jkMiNywXTwbimWFhSnPxyS3x5eDmB6
         CjQb4NjOWqEZo0wqGi3DkoL6dldjBhuZNBp384xR+unRvGKxNQWjVAA7nWOBr/XjHvGV
         mWUeeJA5GuQ21R6M/c37trhOJkbApOlCkedU2T4YWXr8+49UjXtI0ILmmCeRQtlK9eRl
         8evnlxo0hp770oaCN4NlIseg5WIhM3PSMra677CZ2B4bAsQt9mkOXNwNpWATJFrtdlfE
         TJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vzwN+R1wmxSpPdafDC3/WoRuAjJIADs1nCYaGN/ER74=;
        b=D7HjrEl8UF++RrdcZhg2ot/dWw/lHJtWE+wMec/8uj3NlQ4BlczeMKTUVYuiyHjkJD
         CbbpHx8gyEwr9GJgXBALRCnvZuZnPphkD0+TAl1mb148vgC08D6bV2kAJE8KN/CE0I5B
         BRGRMAUNuV37bZuTOecvmmmSCfmYfRlaoHNtE2IV5D2Lc8IVjdCYrezDuGWFA4MPQ5ou
         ONkKZfS1MyADbAHEjlknz7aVPg7kkGQguQRZ12NOa4D0vLm//UUpPAKjDp8Cm+v9k7iJ
         qhmnLrajZbRWBK57jIRJWp67zSlMf7JMj9BVva7rSme/+yFJREwwsDrGizp+puH2If1z
         YqnA==
X-Gm-Message-State: AGRZ1gImBLcLMh3GOaK1+Y3OAyEYG898qCmbDZrcadHmhG8bjJgWEJUY
        l/cFjcj/urEENN2e+8rXeLY=
X-Google-Smtp-Source: AJdET5cdrC2Z8R0l7z32t/BCygqfB+FEGmSRGowBIqUSVyyV7CjufZsu/2/Ta6Y2aLxuS19QHoc3MA==
X-Received: by 2002:a17:902:2909:: with SMTP id g9-v6mr26417959plb.223.1541519886904;
        Tue, 06 Nov 2018 07:58:06 -0800 (PST)
Received: from ubuntu.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id p87-v6sm48032384pfk.186.2018.11.06.07.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 07:58:06 -0800 (PST)
From:   Muchun Song <smuchun@gmail.com>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/rt: Add a check for calling update_curr_rt()
Date:   Tue,  6 Nov 2018 23:57:31 +0800
Message-Id: <20181106155731.32528-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We may dequeue prev's rt_rq in put_prev_task() only when RT
bandwidth is enabled. If RT bandwidth is disabled, it is
unnecessary for us to call update_curr_rt(). So we add a check
there.

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 kernel/sched/rt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 9aa3287ce301..7761a75d9b87 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1564,10 +1564,11 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	}
 
 	/*
-	 * We may dequeue prev's rt_rq in put_prev_task().
-	 * So, we update time before rt_queued check.
+	 * We may dequeue prev's rt_rq in put_prev_task()
+	 * only when RT bandwidth is enabled. So, we
+	 * update time before rt_queued check.
 	 */
-	if (prev->sched_class == &rt_sched_class)
+	if (rt_bandwidth_enabled() && prev->sched_class == &rt_sched_class)
 		update_curr_rt(rq);
 
 	if (!rt_rq->rt_queued)
-- 
2.17.1

