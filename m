Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3649678-1527052841-2-12841201596596444143
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527052840; b=Dr4g6YBAiRC6TAOTXU11wQnz9QgLLhtUgRtYE2P50UpY0Lv4ZL
    q1yaa8HRg8XbkXxzuLdNtrZBJgvDSoNIrtXmWpH41eWeJ0Vv6lZ1252qFbbT59F3
    ZQTuwn7BiDH8ooo6gTn4n7jpTstIX9aZEhWkodyTvjnWZW3fjcdn4wtkMaEBnu+E
    gMUYD979DpyH9LEgr3gzC3cVipN7jPqeCVlCRoxfhrhalWAMK0LcR20c0tSv9zHJ
    9IUXaY8ni8XDQHjnrjVcYhlpu5wwHCb0AqAz0qNGq6zdOUa1WXBB4pIg1Xu06TnF
    geNH9BXuPmCC7TjLLNfIB7PhgnFR5mbEJvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527052840;
    bh=fRU23vfxtHWn5cqggtVjESrTSQ30jEX1e5V0p5AwHrM=; b=bKzDBb3G5LWg
    W/3ySXEZ6i6cUpcLBvWTl4AWEGM14hDaR7IO/QM20TEBwcgxE+XSy4vlvJLqBebO
    CgACT7Z7+lLs7+b5fEBgOtPdNNHQpzRvjQENzP1Ibz5cJQfLmAcLK83VdiFcJ4mu
    3+2wNbEe5iqfBGfwqIfOXTIaRALMLe/gvHCfe/UL6CPt6YEd98S/+F6RVbpgkR3w
    4Llq48+dsdOSRrfYvYKRt+DY7QzXRwbmJRX1db6GeRPq/lBGjmg4GVI91MRSTvZL
    oH58TuvU1qQz4DFmgfS9BF5UkVt69ASMUESngJppAbIm7T+DgNNgsgV/PMxcsluv
    oedWFKTK7g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCUZ/PsVGmPlNJearO2eTvshErfNj9KDEmP4hUbGnuDIyDRkDaaRNHGlks6SZ/JsapsJgwXx3TE/bO/9WIGaZIod4OIXDLwm1e3HAcVSxO+DC0Tu/ePa
    WQOTOjvCsEJSr5qiK0PfvFUXEK6J3JQTMdT01ut4FAOUBVBcUBOVX/73nP0n2k/orcMiwsaitia9DUkQnJX1e6BHhFvhr72pQEc8pAwsE1Buigjb6ks4By2U
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=gXLdhW2jAAAA:8 a=QyXUC8HyAAAA:8
    a=DgC3iflxQ2nLEFcg8YQA:9 a=Wde2UB5fOfEum_Zu:21 a=9gISZVg1zcSShJ-v:21
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Dn9eIPSr_RzuO0KTJioD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754020AbeEWFUh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 01:20:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:63070 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754004AbeEWFUb (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 23 May 2018 01:20:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,431,1520924400";
   d="scan'208";a="58260587"
Subject: [PATCH v2 3/7] mm, devm_memremap_pages: Fix shutdown handling
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Cc: stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date: Tue, 22 May 2018 22:10:34 -0700
Message-ID: <152705223396.21414.13388289577013917472.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152705221686.21414.771870778478134768.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152705221686.21414.771870778478134768.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The last step before devm_memremap_pages() returns success is to
allocate a release action, devm_memremap_pages_release(), to tear the
entire setup down. However, the result from devm_add_action() is not
checked.

Checking the error from devm_add_action() is not enough. The api
currently relies on the fact that the percpu_ref it is using is killed
by the time the devm_memremap_pages_release() is run. Rather than
continue this awkward situation, offload the responsibility of killing
the percpu_ref to devm_memremap_pages_release() directly. This allows
devm_memremap_pages() to do the right thing  relative to init failures
and shutdown.

Without this change we could fail to register the teardown of
devm_memremap_pages(). The likelihood of hitting this failure is tiny as
small memory allocations almost always succeed. However, the impact of
the failure is large given any future reconfiguration, or
disable/enable, of an nvdimm namespace will fail forever as subsequent
calls to devm_memremap_pages() will fail to setup the pgmap_radix since
there will be stale entries for the physical address range.

Cc: <stable@vger.kernel.org>
Fixes: e8d513483300 ("memremap: change devm_memremap_pages interface...")
Cc: Christoph Hellwig <hch@lst.de>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Reported-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/pmem.c                |   10 ++--------
 drivers/nvdimm/pmem.c             |   18 ++++++++----------
 include/linux/memremap.h          |    7 +++++--
 kernel/memremap.c                 |   36 +++++++++++++++++++-----------------
 tools/testing/nvdimm/test/iomap.c |   21 ++++++++++++++++++---
 5 files changed, 52 insertions(+), 40 deletions(-)

diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index fd49b24fd6af..54cba20c8ba6 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -48,9 +48,8 @@ static void dax_pmem_percpu_exit(void *data)
 	percpu_ref_exit(ref);
 }
 
