Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3148351-1525384357-2-8139715926887239214
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525384357; b=R3XYbX3FS5+2d8z/vgdCk4I7yD6Lo15JDNXAjCR40slXp99yF5
    eEZ3qP9o60Y2aVxw9SycFOCm54R4SHDI44maO+/Ri43nEblPCzAyh+XtH2Sfgw4b
    woBlqkJKyB+47UOEiB9PYvA+1Jw4db1+ikG4o2Ipz+23eeQA0AkMQToecEY4Yfw3
    SOIG8z/b2iikHWF/QHdm1DcXJ7Hx/PrHBB83v52MIlRNx8AF6Ukr0MPZinXZyDMw
    /VU/Vu4d2JGE8ntEbSMyLt3zxu98uz4niV2bfo1ELKBKxW0Qjw/LOjd9BwdztPnL
    MsblPURBgkrVBvvDR/0R6H1NErcB6atzkJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525384357;
    bh=LKkHzF2hbR1MP2TnDz1jv/JpGx64DofpPo2fyH/vdSs=; b=T5ZIOdJB4Ysq
    Wcd8N0IpfHX1/gOwAHfFVw/wRafSIMzWh5u6mt9Pz82sOojccm2jLLPAY6TPfeQD
    jsm/1oYBdrFxNmEoKQOpKS0fFVnhj4F+A6ZGSG01AqaKdoi/pk+LH+b+ctwWELWc
    jtd0Mmu2SfM5qNn+jASOPk/ZiOD+81dUtfMQYXuuiDPsgujg7PlfoSYcNShRmuPF
    PynjNIkBmmPlbWr7FIe4oiM9hbBgQ/cUfGO11LaUGp/IG1rMbeXBa4YEczB2lHI2
    5j7vxiLcS+mZo2PjjLpRYJWfpem/GuAm1mdy8PpjSzNQpJ7sZF+eCUBNX/jutbYh
    ems02hXNCA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=WQAgY/ZZ x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=PBGfN4vO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=WQAgY/ZZ x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=PBGfN4vO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD/LwuVe8IntodVd8DCsHKWXqVMT6xtG6dfITXe+zxHyO632ij3jjZ0gVD+etTbbxEgWWu4dlcYI8/Gs0CPBaT5EgBY9RdClNJZaQu4ZkqhJhmxosjvL
    a27+e/6pWt0rOpSvL12D1QsWqP0nrtEaeWAjusRTDjpW8SKiLVnG7d70Ef6C1pceuscot3lY9txLTA60xDFrYTqVp1Br6CWZ18B4vaV186ViWkjJQfONJobv
    GKEnxgFZtKopeF7WNAs66g==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=OWgH-102JUsA:10 a=xqWC_Br6kY4A:10 a=4_-BN3WEXhEA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=vSREcoS7n-B-j0QU_6sA:9 a=RLxDDVBjfb6fYRnY:21
    a=ZrXtmOWSty3ZE4m6:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeECVwe (ORCPT <rfc822;linux@kroah.com>);
        Thu, 3 May 2018 17:52:34 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43346 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbeECVwd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 May 2018 17:52:33 -0400
X-Google-Smtp-Source: AB8JxZrcdOQN69F8sI2xqm0UqrxFq9sE05nptmXFhXueHefhpgWgVXTQRnttI+xGblcEL7h/oxzQ8A==
Subject: Correct way to access the physmap? - Was: Re: [PATCH 7/9] Pmalloc
 Rare Write: modify selected pools
To: Matthew Wilcox <willy@infradead.org>, dave.hansen@linux.intel.com
Cc: linux-security-module@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Igor Stoppa <igor.stoppa@huawei.com>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
 <20180423125458.5338-8-igor.stoppa@huawei.com>
 <20180424115050.GD26636@bombadil.infradead.org>
From: Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <035f2bba-ebb1-06a0-fb88-3d40f7e484a7@gmail.com>
Date: Fri, 4 May 2018 01:52:29 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424115050.GD26636@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 24/04/18 15:50, Matthew Wilcox wrote:
> On Mon, Apr 23, 2018 at 04:54:56PM +0400, Igor Stoppa wrote:
>> While the vanilla version of pmalloc provides support for permanently
>> transitioning between writable and read-only of a memory pool, this
>> patch seeks to support a separate class of data, which would still
>> benefit from write protection, most of the time, but it still needs to
>> be modifiable. Maybe very seldom, but still cannot be permanently marked
>> as read-only.
> 
> This seems like a horrible idea that basically makes this feature useless.
> I would say the right way to do this is to have:
> 
> struct modifiable_data {
> 	struct immutable_data *d;
> 	...
> };
> 
> Then allocate a new pool, change d and destroy the old pool.

At the end of the summit, we agreed that I would go through the physmap.

But I'm not sure of what is the correct way to access it :-/

Starting from a vmalloc address, say:

int *i = vmalloc(sizeof(int));

I can get its linear counterpart:

int *j = page_to_virt(vmalloc_to_page(i));

and the physical address:

int *k = virt_to_phys(j);

But how do I get to the physmap?

I did not find much about it, apart from papers that talk about specific 
hardcoded addresses, but I would expect that if there is any hardcoded 
constant, by now, it's hidden behind some macro.

What I have verified, so far, at least on qemu x86_64, is that 
protecting "i" will also make "j" unwritable.

--
igor
