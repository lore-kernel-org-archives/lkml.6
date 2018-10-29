Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2458C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972E220657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AIPNHXKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972E220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbeJ3B13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:27:29 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54900 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbeJ3B13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:27:29 -0400
Received: by mail-it1-f195.google.com with SMTP id d6so4718660itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eukhLpnpSqFgkXd6fwxIBdknpGfhnAOi4PUxG7MjAPc=;
        b=AIPNHXKuRPpEDkKj0gOHLJv8h1wUyO1OQ649DAib/5VXwcfXfApINpexfzi/OEmyWM
         ByVl2GjNjeRztMNXg8Nyfy9/yUcgo6B7WCKskznq3ja+rMAiKsLtT8+g+TMxf2Wdzmre
         DY0XBnYmjCeq3goRB6agwt8eSaoAMvG3tbN9sCh8tKkk4woixyCzuoZjlcvT/QtQEQAy
         gZl2tI48OD3FxQU1SElBNX8arISa5ZFZWUQNjHJV9BtYIRZhF3hK7Ug1nmHFsSk20/Oa
         JOpmGFtEhvRgHRRU6Kd5uIpJandGXpTdZ6u4nVS9tcyLrM+E00tOx/lSfWerxze27lof
         QMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eukhLpnpSqFgkXd6fwxIBdknpGfhnAOi4PUxG7MjAPc=;
        b=CiCzEufDcGC8bmW7k7EDQIsGIUVEh591YS2MFdkS5RWF8iPKav1mu1JASPJXLeqXee
         7DX4zkXyi5nApSZZzbu7jRf1kgrd9OIAWKNxyd5dqO4e1HBvUCEXEUDuGWsoHIuCxHnk
         LxHG602l4hDBiSkqmRCcLRShRETzjTNvzRBh96zwFj8hsYoim8Tr9miekou3jtLjxDfl
         QoR7E/EivuZ29RxexLyipfpPfQjTSUmKcQBDAbQ2EO162rJ6pdk3JqxZood65UmokeTs
         Otg/Vw2M+ovTpMUixPyVcjFOXtHiQr3GTH1xdegdcAhjh1Tmq9SLabLItqp2LGZKKFBW
         KH8w==
X-Gm-Message-State: AGRZ1gKrzm7BCEmDXUOGymQYUoON8XpY8S1WHwnbzdXisMDFfAOleZAc
        FhYKtwg461ktuj3F7B2iQyO8bA==
X-Google-Smtp-Source: AJdET5fd+fbMZ5osHM5Yz/a2ZBO184Xx/g/2uQxElWT1m4lx66oTjIL/cDOBeMax1x6UOI1kliXEJg==
X-Received: by 2002:a02:3b2c:: with SMTP id c44-v6mr10944100jaa.31.1540831087063;
        Mon, 29 Oct 2018 09:38:07 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q15-v6sm3367019itc.38.2018.10.29.09.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:38:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 11/14] irq: add support for allocating (and affinitizing) sets of IRQs
Date:   Mon, 29 Oct 2018 10:37:35 -0600
Message-Id: <20181029163738.10172-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029163738.10172-1-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A driver may have a need to allocate multiple sets of MSI/MSI-X
interrupts, and have them appropriately affinitized. Add support for
defining a number of sets in the irq_affinity structure, of varying
sizes, and get each set affinitized correctly across the machine.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/interrupt.h |  4 ++++
 kernel/irq/affinity.c     | 40 ++++++++++++++++++++++++++++++---------
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 1d6711c28271..ca397ff40836 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -247,10 +247,14 @@ struct irq_affinity_notify {
  *			the MSI(-X) vector space
  * @post_vectors:	Don't apply affinity to @post_vectors at end of
  *			the MSI(-X) vector space
+ * @nr_sets:		Length of passed in *sets array
+ * @sets:		Number of affinitized sets
  */
 struct irq_affinity {
 	int	pre_vectors;
 	int	post_vectors;
+	int	nr_sets;
+	int	*sets;
 };
 
 #if defined(CONFIG_SMP)
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f4f29b9d90ee..2046a0f0f0f1 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -180,6 +180,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	int curvec, usedvecs;
 	cpumask_var_t nmsk, npresmsk, *node_to_cpumask;
 	struct cpumask *masks = NULL;
+	int i, nr_sets;
 
 	/*
 	 * If there aren't any vectors left after applying the pre/post
@@ -210,10 +211,23 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	get_online_cpus();
 	build_node_to_cpumask(node_to_cpumask);
 
-	/* Spread on present CPUs starting from affd->pre_vectors */
-	usedvecs = irq_build_affinity_masks(affd, curvec, affvecs,
-					    node_to_cpumask, cpu_present_mask,
-					    nmsk, masks);
+	/*
+	 * Spread on present CPUs starting from affd->pre_vectors. If we
+	 * have multiple sets, build each sets affinity mask separately.
+	 */
+	nr_sets = affd->nr_sets;
+	if (!nr_sets)
+		nr_sets = 1;
+
+	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
+		int this_vecs = affd->sets ? affd->sets[i] : affvecs;
+		int nr;
+
+		nr = irq_build_affinity_masks(affd, curvec, this_vecs,
+					      node_to_cpumask, cpu_present_mask,
+					      nmsk, masks + usedvecs);
+		usedvecs += nr;
+	}
 
 	/*
 	 * Spread on non present CPUs starting from the next vector to be
@@ -258,13 +272,21 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
 {
 	int resv = affd->pre_vectors + affd->post_vectors;
 	int vecs = maxvec - resv;
-	int ret;
+	int set_vecs;
 
 	if (resv > minvec)
 		return 0;
 
-	get_online_cpus();
-	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs) + resv;
-	put_online_cpus();
-	return ret;
+	if (affd->nr_sets) {
+		int i;
+
+		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
+			set_vecs += affd->sets[i];
+	} else {
+		get_online_cpus();
+		set_vecs = cpumask_weight(cpu_possible_mask);
+		put_online_cpus();
+	}
+
+	return resv + min(set_vecs, vecs);
 }
-- 
2.17.1

