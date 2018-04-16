Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2210789-1523851826-2-12937470082764644007
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523851824; b=VXLW/Ha6k2bZdqB51DaJDwD+vauadO/3a3zEWN75cHxye1Sr8n
    H5nmDreUGalNlTzjrJVkMs07nMHGe9J26CQjSC0DPvyjqyvuXg2HargBoyHQC4ke
    3sNAWxX/gBvaGfDv20fwnMsOf5LOtNS/uwH29YglcX3ZS5b2B9gMCS34xHhvSBl9
    znsaOJVEr85AFY+ds6Vm53S3j0bFx6VGMmAfYjFtELDt67liRVHoJM8t+AJxyw9e
    Zz5fBsG+U07SrytbKu+sOyM5qXaMlsENVMcFZoZW0wuNCnPSr3RPSnG96poa2Sg6
    1K/Onocisyf8b0ExkbGV530YyfpLiBAHYGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851824; bh=ASJFl
    5p4LJBCttPyLioO04gW77Ku3NmvsAgWk/5pEKM=; b=YNIMdZmU6pEaeTbg/1HsD
    k7kfngGrC+jmyERBc6C4icFi8ulJWX/8EJ/pXkKi7Er+VCRrrERXFJpqxBKQOip5
    MmR7/aUP3MQ6Tyvs7t5MrYxxVTv/oz29oxi9OksG4vll47fx/WGsQ0C/eOHaTk60
    0J5z0AOl62mXGBCI2FCmCNk7Q+1PyHjViGPjNpruk+N73JIuVO215xGIPN3/bbE0
    W3VCvPRAzPHkjAZKZOXowdfUGPczZBDczHoAByfYQFbxzHrbVGt77VqZSDXTeD3K
    giCRXnTv0cJxOtD6IpDje628jIghMl6DmQXwEDoovpCAc8k78BGSZbckRpMMsu8g
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHyhUm82i9WYoOJWbNkoGVdwBtB4rIJxSsEyKTm5y4hRlHI06RmtDsJvMKEQ6Jk0lDfe5sAj6tnSO4xwZqMauRVlgSV0kCRogRUdIYFmdTn4GAS6w+Rh
    71df5GwPe/vWESHc4Nw5AXqv0Cm1GsuzxYj7yN3nMRXLeAJyeLaiXXoHgfv8GGGLGV8ImnsxkXu+ulxJVhsi+GkBQ2wM0jxMm6BjTF7WNooJeLs0eHlH4oqL
    92TlKlE4AtpF3atlOVJ+Rg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=HHGDD-5mAAAA:8 a=eJfxgxciAAAA:8 a=JfrnYn6hAAAA:8
    a=DDOyTI_5AAAA:8 a=faQReNI9r__9l8enYusA:9 a=G48N9-LwwXPZHxi4:21
    a=EKo3cBsg2PpuK936:21 a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22
    a=xM9caqqi1sUkTy8OJ5Uh:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 01/25] staging: lustre: libcfs: remove useless CPU partition
 code
Date: Mon, 16 Apr 2018 00:09:43 -0400
Message-Id: <1523851807-16573-2-git-send-email-jsimmons@infradead.org>
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
Cc: Dmitry Eremin <dmitry.eremin@intel.com>,
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

From: Dmitry Eremin <dmitry.eremin@intel.com>

* remove scratch buffer and mutex which guard it.
* remove global cpumask and spinlock which guard it.
* remove cpt_version for checking CPUs state change during setup
  because of just disable CPUs state change during setup.
* remove whole global struct cfs_cpt_data cpt_data.
* remove few unused APIs.

Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8703
Reviewed-on: https://review.whamcloud.com/23303
Reviewed-on: https://review.whamcloud.com/25048
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Doug Oucharek <dougso@me.com>
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Reviewed-by: Olaf Weber <olaf@sgi.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 .../lustre/include/linux/libcfs/libcfs_cpu.h       |  13 +--
 .../lustre/include/linux/libcfs/linux/linux-cpu.h  |   2 -
 drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c    |  18 +---
 .../staging/lustre/lnet/libcfs/linux/linux-cpu.c   | 114 +++------------------
 4 files changed, 20 insertions(+), 127 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h b/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
