Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BAFECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95062081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CwfXroiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95062081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeJaGbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:31:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32986 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeJaGbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aUavaxogKH403XKXRPnEVNz6RyBC+eD5hHVDUeLt+mY=; b=CwfXroiGl1iorCuN3F1tA9J1q
        DmMej9IeRdtCWzJcrG/znrrZpyrLbDOk53lsMNEfWiA63Uq9/ZeeN2Cu/xjfU4mmH/LaDvJcdYbax
        A3SIweSwoNRH5EbjUIZKqeiQ7ZYH/ZCBah5Jz5ppBhcd9EsDLaxWE4QGGm2ZXhD/ZycXZnSxehbYZ
        qVoGadHOYiLfYG1MDVQcVjNeMNQIq8UWJOrb0Nviai2/AG2zrGVxCuIPlqNy+yZnJnzWYPlEmbtmn
        YiX6eUCXcAQz2rSQYfvlcI/LOYJLDyL1q9knQS/hVljf6eM+cAmWl7Jm95obQtZ7/YDKW4WO5lsB0
        AHnRlXlkg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHbg5-0004UL-KK; Tue, 30 Oct 2018 21:35:57 +0000
Date:   Tue, 30 Oct 2018 14:35:57 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20181030213557.GE10491@bombadil.infradead.org>
References: <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org>
 <20181030182841.GE7343@cisco>
 <20181030192021.GC10491@bombadil.infradead.org>
 <9edbdf8b-b5fb-5a82-43b4-b639f5ec8484@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9edbdf8b-b5fb-5a82-43b4-b639f5ec8484@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:43:14PM +0200, Igor Stoppa wrote:
> On 30/10/2018 21:20, Matthew Wilcox wrote:
> > > > So the API might look something like this:
> > > > 
> > > > 	void *p = rare_alloc(...);	/* writable pointer */
> > > > 	p->a = x;
> > > > 	q = rare_protect(p);		/* read-only pointer */
> 
> With pools and memory allocated from vmap_areas, I was able to say
> 
> protect(pool)
> 
> and that would do a swipe on all the pages currently in use.
> In the SELinux policyDB, for example, one doesn't really want to
> individually protect each allocation.
> 
> The loading phase happens usually at boot, when the system can be assumed to
> be sane (one might even preload a bare-bone set of rules from initramfs and
> then replace it later on, with the full blown set).
> 
> There is no need to process each of these tens of thousands allocations and
> initialization as write-rare.
> 
> Would it be possible to do the same here?

What Andy is proposing effectively puts all rare allocations into
one pool.  Although I suppose it could be generalised to multiple pools
... one mm_struct per pool.  Andy, what do you think to doing that?

> > but we'd probably wrap it in list_for_each_rare_entry(), just to be nicer.
> 
> This seems suspiciously close to the duplication of kernel interfaces that I
> was roasted for :-)

Can you not see the difference between adding one syntactic sugar function
and duplicating the entire infrastructure?
