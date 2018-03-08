Return-Path: <kernel-hardening-return-12278-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtqRtMf0KVFflHlydGfUzfRJmTVX4rUXETo1ASc6S+oQwUlkCNypQUkXc3L570FvBvbFgD3
ARC-Seal: i=1; a=rsa-sha256; t=1520550338; cv=none;
        d=google.com; s=arc-20160816;
        b=gO40DxOyU9gb4hThlWps6dsAocfzu6VRIYfI5OYGkWJCcI+HUaeUvmGsgSGMjrc60/
         mf3N8aFWLJV8AYyAGt8IBQxrNcsmB77foWDONR07oLOhM3Atc8hZqTJITX3JYcNnpVEY
         +8MeVum2h7C7+xe8WWxUNBuaYl6OD6F1eEZhQZ3d+B+p009oG2qCBP5x15DiCLbgYy0G
         DY4fMbXFWTG7Hf2EgniHmOfHy61xe7RrNhd7zhQbsSLX5qIVz3g4KcZFxRvwzhVxcO7k
         4dnu5esbyCfopcQdATc9yos8M/HdxTne8u/sjQMwv7mD4HmUoo5vElodK/p16F38MaQF
         ksCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=Jzk2woI9SrMYOmC+29JDfdZqyq3lUAVirx3W1fi8uWk=;
        b=RffRaqdXYs08YCdFfNxBqeWdu0GEgX3J+rDB+G3LKmpxix7NAIhPGuyBTaUaAFms9j
         3VelsDEcHyn79Qm7JfKA1U7SRQBvlheTUT4NqBFJeBziDQe98tCByN34DmV3nlsN4Ozl
         6cwbHRO5PPEvAFWH/kfp0RXLazk9RwOuDpBBU6bp8i3J6f89ZAZ6B6whvSyx5UwelCQf
         N0qrKQuiSdtsL9DnPO+76Ic5zhElhwGXskIQcbDodKjYKt7LYgy1WdQMx3dtQKNPkmtR
         Nmbt7jUXAb4++CYgJlK0ccmxRQd+XRZd7wcwodPXnm/PkpKqU6GtwpF0O6INcT9un9ob
         T2Bw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=iHzFsqA6;
       spf=pass (google.com: domain of kernel-hardening-return-12278-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12278-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=iHzFsqA6;
       spf=pass (google.com: domain of kernel-hardening-return-12278-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12278-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Mar 2018 15:05:12 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	cocci@systeme.lip6.fr, Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 2/2] mm: Add kvmalloc_ab_c and kvzalloc_struct
Message-ID: <20180308230512.GD29073@bombadil.infradead.org>
References: <20180214182618.14627-1-willy@infradead.org>
 <20180214182618.14627-3-willy@infradead.org>
 <CAGXu5jL9hqQGe672CmvFwqNbtTr=qu7WRwHuS4Vy7o5sX_UTgg@mail.gmail.com>
 <alpine.DEB.2.20.1803072212160.2814@hadrien>
 <20180308025812.GA9082@bombadil.infradead.org>
 <alpine.DEB.2.20.1803080722300.3754@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1803080722300.3754@hadrien>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401933337716102?=
X-GMAIL-MSGID: =?utf-8?q?1594412591629646504?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 07:24:47AM +0100, Julia Lawall wrote:
> On Wed, 7 Mar 2018, Matthew Wilcox wrote:
> > On Wed, Mar 07, 2018 at 10:18:21PM +0100, Julia Lawall wrote:
> > > > Otherwise, yes, please. We could build a coccinelle rule for
> > > > additional replacements...
> > >
> > > A potential semantic patch and the changes it generates are attached
> > > below.  Himanshu Jha helped with its development.  Working on this
> > > uncovered one bug, where the allocated array is too large, because the
> > > size provided for it was a structure size, but actually only pointers to
> > > that structure were to be stored in it.
> >
> > This is cool!  Thanks for doing the coccinelle patch!  Diffstat:
> >
> >  50 files changed, 81 insertions(+), 124 deletions(-)
> >
> > I find that pretty compelling.  I'll repost the kvmalloc_struct patch
> > imminently.
> 
> Thanks.  So it's OK to replace kmalloc and kzalloc, even though they
> didn't previously consider vmalloc and even though kmalloc doesn't zero?

We'll also need to replace the corresponding places where those structs
are freed with kvfree().  Can coccinelle handle that too?

> There are a few other cases that use GFP_NOFS and GFP_NOWAIT, but I didn't
> transform those because the comment says that the flags should be
> GFP_KERNEL based.  Should those be transformed too?

The problem with non-GFP_KERNEL allocations is that vmalloc may have to
allocate page tables, which is always done with an implicit GFP_KERNEL
allocation.  There's an intent to get rid of GFP_NOFS, but that's not
been realised yet (and I'm not sure of our strategy to eliminate it ...
I'll send a separate email about that).  I'm not sure why anything's
trying to allocate with GFP_NOWAIT; can you send a list of those places?
