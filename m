Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-970458-1525275275-2-6511706375283755040
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525275275; b=HOeFEBvxbeNmDdq9HHmcSnOJcii/Z3WgBbhweCpF+SN0fN985Y
    9XvDQC0AkcW2KUSjrr0VgNmvQd6gvpN9NQqMTmLdqa6QlsoubLdUdaeISYTbl0LB
    6ZlfYh7xCj5su2VcHJrFi1+u3KCTFvxu1Y6XgZn075JK31Cs5Z1jLMjrARBEJxbx
    G5FOJc5VvK1BiOfB/YT29RtEGbjhcscTtA8FyyD13JMOJVoLrIj9zv1Xvo6pAtzL
    WL9fBZN3lPGNzpR10A5KcjgRuGMbpL5R6Av1cM8KrtxvHhzR+sKj7EHIFDGfxAAs
    bODQclmQTB4wH/+d9dsKCeBdK+A2ew02USqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525275275;
    bh=tjakATl6mnNzM9N+WOU0mvQZuexqHRiPXW5mak9T0ho=; b=lCd5Mr5apJZb
    XL9VtAvbmtoWyHtL1ntLdHsbTz90Hw7cqMvkgNNE/uwXmi+q5rOzYAT6Idy78pcd
    nbaFSThogGLTGl+eDHHfLBOh/GbFBTbHXhPJzhCE4sjzzBSJLcHZx7YlCRGSWS+b
    fkzo+1gkpw30VAQ+GBNr7Fswy2yOGuBf10+1HQxzErNHBAyrjd71u8xp5bIvcroM
    wKdCbh/SKJPb6hQ+O/Y3GUWoRFlt/1VhfAwsnlVCrNy+LZDcQ730iCD8i31S+HL0
    PxEKBbnDRlwIkUfLeURXbhmU4azD5Vfip0JpBjzJjxq1ZGD6A8RQZV731TPLe1ze
    ucIE51Y8gQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
    header.i=@oracle.com header.b=QO3rS6cy x-bits=2048 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
      header.i=@oracle.com header.b=QO3rS6cy x-bits=2048 x-keytype=rsa
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
X-CM-Envelope: MS4wfMzakh0PQG/9eDiMAeo2Fse61cHp0gWBy/AtbT41qSbRiiui+RN1JRFS3huFd7+TT54jCzy2wpnSNbvxZ/uypKIOVBXgasAR5//paZ47Ogu0/VMA3sl3
    +T+AvmkdMKRO3JXJV+olJTxqJy5nllFwaMIrTfhCKx1VRRrlR8xgcJxXFaMI/pHCR5zdfHcno/X8rZeqjEotEvMYrLFKpmtArnkgu8myt8tJyuC6gEBWrTRy
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=j4fmYhm-LQ7WX9w-vfIA:9 a=wuoV1WYUt2czbihS:21
    a=voyHm42oHMErA00H:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751641AbeEBPUO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 11:20:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34268 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751604AbeEBPUJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 May 2018 11:20:09 -0400
Subject: Re: [Xen-devel] [PATCH 3/4] xen/PVH: Set up GS segment for stack
 canary
To: Jan Beulich <JBeulich@suse.com>
Cc: xen-devel <xen-devel@lists.xenproject.org>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
 <20180430162339.17143-4-boris.ostrovsky@oracle.com>
 <5AE973CD02000078001C008E@prv1-mh.provo.novell.com>
 <615b0e30-c360-3ad4-f1b3-0e907d790643@oracle.com>
 <5AE9D2DD02000078001C02F0@prv1-mh.provo.novell.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <6729d0ff-31ff-779d-6d6f-511f9ee29e50@oracle.com>
Date: Wed, 2 May 2018 11:22:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5AE9D2DD02000078001C02F0@prv1-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8880 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=759
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805020126
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/02/2018 11:01 AM, Jan Beulich wrote:
>>>> On 02.05.18 at 17:00, <boris.ostrovsky@oracle.com> wrote:
>> On 05/02/2018 04:16 AM, Jan Beulich wrote:
>>>>>> On 30.04.18 at 18:23, <boris.ostrovsky@oracle.com> wrote:
>>>> --- a/arch/x86/xen/xen-pvh.S
>>>> +++ b/arch/x86/xen/xen-pvh.S
>>>> @@ -54,6 +54,9 @@
>>>>   * charge of setting up it's own stack, GDT and IDT.
>>>>   */
>>>>  
>>>> +#define PVH_GDT_ENTRY_CANARY    4
>>>> +#define PVH_CANARY_SEL          (PVH_GDT_ENTRY_CANARY * 8)
>>> I can only advise against doing it this way: There's no safeguard against
>>> someone changing asm/segment.h without changing this value (in fact
>>> this applies to all of the GDT selectors populated in this file). At the 
>> very
>>> least tie this to GDT_ENTRY_BOOT_TSS / __BOOT_TSS?
>>>
>>>> @@ -64,6 +67,9 @@ ENTRY(pvh_start_xen)
>>>>  	mov %eax,%es
>>>>  	mov %eax,%ss
>>>>  
>>>> +	mov $(PVH_CANARY_SEL),%eax
>>>> +	mov %eax,%gs
>>>> +
>>>>  	/* Stash hvm_start_info. */
>>>>  	mov $_pa(pvh_start_info), %edi
>>>>  	mov %ebx, %esi
>>>> @@ -150,6 +156,7 @@ gdt_start:
>>>>  	.quad 0x00cf9a000000ffff            /* __BOOT_CS */
>>>>  #endif
>>>>  	.quad 0x00cf92000000ffff            /* __BOOT_DS */
>>>> +	.quad 0x0040900000000018            /* PVH_CANARY_SEL */
>>> Without any further code before loading the selector, this points at
>>> physical address 0. Don't you need to add in the base address of
>>> the per-CPU stack_canary?
>> This GDT is gone soon after we jump into generic x86 startup code.That
>> code will load its own GDT (and then set up per-cpu segments and all that).
> All understood, but why would you set up the per-CPU segment here if
> what you load into the segment register is not usable for the intended
> purpose (until that other code sets up things and reloads the segment
> registers)?

The intended purpose here is to allow stack protector access not to
fail. At this point it doesn't really matter that GS is later used for
per-cpu segment, this code (and this GDT) will not be used when other
CPUs come up.

-boris
