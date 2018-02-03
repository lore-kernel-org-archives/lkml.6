Return-Path: <kernel-hardening-return-11570-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224UFxOIkvB1bwE4CLPY+lMOHY6+FxVJnP2VXuylxHX9P+UghqOCaJCmWUhJwUwUgDTRIVip
ARC-Seal: i=1; a=rsa-sha256; t=1517696982; cv=none;
        d=google.com; s=arc-20160816;
        b=hJxfsrFIiveKyaIK9cyycPVSTyLk4U0GynYvKasHlGXR17M9SLfp8OHhBKqahKV+mR
         Dskisk8J49LbSjyzoKlYcdIc9q4qvLc9OuLF8YWsKwi88x/p4AapcJLydvxDEv0zW3Ej
         wdNlfr3obdSDSCvnm7mFtPeSwXIMotg2pxbGjSNN3WIU8jwYne4Q2aJY/vZKS/8+P0/N
         X0cxLdy0tOjiXzGy9QiAnCT6Z4yua0VeBSBchEa4TCZyTzyGrdXr2wP4TU7aCkiqYnkQ
         wv+kbVOxV0KOEDcZ/ENsdBZn4BGR23+sZxx2uhByZ/tdnUP7Xk15giXMhy9SJNETnWvd
         9L9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=6J8v415C7nTPDnExxrfpjJ8XR+eMQTEeMTtBlS/b44I=;
        b=BwSFgAoJdxYkwrpLNQT8BKZzv1C6niQFNKxe8UgVbu0o+x/WgjH4Z6gvbMtDQOmurv
         DFdCI+H8igbU+pCWQLBxR20uFf2h31IYDQdE8Fy4w1kKJjUQLpRWY9NX5LrZO1lZE5Ku
         9p1fEzIMMAM+Iil0GALCBaWo9+R7oRxM+20BdSIwsCWv+HgENx4LNalnQIrdnDryiWPR
         0SLzFjOF51UdOTB6hq4WVCgJvmFqDrHlzPNqt7SLFx/5Y0146IO69pKnWbqTYcEJxi58
         8w62TsjkZ4Wd0Yf2oRM22mjT6k1n6CW80h0CvKVEQ/nm73Z3EvJ+0g4PtQfTLPudw6dK
         sl5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sempervictus-com.20150623.gappssmtp.com header.s=20150623 header.b=REwY8Rf3;
       spf=pass (google.com: domain of kernel-hardening-return-11570-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11570-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sempervictus-com.20150623.gappssmtp.com header.s=20150623 header.b=REwY8Rf3;
       spf=pass (google.com: domain of kernel-hardening-return-11570-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11570-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
X-Originating-IP: [72.70.61.204]
In-Reply-To: <8818bfd4-dd9f-f279-0432-69b59531bd41@huawei.com>
References: <20180124175631.22925-1-igor.stoppa@huawei.com>
 <20180124175631.22925-5-igor.stoppa@huawei.com> <CAG48ez0JRU8Nmn7jLBVoy6SMMrcj46R0_R30Lcyouc4R9igi-g@mail.gmail.com>
 <20180126053542.GA30189@bombadil.infradead.org> <alpine.DEB.2.20.1802021236510.31548@nuc-kabylake>
 <f2ddaed0-313e-8664-8a26-9d10b66ed0c5@huawei.com> <b75b5903-0177-8ad9-5c2b-fc63438fb5f2@huawei.com>
 <CAFUG7CfrCpcbwgf5ixMC5EZZgiVVVp1NXhDHK1UoJJcC08R2qQ@mail.gmail.com> <8818bfd4-dd9f-f279-0432-69b59531bd41@huawei.com>
From: Boris Lukashev <blukashev@sempervictus.com>
Date: Sat, 3 Feb 2018 17:29:22 -0500
Message-ID: <CAFUG7CeUhFcvA82uZ2ZH1j_6PM=aBo4XmYDN85pf8G0gPU44dg@mail.gmail.com>
Subject: Re: [kernel-hardening] [PATCH 4/6] Protectable Memory
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Christopher Lameter <cl@linux.com>, Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>,
	Jerome Glisse <jglisse@redhat.com>, Kees Cook <keescook@chromium.org>,
	Michal Hocko <mhocko@kernel.org>, Laura Abbott <labbott@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1591420631588807091?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 3, 2018 at 3:32 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>
>
> On 03/02/18 22:12, Boris Lukashev wrote:
>
>> Regarding the notion of validated protected memory, is there a method
>> by which the resulting checksum could be used in a lookup
>> table/function to resolve the location of the protected data?
>
> What I have in mind is a checksum at page/vmap_area level, so there
> would be no 1:1 mapping between a specific allocation and the checksum.
>
> An extreme case would be the one where an allocation crosses one or more
> page boundaries, while the checksum refers to a (partially) overlapping
> memory area.
>
> Code accessing a pool could perform one (relatively expensive)
> validation. But still something that would require a more sophisticated
> attack, to subvert.
>
>> Effectively a hash table of protected allocations, with a benefit of
>> dedup since any data matching the same key would be the same data
>> (multiple identical cred structs being pushed around). Should leave
>> the resolver address/csum in recent memory to check against, right?
>
> I see where you are trying to land, but I do not see how it would work
> without a further intermediate step.
>
> pmalloc dishes out virtual memory addresses, when called.
>
> It doesn't know what the user of the allocation will put in it.
> The user, otoh, has the direct address of the memory it got.
>
> What you are suggesting, if I have understood it correctly, is that,
> when the pool is protected, the addresses already given out, will become
> traps that get resolved through a lookup table that is built based on
> the content of each allocation.
>
> That seems to generate a lot of overhead, not to mention the fact that
> it might not play very well with the MMU.

That is effectively what i'm suggesting - as a form of protection for
consumers against direct reads of data which may have been corrupted
by some irrelevant means. In the context of pmalloc, it would probably
be a separate type of ro+verified pool which consumers would
explicitly opt into. Say there's a maintenance cycle on a <name some
scary thing controlled by Linux> and it wants to make sure that the
instructions it read in are what they should have been before running
them, those consumers might well take the penalty if it keeps <said
scary big thing> from doing <the thing we're scared of it doing>.
If such a resolver could be implemented in a manner which doesnt break
all the things (including acceptable performance for at least a
significant number of workloads), it might be useful as a general tool
for handing out memory to userspace, even in rw, as it provides
execution context in which other requirements can be forcibly
resolved, preventing unauthorized access to pages the consumer
shouldn't get in a very generic way. Spectre comes to mind as a
potential class of issues to be addressed this way, since speculative
load could be prevented if the resolution were to fail.

>
> If I misunderstood, then I'd need a step by step description of what
> happens, because it's not clear to me how else the data would be
> accessed if not through the address that was obtained when pmalloc was
> invoked.
>
> --
> igor



-- 
Boris Lukashev
Systems Architect
Semper Victus
