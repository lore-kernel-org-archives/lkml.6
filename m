Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E697EECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFFC2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XOqqvlIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFFC2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeJaUbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 16:31:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbeJaUbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 16:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1Nx7BO2VnRh0a+k2wp2hDZfug8S8paE2B6A9HLC6QA8=; b=XOqqvlIVZO/TCdFsj9fzYAmfN
        vtDeI48fJxQqPNLDNNW2FRQ59jRc0YgoyWc9OZk1adej3fYHmt+6SSNPQMTL73MRRLd51foZ5ngyr
        mOrh1B6t1BAsAiyCg0xWZmKqF4Hgxwpr47JkvcOMd4rzIL/Q1J3OXgFO9Ypv3J3pITxZN52VnBJHM
        9NTbMJHfSSrqWKf77P0SreElImwrKXths6lRkk/dsgFD2hqCOjfWr14YpuxIuDsVbloZVtzBCVKFO
        FtwS1T7Tjfk3GwYpJGdLK1FynxfapKnEjRAkPuiE++hznb2wbpm7Ld7C8FaltPVcev3oq2gMlFkXh
        Xk3OM+keA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHokB-0006ej-FS; Wed, 31 Oct 2018 11:33:03 +0000
Date:   Wed, 31 Oct 2018 04:33:03 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Igor Stoppa <igor.stoppa@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 10/17] prmem: documentation
Message-ID: <20181031113303.GJ10491@bombadil.infradead.org>
References: <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org>
 <20181031093659.GL744@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031093659.GL744@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 10:36:59AM +0100, Peter Zijlstra wrote:
> On Tue, Oct 30, 2018 at 10:58:14AM -0700, Matthew Wilcox wrote:
> > On Tue, Oct 30, 2018 at 10:06:51AM -0700, Andy Lutomirski wrote:
> > > > On Oct 30, 2018, at 9:37 AM, Kees Cook <keescook@chromium.org> wrote:
> > > I support the addition of a rare-write mechanism to the upstream kernel.
> > > And I think that there is only one sane way to implement it: using an
> > > mm_struct. That mm_struct, just like any sane mm_struct, should only
> > > differ from init_mm in that it has extra mappings in the *user* region.
> > 
> > I'd like to understand this approach a little better.  In a syscall path,
> > we run with the user task's mm.  What you're proposing is that when we
> > want to modify rare data, we switch to rare_mm which contains a
> > writable mapping to all the kernel data which is rare-write.
> > 
> > So the API might look something like this:
> > 
> > 	void *p = rare_alloc(...);	/* writable pointer */
> > 	p->a = x;
> > 	q = rare_protect(p);		/* read-only pointer */
> > 
> > To subsequently modify q,
> > 
> > 	p = rare_modify(q);
> > 	q->a = y;
> > 	rare_protect(p);
> 
> Why would you have rare_alloc() imply rare_modify() ? Would you have the
> allocator meta data inside the rare section?

Normally when I allocate some memory I need to initialise it before
doing anything else with it ;-)

I mean, you could do:

	ro = rare_alloc(..);
	rare = rare_modify(ro);
	rare->a = x;
	rare_protect(rare);

but that's more typing.
