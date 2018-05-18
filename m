Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4167094-1526659027-2-4747577312135213831
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526659026; b=V3OABeIhl6mR1t2Y2LOCjhPpAkaWfovnmX+ZnWy9iZPSQ0pgyS
    AFJoa/ZSowPplMeMciwYSLe0IIOUKNAT1EWb6P67/EB4iRKKLaU7fKUrBqBlt5Zl
    Kt6cI9qpkNSn2A+sJM/cizNPVp2bl850/HX1y4QTdkgMYCUoYoiTaOuwVV5ZLs74
    5IgqcdC+FgbKeFqLz33H9eCpS+/L7/S25Y+GKJJgJpwLX8KwXe18otG/cYa84sTh
    zX9qgYXe1q3Cqgl0Gekvk60ilm9zwR1no0NPt6t2r9E11zh+c5AcOKd48pXXwI5T
    M6GOTzpU1cqQU9wQuC0KZjYHZUOQhL5hTQmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526659026;
    bh=G7D+HS9LjbsFKxHDjVUuUihHBoKIEryKSHtcdI7LMrI=; b=hAKM1MQtDIXF
    aYBvmIuhEXHLXumEsvTeY6pzECym1iPAZTi9Hj6IiURQCW7sPBlUA4aFsyNx988H
    57YBUH+ib3YH+2u7KOls+/bHxOE2YhcMh124laR44JxtOe7LThPyvoti/bgpNz8W
    M+qaikfCfIYygd3s8QKnQhY+ftB2Eh2+dbIoarJVnnYLJS52cUjMpkDfjnVwoiSw
    9AGLc+Pn+q3MplIsrGUtAuFd/CfyWtd+ckWtGXjcKUhqSyt1xi7LZoygAIgzLw3W
    ZxjuDeVkvO2/wysaTmCuGfCQTWq/x7Fj/DjyTJeyeJAm7NRuT7yacfKaGg8+CD7l
    c7G+yQZSRw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCnQmTvsQJJgfoVzNdLPSemUimIJfbWB3iMbMScbwoKE1cYTm13S0OTvKK02234lKve0o7SXpca4P0Gf914jhBNL6Cvm3OZ5zrTseYwuHyTm8ERhXDT6
    zQw9SiQvT87EfZUFaX+esZQwuXXfmNgKO12WJ4UQRGDiaQfNxnlRtfscxc6aOsusKuXHp+h0stkXHoyxcm6CkUKNbBIN3dEXkhSUiv7106JoJajRqksAmFs9
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=TYBLyS7eAAAA:8 a=VwQbUJbxAAAA:8 a=brrYe1xspg1YvC0O15wA:9
    a=d_rr1OUZ-Jov2P4b:21 a=fTOwwnFuGPz-pBav:21 a=QEXdDO2ut3YA:10
    a=zvYvwCWiE4KgVXXeO06c:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeERP5F (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 11:57:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751999AbeERP5E (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 18 May 2018 11:57:04 -0400
Subject: Re: [PATCH] mm/kasan: Don't vfree() nonexistent vm_area.
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Menzel <pmenzel+linux-kasan-dev@molgen.mpg.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
References: <12c9e499-9c11-d248-6a3f-14ec8c4e07f1@molgen.mpg.de>
 <20180201163349.8700-1-aryabinin@virtuozzo.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <784dfdf6-8fc3-be08-833b-a9097c3d1b96@redhat.com>
Date: Fri, 18 May 2018 17:57:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180201163349.8700-1-aryabinin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01.02.2018 17:33, Andrey Ryabinin wrote:
> KASAN uses different routines to map shadow for hot added memory and memory
> obtained in boot process. Attempt to offline memory onlined by normal boot
> process leads to this:
> 
>     Trying to vfree() nonexistent vm area (000000005d3b34b9)
>     WARNING: CPU: 2 PID: 13215 at mm/vmalloc.c:1525 __vunmap+0x147/0x190
> 
>     Call Trace:
>      kasan_mem_notifier+0xad/0xb9
>      notifier_call_chain+0x166/0x260
>      __blocking_notifier_call_chain+0xdb/0x140
>      __offline_pages+0x96a/0xb10
>      memory_subsys_offline+0x76/0xc0
>      device_offline+0xb8/0x120
>      store_mem_state+0xfa/0x120
>      kernfs_fop_write+0x1d5/0x320
>      __vfs_write+0xd4/0x530
>      vfs_write+0x105/0x340
>      SyS_write+0xb0/0x140
> 
> Obviously we can't call vfree() to free memory that wasn't allocated via
> vmalloc(). Use find_vm_area() to see if we can call vfree().
> 
> Unfortunately it's a bit tricky to properly unmap and free shadow allocated
> during boot, so we'll have to keep it. If memory will come online again
> that shadow will be reused.
> 

While debugging kasan memory hotplug problems I am having, stumbled over
this patch.

Couldn't we handle that via VM_KASAN like in kasan_module_alloc/free
instead?

> Fixes: fa69b5989bb0 ("mm/kasan: add support for memory hotplug")
> Reported-by: Paul Menzel <pmenzel+linux-kasan-dev@molgen.mpg.de>
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/kasan/kasan.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
> index e13d911251e7..0d9d9d268f32 100644
> --- a/mm/kasan/kasan.c
> +++ b/mm/kasan/kasan.c
> @@ -791,6 +791,41 @@ DEFINE_ASAN_SET_SHADOW(f5);
>  DEFINE_ASAN_SET_SHADOW(f8);
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> +static bool shadow_mapped(unsigned long addr)
> +{
> +	pgd_t *pgd = pgd_offset_k(addr);
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +
> +	if (pgd_none(*pgd))
> +		return false;
> +	p4d = p4d_offset(pgd, addr);
> +	if (p4d_none(*p4d))
> +		return false;
> +	pud = pud_offset(p4d, addr);
> +	if (pud_none(*pud))
> +		return false;
> +
> +	/*
> +	 * We can't use pud_large() or pud_huge(), the first one
> +	 * is arch-specific, the last one depend on HUGETLB_PAGE.
> +	 * So let's abuse pud_bad(), if bud is bad it's has to
> +	 * because it's huge.
> +	 */
> +	if (pud_bad(*pud))
> +		return true;
> +	pmd = pmd_offset(pud, addr);
> +	if (pmd_none(*pmd))
> +		return false;
> +
> +	if (pmd_bad(*pmd))
> +		return true;
> +	pte = pte_offset_kernel(pmd, addr);
> +	return !pte_none(*pte);
> +}
> +
>  static int __meminit kasan_mem_notifier(struct notifier_block *nb,
>  			unsigned long action, void *data)
>  {
> @@ -812,6 +847,14 @@ static int __meminit kasan_mem_notifier(struct notifier_block *nb,
>  	case MEM_GOING_ONLINE: {
>  		void *ret;
>  
> +		/*
> +		 * If shadow is mapped already than it must have been mapped
> +		 * during the boot. This could happen if we onlining previously
> +		 * offlined memory.
> +		 */
> +		if (shadow_mapped(shadow_start))
> +			return NOTIFY_OK;
> +
>  		ret = __vmalloc_node_range(shadow_size, PAGE_SIZE, shadow_start,
>  					shadow_end, GFP_KERNEL,
>  					PAGE_KERNEL, VM_NO_GUARD,
> @@ -823,8 +866,18 @@ static int __meminit kasan_mem_notifier(struct notifier_block *nb,
>  		kmemleak_ignore(ret);
>  		return NOTIFY_OK;
>  	}
> -	case MEM_OFFLINE:
> -		vfree((void *)shadow_start);
> +	case MEM_OFFLINE: {
> +		struct vm_struct *vm;
> +
> +		/*
> +		 * Only hot-added memory have vm_area. Freeing shadow
> +		 * mapped during boot would be tricky, so we'll just
> +		 * have to keep it.
> +		 */
> +		vm = find_vm_area((void *)shadow_start);
> +		if (vm)
> +			vfree((void *)shadow_start);
> +	}
>  	}
>  
>  	return NOTIFY_OK;
> 


-- 

Thanks,

David / dhildenb
