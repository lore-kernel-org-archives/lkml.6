Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F13C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690F720878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="LXE/K1XF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690F720878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeJCGLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 02:11:42 -0400
Received: from imap.thunk.org ([74.207.234.97]:48222 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725724AbeJCGLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 02:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=t6Nj3tOXaCalTYPbdK5Vd/1HsNLBCQAbMp0xxwDDHxI=; b=LXE/K1XFvQSohP3wAfgTc26dsU
        7XUnWpdet4SvTKD954MHcZgqMjwmdGBIUwqGAWOiCuuWSETQpZlzZiu4rss0hJVuNJw6G7rD9AUb/
        FycQpvL0UEHQndsuwzaFNP5itIP4V4Fl2OM+wMpmzPIWgXO3e6B+36ON93GacljErXfk=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g7U2A-0001CS-Ui; Tue, 02 Oct 2018 23:24:54 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 366767A5186; Tue,  2 Oct 2018 19:24:54 -0400 (EDT)
Date:   Tue, 2 Oct 2018 19:24:54 -0400
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
Message-ID: <20181002232454.GB2483@thunk.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mmxiO6RWBTQfWYDaa6gmOF01nXmN6BJNCAjAFz3QJqqA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 12:12:10AM +0200, Miguel Ojeda wrote:
> As I have read, -next is supposed to be a vision of what the merge
> window will look like after merging everything, i.e. ideally -rc1. For
> that to work for files out-of-tree (like these ones, which are not
> maintained by a single tree), changes should be allowed to be stacked
> on each other; otherwise, we cannot handle conflicts :-(

In general, best practice is to base tree on an -rcX commit.  I
usually will use something like -rc4 which is after most of the major
changes have gone in.  This tends to reduce conflicts for most git
trees.

There are times when a commit in one tree needs to depend on a commit
in another tree.  What to do depends on the circumstances.

One solution is to base one subsystem's git tree on another
subsystem's git tree --- *if* that git tree is one that doesn't get
rebase.  You'll need to talk to the subsystem maintainer to find out
whether or not that's the case.  But that's actually not a great
solution, because what can happen is if the tree A is based on tree B,
and there is something in tree B which Linus objects to, tree B won't
get pulled.  And since tree A depends on tree B, Linus will refuse to
pull tree A as well.  We recently had a case where a subsystem pull
got delayed by a full development cycle because of this.

So another solution is to simply evade the problem.  If the reason why
tree A needs to depend on tree B is that tree B is using some
interface which has changed, if it's a minor change, then Stephen will
fix it up when he pulls the changes; just as Linus will.

If the issue is that there is some common infrastructure which two git
tree needs, what will often happen is that just those patches which
provide the new infastructure will get put on a branch based on -rcX
on one of the git trees.  And then the subsystems will base their work
on that sub-branche.  For example, suppose the file system developers
have collectively decided that there should be a new fallocate(2)
flag, FALLOC_FL_DONT_RANDOMLY_LOSE (ala RFC 748).  The work to define
and enable that feature in the VFS layer might be placed on the
randomly-lose git branch on xfs.git.  And then the xfs and ext4
development branches will both be based on the randomly-lose branch.

Yet another solution is to arrange the code changes to avoid needing
commits that might conflict.  For example, in fs/ext4/ext4.h, I very
deliberately did this.

/* Until this gets included into linux/compiler-gcc.h */
#ifndef __nonstring
#if defined(GCC_VERSION) && (GCC_VERSION >= 80000)
#define __nonstring __attribute__((nonstring))
#else
#define __nonstring
#endif
#endif

You included a cleanup patch to remove it in your git tree, but it
wasn't actually necessary.  If there was a merge conflict, it would be
simple enough to just drop your cleanup patch, since I had carefully
used #ifndef __nonstring... #endif.  So the idea was that if someone
defined __nonstring somewhere else, it wouldn't break the build with a
duplicate #define since it was protected with an #ifndef.

I didn't mind that you included a cleanup patch; but I set things up
so that it would not be necessary, since often the best way to solve a
merge conflict is by avoiding the need for the change (in some other
git tree) in the first place.  :-)

Cheers,

					- Ted
