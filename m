Return-Path: <kernel-hardening-return-11764-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x22567UmxQHoU4rF5bC02sxdefOPJm6MxTNm6EORwR4RXnF2NJrTwfpDQHxPvG92eKC3qdXQ+
ARC-Seal: i=1; a=rsa-sha256; t=1518636939; cv=none;
        d=google.com; s=arc-20160816;
        b=IvefsESuYaqJCpq7TQssrd8sIkCd5wzUqloNF3EXVsU7IFntO1IioeVFr1a+dMU3tx
         0SsE8txs+bLdoafOOLFpCrB68K9LJsSaqCD/+/kXPYKtVCM/X1N8255/EzUFhN/aS62m
         8nBnf6ZiWGKy83TD0UA25OYloBGJa0/zB07bBofh+FR5L07DgL8OBTxDVGrRsFQWAP96
         /rm6uSD7Hfymd4JZsfVdToXiFSzG2Oa6udAFtZsOROMWK3Fj0/aRxebfqjHiW+lrQFeE
         TI076m6Rgui+9qTAZTckghlchND9l3iCe5KV3cExbvcpkuvW2FOTd9Iw2T5SgcypSHu8
         M6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=Ab31J7iLVde64gVrGKq4u2hv8mkLA7+w+gQzHabctEo=;
        b=EFD9XQ7IIIILT7lsQ21AcdlDuzmIa+404yfW4FiZSnt6Q6PC509lf48SN00mxsO4CI
         O0ID7IR6l0dHjHB0YMLDMZNm2o1jKQbHrSvVQH0+1xWSzMwdkCm67fPzUbofhhq5zPPe
         g/O16C39rsStvjqiGwwCjPDIYpf0Kema+yyua10MXQ4XVpxOmF46r+Zw75RgKjeSEoPt
         hrrNNZQgoB0fWKDK/A7UTxEUvBd5dn/ECrVYHPJxOhF9lAhkjGkCGV8UauoPWSyJIVPR
         4yIiNv1xIAFd6jZy21XFhNlKS18ggxkUQ8OkDMuduQMz/bziDj6rqqUZV0QT8lFdUGbM
         WPcg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=sC1qk+e5;
       spf=pass (google.com: domain of kernel-hardening-return-11764-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11764-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=sC1qk+e5;
       spf=pass (google.com: domain of kernel-hardening-return-11764-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11764-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Feb 2018 11:35:17 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr
Subject: Re: [PATCH 2/2] mm: Add kvmalloc_ab_c and kvzalloc_struct
Message-ID: <20180214193517.GA20627@bombadil.infradead.org>
References: <20180214182618.14627-1-willy@infradead.org>
 <20180214182618.14627-3-willy@infradead.org>
 <CAGXu5jL9hqQGe672CmvFwqNbtTr=qu7WRwHuS4Vy7o5sX_UTgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jL9hqQGe672CmvFwqNbtTr=qu7WRwHuS4Vy7o5sX_UTgg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401933337716102?=
X-GMAIL-MSGID: =?utf-8?q?1592406247291500335?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 11:22:38AM -0800, Kees Cook wrote:
> > +/**
> > + * kvmalloc_ab_c() - Allocate memory.
> 
> Longer description, maybe? "Allocate a *b + c bytes of memory"?

Done!

> > + * @n: Number of elements.
> > + * @size: Size of each element (should be constant).
> > + * @c: Size of header (should be constant).
> 
> If these should be constant, should we mark them as "const"? Or WARN
> if __builtin_constant_p() isn't true?

It's only less efficient if they're not const.  Theoretically they could be
variable ... and I've been bitten by __builtin_constant_p() recently
(gcc bug 83653 which I still don't really understand).

> > + * @gfp: Memory allocation flags.
> > + *
> > + * Use this function to allocate @n * @size + @c bytes of memory.  This
> > + * function is safe to use when @n is controlled from userspace; it will
> > + * return %NULL if the required amount of memory cannot be allocated.
> > + * Use kvfree() to free the allocated memory.
> > + *
> > + * The kvzalloc_hdr_arr() function is easier to use as it has typechecking
> 
> renaming typo? Should this be "kvzalloc_struct()"?

Urgh, yes.  I swear I searched for it ... must've typoed my search string.
Anyway, fixed, because kvzalloc_hdr_arr() wasn't a good name.

> > +#define kvzalloc_ab_c(a, b, c, gfp)    kvmalloc_ab_c(a, b, c, gfp | __GFP_ZERO)
> 
> Nit: "(gfp) | __GFP_ZERO" just in case of insane usage.

Fixed!

> It might be nice to include another patch that replaces some of the
> existing/common uses of a*b+c with the new function...

Sure!  I have a few examples in my tree, I just didn't want to complicate
things by sending a patch that crossed dozens of maintainer trees.
