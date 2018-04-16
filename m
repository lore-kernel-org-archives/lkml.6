Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2210789-1523851840-2-5588606681725454524
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523851839; b=QHmONHSDAf+HgqTCukgIznZ/RQDb6NRYAdi7TeNBgfU1XaDTU4
    susMmoRtfNCeiG6RYfeuyUSgms+kmimW/y7o7u5S9sfGvzfkchYPESOSmjPkJ8iB
    nTMxsHUqIa538aQbd6YIOJksvwhlm62mXEpJEVEgXMRWtKt3o/kfVek2UOtWP8Ns
    VE78DIaat2Sq3YdbW9KdwbAdTMd8g9jXFDbdAGamFb0EjoN7Q2I/mUPAFEv71ryZ
    NDrodEdvzKBxzH7DIGEddQAdG75BiFKxNkEw+OEZ2kO2yndNxdCYY+spynE5yIx5
    gdvDT4i1OXNh0/xChZo3RNLuN3Aq4d091QEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851839; bh=7X+RU
    ibXvL+I5Qzi9K5ns9o361J6YRa9rxyuqv0qHI0=; b=FFRL32qLQdJEzNaGwM7k7
    DnK5UBB9Z2QDmILgTOlrNNMGRn0cqw0p+lCM+Kmexra7PcJy2SBcxI+cWO7a9Fl0
    jZLUVmkBdXNuOIitAbst3Lx+s8q88i2vTLMnIxPkwhKO9KYiSPTrETf/QUN7uHxt
    kqx/11e1u1cVD7sQWIefgLpZUiIkl66QiVWAP3TseRPktsqeT0XaErbEgVNHIdRj
    5k8Ogv+es2WoJqBmh+VEHvm5ZzeBhnC8QRzz2FwQAZfw20FiwTwKhEYlwL1oex7e
    KnfuNYDsYvFIpo6q9Xlh1fHGYTCqnX/HUrxCAhCuEjLTJuYUl883ANjm4UoRcVxB
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDjkhQYk9Ujj6rj8O7vimklMs2g6k/SCew12shCipXWLBL/5PCin6HY5/yCLkaODLV7IWnFTIVx7Bdaxi1V42IAXiPxFhDtntPwyEr8Fkzx6l9YZ4m/v
    bX0vwD5K3ThYF84qCAArOU1HtJAtn/shJB9rcghemU51q2epbnIESUlAiT4jGwJhCJJf0xerhez/mv1RLGf5H9b0q3mrrc6Hay93Gi6qZh4NAoSZAFXxTOX5
    SfXXe74BZtjGdwViYmLFew==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=eJfxgxciAAAA:8 a=HHGDD-5mAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=j0Y9XfXtp42peMgDJBgA:9 a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22
    a=xM9caqqi1sUkTy8OJ5Uh:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 09/25] staging: lustre: libcfs: use distance in cpu and node
 handling
Date: Mon, 16 Apr 2018 00:09:51 -0400
Message-Id: <1523851807-16573-10-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
References: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Amir Shehata <amir.shehata@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Amir Shehata <amir.shehata@intel.com>

Take into consideration the location of NUMA nodes and core
when calling cfs_cpt_[un]set_cpu() and cfs_cpt_[un]set_node().
This enables functioning on platforms with 100s of cores and
NUMA nodes.

Signed-off-by: Amir Shehata <amir.shehata@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-7734
Reviewed-on: http://review.whamcloud.com/18916
Reviewed-by: Olaf Weber <olaf@sgi.com>
Reviewed-by: Doug Oucharek <dougso@me.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 .../staging/lustre/lnet/libcfs/linux/linux-cpu.c   | 192 +++++++++++++++------
 1 file changed, 143 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index 1e184b1..bbf89b8 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -300,11 +300,134 @@ unsigned int cfs_cpt_distance(struct cfs_cpt_table *cptab, int cpt1, int cpt2)
 }
 EXPORT_SYMBOL(cfs_cpt_distance);
 
