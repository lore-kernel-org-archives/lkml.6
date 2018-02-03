Return-Path: <kernel-hardening-return-11569-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224vQi4/IboWw5q/LuHvWtoFcDK7Q5MvAqskegYLtgRaKO71E7f+ZQvZxgG1J7MiZJcTY1vO
ARC-Seal: i=1; a=rsa-sha256; t=1517690011; cv=none;
        d=google.com; s=arc-20160816;
        b=HizlUqajdYa45Y3hrX5gj1gMLW2ccJsR/iqT4ow9FbB3jtfDlImCbkQDUautDI0b4o
         AdhqJe1u4gLR6DSWLIW5QKZmAmCfgXGUglveMt2KSgUNuWj02kRPg1ISnVEw51QAyqsw
         nUlN6GYmThJAa66+H8shnh4G/Cp7KoRh6d+V0hpg0kPKhFQBXI8iIz/vmelOwbZqveFQ
         VAzEGWgGkD9dJF7/fLL3DY5cYb6qSfabsG7QycSHXaZU5PjrHQwsd4UYWGV3OrgFdN4C
         QyfwEt0OC61jz0+FAquUSwfAaV5HTO8w6u0zL0CNl0J0ZTsd7C1KdN3cI2HsMCKd0mIy
         M5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=inS5AXAdYyf3YEa+7TnPen0jsmTDZ8FdpH3FbMAO1ms=;
        b=vLN9rKXk0Z+5eB9FiY/WbTNNkkM8tv1C/XOMfMnzGLjB7A3C+JGkgnHRABGpEhwed/
         5+Sb2/Dlf3lBepBmtwV3bsj8UTgkvSvCY8F5AWLm6pu68C1bPTjTgvQ9OA2IHKMrd8My
         RGGVgNDJvsuW17ExuvmZUsbHaS3MwWLn48+hfMOOy9it4qp/K6U2eQDSzFX2RbdiCRnS
         tzEGzuAuMvaxxwKLppo87YJqCSw+sfxDuoTJiESsOCg1f1UZtUmIHgW4MWfEjvKLc5H9
         PDMDSBLOwKxMTRVQDtogxp+wVRdqtOGiC5et9SvAaGh5U7Z/pWWMfV1gOHzw3EG+TQZO
         ZtTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11569-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11569-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11569-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11569-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [kernel-hardening] [PATCH 4/6] Protectable Memory
To: Boris Lukashev <blukashev@sempervictus.com>
CC: Christopher Lameter <cl@linux.com>, Matthew Wilcox <willy@infradead.org>,
	Jann Horn <jannh@google.com>, Jerome Glisse <jglisse@redhat.com>, Kees Cook
	<keescook@chromium.org>, Michal Hocko <mhocko@kernel.org>, Laura Abbott
	<labbott@redhat.com>, Christoph Hellwig <hch@infradead.org>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM
	<linux-mm@kvack.org>, kernel list <linux-kernel@vger.kernel.org>, "Kernel
 Hardening" <kernel-hardening@lists.openwall.com>
References: <20180124175631.22925-1-igor.stoppa@huawei.com>
 <20180124175631.22925-5-igor.stoppa@huawei.com>
 <CAG48ez0JRU8Nmn7jLBVoy6SMMrcj46R0_R30Lcyouc4R9igi-g@mail.gmail.com>
 <20180126053542.GA30189@bombadil.infradead.org>
 <alpine.DEB.2.20.1802021236510.31548@nuc-kabylake>
 <f2ddaed0-313e-8664-8a26-9d10b66ed0c5@huawei.com>
 <b75b5903-0177-8ad9-5c2b-fc63438fb5f2@huawei.com>
 <CAFUG7CfrCpcbwgf5ixMC5EZZgiVVVp1NXhDHK1UoJJcC08R2qQ@mail.gmail.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <8818bfd4-dd9f-f279-0432-69b59531bd41@huawei.com>
Date: Sat, 3 Feb 2018 22:32:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAFUG7CfrCpcbwgf5ixMC5EZZgiVVVp1NXhDHK1UoJJcC08R2qQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1591413321794377543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/02/18 22:12, Boris Lukashev wrote:

> Regarding the notion of validated protected memory, is there a method
> by which the resulting checksum could be used in a lookup
> table/function to resolve the location of the protected data?

What I have in mind is a checksum at page/vmap_area level, so there
would be no 1:1 mapping between a specific allocation and the checksum.

An extreme case would be the one where an allocation crosses one or more
page boundaries, while the checksum refers to a (partially) overlapping
memory area.

Code accessing a pool could perform one (relatively expensive)
validation. But still something that would require a more sophisticated
attack, to subvert.

> Effectively a hash table of protected allocations, with a benefit of
> dedup since any data matching the same key would be the same data
> (multiple identical cred structs being pushed around). Should leave
> the resolver address/csum in recent memory to check against, right?

I see where you are trying to land, but I do not see how it would work
without a further intermediate step.

pmalloc dishes out virtual memory addresses, when called.

It doesn't know what the user of the allocation will put in it.
The user, otoh, has the direct address of the memory it got.

What you are suggesting, if I have understood it correctly, is that,
when the pool is protected, the addresses already given out, will become
traps that get resolved through a lookup table that is built based on
the content of each allocation.

That seems to generate a lot of overhead, not to mention the fact that
it might not play very well with the MMU.

If I misunderstood, then I'd need a step by step description of what
happens, because it's not clear to me how else the data would be
accessed if not through the address that was obtained when pmalloc was
invoked.

--
igor
