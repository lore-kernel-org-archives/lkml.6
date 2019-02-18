Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1951FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD59A21736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbfBRK0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:26:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39915 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbfBRK0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:26:33 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1IAPpdM2530687
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 18 Feb 2019 02:25:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1IAPo0m2530683;
        Mon, 18 Feb 2019 02:25:50 -0800
Date:   Mon, 18 Feb 2019 02:25:50 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-0145c30e896d26e638d27c957d9eed72893c1c92@git.kernel.org>
Cc:     shivasharan.srikanteshwara@broadcom.com, axboe@kernel.dk,
        sagi@grimberg.me, hch@lst.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, marc.zyngier@arm.com, keith.busch@intel.com,
        sumit.saxena@broadcom.com, hpa@zytor.com,
        kashyap.desai@broadcom.com, tglx@linutronix.de, helgaas@kernel.org,
        ming.lei@redhat.com
Reply-To: shivasharan.srikanteshwara@broadcom.com,
          linux-kernel@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
          sagi@grimberg.me, mingo@kernel.org, marc.zyngier@arm.com,
          keith.busch@intel.com, kashyap.desai@broadcom.com, hpa@zytor.com,
          sumit.saxena@broadcom.com, tglx@linutronix.de,
          helgaas@kernel.org, ming.lei@redhat.com
In-Reply-To: <20190216172228.336424556@linutronix.de>
References: <20190216172228.336424556@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/affinity: Code consolidation
Git-Commit-ID: 0145c30e896d26e638d27c957d9eed72893c1c92
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0145c30e896d26e638d27c957d9eed72893c1c92
Gitweb:     https://git.kernel.org/tip/0145c30e896d26e638d27c957d9eed72893c1c92
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sat, 16 Feb 2019 18:13:07 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 18 Feb 2019 11:21:27 +0100

genirq/affinity: Code consolidation

All information and calculations in the interrupt affinity spreading code
is strictly unsigned int. Though the code uses int all over the place.

Convert it over to unsigned int.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Shivasharan Srikanteshwara <shivasharan.srikanteshwara@broadcom.com>
Link: https://lkml.kernel.org/r/20190216172228.336424556@linutronix.de

---
 include/linux/interrupt.h | 20 +++++++++--------
 kernel/irq/affinity.c     | 56 +++++++++++++++++++++++------------------------
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 4a728dba02e2..35e7389c2011 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -251,10 +251,10 @@ struct irq_affinity_notify {
  * @sets:		Number of affinitized sets
  */
 struct irq_affinity {
-	int	pre_vectors;
-	int	post_vectors;
-	int	nr_sets;
-	int	*sets;
+	unsigned int	pre_vectors;
+	unsigned int	post_vectors;
+	unsigned int	nr_sets;
+	unsigned int	*sets;
 };
 
 /**
@@ -314,9 +314,10 @@ extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 
 struct irq_affinity_desc *
-irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
+irq_create_affinity_masks(unsigned int nvec, const struct irq_affinity *affd);
 
-int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd);
+unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
+				       const struct irq_affinity *affd);
 
 #else /* CONFIG_SMP */
 
@@ -350,13 +351,14 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 }
 
 static inline struct irq_affinity_desc *
-irq_create_affinity_masks(int nvec, const struct irq_affinity *affd)
+irq_create_affinity_masks(unsigned int nvec, const struct irq_affinity *affd)
 {
 	return NULL;
 }
 
-static inline int
-irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd)
+static inline unsigned int
+irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
+			  const struct irq_affinity *affd)
 {
 	return maxvec;
 }
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 118b66d64a53..82e8799374e9 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -9,7 +9,7 @@
 #include <linux/cpu.h>
 
 static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