+/*
+ * Calculate the maximum NUMA distance between all nodes in the
+ * from_mask and all nodes in the to_mask.
+ */
+static unsigned int cfs_cpt_distance_calculate(nodemask_t *from_mask,
+					       nodemask_t *to_mask)
+{
+	unsigned int maximum;
+	unsigned int distance;
+	int from;
+	int to;
+
+	maximum = 0;
+	for_each_node_mask(from, *from_mask) {
+		for_each_node_mask(to, *to_mask) {
+			distance = node_distance(from, to);
+			if (maximum < distance)
+				maximum = distance;
+		}
+	}
+	return maximum;
+}
+
+static void cfs_cpt_add_cpu(struct cfs_cpt_table *cptab, int cpt, int cpu)
+{
+	cptab->ctb_cpu2cpt[cpu] = cpt;
+
+	cpumask_set_cpu(cpu, cptab->ctb_cpumask);
+	cpumask_set_cpu(cpu, cptab->ctb_parts[cpt].cpt_cpumask);
+}
+
+static void cfs_cpt_del_cpu(struct cfs_cpt_table *cptab, int cpt, int cpu)
+{
+	cpumask_clear_cpu(cpu, cptab->ctb_parts[cpt].cpt_cpumask);
+	cpumask_clear_cpu(cpu, cptab->ctb_cpumask);
+
+	cptab->ctb_cpu2cpt[cpu] = -1;
+}
+
+static void cfs_cpt_add_node(struct cfs_cpt_table *cptab, int cpt, int node)
+{
+	struct cfs_cpu_partition *part;
+
+	if (!node_isset(node, *cptab->ctb_nodemask)) {
+		unsigned int dist;
+
+		/* first time node is added to the CPT table */
+		node_set(node, *cptab->ctb_nodemask);
+		cptab->ctb_node2cpt[node] = cpt;
+
+		dist = cfs_cpt_distance_calculate(cptab->ctb_nodemask,
+						  cptab->ctb_nodemask);
+		cptab->ctb_distance = dist;
+	}
+
+	part = &cptab->ctb_parts[cpt];
+	if (!node_isset(node, *part->cpt_nodemask)) {
+		int cpt2;
+
+		/* first time node is added to this CPT */
+		node_set(node, *part->cpt_nodemask);
+		for (cpt2 = 0; cpt2 < cptab->ctb_nparts; cpt2++) {
+			struct cfs_cpu_partition *part2;
+			unsigned int dist;
+
+			part2 = &cptab->ctb_parts[cpt2];
+			dist = cfs_cpt_distance_calculate(part->cpt_nodemask,
+							  part2->cpt_nodemask);
+			part->cpt_distance[cpt2] = dist;
+			dist = cfs_cpt_distance_calculate(part2->cpt_nodemask,
+							  part->cpt_nodemask);
+			part2->cpt_distance[cpt] = dist;
+		}
+	}
+}
+
+static void cfs_cpt_del_node(struct cfs_cpt_table *cptab, int cpt, int node)
+{
+	struct cfs_cpu_partition *part = &cptab->ctb_parts[cpt];
+	int cpu;
+
+	for_each_cpu(cpu, part->cpt_cpumask) {
+		/* this CPT has other CPU belonging to this node? */
+		if (cpu_to_node(cpu) == node)
+			break;
+	}
+
+	if (cpu >= nr_cpu_ids && node_isset(node,  *part->cpt_nodemask)) {
+		int cpt2;
+
+		/* No more CPUs in the node for this CPT. */
+		node_clear(node, *part->cpt_nodemask);
+		for (cpt2 = 0; cpt2 < cptab->ctb_nparts; cpt2++) {
+			struct cfs_cpu_partition *part2;
+			unsigned int dist;
+
+			part2 = &cptab->ctb_parts[cpt2];
+			if (node_isset(node, *part2->cpt_nodemask))
+				cptab->ctb_node2cpt[node] = cpt2;
+
+			dist = cfs_cpt_distance_calculate(part->cpt_nodemask,
+							  part2->cpt_nodemask);
+			part->cpt_distance[cpt2] = dist;
+			dist = cfs_cpt_distance_calculate(part2->cpt_nodemask,
+							  part->cpt_nodemask);
+			part2->cpt_distance[cpt] = dist;
+		}
+	}
+
+	for_each_cpu(cpu, cptab->ctb_cpumask) {
+		/* this CPT-table has other CPUs belonging to this node? */
+		if (cpu_to_node(cpu) == node)
+			break;
+	}
+
+	if (cpu >= nr_cpu_ids && node_isset(node, *cptab->ctb_nodemask)) {
+		/* No more CPUs in the table for this node. */
+		node_clear(node, *cptab->ctb_nodemask);
+		cptab->ctb_node2cpt[node] = -1;
+		cptab->ctb_distance =
+			cfs_cpt_distance_calculate(cptab->ctb_nodemask,
+						   cptab->ctb_nodemask);
+	}
+}
+
 int
 cfs_cpt_set_cpu(struct cfs_cpt_table *cptab, int cpt, int cpu)
 {
-	int node;
-
 	LASSERT(cpt >= 0 && cpt < cptab->ctb_nparts);
 
 	if (cpu < 0 || cpu >= nr_cpu_ids || !cpu_online(cpu)) {
@@ -318,23 +441,11 @@ unsigned int cfs_cpt_distance(struct cfs_cpt_table *cptab, int cpt1, int cpt2)
 		return 0;
 	}
 
-	cptab->ctb_cpu2cpt[cpu] = cpt;
-
 	LASSERT(!cpumask_test_cpu(cpu, cptab->ctb_cpumask));
 	LASSERT(!cpumask_test_cpu(cpu, cptab->ctb_parts[cpt].cpt_cpumask));
 
-	cpumask_set_cpu(cpu, cptab->ctb_cpumask);
-	cpumask_set_cpu(cpu, cptab->ctb_parts[cpt].cpt_cpumask);
-
-	node = cpu_to_node(cpu);
-
-	/* first CPU of @node in this CPT table */
-	if (!node_isset(node, *cptab->ctb_nodemask))
-		node_set(node, *cptab->ctb_nodemask);
-
-	/* first CPU of @node in this partition */
-	if (!node_isset(node, *cptab->ctb_parts[cpt].cpt_nodemask))
-		node_set(node, *cptab->ctb_parts[cpt].cpt_nodemask);
+	cfs_cpt_add_cpu(cptab, cpt, cpu);
+	cfs_cpt_add_node(cptab, cpt, cpu_to_node(cpu));
 
 	return 1;
 }