index 61bce77..1f2cd78 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
@@ -162,12 +162,12 @@ struct cfs_cpt_table {
  * return 1 if successfully set all CPUs, otherwise return 0
  */
 int cfs_cpt_set_cpumask(struct cfs_cpt_table *cptab,
-			int cpt, cpumask_t *mask);
+			int cpt, const cpumask_t *mask);
 /**
  * remove all cpus in \a mask from CPU partition \a cpt
  */
 void cfs_cpt_unset_cpumask(struct cfs_cpt_table *cptab,
-			   int cpt, cpumask_t *mask);
+			   int cpt, const cpumask_t *mask);
 /**
  * add all cpus in NUMA node \a node to CPU partition \a cpt
  * return 1 if successfully set all CPUs, otherwise return 0
@@ -190,20 +190,11 @@ int cfs_cpt_set_nodemask(struct cfs_cpt_table *cptab,
 void cfs_cpt_unset_nodemask(struct cfs_cpt_table *cptab,
 			    int cpt, nodemask_t *mask);
 /**
- * unset all cpus for CPU partition \a cpt
- */
-void cfs_cpt_clear(struct cfs_cpt_table *cptab, int cpt);
-/**
  * convert partition id \a cpt to numa node id, if there are more than one
  * nodes in this partition, it might return a different node id each time.
  */
 int cfs_cpt_spread_node(struct cfs_cpt_table *cptab, int cpt);
 
-/**
- * return number of HTs in the same core of \a cpu
- */
-int cfs_cpu_ht_nsiblings(int cpu);
-
 /*
  * allocate per-cpu-partition data, returned value is an array of pointers,
  * variable can be indexed by CPU ID.
diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h b/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h
index 6035376..e8bbbaa 100644
--- a/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h
+++ b/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h
@@ -58,8 +58,6 @@ struct cfs_cpu_partition {
 
 /** descriptor for CPU partitions */
 struct cfs_cpt_table {
-	/* version, reserved for hotplug */
-	unsigned int			ctb_version;
 	/* spread rotor for NUMA allocator */
 	unsigned int			ctb_spread_rotor;
 	/* # of CPU partitions */
diff --git a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
index 76291a3..705abf2 100644
--- a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
@@ -129,14 +129,15 @@ struct cfs_cpt_table *
 EXPORT_SYMBOL(cfs_cpt_unset_cpu);
 
 int
-cfs_cpt_set_cpumask(struct cfs_cpt_table *cptab, int cpt, cpumask_t *mask)
+cfs_cpt_set_cpumask(struct cfs_cpt_table *cptab, int cpt, const cpumask_t *mask)
 {
 	return 1;
 }
 EXPORT_SYMBOL(cfs_cpt_set_cpumask);
 
 void
-cfs_cpt_unset_cpumask(struct cfs_cpt_table *cptab, int cpt, cpumask_t *mask)
+cfs_cpt_unset_cpumask(struct cfs_cpt_table *cptab, int cpt,
+		      const cpumask_t *mask)
 {
 }
 EXPORT_SYMBOL(cfs_cpt_unset_cpumask);
@@ -167,12 +168,6 @@ struct cfs_cpt_table *
 }
 EXPORT_SYMBOL(cfs_cpt_unset_nodemask);
 
