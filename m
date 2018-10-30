Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399CEC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F5C20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="m+tguX0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F5C20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeJaD17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:27:59 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:33712 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeJaD16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:27:58 -0400
Received: by mail-it1-f196.google.com with SMTP id p11-v6so3569483itf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 11:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=34+ob0sFEhybFDfaezN8qC7dpU4f/CwKNb9IJtk6PWk=;
        b=m+tguX0CzwX4Zon4ogYPZwXdBp1jkg8v9JkETR+zu+ZkbaPiCd33OpUzP+gwqj8czF
         8nuECRUlFR8L2K7LECxCJ0K0y+muRwKYMbtiqxPwHsPv8/AHtAuyGgA1erCZGzFXD/Kj
         ptTujM6AkagSTBisw7YavJjUVALJbJ2k/E5XOxDjyBRRvkHk1r4v4/B8R62oo07tCXOd
         QBLLSIyTMFu3tlw0OwIrbwpZZxP+if4nTRBry/XRL/H0D56+PM0O8rAGr0azuKbpMkcP
         eGyPaRSOgqqh0PDV+F+crZ7QhcWxU3MdKLESPC+RMhUFovm38ioUkHyuIGOMEdam9Ji8
         02AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=34+ob0sFEhybFDfaezN8qC7dpU4f/CwKNb9IJtk6PWk=;
        b=SSbkNZx+xQ2nh85y2fFpaLNnrnA1MxCzCW9CZJ2zQQA/kJpsv7mqHdtQzGrJFqviht
         wCpFnexhjt2cWG+fKMCmqCj7iFvj1Zau0zrlnnEIX3g/HkzUIl+0PADz6UE/E/uXs6v4
         RznIkbfBotcJU//T9xCsOQeQlm5xjcJW8l2exG5HJDy9PJ8BdDHSt7ilV8pXlmyJf/LT
         YlZcIv6uSxoanD/oWMtLCHXAt3vjWc0f05VkzsDVB/RUgGFm5LrCIOGwl9Z1YUuol3j0
         HDF+fI6pVo95Ou7banBbjPs+4WCyBfDsZ+Fs68l6Z3KTTDojI46wfPWqNveLR8S/+HY6
         DDuQ==
X-Gm-Message-State: AGRZ1gLl0KHhDrkokKvJS33dYjCN2jblg3TJTNimswFCH7ilz7R8ra6x
        ZjY3oPjvdDs8+3Y7pJfbTQJPyw==
X-Google-Smtp-Source: AJdET5cl3KsNiGzxsR218xiYH+W3ub3FKlYGCLIVFJ98rsqfSb+kHSbG7YZDuzWlBMTS3hqYbe54Cw==
X-Received: by 2002:a02:e43:: with SMTP id 64-v6mr21185jae.58.1540924402168;
        Tue, 30 Oct 2018 11:33:22 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o20-v6sm4895739itc.34.2018.10.30.11.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:33:20 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 13/16] irq: add support for allocating (and affinitizing) sets of IRQs
Date:   Tue, 30 Oct 2018 12:32:49 -0600
Message-Id: <20181030183252.17857-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030183252.17857-1-axboe@kernel.dk>
References: <20181030183252.17857-1-axboe@kernel.dk>
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/pci/msi.c         | 14 ++++++++++++++
 include/linux/interrupt.h |  4 ++++
 kernel/irq/affinity.c     | 40 ++++++++++++++++++++++++++++++---------
 3 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index af24ed50a245..e6c6e10b9ceb 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1036,6 +1036,13 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (maxvec < minvec)
 		return -ERANGE;
 
+	/*
+	 * If the caller is passing in sets, we can't support a range of
+	 * vectors. The caller needs to handle that.
+	 */
+	if (affd->nr_sets && minvec != maxvec)
+		return -EINVAL;
+
 	if (WARN_ON_ONCE(dev->msi_enabled))
 		return -EINVAL;
 
@@ -1087,6 +1094,13 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 	if (maxvec < minvec)
 		return -ERANGE;
 
+	/*
+	 * If the caller is passing in sets, we can't support a range of
+	 * supported vectors. The caller needs to handle that.
+	 */
+	if (affd->nr_sets && minvec != maxvec)
+		return -EINVAL;
+
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 
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