-				int cpus_per_vec)
+				unsigned int cpus_per_vec)
 {
 	const struct cpumask *siblmsk;
 	int cpu, sibl;
@@ -95,15 +95,17 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
 }
 
 static int __irq_build_affinity_masks(const struct irq_affinity *affd,
-				      int startvec, int numvecs, int firstvec,
+				      unsigned int startvec,
+				      unsigned int numvecs,
+				      unsigned int firstvec,
 				      cpumask_var_t *node_to_cpumask,
 				      const struct cpumask *cpu_mask,
 				      struct cpumask *nmsk,
 				      struct irq_affinity_desc *masks)
 {
-	int n, nodes, cpus_per_vec, extra_vecs, done = 0;
-	int last_affv = firstvec + numvecs;
-	int curvec = startvec;
+	unsigned int n, nodes, cpus_per_vec, extra_vecs, done = 0;
+	unsigned int last_affv = firstvec + numvecs;
+	unsigned int curvec = startvec;
 	nodemask_t nodemsk = NODE_MASK_NONE;
 
 	if (!cpumask_weight(cpu_mask))
@@ -117,18 +119,16 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
 	 */
 	if (numvecs <= nodes) {
 		for_each_node_mask(n, nodemsk) {
-			cpumask_or(&masks[curvec].mask,
-					&masks[curvec].mask,
-					node_to_cpumask[n]);
+			cpumask_or(&masks[curvec].mask, &masks[curvec].mask,
+				   node_to_cpumask[n]);
 			if (++curvec == last_affv)
 				curvec = firstvec;
 		}
-		done = numvecs;
-		goto out;
+		return numvecs;
 	}
 
 	for_each_node_mask(n, nodemsk) {
-		int ncpus, v, vecs_to_assign, vecs_per_node;
+		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
 
 		/* Spread the vectors per node */
 		vecs_per_node = (numvecs - (curvec - firstvec)) / nodes;
@@ -163,8 +163,6 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
 			curvec = firstvec;
 		--nodes;
 	}
-
-out:
 	return done;
 }
 
@@ -174,13 +172,14 @@ out:
  *	2) spread other possible CPUs on these vectors
  */
 static int irq_build_affinity_masks(const struct irq_affinity *affd,
-				    int startvec, int numvecs, int firstvec,
+				    unsigned int startvec, unsigned int numvecs,
+				    unsigned int firstvec,
 				    struct irq_affinity_desc *masks)
 {
-	int curvec = startvec, nr_present, nr_others;
-	int ret = -ENOMEM;
-	cpumask_var_t nmsk, npresmsk;
+	unsigned int curvec = startvec, nr_present, nr_others;
 	cpumask_var_t *node_to_cpumask;
+	cpumask_var_t nmsk, npresmsk;
+	int ret = -ENOMEM;
 
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return ret;
@@ -239,12 +238,10 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
  * Returns the irq_affinity_desc pointer or NULL if allocation failed.
  */
 struct irq_affinity_desc *
-irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
+irq_create_affinity_masks(unsigned int nvecs, const struct irq_affinity *affd)
 {
-	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
-	int curvec, usedvecs;
+	unsigned int affvecs, curvec, usedvecs, nr_sets, i;
 	struct irq_affinity_desc *masks = NULL;
-	int i, nr_sets;
 
 	/*
 	 * If there aren't any vectors left after applying the pre/post
@@ -264,16 +261,17 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	 * Spread on present CPUs starting from affd->pre_vectors. If we
 	 * have multiple sets, build each sets affinity mask separately.
 	 */
+	affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
 	nr_sets = affd->nr_sets;
 	if (!nr_sets)
 		nr_sets = 1;
 
 	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
-		int this_vecs = affd->sets ? affd->sets[i] : affvecs;
+		unsigned int this_vecs = affd->sets ? affd->sets[i] : affvecs;
 		int ret;
 
 		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
-						curvec, masks);
+					       curvec, masks);
 		if (ret) {
 			kfree(masks);
 			return NULL;
@@ -303,17 +301,17 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
  * @maxvec:	The maximum number of vectors available
  * @affd:	Description of the affinity requirements
  */
-int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd)
+unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
+				       const struct irq_affinity *affd)
 {
-	int resv = affd->pre_vectors + affd->post_vectors;
-	int vecs = maxvec - resv;
-	int set_vecs;
+	unsigned int resv = affd->pre_vectors + affd->post_vectors;
+	unsigned int set_vecs;
 
 	if (resv > minvec)
 		return 0;
 
 	if (affd->nr_sets) {
-		int i;
+		unsigned int i;
 
 		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
 			set_vecs += affd->sets[i];
@@ -323,5 +321,5 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
 		put_online_cpus();
 	}
 
-	return resv + min(set_vecs, vecs);
+	return resv + min(set_vecs, maxvec - resv);
 }