-static void dax_pmem_percpu_kill(void *data)
+static void dax_pmem_percpu_kill(struct percpu_ref *ref)
 {
-	struct percpu_ref *ref = data;
 	struct dax_pmem *dax_pmem = to_dax_pmem(ref);
 
 	dev_dbg(dax_pmem->dev, "trace\n");
@@ -111,15 +110,10 @@ static int dax_pmem_probe(struct device *dev)
 		return rc;
 
 	dax_pmem->pgmap.ref = &dax_pmem->ref;
-	addr = devm_memremap_pages(dev, &dax_pmem->pgmap);
+	addr = devm_memremap_pages(dev, &dax_pmem->pgmap, dax_pmem_percpu_kill);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
 
-	rc = devm_add_action_or_reset(dev, dax_pmem_percpu_kill,
-							&dax_pmem->ref);
-	if (rc)
-		return rc;
-
 	/* adjust the dax_region resource to the start of data */
 	memcpy(&res, &dax_pmem->pgmap.res, sizeof(res));
 	res.start += le64_to_cpu(pfn_sb->dataoff);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 9d714926ecf5..49c9c1bab438 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -279,8 +279,11 @@ static void pmem_release_queue(void *q)
 	blk_cleanup_queue(q);
 }
 
-static void pmem_freeze_queue(void *q)
+static void pmem_freeze_queue(struct percpu_ref *ref)
 {
+	struct request_queue *q;
+
+	q = container_of(ref, typeof(*q), q_usage_counter);
 	blk_freeze_queue_start(q);
 }
 
@@ -353,7 +356,8 @@ static int pmem_attach_disk(struct device *dev,
 	pmem->pfn_flags = PFN_DEV;
 	pmem->pgmap.ref = &q->q_usage_counter;
 	if (is_nd_pfn(dev)) {
-		addr = devm_memremap_pages(dev, &pmem->pgmap);
+		addr = devm_memremap_pages(dev, &pmem->pgmap,
+				pmem_freeze_queue);
 		pfn_sb = nd_pfn->pfn_sb;
 		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
 		pmem->pfn_pad = resource_size(res) -
@@ -364,20 +368,14 @@ static int pmem_attach_disk(struct device *dev,
 	} else if (pmem_should_map_pages(dev)) {
 		memcpy(&pmem->pgmap.res, &nsio->res, sizeof(pmem->pgmap.res));
 		pmem->pgmap.altmap_valid = false;
-		addr = devm_memremap_pages(dev, &pmem->pgmap);
+		addr = devm_memremap_pages(dev, &pmem->pgmap,
+				pmem_freeze_queue);
 		pmem->pfn_flags |= PFN_MAP;
 		memcpy(&bb_res, &pmem->pgmap.res, sizeof(bb_res));
 	} else
 		addr = devm_memremap(dev, pmem->phys_addr,
 				pmem->size, ARCH_MEMREMAP_PMEM);
 
-	/*
-	 * At release time the queue must be frozen before
-	 * devm_memremap_pages is unwound
-	 */
-	if (devm_add_action_or_reset(dev, pmem_freeze_queue, q))
-		return -ENOMEM;
-
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
 	pmem->virt_addr = addr;
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 7b4899c06f49..b5e894133cf6 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -106,6 +106,7 @@ typedef void (*dev_page_free_t)(struct page *page, void *data);
  * @altmap: pre-allocated/reserved memory for vmemmap allocations
  * @res: physical address range covered by @ref
  * @ref: reference count that pins the devm_memremap_pages() mapping
+ * @kill: callback to transition @ref to the dead state
  * @dev: host device of the mapping for debug
  * @data: private data pointer for page_free()
  * @type: memory type: see MEMORY_* in memory_hotplug.h
@@ -117,13 +118,15 @@ struct dev_pagemap {
 	bool altmap_valid;
 	struct resource res;
 	struct percpu_ref *ref;
+	void (*kill)(struct percpu_ref *ref);
 	struct device *dev;
 	void *data;
 	enum memory_type type;
 };
 
 #ifdef CONFIG_ZONE_DEVICE
-void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
+void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap,
+		void (*kill)(struct percpu_ref *));
 struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 		struct dev_pagemap *pgmap);
 
