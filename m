Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386D2C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B2E213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="bK2j54ky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B2E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbeJDLyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 07:54:11 -0400
Received: from imap.thunk.org ([74.207.234.97]:46658 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbeJDLyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 07:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cO1ZGjSxRkU5bvF6UV1o6VWMRXtZRep6usj9qhICr8g=; b=bK2j54kyica/sC5POhYHkMu2RT
        y3T9gaqZ5gX8HcK31afQ6xeLgfxzOkjjT/Wb37nIB8O4DHa3PAuWYZmtovgv05Zb8UscW2TEQewh3
        WY2j0S2hFx6WkyAYg3iT7bRdAFd6YkPLMs/48klXbptkEJ6Cf1gd0f8x4d0VxFsw/wUM=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g7vld-0004jF-93; Thu, 04 Oct 2018 05:01:41 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7A4F07A51B1; Thu,  4 Oct 2018 01:01:40 -0400 (EDT)
Date:   Thu, 4 Oct 2018 01:01:40 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL linux-next] Add Compiler Attributes tree
Message-ID: <20181004050140.GC646@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <CANiq72=rgT9cPWH64Tf_8gAU09EiH5FvGqFUdOjV=spVbM5m8Q@mail.gmail.com>
 <20181003071059.02b3fd6f@canb.auug.org.au>
 <CAKwvOdmt4-jFv6d-ZVUH5OOvXSz38jpuNvQy-jtoSS3xEoh78A@mail.gmail.com>
 <CANiq72mmxiO6RWBTQfWYDaa6gmOF01nXmN6BJNCAjAFz3QJqqA@mail.gmail.com>
 <20181002232454.GB2483@thunk.org>
 <CANiq72=cRpqnB3BxLsmj-rMdUGJK+pac1SRppoRgsON69ErfQg@mail.gmail.com>
 <20181003153303.GC2835@thunk.org>
 <CANiq72=Jq8HZ1=CsSvV4GenG+F6z3vRFmiB7Joct5VKdUFo8pA@mail.gmail.com>
 <CANiq72nMu6NXg1Ovn49qJ=FP_S4_LQJSwPuS+Q_zofhOEbVZng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72nMu6NXg1Ovn49qJ=FP_S4_LQJSwPuS+Q_zofhOEbVZng@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 11:41:08PM +0200, Miguel Ojeda wrote:
> 
> I forgot to mention that if the definitions were different, it could
> have caused a problem, because your definition wouldn't apply, so your
> 27+ hours of testing wouldn't have mattered :-P Without the #ifndef,
> we would have at least got a redefinition warning about it.

In this case, yes.  Again, I emphasize that I was using the ext4.h
cleanup as an *example*.  The point I was trying to make was that your
change did *not* do a full set of deep ext4 regression tests because
the your change didn't go through the ext4.git tree.  I have seen
cases where "simple mechanical changes" were anything but, and while
the kernel *compiled* it resulted in the file system not working.
(And in the worst case, it resulted actual data loss or file system
corruption.)

My test scripts are public, and in fact I've gone out of my way to
make them easy for other people to run them, with documentation[1][2],
slide sets[3], etc.  But the vast majority of people who submit
patches to ext4.git don't bother --- and as far as I know *no one* who
sends ext4 changes via other git trees *ever* bothered.  (And, for one
recent patchset where the ext4 developer spent a lot of time using
kvm-xfstests before submission, accepting that set of changes was easy
and was a joy.  I'm a big believe in tests.)

[1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/gce-xfstests.md
[2] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
[3] https://thunk.org/gce-xfstests

As far as what you want to do, there are solutions, but they require a
radically different way of developing.  For example, inside Google,
for the non-public sources (e.g., excluding Android, Chrome OS, etc.)
there is a single source tree, with thousands of projects.  They use
common set of C++ utility libraries/classes, and there is a
standardized build system (bazel[4]), and a standardized way of
writing tests.  More importantly, there is a fully automated
continuous testing system which will automatically trigger and run the
appropriate tests --- at the moment when the patch is submitted into
the Google's custom code review system --- and the results of the test
are automatically submitted as comments in the code review system, so
the automated testing is integrated into the code review.  For changes
that affected all or substantially all projects, it's possible to run
tests across the entire source tree using automated, centralized
resources, and even then it can take a significantlly non-trivial (as
in days) of calendar time running on many systems in parallel.

[4] https://bazel.build/

So if you are willing to completely standardize your testing
infrastructure and devote utterly lavish amounts of automated testing
which is deeply integrated into a standardized, non-email code review
system, the challenge you have identified *has* been solved.  But
trust me when I say that it is a very non-trivial thing to do, and it
requires a lot of very strict code development practices that are
imposed on all Google C++ developers working in the common tree (which
is probably 90%+ of the SWE's inside Google).  I'm not at all
convinced that it could be adopted or imposed on the kernel
development process.  In fact, I'm quite confident it could not be.

I actually think the Linux Kernel's approach of carefully segregating
how code and headers to avoid merge conflicts (and worse, semantic
conflicts that may git merge and build succesfully, but then blow up
in subtle ways leading to user data loss) is actually a pretty good
way of doing things.  It works 99.99% of the the commits.  True, it
wasn't optimal for the changes you were trying to make; but your
experience is the exception, not the rule.

The risk here is that it's very easy to engineer changes in processes
for corner cases, and which make things much worse (either taking more
time, or more effort, or being less reliable) for the common case.

Cheers,

					- Ted

