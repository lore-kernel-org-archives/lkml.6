Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3048566-1520547340-2-17588936620517636069
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520547339; b=CfsdlJEK9Iht80JYZpGyQxA70bXOjYAVYmuvpu7N++LzIJz
    KFUxqXv7/+EguBtGSkoZBGNgDEA2mAvjBmvGZAVLwOfHlCJldPWaYE9cEHkOPGxA
    SRYr80X09QzlgFR/aTkgPWWC4o3dserIGYQUHH4aAD4pTZJ/sdDc6Y3w4ZNOGiB5
    y7lEQxGOYurqRtDDw7egv+5O+yCn9ZyMfOiTk7mD34t7cBik6utTloBZbR6/5kQ4
    mp0FwNYyxH6bKpjfEnqF89CE5/udTddW8XcuuzzPALzchuKT5CSGDzE/2Z8jJSCA
    Nje/7gHxjoAiIPxTSEYbgQjDnpVlO7uCFPqDTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520547339; bh=hDoTwozBvM3zCPTjozTq/A040lZ+apFp+8FLhxid4iM=; b=f
    l0zvt3Z/ChYEEwaLgLpY6TB5m6L9FWIhfk59e83mteRURTp8hT9oxphSBCGGy1BU
    gHueGoKyk7wakhHJkeMwNmeFzmJrPdmAZzbGG48ogLWhB800KvOa4mUkv6Wt/YuR
    0eksbHBpLG8spGwPu9SP+/b8744ayN+z5keSECGuFtiETGOW3ujugThG6Z9EgHpS
    MHL/FqZT9ZD5oUHjS3cjlKhJa2h4NU3HlT//KM0N7LEfNr3HnWvcWC2uIDDsMEFz
    yabNV3dnfvKaeGeL7iuYm8X0QxihCOmC3Mj8Med2/kFSkx4I9n4O3fQW3irhBhBs
    0/fGe3t7h8N5p8dxzGbUQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750783AbeCHWPg (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 17:15:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46546 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeCHWPf (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 17:15:35 -0500
Date: Thu, 8 Mar 2018 14:15:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bugzilla-daemon@bugzilla.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Nic Losby <blurbdust@gmail.com>,
        Yisheng Xie <xieyisheng1@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] hugetlbfs: check for pgoff value overflow
Message-Id: <20180308141533.d16e43f5f559215089e522ae@linux-foundation.org>
In-Reply-To: <20180308210502.15952-1-mike.kravetz@oracle.com>
References: <20180306133135.4dc344e478d98f0e29f47698@linux-foundation.org>
        <20180308210502.15952-1-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu,  8 Mar 2018 13:05:02 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

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
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -111,6 +111,7 @@ static void huge_pagevec_release(struct pagevec *pvec)
>  static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct inode *inode = file_inode(file);
> +	unsigned long ovfl_mask;
>  	loff_t len, vma_len;
>  	int ret;
>  	struct hstate *h = hstate_file(file);
> @@ -127,12 +128,16 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	vma->vm_ops = &hugetlb_vm_ops;
>  
>  	/*
> -	 * Offset passed to mmap (before page shift) could have been
> -	 * negative when represented as a (l)off_t.
> +	 * page based offset in vm_pgoff could be sufficiently large to
> +	 * overflow a (l)off_t when converted to byte offset.
>  	 */
> -	if (((loff_t)vma->vm_pgoff << PAGE_SHIFT) < 0)
> +	ovfl_mask = (1UL << (PAGE_SHIFT + 1)) - 1;
> +	ovfl_mask <<= ((sizeof(unsigned long) * BITS_PER_BYTE) -
> +		       (PAGE_SHIFT + 1));

That's a compile-time constant.  The compiler will indeed generate an
immediate load, but I think it would be better to make the code look
more like we know that it's a constant, if you get what I mean. 
Something like

/*
 * If a pgoff_t is to be converted to a byte index, this is the max value it
 * can have to avoid overflow in that conversion.
 */
#define PGOFF_T_MAX	<long string of crap>

And I bet that this constant could be used elsewhere - surely it's a
very common thing to be checking for.


Also, the expression seems rather complicated.  Why are we adding 1 to
PAGE_SHIFT?  Isn't there a logical way of using PAGE_MASK?

The resulting constant is 0xfff8000000000000 on 64-bit.  We could just
use along the lines of

	1UL << (BITS_PER_LONG - PAGE_SHIFT - 1)

But why the -1?  We should be able to handle a pgoff_t of
0xfff0000000000000 in this code?


Also, we later to

	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
	/* check for overflow */
	if (len < vma_len)
		return -EINVAL;

which is ungainly: even if we passed the PGOFF_T_MAX test, there can
still be an overflow which we still must check for.  Is that avoidable?
Probably not...
