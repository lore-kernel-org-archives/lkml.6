Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3287437-1525387948-2-9287037140345330844
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525387948; b=bhdjkEl32unMfU9mda9VNAL0lKD+V59YOTpP4DEtnzRDcazzcl
    cWNLqRQwu0cjtEpPbaphuAtPoOt6Wm2Uis5PyYVrj6OAwuNhe0DoCuQG+B+p8Jep
    EfbkPr+fpHoMvHT7lNXHXo8Bk19JCQPkZ6mVt2wE6WAKHOiOcK3N1l7gsU2srqfn
    o86alGdocYBzpJSUKIGjqTOmnTqnhVH6KDxju47i/dWtb5rz2gjnM88dTGZo66OS
    W6KzW+Df4jdjEDa4jrWUDaLHq7K+S+IHNBUp3zjt7kRq/L/g6xAMNpGT6X1wMfeO
    NPR4Vi2pdhVr0VF8e/DPCYYilP/+uYyg66dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525387948;
    bh=hJ/hmnGwyD117h68PUjur37hAZkP7DLJn5oEuQjEyRE=; b=dc0uXjxqeMzv
    NCM9qDyAY/qAxIh93Nr67duatRNWVqQlNSiMpoSHkzwyVgI1wU1vrsGsWcTrgWAi
    hsjcf5ycaEWMnciPuxPQT+0y1Du6CS3oMV46F+j7Ls/Ut6xid6Hq0ymH+zIAmSzq
    fzt+w6WStst/mp35+aWtCv+83RixPGQKUgshtNIwdfP0fsOD+e1RmomWzN+d0MxZ
    8FMXcXkS/8vEB3N6gJxgTe362Hbja1qYjRickYZuH7S3uR2FEVoHNw8x22wIia09
    50tE5yvaadKTOPy4Sxjt2vs1LhBEQ7ZHrAvfMQTe9gXNXeT5zuNJ2q68Mp0y5j3g
    Yci5b0ZY4Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=ZLYfSFXc x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=mIKxmt+T;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=ZLYfSFXc x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=mIKxmt+T;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIVchJ9LzuJfpku9Ln0kB0mw+G+yj/om9s6GEQLgXtUuuOjBU14k8xWkGpbc5E8oVsUxrf1w6k5SQJSDgbkuTJl2Yv9lSm8Kc+IlAqJEIYrueMRcwt6+
    winkBbCmZ8OzwQHJFthg0phgNLTQ2Cs+Hfa7pMDs07ikj9yazPlUR7XuFRVrAiVbqqeSCzZJ8Qv7rpxoBN4ihF2R9mOva+2Vrxvz1VLmNl4j7b8/yUJJkkww
    tjZnwudtj2KzXc6zh00cMQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=OWgH-102JUsA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=bipczEzUf6gePfAZrc0A:9
    a=CEVPCDR6jXBw6lkU:21 a=lLXuVgZuF7MzRysZ:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbeECWw1 (ORCPT <rfc822;linux@kroah.com>);
        Thu, 3 May 2018 18:52:27 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44727 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbeECWwZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 May 2018 18:52:25 -0400
X-Google-Smtp-Source: AB8JxZp3HpAE7GUbaSF0jdCr3BRS783Xhd/9v9QhX6SL393hHdBm2JpMAHx08gkjWckxeKjh7VPn2Q==
Subject: Re: Correct way to access the physmap? - Was: Re: [PATCH 7/9] Pmalloc
 Rare Write: modify selected pools
To: Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc: linux-security-module@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Igor Stoppa <igor.stoppa@huawei.com>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
 <20180423125458.5338-8-igor.stoppa@huawei.com>
 <20180424115050.GD26636@bombadil.infradead.org>
 <035f2bba-ebb1-06a0-fb88-3d40f7e484a7@gmail.com>
 <ef116557-1fb1-780e-2480-3eef9052b609@intel.com>
From: Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <91ca0b5e-0719-7ebf-4e11-8b17f54251fe@gmail.com>
Date: Fri, 4 May 2018 02:52:22 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ef116557-1fb1-780e-2480-3eef9052b609@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/05/18 01:55, Dave Hansen wrote:
> On 05/03/2018 02:52 PM, Igor Stoppa wrote:
>> At the end of the summit, we agreed that I would go through the physmap.
> 
> Do you mean the kernel linear map? 

Apparently I did mean it. It was confusing, because I couldn't find a 
single place stating it explicitly, like you just did.

> That's just another name for the
> virtual address that you get back from page_to_virt():
> 
> 	int *j = page_to_virt(vmalloc_to_page(i));
> 

One reason why I was not sure is that also the linear mapping gets 
protected, when I protect hte corresponding page in the vmap_area:

if i do:

int *i = vmalloc(sizeof(int));
int *j = page_to_virt(vmalloc_to_page(i));
*i = 1;
set_memory_ro(i, 1);
*j = 2;

I get an error, because also *j has become read only.
I was expecting to have to do the protection of the linear mapping in a 
second phase.

It turns out that - at least on x86_64 - it's already in place.

But it invalidates what we agreed, which was based on the assumption 
that the linear mapping was writable all the time.

I see two options:

1) continue to go through the linear mapping, unprotecting it for the 
time it takes to make the write.

2) use the code I already wrote, which creates an additional, temporary 
mapping in R/W mode at a random address.


I'd prefer 2) because it is already designed to make life harder for 
someone trying to attack the data in the page: even if one manages to 
take over a core and busy loop on it, option 2) will use a random 
temporary address, that is harder to figure out.

Option 1) re-uses the linear mapping and therefore the attacker really 
only needs to get lucky and, depending on the target, write over some 
other data that was in the same page being unprotected, or overwrite the 
same data being updated, after the update has taken place.


Is there any objection if I continue with options 2?

--
igor