-void
-cfs_cpt_clear(struct cfs_cpt_table *cptab, int cpt)
-{
-}
-EXPORT_SYMBOL(cfs_cpt_clear);
-
 int
 cfs_cpt_spread_node(struct cfs_cpt_table *cptab, int cpt)
 {
@@ -181,13 +176,6 @@ struct cfs_cpt_table *
 EXPORT_SYMBOL(cfs_cpt_spread_node);
 
 int
-cfs_cpu_ht_nsiblings(int cpu)
-{
-	return 1;
-}
-EXPORT_SYMBOL(cfs_cpu_ht_nsiblings);
-
-int
 cfs_cpt_current(struct cfs_cpt_table *cptab, int remap)
 {
 	return 0;
diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index 388521e..134b239 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -64,30 +64,6 @@
 module_param(cpu_pattern, charp, 0444);
 MODULE_PARM_DESC(cpu_pattern, "CPU partitions pattern");
 
-struct cfs_cpt_data {
-	/* serialize hotplug etc */
-	spinlock_t		cpt_lock;
-	/* reserved for hotplug */
-	unsigned long		cpt_version;
-	/* mutex to protect cpt_cpumask */
-	struct mutex		cpt_mutex;
-	/* scratch buffer for set/unset_node */
-	cpumask_var_t		cpt_cpumask;
-};
-
-static struct cfs_cpt_data	cpt_data;
-
-static void
-cfs_node_to_cpumask(int node, cpumask_t *mask)
-{
-	const cpumask_t *tmp = cpumask_of_node(node);
-
-	if (tmp)
-		cpumask_copy(mask, tmp);
-	else
-		cpumask_clear(mask);
-}
-
 void
 cfs_cpt_table_free(struct cfs_cpt_table *cptab)
 {
@@ -153,11 +129,6 @@ struct cfs_cpt_table *
 			goto failed;
 	}
 
-	spin_lock(&cpt_data.cpt_lock);
-	/* Reserved for hotplug */
-	cptab->ctb_version = cpt_data.cpt_version;
-	spin_unlock(&cpt_data.cpt_lock);
-
 	return cptab;
 
  failed:
@@ -361,7 +332,7 @@ struct cfs_cpt_table *
 EXPORT_SYMBOL(cfs_cpt_unset_cpu);
 
 int
-cfs_cpt_set_cpumask(struct cfs_cpt_table *cptab, int cpt, cpumask_t *mask)
+cfs_cpt_set_cpumask(struct cfs_cpt_table *cptab, int cpt, const cpumask_t *mask)
 {
 	int i;
 
@@ -382,7 +353,8 @@ struct cfs_cpt_table *
 EXPORT_SYMBOL(cfs_cpt_set_cpumask);
 
 void
-cfs_cpt_unset_cpumask(struct cfs_cpt_table *cptab, int cpt, cpumask_t *mask)
+cfs_cpt_unset_cpumask(struct cfs_cpt_table *cptab, int cpt,
+		      const cpumask_t *mask)
 {
 	int i;
 
@@ -394,7 +366,7 @@ struct cfs_cpt_table *
 int
 cfs_cpt_set_node(struct cfs_cpt_table *cptab, int cpt, int node)
 {
-	int rc;
+	const cpumask_t *mask;
 
 	if (node < 0 || node >= MAX_NUMNODES) {
 		CDEBUG(D_INFO,
@@ -402,34 +374,26 @@ struct cfs_cpt_table *
 		return 0;
 	}
 
-	mutex_lock(&cpt_data.cpt_mutex);
-
-	cfs_node_to_cpumask(node, cpt_data.cpt_cpumask);
-
-	rc = cfs_cpt_set_cpumask(cptab, cpt, cpt_data.cpt_cpumask);
-
-	mutex_unlock(&cpt_data.cpt_mutex);
+	mask = cpumask_of_node(node);
 
-	return rc;
+	return cfs_cpt_set_cpumask(cptab, cpt, mask);
 }
 EXPORT_SYMBOL(cfs_cpt_set_node);
 
 void
 cfs_cpt_unset_node(struct cfs_cpt_table *cptab, int cpt, int node)
 {
+	const cpumask_t *mask;
+
 	if (node < 0 || node >= MAX_NUMNODES) {
 		CDEBUG(D_INFO,
 		       "Invalid NUMA id %d for CPU partition %d\n", node, cpt);
 		return;
 	}
 
-	mutex_lock(&cpt_data.cpt_mutex);
-
-	cfs_node_to_cpumask(node, cpt_data.cpt_cpumask);
+	mask = cpumask_of_node(node);
 
-	cfs_cpt_unset_cpumask(cptab, cpt, cpt_data.cpt_cpumask);
-
-	mutex_unlock(&cpt_data.cpt_mutex);
+	cfs_cpt_unset_cpumask(cptab, cpt, mask);
 }
 EXPORT_SYMBOL(cfs_cpt_unset_node);
 
@@ -457,26 +421,6 @@ struct cfs_cpt_table *
 }
 EXPORT_SYMBOL(cfs_cpt_unset_nodemask);
 
-void
-cfs_cpt_clear(struct cfs_cpt_table *cptab, int cpt)
-{
-	int last;
-	int i;
-
-	if (cpt == CFS_CPT_ANY) {
-		last = cptab->ctb_nparts - 1;
-		cpt = 0;
-	} else {
-		last = cpt;
-	}
-
-	for (; cpt <= last; cpt++) {
-		for_each_cpu(i, cptab->ctb_parts[cpt].cpt_cpumask)
-			cfs_cpt_unset_cpu(cptab, cpt, i);
-	}
-}
-EXPORT_SYMBOL(cfs_cpt_clear);
-
 int
 cfs_cpt_spread_node(struct cfs_cpt_table *cptab, int cpt)
 {
@@ -749,7 +693,7 @@ struct cfs_cpt_table *
 	}
 
 	for_each_online_node(i) {
-		cfs_node_to_cpumask(i, mask);
+		cpumask_copy(mask, cpumask_of_node(i));
 
 		while (!cpumask_empty(mask)) {
 			struct cfs_cpu_partition *part;
@@ -955,16 +899,8 @@ struct cfs_cpt_table *
 #ifdef CONFIG_HOTPLUG_CPU
 static enum cpuhp_state lustre_cpu_online;
 
-static void cfs_cpu_incr_cpt_version(void)
-{
-	spin_lock(&cpt_data.cpt_lock);
-	cpt_data.cpt_version++;
-	spin_unlock(&cpt_data.cpt_lock);
-}
-
 static int cfs_cpu_online(unsigned int cpu)
 {
-	cfs_cpu_incr_cpt_version();
 	return 0;
 }
 
@@ -972,14 +908,9 @@ static int cfs_cpu_dead(unsigned int cpu)
 {
 	bool warn;
 
-	cfs_cpu_incr_cpt_version();
-
-	mutex_lock(&cpt_data.cpt_mutex);
 	/* if all HTs in a core are offline, it may break affinity */
-	cpumask_copy(cpt_data.cpt_cpumask, topology_sibling_cpumask(cpu));
-	warn = cpumask_any_and(cpt_data.cpt_cpumask,
+	warn = cpumask_any_and(topology_sibling_cpumask(cpu),
 			       cpu_online_mask) >= nr_cpu_ids;
-	mutex_unlock(&cpt_data.cpt_mutex);
 	CDEBUG(warn ? D_WARNING : D_INFO,
 	       "Lustre: can't support CPU plug-out well now, performance and stability could be impacted [CPU %u]\n",
 	       cpu);
@@ -998,7 +929,6 @@ static int cfs_cpu_dead(unsigned int cpu)
 		cpuhp_remove_state_nocalls(lustre_cpu_online);
 	cpuhp_remove_state_nocalls(CPUHP_LUSTRE_CFS_DEAD);
 #endif
-	free_cpumask_var(cpt_data.cpt_cpumask);
 }
 
 int
@@ -1008,16 +938,6 @@ static int cfs_cpu_dead(unsigned int cpu)
 
 	LASSERT(!cfs_cpt_table);
 
-	memset(&cpt_data, 0, sizeof(cpt_data));
-
-	if (!zalloc_cpumask_var(&cpt_data.cpt_cpumask, GFP_NOFS)) {
-		CERROR("Failed to allocate scratch buffer\n");
-		return -1;
-	}
-
-	spin_lock_init(&cpt_data.cpt_lock);
-	mutex_init(&cpt_data.cpt_mutex);
-
 #ifdef CONFIG_HOTPLUG_CPU
 	ret = cpuhp_setup_state_nocalls(CPUHP_LUSTRE_CFS_DEAD,
 					"staging/lustre/cfe:dead", NULL,
@@ -1033,6 +953,7 @@ static int cfs_cpu_dead(unsigned int cpu)
 #endif
 	ret = -EINVAL;
 
+	get_online_cpus();
 	if (*cpu_pattern) {
 		char *cpu_pattern_dup = kstrdup(cpu_pattern, GFP_KERNEL);
 
@@ -1058,13 +979,7 @@ static int cfs_cpu_dead(unsigned int cpu)
 		}
 	}
 
-	spin_lock(&cpt_data.cpt_lock);
-	if (cfs_cpt_table->ctb_version != cpt_data.cpt_version) {
-		spin_unlock(&cpt_data.cpt_lock);
-		CERROR("CPU hotplug/unplug during setup\n");
-		goto failed;
-	}
-	spin_unlock(&cpt_data.cpt_lock);
+	put_online_cpus();
 
 	LCONSOLE(0, "HW nodes: %d, HW CPU cores: %d, npartitions: %d\n",
 		 num_online_nodes(), num_online_cpus(),
@@ -1072,6 +987,7 @@ static int cfs_cpu_dead(unsigned int cpu)
 	return 0;
 
  failed:
+	put_online_cpus();
 	cfs_cpu_fini();
 	return ret;
 }
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
