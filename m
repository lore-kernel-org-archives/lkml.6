Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-52214-1519433594-2-7949428872643669242
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519433593; b=xDkxHjfIt8T7DXkmrbS5HCIgtnptVGaaYEFL2EIC6FzuCmv
    bkvvmJYus/2aXO66uFjSrn+TxO2/uvv071IrjucQY0VqSMPFaXnpu6WFtMgIM548
    WGUkeG5viM0hhOJmdyIw/ZvX0u+8Y6VVz1Zy2pvSc+s82mifpJLgUjHfmsMm2syB
    yG5ifg4WNuOS5UJivVlGb9J6dPQ0ewD8RlkiG2vO+yVLj0wqIpW+M7fNiu69XvDA
    1lFbGJbugia+2KRjuijQhewtn2LJ0MsYhrchErByFknMZA1ytRfsLiDh6O+dqVEh
    gsfOhnmSGEbOuzHDRf3k7ZSRNwrNdcTAiWrRCoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519433593; bh=Kf/cUYuXMUryoGnK1rMJNeI7PZLoL9Nj7y+935Om2dQ=; b=g
    3gYUu9O7dVb7CRK3VM+AJ15gt9QJpYd2MYDkIJMsCrOXmmkp4219TIQxYUzZ4gyp
    aBAXo1V3ZjYiuYuO0kNIB/gXafUWBQDaVCHtlq4QfmZxFOlGX8XTzK+A6vi/2xyc
    uZnObGFGVgxGpIU72UZFf3JtlcnTpvbKQ2CqbtKR3fTbyS1o3RKwghnmM5tnjuMC
    KwF60m58dLTZ7RizpgDceRQLaMIh9zCjSLPr7bIFtsCclNxB8U1h8t1n3IpQnuk/
    ZEAcM+kIABcwztRQDUuJTsx35LYe5bxMz3KitooVtkPBGksGTWAAecT4pV0Ek49Z
    iAHzMj0NxqZGX067eNFMQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeBXAww (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 19:52:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:14228 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752782AbeBXAwt (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 19:52:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,385,1515484800";
   d="scan'208";a="33189734"
Subject: [PATCH v3 6/6] vfio: disable filesystem-dax page pinning
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Haozhong Zhang <haozhong.zhang@intel.com>,
        Michal Hocko <mhocko@suse.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@kvack.org, Alex Williamson <alex.williamson@redhat.com>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Date: Fri, 23 Feb 2018 16:43:43 -0800
Message-ID: <151943302342.29249.273948227195246135.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151943298533.29249.14597996053028346159.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151943298533.29249.14597996053028346159.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Filesystem-DAX is incompatible with 'longterm' page pinning. Without
page cache indirection a DAX mapping maps filesystem blocks directly.
This means that the filesystem must not modify a file's block map while
any page in a mapping is pinned. In order to prevent the situation of
userspace holding of filesystem operations indefinitely, disallow
'longterm' Filesystem-DAX mappings.

RDMA has the same conflict and the plan there is to add a 'with lease'
mechanism to allow the kernel to notify userspace that the mapping is
being torn down for block-map maintenance. Perhaps something similar can
be put in place for vfio.

Note that xfs and ext4 still report:

   "DAX enabled. Warning: EXPERIMENTAL, use at your own risk"

...at mount time, and resolving the dax-dma-vs-truncate problem is one
of the last hurdles to remove that designation.

Acked-by: Alex Williamson <alex.williamson@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: kvm@vger.kernel.org
Cc: <stable@vger.kernel.org>
Reported-by: Haozhong Zhang <haozhong.zhang@intel.com>
Fixes: d475c6346a38 ("dax,ext2: replace XIP read and write with DAX I/O")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/vfio/vfio_iommu_type1.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index e30e29ae4819..45657e2b1ff7 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -338,11 +338,12 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
 {
 	struct page *page[1];
 	struct vm_area_struct *vma;
+	struct vm_area_struct *vmas[1];
 	int ret;
 
 	if (mm == current->mm) {
-		ret = get_user_pages_fast(vaddr, 1, !!(prot & IOMMU_WRITE),
-					  page);
+		ret = get_user_pages_longterm(vaddr, 1, !!(prot & IOMMU_WRITE),
+					      page, vmas);
 	} else {
 		unsigned int flags = 0;
 
@@ -351,7 +352,18 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
 
 		down_read(&mm->mmap_sem);
 		ret = get_user_pages_remote(NULL, mm, vaddr, 1, flags, page,
-					    NULL, NULL);
+					    vmas, NULL);
+		/*
+		 * The lifetime of a vaddr_get_pfn() page pin is
+		 * userspace-controlled. In the fs-dax case this could
+		 * lead to indefinite stalls in filesystem operations.
+		 * Disallow attempts to pin fs-dax pages via this
+		 * interface.
+		 */
+		if (ret > 0 && vma_is_fsdax(vmas[0])) {
+			ret = -EOPNOTSUPP;
+			put_page(page[0]);
+		}
 		up_read(&mm->mmap_sem);
 	}
 
