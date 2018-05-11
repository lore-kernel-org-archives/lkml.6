Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4103318-1526049830-2-9739946864442986989
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526049830; b=m9Kj4dc/jITwlm9zcOI4YB86vvObq/wuCO8sObQev+NsRB34d7
    5grd2ymoiGnJEi7aC38Ygr2fA5Rgw7cLVnqjeprIsyiNm+Z2Exd4EypGOB15r2yv
    Y8hj7bGsAdX1NN9ktFEMXclyi3G7jMbNib77rU2ZginRQhNakPUILvXaNaxRo0ny
    Nu5nHA9JuYjCq0MWaenoi/pr3rt53gVgP31XUAA5qPKW74p92AU1xS2wLtixgols
    MU6oTGetyppD1aP1COKs9Z3at+ewq1p2/xZMmUCj1mfqKq92/NvN9/GyDyFl8ao6
    J9IqLIJj51BwqdvgPELnGctjvaem1K1iuAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1526049830; bh=b
    ubCCzPP0hp6WvmxnM6SyoHngpS3mVkUi9wz1KlRdd8=; b=MHGMzeQh/Befgs3px
    /eD5N+Qi6UjyOUs16AbEAfLjejGH6r3ra9B688S/oc/DPmy3wigsO/2Is5/0Tpa1
    Zl9F1Hmd/Ocyi1juazK7oWvOF7XPMIZwr6hrkHUvew3nbeH952qSHcweX2Nu3/uB
    0fq8CnPcul9oGf5OtlG2N1KO9sJbxzEcWjcW6ZH2pJ90F5l1wFQll36+SzUuyhse
    5nqRmL5B5GA5Go3iElXdFrcfglWgRyUi9QvIolFPUraFA11iabbP9f2jcXzaXEb8
    qav19QdmyWzKAn9NOdx4ggs9kIMcvegh9fRAmErST3FsN2KsQ59uz4EpGyXWFUEd
    KLU4Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMeKPuuzLAbU6mBO8FVMDtw/ndpN26C2TjfMvZn/vI4r+nfzv2uHUtVsQ2mrsuQP3rKrc85U5wuFt/Lk5gl9RmhtSs6YYdItjc/cy+jo1kmyhpWhfHCM
    vBTl8VlifaCqT4HpJYwrlk9VYECxyMkUO56OFU3st0q28Nd0h5r84dnbqbdt73DETzWUfVvVQXt/fu5JHzeDodwLOuziLdYY4Bf0bBRvLJHY2yFx4/EqygO6
    37Ad1r9lHhdCawrDnn9M2w==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VnNF1IyMAAAA:8
    a=VwQbUJbxAAAA:8 a=RPmV3-Ix6R1-ZhG2XEgA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeEKOns (ORCPT <rfc822;linux@kroah.com>);
        Fri, 11 May 2018 10:43:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753231AbeEKOmo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 May 2018 10:42:44 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: serge@hallyn.com, sunyuqiong1988@gmail.com, david.safford@ge.com,
        mkayaalp@cs.binghamton.edu, James.Bottomley@HansenPartnership.com,
        zohar@linux.vnet.ibm.com, ebiederm@xmission.com,
        john.johansen@canonical.com,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Subject: [RFC PATCH v4 2/5] ima: Add ns_status for storing namespaced iint data
Date: Fri, 11 May 2018 10:42:27 -0400
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180511144230.75384-1-stefanb@linux.vnet.ibm.com>
References: <20180511144230.75384-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051114-0012-0000-0000-00001634CC3C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009006; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01030767; UDB=6.00526815; IPR=6.00809898;
 MB=3.00021049; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-11 14:42:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051114-0013-0000-0000-000052B3631B
Message-Id: <20180511144230.75384-3-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110139
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>

This patch adds an rbtree to the IMA namespace structure that stores a
namespaced version of iint->flags in ns_status struct. Similar to the
integrity_iint_cache, both the iint ns_struct are looked up using the
inode pointer value. The lookup, allocate, and insertion code is also
similar, except ns_struct is not free'd when the inode is free'd.
Instead, the lookup verifies the i_ino and i_generation fields are also a
match. This could be replaced by a lazy clean up of the rbtree.

Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>

