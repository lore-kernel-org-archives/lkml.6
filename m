Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-897776-1525273318-2-16455121119023698020
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
    1525273316; b=EzogqEAJ9Cy0wDYTwMe22EyffMuIdY3EcDJPWxVfj1vhbWL915
    ToLWlEG2ryLscLgye8NpVebCOgIUJDec9iZXRcqHBxyl4AUGJ7n9y0qCiD/nwbop
    efZuo0AZ6FaPXkkTvoycLv82hXWFVVkyUvWwRkPk8lBSMxhJHKzjmh52OHYNanp6
    2oEYSErQIkyBEopfNJ+6iCVIOm8dFmhtl48QXE4bkrknIAS8s/Uq79ZcI58aGVII
    qBQPo/gPwnWE/wmbnzGBrpb01J6tyZCI/iRT9EHNUikhETI8igHXjxhlRGRe5aVc
    VRfnkSRJLwCAGjxqnd37A1+x4mV30xIh/pGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:in-reply-to:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525273316;
    bh=r28uNWbQZo3PdAiuzFu5+C429VFMRGCk7cV+V3Ayhyc=; b=A7KckV8zsl0q
    m0nsljZj6YaLYv3XPMSksjez4uLuXZmB1Xi+WyjsSgLQWRPgaRpKVbVlSUhM7f8a
    qlAiNpNxXU+HWkOSKhJ624wRDDCjRIwZ2wjWu5lp+5ve0KKerz7N7tM1vo+3YQKp
    Tk1EHHrlefhtsq5ZBvQ9+rApsUPKDyXsBwozAI7hdHFEb/Sv8V3XiPAT32qjAqyR
    I1EE59GHUE+nvbVtJSJjfn2Pjrb8PB8CEGqZKJ5ut68dtI77LlCAiYz5rna//4n1
    k7EIT8HPoH3ZW+0dznulx3xaBppC2BRAj8+tJGTWkyzvVj09xjMaZ6Buh4KhtW6X
    ZfqElGrALw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfBZuKJW/gAz67EGejSa455izjyPuFmLAmjtr4GpgLTPtm+4TMdlePFYQR2kbil2z998VpKeEVmxl4ymHE9aJFd1ilhr0TnqhwsD3422TErLe4uS6EPM5
    x42AJZUxLr6+8d6TA4xzppMMM2BcfX6N7JtTtrR6UkuGndKcm/5EkyD/MzSYpmT5bWPg5tktYroTfdY3VmH3d9JgLvX2cIM1Pydpvo8ioYRADPoj7iRbLMSL
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=qar9sMMzLkbzSfOHmXsA:9 a=M4dmaSuXvIuMGgTE:21
    a=lZLzBI_aTAzUbEpz:21 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751144AbeEBPBz convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 2 May 2018 11:01:55 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:59470 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbeEBPBy (ORCPT
        <rfc822;groupwise-stable@vger.kernel.org:4:2>);
        Wed, 2 May 2018 11:01:54 -0400
Message-Id: <5AE9D2DD02000078001C02F0@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Wed, 02 May 2018 09:01:49 -0600
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
In-Reply-To: <615b0e30-c360-3ad4-f1b3-0e907d790643@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>>> On 02.05.18 at 17:00, <boris.ostrovsky@oracle.com> wrote:
> On 05/02/2018 04:16 AM, Jan Beulich wrote:
>>>>> On 30.04.18 at 18:23, <boris.ostrovsky@oracle.com> wrote:
>>> --- a/arch/x86/xen/xen-pvh.S
>>> +++ b/arch/x86/xen/xen-pvh.S
>>> @@ -54,6 +54,9 @@
>>>   * charge of setting up it's own stack, GDT and IDT.
>>>   */
>>>  
>>> +#define PVH_GDT_ENTRY_CANARY    4
>>> +#define PVH_CANARY_SEL          (PVH_GDT_ENTRY_CANARY * 8)
>> I can only advise against doing it this way: There's no safeguard against
>> someone changing asm/segment.h without changing this value (in fact
>> this applies to all of the GDT selectors populated in this file). At the 
> very
>> least tie this to GDT_ENTRY_BOOT_TSS / __BOOT_TSS?
>>
>>> @@ -64,6 +67,9 @@ ENTRY(pvh_start_xen)
>>>  	mov %eax,%es
>>>  	mov %eax,%ss
>>>  
>>> +	mov $(PVH_CANARY_SEL),%eax
>>> +	mov %eax,%gs
>>> +
>>>  	/* Stash hvm_start_info. */
>>>  	mov $_pa(pvh_start_info), %edi
>>>  	mov %ebx, %esi
>>> @@ -150,6 +156,7 @@ gdt_start:
>>>  	.quad 0x00cf9a000000ffff            /* __BOOT_CS */
>>>  #endif
>>>  	.quad 0x00cf92000000ffff            /* __BOOT_DS */
>>> +	.quad 0x0040900000000018            /* PVH_CANARY_SEL */
>> Without any further code before loading the selector, this points at
>> physical address 0. Don't you need to add in the base address of
>> the per-CPU stack_canary?
> 
> This GDT is gone soon after we jump into generic x86 startup code.That
> code will load its own GDT (and then set up per-cpu segments and all that).

All understood, but why would you set up the per-CPU segment here if
what you load into the segment register is not usable for the intended
purpose (until that other code sets up things and reloads the segment
registers)?

Jan
