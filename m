Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3870C1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9D420846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQCdnI7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9D420846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753760AbeFTFuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:50:01 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39440 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeFTFt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:49:59 -0400
Received: by mail-pl0-f67.google.com with SMTP id f1-v6so1130499plt.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 22:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T9yAtOhSpTb93WVne/AQdq2Ov8Vto/SkQrnzAC3zNak=;
        b=pQCdnI7GGcHMrZavo6us2qRNgo3yxsKSYZKVIVA7TM4GaTLr2SSTtYCa7swuAmG8jn
         q8muwceQzNb6/K99WMCgASs7OcCAGhF4nO+t5/inaJ3E/jPwMbouylcev5fL2KdS9rEO
         oR/vGgArrH8DgKyQkRExKs7IBBBB448iC4Cn3CMFUMt9RiALZRMz8qKRXT9o4jBVS+2d
         Os4315ZM05W9kdpKXYJUJCo0Vmb6KXK8VRIDjMtDWwBLuKxtMDQYVMXb/tkxUv3nr/7Q
         C/ZVd+lga2Xb7nWm4aibeLs5Tf8es095PeiQgAOI8SWuhls+EuEvUUw6O5SfViIN5fqP
         u8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T9yAtOhSpTb93WVne/AQdq2Ov8Vto/SkQrnzAC3zNak=;
        b=Pl/e8nC093qM7FUEbhTI0BUXkkCW7TXPgw1uXt39xpWVwgI359HlyZ0zexBPdQp4g4
         iX0wBK0btuggBfJZDO0IfQ3+qzRUDLgqMBzjQR0xOCzvi1W5anE1ZmyWLllmi1Fn25MW
         kIyxL+m3DPoZwQsij5RyiOkf3D4QLAjFtUUxY25jILvh+0kx2Mu2ilvzwWz8eubk3Lic
         DHIvAZ7HpjsQQrwPvItEVMqafSltk5FJ5O6ZaZ4fSv/XWRa4JJW7zXI24xehp2yF0Yx8
         3PTJKsTGN1qG2R61R2VdaEv9CAi8iknXKyeaF15ghXqL67ugjpHupMGKGeXyFeUce/nK
         hOEQ==
X-Gm-Message-State: APt69E2I7jjSGCUn6dQlKl8fpzo+05AVgQ5qnyQi2bNDbFrgocd0NBhj
        yotbDOGXpcc+3L9jhoynwMVe599O
X-Google-Smtp-Source: ADUXVKJAXjqM9YP7GRsfXkUYr3m/SXYKPnLBWoHalXAQDZNxfgxGdMTDOgAvOhnimhRttfCp9h4xJA==
X-Received: by 2002:a17:902:9f81:: with SMTP id g1-v6mr20813716plq.304.1529473799057;
        Tue, 19 Jun 2018 22:49:59 -0700 (PDT)
Received: from ubuntu.AD.HARMAN.COM ([106.206.6.177])
        by smtp.gmail.com with ESMTPSA id k69-v6sm2107518pgc.39.2018.06.19.22.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jun 2018 22:49:57 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linuxtronix.de, gregkh@linuxfoundation.org,
        Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH] proc: use ktime_get_coarse_boottime64
Date:   Wed, 20 Jun 2018 11:19:40 +0530
Message-Id: <1529473780-19852-1-git-send-email-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_monotonic_boottime() has been deprecated and might not be
safe to call in every context.

Change to use ktime_get_coarse_boottime_ts64.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 fs/proc/uptime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
index 3f723cb..17c6fff 100644
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -9,7 +9,7 @@
 
 static int uptime_proc_show(struct seq_file *m, void *v)
 {
-	struct timespec uptime;
+	struct timespec64 uptime;
 	struct timespec64 idle;
 	u64 nsec;
 	u32 rem;
@@ -19,7 +19,7 @@ static int uptime_proc_show(struct seq_file *m, void *v)
 	for_each_possible_cpu(i)
 		nsec += (__force u64) kcpustat_cpu(i).cpustat[CPUTIME_IDLE];
 
-	get_monotonic_boottime(&uptime);
+	ktime_get_coarse_boottime_ts64(&uptime);
 	idle.tv_sec = div_u64_rem(nsec, NSEC_PER_SEC, &rem);
 	idle.tv_nsec = rem;
 	seq_printf(m, "%lu.%02lu %lu.%02lu\n",
-- 
2.7.4

