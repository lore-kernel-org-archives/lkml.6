Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9157C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37CF206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A0gLzy9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfAIWrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:47:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46402 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbfAIWrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g/Qw7ZmXNSasK/SUcOq5J7QB659xYt9kfAFxlkrc9TY=; b=A0gLzy9W0sF3/0sdzVsZ5TTQG
        jOHwLpi46u7hR6uhw8jxEmJ3iEdyFSx0Jhxkvo96qWbHV4oLVWRA6cHOYIWm0/aoVKqujcSKybc4+
        7TwWPMpIP33eXlWJ+/skN7ZyioW3ECTMdq5VA4ZnmcJge1bqNJWx3epVbn/hMYKmhCQrheJvxSgHT
        k5bvPchIYBuZNmnEl1cLxK4wJTppoimVVLVg04aWWfYZNWQjUDsGK5p+i5oUZdXLGaXitU1UyU0Qm
        66OnQnKBKWb4xx84IpW/zWc8bLw9hSllBVLyTa0GTloxQjQvBAQU/A/mKhcO6/BlV62dcF3srUAnu
        4so/yEDew==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghMdF-000806-Jc; Wed, 09 Jan 2019 22:47:29 +0000
Date:   Wed, 9 Jan 2019 14:47:29 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Collingbourne <pcc@google.com>, rsmith@google.com
Subject: Re: [RFC] Use plan9 C extensions
Message-ID: <20190109224729.GS6310@bombadil.infradead.org>
References: <20190109203119.GR6310@bombadil.infradead.org>
 <CAKwvOdns4358_UgKgBPGzMfXoFLDijv13wFnv5UP=G_zjZbcwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdns4358_UgKgBPGzMfXoFLDijv13wFnv5UP=G_zjZbcwA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 02:07:11PM -0800, Nick Desaulniers wrote:
> On Wed, Jan 9, 2019 at 12:31 PM Matthew Wilcox <willy@infradead.org> wrote:
> > For cyclic allocations, we need to keep a 'next' value somewhere.
> > The IDR had a moderately large root, so they didn't mind the cost to
> > all users of embedding the next value in the root.
> 
> This sounds like some kind of "intrusive data structure?"  Doesn't the
> kernel have macro's for generic intrusive containers?  Would you be
> adding similar macros for xarray (or is that irrelevant to your
> question)?

I think that's irrelevant ...

> Sorry, this doesn't look quite syntactically valid, so I'm having a
> hard time following along.  Would you be able to show me a simple
> reproducer in godbolt (https://godbolt.org/) with GCC what you're
> trying to do (maybe with comments showing before/after)?  (Godbolt is
> a godsend for developers to clearly communicate codegen issues with
> compiler vendors, and its short links can easily be embedded in bug
> reports and commit messages).

Sure!  https://godbolt.org/z/OfHOLI is an example of a client of the API
I want to create.

> > (ie one fewer argument, as well as one fewer thing to track in their struct).
> 
> The difference in the second case from the first looks like the "one
> fewer argument" is the address of another member of `nn`.  In general
> cases of trying to minimize the number of parameters passed, rather
> than pass 2 pointers to 2 members, I would curious if you could just
> pass 1 pointer to parent struct (ie. `nn`) to `xa_foo()` and friends
> and pull out the members there?

Not really; nn is going to be a per-client type, ie hundreds of different
structs.  The struct xarray gets embedded in it.

> > That's what -fplan9-extensions would allow us to do.  Without it,
> > we'd need to name that struct xarray and need extra syntactic sugar;
> > eg later when it calls xa_erase(), it'd look like this:
> >
> >         xa_erase(&nn->s2s_cp_stateids, copy->cp_stateid.si_opaque.so_id);
> >
> > instead of:
> >
> >         xa_erase(&nn->s2s_cp_stateids.xa, copy->cp_stateid.si_opaque.so_id);
> 
> Also hard to spot the intended difference as there's no `xa` member in
> any of your examples (I assume you meant `xarray`, but a godbolt link
> would be appreciated to make sure I'm understanding the problem
> correctly).

Right, what I'm trying to communicate there is that if we need to name
the xarray, we then have to name it everywhere that we use it.

> Thanks for including us (LLVM folks)!  It would be good that new
> additions be made optional if possible if unsupported in Clang; but
> that's not doable in this case.  From the documentation, it seems that
> `-fplan9-extensions` enables a couple of things, and I think with a
> clearer example of what you're trying to do, I would be better
> equipped to comment on which part of the compiler flag you'd like to
> make use of.

I hope the example makes things clearer!
