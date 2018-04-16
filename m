Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217885-1523851838-2-6512056100335814836
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523851837; b=I0y2lK3aYXVFFO0gvQPOrvtE4F+P7H923WEeEJhspn2fQwtmdt
    3zY8kJqcHakkQ0jgGHR6BhDJyNBY2n16O5KEEjtBRNS0Td4sZ1JIzXxfhibh2RlN
    OzPO80JTutn71qKyUo2izPENNqquBfoMqM2plRqTJ+QNx/XfzW69qUIwSRH2w+Rx
    cwLLYoqcXKx3ZV1996e54ai3xF4KDc3yAkVPvFQEpQeJhATBBjLzE4QCnjhA4eu8
    DNoLKahVslMMJhHxyzaxl5zt/LwckgWOh1KjdpTpB82HEyEW4OggExFUmZxnIuUQ
    Du1BGfoDvglhfv+A6nXtLx9En4NM5/a6RN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851837; bh=ie3o/
    oVSysXUOo9fykTeUf83xOYkPg/LReMb26zyL1w=; b=Gs5RcK1wILUuVraMi/H3X
    Ppsq4MRw8zExN/mhd47Og9i83exJjkd6gulz5F0MCpvDfURSsFdACMRhB0xwHAYS
    fIXORkx+3n5/WsgcBsgUCgKcZ97PUh/AtXt8nvHxW3beadX2jphbLW1OA5k8beN3
    8GvxHUbTXjIXmcygo2ae1dmjanTIgUZEA4WOe8PbQlQPxpkeHQChIqfPSeAOj2iZ
    dhBzRf2Nq25595malkYvJvh1A3RSZ6rgzKM+qsW8LOfSmqhZjWkKgPSo2oUjaDG/
    mzq5Mcunw4He3+Fb92AHD3NRCw+Bw6j4lNY6QNNBPJfU0o6ByTu/U4bbaGijQ1Qd
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG7x9MxpUvJXuXkkZIPTFPpjeLZ0DisKUoawfB+Y72Js9DR1LefBXMbNd7oiWrQhhM+RBDy8BB0e5ATfY/mJ3rM+QoGiDy1eyFwLUkKUrCYwAtKJ3L+s
    8aUWxThiGDYDJFM73p2bPpTA4wgopmgXJWfRQqnJG7pPxhFSn7f/doV7QSBbfX6XQbxXEKs7Zaz014aU057UxQbc0XYPMNfRI0XDdHycJ+dZs9rTH4wtkySB
    5eAwYBXlQbAD1YQEXPGHWA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=eJfxgxciAAAA:8 a=HHGDD-5mAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=Rma03zw6Xm-s-WVVKtYA:9 a=lXC5fwHDdACqBvDE:21 a=p0SG0WBHEbhrh33k:21
    a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=xM9caqqi1sUkTy8OJ5Uh:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 08/25] staging: lustre: libcfs: add cpu distance handling
Date: Mon, 16 Apr 2018 00:09:50 -0400
Message-Id: <1523851807-16573-9-git-send-email-jsimmons@infradead.org>
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

Add functionality to calculate the distance between two CPTs.
Expose those distance in debugfs so people deploying a setup
can debug what is being created for CPTs.