@@ -343,9 +454,6 @@ unsigned int cfs_cpt_distance(struct cfs_cpt_table *cptab, int cpt1, int cpt2)
 void
 cfs_cpt_unset_cpu(struct cfs_cpt_table *cptab, int cpt, int cpu)
 {
-	int node;
-	int i;
-
 	LASSERT(cpt == CFS_CPT_ANY || (cpt >= 0 && cpt < cptab->ctb_nparts));
 
 	if (cpu < 0 || cpu >= nr_cpu_ids) {
@@ -371,32 +479,8 @@ unsigned int cfs_cpt_distance(struct cfs_cpt_table *cptab, int cpt1, int cpt2)
 	LASSERT(cpumask_test_cpu(cpu, cptab->ctb_parts[cpt].cpt_cpumask));
 	LASSERT(cpumask_test_cpu(cpu, cptab->ctb_cpumask));
 
-	cpumask_clear_cpu(cpu, cptab->ctb_parts[cpt].cpt_cpumask);
-	cpumask_clear_cpu(cpu, cptab->ctb_cpumask);
-	cptab->ctb_cpu2cpt[cpu] = -1;
-
-	node = cpu_to_node(cpu);
-
-	LASSERT(node_isset(node, *cptab->ctb_parts[cpt].cpt_nodemask));
-	LASSERT(node_isset(node, *cptab->ctb_nodemask));
-
-	for_each_cpu(i, cptab->ctb_parts[cpt].cpt_cpumask) {
-		/* this CPT has other CPU belonging to this node? */
-		if (cpu_to_node(i) == node)
-			break;
-	}
-
-	if (i >= nr_cpu_ids)
-		node_clear(node, *cptab->ctb_parts[cpt].cpt_nodemask);
-
-	for_each_cpu(i, cptab->ctb_cpumask) {
-		/* this CPT-table has other CPU belonging to this node? */
-		if (cpu_to_node(i) == node)
-			break;
-	}
-
-	if (i >= nr_cpu_ids)
-		node_clear(node, *cptab->ctb_nodemask);
+	cfs_cpt_del_cpu(cptab, cpt, cpu);
+	cfs_cpt_del_node(cptab, cpt, cpu_to_node(cpu));
 }
 EXPORT_SYMBOL(cfs_cpt_unset_cpu);
 
@@ -413,8 +497,8 @@ unsigned int cfs_cpt_distance(struct cfs_cpt_table *cptab, int cpt1, int cpt2)
 	}
 
 	for_each_cpu(cpu, mask) {
-		if (!cfs_cpt_set_cpu(cptab, cpt, cpu))
-			return 0;
+		cfs_cpt_add_cpu(cptab, cpt, cpu);
+		cfs_cpt_add_node(cptab, cpt, cpu_to_node(cpu));
 	}
 
 	return 1;
@@ -436,6 +520,7 @@ unsigned int cfs_cpt_distance(struct cfs_cpt_table *cptab, int cpt1, int cpt2)
 cfs_cpt_set_node(struct cfs_cpt_table *cptab, int cpt, int node)
 {
 	const cpumask_t *mask;
+	int cpu;
 
 	if (node < 0 || node >= nr_node_ids) {
 		CDEBUG(D_INFO,
@@ -445,7 +530,12 @@ unsigned int cfs_cpt_distance(struct cfs_cpt_table *cptab, int cpt1, int cpt2)
 
 	mask = cpumask_of_node(node);
 
-	return cfs_cpt_set_cpumask(cptab, cpt, mask);
+	for_each_cpu(cpu, mask)
+		cfs_cpt_add_cpu(cptab, cpt, cpu);
+
+	cfs_cpt_add_node(cptab, cpt, node);
+
+	return 1;
 }
 EXPORT_SYMBOL(cfs_cpt_set_node);
 
@@ -453,6 +543,7 @@ unsigned int cfs_cpt_distance(struct cfs_cpt_table *cptab, int cpt1, int cpt2)
 cfs_cpt_unset_node(struct cfs_cpt_table *cptab, int cpt, int node)
 {
 	const cpumask_t *mask;
+	int cpu;
 
 	if (node < 0 || node >= nr_node_ids) {
 		CDEBUG(D_INFO,
@@ -462,7 +553,10 @@ unsigned int cfs_cpt_distance(struct cfs_cpt_table *cptab, int cpt1, int cpt2)
 
 	mask = cpumask_of_node(node);
 
-	cfs_cpt_unset_cpumask(cptab, cpt, mask);
+	for_each_cpu(cpu, mask)
+		cfs_cpt_del_cpu(cptab, cpt, cpu);
+
+	cfs_cpt_del_node(cptab, cpt, node);
 }
 EXPORT_SYMBOL(cfs_cpt_unset_node);
 
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
