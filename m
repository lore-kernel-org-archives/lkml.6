Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAC4ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B195E205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kzi+2D/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B195E205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeJaSQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:16:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34784 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeJaSQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fVhXZWXj81sT/c2mZE0H4mJ1k8z+LPDjNU9EBM9zVvU=; b=kzi+2D/uyQhcVvTbEufaP92gn
        nyDe5p2eDCiO4FJ1nv9mXiBFr4+Vhifg605AxkPfkblc1H1mSQoK8vMeruUP3pWZLoFjCdV2D5r3C
        6Z/4WYmD74tckX8XvozBI0epdKJ27Tg1xvCKwI4iEE61plq+4eJf27iO8jL13jAt9IEPEw1ZxbBpo
        KtPV3DmNlIHr8ZzdiYrXjL1GwYHfUUalZEV2bpe/59qZx/IV4gr6XuvQyTWvWRB6eyZVIYjolcQwq
        33QzbBQh58hAxV5a/L2T8iLrfKE31Vqabllhz9w0kI8SVNmuNLKamKfs21WjbcyJP7y7dYRyApjHi
        jVfTTfo/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHmeS-0002R2-PK; Wed, 31 Oct 2018 09:19:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A63A2029FA14; Wed, 31 Oct 2018 10:18:59 +0100 (CET)
Date:   Wed, 31 Oct 2018 10:18:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
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
Message-ID: <20181031091859.GI744@hirez.programming.kicks-ass.net>
References: <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org>
 <d5b57049-419b-3bbb-dc8d-97e4024965df@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5b57049-419b-3bbb-dc8d-97e4024965df@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 11:03:51AM -0700, Dave Hansen wrote:
> On 10/30/18 10:58 AM, Matthew Wilcox wrote:
> > Does this satisfy Igor's requirements?  We wouldn't be able to
> > copy_to/from_user() while rare_mm was active.  I think that's a feature
> > though!  It certainly satisfies my interests (kernel code be able to
> > mark things as dynamically-allocated-and-read-only-after-initialisation)
> 
> It has to be more than copy_to/from_user(), though, I think.
> 
> rare_modify(q) either has to preempt_disable(), or we need to teach the
> context-switching code when and how to switch in/out of the rare_mm.
> preempt_disable() would also keep us from sleeping.

Yes, I think we want to have preempt disable at the very least. We could
indeed make the context switch code smart and teach is about this state,
but I think allowing preemption in such section is a bad idea. We want
to keep these sections short and simple (and bounded), such that they
can be analyzed for correctness.

Once you allow preemption, things tend to grow large and complex.

Ideally we'd even disabled interrupts over this, to further limit what
code runs in the rare_mm context. NMIs need special care anyway.