Changelog:
v2:
 * fixed tree traversal in __ima_ns_status_find()
---
 include/linux/ima.h                      |   3 +
 security/integrity/ima/Makefile          |   2 +-
 security/integrity/ima/ima.h             |  21 +++++
 security/integrity/ima/ima_init_ima_ns.c |  17 +++-
 security/integrity/ima/ima_ns.c          |   1 +
 security/integrity/ima/ima_ns_status.c   | 133 +++++++++++++++++++++++++++++++
 6 files changed, 173 insertions(+), 4 deletions(-)
 create mode 100644 security/integrity/ima/ima_ns_status.c

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 27a332cd0438..f0cc74c698e5 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -112,6 +112,9 @@ struct ima_namespace {
 	struct ucounts *ucounts;
 	struct ns_common ns;
 	struct ima_namespace *parent;
+	struct rb_root ns_status_tree;
+	rwlock_t ns_status_lock;
+	struct kmem_cache *ns_status_cache;
 };
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index cc60f726e651..b2a68940dd22 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -9,6 +9,6 @@ obj-$(CONFIG_IMA) += ima.o
 ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
 	 ima_policy.o ima_template.o ima_template_lib.o ima_init_ima_ns.o
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
-ima-$(CONFIG_IMA_NS) += ima_ns.o
+ima-$(CONFIG_IMA_NS) += ima_ns.o ima_ns_status.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f999328e5b49..0a644922c6e7 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -129,6 +129,14 @@ static inline void ima_load_kexec_buffer(void) {}
  */
 extern bool ima_canonical_fmt;
 
+struct ns_status {
+	struct rb_node rb_node;
+	struct inode *inode;
+	ino_t i_ino;
+	u32 i_generation;
+	unsigned long flags;
+};
+
 /* Internal IMA function definitions */
 int ima_init(void);
 int ima_fs_init(void);
@@ -296,6 +304,17 @@ int ima_ns_init(void);
 struct ima_namespace;
 int ima_init_namespace(struct ima_namespace *ns);
 
+#ifdef CONFIG_IMA_NS
+struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
+				    struct inode *inode);
+#else
+static inline struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
+						  struct inode *inode)
+{
+	return NULL;
+}
+#endif /* CONFIG_IMA_NS */
+
 /* LSM based policy rules require audit */
 #ifdef CONFIG_IMA_LSM_RULES
 
@@ -336,6 +355,8 @@ static inline struct ima_namespace *get_current_ns(void)
 	return current->nsproxy->ima_ns;
 }
 
+void free_ns_status_cache(struct ima_namespace *ns);
+
 #else
 
 static inline struct ima_namespace *get_current_ns(void)
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 0bd6c418b8e3..6c2830f61afe 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -13,17 +13,28 @@
 #include <linux/user_namespace.h>
 #include <linux/proc_ns.h>
 #include <linux/ima.h>
+#include <linux/slab.h>
 
 #include "ima.h"
 
 int ima_init_namespace(struct ima_namespace *ns)
 {
+	int ret = 0;
+
+	ns->ns_status_tree = RB_ROOT;
+	rwlock_init(&ns->ns_status_lock);
+	ns->ns_status_cache = KMEM_CACHE(ns_status, SLAB_PANIC);
+	if (!ns->ns_status_cache)
+		return -ENOMEM;
+
 #ifdef CONFIG_IMA_NS
 	ns->ns.ops = &imans_operations;
-	return ns_alloc_inum(&ns->ns);
-#else
-	return 0;
+	ret = ns_alloc_inum(&ns->ns);
+	if (ret)
+		kmem_cache_destroy(ns->ns_status_cache);
 #endif
+
+	return ret;
 }
 
 int __init ima_ns_init(void)
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 8e37d7ac5d34..e0c4d66aab79 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -101,6 +101,7 @@ static void destroy_ima_ns(struct ima_namespace *ns)
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
 	dec_ima_namespaces(ns->ucounts);
+	free_ns_status_cache(ns);
 	kfree(ns);
 }
 
