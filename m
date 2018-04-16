Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217885-1523851856-2-11699264013062951319
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523851855; b=L1SvPkOb7r9Dq4kj9abjAkg8Ju5VS7WVYVmJ+Gu5ycpaJQ0uR0
    FQy+BUTWf6ovfemdOgfjh0Kr53+fChHJh0YZ8ereByMOiU7qJY0FvKff1b+r/zZ1
    zTq5SGI+jJZ+itqnSdlD4zK9bL/TPPkjVg7w/5AOxUnKZyoiRznZYkXuzj5igaRy
    SgVYkQ8XZWb31SAP11Z1oS7N0vkOb72yR8b8uR93HfMGUDoZA9wzPLFi6VBQ7ICa
    TNC8y+tRvFdevwIuXz2Rs3MU+gadvM6k9ZImiKkMViSnul9AhDrTTNWoV/GPtuHb
    iLU9Jwi1yw5/3TJMyALOz3Gcn8F5cXWIw2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851855; bh=shHY2
    jMwf3vGLrTWXNeCU6uT22tCdJ8YHnpHlupJ1VI=; b=C6f585BU9hJff4dVXGJAr
    mv1BkzDkHzQXy6VEsJYSsP+tBYGPaVTPKF88ybIJHUDJqHwUffWpgrpniHzQn1Sj
    41aGPnziSxLcpfqix9xt14AdQacEIoPQ/M/WBByQ9JVP+kIjD6cEzM/Uzzb8/h4X
    nUTfq6K3EZFvXdL62V0C7WqWX0lj6kKYJFfHqxyg6/bKMSv9DqXAkdKvtIybaZ8B
    mUdLrWvwEXQ8Tzv6KZ6osSawiLVMxsThEcEXeUiSCNzOMDrXHQxXiCI1oLplsSwa
    016qMPhCdtsKAQjztWE2zATqqivcpc9mHGsHJXCk1rJB3y6z0IA27DeEq7P1utQb
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfJEG65AXON/pZhnY+4p+pK/i5XMIrTlRss8wNKh2pyj4/LPd3AWCweEDhxfTwKZ8L4haCkTxzTTg5nSjXbd6BwAq6cS+4uDRUZ5FO4IfRQl6+0/aTl3j
    jq6qGMS7AJjQlgdooLIQqbsBfejAvDfwOEQ99HiqZLaGwTC/LIODK7a3ix9MyRvecgg5+9+iOO5lnC1kqvIv/HiYtDF5RHUpyfx6ApcKTt4yFQ7Al3qf3Epr
    YA+M7zLYBnhfDGDkCd3ZmA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=kBl-OI3rAAAA:8 a=MvuuwTCpAAAA:8 a=JfrnYn6hAAAA:8
    a=DDOyTI_5AAAA:8 a=fm7P8Jc2wZyKYUDYw1sA:9 a=exEfqMVFrCUcjO8s:21
    a=rPVNMQCINtyI8wue:21 a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22
    a=pLxN2xGgR0OPbCgNAGn6:22 a=dVHiktpip_riXrfdqayU:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 23/25] staging: lustre: libcfs: rework CPU pattern parsing code
Date: Mon, 16 Apr 2018 00:10:05 -0400
Message-Id: <1523851807-16573-24-git-send-email-jsimmons@infradead.org>
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
 Amir Shehata <amir.shehata@intel.com>,
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

Currently the module param string for CPU pattern can be
modified which is wrong. Rewrite CPU pattern parsing code
to avoid the passed buffer from being changed. This change
also enables us to add real errors propogation to the caller
functions.

Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
Signed-off-by: Amir Shehata <amir.shehata@intel.com>
Signed-off-by: Andreas Dilger <andreas.dilger@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8703
Reviewed-on: https://review.whamcloud.com/23306
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9715
Reviewed-on: https://review.whamcloud.com/27872
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Reviewed-by: Patrick Farrell <paf@cray.com>
Reviewed-by: Olaf Weber <olaf.weber@hpe.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 .../staging/lustre/lnet/libcfs/linux/linux-cpu.c   | 151 ++++++++++++---------
 1 file changed, 88 insertions(+), 63 deletions(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index a08816a..915cfca 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -662,11 +662,11 @@ int cfs_cpt_bind(struct cfs_cpt_table *cptab, int cpt)
 		nodemask = cptab->ctb_parts[cpt].cpt_nodemask;
 	}
 
