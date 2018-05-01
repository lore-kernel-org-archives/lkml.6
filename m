Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3108986-1525177001-2-7004385129260438787
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525177000; b=MLAMj/C1CkPRK2yeaMnCwI5jcJV0dkyoqcL2+GIW81KT1oaBTw
    0sccioomeB2bv8E/Z7Te0yhDEnW2O3GWwYUEUmHEUEmz9XwcP0C8v8zQ/7yO45QG
    kdBzn5Ts7QVgQyKP0SpT0xJFitT91q7LEfl+OPkiORBuZj5mWKQMJPYjzzaXL8qK
    +LP3h92lug/esPE8DUvYZ9LqHqjHQOmXhgT0mT5s80DFvxg8/LEhYthDh7jAGO3Z
    D4yY3+tk7s1DO6zBzXVxQtoNGYHJ6PbPOHFffnWl3L5qEpYmT6YB7xlcL1vvo0yI
    kioMYR90vBdAybtAIMfOVoL2qjfljGnhs+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525177000;
    bh=oPNAwli6aFH2FAQvu3zhNrp1ULVbmLCLKtSWnihq8DE=; b=FsK6sW4TX2fu
    Js9F16fm4rBttcuZjBSdNuho45vyZAj7BH1c9ayjqV289QcXunObGONS1FX4fh9u
    aKbDzrGXNNboRgGliWhh02bQzoY+hAkaeKTE8oc6r+D1bbGuGISnJOYMfcu2eCtB
    /ayMmQWZNfnnePwnQ/odU7nK0eJ+OtvU1wvC1Vw01cUBjIrOafUcNpXV08Wg4IxH
    P3i6NPe48/JD4lAjHDfVcj8s2YUI+/Q9rJl+py9MksO5OvnAXKEpLT1SXEi9FdVV
    sAU0Om521XNxFAXz9onyUWPSyA492hupe8GbgG+BvvEj+gWkN2lE3ato1xq6uBB2
    W2GTBpWiHQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
    header.i=@oracle.com header.b=Wvd0rcsV x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
      header.i=@oracle.com header.b=Wvd0rcsV x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGvPWCsrHQSpTKKqZU4uNygURji4p07YxWDcB+YkXKAkJRIRfOkfcseVHCWAJrXEbMRarY40Ff2unzUcfdGNaxX8XW1YI6/9Ghxh+/yfJX0+btB87mz+
    WfAnrZ8G54oDbHpRbnENZE4LacvIiaC5dngA082ebivXEiRdivPIUy53bL0vwdcXmNN5po51O70WxS++teSQ7tXsgWZ4GYIbASNnbxZBVu28zTj5PK3O8kas
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=9CLdXgv8KAxIvgJ2eWYA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755506AbeEAMQZ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 08:16:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45122 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755223AbeEAMQV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 08:16:21 -0400
Subject: Re: [Xen-devel] [PATCH 1/4] xen/PVH: Replace GDT_ENTRY with explicit
 constant
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com, stable@vger.kernel.org
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
 <20180430162339.17143-2-boris.ostrovsky@oracle.com>
 <20180430165704.bkce56nzx3giodbd@MacBook-Pro-de-Roger.local>
 <310676e9-d527-421b-a367-a6a8ada5255d@oracle.com>
 <20180501075352.ffx5dqaedo657nub@MacBook-Pro-de-Roger.local>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <776256de-1e9d-9e7a-2352-0f8ce0e7f5c8@oracle.com>
Date: Tue, 1 May 2018 08:16:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501075352.ffx5dqaedo657nub@MacBook-Pro-de-Roger.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8879 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805010124
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/01/2018 03:53 AM, Roger Pau Monné wrote:
> On Mon, Apr 30, 2018 at 02:07:43PM -0400, Boris Ostrovsky wrote:
>> On 04/30/2018 12:57 PM, Roger Pau Monné wrote:
>>> On Mon, Apr 30, 2018 at 12:23:36PM -0400, Boris Ostrovsky wrote:
>>>> Latest binutils release (2.29.1) will no longer allow proper computation
>>>> of GDT entries on 32-bits, with warning:
>>>>
>>>> arch/x86/xen/xen-pvh.S: Assembler messages:
>>>> arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (32 is not between 0 and 31)
>>>> arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (40 is not between 0 and 31)
>>>> arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (32 is not between 0 and 31)
>>>> arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (32 is not between 0 and 31)
>>>> arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (40 is not between 0 and 31)
>>>> arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (32 is not between 0 and 31)
>>>>
>>>> Use explicit value of the entry instead of using GDT_ENTRY() macro.
>>>>
>>>> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>>> Cc: stable@vger.kernel.org
>>>> ---
>>>>   arch/x86/xen/xen-pvh.S | 6 +++---
>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
>>>> index e1a5fbe..934f7d4 100644
>>>> --- a/arch/x86/xen/xen-pvh.S
>>>> +++ b/arch/x86/xen/xen-pvh.S
>>>> @@ -145,11 +145,11 @@ gdt_start:
>>>>   	.quad 0x0000000000000000            /* NULL descriptor */
>>>>   	.quad 0x0000000000000000            /* reserved */
>>>>   #ifdef CONFIG_X86_64
>>>> -	.quad GDT_ENTRY(0xa09a, 0, 0xfffff) /* __KERNEL_CS */
>>>> +	.quad 0x00af9a000000ffff            /* __BOOT_CS */
>>>>   #else
>>>> -	.quad GDT_ENTRY(0xc09a, 0, 0xfffff) /* __KERNEL_CS */
>>>> +	.quad 0x00cf9a000000ffff            /* __BOOT_CS */
>>> Maybe it would be cleaner to use something like:
>>
>> I actually considered all of these and ended up with a raw number
>> because it seems to be a convention in kernel (and Xen too, apparently)
>> to use raw values in .S files.
>>
>> Kernel is using now GDT_ENTRY_INIT() which is a C macro. There is one
>> other location where GDT_INIT() is used (arch/x86/boot/pm.c) and,
>> incidentally, it also generates this warning IIRC.
>>
>> I really don't want to move definition to C code just to use a macro ---
>> I don't think C code needs to be exposed to this GDT.
>>
>>
>>>
>>> .word 0xffff /* limit */
>>> .word 0      /* base */
>>> .byte 0      /* base */
>>> .byte 0x9a   /* access */
>>> #ifdef CONFIG_X86_64
>>> .byte 0xaf   /* flags plus limit */
>>> #else
>>> .byte 0xcf   /* flags plus limit */
>>> #endif
>>> .byte 0      /* base */
>>
>>
>> I, in fact, started with something like this. But if you repeat this 4
>> times you will probably see why I decided against it ;-)
> 
> Heh, right. Maybe a .macro to generate those? Or this is all too much
> for just a couple of GDT entries anyway...


That's what I thought. Especially given that assembly code seems to be 
using raw values.

> 
> For long mode however you could use simpler values, AFAICT the code
> segment in long mode could be simplified to:
> 
> 0x00209a0000000000
> 
> Because the base/limit have no effect.


True. However, we are sharing the DS (and later GS) descriptors between 
32- and 64-it modes. I can separate them if you think it makes sense.

-boris


> 
> In any case I'm not specially inclined either way, and maybe using
> similar values for 32 and 64bit modes makes this easier to understand
> (and decode if needed).
> 
> Roger.
> 
