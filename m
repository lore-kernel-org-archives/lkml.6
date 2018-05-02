Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-437838-1525248987-2-7529737216694430513
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525248986; b=mdMgyFhhHVdFGQMXbC3tf04+zboRfVWpj6UxbbcTEKBKaxh9Ob
    FjdN6AJMn3MTwO2/13gfIYPOvBhtvHJ08/nrYAgRldC6tlXIdGvg9MB/beWv6Glx
    UWTKG+0wJPmh3DVs0vh9iW/eUnExoPUe89fucnzl3wmpOivlIIGQkFdSBDE7fTHI
    Si7ohsW06GWwaUa56sgm6YZMrP2aHwKzJJlbsZIuEVdCqaIJxzhlBW12U5Pmtj6X
    DmLGSrEMQcZZ0L2KWWVsjmBbS+ovXz/sRKXFUn3+S38c10VXC3ajyVpP5PKsEa0k
    xjhiiWMnFAOa/HKcbzfydnVKAivkfgctdmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:in-reply-to:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525248986;
    bh=fp5atlUzASM/FpoakrN6YNUEF7wgRgHyiMLu29t6W70=; b=bglI2N1yKAze
    TNrRzqN38cnmkegV6nvo6o+mUhhQ3SlZkK0aviTupGB2uxuwRNDOIWCXs9xaSH/X
    9rHaXABCwQ++IOtWYJ8yvNmqG6k3ggYcQNaVBozB7/MCXwIeTRBn16aZ3MJ5cu8K
    LDI11WCMZgavqD1UDB2nDNsY2SE08Q9zjB+cXyC0aXM73hpBuJXNTTaDRyZdYxKR
    XKAfmXdprByQdpKkE2bwRVBysKTmmZvq0BDwR2dYK8UZlMb0FPvwQYTegISrD55B
    CzfS9F1ZNSmmXFrCO0m+grXYGdc1OxJHAfcyrVHywDRSNrhQQE64pyh9YWklYthX
    WoDYdiHKWQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-90 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-90 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPWgZAOcVkyz8fUXp1o2dFJ7Bry/N1G9wf0clBwfdLlS5C0cew1q0fvOlWwJ1sjTGq4KgrTUL53Zpwv9CT3ktqSAhqdXUEEjKiUdgPMcDWrwg7DzO6m2
    PyA6ZEuJ9Fl38jGqjwhv/yBly6ZHTsLmZncEvrs3y8xQ3vKPY2Unal1dn9G579GkBvSqfRjs/w/9+pJwk4QHPzs0OZEb/YeQ4qsWbdwA5RALcpanGI2SZchW
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=ZOODMjqyJcwrYCzWUJcA:9 a=IRlLSGNwzZ5svOmX:21
    a=wfQc8d6fhBaG_zbS:21 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeEBIQX convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 2 May 2018 04:16:23 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:42734 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbeEBIQW (ORCPT
        <rfc822;groupwise-stable@vger.kernel.org:4:2>);
        Wed, 2 May 2018 04:16:22 -0400
Message-Id: <5AE973CD02000078001C008E@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Wed, 02 May 2018 02:16:13 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Cc: "xen-devel" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH 3/4] xen/PVH: Set up GS segment for
 stack canary
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
 <20180430162339.17143-4-boris.ostrovsky@oracle.com>
In-Reply-To: <20180430162339.17143-4-boris.ostrovsky@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>>> On 30.04.18 at 18:23, <boris.ostrovsky@oracle.com> wrote:
> --- a/arch/x86/xen/xen-pvh.S
> +++ b/arch/x86/xen/xen-pvh.S
> @@ -54,6 +54,9 @@
>   * charge of setting up it's own stack, GDT and IDT.
>   */
>  
> +#define PVH_GDT_ENTRY_CANARY    4
> +#define PVH_CANARY_SEL          (PVH_GDT_ENTRY_CANARY * 8)

I can only advise against doing it this way: There's no safeguard against
someone changing asm/segment.h without changing this value (in fact
this applies to all of the GDT selectors populated in this file). At the very
least tie this to GDT_ENTRY_BOOT_TSS / __BOOT_TSS?

> @@ -64,6 +67,9 @@ ENTRY(pvh_start_xen)
>  	mov %eax,%es
>  	mov %eax,%ss
>  
> +	mov $(PVH_CANARY_SEL),%eax
> +	mov %eax,%gs
> +
>  	/* Stash hvm_start_info. */
>  	mov $_pa(pvh_start_info), %edi
>  	mov %ebx, %esi
> @@ -150,6 +156,7 @@ gdt_start:
>  	.quad 0x00cf9a000000ffff            /* __BOOT_CS */
>  #endif
>  	.quad 0x00cf92000000ffff            /* __BOOT_DS */
> +	.quad 0x0040900000000018            /* PVH_CANARY_SEL */

Without any further code before loading the selector, this points at
physical address 0. Don't you need to add in the base address of
the per-CPU stack_canary?

Jan
