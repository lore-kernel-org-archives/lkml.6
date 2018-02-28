Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519832058-2-14243146319819019725
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519832057; b=o7tt3xz6BJ7z+G4mbY2vgXRZeJhJ6SxcyM9ZEYzUvSCODTI
    xZ+A86oevnsvIvCbG78/FIKfuJtzynSIuzxnuIkXf1I33H9JuYtbUGhBOYLUv4Q7
    tmF+6tBNsHfD5tB0SDtot6rxqfFEsUQyb0KlgyIkJkdCUxTsacSp4Xjt5ZQ7H64x
    H7xaHhmWjdoz9Fmmh14cTEtZRrU+umnkusuHxJ2GyDkRcqhOOD4aPgxqXOSy21mG
    7cvQk/6wPJ55oXQ+zN31og9PMLY+ADCe4c91lmAPwM12h7iWUBt+0WSzSSloctdt
    ABLTHSdRj59pAW4MkviUnB4JEFGTKuGrBh0uJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832057; bh=wnlzroWSDXmPbNBvUK3
    TfBV7gdA6+ZNgvZJ/DZIMm/s=; b=UoPY+A7CBQh29kW7LBlyfwUFXFJf1hWr/fH
    5j+ubesnvlsQdWG9HKUV1/VVfdcxdiu3C1FfYD37vBCb96OUQCq03neU/QnOC4Km
    Pu/tkNfk3i9zrKJCHtNhV4nBmqJ216AxthIw71OXkS7QHrBrFMG7UvQGAnWifpDL
    b1ppagwRLmOvF7qcUXkdm2TXByIPO5jvX5EN3jD0N/SHIh04V2AYVnBoqBmx1uWk
    zaA9JTBvwwWt5SM2ZFqbcQ/aOSvJqfkd60CqdOTnXJpEd7kGrzXiRTyUHTICtbpt
    1e+6YIdPacK44jKTlQsz6ADdco960LxxuN6c8eB9HC9eGjVRzGw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933055AbeB1PcY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:32:24 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33313 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752859AbeB1PWi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:38 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Alex Williamson" <alex.williamson@redhat.com>,
        "Harsh Jain" <Harsh@chelsio.com>,
        "Robin Murphy" <robin.murphy@arm.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.606322283@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 006/254] iommu/vt-d: Fix scatterlist offset handling
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>

commit 29a90b70893817e2f2bb3cea40a29f5308e21b21 upstream.

The intel-iommu DMA ops fail to correctly handle scatterlists where
sg->offset is greater than PAGE_SIZE - the IOVA allocation is computed
appropriately based on the page-aligned portion of the offset, but the
mapping is set up relative to sg->page, which means it fails to actually
cover the whole buffer (and in the worst case doesn't cover it at all):

    (sg->dma_address + sg->dma_len) ----+
    sg->dma_address ---------+          |
    iov_pfn------+           |          |
                 |           |          |
                 v           v          v
iova:   a        b        c        d        e        f
        |--------|--------|--------|--------|--------|
                          <...calculated....>
                 [_____mapped______]
pfn:    0        1        2        3        4        5
        |--------|--------|--------|--------|--------|
                 ^           ^          ^
                 |           |          |
    sg->page ----+           |          |
    sg->offset --------------+          |
    (sg->offset + sg->length) ----------+

As a result, the caller ends up overrunning the mapping into whatever
lies beyond, which usually goes badly:

[  429.645492] DMAR: DRHD: handling fault status reg 2
[  429.650847] DMAR: [DMA Write] Request device [02:00.4] fault addr f2682000 ...

Whilst this is a fairly rare occurrence, it can happen from the result
of intermediate scatterlist processing such as scatterwalk_ffwd() in the
crypto layer. Whilst that particular site could be fixed up, it still
seems worthwhile to bring intel-iommu in line with other DMA API
implementations in handling this robustly.

To that end, fix the intel_map_sg() path to line up the mapping
correctly (in units of MM pages rather than VT-d pages to match the
aligned_nrpages() calculation) regardless of the offset, and use
sg_phys() consistently for clarity.

Reported-by: Harsh Jain <Harsh@chelsio.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed by: Ashok Raj <ashok.raj@intel.com>
Tested by: Jacob Pan <jacob.jun.pan@intel.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/iommu/intel-iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2008,10 +2008,12 @@ static int __domain_mapping(struct dmar_
 		uint64_t tmp;
 
 		if (!sg_res) {
+			unsigned int pgoff = sg->offset & ~PAGE_MASK;
+
 			sg_res = aligned_nrpages(sg->offset, sg->length);
-			sg->dma_address = ((dma_addr_t)iov_pfn << VTD_PAGE_SHIFT) + sg->offset;
+			sg->dma_address = ((dma_addr_t)iov_pfn << VTD_PAGE_SHIFT) + pgoff;
 			sg->dma_length = sg->length;
-			pteval = page_to_phys(sg_page(sg)) | prot;
+			pteval = (sg_phys(sg) - pgoff) | prot;
 			phys_pfn = pteval >> VTD_PAGE_SHIFT;
 		}
 
@@ -3345,7 +3347,7 @@ static int intel_nontranslate_map_sg(str
 
 	for_each_sg(sglist, sg, nelems, i) {
 		BUG_ON(!sg_page(sg));
-		sg->dma_address = page_to_phys(sg_page(sg)) + sg->offset;
+		sg->dma_address = sg_phys(sg);
 		sg->dma_length = sg->length;
 	}
 	return nelems;
