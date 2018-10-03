Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,WEIRD_QUOTING
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2898EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF612089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVlE3JIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF612089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeJCSmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:42:23 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:37140 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeJCSmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:42:22 -0400
Received: by mail-qt1-f170.google.com with SMTP id n6-v6so5515154qtl.4;
        Wed, 03 Oct 2018 04:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4ZU0NqyeDKJqVATpo3F4hRGrcA/p65+RxIxkyHT2WTc=;
        b=qVlE3JITjCo5T80aFChdQqXhV+2JMBmatix6tHhnP7ucNESrIIVHl0z8mzU6OERp4F
         maueJ5aELTDSjxuOmvUsXTYGl4i3iZcYH5U3Le8Dw0kejQ/gWA8ZJjmq3XaVjihlk413
         NrjCbsEvmI+XD8gfucgHP+YdDr+auZt1WxcPKp6zJ3rmfmAy7zCcR2CO+M01GflsBZ+s
         0bsgv/LTm+hAmGpWPTSK0l8q/uxfaytO5SEastOsWlj/3LICm23oCmJNtOSpzYW3cFgZ
         Vqp5F7wLOBuOmCrNoepOfiqZp81PKcveEUW2YLmvPRsUcAThZxnJPz7J7GMhUNRMVEqs
         mCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4ZU0NqyeDKJqVATpo3F4hRGrcA/p65+RxIxkyHT2WTc=;
        b=cLTTV+SUfRbG4oOd/G4Yc/NKT/xqECm4e7hO7aRo9Jm1k3S56SI6HJNaGwO0F+kdD5
         4QdnxRYJalrO4ufAwdOBq4IP2pIoM7qrLETCj65B6PXH+XPEDqLqQKUtiejtAkR20Z5U
         329h6Y5s5lJ5T7Fr3+Cq6m4rp04Y5w9WwOu2TqL2ewvo9j74JYomTBsv0id5vwnO4Zs7
         8rqjDvC47k7hyy0MC+O7LDAwqcscrL8kmXtbzll6id/kFYlXP9TOQSKAxEScE7eplhdY
         QNhZrV7/ihLpaE++td8nCrhavcPNeTEdgygZuC1AbTdkEmPQ7Mo0010tkx4JAVpH2+Gk
         rpCQ==
X-Gm-Message-State: ABuFfohq1/ER92frYNCKnPPcg7iMDY4XZobQ1nnq9ZBRtxJgHn6SO/33
        7ZGQ8CZ26x1gtM0/s+633x2x/2Of4JU4YtU9Sbo=
X-Google-Smtp-Source: ACcGV63hL17PT6rKb0AKtDderPdljFWkjDQ8LIIVwOggDYDuenGMDpaesV8t3ixxVdYuocER+WRnCUv6hk2rTK0aK9E=
X-Received: by 2002:a0c:f40c:: with SMTP id h12-v6mr870825qvl.78.1538567656744;
 Wed, 03 Oct 2018 04:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72=rgT9cPWH64Tf_8gAU09EiH5FvGqFUdOjV=spVbM5m8Q@mail.gmail.com>
 <20181003071059.02b3fd6f@canb.auug.org.au> <CAKwvOdmt4-jFv6d-ZVUH5OOvXSz38jpuNvQy-jtoSS3xEoh78A@mail.gmail.com>
 <CANiq72mmxiO6RWBTQfWYDaa6gmOF01nXmN6BJNCAjAFz3QJqqA@mail.gmail.com> <20181002232454.GB2483@thunk.org>
In-Reply-To: <20181002232454.GB2483@thunk.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 3 Oct 2018 13:54:05 +0200
Message-ID: <CANiq72=cRpqnB3BxLsmj-rMdUGJK+pac1SRppoRgsON69ErfQg@mail.gmail.com>
Subject: Re: [GIT PULL linux-next] Add Compiler Attributes tree
To:     "Ted Ts'o" <tytso@mit.edu>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

