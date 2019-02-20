Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC2CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF2520855
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kerrnel.com header.i=@kerrnel.com header.b="gN7Cci8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfBTTLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:11:16 -0500
Received: from ch14b.valcato.com ([216.104.44.82]:42236 "EHLO
        ch14b.valcato.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBTTLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:11:16 -0500
X-Greylist: delayed 2232 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Feb 2019 14:11:16 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kerrnel.com
        ; s=default; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MNpG+7NE9CEwZpRcZsJF4M7fn6beDt1lJ2hBws3hS4o=; b=gN7Cci8hHQYlI6NRwdHowWerLo
        +nC5t7Yfp68KJtJS9uh0GxuKe1WbwND5zTkID17JM1oW/e5RP0E9KBl3XCQzpUxAdM2BF7IlbXdyY
        0TPRRTglAV9T6erX9M2GmrWoHCSAW7M4KiUL0Wet0vMHnSODF1xZGBaOW9zYCYnNPQHNEK7ipMQKZ
        V/KyT1s2Okp/xO8ZkXt2Ag8Zgxx6LO57cN3G9dT9mM48OpDFUT6W3v/0et4vHaj58wLAuUDMMUX0c
        r9dPVWk0xlhbfquj6Xvsa1rGGtyNaAhLaJd71tqPf26y81Rk3FJdu1v32RP3cBUZ1WGoW46hjjOnW
        mutgr0Nw==;
Received: from [104.132.11.80] (port=62947 helo=kerrnel.com)
        by ch14b.valcato.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <greg@kerrnel.com>)
        id 1gwWgv-00Gmi2-Qn; Wed, 20 Feb 2019 18:33:58 +0000
Date:   Wed, 20 Feb 2019 10:33:55 -0800
From:   Greg Kerr <greg@kerrnel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg Kerr <kerrnel@google.com>, mingo@kernel.org,
        tglx@linutronix.de, Paul Turner <pjt@google.com>,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
Message-ID: <20190220183355.GA213003@kerrnel.com>
References: <20190218165620.383905466@infradead.org>
 <CAJGSLMt_X97Ux=1YiZcXWXvBy4n=ExO=2yAJhfbvxDh+wnWPvQ@mail.gmail.com>
 <20190220094255.GE32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220094255.GE32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ch14b.valcato.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kerrnel.com
X-Get-Message-Sender-Via: ch14b.valcato.com: authenticated_id: greg@kerrnel.com
X-Authenticated-Sender: ch14b.valcato.com: greg@kerrnel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:42:55AM +0100, Peter Zijlstra wrote:
> 
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
> 
I am relieved to know that when my mail client embeds HTML tags into raw
text, it will only be the second most annoying thing I've done on
e-mail.

Speaking of annoying things to do, sorry for switching e-mail addresses
but this is easier to do from my personal e-mail.

> On Tue, Feb 19, 2019 at 02:07:01PM -0800, Greg Kerr wrote:
> > Thanks for posting this patchset Peter. Based on the patch titled, "sched: A
> > quick and dirty cgroup tagging interface," I believe cgroups are used to
> > define co-scheduling groups in this implementation.
> > 
> > Chrome OS engineers (kerrnel@google.com, mpdenton@google.com, and
> > palmer@google.com) are considering an interface that is usable by unprivileged
> > userspace apps. cgroups are a global resource that require privileged access.
> > Have you considered an interface that is akin to namespaces? Consider the
> > following strawperson API proposal (I understand prctl() is generally
> > used for process
> > specific actions, so we aren't married to using prctl()):
> 
> I don't think we're anywhere near the point where I care about
> interfaces with this stuff.
> 
> Interfaces are a trivial but tedious matter once the rest works to
> satisfaction.
> 
I agree that the API itself is a bit of a bike shedding and that's why I
provided a strawperson proposal to highlight the desired properties. I
do think the high level semantics are important to agree upon.

Using cgroups could imply that a privileged user is meant to create and
track all the core scheduling groups. It sounds like you picked cgroups
out of ease of prototyping and not the specific behavior?

> As it happens; there is actually a bug in that very cgroup patch that
> can cause undesired scheduling. Try spotting and fixing that.
> 
This is where I think the high level properties of core scheduling are
relevant. I'm not sure what bug is in the existing patch, but it's hard
for me to tell if the existing code behaves correctly without answering
questions, such as, "Should processes from two separate parents be
allowed to co-execute?"

> Another question is if we want to be L1TF complete (and how strict) or
> not, and if so, build the missing pieces (for instance we currently
> don't kick siblings on IRQ/trap/exception entry -- and yes that's nasty
> and horrible code and missing for that reason).
>
I assumed from the beginning that this should be safe across exceptions.
Is there a mitigating reason that it shouldn't?

> 
> So first; does this provide what we need? If that's sorted we can
> bike-shed on uapi/abi.
I agree on not bike shedding about the API, but can we agree on some of
the high level properties? For example, who generates the core
scheduling ids, what properties about them are enforced, etc.?

Regards,

Greg Kerr
