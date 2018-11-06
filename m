Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CA3C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD1B2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ijqSKrCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD1B2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388877AbeKGAMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:12:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33644 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388680AbeKGAMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=726HoIo0OJu6z4i7zTm49rjonxc9Pk+jeJ6exzzSC+M=; b=ijqSKrCKJfZnqW8srLXOKu/sr
        SvUKfh/I29+g7SdKOJRoIYGHxwUb4Lgc1XckzBWhHB54Y9yTttFs333cDqbJ6h5D8HuK+prcEW1kU
        2w20yuSQQVpXjmbVUZZ6qbAZDkhfIoizW+/u4wdd+VlPzy8IQrHoOYxZ4Z2RtdB1KKUSv7DRQU2X6
        U2H6zlI/goKSoFBZixirUgWgnRUxtql7fP4GIbqGI3MbesdgUc2tNfMxylCIctab6zGWMbHox5KwP
        XhrL67cWKD/IZWjwACVNnsgpwd3dyvCDgkKW6Tq9uRRE4SyCvgS/gVYym/S2waOterLeU7KuWiy0J
        kbXwTajHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gK2cb-0007MZ-73; Tue, 06 Nov 2018 14:46:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8CF2A20284F94; Tue,  6 Nov 2018 15:46:19 +0100 (CET)
Date:   Tue, 6 Nov 2018 15:46:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, namit@vmware.com,
        Joe Perches <joe@perches.com>, segher@kernel.crashing.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH] tree-wide: Remove __inline__ and __inline usage
Message-ID: <20181106144619.GB9781@hirez.programming.kicks-ass.net>
References: <20181106100229.GI22431@hirez.programming.kicks-ass.net>
 <CANiq72=VUEvPJf_U8s+FJbdj7pbEpsxepFaduUoW7Ov_arnRGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=VUEvPJf_U8s+FJbdj7pbEpsxepFaduUoW7Ov_arnRGA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 03:09:37PM +0100, Miguel Ojeda wrote:
> On Tue, Nov 6, 2018 at 11:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > allows adding the "inline" keyword to 'asm ("")' statements. The
> > problem is that we're possibly redefining "inline" to
> > "inline __attribute__((__always_inline__))" which makes the proposed:
> >
> >   asm volatile inline ("")
> >
> > (...)
> >
> > -#define inline inline
> > -#define inline   inline
> > -
> 
> It seems somehow your patch got underscores removed.

If you actually read what I wrote:

> > Therefore I'm proposing to run:
> > 
> >   git grep -l "\<__inline\(\|__\)\>" | while read file
> >   do
> > 	sed -i -e 's/\<__inline\(\|__\)\>/inline/g' $file
> >   done
> > 
> > On your current tree, and apply the below fixup patch on top of that
> > result.

It makes sense.

> By the way, we have been re#defining the inline keyword since (at
> least) 2003, and already in 2008 Ingo was commenting in a commit to
> add the #ifdef to avoid it for x86. Is it still a good idea nowadays
> that the minimum compiler is quite modern compare to a decade ago? Is
> it still needed on non-x86 arches (they don't have it in the
> defconfig)? Couldn't functions be marked as __always_inline if really
> needed (as many are)?
> 
> By the way (x2): CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING is only ever
> referenced in that #ifdef. May it be removed?

Dunno, but that is a far more difficult patch. The proposed one is an
obvious identify.