-	if (cpumask_any_and(*cpumask, cpu_online_mask) >= nr_cpu_ids) {
+	if (!cpumask_intersects(*cpumask, cpu_online_mask)) {
 		CDEBUG(D_INFO,
 		       "No online CPU found in CPU partition %d, did someone do CPU hotplug on system? You might need to reload Lustre modules to keep system working well.\n",
 		       cpt);
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	for_each_online_cpu(cpu) {
@@ -830,11 +830,13 @@ static struct cfs_cpt_table *cfs_cpt_table_create(int ncpt)
 	cptab = cfs_cpt_table_alloc(ncpt);
 	if (!cptab) {
 		CERROR("Failed to allocate CPU map(%d)\n", ncpt);
+		rc = -ENOMEM;
 		goto failed;
 	}
 
 	if (!zalloc_cpumask_var(&node_mask, GFP_NOFS)) {
 		CERROR("Failed to allocate scratch cpumask\n");
+		rc = -ENOMEM;
 		goto failed;
 	}
 
@@ -849,8 +851,10 @@ static struct cfs_cpt_table *cfs_cpt_table_create(int ncpt)
 
 			rc = cfs_cpt_choose_ncpus(cptab, cpt, node_mask,
 						  num - ncpu);
-			if (rc < 0)
+			if (rc < 0) {
+				rc = -EINVAL;
 				goto failed_mask;
+			}
 
 			ncpu = cpumask_weight(part->cpt_cpumask);
 			if (ncpu == num + !!(rem > 0)) {
@@ -873,37 +877,51 @@ static struct cfs_cpt_table *cfs_cpt_table_create(int ncpt)
 	if (cptab)
 		cfs_cpt_table_free(cptab);
 
-	return NULL;
+	return ERR_PTR(rc);
 }
 
-static struct cfs_cpt_table *cfs_cpt_table_create_pattern(char *pattern)
+static struct cfs_cpt_table *cfs_cpt_table_create_pattern(const char *pattern)
 {
 	struct cfs_cpt_table *cptab;
+	char *pattern_dup;
+	char *bracket;
 	char *str;
 	int node = 0;
-	int high;
 	int ncpt = 0;
-	int cpt;
+	int cpt = 0;
+	int high;
 	int rc;
 	int c;
 	int i;
 
-	str = strim(pattern);
+	pattern_dup = kstrdup(pattern, GFP_KERNEL);
+	if (!pattern_dup) {
+		CERROR("Failed to duplicate pattern '%s'\n", pattern);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	str = strim(pattern_dup);
 	if (*str == 'n' || *str == 'N') {
-		pattern = str + 1;
-		if (*pattern != '\0') {
-			node = 1;
-		} else { /* shortcut to create CPT from NUMA & CPU topology */
+		str++; /* skip 'N' char */
+		node = 1; /* NUMA pattern */
+		if (*str == '\0') {
 			node = -1;
-			ncpt = num_online_nodes();
+			for_each_online_node(i) {
+				if (!cpumask_empty(cpumask_of_node(i)))
+					ncpt++;
+			}
+			if (ncpt == 1) { /* single NUMA node */
+				kfree(pattern_dup);
+				return cfs_cpt_table_create(cpu_npartitions);
+			}
 		}
 	}
 
 	if (!ncpt) { /* scanning bracket which is mark of partition */
-		for (str = pattern;; str++, ncpt++) {
-			str = strchr(str, '[');
-			if (!str)
-				break;
+		bracket = str;
+		while ((bracket = strchr(bracket, '['))) {
+			bracket++;
+			ncpt++;
 		}
 	}
 
@@ -911,87 +929,95 @@ static struct cfs_cpt_table *cfs_cpt_table_create_pattern(char *pattern)
 	    (node && ncpt > num_online_nodes()) ||
 	    (!node && ncpt > num_online_cpus())) {
 		CERROR("Invalid pattern '%s', or too many partitions %d\n",
-		       pattern, ncpt);
-		return NULL;
+		       pattern_dup, ncpt);
+		rc = -EINVAL;
+		goto err_free_str;
 	}
 
 	cptab = cfs_cpt_table_alloc(ncpt);
 	if (!cptab) {
 		CERROR("Failed to allocate CPU partition table\n");
-		return NULL;
+		rc = -ENOMEM;
+		goto err_free_str;
 	}
 
 	if (node < 0) { /* shortcut to create CPT from NUMA & CPU topology */
-		cpt = 0;
-
 		for_each_online_node(i) {
-			if (cpt >= ncpt) {
-				CERROR("CPU changed while setting CPU partition table, %d/%d\n",
-				       cpt, ncpt);
-				goto failed;
-			}
+			if (cpumask_empty(cpumask_of_node(i)))
+				continue;
 
 			rc = cfs_cpt_set_node(cptab, cpt++, i);
-			if (!rc)
-				goto failed;
+			if (!rc) {
+				rc = -EINVAL;
+				goto err_free_table;
+			}
 		}
+		kfree(pattern_dup);
 		return cptab;
 	}
 
 	high = node ? nr_node_ids - 1 : nr_cpu_ids - 1;
 
-	for (str = strim(pattern), c = 0;; c++) {
+	for (str = strim(str), c = 0; /* until break */; c++) {
 		struct cfs_range_expr *range;
 		struct cfs_expr_list *el;
-		char *bracket = strchr(str, '[');
 		int n;
 
+		bracket = strchr(str, '[');
 		if (!bracket) {
 			if (*str) {
 				CERROR("Invalid pattern '%s'\n", str);
-				goto failed;
-			}
-			if (c != ncpt) {
+				rc = -EINVAL;
+				goto err_free_table;
+			} else if (c != ncpt) {
 				CERROR("Expect %d partitions but found %d\n",
 				       ncpt, c);
-				goto failed;
+				rc = -EINVAL;
+				goto err_free_table;
 			}
 			break;
 		}
 
 		if (sscanf(str, "%d%n", &cpt, &n) < 1) {
 			CERROR("Invalid CPU pattern '%s'\n", str);
-			goto failed;
+			rc = -EINVAL;
+			goto err_free_table;
 		}
 
 		if (cpt < 0 || cpt >= ncpt) {
 			CERROR("Invalid partition id %d, total partitions %d\n",
 			       cpt, ncpt);
-			goto failed;
+			rc = -EINVAL;
+			goto err_free_table;
 		}
 
 		if (cfs_cpt_weight(cptab, cpt)) {
 			CERROR("Partition %d has already been set.\n", cpt);
-			goto failed;
+			rc = -EPERM;
+			goto err_free_table;
 		}
 
 		str = strim(str + n);
 		if (str != bracket) {
 			CERROR("Invalid pattern '%s'\n", str);
-			goto failed;
+			rc = -EINVAL;
+			goto err_free_table;
 		}
 
 		bracket = strchr(str, ']');
 		if (!bracket) {
 			CERROR("Missing right bracket for partition %d in '%s'\n",
 			       cpt, str);
-			goto failed;
+			rc = -EINVAL;
+			goto err_free_table;
 		}
 
-		if (cfs_expr_list_parse(str, (bracket - str) + 1,
-					0, high, &el)) {
+		rc = cfs_expr_list_parse(str, (bracket - str) + 1, 0, high,
+					 &el);
+		if (rc) {
 			CERROR("Can't parse number range in '%s'\n", str);
-			goto failed;
+			rc = -ERANGE;
+			goto err_free_table;
 		}
 
 		list_for_each_entry(range, &el->el_exprs, re_link) {
@@ -999,11 +1025,12 @@ static struct cfs_cpt_table *cfs_cpt_table_create_pattern(char *pattern)
 				if ((i - range->re_lo) % range->re_stride)
 					continue;
 
-				rc = node ? cfs_cpt_set_node(cptab, cpt, i) :
-					    cfs_cpt_set_cpu(cptab, cpt, i);
+				rc = node ? cfs_cpt_set_node(cptab, cpt, i)
+					  : cfs_cpt_set_cpu(cptab, cpt, i);
 				if (!rc) {
 					cfs_expr_list_free(el);
-					goto failed;
+					rc = -EINVAL;
+					goto err_free_table;
 				}
 			}
 		}
@@ -1012,17 +1039,21 @@ static struct cfs_cpt_table *cfs_cpt_table_create_pattern(char *pattern)
 
 		if (!cfs_cpt_online(cptab, cpt)) {
 			CERROR("No online CPU is found on partition %d\n", cpt);
-			goto failed;
+			rc = -ENODEV;
+			goto err_free_table;
 		}
 
 		str = strim(bracket + 1);
 	}
 
+	kfree(pattern_dup);
 	return cptab;
 
-failed:
+err_free_table:
 	cfs_cpt_table_free(cptab);
-	return NULL;
+err_free_str:
+	kfree(pattern_dup);
+	return ERR_PTR(rc);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1049,7 +1080,7 @@ static int cfs_cpu_dead(unsigned int cpu)
 
 void cfs_cpu_fini(void)
 {
-	if (cfs_cpt_table)
+	if (!IS_ERR_OR_NULL(cfs_cpt_table))
 		cfs_cpt_table_free(cfs_cpt_table);
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1082,26 +1113,20 @@ int cfs_cpu_init(void)
 
 	get_online_cpus();
 	if (*cpu_pattern) {
-		char *cpu_pattern_dup = kstrdup(cpu_pattern, GFP_KERNEL);
-
-		if (!cpu_pattern_dup) {
-			CERROR("Failed to duplicate cpu_pattern\n");
-			goto failed;
-		}
-
-		cfs_cpt_table = cfs_cpt_table_create_pattern(cpu_pattern_dup);
-		kfree(cpu_pattern_dup);
-		if (!cfs_cpt_table) {
-			CERROR("Failed to create cptab from pattern %s\n",
+		cfs_cpt_table = cfs_cpt_table_create_pattern(cpu_pattern);
+		if (IS_ERR(cfs_cpt_table)) {
+			CERROR("Failed to create cptab from pattern '%s'\n",
 			       cpu_pattern);
+			ret = PTR_ERR(cfs_cpt_table);
 			goto failed;
 		}
 
 	} else {
 		cfs_cpt_table = cfs_cpt_table_create(cpu_npartitions);
-		if (!cfs_cpt_table) {
-			CERROR("Failed to create ptable with npartitions %d\n",
+		if (IS_ERR(cfs_cpt_table)) {
+			CERROR("Failed to create cptab with npartitions %d\n",
 			       cpu_npartitions);
+			ret = PTR_ERR(cfs_cpt_table);
 			goto failed;
 		}
 	}
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
