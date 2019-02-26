Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1165DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BFC2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjsdSHs+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfBZKEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:04:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44174 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbfBZKD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:03:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id c4so5986530pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 02:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G+RoZDxlii0BAcLmyBvk41Q9KarsmkZs6L5a3xycMNU=;
        b=LjsdSHs+75hR4YMRpX5dlkFy/quBDym0yZiCOoiOsShEiZjCuajCXAzkAwBIOeJsqK
         APZ149PKFm2w0uN0AautxjQtRdRXQrLXqqGF4WuP9N10diBTcK1Tb76WIJ4p1pJwuRUI
         o439+lueTx8x/kGftsHqOlAbErOn8hkS2TrtN/Kouz03/waYvFgC3dOO2usHkr1ItmV1
         KuUY6MraZSOqOcs39I7TsvLPT1L5q7PaZRNCDRcA64LlZqxuXzp80UkYVjUQcTUZZdy9
         l6KUQcY5kVpebUlqUYmQyCgg21wWzfHSrnbwwKXQtbO6grbLlKA6vySuNHxCI08ZUczF
         Pwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G+RoZDxlii0BAcLmyBvk41Q9KarsmkZs6L5a3xycMNU=;
        b=XsiCFQMDG9WLvyR70yT4FJ9XEVgu/qC9057D7qj/GaMNuBVLTmMJIpm9VoZ/Tyr/ZA
         XnwtSfPEq6UcjCyQTW1f+KeNngj4/GXl7qwoWhoNMYnHlho6pvcSjLMCpsvqwSykElOY
         +qO3gZQMTYOTm2DGuOW1uReuCkeeQEcNxKPkTVi8hjPzNDmHumcUR0DJp3Uylpo3z6Ab
         Tb5r7mPF/L0T0+cAAZ1gEOCsLeDMYx7iuIaDNzuXnYou119nQ4euKn9Vo8IYvZhBgs8F
         n3NWWyhP910d5U8PHSss3lpSUGU1fGvM5f5yNkaolyr0RPHICEbzfPwKY8jH4G7sTiLd
         TQKQ==
X-Gm-Message-State: AHQUAub52LelnvCGKJ19nuo0KYg/vt/HHQiBMpn13tU8qo3bFmLL5JJI
        aHi+0eaWOmpbm7l9xMA7pL/u++zn8As=
X-Google-Smtp-Source: AHgI3Ia7jbIe5Ehd5Z0f1m38sM3gn0Hypem98Z0PKI1s7qLYZj/D2ztfhD2EvEHsFAlAulrCL1xupw==
X-Received: by 2002:a17:902:9b90:: with SMTP id y16mr25622839plp.0.1551175435694;
        Tue, 26 Feb 2019 02:03:55 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id y6sm12045520pfy.87.2019.02.26.02.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 02:03:55 -0800 (PST)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 8/8] locking/lockdep: Consider zapped locks when printing lock chains in /proc
Date:   Tue, 26 Feb 2019 18:03:27 +0800
Message-Id: <20190226100327.19340-9-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190226100327.19340-1-duyuyang@gmail.com>
References: <20190226100327.19340-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not rare to spot empty lock chains in /proc/lockdep_chains, where only
shows irq_context but not the locks, which is useless and makes people
confused.

This happens because the chained lock classes are freeed, so consider this
when printing the lock chains.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep_proc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 3d31f9b..47a6f4f 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -127,7 +127,7 @@ static int lc_show(struct seq_file *m, void *v)
 {
 	struct lock_chain *chain = v;
 	struct lock_class *class;
-	int i;
+	int i, nr_locks = 0;
 
 	if (v == SEQ_START_TOKEN) {
 		if (nr_chain_hlocks > MAX_LOCKDEP_CHAIN_HLOCKS)
@@ -136,18 +136,28 @@ static int lc_show(struct seq_file *m, void *v)
 		return 0;
 	}
 
-	seq_printf(m, "irq_context: %d\n", chain->irq_context);
-
 	for (i = 0; i < chain->depth; i++) {
 		class = lock_chain_get_class(chain, i);
+		/*
+		 * Is this lock class zapped?
+		 */
 		if (!class->key)
 			continue;
 
+		if (!nr_locks++)
+			seq_printf(m, "irq_context: %d\n", chain->irq_context);
+
 		seq_printf(m, "[%p] ", class->key);
 		print_name(m, class);
 		seq_puts(m, "\n");
 	}
-	seq_puts(m, "\n");
+
+	if (nr_locks) {
+		if (nr_locks != chain->depth)
+			seq_printf(m, "(chain has %d zapped classes)\n",
+				   chain->depth - nr_locks);
+		seq_puts(m, "\n");
+	}
 
 	return 0;
 }
-- 
1.8.3.1

