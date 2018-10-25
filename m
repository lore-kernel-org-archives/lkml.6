Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831DDC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241162082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ly4bcscD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241162082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeJZFvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:51:11 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35302 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeJZFvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:51:10 -0400
Received: by mail-io1-f68.google.com with SMTP id 79-v6so6422757iou.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 14:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RdTXcoUkTq5K7EWsZETMPuhG8fwGUygYDmWiHM5puJA=;
        b=Ly4bcscD6GbJCU7u76fx+8s8P4RCvOwcwJT5eRNpl6oZoKjfoLhBIM36L9RmsV1/6S
         iPLeVklwGnoYEVi74HNR2YbckDz4aeU6gGLWfPzNKFKl9sRHwFL47vQC5ce04fsxUU4E
         mfNZ4tfC8pmTplQnDNiThB5pGFWU1SwLKrdFyQKHuK7OxD4zOc9iUS7vq1Z6HpD+vHnD
         Vi1pKp/sonPsfbaIGSlcrGxiEx0NeNEzHx4tftVPJkCy0d6S2oj4Ah0aBjfPWCdelW+3
         MsQbxdHRW8HPdhsfQFRz/jHKXcqY8t07sB54SaAqJLoum1WdU2nwnByi6E9jUn0bn2k6
         ckpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RdTXcoUkTq5K7EWsZETMPuhG8fwGUygYDmWiHM5puJA=;
        b=T9REwxCWYUSZVtNEAayctgp34EuGObe0XGVchIt6GsZTxyFBMO/+x7pBJtb1V/0zLW
         7t6aWIf7snGDEX3Jt1hweqLV4gG2kyWCoMKWWbZrweRkkDJr1XzoCo99W+9sVcsmfBuy
         bFj1vyndGKnL9nFGBq/qQt+B2XdQ8V3Fq0MrgEXGH2AtXU7DfME1pOwxbZosjnv7i1Sv
         zpmks+xJC4PAnZkQY63TZzAwOapLFoZcciJPBo6c4D/NuPiy9kop8a2SWOoVZE/Y0GlU
         cKcei+SgxIsWnCc8novwtTjT99Y5ykwd6o5HbZ0rRnrZOsyTB0EhDGKQhnzZjlgJ3DdQ
         R/FA==
X-Gm-Message-State: AGRZ1gKv++1Nezs7SNQfswR6hrYFsiCOFVSvbM9GfS1NQN5fgRM/9jER
        v4J5+nkYXe/CEg7oqjdQpFkH+w==
X-Google-Smtp-Source: AJdET5cgnM6sQbxJI0Q4G2lSyYMQgtEy3+C0fQnrbJ+j+6BoQ6Hi9E5iJpj1WP7e6Qe0oRWlvhRqsg==
X-Received: by 2002:a6b:6201:: with SMTP id f1-v6mr576095iog.11.1540502210964;
        Thu, 25 Oct 2018 14:16:50 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l23-v6sm2831890ioj.40.2018.10.25.14.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 14:16:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] irq: add support for allocating (and affinitizing) sets of IRQs
Date:   Thu, 25 Oct 2018 15:16:23 -0600
Message-Id: <20181025211626.12692-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025211626.12692-1-axboe@kernel.dk>
References: <20181025211626.12692-1-axboe@kernel.dk>
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
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/interrupt.h |  4 ++++
 kernel/irq/affinity.c     | 31 +++++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index eeceac3376fc..9fce2131902c 100644
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
index f4f29b9d90ee..0055e252e438 100644
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
@@ -258,13 +272,18 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
 {
 	int resv = affd->pre_vectors + affd->post_vectors;
 	int vecs = maxvec - resv;
+	int i, set_vecs;
 	int ret;
 
 	if (resv > minvec)
 		return 0;
 
 	get_online_cpus();
-	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs) + resv;
+	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs);
 	put_online_cpus();
-	return ret;
+
+	for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
+		set_vecs += affd->sets[i];
+
+	return resv + max(ret, set_vecs);
 }
-- 
2.17.1

