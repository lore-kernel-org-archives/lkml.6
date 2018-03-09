Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3342454-1520557534-2-9314976373692192594
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
    t=1520557533; b=SrntjdRPMF5IeqXQYPtmx/gw50L87iaGJ5ZR/J3YRxmqBYB
    OM49DUCwP2M85ZLlqMdjzwEZsM87eUlaP0BStWb9/WKM83oiryBjS79Q1T+ZdFZP
    IY9X62GdGONfrRNVa68m7tQ0QYmYCvfg9cujMhjrB5YgaiFc6oeb1QnxC/bHlOhe
    d7Uqu+VoEXTbykhWP/JoQR5ODEFzyy+hyqeptaqokupAKOxuhEb+tKeva784wAh0
    IQnI7fUg4BbzVOzCK9IX/w0PaDSDfUmGEXwd9OR2yETua9Fgy8NfYJtEPLekL1ak
    OSWeC1r6nX+heCET4iXWzyF2uSSkLqRfTASUB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520557533; bh=Jg2KmMBW+XRuRB24UzXyNZ+QQnCo6GuTrmLMw9yY2p8=; b=P
    ZoxIv4qGqwuCZPaokXMcczOafsGfZBLoZJ4/A59MK1Cyt6MF8dx8tVyC1kRYg99F
    +yep1Er24WYFCNVCZN3aTUheq1A5S0rdXIGvYrloTwakrEhUt23V5kATNJVEfRdA
    +E5Ks16FQla2QJ9PxVuiCJvi33AYejeCok0rXlbecOZF8Be0kOXzgJczhmRn8bjS
    Q8w4aMd3SS3FgtrA48bsiUWZuEydhSb+CMP3O68/Y2m99ajWEJ5uEAWqMSY0i9lD
    ftU4UnXUCt1E/9r6aEGNkHk/HtIiBFqv18GW1N01980PGt5VCFpgWSz2JwcJkUq6
    GouGxLsmeK9NGb1BL4GFw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
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
        id S1751901AbeCIBFP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 20:05:15 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47160 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751373AbeCIBFO (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 20:05:14 -0500
Date: Thu, 8 Mar 2018 17:05:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bugzilla-daemon@bugzilla.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Nic Losby <blurbdust@gmail.com>,
        Yisheng Xie <xieyisheng1@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] hugetlbfs: check for pgoff value overflow
Message-Id: <20180308170511.c16fc731523ff49f1981f89d@linux-foundation.org>
In-Reply-To: <20180309002726.7248-1-mike.kravetz@oracle.com>
References: <20180306133135.4dc344e478d98f0e29f47698@linux-foundation.org>
        <20180309002726.7248-1-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu,  8 Mar 2018 16:27:26 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

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
> ...
>
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

This is tidier, and that comment is a bit too obvious to live ;)

--- a/mm/hugetlb.c~hugetlbfs-check-for-pgoff-value-overflow-v3-fix
+++ a/mm/hugetlb.c
@@ -18,6 +18,7 @@
 #include <linux/bootmem.h>
 #include <linux/sysfs.h>
 #include <linux/slab.h>
+#include <linux/mmdebug.h>
 #include <linux/sched/signal.h>
 #include <linux/rmap.h>
 #include <linux/string_helpers.h>
@@ -4374,11 +4375,8 @@ int hugetlb_reserve_pages(struct inode *
 	struct resv_map *resv_map;
 	long gbl_reserve;
 
-	/* This should never happen */
-	if (from > to) {
-		VM_WARN(1, "%s called with a negative range\n", __func__);
+	if (VM_WARN(from > to, "%s called with a negative range\n", __func__))
 		return -EINVAL;
-	}
 
 	/*
 	 * Only apply hugepage reservation if asked. At fault time, an
