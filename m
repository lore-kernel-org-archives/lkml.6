Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6378CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058132172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQ6Jw9wO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058132172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeHCIjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:39:01 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42855 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeHCIjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:39:01 -0400
Received: by mail-pl0-f65.google.com with SMTP id z7-v6so2134315plo.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 23:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lRdsqnyz8TgvRJZuaBgDZJMLmh/ZbILZ2fnea/eJUFk=;
        b=rQ6Jw9wOZcgtjN89tjYdZcytti1MlLkVRChlF+Gg9oCmBmMTTK/PWSdikO2sr573Ct
         IgC5+XYl87of31yfQPAb5mkldRr1KhWiKlNW1YbYTHxA02cVgTqmjQFLB3/wl17dsRPe
         uiFWtnLbldLHcYfneFJWLJc8+OQ2xBT3iJ0zMRiW/k9X0dSAnLcqD7brNaekpUmZVh2D
         YBcl3qSXZFahYWb10ISyVR6yFQ2Rtt2Z5DERnvpQayS2F+EWcZeTyg57glG55Sf6lcPR
         rEbVhQijdDlwdhi++Qjhd6OzX5sTwYFYwTyGVL3hY7MLs2aJnW5ZgPZr6kUMw3MY8WwM
         FcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lRdsqnyz8TgvRJZuaBgDZJMLmh/ZbILZ2fnea/eJUFk=;
        b=EEPfydTBh8xCUtVoCXBmGJ0RzkXR/crv8+lChx8LQcpS5Cz/7JNZykv83s+80wMhMY
         A/31yDuIFD/w/4wwaWJ7P5EEo5/T//rxXUxQfWq4xuSdJ7tIujUNWqKsmueT/BKuvnve
         no+3zJ4CP4PpHgxC1K1YTbbdVx2GygLeL8MvHMOP5h0DUx5EhUdTW9bveu+YeqvmsufG
         jB15rx+NzOOEMgQY1jIygwFAgcT0h3FYlSq/mmUZeoU+CT3v/I1dwRdIhp/aKiM6nk57
         94G/0yIOakyfKCAU54Fs6IO2ENltWncag1obqiuWqaomN3KgZtEx0CJveMAIp+eprMNN
         k+GQ==
X-Gm-Message-State: AOUpUlHliLgQDKq+R/BYXXyaoprTQeTLzPlAqLYeXK9DcmNEZ2IdYQCP
        t4Q7UPKrrHjTfKol/5jLU2M=
X-Google-Smtp-Source: AAOMgpcBmer+DbC1tFhbiUK2JcYa86fbq47puVlu4zcyMv5QhC4Inw29yvssfhy6tZIwzxWHZUsPdw==
X-Received: by 2002:a17:902:1101:: with SMTP id d1-v6mr2282623pla.131.1533278652081;
        Thu, 02 Aug 2018 23:44:12 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id q140-v6sm4880289pgq.11.2018.08.02.23.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 23:44:11 -0700 (PDT)
From:   Rashmica Gupta <rashmica.g@gmail.com>
To:     toshi.kani@hpe.com, tglx@linutronix.de, akpm@linux-foundation.org,
        bp@suse.de, brijesh.singh@amd.com, thomas.lendacky@amd.com,
        jglisse@redhat.com, gregkh@linuxfoundation.org,
        baiyaowei@cmss.chinamobile.com, dan.j.williams@intel.com,
        mhocko@suse.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        malat@debian.org, pasha.tatashin@oracle.com, bhelgaas@google.com,
        osalvador@techadventures.net, yasu.isimatu@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Rashmica Gupta <rashmica.g@gmail.com>
Subject: [RESEND PATCH] resource: Merge resources on a node when hot-adding memory
Date:   Fri,  3 Aug 2018 16:43:57 +1000
Message-Id: <20180803064357.3757-1-rashmica.g@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hot-removing memory release_mem_region_adjustable() splits
iomem resources if they are not the exact size of the memory being
hot-deleted. Adding this memory back to the kernel adds a new
resource.

