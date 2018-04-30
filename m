Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1619120-1525107435-2-13852917751677875423
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FROM_EXCESS_BASE64 0.979,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='utf-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525107435; b=LhmIOzi1AmQgpHvoFHPLLPEfhZzskXdRLi66UO+TVushcGb9aF
    KPt+beVpBdFbnUd/uEL4RD1LxR8o9xqsp6GLOKLehwgdo62gM9ICHMem5S9o/UfP
    xwUn0otj0hi8jEsLkvhzyO9stQ94aWIQdvKPc0mZC2b3Wzj3fC6VlC8t6x/ynDhT
    gxWRAeBowmN5WCIImKFXMM6e1sK0V8XzOh/APpwwjX/hDdozKfRwx7Ou3/6Iap5T
    fayvpsj9lBi6dyJ8EbBwALD2sfTtnUFowZfOQDPifCZ3MGpBh940gpOLYk0F0nP8
    AuS/Pk+x1orRjyOqVoWiT/I1dafD6j9I+E5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525107435; bh=LLb5WgkX3wqZQawbMouyIY4wZ1dqRw
    rHoOOFyi/Saxc=; b=g7tn7bWFLewVBkE+Pc4Mpi5+6KT1nEM3qZkL8HEa3Wo6bo
    xOXNqpxnknjyz0fWziGVlKKm5S7sXSNIlbFhgjDbHrmxUYGXDvwpzMbjRgGn9HOf
    HejuEGFygD95I9uDWwjNUDn1CQppTvzOCpM1IwuiiCPQYCUxVA+togGI3rS9jXqw
    e0Wge2kJKJaDBOiruCHU+1S9q4BLeosz3ipRzec98px6b+TFLnRZuKA3ID1gQeDL
    ++lB5JKipXtnilC8LwqUMnGunlOU0QrsaGsDO2viexFau4t0o6511O8oVteMlYVJ
    o5g+d24Cxi3lgtQ1iUtGH2Vh23zjelbZDAc232sQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=citrix.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=citrix.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIVxgtu4b9QIp+VudwADkaBE6cZ9wqRZ/LpT2b/4hR/h3nYub8fdnb1aomNyffNSVEO7JpC5+M1DKU3OHWYVLysLewdvaXy57gOeO/mmLL5YQbUblMR2
    q9u3/Vty+nT6rsDsS3NJABFh4QoDWIJLrvRsV/uDx8Yc56z1dMbczpMNKIuoDaejYhGJjKocmjZTBosKkKxx87N+N7Nh//Sr4+kctik6MYNXePopAS4cFhy2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=hK3Guw29bmMOsdThyW4A:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754867AbeD3Q5M (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 12:57:12 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:6625 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753508AbeD3Q5M (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 12:57:12 -0400
X-IronPort-AV: E=Sophos;i="5.49,346,1520899200";
   d="scan'208";a="72387434"
Date: Mon, 30 Apr 2018 17:57:04 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <jgross@suse.com>, <stable@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH 1/4] xen/PVH: Replace GDT_ENTRY with explicit
 constant
Message-ID: <20180430165704.bkce56nzx3giodbd@MacBook-Pro-de-Roger.local>
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
 <20180430162339.17143-2-boris.ostrovsky@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180430162339.17143-2-boris.ostrovsky@oracle.com>
User-Agent: NeoMutt/20180323
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 12:23:36PM -0400, Boris Ostrovsky wrote:
> Latest binutils release (2.29.1) will no longer allow proper computation
> of GDT entries on 32-bits, with warning:
> 
> arch/x86/xen/xen-pvh.S: Assembler messages:
> arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (32 is not between 0 and 31)
> arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (40 is not between 0 and 31)
> arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (32 is not between 0 and 31)
> arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (32 is not between 0 and 31)
> arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (40 is not between 0 and 31)
> arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (32 is not between 0 and 31)
> 
> Use explicit value of the entry instead of using GDT_ENTRY() macro.
> 
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/xen/xen-pvh.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
> index e1a5fbe..934f7d4 100644
> --- a/arch/x86/xen/xen-pvh.S
> +++ b/arch/x86/xen/xen-pvh.S
> @@ -145,11 +145,11 @@ gdt_start:
>  	.quad 0x0000000000000000            /* NULL descriptor */
>  	.quad 0x0000000000000000            /* reserved */
>  #ifdef CONFIG_X86_64
> -	.quad GDT_ENTRY(0xa09a, 0, 0xfffff) /* __KERNEL_CS */
> +	.quad 0x00af9a000000ffff            /* __BOOT_CS */
>  #else
> -	.quad GDT_ENTRY(0xc09a, 0, 0xfffff) /* __KERNEL_CS */
> +	.quad 0x00cf9a000000ffff            /* __BOOT_CS */

Maybe it would be cleaner to use something like:

.word 0xffff /* limit */
.word 0      /* base */
.byte 0      /* base */
.byte 0x9a   /* access */
#ifdef CONFIG_X86_64
.byte 0xaf   /* flags plus limit */
#else
.byte 0xcf   /* flags plus limit */
#endif
.byte 0      /* base */

Or try to fix the GDT_ENTRY macro, maybe if you prepend extra 0's to
make the values 64bit that would prevent the warnings?

Or declare the GDT in enlighten_pvh in C and use it here?

Also, IIRC the base/limit values are ignored in long mode.

Thanks, Roger.
