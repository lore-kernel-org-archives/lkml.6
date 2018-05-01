Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3108986-1525178440-2-3875868803976268552
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525178439; b=f7xoSAE/LVwtdvl2d7pqV8SZZhKp6fgzu4P4DNT1tKEYqsZgi1
    1Sn2xqQTkzrTzmbwadIL1xXXYIZDnCvvnmJxy/51Dd4RzoBT2rwnkan5ffHGN2NC
    sNZOHFB9WwfErSre5UlOXiXaUjwwtaUxVsvUtIdcK9SL6FqVcL/jhtWaparYhsVK
    a9XJEIQMz3fqIWRKNfcifh7J3zp+njlHipK6TlFOKbLXoeuDSIs/XXo292uHdyIg
    erIsGe48jRqbOQGiUlp7HT1rAGT9fjifbAWQaM8s2eXh7d4Bad1XhjbpiJuENwwL
    T+2NdiqTeRpKwnlsMEhNSjq5qYsQJvAJUQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525178439;
    bh=vG+3UFSJCzNNZ86eIg7HA6J4XMHdvCJijd+wA/jdlAc=; b=mTGnEhO7Yf8f
    A9VF8gZ4UdGCKWITiHur0+bjQOsyr+qe2xw9+lgH1ijBNM303wxvRtKrEk4mqp5L
    kGr878HzEgkGKvbUV8kwYWfE/b9fNBZ7W1++umnRTaOzYehHXqfhumUX9rEFV0/q
    aDmYQhNA8/i6y0w731kuy2REsI22FA03gB4kybDubK6sxeNJhjLcmmXqdU60nTUM
    Bjdpi1TlofpK4hoea4eWfseFU3pd2rP+jhYnjzTZW1n0W/str7sij4AZamwD2Sv2
    gPAyr/lmmnYZAqRKr8JvkQxNdgHM7Y2riEWLptaFUX3v1kAqDxkn8Ey8njx/+if5
    taHziwwxcw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
    header.i=@oracle.com header.b=StvNPXPV x-bits=2048 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
      header.i=@oracle.com header.b=StvNPXPV x-bits=2048 x-keytype=rsa
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
X-CM-Envelope: MS4wfDNbf4xTcXDRCatB5ALAgUjGFNR4WI6n8BQmvqL5dqMyEDA9W6SwnfYjBSizDVblxXmxiJoE90uENpKZUZ7R4rIQt9ssMmvWqshpJq1tl60T+M2NCaNu
    wTYtiumWBb15ajUkFzjWD87yciOlkQvIz3lijkA6pTS6hRNowIgG2H9y4tPAFPN8rUo6HQxETPdU5OKm65gxy62y1oVkynx89ZXBQC8TZXYLt9WI6dOZ/Zvg
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=cWRNjhkoAAAA:8 a=iox4zFpeAAAA:8 a=iOhjNtWLBL_JuIC7nAkA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=sVa6W5Aao32NNC1mekxh:22
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755206AbeEAMkg (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 08:40:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44220 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755044AbeEAMkf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 08:40:35 -0400
Subject: Re: [PATCH 1/4] xen/PVH: Replace GDT_ENTRY with explicit constant
To: David Laight <David.Laight@ACULAB.COM>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Cc: "jgross@suse.com" <jgross@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
 <20180430162339.17143-2-boris.ostrovsky@oracle.com>
 <70673793884c4eba857970359f9f5158@AcuMS.aculab.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <b681fc9c-ae83-ae51-2025-afe84678b14c@oracle.com>
Date: Tue, 1 May 2018 08:40:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <70673793884c4eba857970359f9f5158@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8879 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=859
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805010127
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/01/2018 07:31 AM, David Laight wrote:
> From: Boris Ostrovsky
>> Sent: 30 April 2018 17:24
>> To: linux-kernel@vger.kernel.org; xen-devel@lists.xenproject.org
>> Cc: jgross@suse.com; Boris Ostrovsky; stable@vger.kernel.org
>> Subject: [PATCH 1/4] xen/PVH: Replace GDT_ENTRY with explicit constant
>>
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
> ...
>>   #ifdef CONFIG_X86_64
>> -	.quad GDT_ENTRY(0xa09a, 0, 0xfffff) /* __KERNEL_CS */
>> +	.quad 0x00af9a000000ffff            /* __BOOT_CS */
>>   #else
>> -	.quad GDT_ENTRY(0xc09a, 0, 0xfffff) /* __KERNEL_CS */
>> +	.quad 0x00cf9a000000ffff            /* __BOOT_CS */
>>   #endif
>> -	.quad GDT_ENTRY(0xc092, 0, 0xfffff) /* __KERNEL_DS */
>> +	.quad 0x00cf92000000ffff            /* __BOOT_DS */
>>   gdt_end:
> 
> It has to be possible to fix the GDT_ENTRY() macro.
> Even if you end up with one that generates two 32bit values.


Is it worth it though? We seem to be using GDT_ENTRY_INIT() everywhere 
and the only other reference that I see is in pm.c and it also probably 
ought to use GDT_ENTRY_INIT().


> 
> You've also changed the name in the comments.

Yes, I should mention this in the commit message.


-boris
