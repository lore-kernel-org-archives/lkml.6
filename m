Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732904-1525111538-2-11037762751151426797
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525111538; b=TNRCVrmNLAooma6FUH9tdGPu+Ee/4dthRr2Hqz80ckCTkalU1X
    MEHtg3otaxXKbnIq4MsATukiPpaeR+QKf0gMUJtFhOsQsqdATAwcPn7P3YYyFmGb
    dmb75wGx3vL8y4wFK8W5OiMaLHLPamyqPyDQKK6dZTmULbZiZ+MF1luAgDd3+RqE
    S+eVUjFpNb3MJasqpj36LDHsbARNYskyw54xk83YuSdb/r33twS/ty+Eqq5MuAc+
    iXBVkhZBB4RX7gP6x4TN1I0GwzVy90WKHIoxQEyOb4XnZ+cJI/WJ6+v2Ckq/W0rd
    CawTRGlvt4AGhRxZtsMx+goTrwo6VYbq+2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525111538;
    bh=xJmHTMthh0QtRvIDUAnZithQmNI9YnIAAKL6L8Q4Wsc=; b=Orik6xssFcXO
    5g2QKytXZ9bxV1Zi8Q7O/XPkxtjaCnTGzqNZD2qSjBxHr9h8peWAPjg7vMwWVE9Z
    eHN5owDiqBrKkQ4ddUwpWrBAaWBLyypDa9s9JlC9ZfDeBtT5RqkGM8ruc3vCDJOA
    86ek1rUL99Sfi6T6RhIAqBdzTeeZHTyvkgWL+vStSNfcHz+ju46nzz6k6S1KLxxN
    sF5xv1V9RBuUYOfE66jpxs73eObpUg8eUYxepFrD7kMK9RhOOVfmEbh7YohtaStD
    wutipzpmtCBbE4c94XtyIfedIIgxvp4ulLgPasMzm/y8FDU9wzbM1XmmGASm+sOF
    aCmkR3SNtg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Gr22x8tc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Gr22x8tc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLtRK/SlQCAWPnxn3TfntSV0vuAqEEoRmf0G5a0GyBlzt+La312oeDHucuzvUlSYd+I+cTza/qZtNkyJmM9GNA7mUVXepkozkaEa0tOfwAd1mOBeyna+
    N9UdMOwP24DnHZ6Re5FUO6b3ca1NJluBo7gRGt9y0qh0TEVuoMgDda7k2kF2NNX4IJgp7PrOHZRXNZ9b6hJIRA8j8igpSopAv6YWnGeHjTHrupGVK/GctEF+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=PA8RhHZH_tBapMXY7tUA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754548AbeD3SF3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 14:05:29 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51386 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753480AbeD3SFF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 14:05:05 -0400
Subject: Re: [Xen-devel] [PATCH 1/4] xen/PVH: Replace GDT_ENTRY with explicit
 constant
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com, stable@vger.kernel.org
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
 <20180430162339.17143-2-boris.ostrovsky@oracle.com>
 <20180430165704.bkce56nzx3giodbd@MacBook-Pro-de-Roger.local>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <310676e9-d527-421b-a367-a6a8ada5255d@oracle.com>
Date: Mon, 30 Apr 2018 14:07:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430165704.bkce56nzx3giodbd@MacBook-Pro-de-Roger.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8879 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=781
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804300174
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/30/2018 12:57 PM, Roger Pau Monné wrote:
> On Mon, Apr 30, 2018 at 12:23:36PM -0400, Boris Ostrovsky wrote:
>> Latest binutils release (2.29.1) will no longer allow proper computation
>> of GDT entries on 32-bits, with warning:
>>
>> arch/x86/xen/xen-pvh.S: Assembler messages:
>> arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (32 is not between 0 and 31)
>> arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (40 is not between 0 and 31)
>> arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (32 is not between 0 and 31)
>> arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (32 is not between 0 and 31)
>> arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (40 is not between 0 and 31)
>> arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (32 is not between 0 and 31)
>>
>> Use explicit value of the entry instead of using GDT_ENTRY() macro.
>>
>> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  arch/x86/xen/xen-pvh.S | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
>> index e1a5fbe..934f7d4 100644
>> --- a/arch/x86/xen/xen-pvh.S
>> +++ b/arch/x86/xen/xen-pvh.S
>> @@ -145,11 +145,11 @@ gdt_start:
>>  	.quad 0x0000000000000000            /* NULL descriptor */
>>  	.quad 0x0000000000000000            /* reserved */
>>  #ifdef CONFIG_X86_64
>> -	.quad GDT_ENTRY(0xa09a, 0, 0xfffff) /* __KERNEL_CS */
>> +	.quad 0x00af9a000000ffff            /* __BOOT_CS */
>>  #else
>> -	.quad GDT_ENTRY(0xc09a, 0, 0xfffff) /* __KERNEL_CS */
>> +	.quad 0x00cf9a000000ffff            /* __BOOT_CS */
> Maybe it would be cleaner to use something like:

I actually considered all of these and ended up with a raw number
because it seems to be a convention in kernel (and Xen too, apparently) 
to use raw values in .S files.

Kernel is using now GDT_ENTRY_INIT() which is a C macro. There is one
other location where GDT_INIT() is used (arch/x86/boot/pm.c) and,
incidentally, it also generates this warning IIRC.

I really don't want to move definition to C code just to use a macro ---
I don't think C code needs to be exposed to this GDT.


>
> .word 0xffff /* limit */
> .word 0      /* base */
> .byte 0      /* base */
> .byte 0x9a   /* access */
> #ifdef CONFIG_X86_64
> .byte 0xaf   /* flags plus limit */
> #else
> .byte 0xcf   /* flags plus limit */
> #endif
> .byte 0      /* base */


I, in fact, started with something like this. But if you repeat this 4
times you will probably see why I decided against it ;-)


-boris


>
> Or try to fix the GDT_ENTRY macro, maybe if you prepend extra 0's to
> make the values 64bit that would prevent the warnings?
>
> Or declare the GDT in enlighten_pvh in C and use it here?
>
> Also, IIRC the base/limit values are ignored in long mode.
>
> Thanks, Roger.
