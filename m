Return-Path: <kernel-hardening-return-12510-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvSYY6FlA9Mo9Lc7LqgXh7GysqJ4aR5x7QXWNFdpP5lZDrLKURNQ4FrPndbsxKt1eq8Q32+
ARC-Seal: i=1; a=rsa-sha256; t=1520961614; cv=none;
        d=google.com; s=arc-20160816;
        b=HlJRpcRO6CdztYQclGIXzIZuGocNEzSXcXEiXMePyt9JRXUXr6qg4h6mha66aOadJq
         rYH+W2Y1HtDYSa/ELCo30dCjOw1fX/9oY5RGYwgVI8K8XAlr5p7MDHDvTz1Upckf3/u/
         AsyQE1QnpZDmWsU+zaf7tO4MOfAhPxoyARbnMXignfSDFKAzuBF6i3k1NOBYFee8BZpG
         OW+8ikbKmZtwPh5Y96FViBfHs2KMOHFmiJt5ERFtdtEP/LUD9Sln09DWQEPwgjFbpdWu
         b1JAgiJH4FOAmxz4cRIXKFO68vfpw42o3wg7yBGRQl6rQB4hKSJA/mwhT73i7TrlH+wp
         6NvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=O4WQIHzJCABpX66bp0kYm/q6o6J6W+S68WBAXqR2MbA=;
        b=AgeYcRzQ6VVGSCyKSrG4XKkL+Gk9JnXTad0uRWX9dZyp2aYt9/ioi6T/ww4/paS6SW
         AspfARJ0R/92ZN9s4fpc9cPHDHvjkm/ScaMqXCmG072SgAczf4aOpT8SRo/pTpwFua56
         qOByfJP9kRRfzumV3c478uCydxVlzzX2uphxCrRU6+0TJ3+uvnq8LCIE8mN+5un643C/
         YhEfZqPR+SGwYZp/m+MrPZ9ODZAgydozl4sIMYUcE31LmnD9rLswq7RO++jqlx2u5cO8
         EoL5XRk9pCJcKd16DcYnexlROiX5kEbXhPmPEzgaKHLaZjPlKt3/tRRLMjsNv/8IBouE
         C/4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12510-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12510-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12510-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12510-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-IronPort-AV: E=Sophos;i="5.47,465,1515452400";
   d="scan'208";a="258178898"
Date: Tue, 13 Mar 2018 18:19:51 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Matthew Wilcox <willy@infradead.org>
cc: Julia Lawall <julia.lawall@lip6.fr>, Kees Cook <keescook@chromium.org>,
    Andrew Morton <akpm@linux-foundation.org>,
    Matthew Wilcox <mawilcox@microsoft.com>, Linux-MM <linux-mm@kvack.org>,
    LKML <linux-kernel@vger.kernel.org>,
    Kernel Hardening <kernel-hardening@lists.openwall.com>,
    cocci@systeme.lip6.fr, Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 2/2] mm: Add kvmalloc_ab_c and kvzalloc_struct
In-Reply-To: <20180308230512.GD29073@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1803131818550.3117@hadrien>
References: <20180214182618.14627-1-willy@infradead.org> <20180214182618.14627-3-willy@infradead.org> <CAGXu5jL9hqQGe672CmvFwqNbtTr=qu7WRwHuS4Vy7o5sX_UTgg@mail.gmail.com> <alpine.DEB.2.20.1803072212160.2814@hadrien> <20180308025812.GA9082@bombadil.infradead.org>
 <alpine.DEB.2.20.1803080722300.3754@hadrien> <20180308230512.GD29073@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401933337716102?=
X-GMAIL-MSGID: =?utf-8?q?1594843845882742485?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Thu, 8 Mar 2018, Matthew Wilcox wrote:

> On Thu, Mar 08, 2018 at 07:24:47AM +0100, Julia Lawall wrote:
> > On Wed, 7 Mar 2018, Matthew Wilcox wrote:
> > > On Wed, Mar 07, 2018 at 10:18:21PM +0100, Julia Lawall wrote:
> > > > > Otherwise, yes, please. We could build a coccinelle rule for
> > > > > additional replacements...
> > > >
> > > > A potential semantic patch and the changes it generates are attached
> > > > below.  Himanshu Jha helped with its development.  Working on this
> > > > uncovered one bug, where the allocated array is too large, because the
> > > > size provided for it was a structure size, but actually only pointers to
> > > > that structure were to be stored in it.
> > >
> > > This is cool!  Thanks for doing the coccinelle patch!  Diffstat:
> > >
> > >  50 files changed, 81 insertions(+), 124 deletions(-)
> > >
> > > I find that pretty compelling.  I'll repost the kvmalloc_struct patch
> > > imminently.
> >
> > Thanks.  So it's OK to replace kmalloc and kzalloc, even though they
> > didn't previously consider vmalloc and even though kmalloc doesn't zero?
>
> We'll also need to replace the corresponding places where those structs
> are freed with kvfree().  Can coccinelle handle that too?

Is the use of vmalloc a necessary part of the design?  Or could there be a
non vmalloc versions for call sites that are already ok with that?

julia

> > There are a few other cases that use GFP_NOFS and GFP_NOWAIT, but I didn't
> > transform those because the comment says that the flags should be
> > GFP_KERNEL based.  Should those be transformed too?
>
> The problem with non-GFP_KERNEL allocations is that vmalloc may have to
> allocate page tables, which is always done with an implicit GFP_KERNEL
> allocation.  There's an intent to get rid of GFP_NOFS, but that's not
> been realised yet (and I'm not sure of our strategy to eliminate it ...
> I'll send a separate email about that).  I'm not sure why anything's
> trying to allocate with GFP_NOWAIT; can you send a list of those places?
>
