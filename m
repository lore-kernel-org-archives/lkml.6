Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-62429-1526464399-2-17857276852235721112
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526464398; b=Y2QyfI2ruhsWMMGsHLl2y6Nv55QhdQMRri9Z088A91gv9jyTBR
    rHfsktM4fu2dKW349M/Qj/fEZJQpjSeQwObUtOL0PMsWqb7h0mmaIBbX2vaUnt+C
    DYpGkjNLXHTD55bFIErTQCPqE2gmGuKnLAoisLtgxCPsUMrRO3HtIiUUbDVDgReG
    rMlOaGuho8rtiAzro5vKcNeGVW0rsM+WDjXUKQpG53H9NYPS9dMKkZLAaFgXOPwi
    JgBn2hHxp4OoiYP8fYnK+wNIT7Wch6dWnsG79m9tNNFtbuELy8YYTp4+wfDlXwDi
    Qf0On8ySEBlVr1gUZozEyC2lCqHCZDCQd4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526464398; bh=SOr827T3kiF1nBC85X7C0KkZmSKbYq
    fP8K9UOFsAWmg=; b=Mu5TepQIC1foe2IcTiG5JTci0NosyOuFZqjUEZJdQHcwGN
    mbw7cp2haZgy9fmiSRipL9Y40ArsIS5zt6FJK1o8UlPRaGgcaGL+qP73SXjModJG
    CyoYTejml2EzpzSp0gAk54a2jo4ngk4cfnftQXQafzlCg5ggpUdI7d9qmAMsBi7r
    eudOP0kSIhPML+vbJfBHrMNzEMEQgq8yLeQ1CugTayvbVpamUkCa+Y4kYPjbWiFP
    Q0rAAifSk+doU0tpowubVF9B9WSiAxCnZzB2a9k/bfP1N/4ERvS7Z04f4fxhnUHk
    LCdFNIsOBqjyes0RmVafC6rPtRS/Rq6bMnhHeqjg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=ffwll.ch header.i=@ffwll.ch header.b=aTGcpxD9 x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ffwll.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=BslAIUUr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ffwll.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=ffwll.ch header.i=@ffwll.ch header.b=aTGcpxD9 x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ffwll.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=BslAIUUr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ffwll.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJK2FUpdE4A2rt0Ew3NPwpCgcysVvBb50ltwDcRU61K6xWww3ysrrgI4vm+bX7ubo5Auu+5masApynOq1a07TgcE+VY44s0lI7Bb4WbnqDS6hP0VCXOl
    iVmXhaav8av2O17DLdPgv2RPBVo9ggE3toyRe/qspqg0/f14IOauMcalBzP2T2k7n3lcV7Dkf+JfkTMy63aXVEemsy41NS2rfxalg9HC+H8L4OlzcVNyGoVA
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=25-AhOLfAAAA:8 a=j5-RFwU6Y8ZpuiUXgKoA:9
    a=LwN9BIeHEuHFlBtg:21 a=P2ikhRCpPGHes7Iz:21 a=CjuIK1q_8ugA:10
    a=dnuY3_Gu-P7Vi9ynLKQe:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbeEPJxM (ORCPT <rfc822;linux@kroah.com>);
        Wed, 16 May 2018 05:53:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33212 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753280AbeEPJxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 May 2018 05:53:07 -0400
X-Google-Smtp-Source: AB8JxZopb8iG/gH3DVR+t1UO4oG+xZ9+YGXCt9gWNI4cVt2UaHW5wqYpu/kZ+aQoaUn8V7UPhigxuQ==
Date: Wed, 16 May 2018 11:53:03 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christoph Hellwig <hch@lst.de>
Cc: Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, devel@lists.orangefs.org,
        ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org, dri-devel@lists.freedesktop.org,
        lustre-devel@lists.lustre.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 10/14] vgem: separate errno from VM_FAULT_* values
Message-ID: <20180516095303.GH3438@phenom.ffwll.local>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        devel@lists.orangefs.org, ceph-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-mtd@lists.infradead.org,
        dri-devel@lists.freedesktop.org, lustre-devel@lists.lustre.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
References: <20180516054348.15950-1-hch@lst.de>
 <20180516054348.15950-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516054348.15950-11-hch@lst.de>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 07:43:44AM +0200, Christoph Hellwig wrote:
> And streamline the code in vgem_fault with early returns so that it is
> a little bit more readable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/vgem/vgem_drv.c | 51 +++++++++++++++------------------
>  1 file changed, 23 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
> index 2524ff116f00..a261e0aab83a 100644
> --- a/drivers/gpu/drm/vgem/vgem_drv.c
> +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> @@ -61,12 +61,13 @@ static void vgem_gem_free_object(struct drm_gem_object *obj)
>  	kfree(vgem_obj);
>  }
>  
> -static int vgem_gem_fault(struct vm_fault *vmf)
> +static vm_fault_t vgem_gem_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct drm_vgem_gem_object *obj = vma->vm_private_data;
>  	/* We don't use vmf->pgoff since that has the fake offset */
>  	unsigned long vaddr = vmf->address;
> +	struct page *page;
>  	int ret;
>  	loff_t num_pages;
>  	pgoff_t page_offset;
> @@ -85,35 +86,29 @@ static int vgem_gem_fault(struct vm_fault *vmf)
>  		ret = 0;
>  	}
>  	mutex_unlock(&obj->pages_lock);
> -	if (ret) {
> -		struct page *page;
> -
> -		page = shmem_read_mapping_page(
> -					file_inode(obj->base.filp)->i_mapping,
> -					page_offset);
> -		if (!IS_ERR(page)) {
> -			vmf->page = page;
> -			ret = 0;
> -		} else switch (PTR_ERR(page)) {
> -			case -ENOSPC:
> -			case -ENOMEM:
> -				ret = VM_FAULT_OOM;
> -				break;
> -			case -EBUSY:
> -				ret = VM_FAULT_RETRY;
> -				break;
> -			case -EFAULT:
> -			case -EINVAL:
> -				ret = VM_FAULT_SIGBUS;
> -				break;
> -			default:
> -				WARN_ON(PTR_ERR(page));
> -				ret = VM_FAULT_SIGBUS;
> -				break;
> -		}
> +	if (!ret)
> +		return 0;
> +
> +	page = shmem_read_mapping_page(file_inode(obj->base.filp)->i_mapping,
> +			page_offset);
> +	if (!IS_ERR(page)) {
> +		vmf->page = page;
> +		return 0;
> +	}
>  
> +	switch (PTR_ERR(page)) {
> +	case -ENOSPC:
> +	case -ENOMEM:
> +		return VM_FAULT_OOM;
> +	case -EBUSY:
> +		return VM_FAULT_RETRY;
> +	case -EFAULT:
> +	case -EINVAL:
> +		return VM_FAULT_SIGBUS;
> +	default:
> +		WARN_ON(PTR_ERR(page));
> +		return VM_FAULT_SIGBUS;
>  	}
> -	return ret;

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Want me to merge this through drm-misc or plan to pick it up yourself?
-Daniel

>  }
>  
>  static const struct vm_operations_struct vgem_gem_vm_ops = {
> -- 
> 2.17.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