diff --git a/security/integrity/ima/ima_ns_status.c b/security/integrity/ima/ima_ns_status.c
new file mode 100644
index 000000000000..c432d1b70d6f
--- /dev/null
+++ b/security/integrity/ima/ima_ns_status.c
@@ -0,0 +1,133 @@
+/*
+ * Copyright (C) 2016-2018 IBM Corporation
+ * Author:
+ *  Yuqiong Sun <suny@us.ibm.com>
+ *  Stefan Berger <stefanb@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ */
+
+#include <linux/user_namespace.h>
+#include <linux/proc_ns.h>
+#include <linux/ima.h>
+
+#include "ima.h"
+
+void free_ns_status_cache(struct ima_namespace *ns)
+{
+	struct ns_status *status, *next;
+
+	write_lock(&ns->ns_status_lock);
+	rbtree_postorder_for_each_entry_safe(status, next,
+					     &ns->ns_status_tree, rb_node)
+		kmem_cache_free(ns->ns_status_cache, status);
+	ns->ns_status_tree = RB_ROOT;
+	write_unlock(&ns->ns_status_lock);
+	kmem_cache_destroy(ns->ns_status_cache);
+}
+
+/*
+ * __ima_ns_status_find - return the ns_status associated with an inode
+ */
+static struct ns_status *__ima_ns_status_find(struct ima_namespace *ns,
+					      struct inode *inode)
+{
+	struct ns_status *status;
+	struct rb_node *n = ns->ns_status_tree.rb_node;
+
+	while (n) {
+		status = rb_entry(n, struct ns_status, rb_node);
+
+		if (inode < status->inode)
+			n = n->rb_left;
+		else if (inode > status->inode)
+			n = n->rb_right;
+		else
+			break;
+	}
+	if (!n)
+		return NULL;
+
+	return status;
+}
+
+/*
+ * ima_ns_status_find - return the ns_status associated with an inode
+ */
+static struct ns_status *ima_ns_status_find(struct ima_namespace *ns,
+					    struct inode *inode)
+{
+	struct ns_status *status;
+
+	read_lock(&ns->ns_status_lock);
+	status = __ima_ns_status_find(ns, inode);
+	read_unlock(&ns->ns_status_lock);
+
+	return status;
+}
+
+void insert_ns_status(struct ima_namespace *ns, struct inode *inode,
+		      struct ns_status *status)
+{
+	struct rb_node **p;
+	struct rb_node *node, *parent = NULL;
+	struct ns_status *test_status;
+
+	p = &ns->ns_status_tree.rb_node;
+	while (*p) {
+		parent = *p;
+		test_status = rb_entry(parent, struct ns_status, rb_node);
+		if (inode < test_status->inode)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+	node = &status->rb_node;
+	rb_link_node(node, parent, p);
+	rb_insert_color(node, &ns->ns_status_tree);
+}
+
+struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
+				    struct inode *inode)
+{
+	struct ns_status *status;
+	int skip_insert = 0;
+
+	status = ima_ns_status_find(ns, inode);
+	if (status) {
+		/*
+		 * Unlike integrity_iint_cache we are not free'ing the
+		 * ns_status data when the inode is free'd. So, in addition to
+		 * checking the inode pointer, we need to make sure the
+		 * (i_generation, i_ino) pair matches as well. In the future
+		 * we might want to add support for lazily walking the rbtree
+		 * to clean it up.
+		 */
+		if (inode->i_ino == status->i_ino &&
+		    inode->i_generation == status->i_generation)
+			return status;
+
+		/* Same inode number is reused, overwrite the ns_status */
+		skip_insert = 1;
+	} else {
+		status = kmem_cache_alloc(ns->ns_status_cache, GFP_NOFS);
+		if (!status)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	write_lock(&ns->ns_status_lock);
+
+	if (!skip_insert)
+		insert_ns_status(ns, inode, status);
+
+	status->inode = inode;
+	status->i_ino = inode->i_ino;
+	status->i_generation = inode->i_generation;
+	status->flags = 0UL;
+
+	write_unlock(&ns->ns_status_lock);
+
+	return status;
+}
-- 
2.14.3

