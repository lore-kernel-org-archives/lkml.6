Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE406ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FCD206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="Lr70/La+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FCD206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeKIFXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:23:36 -0500
Received: from imap.thunk.org ([74.207.234.97]:55884 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbeKIFXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pMCmL51QKjvHYr1OrQ+ihql4mYxq5wNFBsRiZzLuGzY=; b=Lr70/La+OaA3ptDDAITuX7xBS0
        zu+gBrDxs0RwF1+W7p86/K4upG/TORM1rpolraCFihaTQlWK5oY4xdyhWLP7Ye62a/x4xbWtqu6CR
        fofQDeBn6am6o4jvgwAyQxEOW+kkr/64MVLMjyoYacj5Oo9m29y4zIIX09B+A4dhLL58=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gKqFr-0000dV-Al; Thu, 08 Nov 2018 19:46:15 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3C7AA7A7D24; Thu,  8 Nov 2018 14:46:14 -0500 (EST)
Date:   Thu, 8 Nov 2018 14:46:14 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        john.stultz@linaro.org, acme@redhat.com, frederic@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>, daniel.lezcano@linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [patch 0/2] Documentation/process: Add subsystem/tree handbook
Message-ID: <20181108194614.GA4105@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>,
        john.stultz@linaro.org, acme@redhat.com, frederic@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>, daniel.lezcano@linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>
References: <20181107171010.421878737@linutronix.de>
 <20181107124855.328133e7@lwn.net>
 <CAPcyv4goT+7t1foOhEYgGTz2kRV2Oou8QOs38D13rdC-TpfX+Q@mail.gmail.com>
 <alpine.DEB.2.21.1811072134060.1666@nanos.tec.linutronix.de>
 <20181108074920.4c601ee3@lwn.net>
 <20181108150517.GV9761@hirez.programming.kicks-ass.net>
 <20181108162133.GC1080@thunk.org>
 <20181108093347.61dd6cf3@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108093347.61dd6cf3@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 09:33:47AM -0700, Jonathan Corbet wrote:
> 
> > I thought there was a slot already scheduled on the refereed track,
> > "Towards a Linux Kernel Mainainer Handbook" (Tuesday at 4:45pm) for
> > this purpose?
> 
> My expectation is that this will be an actual talk; it seemed rude to
> assume that Dan had penciled in a block of time for open arguments about
> the tip-tree handbook :)  That said, I'm not feeling a groundswell of
> support for scheduling another session at this point...

Agreed, my apologies to Dan for making that presumption.  My reasoning
for suggesting that his session might be a good one is that many of
the things which are listed as "tip-tree quirks" are things which I
suspect we are discovering are actually things that should go into the
Maintainer Handbook.

I don't know how much time Dan was planning on presenting versus
having a discussion.  If there is a lot of discussion that gets kicked
up, that's why we have TBD/Unconference slots.  (And yes, there may be
conflicts; sorry about that.  On the other hand, better that people
are frustrated that there are too many high quality sessions they want
to attend, as opposed to twiddling their fingers and saying, "well
*this* afternoon is a complete waste of my time."  :-)

I suspect the main places where there will be divergencies between
different trees might be in how individual subsystems weigh various
recommendations when they come into conflict with each other.  We've
seen that already with checkpatch.pl, where in fact the choices about
"lines > 80 characters always BAD BAD BAD" versus "continuation
strings in printk EVEN WORSE" have flipped over time (and so now we
have cleanup patches being submitted which undo the work of different
cleanup patches years earlier :-).  And I have no doubt that this will
be true for things that might go into tree-specific quirks versus
Maintainer Handbook.

In fact, what might make sense is for Maintainer Handbook to have the
general recommendations, and then maybe tree-specific quirks document
might simply say that in terms of the Frobozz tree weighs the
suggestions of guideline Foo over guideline Quux, where as the
Frobnozz tree has a the opposite weighting.

Cheers,

						- Ted