Eg a node has memory 0x0 - 0xfffffffff. Offlining and hot-removing
1GB from 0xf40000000 results in the single resource 0x0-0xfffffffff being
split into two resources: 0x0-0xf3fffffff and 0xf80000000-0xfffffffff.

When we hot-add the memory back we now have three resources:
0x0-0xf3fffffff, 0xf40000000-0xf7fffffff, and 0xf80000000-0xfffffffff.

Now if we try to remove a section of memory that overlaps these resources,
like 2GB from 0xf40000000, release_mem_region_adjustable() fails as it
expects the chunk of memory to be within the boundaries of a single
resource.

This patch adds a function request_resource_and_merge(). This is called
instead of request_resource_conflict() when registering a resource in
add_memory(). It calls request_resource_conflict() and if there are
no conflicts we attempt to merge contiguous resources on the node.

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
---

[Resending because there is no second patch. Don't send patches on
Friday afternoons...]

 include/linux/ioport.h         |   2 +
 include/linux/memory_hotplug.h |   2 +-
 kernel/resource.c              | 110 +++++++++++++++++++++++++++++++++++++++++
 mm/memory_hotplug.c            |  29 ++++-------
 4 files changed, 122 insertions(+), 21 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index da0ebaec25f0..f5b93a711e86 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -189,6 +189,8 @@ extern int allocate_resource(struct resource *root, struct resource *new,
 						       resource_size_t,
 						       resource_size_t),
 			     void *alignf_data);
+extern struct resource *request_resource_and_merge(struct resource *parent,
+						   struct resource *new, int nid);
 struct resource *lookup_resource(struct resource *root, resource_size_t start);
 int adjust_resource(struct resource *res, resource_size_t start,
 		    resource_size_t size);
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 4e9828cda7a2..9c00f97c8cc6 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -322,7 +322,7 @@ static inline void remove_memory(int nid, u64 start, u64 size) {}
 extern int walk_memory_range(unsigned long start_pfn, unsigned long end_pfn,
 		void *arg, int (*func)(struct memory_block *, void *));
 extern int add_memory(int nid, u64 start, u64 size);
-extern int add_memory_resource(int nid, struct resource *resource, bool online);
+extern int add_memory_resource(int nid, u64 start, u64 size, bool online);
 extern int arch_add_memory(int nid, u64 start, u64 size,
 		struct vmem_altmap *altmap, bool want_memblock);
 extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
