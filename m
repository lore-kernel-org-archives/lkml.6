Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEEEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 22:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751742084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 22:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="wqoiumwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751742084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbeKZJd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 04:33:26 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33571 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKZJd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 04:33:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so5232659pgu.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 14:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=K4TUz32cIIhqvLy9aozJf9E4I+SHSNvQ4IELAYlxGVg=;
        b=wqoiumwRfY24rRYwjuj+u8E4w34KFkLuSsq8cndofVg7+Q6xegOOBbSdxEKfSO8dPW
         zrbnjlyxY/yy7bTcVd5nxjS+7uDs9WOnmaLOIYu6ToTai8dRlzsX33VD+88O3Yq21xga
         JZqAbXURdaCD8p6hPweC+s7zRKb9HcMfjkHhrWbpGTpP4cYYJXMGjbHlmNUD4dfg/faf
         bT1wD44OqiVkiYTtcHyfqTNRLL2EQ1sTXHyFc2tEJn8w+kRJWBKFdmB5QnHpRddT3qRF
         c5pGwZEst8Qcg0n091XoymtieGaCn25vSCIaeZ5xmsQplyrBzqUk31TMUgnovcocdrLE
         MYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K4TUz32cIIhqvLy9aozJf9E4I+SHSNvQ4IELAYlxGVg=;
        b=Q+bsz0eQ7mkeulzzTOujrLUpR7xYUdNYjizZIm62L12oc2J2HEHUKp8obwHZR5uOA+
         3t3rXzSl2mvF88rX/uJ8VzlWeVK0cLiC2MRPrFqZxLeRf7ZIj65dWEw63/inMSX6WNjq
         lQa793NOFbXYAJrJs+UUrxwMWVbGi15HU+irzTKsLC14WU7swgQH8OUuDhpQresLwoS2
         n6NpCYjs5sEVeYnf5FsZB5JhNaGFgp+bqxuOuyaLlLnJHr6yp6IfiKxQ4kDiZ0tPxksy
         HsVYGQ7EPRUBxeEx+m9uQs9PzWzVPx35lESZ3GRaXLItsucIEP+TMqWaMM1tx4bnpth3
         5NRw==
X-Gm-Message-State: AGRZ1gIXAKAkfQJl9hcX9xybaGJV8tppgsSHJUK34QsVm4AInH8qMK8Y
        t7TVgRlB7cokhAJwdVIUGB0AjA==
X-Google-Smtp-Source: AJdET5cP2iH5FQQH/txY7NaJtzLsfv4Qkk41pCDrO9rSVrBHjVGTYnQeaPbOG6EzmVBvdMJl5xMmbA==
X-Received: by 2002:a62:db41:: with SMTP id f62mr25656920pfg.123.1543185676046;
        Sun, 25 Nov 2018 14:41:16 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id m65sm7568463pfg.180.2018.11.25.14.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 14:41:14 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Muchun Song <smuchun@gmail.com>, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] sched/fair: Fix warning on non-SMP build
Date:   Sun, 25 Nov 2018 14:41:05 -0800
Message-Id: <20181125224105.123568-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Caused by making the variable static:

kernel/sched/fair.c:119:21: warning: 'capacity_margin' defined but not used [-Wunused-variable]

Seems easiest to just move it up under the existing ifdef CONFIG_SMP
that's a few lines above.

Fixes: ed8885a14433a ('sched/fair: Make some variables static')
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 kernel/sched/fair.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e30dea59d215d..d25211f45c671 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -94,6 +94,14 @@ int __weak arch_asym_cpu_priority(int cpu)
 {
 	return -cpu;
 }
+
+/*
+ * The margin used when comparing utilization with CPU capacity:
+ * util * margin < capacity * 1024
+ *
+ * (default: ~20%)
+ */
+static unsigned int capacity_margin			= 1280;
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -110,14 +118,6 @@ int __weak arch_asym_cpu_priority(int cpu)
 unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
 #endif
 
-/*
- * The margin used when comparing utilization with CPU capacity:
- * util * margin < capacity * 1024
- *
- * (default: ~20%)
- */
-static unsigned int capacity_margin			= 1280;
-
 static inline void update_load_add(struct load_weight *lw, unsigned long inc)
 {
 	lw->weight += inc;
-- 
2.11.0

