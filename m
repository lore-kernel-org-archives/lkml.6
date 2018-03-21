Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-702083-1521665787-2-7510995504010199777
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
    t=1521665786; b=XVFtOw7v62szmvsFvHsdYmiM/MoFBxDhLJ6a/4BOoAA0FfH
    q91szeLakUjCBPw8tqJuN3kZMWcowvBzhPVWldRWSdBBEJ3ExrSTh4jr1KtnURZK
    uXyUnLjLqt/YncS6Y7cljgKKwb8htRe27rfGd5eonOY7ca/N19KDu93dUcm7Xrna
    eLMWzgAU+K4v8e3gVYGi37LkoaV9unFznJz/vCl3+l7uMPXTu0rjtyOXqalDDTEe
    X1c9WS/awIj9U+UN7i7jr2hYkeasc5o/1es6R1ZaXMc1DtrXS1bhPvyM3ByIsuMP
    Ahoiks8r6RxT8YLX5r7Zj3yJ7WUW0y8Zajyw+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521665786; bh=EzDOeV5TZ8CSS6+izJ3xG5SuAkvBLRyysQcrvcDkr18=; b=f
    q9ebaBsDZxh3tOngKXm4OJq+ZfECk0ZN8pNKzcHpq7zjRnPFzH1LBv0ipMXdOTfZ
    ykNyqC6Z6pVpPF92y6ZQ1jHLn8CrcvR8tTBtUIVF0JNeNUX8T6+EWlw9KBo0lhFr
    C8euXJ9S0W9jTYjjguO6PvCu9Ni7gifQ6A4T7YqHbWCj8yx5CFgYygwkf/ffYt1u
    Lco9+FMYgzN9XtpWyIt8ABfUZXW4RW6Jb4biLlv7z19QoHFD1QYt0JDcHpP2LtRm
    44PLRWpAFSm6rjDiSkQolAHx0DTpVR+YIs2qDd4kGIN8kOHm9Wq/QB2+Mmyxeq7h
    om4oRg8c6DahRNQ21DliQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753364AbeCUU4X (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 16:56:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35570 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753210AbeCUU4U (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 16:56:20 -0400
Date: Wed, 21 Mar 2018 13:56:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] shm: add split function to shm_vm_ops
Message-Id: <20180321135618.f3d4a0c30d9f413ce4092ddf@linux-foundation.org>
In-Reply-To: <20180321161314.7711-1-mike.kravetz@oracle.com>
References: <0d24f817-303a-7b4d-4603-b2d14e4b391a@oracle.com>
        <20180321161314.7711-1-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 21 Mar 2018 09:13:14 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> If System V shmget/shmat operations are used to create a hugetlbfs
> backed mapping, it is possible to munmap part of the mapping and
> split the underlying vma such that it is not huge page aligned.
> This will untimately result in the following BUG:
> 
> kernel BUG at /build/linux-jWa1Fv/linux-4.15.0/mm/hugetlb.c:3310!
> Oops: Exception in kernel mode, sig: 5 [#1]
> LE SMP NR_CPUS=2048 NUMA PowerNV
> Modules linked in: kcm nfc af_alg caif_socket caif phonet fcrypt
> 		8<--8<--8<--8< snip 8<--8<--8<--8<
> CPU: 18 PID: 43243 Comm: trinity-subchil Tainted: G         C  E
> 4.15.0-10-generic #11-Ubuntu
> NIP:  c00000000036e764 LR: c00000000036ee48 CTR: 0000000000000009
> REGS: c000003fbcdcf810 TRAP: 0700   Tainted: G         C  E
> (4.15.0-10-generic)
> MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24002222  XER:
> 20040000
> CFAR: c00000000036ee44 SOFTE: 1
> GPR00: c00000000036ee48 c000003fbcdcfa90 c0000000016ea600 c000003fbcdcfc40
> GPR04: c000003fd9858950 00007115e4e00000 00007115e4e10000 0000000000000000
> GPR08: 0000000000000010 0000000000010000 0000000000000000 0000000000000000
> GPR12: 0000000000002000 c000000007a2c600 00000fe3985954d0 00007115e4e00000
> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> GPR20: 00000fe398595a94 000000000000a6fc c000003fd9858950 0000000000018554
> GPR24: c000003fdcd84500 c0000000019acd00 00007115e4e10000 c000003fbcdcfc40
> GPR28: 0000000000200000 00007115e4e00000 c000003fbc9ac600 c000003fd9858950
> NIP [c00000000036e764] __unmap_hugepage_range+0xa4/0x760
> LR [c00000000036ee48] __unmap_hugepage_range_final+0x28/0x50
> Call Trace:
> [c000003fbcdcfa90] [00007115e4e00000] 0x7115e4e00000 (unreliable)
> [c000003fbcdcfb50] [c00000000036ee48]
> __unmap_hugepage_range_final+0x28/0x50
> [c000003fbcdcfb80] [c00000000033497c] unmap_single_vma+0x11c/0x190
> [c000003fbcdcfbd0] [c000000000334e14] unmap_vmas+0x94/0x140
> [c000003fbcdcfc20] [c00000000034265c] exit_mmap+0x9c/0x1d0
> [c000003fbcdcfce0] [c000000000105448] mmput+0xa8/0x1d0
> [c000003fbcdcfd10] [c00000000010fad0] do_exit+0x360/0xc80
> [c000003fbcdcfdd0] [c0000000001104c0] do_group_exit+0x60/0x100
> [c000003fbcdcfe10] [c000000000110584] SyS_exit_group+0x24/0x30
> [c000003fbcdcfe30] [c00000000000b184] system_call+0x58/0x6c
> Instruction dump:
> 552907fe e94a0028 e94a0408 eb2a0018 81590008 7f9c5036 0b090000 e9390010
> 7d2948f8 7d2a2838 0b0a0000 7d293038 <0b090000> e9230086 2fa90000 419e0468
> ---[ end trace ee88f958a1c62605 ]---
> 
> This bug was introduced by commit 31383c6865a5 ("mm, hugetlbfs:
> introduce ->split() to vm_operations_struct").  A split function
> was added to vm_operations_struct to determine if a mapping can
> be split.  This was mostly for device-dax and hugetlbfs mappings
> which have specific alignment constraints.
> 
> Mappings initiated via shmget/shmat have their original vm_ops
> overwritten with shm_vm_ops.  shm_vm_ops functions will call back
> to the original vm_ops if needed.  Add such a split function to
> shm_vm_ops.
> 
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -386,6 +386,17 @@ static int shm_fault(struct vm_fault *vmf)
>  	return sfd->vm_ops->fault(vmf);
>  }
>  
> +static int shm_split(struct vm_area_struct *vma, unsigned long addr)
> +{
> +	struct file *file = vma->vm_file;
> +	struct shm_file_data *sfd = shm_file_data(file);
> +
> +	if (sfd->vm_ops && sfd->vm_ops->split)
> +		return sfd->vm_ops->split(vma, addr);

This will be the only site which tests for NULL shm_file_data.vm_ops. 
It's a can't-happen, methinks.

I think I'll leave it as it is for now and will queue up a non-urgent
patch:



From: Andrew Morton <akpm@linux-foundation.org>
Subject: ipc/shm.c: shm_split(): remove unneeded test for NULL shm_file_data.vm_ops

This was added by the recent "ipc/shm.c: add split function to
shm_vm_ops", but it is not necessary.

Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 ipc/shm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN ipc/shm.c~ipc-shmc-shm_split-remove-unneeded-test-for-null-shm_file_datavm_ops ipc/shm.c
--- a/ipc/shm.c~ipc-shmc-shm_split-remove-unneeded-test-for-null-shm_file_datavm_ops
+++ a/ipc/shm.c
@@ -391,7 +391,7 @@ static int shm_split(struct vm_area_stru
 	struct file *file = vma->vm_file;
 	struct shm_file_data *sfd = shm_file_data(file);
 
-	if (sfd->vm_ops && sfd->vm_ops->split)
+	if (sfd->vm_ops->split)
 		return sfd->vm_ops->split(vma, addr);
 
 	return 0;
_
