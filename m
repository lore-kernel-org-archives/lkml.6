Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C0AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB0320874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q0HfzpNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB0320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754071AbeFTPDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:03:38 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42300 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbeFTPDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:03:37 -0400
Received: by mail-pf0-f196.google.com with SMTP id w7-v6so1738757pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 08:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UJOMjbY42s9LuXyQxzFGxT8fRohl2wL0piFyBfoXYbc=;
        b=q0HfzpNNrbRxbU9nTXEG2nV4kEqa+DssoTC6rjvIUxZTYHVx9Mx5y7dYlyAwEo45eV
         XizF9bynVTwktoAExYNzURz+nYoKR/XL2ZTIgQCOyOnPZxXkNRd2mu57lfsK4w+24uZB
         9YThuYarA4iaAta1g5BEnJx2RkinnY4CvFgZFLXkHxLwTTA73Rk/LIK3pbWdLbAyc3wn
         SxLV/EsXlkI5xnXnWCfJUncm+oNGDDFqylc5G6C+7IxLOyGBFape8UsjpkCGAYqRVusr
         Ul1FsrwYs3bMaBvwTdkNGYbutw4aBvo2IaP1v6q2yL0B4isn5KRhqtTBuM+ECZ6Aybft
         pvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UJOMjbY42s9LuXyQxzFGxT8fRohl2wL0piFyBfoXYbc=;
        b=P0eFdIUPl1Qrf0ohREqjk4fb4XDMU+hx+0GAvgJWa8He17GWa0ThwgsvzI5sZGDNDK
         /Ude2vaYZE6VF2HIq+GENvxq1KvEULYCexsBu0xOZKU14VeIQBuRZjd+gdIfypvyycXj
         rjf6hE9Wno+IWg1CbVzBlEGBcvEUdQTRH9drhP32S/AVgJ27sm0afaa75QrgnTey4ZkO
         b1jM8Or9tEFVXNHPVMtabmn0Ymv1w1jaQsGEIAHTLAYs/LOKo8oFlSJ5NiozsFx6JjwR
         bsnGZ05AtyTCwn0cBe1MZNEuXqpnBlvt/RantdaMuyNn2BOnlvT3YHJ5vGBYiXGaj0JW
         CjKQ==
X-Gm-Message-State: APt69E15+wSpmCFh3IbRKk4YOQDNUGMFHNOqw2H83YlGl3ttAw3PaWsc
        D0nZi1IRDdqgJgTx+oIIPn9T0A==
X-Google-Smtp-Source: ADUXVKJkPvgaKtPv5iiUexHIssKKZ1XTsOAhaqtc2RTdDrQ3x+SY+WZnwBX+XQszi3lVd47o3gURoA==
X-Received: by 2002:a62:221a:: with SMTP id i26-v6mr23491012pfi.240.1529507015735;
        Wed, 20 Jun 2018 08:03:35 -0700 (PDT)
Received: from localhost ([2620:15c:2c4:201:f5a:7eca:440a:3ead])
        by smtp.gmail.com with ESMTPSA id g80-v6sm5753901pfd.21.2018.06.20.08.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 08:03:34 -0700 (PDT)
From:   Eric Dumazet <edumazet@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH] genirq: speedup show_interrupts()
Date:   Wed, 20 Jun 2018 08:03:32 -0700
Message-Id: <20180620150332.163320-1-edumazet@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 425a5072dcd1 ("genirq: Free irq_desc with rcu"),
show_interrupts() can be switched to rcu locking, which removes
possible contention on sparse_irq_lock.

The per_cpu count scan and print can be done without holding
desc spinlock.

And there is no need to call kstat_irqs_cpu() and abuse
irq_to_desc() while holding rcu read lock, since desc and
desc->kstat_irqs wont disappear or change.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 kernel/irq/proc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 37eda10f5c362fb173f4280fe77fd24ebc8c195f..da9addb8d655719cbd67a59e5d8535670e28f885 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -475,22 +475,24 @@ int show_interrupts(struct seq_file *p, void *v)
 		seq_putc(p, '\n');
 	}
 
-	irq_lock_sparse();
+	rcu_read_lock();
 	desc = irq_to_desc(i);
 	if (!desc)
 		goto outsparse;
 
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	for_each_online_cpu(j)
-		any_count |= kstat_irqs_cpu(i, j);
-	action = desc->action;
-	if ((!action || irq_desc_is_chained(desc)) && !any_count)
-		goto out;
+	if (desc->kstat_irqs)
+		for_each_online_cpu(j)
+			any_count |= *per_cpu_ptr(desc->kstat_irqs, j);
+
+	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
+		goto outsparse;
 
 	seq_printf(p, "%*d: ", prec, i);
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
+		seq_printf(p, "%10u ", desc->kstat_irqs ?
+					*per_cpu_ptr(desc->kstat_irqs, j) : 0);
 
+	raw_spin_lock_irqsave(&desc->lock, flags);
 	if (desc->irq_data.chip) {
 		if (desc->irq_data.chip->irq_print_chip)
 			desc->irq_data.chip->irq_print_chip(&desc->irq_data, p);
@@ -511,6 +513,7 @@ int show_interrupts(struct seq_file *p, void *v)
 	if (desc->name)
 		seq_printf(p, "-%-8s", desc->name);
 
+	action = desc->action;
 	if (action) {
 		seq_printf(p, "  %s", action->name);
 		while ((action = action->next) != NULL)
@@ -518,10 +521,9 @@ int show_interrupts(struct seq_file *p, void *v)
 	}
 
 	seq_putc(p, '\n');
-out:
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 outsparse:
-	irq_unlock_sparse();
+	rcu_read_unlock();
 	return 0;
 }
 #endif
-- 
2.18.0.rc1.244.gcf134e6275-goog

