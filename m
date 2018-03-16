Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2753674-1521195496-2-14655612768245549357
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521195495; b=CIANmae22qgbs3t/cqSLTyTShbEiII1MDEuy3ONrofRH9Iw
    y6GI2NldpmYkXyIW3KWkqOXWF1qSokqPBNQ88RbtD1U6kNhzT4D2Rm6HP3ocz3Ci
    9mjrMz0sdZEoLdTBp80hKFtZcLGgTKEK9NmTRVO66aQ6CAchjsb4ZGa+RWdvOEkt
    ryn55qH1W7CZtm0xpNdEWnIJBOuPxgdx55JPygXTZu0qfmAXcFTaqEYB45pGNocD
    +ZrZdZb9AEm+XjWhdE+rsbrIvguZleHC0ogRLgfvGpaN3DzsTT6j54nFJqNZ+YEp
    IUjxJjR1YlMjCTrLJzA/Qjom44svpzeC21hoAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521195495; bh=NihGyx+3MFwcOBYoQAOHYQTiVB
    aDCQEEUYGX7nBQ4og=; b=P1OydsUSuyzwRvfQLSZ5AjA5J6sKnMfTDO4KXOgaW/
    66r2HnhkgdeAGAzzA70CJQSKyOspY7iUGg6/wjZn1mDJEwMjCZCYx1qAbrE4zhun
    HwXJE8e4IQ3S5A7Uus+65tlY43yzkZLALXLLXw2BaFl4hXtuYCSwP+68zywZV7NU
    V7hI1m7YSeRyrdjh/jRVuEOkEM8B3+SUk45Gt/xq+AW1OgrcDe7IgIXBEzzZnGQp
    qaTelGX6LOwE1tcQIp2eDTA9V+6/GoiMgLN6wOMNup9mkNDMbH5nbdEPN9369VYP
    XIm5LYLfatgyijrgj7lb+zy+esFNlmkTQq6n+ZszF/+g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753188AbeCPKSC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 06:18:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:35481 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751637AbeCPKSB (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Mar 2018 06:18:01 -0400
Date: Fri, 16 Mar 2018 11:17:57 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bugzilla-daemon@bugzilla.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Nic Losby <blurbdust@gmail.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] hugetlbfs: check for pgoff value overflow
Message-ID: <20180316101757.GE23100@dhcp22.suse.cz>
References: <20180306133135.4dc344e478d98f0e29f47698@linux-foundation.org>
 <20180309002726.7248-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309002726.7248-1-mike.kravetz@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 08-03-18 16:27:26, Mike Kravetz wrote:
> A vma with vm_pgoff large enough to overflow a loff_t type when
> converted to a byte offset can be passed via the remap_file_pages
> system call.  The hugetlbfs mmap routine uses the byte offset to
> calculate reservations and file size.
> 
> A sequence such as:
>   mmap(0x20a00000, 0x600000, 0, 0x66033, -1, 0);
>   remap_file_pages(0x20a00000, 0x600000, 0, 0x20000000000000, 0);
> will result in the following when task exits/file closed,
>   kernel BUG at mm/hugetlb.c:749!
> Call Trace:
>   hugetlbfs_evict_inode+0x2f/0x40
>   evict+0xcb/0x190
>   __dentry_kill+0xcb/0x150
>   __fput+0x164/0x1e0
>   task_work_run+0x84/0xa0
>   exit_to_usermode_loop+0x7d/0x80
>   do_syscall_64+0x18b/0x190
>   entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> 
> The overflowed pgoff value causes hugetlbfs to try to set up a
> mapping with a negative range (end < start) that leaves invalid
> state which causes the BUG.
> 
> The previous overflow fix to this code was incomplete and did not
> take the remap_file_pages system call into account.
> 
> Fixes: 045c7a3f53d9 ("hugetlbfs: fix offset overflow in hugetlbfs mmap")
> Cc: <stable@vger.kernel.org>
> Reported-by: Nic Losby <blurbdust@gmail.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

OK, looks good to me. Hairy but seems to be the easiest way around this.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> Changes in v3
>   * Use a simpler mask computation as suggested by Andrew Morton
> Changes in v2
>   * Use bitmask for overflow check as suggested by Yisheng Xie
>   * Add explicit (from > to) check when setting up reservations
>   * Cc stable
> 
>  fs/hugetlbfs/inode.c | 16 +++++++++++++---
>  mm/hugetlb.c         |  6 ++++++
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 8fe1b0aa2896..e46117dc006a 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -108,6 +108,15 @@ static void huge_pagevec_release(struct pagevec *pvec)
>  	pagevec_reinit(pvec);
>  }
>  
> +/*
> + * Mask used when checking the page offset value passed in via system
> + * calls.  This value will be converted to a loff_t which is signed.
> + * Therefore, we want to check the upper PAGE_SHIFT + 1 bits of the
> + * value.  The extra bit (- 1 in the shift value) is to take the sign
> + * bit into account.
> + */
> +#define PGOFF_LOFFT_MAX (PAGE_MASK << (BITS_PER_LONG - (2 * PAGE_SHIFT) - 1))
> +
>  static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct inode *inode = file_inode(file);
> @@ -127,12 +136,13 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	vma->vm_ops = &hugetlb_vm_ops;
>  
>  	/*
> -	 * Offset passed to mmap (before page shift) could have been
> -	 * negative when represented as a (l)off_t.
> +	 * page based offset in vm_pgoff could be sufficiently large to
> +	 * overflow a (l)off_t when converted to byte offset.
>  	 */
> -	if (((loff_t)vma->vm_pgoff << PAGE_SHIFT) < 0)
> +	if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
>  		return -EINVAL;
>  
> +	/* must be huge page aligned */
>  	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
>  		return -EINVAL;
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7c204e3d132b..8eeade0a0b7a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4374,6 +4374,12 @@ int hugetlb_reserve_pages(struct inode *inode,
>  	struct resv_map *resv_map;
>  	long gbl_reserve;
>  
> +	/* This should never happen */
> +	if (from > to) {
> +		VM_WARN(1, "%s called with a negative range\n", __func__);
> +		return -EINVAL;
> +	}
> +
>  	/*
>  	 * Only apply hugepage reservation if asked. At fault time, an
>  	 * attempt will be made for VM_NORESERVE to allocate a page
> -- 
> 2.13.6

-- 
Michal Hocko
SUSE Labs