On Wed, Oct 3, 2018 at 1:25 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Oct 03, 2018 at 12:12:10AM +0200, Miguel Ojeda wrote:
> > As I have read, -next is supposed to be a vision of what the merge
> > window will look like after merging everything, i.e. ideally -rc1. For
> > that to work for files out-of-tree (like these ones, which are not
> > maintained by a single tree), changes should be allowed to be stacked
> > on each other; otherwise, we cannot handle conflicts :-(
>
> In general, best practice is to base tree on an -rcX commit.  I
> usually will use something like -rc4 which is after most of the major
> changes have gone in.  This tends to reduce conflicts for most git
> trees.

Sure. That is what I do for mainline PRs to Linus. As you say, it
works fine for mostly independent trees. But it doesn't (that well)
for out-of-tree stuff or for stuff spanning several trees.

>
> There are times when a commit in one tree needs to depend on a commit
> in another tree.  What to do depends on the circumstances.
>

Exactly. And for this case, I simply assumed Stephen wanted a clean
series to apply on top of the latest next-* tag (same way we base
stuff on top of -rc*s). Note that this is *not* really a "tree"
collecting changes/development, it is a patch series, i.e. what is
important is only the range-diff.

What has surprised me is that -next does not allow for range-diffs
(patches/commits/...) to be inside -next, maybe applied after all the
normal merges of trees. I simply assumed it did, given what I could
find about -next (which does not seem to be documented properly, by
the way).

>
> So another solution is to simply evade the problem.  If the reason why
> tree A needs to depend on tree B is that tree B is using some
> interface which has changed, if it's a minor change, then Stephen will
> fix it up when he pulls the changes; just as Linus will.

While this is a simple conflict, I don't really agree with release
maintainers having to fix conflicts on the fly (even if it is a single
trivial line), but that is an orthogonal discussion...

> Yet another solution is to arrange the code changes to avoid needing
> commits that might conflict.  For example, in fs/ext4/ext4.h, I very
> deliberately did this.
>
> /* Until this gets included into linux/compiler-gcc.h */
> #ifndef __nonstring
> #if defined(GCC_VERSION) && (GCC_VERSION >= 80000)
> #define __nonstring __attribute__((nonstring))
> #else
> #define __nonstring
> #endif
> #endif
>
> You included a cleanup patch to remove it in your git tree, but it
> wasn't actually necessary.  If there was a merge conflict, it would be
> simple enough to just drop your cleanup patch, since I had carefully
> used #ifndef __nonstring... #endif.  So the idea was that if someone
> defined __nonstring somewhere else, it wouldn't break the build with a
> duplicate #define since it was protected with an #ifndef.
>
> I didn't mind that you included a cleanup patch; but I set things up
> so that it would not be necessary, since often the best way to solve a
> merge conflict is by avoiding the need for the change (in some other
> git tree) in the first place.  :-)

Alright, I am not sure how to answer this without sounding
"aggressive" and maybe I misunderstood something you tried to point
out, so I apologize in advance. There are several points here:

  * The merge conflict isn't related to this (but let's assume it was,
since you pointed this out as an example -- I guess; although I am not
sure why).

  * Thanks for explaining, but I think most people here understand how
#ifndef works :-) Also note that we already had guards for some
attributes that needed per-compiler implementations.

  * The patch is actually necessary:

    - Several people argued that examples should be present when I
introduced __nonstring earlier in the series. While I don't think they
are mandatory for this case, they are good to have, and since they
were anyway requested, I happily added them.

    - Changes should include everything related to them (as far as
possible, i.e. extreme examples aside). Adding __nonstring and not
removing the ext4 part would simply be leaving undone work (which has
to be done sooner or later). To be honest, it could have even been
done in the same commit and I would say it is logically OK (even if
not great).

    - Related to that: I think the outer #ifndef shouldn't have been
included to begin with, because it is either wrong or dead code: if we
end up having a __nonstring, it should be removed at the same time
(like this series does); and if __nonstring isn't there (like now), it
isn't guarding against anything. At worst, it could hide a mismatch in
the definitions.

    - I promised to you I would clean it up :-)

You seem to argue that it is better to avoid merge conflicts rather
than doing a proper series. Well, I think we should really try to
avoid conflicts pushing down the """quality""" of
patches/commits/series.

Cheers,
Miguel