diff --git a/kernel/resource.c b/kernel/resource.c
index 30e1bc68503b..18a405c1b4ff 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1621,3 +1621,113 @@ static int __init strict_iomem(char *str)
 }
 
 __setup("iomem=", strict_iomem);
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+/*
+ * Attempt to merge resource and it's sibling
+ */
+static int merge_resources(struct resource *res)
+{
+	struct resource *next;
+	struct resource *tmp;
+	uint64_t size;
+	int ret = -EINVAL;
+
+	next = res->sibling;
+
+	/*
+	 * Not sure how to handle two different children. So only attempt
+	 * to merge two resources if neither have children, only one has a
+	 * child or if both have the same child.
+	 */
+	if ((res->child && next->child) && (res->child != next->child))
+		return ret;
+
+	if (res->end + 1 != next->start)
+		return ret;
+
+	if (res->flags != next->flags)
+		return ret;
+
+	/* Update sibling and child of resource */
+	res->sibling = next->sibling;
+	tmp = res->child;
+	if (!res->child)
+		res->child = next->child;
+
+	size = next->end - res->start + 1;
+	ret = __adjust_resource(res, res->start, size);
+	if (ret) {
+		/* Failed so restore resource to original state */
+		res->sibling = next;
+		res->child = tmp;
+		return ret;
+	}
+
+	free_resource(next);
+
+	return ret;
+}
+
+/*
+ * Attempt to merge resources on the node
+ */
+static void merge_node_resources(int nid, struct resource *parent)
+{
+	struct resource *res;
+	uint64_t start_addr;
+	uint64_t end_addr;
+	int ret;
+
+	start_addr = node_start_pfn(nid) << PAGE_SHIFT;
+	end_addr = node_end_pfn(nid) << PAGE_SHIFT;
+
+	write_lock(&resource_lock);
+
+	/* Get the first resource */
+	res = parent->child;
+
+	while (res) {
+		/* Check that the resource is within the node */
+		if (res->start < start_addr) {
+			res = res->sibling;
+			continue;
+		}
+		/* Exit if resource is past end of node */
+		if (res->sibling->end > end_addr)
+			break;
+
+		ret = merge_resources(res);
+		if (!ret)
+			continue;
+		res = res->sibling;
+	}
+	write_unlock(&resource_lock);
+}
+
+/**
+ * request_resource_and_merge() - request an I/O or memory resource for hot-add
+ * @parent: parent resource descriptor
+ * @new: resource descriptor desired by caller
+ * @nid: node id of the node we want the resource on
+ *
+ * Returns NULL for success and conflict resource on error.
+ * If no conflict resource then attempt to merge resources on the node.
+ *
+ * This is intended to cleanup the fragmentation of resources that occurs when
+ * hot-deleting memory (see release_mem_region_adjustable).
+ */
+struct resource *request_resource_and_merge(struct resource *parent,
+					    struct resource *new, int nid)
+{
+	struct resource *conflict;
+
+	conflict = request_resource_conflict(parent, new);
+
+	if (conflict)
+		return conflict;
+
+	merge_node_resources(nid, parent);
+	return NULL;
+}
+#endif /* CONFIG_MEMORY_HOTPLUG */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7deb49f69e27..989774afcf30 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -97,7 +97,7 @@ void mem_hotplug_done(void)
 }
 
 /* add this memory to iomem resource */
-static struct resource *register_memory_resource(u64 start, u64 size)
+static struct resource *register_memory_resource(int nid, u64 start, u64 size)
 {
 	struct resource *res, *conflict;
 	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
@@ -108,7 +108,7 @@ static struct resource *register_memory_resource(u64 start, u64 size)
 	res->start = start;
 	res->end = start + size - 1;
 	res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
-	conflict =  request_resource_conflict(&iomem_resource, res);
+	conflict =  request_resource_and_merge(&iomem_resource, res, nid);
 	if (conflict) {
 		if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
 			pr_debug("Device unaddressable memory block "
@@ -122,15 +122,6 @@ static struct resource *register_memory_resource(u64 start, u64 size)
 	return res;
 }
 
-static void release_memory_resource(struct resource *res)
-{
-	if (!res)
-		return;
-	release_resource(res);
-	kfree(res);
-	return;
-}
-
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
 void get_page_bootmem(unsigned long info,  struct page *page,
 		      unsigned long type)
@@ -1096,17 +1087,13 @@ static int online_memory_block(struct memory_block *mem, void *arg)
 }
 
 /* we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG */
-int __ref add_memory_resource(int nid, struct resource *res, bool online)
+int __ref add_memory_resource(int nid, u64 start, u64 size, bool online)
 {
-	u64 start, size;
 	pg_data_t *pgdat = NULL;
 	bool new_pgdat;
 	bool new_node;
 	int ret;
 
-	start = res->start;
-	size = resource_size(res);
-
 	ret = check_hotplug_memory_range(start, size);
 	if (ret)
 		return ret;
@@ -1195,13 +1182,15 @@ int __ref add_memory(int nid, u64 start, u64 size)
 	struct resource *res;
 	int ret;
 
-	res = register_memory_resource(start, size);
+	res = register_memory_resource(nid, start, size);
 	if (IS_ERR(res))
 		return PTR_ERR(res);
 
-	ret = add_memory_resource(nid, res, memhp_auto_online);
-	if (ret < 0)
-		release_memory_resource(res);
+	ret = add_memory_resource(nid, start, size, memhp_auto_online);
+	if (ret < 0) {
+		release_mem_region_adjustable(&iomem_resource, start, size);
+		kfree(res);
+	}
 	return ret;
 }
 EXPORT_SYMBOL_GPL(add_memory);
-- 
2.14.4

