Return-Path: <kernel-hardening-return-11796-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225T+2KXGz6GStcsynkdg851hsQFA6C9T5l+oi3wSa+MEumNyPlEmO6YAn03OdjQZCBvetkj
ARC-Seal: i=1; a=rsa-sha256; t=1518647294; cv=none;
        d=google.com; s=arc-20160816;
        b=zNAZExnE+gfzoB4KOIx2b89c8CKmoP6cfSY9jLh0i55sKIa/8B64ZUOy3TtcsM1yb4
         2rUGmP02Y9a08CvmAatRDV6FpBUzvlIkGJtaU+2miUu3kVpk80s0IvhjhOKGJCEZaRnR
         9Heza2TpYBevc8Th2faC12HLYH3GPIypEHws3ULwOfvjFD0nlgmA7VKmQxiPPILAGDKy
         bSV00aLgxIWrvb8s89mwbJUOXz212tMdMo1pydMoS2EdJU0StjGXc0cmLKsgVzf393rj
         AC/IJ/nnf4OEHGWOnxjtGrMkO/2L2I0VR9li5ibmBVcyf5QYeD+y2uYd/fJXzE5P7mps
         R4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=7bBT0aZfqnZ89JzDqlI4Yvru5lcdAyFMJibsEYAktAo=;
        b=BpYVGJFpIZvHKi0oPjpWwRXgNjc/tRC6quVkFW2lZhyvNEFdvpLF2EnU44UpPDVyOc
         VueNTjJHCCHLOOBEuq3nz6q/lVmhJ3nEHb2EzYazgiDbOOq3+jWubeNtycRwduQs1biD
         pdIImmYqlWNM7ctuewyQy8oL4NOuA7wHK8yfbd4RNXMKztDjw9CgKwe1nIlVChJkplHj
         fBY/8qiix7aGAVikIud2Y50r1sycN3QYrUnLuoI09xjWdK9P5qGjjSuKFlT1VWd294kk
         KiHDkaPLsiZsAJ9KkEwHpWBkCCgIs9lB17y3geOLjTsxLaGNQSzgAi5aMNWJUFHIljge
         hM5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SklH+isN;
       dkim=pass header.i=@chromium.org header.s=google header.b=nMrM+gcr;
       spf=pass (google.com: domain of kernel-hardening-return-11796-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11796-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SklH+isN;
       dkim=pass header.i=@chromium.org header.s=google header.b=nMrM+gcr;
       spf=pass (google.com: domain of kernel-hardening-return-11796-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11796-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180214221328.glbrdib3wumve53z@cisco>
References: <CAFUG7CeUhFcvA82uZ2ZH1j_6PM=aBo4XmYDN85pf8G0gPU44dg@mail.gmail.com>
 <17e5b515-84c8-dca2-1695-cdf819834ea2@huawei.com> <CAGXu5j+LS1pgOOroi7Yxp2nh=DwtTnU3p-NZa6bQu_wkvvVkwg@mail.gmail.com>
 <414027d3-dd73-cf11-dc2a-e8c124591646@redhat.com> <CAGXu5j++igQD4tMh0J8nZ9jNji5mU16C7OygFJ5Td+Bq-KSMgw@mail.gmail.com>
 <CAG48ez1utN_vwHUwk=BU6zM4Wa_53TPu8rm9JuTtY-vGP0Shqw@mail.gmail.com>
 <f4226a44-92fd-8ead-b458-7551ba82f96d@redhat.com> <CAGXu5j+zOCLerneUt2b-tvyLLg7fEbr9B0YYow-4DH6oV-nnCw@mail.gmail.com>
 <2f23544a-bd24-1e71-967b-e8d1cf5a20a3@redhat.com> <CAGXu5j+zkFx+1Dn908iqaTV-yP7Wk_rMXZRvXN32h+i_oAcy6w@mail.gmail.com>
 <20180214221328.glbrdib3wumve53z@cisco>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 14 Feb 2018 14:27:47 -0800
X-Google-Sender-Auth: I0GRJYtRLQnEI4q9b8tJXhKA-Rg
Message-ID: <CAGXu5jK1taW5JccCTdi6EzfD7RNnFrRyoJQMtLLi5CwT-8eJkQ@mail.gmail.com>
Subject: Re: arm64 physmap (was Re: [kernel-hardening] [PATCH 4/6] Protectable Memory)
To: Tycho Andersen <tycho@tycho.ws>
Cc: Laura Abbott <labbott@redhat.com>, Jann Horn <jannh@google.com>,
	Igor Stoppa <igor.stoppa@huawei.com>, Boris Lukashev <blukashev@sempervictus.com>,
	Christopher Lameter <cl@linux.com>, Matthew Wilcox <willy@infradead.org>, Jerome Glisse <jglisse@redhat.com>,
	Michal Hocko <mhocko@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592404410626838547?=
X-GMAIL-MSGID: =?utf-8?q?1592417105482529954?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 2:13 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> On Wed, Feb 14, 2018 at 11:48:38AM -0800, Kees Cook wrote:
>> On Wed, Feb 14, 2018 at 11:06 AM, Laura Abbott <labbott@redhat.com> wrote:
>> > fixed. Modules yes are not fully protected. The conclusion from past
>> > experience has been that we cannot safely break down larger page sizes
>> > at runtime like x86 does. We could theoretically
>> > add support for fixing up the alias if PAGE_POISONING is enabled but
>> > I don't know who would actually use that in production. Performance
>> > is very poor at that point.
>>
>> XPFO forces 4K pages on the physmap[1] for similar reasons. I have no
>> doubt about performance changes, but I'd be curious to see real
>> numbers. Did anyone do benchmarks on just the huge/4K change? (Without
>> also the XPFO overhead?)
>>
>> If this, XPFO, and PAGE_POISONING all need it, I think we have to
>> start a closer investigation. :)
>
> I haven't but it shouldn't be too hard. What benchmarks are you
> thinking?

Unless I'm looking at some specific micro benchmark, I tend to default
to looking at kernel build benchmarks but that gets pretty noisy.
Laura regularly uses hackbench, IIRC. I'm not finding the pastebin I
had for that, though.

I wonder if we need a benchmark subdirectory in tools/testing/, so we
could collect some of these common tools? All benchmarks are terrible,
but at least we'd have the same terrible benchmarks. :)

-Kees

-- 
Kees Cook
Pixel Security
