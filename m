Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3465232-1517867067-2-15468560356663351305
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517867066; b=l8UJj0j+YZEH6ImQ69XHS9gZkInqKotn+nPXux5tbOPGZZC
    RnRPRsVH/J9FW8tHC2K+5O7nAvg7nEsZ04xK9vj2LSmwyMDm1YSo6wLqCueUnNZx
    DpHsI7JEOCCjBkr/wAcGs8t7BSyTFtjFFUY5mwI49QcGUDzc2XPeq/3b/4UTg/ik
    hJGawSGM79Pqq7uuVhbfeGoWMa9GKQCKtoEoGlllguhcWfABYgmiUEYLVAdCShFZ
    mSyBqpSaqC+Lk5L7ar5i7gRFUbdvifREPd7JZ9275To7Wd/HoGm2uZ8rW1+8wCy4
    dBMXW6gLKFkphfanNZ0r5QnMDaIfkSbR1JKhfYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517867066; bh=kOJo7Q6ZkNzkadfSvzia+ee0bZzZIg3xsoOvU+RLU30=; b=B
    2j27q/4MkEgR9vFiA9krzigJK6IwJB150KTOGDwnq/e6vikM8dTmZI3VjOEE3kuE
    hYK8GMVkrMZH2+Jqio3hF513NRyTaABUd18XBuLmMRENXwMSS/7mpXUJZfci0eKm
    WuHqXaiSGBQUyq/cIG8vfIsHfczDQJ89DHLWxXZ+uAkI6xp8IMLkWDEeafH8jdHi
    aQp1Y2Co7V6IRRaxGbMlpqau8spH5TOp6w6vusfuUYsf+808BWyid3eV4YslfzcS
    EjOGkwLbKE4xUY1rgdHKKaG3MrMLlVD58hJXDOpDB9FzmMUNjxgnh1NUZT7dwbZn
    yyBLOtRewXfCg6Arryx1g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeBEVoZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 16:44:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16691 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752010AbeBEVoY (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 5 Feb 2018 16:44:24 -0500
Date: Mon, 5 Feb 2018 14:44:22 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>,
        Michal Hocko <mhocko@suse.com>, jack@suse.cz,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@lst.de, <aik@ozlabs.ru>
Subject: Re: [PATCH 3/3] vfio: disable filesystem-dax page pinning
Message-ID: <20180205144422.1ca67ab5@w520.home>
In-Reply-To: <151778553083.7139.6601964812589807125.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151778551496.7139.17808629759104553625.stgit@dwillia2-desk3.amr.corp.intel.com>
        <151778553083.7139.6601964812589807125.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 04 Feb 2018 15:05:30 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Filesystem-DAX is incompatible with 'longterm' page pinning. Without
> page cache indirection a DAX mapping maps filesystem blocks directly.
> This means that the filesystem must not modify a file's block map while
> any page in a mapping is pinned. In order to prevent the situation of
> userspace holding of filesystem operations indefinitely, disallow
> 'longterm' Filesystem-DAX mappings.
> 
> RDMA has the same conflict and the plan there is to add a 'with lease'
> mechanism to allow the kernel to notify userspace that the mapping is
> being torn down for block-map maintenance. Perhaps something similar can
> be put in place for vfio.
> 
> Note that xfs and ext4 still report:
> 
>    "DAX enabled. Warning: EXPERIMENTAL, use at your own risk"
> 
> ...at mount time, and resolving the dax-dma-vs-truncate problem is one
> of the last hurdles to remove that designation.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: kvm@vger.kernel.org
> Cc: <stable@vger.kernel.org>
> Reported-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Fixes: d475c6346a38 ("dax,ext2: replace XIP read and write with DAX I/O")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c |   18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

This isn't without some expense, a vfio mapping and un-mapping unit
test incurs ~1.5% increase in system time losing access to gup_fast().
Also, I think tce_iommu_use_page() is going to have the same problem, it
provides the same sort of functionality for a different vfio IOMMU
backend.  Please take this through your tree and I'll add a todo list
item to see how we might improve this.

Acked-by: Alex Williamson <alex.williamson@redhat.com>

Thanks,
Alex

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index e30e29ae4819..45657e2b1ff7 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -338,11 +338,12 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
>  {
>  	struct page *page[1];
>  	struct vm_area_struct *vma;
> +	struct vm_area_struct *vmas[1];
>  	int ret;
>  
>  	if (mm == current->mm) {
> -		ret = get_user_pages_fast(vaddr, 1, !!(prot & IOMMU_WRITE),
> -					  page);
> +		ret = get_user_pages_longterm(vaddr, 1, !!(prot & IOMMU_WRITE),
> +					      page, vmas);
>  	} else {
>  		unsigned int flags = 0;
>  
> @@ -351,7 +352,18 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
>  
>  		down_read(&mm->mmap_sem);
>  		ret = get_user_pages_remote(NULL, mm, vaddr, 1, flags, page,
> -					    NULL, NULL);
> +					    vmas, NULL);
> +		/*
> +		 * The lifetime of a vaddr_get_pfn() page pin is
> +		 * userspace-controlled. In the fs-dax case this could
> +		 * lead to indefinite stalls in filesystem operations.
> +		 * Disallow attempts to pin fs-dax pages via this
> +		 * interface.
> +		 */
> +		if (ret > 0 && vma_is_fsdax(vmas[0])) {
> +			ret = -EOPNOTSUPP;
> +			put_page(page[0]);
> +		}
>  		up_read(&mm->mmap_sem);
>  	}
>  
> 
