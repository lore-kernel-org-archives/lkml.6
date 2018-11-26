Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B17C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FA82089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV+bCl74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27FA82089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbeKZV5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:57:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbeKZV5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:57:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21AC820645;
        Mon, 26 Nov 2018 11:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230197;
        bh=nAFsAxqrV0rOoqHHH7dkVjYJaDBSdSge5+osrDiAXQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TV+bCl742CM+eoVPdxS1nF8R21YLgjhHx3h5hfCRvtVuvL7wYx/jfEpXzMI+2VrMV
         6FBGK4YfxgNAxkdidOOigu/YbBz/t3Oc0DcZWMVsJGkmS2Wwoht5yqZoeornPQEBMI
         oaPnHpbdnSnhGZXXWk711cny47ZlC5SWHS4Rp7EQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [PATCH 4.19 001/118] drm/i915: Replace some PAGE_SIZE with I915_GTT_PAGE_SIZE
Date:   Mon, 26 Nov 2018 11:49:55 +0100
Message-Id: <20181126105059.888346300@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit f6e35cda66146106cfeb85ed65696e0f8e793fee upstream.

Use I915_GTT_PAGE_SIZE when talking about GTT pages rather than
physical pages.

There are some PAGE_SHIFTs left though. Not sure if we want to
introduce I915_GTT_PAGE_SHIFT or what?

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Suggested-by: Chris Wilson <chris@chris-wilson.co.uk> # at least some of it :)
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180913150405.706-1-ville.syrjala@linux.intel.com
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_drv.h     |    2 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c |   18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -2248,7 +2248,7 @@ static inline struct scatterlist *__sg_n
 #define for_each_sgt_dma(__dmap, __iter, __sgt)				\
 	for ((__iter) = __sgt_iter((__sgt)->sgl, true);			\
 	     ((__dmap) = (__iter).dma + (__iter).curr);			\
-	     (((__iter).curr += PAGE_SIZE) >= (__iter).max) ?		\
+	     (((__iter).curr += I915_GTT_PAGE_SIZE) >= (__iter).max) ?	\
 	     (__iter) = __sgt_iter(__sg_next((__iter).sgp), true), 0 : 0)
 
 /**
--- a/drivers/gpu/drm/i915/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/i915_gem_gtt.c
@@ -1058,7 +1058,7 @@ gen8_ppgtt_insert_pte_entries(struct i91
 	do {
 		vaddr[idx->pte] = pte_encode | iter->dma;
 
-		iter->dma += PAGE_SIZE;
+		iter->dma += I915_GTT_PAGE_SIZE;
 		if (iter->dma >= iter->max) {
 			iter->sg = __sg_next(iter->sg);
 			if (!iter->sg) {
@@ -1770,7 +1770,7 @@ static void gen6_dump_ppgtt(struct i915_
 
 			seq_printf(m, "\t\t(%03d, %04d) %08llx: ",
 				   pde, pte,
-				   (pde * GEN6_PTES + pte) * PAGE_SIZE);
+				   (pde * GEN6_PTES + pte) * I915_GTT_PAGE_SIZE);
 			for (i = 0; i < 4; i++) {
 				if (vaddr[pte + i] != scratch_pte)
 					seq_printf(m, " %08x", vaddr[pte + i]);
@@ -1910,7 +1910,7 @@ static void gen6_ppgtt_insert_entries(st
 	do {
 		vaddr[act_pte] = pte_encode | GEN6_PTE_ADDR_ENCODE(iter.dma);
 
-		iter.dma += PAGE_SIZE;
+		iter.dma += I915_GTT_PAGE_SIZE;
 		if (iter.dma == iter.max) {
 			iter.sg = __sg_next(iter.sg);
 			if (!iter.sg)
@@ -2048,7 +2048,7 @@ static int pd_vma_bind(struct i915_vma *
 {
 	struct i915_ggtt *ggtt = i915_vm_to_ggtt(vma->vm);
 	struct gen6_hw_ppgtt *ppgtt = vma->private;
-	u32 ggtt_offset = i915_ggtt_offset(vma) / PAGE_SIZE;
+	u32 ggtt_offset = i915_ggtt_offset(vma) / I915_GTT_PAGE_SIZE;
 	struct i915_page_table *pt;
 	unsigned int pde;
 
@@ -2174,7 +2174,7 @@ static struct i915_hw_ppgtt *gen6_ppgtt_
 	ppgtt->base.vm.i915 = i915;
 	ppgtt->base.vm.dma = &i915->drm.pdev->dev;
 
-	ppgtt->base.vm.total = I915_PDES * GEN6_PTES * PAGE_SIZE;
+	ppgtt->base.vm.total = I915_PDES * GEN6_PTES * I915_GTT_PAGE_SIZE;
 
 	i915_address_space_init(&ppgtt->base.vm, i915);
 
@@ -3031,7 +3031,7 @@ static unsigned int gen8_get_total_gtt_s
 		bdw_gmch_ctl = 1 << bdw_gmch_ctl;
 
 #ifdef CONFIG_X86_32
-	/* Limit 32b platforms to a 2GB GGTT: 4 << 20 / pte size * PAGE_SIZE */
+	/* Limit 32b platforms to a 2GB GGTT: 4 << 20 / pte size * I915_GTT_PAGE_SIZE */
 	if (bdw_gmch_ctl > 4)
 		bdw_gmch_ctl = 4;
 #endif
@@ -3729,9 +3729,9 @@ rotate_pages(const dma_addr_t *in, unsig
 			 * the entries so the sg list can be happily traversed.
 			 * The only thing we need are DMA addresses.
 			 */
-			sg_set_page(sg, NULL, PAGE_SIZE, 0);
+			sg_set_page(sg, NULL, I915_GTT_PAGE_SIZE, 0);
 			sg_dma_address(sg) = in[offset + src_idx];
-			sg_dma_len(sg) = PAGE_SIZE;
+			sg_dma_len(sg) = I915_GTT_PAGE_SIZE;
 			sg = sg_next(sg);
 			src_idx -= stride;
 		}
@@ -3744,7 +3744,7 @@ static noinline struct sg_table *
 intel_rotate_pages(struct intel_rotation_info *rot_info,
 		   struct drm_i915_gem_object *obj)
 {
-	const unsigned long n_pages = obj->base.size / PAGE_SIZE;
+	const unsigned long n_pages = obj->base.size / I915_GTT_PAGE_SIZE;
 	unsigned int size = intel_rotation_info_size(rot_info);
 	struct sgt_iter sgt_iter;
 	dma_addr_t dma_addr;


