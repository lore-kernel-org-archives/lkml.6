Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217885-1523851832-5-5500723440651775147
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enrosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523851832; b=eSP7rWvnmVRs8HfnpzolqrKGWUxjAI32kLTNYqJymvMv7Frgw/
    oWx/PgZHotus6GU10pFlKxHXrcfd6S/bwysAKc8JEGw+KqKakieOat8/h7i+mVVo
    AlAPY5jq/7G2ewNTyK5bRXHPxTawuM4BFpD3FHVKxoDvQWtT7JayYt/S8OjOPdaL
    HJHh3CV4H9GmjDVJL5P/e+KEu/rGmkEFPNeLEIfdwhGHhNA01rs6Ae0d47mlyZTa
    xW34O5E2qVt2+wDGuic2LyiLfn7XVPBWQd1ruRVsBkU9cQ6CK14We21S2Nj0V4Zf
    I8aLKGHerStVNwy6mUGV+auCgM/3puL3BNKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851832; bh=PyMly
    dBE3sgbU7eaOgyZ75k0TunTvX7rO1i+HS9P2WM=; b=YTdNGqhtH5Tetx5SOPRiy
    cNJf8bLgF/IapwUP0vdOqOS+Vbq49Fg69yDlGUGLsGH36IEQMuxzw3/oBEUQ4i7Z
    RMyZaek8+zmykYN553buGDG+/n3s6fFM6lOKvv/aGDlc0xvH8Dd6d+0Bp3JUPrQE
    4Azds5rk3khc34AxRuXoYp7SBN/PGzBRhgXlK/5xvT1gonzfjOtpOh5729FExFDD
    mdWm6RazVRs90IcqjTcbmSF2IFEuLWf+jrQdPKq2KrCndXX+vqrjjqehf5F5n28e
    DtdQ6DiNo6KNpUXymH1TVzUqxm0VcY3FUeKVL2yeo+5aXBBTJiBCIE4qPOxYmBL+
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfCXfZmBSMODgZu8emH7oeHHlzsnsIYQ7MH/g2JUvp9WZCZ+m+9d2Z98Blpa8wVs9Ezr0X+y0vM2KIA/51wFOMSdhbQawm5gFVOpRDO0PEAK/dd7r1qbV
    ji0oviYQT9hc0whUIPwszoVgO6xAKS5FoR0CXybDAptLg0KnWoxQ+zC3q4SBQBZm2l2j1WzBSHOXTiqXN6YNR0l3WB8f5TV6+JtVIGmm0Fbh0h3uIxL/qDpv
    gQgmcJvODQbMYQjgSA5SjQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=eJfxgxciAAAA:8 a=HHGDD-5mAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=HSlpM8EmbdHYDzUdRLYA:9 a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22
    a=xM9caqqi1sUkTy8OJ5Uh:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 07/25] staging: lustre: libcfs: NUMA support
Date: Mon, 16 Apr 2018 00:09:49 -0400
Message-Id: <1523851807-16573-8-git-send-email-jsimmons@infradead.org>
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

This patch adds NUMA node support. NUMA node information is stored
in the CPT table. A NUMA node mask is maintained for the entire
table as well as for each CPT to track the NUMA nodes related to
each of the CPTs. Add new function cfs_cpt_of_node() which returns
the CPT of a particular NUMA node.

Signed-off-by: Amir Shehata <amir.shehata@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-7734
Reviewed-on: http://review.whamcloud.com/18916
Reviewed-by: Olaf Weber <olaf@sgi.com>
Reviewed-by: Doug Oucharek <dougso@me.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 .../staging/lustre/include/linux/libcfs/libcfs_cpu.h  |  4 ++++
 .../lustre/include/linux/libcfs/linux/linux-cpu.h     |  2 ++
 drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c       |  6 ++++++
 drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c  | 19 +++++++++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h b/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
index 070f8fe..839ec02 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
@@ -139,6 +139,10 @@ struct cfs_cpt_table {
  */
 int cfs_cpt_of_cpu(struct cfs_cpt_table *cptab, int cpu);
 /**
+ * shadow HW node ID \a NODE to CPU-partition ID by \a cptab
+ */
+int cfs_cpt_of_node(struct cfs_cpt_table *cptab, int node);
+/**
  * bind current thread on a CPU-partition \a cpt of \a cptab
  */
 int cfs_cpt_bind(struct cfs_cpt_table *cptab, int cpt);
diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h b/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h
index e8bbbaa..1bed0ba 100644
--- a/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h
+++ b/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h
@@ -68,6 +68,8 @@ struct cfs_cpt_table {
 	int				*ctb_cpu2cpt;
 	/* all cpus in this partition table */
 	cpumask_var_t			ctb_cpumask;
+	/* shadow HW node to CPU partition ID */
+	int				*ctb_node2cpt;
 	/* all nodes in this partition table */
 	nodemask_t			*ctb_nodemask;
 };
diff --git a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
index 5ea294f..e6d1512 100644
--- a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
@@ -198,6 +198,12 @@ cpumask_var_t *cfs_cpt_cpumask(struct cfs_cpt_table *cptab, int cpt)
 }
 EXPORT_SYMBOL(cfs_cpt_of_cpu);
 
+int cfs_cpt_of_node(struct cfs_cpt_table *cptab, int node)
+{
+	return 0;
+}
+EXPORT_SYMBOL(cfs_cpt_of_node);
+
 int
 cfs_cpt_bind(struct cfs_cpt_table *cptab, int cpt)
 {
diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index 741db69..fd0c451 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -70,6 +70,7 @@
 	int i;
 
 	kvfree(cptab->ctb_cpu2cpt);
+	kvfree(cptab->ctb_node2cpt);
 
 	for (i = 0; cptab->ctb_parts && i < cptab->ctb_nparts; i++) {
 		struct cfs_cpu_partition *part = &cptab->ctb_parts[i];
@@ -114,6 +115,15 @@ struct cfs_cpt_table *
 	memset(cptab->ctb_cpu2cpt, -1,
 	       nr_cpu_ids * sizeof(cptab->ctb_cpu2cpt[0]));
 
+	cptab->ctb_node2cpt = kvmalloc_array(nr_node_ids,
+					     sizeof(cptab->ctb_node2cpt[0]),
+					     GFP_KERNEL);
+	if (!cptab->ctb_node2cpt)
+		goto failed;
+
+	memset(cptab->ctb_node2cpt, -1,
+	       nr_node_ids * sizeof(cptab->ctb_node2cpt[0]));
+
 	cptab->ctb_parts = kvmalloc_array(ncpt, sizeof(cptab->ctb_parts[0]),
 					  GFP_KERNEL);
 	if (!cptab->ctb_parts)
@@ -484,6 +494,15 @@ struct cfs_cpt_table *
 }
 EXPORT_SYMBOL(cfs_cpt_of_cpu);
 
+int cfs_cpt_of_node(struct cfs_cpt_table *cptab, int node)
+{
+	if (node < 0 || node > nr_node_ids)
+		return CFS_CPT_ANY;
+
+	return cptab->ctb_node2cpt[node];
+}
+EXPORT_SYMBOL(cfs_cpt_of_node);
+
 int
 cfs_cpt_bind(struct cfs_cpt_table *cptab, int cpt)
 {
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
