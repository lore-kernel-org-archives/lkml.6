Return-Path: <kernel-hardening-return-11743-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224gCxBlUAX1B5q/4Om5Ou2yDvXRN64pq3RaNr9pBKSfXi5NXhae3HY0tVZWVwdAkC0q/zoi
ARC-Seal: i=1; a=rsa-sha256; t=1518493218; cv=none;
        d=google.com; s=arc-20160816;
        b=sX9mQhShpcTjH5NXrfMtkjthBVuctkUvoW3ZsgkL3mc0gg00rURwA59iX+rycx9c+e
         ty9wDAS0omEbZfABxQnLiDz76+3PtavyppE3ePJJa3Gl8cMLdNxDB12tka5vEg0RXy11
         nUSXtElWq1fG/ORiOUnoHsyafzCNQMjmcVGJmzagFc4OCwCNdDlH9vd/XJEB8HgrrNH7
         HCV7BoXH5Dg8Zg/SwQHWi8s5AB1er0/K9FjWiheWFC4sJplOLd865sXdChlEZu++8vmw
         3DH5uuCO8lveVta8YPrPzZfnaxy9zYJjD/lG9MHXmllPoPXmhxHiPuxy1VhTR5iIP2kd
         2jng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=RPx+ERycomcx9uhafJCpNVwWw+q8GP39Z3VnY5DYFgQ=;
        b=TIAXRkbfdJ3nvwRzyAGFXIpEQ/Cx9Bu7ywwJZK1+B8NUFN3cBpdjDAH5oslcjjzYgP
         Fp/KMQiveypsIOAeI5pj7A9ZiaRY5DPYmI80IfmWGaIchXSsH8yHvDEwt5q6uYIs9Py0
         3lMgc0EuEdsswXETzjwz+mBWCZXqfDcwBNajnYg/bAGGxDOvtWWmgFSQbD/8e3wz2ngq
         Y8y7uQiO7NK7vo4JN2Mr2kbeb8a3Tfa1WgIO2tuXZXcSwuT9jONCyblof4rcTo9ANaCW
         hbiqEc+IPAROiv5uS2f/v8aOXbhaWQNhyYHuAoXOOzfxsghJvdGwEuQIfMYMZ7ZF6koM
         79SA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=sfXRynr0;
       spf=pass (google.com: domain of kernel-hardening-return-11743-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11743-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=sfXRynr0;
       spf=pass (google.com: domain of kernel-hardening-return-11743-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11743-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <CAGXu5j++igQD4tMh0J8nZ9jNji5mU16C7OygFJ5Td+Bq-KSMgw@mail.gmail.com>
References: <20180124175631.22925-1-igor.stoppa@huawei.com>
 <20180124175631.22925-5-igor.stoppa@huawei.com> <CAG48ez0JRU8Nmn7jLBVoy6SMMrcj46R0_R30Lcyouc4R9igi-g@mail.gmail.com>
 <20180126053542.GA30189@bombadil.infradead.org> <alpine.DEB.2.20.1802021236510.31548@nuc-kabylake>
 <f2ddaed0-313e-8664-8a26-9d10b66ed0c5@huawei.com> <b75b5903-0177-8ad9-5c2b-fc63438fb5f2@huawei.com>
 <CAFUG7CfrCpcbwgf5ixMC5EZZgiVVVp1NXhDHK1UoJJcC08R2qQ@mail.gmail.com>
 <8818bfd4-dd9f-f279-0432-69b59531bd41@huawei.com> <CAFUG7CeUhFcvA82uZ2ZH1j_6PM=aBo4XmYDN85pf8G0gPU44dg@mail.gmail.com>
 <17e5b515-84c8-dca2-1695-cdf819834ea2@huawei.com> <CAGXu5j+LS1pgOOroi7Yxp2nh=DwtTnU3p-NZa6bQu_wkvvVkwg@mail.gmail.com>
 <414027d3-dd73-cf11-dc2a-e8c124591646@redhat.com> <CAGXu5j++igQD4tMh0J8nZ9jNji5mU16C7OygFJ5Td+Bq-KSMgw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 13 Feb 2018 04:39:38 +0100
Message-ID: <CAG48ez1utN_vwHUwk=BU6zM4Wa_53TPu8rm9JuTtY-vGP0Shqw@mail.gmail.com>
Subject: Re: [kernel-hardening] [PATCH 4/6] Protectable Memory
To: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <labbott@redhat.com>, Igor Stoppa <igor.stoppa@huawei.com>,
	Boris Lukashev <blukashev@sempervictus.com>, Christopher Lameter <cl@linux.com>,
	Matthew Wilcox <willy@infradead.org>, Jerome Glisse <jglisse@redhat.com>,
	Michal Hocko <mhocko@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1592255544993403790?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 2:25 AM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Feb 12, 2018 at 4:40 PM, Laura Abbott <labbott@redhat.com> wrote:
>> On 02/12/2018 03:27 PM, Kees Cook wrote:
>>>
>>> On Sun, Feb 4, 2018 at 7:05 AM, Igor Stoppa <igor.stoppa@huawei.com>
>>> wrote:
>>>>
>>>> On 04/02/18 00:29, Boris Lukashev wrote:
>>>>>
>>>>> On Sat, Feb 3, 2018 at 3:32 PM, Igor Stoppa <igor.stoppa@huawei.com>
>>>>> wrote:
>>>>
>>>>
>>>> [...]
>>>>
>>>>>> What you are suggesting, if I have understood it correctly, is that,
>>>>>> when the pool is protected, the addresses already given out, will
>>>>>> become
>>>>>> traps that get resolved through a lookup table that is built based on
>>>>>> the content of each allocation.
>>>>>>
>>>>>> That seems to generate a lot of overhead, not to mention the fact that
>>>>>> it might not play very well with the MMU.
>>>>>
>>>>>
>>>>> That is effectively what i'm suggesting - as a form of protection for
>>>>> consumers against direct reads of data which may have been corrupted
>>>>> by some irrelevant means. In the context of pmalloc, it would probably
>>>>> be a separate type of ro+verified pool
>>>>
>>>> ok, that seems more like an extension though.
>>>>
>>>> ATM I am having problems gaining traction to get even the basic merged
>>>> :-)
>>>>
>>>> I would consider this as a possibility for future work, unless it is
>>>> said that it's necessary for pmalloc to be accepted ...
>>>
>>>
>>> I would agree: let's get basic functionality in first. Both
>>> verification and the physmap part can be done separately, IMO.
>>
>>
>> Skipping over physmap leaves a pretty big area of exposure that could
>> be difficult to solve later. I appreciate this might block basic
>> functionality but I don't think we should just gloss over it without
>> at least some idea of what we would do.
>
> What's our exposure on physmap for other regions? e.g. things that are
> executable, or made read-only later (like __ro_after_init)?

I just checked on a system with a 4.9 kernel, and there seems to be no
physical memory that is mapped as writable in the init PGD and
executable elsewhere.

Ah, I think I missed something. At least on X86, set_memory_ro,
set_memory_rw, set_memory_nx and set_memory_x all use
change_page_attr_clear/change_page_attr_set, which use
change_page_attr_set_clr, which calls __change_page_attr_set_clr()
with a second parameter "checkalias" that is set to 1 unless the bit
being changed is the NX bit, and that parameter causes the invocation
of cpa_process_alias(), which will, for mapped ranges, also change the
attributes of physmap ranges. set_memory_ro() and so on are also used
by the module loading code.

But in the ARM64 code, I don't see anything similar. Does anyone with
a better understanding of ARM64 want to check whether I missed
something? Or maybe, with a recent kernel, check whether executable
module pages show up with a second writable mapping in the
"kernel_page_tables" file in debugfs?
