Return-Path: <kernel-hardening-return-13117-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZpomEkPF1eJlEmtGHtF0JTEYaL/EUyfXjnJEgYu0HrxbFEOZA7rdMEq2+I3EwsD4/L2VRNi
ARC-Seal: i=1; a=rsa-sha256; t=1524583768; cv=none;
        d=google.com; s=arc-20160816;
        b=u0SfZTeMta9gqcA5HMJ6SyUXwLirgrih7bFPiPP4Am69oVE/dkirCOto7Aw7X3NdaY
         Y07xip8xubHRfyQcTmuMRK4+ep/pr2gqdzNlyquQdEEJxs3eWDLA5Qrg1WL761q+OHR6
         aoNxOrs2LOvlnY97W4ndhQOAoiVPzux7a6jaFCRldaA4JR6YG8kKnWECVwQiABuaxpu5
         cGQKybbHoD6+I+l95OSn0iZf25Aj6PTkS59FIqKowAepeZ1LeLNiiM74gui8vQwG5lZg
         c9iboOrHrI1n6tbDDGdMMoHU2AqL16ZLepoDvLhdzLL34B8qMiB+OgKDPI6PbqIHPprp
         RyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=fengJc3/RWUkTJvsa3BFD/1Cj8ARDj/NgFG2d6ciGN8=;
        b=xVB8xjpbuScyVt5KmpaOEqcasMuQJXNwsxitgQxuFUe919d5l8GxzDphFFyjv8ZNwo
         DSRYYsn5o+/hK+sL5Ty1n4oAn9R3qdThxyhVGv5C/XrLoOvr1dnvY2UTadQUgLDseYM4
         6oNwMdJ8Mu49v4NEvZ2LrY7C6/vabOH2U0EBbDo7HVjTIbU6Z5b3XP9YmNxbfJfNJc9j
         bQbDmjO7SGQAciFz05KAsOvyRZx7vzzMoMe2VVbrS+e3UL/2g3Xq9Ed4MxU4yCQXnzS9
         j6wta/iPzGvs6+x+fJn5mnQ8Le/+91EFMY+p8NXPhBAx5klqGdAoJNong59gduripsoV
         hLiw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZhdnJZd5;
       spf=pass (google.com: domain of kernel-hardening-return-13117-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13117-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZhdnJZd5;
       spf=pass (google.com: domain of kernel-hardening-return-13117-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13117-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 7/9] Pmalloc Rare Write: modify selected pools
To: lazytyped <lazytyped@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: keescook@chromium.org, paul@paul-moore.com, sds@tycho.nsa.gov,
 mhocko@kernel.org, corbet@lwn.net, labbott@redhat.com,
 linux-cc=david@fromorbit.com, --cc=rppt@linux.vnet.ibm.com,
 --security-module@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
 Igor Stoppa <igor.stoppa@huawei.com>,
 Carlos Chinea Perez <carlos.chinea.perez@huawei.com>,
 Remi Denis Courmont <remi.denis.courmont@huawei.com>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
 <20180423125458.5338-8-igor.stoppa@huawei.com>
 <20180424115050.GD26636@bombadil.infradead.org>
 <eb23fbd9-1b9e-8633-b0eb-241b8ad24d95@gmail.com>
 <20180424144404.GF26636@bombadil.infradead.org>
 <b1efb813-3629-518c-4eeb-7d15eb5e7319@gmail.com>
From: Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <a8ea4455-3be8-153e-0ac4-52ef27a942b4@gmail.com>
Date: Tue, 24 Apr 2018 19:29:05 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b1efb813-3629-518c-4eeb-7d15eb5e7319@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598541768538376919?=
X-GMAIL-MSGID: =?utf-8?q?1598641949674741258?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 24/04/18 19:03, lazytyped wrote:
> 
> 
> On 4/24/18 4:44 PM, Matthew Wilcox wrote:
>> On Tue, Apr 24, 2018 at 02:32:36PM +0200, lazytyped wrote:
>>> On 4/24/18 1:50 PM, Matthew Wilcox wrote:
>>>> struct modifiable_data {
>>>> 	struct immutable_data *d;
>>>> 	...
>>>> };
>>>>
>>>> Then allocate a new pool, change d and destroy the old pool.
>>> With the above, you have just shifted the target of the arbitrary write
>>> from the immutable data itself to the pointer to the immutable data, so
>>> got no security benefit.
>> There's always a pointer to the immutable data.  How do you currently
>> get to the selinux context?  file->f_security.  You can't make 'file'
>> immutable, so file->f_security is the target of the arbitrary write.
>> All you can do is make life harder, and reduce the size of the target.
> 
> So why adding an extra pointer/indirection helps here? It adds attacking
> surface.
>>
>>> The goal of the patch is to reduce the window when stuff is writeable,
>>> so that an arbitrary write is likely to hit the time when data is read-only.
>> Yes, reducing the size of the target in time as well as bytes.  This patch
>> gives attackers a great roadmap (maybe even gadget) to unprotecting
>> a pool.
> 
> I don't think this is relevant to the threat model this patch addresses.
> If the attacker can already execute code, it doesn't matter whether this
> specific piece of code exists or not. In general, if an attacker got to
> the point of using gadgets, you've lost.

Realistically, if the attacker can execute arbitrary code, through 
gadgets, there is nothing preventing a direct attack to the physical 
page, by remapping it, exactly like the patch does.
Or even changing the page table.

Wrt re-utilizing this specific rare_write() function, it would be 
possible to mark it as __always_inline, so that it will be executed only 
with the data and pool it is intended for.

Then, if one has access to a compiler plugin that does CFI, it becomes 
harder to reuse the inlined function.

Inlining should not be too bad, as size overhead.

OTOH, having the pointer always laying around at a specific address, 
allows for easier scanning - and attack - of the data

The remapping to a temporary address should make it harder to figure out 
where to write to.

Again, the whole assumption behind pmalloc is that the attacker can do 
read and writes, maybe limited execution, in the form of function calls.

But if the attacker can execute arbitrary code, all bets are off and the 
system is forfeited.

Really critical data should go into a TEE or similar isolated environment.

> On the contrary, it opens the road to design trusted paths that can
> write to or access data that would generally be read-only or not
> accessible (with, of course, all the complexity, limitations and
> penalties of doing this purely in software on a page sized basis).

I had considered the COW approach, where I would allocate a new page and 
swap it atomically, but it is not supported on ARM.

--

igor
