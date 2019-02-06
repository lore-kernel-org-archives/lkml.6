Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC81C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE37F217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="WeX1RBp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbfBFPFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:05:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55112 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730991AbfBFPFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:05:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so2821537wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9IBLfaavppi758OCjdB947t6koYFqHTGyhMEeJMJjcA=;
        b=WeX1RBp/CcBQkfXjggkfmEjTC8/LsW/ZK4tTOwMymJy0sFUXTlU5DhRI0QK3AQj7FA
         dL48Gs73dLPoVlEb5+tPZkqdYCShxowjg4MMz7qz+tGDKZ6VR5GcKMYuSuodqDPXM52B
         mIKcjGjjxjbyq4BmGlQQogkGUPeOvpiJWf8oW/CGP56Be8GFxhSXuvmCyfY+Ivyuc+Ih
         RjGvktUGafPHuD/GO2SBHflO3psKkTPDKH1oIOxSP+BTUAorx8US4ShzIo8sEChOuBXF
         kL51yLqy3ayPh+WOM2mFmxthMmVDr1rBbaZwBe2r2q1pDJYVhBq/wrOlfFUgCuJMuqvf
         GcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9IBLfaavppi758OCjdB947t6koYFqHTGyhMEeJMJjcA=;
        b=Irs8lRmf3sZPngNxmOsFlnssDhnPyc7XRIVhACJ/X+i1Q8Gs2InQAZ1HTjQW774KX7
         f85wWnqKrX5xWGe2TwEvRJ4zs1+PHk3kBsdTM9tDMHg0jXZZkA599tirdtZ/KmdDz4pB
         CZn9yL4GTWkS/v81GXKvL1eI0/NjrRL8YVoh68OqSuQdJhPeoeizZgvYQkfUhY432+mv
         S1mg3Fi9ek+JXv4A3J9GmRdnXApr3uYVDvkp8edGzRSnIkiOpQicIJgSRJJoQzxgS5Jv
         e9UV0Ki/69FmdAIhHREPOoTcCUcv2o9YL8rsLtJiDuEvJQFNWzR/GtVilsfoaxhV3oiT
         nMGQ==
X-Gm-Message-State: AHQUAubG14BaByaqUGwbV7tM810CIFNEOsuMSMZ+ZJE40XYsazYHUOIM
        MAPaM/PWg0LjtK2S8fpZZGTvWA==
X-Google-Smtp-Source: AHgI3IZv8Dc/NO0zwMnknC1uQ9e87UXxRgqhftEL5QcOBvvK2AZ4r+f++qTEdbDPzlQTI1nlLhX7hw==
X-Received: by 2002:a1c:7406:: with SMTP id p6mr3571209wmc.141.1549465529711;
        Wed, 06 Feb 2019 07:05:29 -0800 (PST)
Received: from localhost (p200300C44723CCF50E7AC8E3657171F5.dip0.t-ipconnect.de. [2003:c4:4723:ccf5:e7a:c8e3:6571:71f5])
        by smtp.gmail.com with ESMTPSA id v132sm18924789wme.20.2019.02.06.07.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 07:05:29 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] kernel: workqueue: clarify wq_worker_last_func() caller requirements
Date:   Wed,  6 Feb 2019 16:05:28 +0100
Message-Id: <20190206150528.31198-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function can only be called safely from very specific scheduler
contexts. Document those.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/workqueue.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

Andrew suggested including the explanations that came up during the
code review in the function doc. As the function has since been
merged, sending as follow-up for 5.1. Thanks!

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index fc5d23d752a5..23a67b9430da 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -918,6 +918,16 @@ struct task_struct *wq_worker_sleeping(struct task_struct *task)
  * CONTEXT:
  * spin_lock_irq(rq->lock)
  *
+ * This function is called during schedule() when a kworker is going
+ * to sleep. It's used by psi to identify aggregation workers during
+ * dequeuing, to allow periodic aggregation to shut-off when that
+ * worker is the last task in the system or cgroup to go to sleep.
+ *
+ * As this function doesn't involve any workqueue-related locking, it
+ * only returns stable values when called from inside the scheduler's
+ * queuing and dequeuing paths, when @task, which must be a kworker,
+ * is guaranteed to not be processing any works.
+ *
  * Return:
  * The last work function %current executed as a worker, NULL if it
  * hasn't executed any work yet.
-- 
2.20.1