@@ -133,7 +136,7 @@ void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns);
 static inline bool is_zone_device_page(const struct page *page);
 #else
 static inline void *devm_memremap_pages(struct device *dev,
-		struct dev_pagemap *pgmap)
+		struct dev_pagemap *pgmap, void (*kill)(struct percpu_ref *))
 {
 	/*
 	 * Fail attempts to call devm_memremap_pages() without
diff --git a/kernel/memremap.c b/kernel/memremap.c
index dd11607671eb..dfec0801f652 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -293,14 +293,10 @@ static void devm_memremap_pages_release(void *data)
 	resource_size_t align_start, align_size;
 	unsigned long pfn;
 
+	pgmap->kill(pgmap->ref);
 	for_each_device_pfn(pfn, pgmap)
 		put_page(pfn_to_page(pfn));
 
-	if (percpu_ref_tryget_live(pgmap->ref)) {
-		dev_WARN(dev, "%s: page mapping is still live!\n", __func__);
-		percpu_ref_put(pgmap->ref);
-	}
-
 	/* pages are dead and unused, undo the arch mapping */
 	align_start = res->start & ~(SECTION_SIZE - 1);
 	align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
@@ -320,7 +316,8 @@ static void devm_memremap_pages_release(void *data)
 /**
  * devm_memremap_pages - remap and provide memmap backing for the given resource
  * @dev: hosting device for @res
- * @pgmap: pointer to a struct dev_pgmap
+ * @pgmap: pointer to a struct dev_pagemap
+ * @kill: routine to kill @pgmap->ref
  *
  * Notes:
  * 1/ At a minimum the res, ref and type members of @pgmap must be initialized
@@ -329,17 +326,15 @@ static void devm_memremap_pages_release(void *data)
  * 2/ The altmap field may optionally be initialized, in which case altmap_valid
  *    must be set to true
  *
- * 3/ pgmap.ref must be 'live' on entry and 'dead' before devm_memunmap_pages()
- *    time (or devm release event). The expected order of events is that ref has
- *    been through percpu_ref_kill() before devm_memremap_pages_release(). The
- *    wait for the completion of all references being dropped and
- *    percpu_ref_exit() must occur after devm_memremap_pages_release().
+ * 3/ pgmap->ref must be 'live' on entry and will be killed at
+ *    devm_memremap_pages_release() time, or if this routine fails.
  *
  * 4/ res is expected to be a host memory range that could feasibly be
  *    treated as a "System RAM" range, i.e. not a device mmio range, but
  *    this is not enforced.
  */
-void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
+void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap,
+		void (*kill)(struct percpu_ref *))
 {
 	resource_size_t align_start, align_size, align_end;
 	struct vmem_altmap *altmap = pgmap->altmap_valid ?
@@ -349,6 +344,9 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	pgprot_t pgprot = PAGE_KERNEL;
 	int error, nid, is_ram;
 
+	if (!pgmap->ref || !kill)
+		return ERR_PTR(-EINVAL);
+
 	align_start = res->start & ~(SECTION_SIZE - 1);
 	align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
 		- align_start;
@@ -358,12 +356,10 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	if (is_ram != REGION_DISJOINT) {
 		WARN_ONCE(1, "%s attempted on %s region %pr\n", __func__,
 				is_ram == REGION_MIXED ? "mixed" : "ram", res);
-		return ERR_PTR(-ENXIO);
+		error = -ENXIO;
+		goto err_init;
 	}
 
-	if (!pgmap->ref)
-		return ERR_PTR(-EINVAL);
-
 	pgmap->dev = dev;
 
 	mutex_lock(&pgmap_lock);
@@ -415,7 +411,11 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 		percpu_ref_get(pgmap->ref);
 	}
 
-	devm_add_action(dev, devm_memremap_pages_release, pgmap);
+	pgmap->kill = kill;
+	error = devm_add_action_or_reset(dev, devm_memremap_pages_release,
+			pgmap);
+	if (error)
+		return ERR_PTR(error);
 
 	return __va(res->start);
 
@@ -424,6 +424,8 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
  err_pfn_remap:
  err_radix:
 	pgmap_radix_release(res, pgoff);
+ err_init:
+	kill(pgmap->ref);
 	return ERR_PTR(error);
 }
 EXPORT_SYMBOL_GPL(devm_memremap_pages);
diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index ff9d3a5825e1..ad544e6476a9 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -104,14 +104,29 @@ void *__wrap_devm_memremap(struct device *dev, resource_size_t offset,
 }
 EXPORT_SYMBOL(__wrap_devm_memremap);
 
-void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
+static void nfit_test_kill(void *_pgmap)
+{
+	struct dev_pagemap *pgmap = _pgmap;
+
+	pgmap->kill(pgmap->ref);
+}
+
+void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap,
+		void (*kill)(struct percpu_ref *))
 {
 	resource_size_t offset = pgmap->res.start;
 	struct nfit_test_resource *nfit_res = get_nfit_res(offset);
 
-	if (nfit_res)
+	if (nfit_res) {
+		int rc;
+
+		pgmap->kill = kill;
+		rc = devm_add_action_or_reset(dev, nfit_test_kill, pgmap);
+		if (rc)
+			return ERR_PTR(rc);
 		return nfit_res->buf + offset - nfit_res->res.start;
-	return devm_memremap_pages(dev, pgmap);
+	}
+	return devm_memremap_pages(dev, pgmap, kill);
 }
 EXPORT_SYMBOL(__wrap_devm_memremap_pages);
 
