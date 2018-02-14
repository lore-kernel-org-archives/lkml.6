Return-Path: <kernel-hardening-return-11795-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226hyJB+j51W/oMaSlmqqft0TewgxgTmWEgXtiJUzEB/yiiY13sofmOOs+r05nzT7QVdhTyK
ARC-Seal: i=1; a=rsa-sha256; t=1518646429; cv=none;
        d=google.com; s=arc-20160816;
        b=fccrpAxg8MBZcpcUfiFmnCFX2B/geCX7joxR8yZNeSFhMzQq4Aq9SYnlPU1TT23B3W
         dK/Tr2e8BADkW+r4yCO280ep7so9nFyFVfk4GLAxi9TeLhngROS6HXpWX0k7ky7D1T0g
         6ftddsPZSt0OcaHvAl062HIsh5BAFycrccq2mJiFu2eaU0v0QKXJ4D2ml9S9vbsqdPiQ
         UUBV1RkirKBr5vqjdg8eSD6uzV/7caPrPSSc/36N8kqvh8ncMyMRf/xua2TAdz4axX7u
         RalxiTOmdx9vdiPOwZ9EtbT/F+no+CNk816WHzC9lf19Veg1DUB9q8kDzhmgiYRHx9V9
         OYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=1I5emYBdMczpmvIvlKtYj1XMEMflhndJ0aLrBKYk+N8=;
        b=S1v+0EPs7oUbJCbmIf1GGbF8CCn84dj9jxNQXu/sqoTVvG4mXg5Pi3rf+ZitzqzM4l
         SXzYKfRigNuJ2AXaBIxJRApnDVqpNlWnT9E44z4ovdIjQ35l8qa5KqZWhKj9+UWX/RRN
         zLZD/cG+BxFBdBWFgY6LEMa4qHmvDSvchRMoxHyLDO9OZyY+rqQpyBxSQchToQNZED/u
         EGQn1nLJSe8VQWZhMjPzAwvnmR4L7aY6swnrkLBYgeY0YyHZrSj7GaloWTWTdyUG5i3M
         dAWLfgHRL2/mR5yruVyQEeEP2lF7zpE+22jb7J/oJs3u2dUsr2a7Yz6LpG9PRnVtGfpo
         izJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=BVh2o/MN;
       spf=pass (google.com: domain of kernel-hardening-return-11795-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11795-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=BVh2o/MN;
       spf=pass (google.com: domain of kernel-hardening-return-11795-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11795-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Feb 2018 15:13:28 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <labbott@redhat.com>, Jann Horn <jannh@google.com>,
	Igor Stoppa <igor.stoppa@huawei.com>,
	Boris Lukashev <blukashev@sempervictus.com>,
	Christopher Lameter <cl@linux.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jerome Glisse <jglisse@redhat.com>,
	Michal Hocko <mhocko@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: arm64 physmap (was Re: [kernel-hardening] [PATCH 4/6]
 Protectable Memory)
Message-ID: <20180214221328.glbrdib3wumve53z@cisco>
References: <CAFUG7CeUhFcvA82uZ2ZH1j_6PM=aBo4XmYDN85pf8G0gPU44dg@mail.gmail.com>
 <17e5b515-84c8-dca2-1695-cdf819834ea2@huawei.com>
 <CAGXu5j+LS1pgOOroi7Yxp2nh=DwtTnU3p-NZa6bQu_wkvvVkwg@mail.gmail.com>
 <414027d3-dd73-cf11-dc2a-e8c124591646@redhat.com>
 <CAGXu5j++igQD4tMh0J8nZ9jNji5mU16C7OygFJ5Td+Bq-KSMgw@mail.gmail.com>
 <CAG48ez1utN_vwHUwk=BU6zM4Wa_53TPu8rm9JuTtY-vGP0Shqw@mail.gmail.com>
 <f4226a44-92fd-8ead-b458-7551ba82f96d@redhat.com>
 <CAGXu5j+zOCLerneUt2b-tvyLLg7fEbr9B0YYow-4DH6oV-nnCw@mail.gmail.com>
 <2f23544a-bd24-1e71-967b-e8d1cf5a20a3@redhat.com>
 <CAGXu5j+zkFx+1Dn908iqaTV-yP7Wk_rMXZRvXN32h+i_oAcy6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+zkFx+1Dn908iqaTV-yP7Wk_rMXZRvXN32h+i_oAcy6w@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592404410626838547?=
X-GMAIL-MSGID: =?utf-8?q?1592416198825543505?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 11:48:38AM -0800, Kees Cook wrote:
> On Wed, Feb 14, 2018 at 11:06 AM, Laura Abbott <labbott@redhat.com> wrote:
> > fixed. Modules yes are not fully protected. The conclusion from past
> > experience has been that we cannot safely break down larger page sizes
> > at runtime like x86 does. We could theoretically
> > add support for fixing up the alias if PAGE_POISONING is enabled but
> > I don't know who would actually use that in production. Performance
> > is very poor at that point.
> 
> XPFO forces 4K pages on the physmap[1] for similar reasons. I have no
> doubt about performance changes, but I'd be curious to see real
> numbers. Did anyone do benchmarks on just the huge/4K change? (Without
> also the XPFO overhead?)
> 
> If this, XPFO, and PAGE_POISONING all need it, I think we have to
> start a closer investigation. :)

I haven't but it shouldn't be too hard. What benchmarks are you
thinking?

Tycho
