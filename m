Return-Path: <kernel-hardening-return-11752-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227Yvy89LaVzm36pyUAQXxPiWHMbBvLaYuD1I7YmbkcUy4FzCjk68G+T5YrW1rNeVJdsP1O8
ARC-Seal: i=1; a=rsa-sha256; t=1518617138; cv=none;
        d=google.com; s=arc-20160816;
        b=Tlr2HJo8XT1T9GtPZuqSourS5qywq1/1b0TdNxbMOvIcSvpmyASmZkDIQgN+spb/2b
         0svoHUJam3WTkUtPZLHJZDv7NyKMC3sCV+I2gmP1UYG7wa5xhRo2r/wT9RqShQAdUPeJ
         qAwdVn1lj6AbWL6+QfamdFrRNvcNzzy6gZGnM3ThqjjA2Zk1r7eQB2ngjtH37XbzSHSD
         a4SRywdUU2hKEnVqNppKc0ut1YQbjnTu2lFv+BPWFrS1p7M/WiZjltd+ZDkSbZEGAobr
         eRAiIU4e5CRj8gOr61h1V/Ja7v21pwi+o5qZE8vLfrHd0GOgbGd1NE7S6ieBqAXf/Z/L
         Tv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=5Ud2uY0+hg4KXlJkIm0NEXX0fMzSNTrmsY/tsv5seRo=;
        b=s15TaLM+sqzys+T35wcMA6O96AQcxdxdBptzLkFaKj+hy7s0cRDWRvTrqtk7iU1vgZ
         SqCSZMX1yxsu7rUbJJeqUN6y10vjLThivsVVX1MU1T0wQ9MQFabVBxkEunioblmcc6YC
         4J4B76t85joTHVSxQQnf0bF5CLf6WgKqgWRN1Ws8MlDc9Q4vScrx4sAItvQraiv7wRe+
         VsvY+6FtKevvKZ2dPtMtmRx9gR9oNoqoKIKTFETbMdLz/D6RCGsAApHvMii7XsbrRuuh
         +WjLPciDQW3G1kcOLjlKz0A2KsRcvYyhsFcHddN8X4Q6MPWXDueYSZz6yoAoBFlEnCDQ
         niTA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@shutemov-name.20150623.gappssmtp.com header.s=20150623 header.b=deUtoxs9;
       spf=pass (google.com: domain of kernel-hardening-return-11752-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11752-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@shutemov-name.20150623.gappssmtp.com header.s=20150623 header.b=deUtoxs9;
       spf=pass (google.com: domain of kernel-hardening-return-11752-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11752-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Feb 2018 17:05:17 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Matthew Wilcox <willy@infradead.org>
Cc: Daniel Micay <danielmicay@gmail.com>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC] Limit mappings to ten per page per process
Message-ID: <20180214140517.ipgxvskdy7bwl7up@node.shutemov.name>
References: <CAG48ez2-MTJ2YrS5fPZi19RY6P_6NWuK1U5CcQpJ25=xrGSy_A@mail.gmail.com>
 <CA+DvKQLHDR0s=6r4uiHL8kw2_PnfJcwYfPxgQOmuLbc=5k39+g@mail.gmail.com>
 <20180208185648.GB9524@bombadil.infradead.org>
 <CA+DvKQLHcFc3+kW_SnD6hs53yyD5Zi+uAeSgDMm1tRzxqy-Opg@mail.gmail.com>
 <20180208194235.GA3424@bombadil.infradead.org>
 <CA+DvKQKba0iU+tydbmGkAJsxCxazORDnuoe32sy-2nggyagUxQ@mail.gmail.com>
 <20180208202100.GB3424@bombadil.infradead.org>
 <20180208213743.GC3424@bombadil.infradead.org>
 <20180209042609.wi6zho24wmmdkg6i@node.shutemov.name>
 <20180214135141.GA16215@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214135141.GA16215@bombadil.infradead.org>
User-Agent: NeoMutt/20171215
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591870366530801102?=
X-GMAIL-MSGID: =?utf-8?q?1592385484081510792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 05:51:41AM -0800, Matthew Wilcox wrote:
> On Fri, Feb 09, 2018 at 07:26:09AM +0300, Kirill A. Shutemov wrote:
> > On Thu, Feb 08, 2018 at 01:37:43PM -0800, Matthew Wilcox wrote:
> > > On Thu, Feb 08, 2018 at 12:21:00PM -0800, Matthew Wilcox wrote:
> > > > Now that I think about it, though, perhaps the simplest solution is not
> > > > to worry about checking whether _mapcount has saturated, and instead when
> > > > adding a new mmap, check whether this task already has it mapped 10 times.
> > > > If so, refuse the mapping.
> > > 
> > > That turns out to be quite easy.  Comments on this approach?
> > 
> > This *may* break some remap_file_pages() users.
> 
> We have some?!  ;-)

I can't prove otherwise :)

> I don't understand the use case where they want to map the same page of
> a file multiple times into the same process.  I mean, yes, of course,
> they might ask for it, but I don't understand why they would.  Do you
> have any insight here?

Some form of data deduplication? Like having repeating chunks stored once
on presistent storage and page cache, but put into memory in
"uncompressed" form.

It's not limited to remap_file_pages(). Plain mmap() can be used for this
too.

-- 
 Kirill A. Shutemov
