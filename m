Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2061751-1525332934-2-14074279475342510091
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
    1525332934; b=TC/nR8u6GU4mtM+Ktrqsw5rRV9vhjpfl1GychF8+a9QWmWT6hp
    3nBI266wK4nUjgRRFMD//FH2oeB8pdvBBAxjCShoY7B/hsM8m5D9CmeBvPZXQEOW
    C2MHtB5X/cwxG2qpgsDBBriGfRHxg/S6noWKjF+f/ungEXvcOBr+CwYReCG8ju9U
    ewCSVeET+2gbMSUf6d6xwps3dM1EtvfSivgDqLOUi6xyp6rMKSJRExA3FfLQa8Qs
    JGfK3VwBNAF5hb8nxuZeD8jG7bIKOK6Ipz6omWlNwujQvbyrrrcFaDw7yWiv/vm+
    fxkV21JZhCqZbkp+p2GNg1Zu6yn5LfSp/h4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:in-reply-to:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525332934;
    bh=ZjMnCx6JzDYdpWxLPZkAXUxTzcOjpzkphyUb3HChEfw=; b=jFjOrYURWtio
    WuqJZX2yu0bvk7muFN3wTK2sFvIc5Vx7bG/hjYeKC6bYT/ejkwaa3Yi43IBWqjUm
    1L1PhNU1pihHShWGSRgNdVXPB/fAvAO+okwsLl1v/wjRgGqNCS2zzJXXXLp1CJax
    ismmhjaSsrJiyZS3Wxpm/42BTwW6ckDYPe8CIh7+nWa/y3YxGMP7kk7Xl3ZOferU
    cJrzoTyJD4mMxxf9hnLLYqzIVBZ0mEOkgp87sN96HhJZrlczwFHZNfzciuAHzWrz
    TcR4yheDzCmtcN/Ujmr9ZUPkE5JDAqElqAi+4dfwR610GHrJFNRJg5Ta6iIBYnR5
    rBJpgK2MCA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfOGH1NZe4tf/8WjFK7nsE29qFedGLmDfP6uolAaXCeUXo3ey8zXL0ExFx3/PKprMStnHsEC4QN01ms9BYu7lgU+MB+mOON6tZfUUdqw0snk4lK1W9dbs
    b0favK1Bpyarr25peJ+W7G7bSdJpgGBaVc/7sKlCAUGWAnm0SuoI0pHAySCSbRRtKxxwq6yZug4a3MxXtnUuggiH4SJLIjsbh4dmFiSIW1U49kZ2H3lLzItR
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=wEVvR5VzqjGt6AzcUZYA:9 a=5R1ZBMBmDRI-tzEc:21
    a=TaiCiWXiIRaBLvCw:21 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750829AbeECHfb convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 3 May 2018 03:35:31 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:55241 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeECHfb (ORCPT
        <rfc822;groupwise-stable@vger.kernel.org:4:2>);
        Thu, 3 May 2018 03:35:31 -0400
Message-Id: <5AEABBBF02000078001C05B0@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Thu, 03 May 2018 01:35:27 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Cc: "xen-devel" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH 3/4] xen/PVH: Set up GS segment for
 stack canary
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
 <20180430162339.17143-4-boris.ostrovsky@oracle.com>
 <5AE973CD02000078001C008E@prv1-mh.provo.novell.com>
 <615b0e30-c360-3ad4-f1b3-0e907d790643@oracle.com>
 <5AE9D2DD02000078001C02F0@prv1-mh.provo.novell.com>
 <6729d0ff-31ff-779d-6d6f-511f9ee29e50@oracle.com>
 <5AE9DC1D02000078001C0370@prv1-mh.provo.novell.com>
 <9ed1210b-47ce-7e03-cc5d-2866bfc7ad03@oracle.com>
In-Reply-To: <9ed1210b-47ce-7e03-cc5d-2866bfc7ad03@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>>> On 02.05.18 at 19:29, <boris.ostrovsky@oracle.com> wrote:
> On 05/02/2018 11:41 AM, Jan Beulich wrote:
>>>>> On 02.05.18 at 17:22, <boris.ostrovsky@oracle.com> wrote:
>>> On 05/02/2018 11:01 AM, Jan Beulich wrote:
>>>>>>> On 02.05.18 at 17:00, <boris.ostrovsky@oracle.com> wrote:
>>>>> On 05/02/2018 04:16 AM, Jan Beulich wrote:
>>>>>>>>> On 30.04.18 at 18:23, <boris.ostrovsky@oracle.com> wrote:
>>>>>>> --- a/arch/x86/xen/xen-pvh.S
>>>>>>> +++ b/arch/x86/xen/xen-pvh.S
>>>>>>> @@ -54,6 +54,9 @@
>>>>>>>   * charge of setting up it's own stack, GDT and IDT.
>>>>>>>   */
>>>>>>>  
>>>>>>> +#define PVH_GDT_ENTRY_CANARY    4
>>>>>>> +#define PVH_CANARY_SEL          (PVH_GDT_ENTRY_CANARY * 8)
>>>>>> I can only advise against doing it this way: There's no safeguard against
>>>>>> someone changing asm/segment.h without changing this value (in fact
>>>>>> this applies to all of the GDT selectors populated in this file). At the 
>>>>> very
>>>>>> least tie this to GDT_ENTRY_BOOT_TSS / __BOOT_TSS?
>>>>>>
>>>>>>> @@ -64,6 +67,9 @@ ENTRY(pvh_start_xen)
>>>>>>>  	mov %eax,%es
>>>>>>>  	mov %eax,%ss
>>>>>>>  
>>>>>>> +	mov $(PVH_CANARY_SEL),%eax
>>>>>>> +	mov %eax,%gs
>>>>>>> +
>>>>>>>  	/* Stash hvm_start_info. */
>>>>>>>  	mov $_pa(pvh_start_info), %edi
>>>>>>>  	mov %ebx, %esi
>>>>>>> @@ -150,6 +156,7 @@ gdt_start:
>>>>>>>  	.quad 0x00cf9a000000ffff            /* __BOOT_CS */
>>>>>>>  #endif
>>>>>>>  	.quad 0x00cf92000000ffff            /* __BOOT_DS */
>>>>>>> +	.quad 0x0040900000000018            /* PVH_CANARY_SEL */
>>>>>> Without any further code before loading the selector, this points at
>>>>>> physical address 0. Don't you need to add in the base address of
>>>>>> the per-CPU stack_canary?
>>>>> This GDT is gone soon after we jump into generic x86 startup code.That
>>>>> code will load its own GDT (and then set up per-cpu segments and all that).
>>>> All understood, but why would you set up the per-CPU segment here if
>>>> what you load into the segment register is not usable for the intended
>>>> purpose (until that other code sets up things and reloads the segment
>>>> registers)?
>>> The intended purpose here is to allow stack protector access not to
>>> fail. At this point it doesn't really matter that GS is later used for
>>> per-cpu segment, this code (and this GDT) will not be used when other
>>> CPUs come up.
>> But the place the canary would live this way is completely wrong. 
> 
> 
> Would creating a canary variable and using it as a base address be better?

Of course, because then at least you properly control where an eventual
access would go, instead of touching some unrelated memory location.

Jan