Signed-off-by: Amir Shehata <amir.shehata@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-7734
Reviewed-on: http://review.whamcloud.com/18916
Reviewed-by: Olaf Weber <olaf@sgi.com>
Reviewed-by: Doug Oucharek <dougso@me.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 .../lustre/include/linux/libcfs/libcfs_cpu.h       |  8 +++
 .../lustre/include/linux/libcfs/linux/linux-cpu.h  |  4 ++
 drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c    | 21 ++++++++
 .../staging/lustre/lnet/libcfs/linux/linux-cpu.c   | 59 ++++++++++++++++++++++
 4 files changed, 92 insertions(+)

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h b/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
index 839ec02..c0922fc 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
@@ -110,6 +110,10 @@ struct cfs_cpt_table {
  */
 struct cfs_cpt_table *cfs_cpt_table_alloc(unsigned int ncpt);
 /**
+ * print distance information of cpt-table
+ */
+int cfs_cpt_distance_print(struct cfs_cpt_table *cptab, char *buf, int len);
+/**
  * return total number of CPU partitions in \a cptab
  */
 int
@@ -143,6 +147,10 @@ struct cfs_cpt_table {
  */
 int cfs_cpt_of_node(struct cfs_cpt_table *cptab, int node);
 /**
+ * NUMA distance between \a cpt1 and \a cpt2 in \a cptab
+ */
+unsigned int cfs_cpt_distance(struct cfs_cpt_table *cptab, int cpt1, int cpt2);
+/**
  * bind current thread on a CPU-partition \a cpt of \a cptab
  */
 int cfs_cpt_bind(struct cfs_cpt_table *cptab, int cpt);
diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h b/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h
index 1bed0ba..4ac1670 100644
--- a/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h
+++ b/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h
@@ -52,6 +52,8 @@ struct cfs_cpu_partition {
 	cpumask_var_t			cpt_cpumask;
 	/* nodes mask for this partition */
 	nodemask_t			*cpt_nodemask;
+	/* NUMA distance between CPTs */
+	unsigned int			*cpt_distance;
 	/* spread rotor for NUMA allocator */
 	unsigned int			cpt_spread_rotor;
 };
@@ -60,6 +62,8 @@ struct cfs_cpu_partition {
 struct cfs_cpt_table {
 	/* spread rotor for NUMA allocator */
 	unsigned int			ctb_spread_rotor;
+	/* maximum NUMA distance between all nodes in table */
+	unsigned int			ctb_distance;
 	/* # of CPU partitions */
 	unsigned int			ctb_nparts;
 	/* partitions tables */
diff --git a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
index e6d1512..7ac2796 100644
--- a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
@@ -41,6 +41,8 @@
 
 #define CFS_CPU_VERSION_MAGIC	   0xbabecafe
 
+#define CFS_CPT_DISTANCE	1	/* Arbitrary positive value */
+
 struct cfs_cpt_table *
 cfs_cpt_table_alloc(unsigned int ncpt)
 {
@@ -90,6 +92,19 @@ struct cfs_cpt_table *
 EXPORT_SYMBOL(cfs_cpt_table_print);
 #endif /* CONFIG_SMP */
 
+int cfs_cpt_distance_print(struct cfs_cpt_table *cptab, char *buf, int len)
+{
+	int rc;
+
+	rc = snprintf(buf, len, "0\t: 0:%d\n", CFS_CPT_DISTANCE);
+	len -= rc;
+	if (len <= 0)
+		return -EFBIG;
+
+	return rc;
+}
+EXPORT_SYMBOL(cfs_cpt_distance_print);
+
 int
 cfs_cpt_number(struct cfs_cpt_table *cptab)
 {
@@ -124,6 +139,12 @@ cpumask_var_t *cfs_cpt_cpumask(struct cfs_cpt_table *cptab, int cpt)
 }
 EXPORT_SYMBOL(cfs_cpt_nodemask);
 
+unsigned int cfs_cpt_distance(struct cfs_cpt_table *cptab, int cpt1, int cpt2)
+{
+	return CFS_CPT_DISTANCE;
+}
+EXPORT_SYMBOL(cfs_cpt_distance);
+
 int
 cfs_cpt_set_cpu(struct cfs_cpt_table *cptab, int cpt, int cpu)
 {
diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index fd0c451..1e184b1 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -76,6 +76,7 @@
 		struct cfs_cpu_partition *part = &cptab->ctb_parts[i];
 
 		kfree(part->cpt_nodemask);
+		kfree(part->cpt_distance);
 		free_cpumask_var(part->cpt_cpumask);
 	}
 
@@ -137,6 +138,12 @@ struct cfs_cpt_table *
 		if (!zalloc_cpumask_var(&part->cpt_cpumask, GFP_NOFS) ||
 		    !part->cpt_nodemask)
 			goto failed;
+
+		part->cpt_distance = kvmalloc_array(cptab->ctb_nparts,
+						    sizeof(part->cpt_distance[0]),
+						    GFP_KERNEL);
+		if (!part->cpt_distance)
+			goto failed;
 	}
 
 	return cptab;
@@ -190,6 +197,46 @@ struct cfs_cpt_table *
 }
 EXPORT_SYMBOL(cfs_cpt_table_print);
 
+int cfs_cpt_distance_print(struct cfs_cpt_table *cptab, char *buf, int len)
+{
+	char *tmp = buf;
+	int rc = -EFBIG;
+	int i;
+	int j;
+
+	for (i = 0; i < cptab->ctb_nparts; i++) {
+		if (len <= 0)
+			goto err;
+
+		rc = snprintf(tmp, len, "%d\t:", i);
+		len -= rc;
+
+		if (len <= 0)
+			goto err;
+
+		tmp += rc;
+		for (j = 0; j < cptab->ctb_nparts; j++) {
+			rc = snprintf(tmp, len, " %d:%d",
+				      j, cptab->ctb_parts[i].cpt_distance[j]);
+			len -= rc;
+			if (len <= 0)
+				goto err;
+			tmp += rc;
+		}
+
+		*tmp = '\n';
+		tmp++;
+		len--;
+	}
+	rc = 0;
+err:
+	if (rc < 0)
+		return rc;
+
+	return tmp - buf;
+}
+EXPORT_SYMBOL(cfs_cpt_distance_print);
+
 int
 cfs_cpt_number(struct cfs_cpt_table *cptab)
 {
@@ -241,6 +288,18 @@ struct cfs_cpt_table *
 }
 EXPORT_SYMBOL(cfs_cpt_nodemask);
 
+unsigned int cfs_cpt_distance(struct cfs_cpt_table *cptab, int cpt1, int cpt2)
+{
+	LASSERT(cpt1 == CFS_CPT_ANY || (cpt1 >= 0 && cpt1 < cptab->ctb_nparts));
+	LASSERT(cpt2 == CFS_CPT_ANY || (cpt2 >= 0 && cpt2 < cptab->ctb_nparts));
+
+	if (cpt1 == CFS_CPT_ANY || cpt2 == CFS_CPT_ANY)
+		return cptab->ctb_distance;
+
+	return cptab->ctb_parts[cpt1].cpt_distance[cpt2];
+}
+EXPORT_SYMBOL(cfs_cpt_distance);
+
 int
 cfs_cpt_set_cpu(struct cfs_cpt_table *cptab, int cpt, int cpu)
 {
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
