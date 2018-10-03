Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60285C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092AC2082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzD2jr13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092AC2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeJCTWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:22:53 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40184 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbeJCTWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:22:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id e9-v6so5636515qtp.7;
        Wed, 03 Oct 2018 05:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O1thCiDnhAjauNlqszuhXYPw0fCWRhuLQh4x+pM2oMI=;
        b=NzD2jr13ZmIhh3a5WDHycXBljwN4Ipu4dEsRpKz44NZwBg5iKXsdejpUyGEeEwABan
         iNIWgV9l8SKIp23gMkW12EkmiVna0R+SdielDYttyGAQVUL+IdiPOwKQn2QjGFbnrBKQ
         3kp9O2c05T5vBxYQBVdKI0dQNBNOSvJBQjJWOBcYFyiGgauFZ02uCDK018RZYFoaICTM
         GusYTT9FGMnJQr49aBKexa3sYqp6RYDST5rtv1ijKlRJBzv3fXic1FPcsB8Sr7Luj4Rg
         xS64/EA7IDod/wv750oG2OHOtJ1OFsSGISNVe9FcnJJtfu63SRxKtZaDKjhq3UcmJGWc
         oJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O1thCiDnhAjauNlqszuhXYPw0fCWRhuLQh4x+pM2oMI=;
        b=f5+B6DIOUm8BFHN/1fYAxXa4W30oDxYT5QtC8F34F5cVvEoRJoeai4d76HUX1lHuc9
         HuJ8VmIZPMiIVdwqDfppjwPCe6/8sgqjebZjNzdyWqNbmWOVhpHfiz8J/MEJ8QG5nk8U
         qvREd+OR48rPu8/iZ0mWdtAlDa/E1ZM3dRF6Mfr8bEW2SN6LkkbWv5B89g0arLag0E1r
         9olHUMtCPHXMfnorjECWWPcrc9f9WnVYBSp10I4kUsV5o/9XF1jGpe6llhQdOqu6a+HJ
         avYVwDgmNG9yPdw4/KuXPxZjCUC0CpPnO7D85LVqj0/3+Fefn2gg2CsnPeRG/g4L2Yit
         RQ3Q==
X-Gm-Message-State: ABuFfohh96UNS+B9/hO/GKARIRLZ5yXY0CRl9MB9clKr7dInsD/XDs7S
        jKYRCooEVshi61fVb1QmK9UXZT8rPbIO6oElqTF04h+3gCo=
X-Google-Smtp-Source: ACcGV633FiC9gxokPjDtkGa7mJwOqrl2bHf8HKCy478WChhI9u+NXDlw4KybzgVJeXQjXLmSEKpTp0MEQWspZhsa2EA=
X-Received: by 2002:ac8:3509:: with SMTP id y9-v6mr976590qtb.241.1538570079612;
 Wed, 03 Oct 2018 05:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72=rgT9cPWH64Tf_8gAU09EiH5FvGqFUdOjV=spVbM5m8Q@mail.gmail.com>
 <20181003071059.02b3fd6f@canb.auug.org.au> <CAKwvOdmt4-jFv6d-ZVUH5OOvXSz38jpuNvQy-jtoSS3xEoh78A@mail.gmail.com>
 <CANiq72mmxiO6RWBTQfWYDaa6gmOF01nXmN6BJNCAjAFz3QJqqA@mail.gmail.com>
 <20181002223652.GA4290@nautica> <20181003090010.5150f914@canb.auug.org.au>
In-Reply-To: <20181003090010.5150f914@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 3 Oct 2018 14:34:28 +0200
Message-ID: <CANiq72nLLhTf3AsXqLkPmK6TV_g7E3tML9XaM_zE45dM7XPn-A@mail.gmail.com>
Subject: Re: [GIT PULL linux-next] Add Compiler Attributes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
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
        Jonathan Corbet <corbet@lwn.net>, "Ted Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, Oct 3, 2018 at 1:00 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Miguel,
>
> On Wed, 3 Oct 2018 00:36:52 +0200 Dominique Martinet <asmadeus@codewreck.org> wrote:
> >
> > Miguel Ojeda wrote on Wed, Oct 03, 2018:
> > > As I have read, -next is supposed to be a vision of what the merge
> > > window will look like after merging everything, i.e. ideally -rc1. For
> > > that to work for files out-of-tree (like these ones, which are not
> > > maintained by a single tree), changes should be allowed to be stacked
> > > on each other; otherwise, we cannot handle conflicts :-(
> >
> > The rule is the same as with a regular mainline pull; I don't have the
> > reference at hand but in some recent-ish pull request Linus said he
> > prefers the stable version with the conflict, and optionally you can
> > provide a second branch with the conflict resolved for reference, but
> > the pull request should be based on something stable even if it has
> > conflicts
> >
> > If there is a conflict Stefen will resolve it like Linus/Greg would, and
> > the resolved bit will be carried over everyday so it's not much more
> > work -- exactly like a regular pull request for inclusion in the main
> > tree :)
>
> Exactly what Dominique said.  I will fix up the conflict (unless it is
> a very complex conflict, in which case the author(s) should help) and
> the Linus (or Greg) will do the same.  If you do depend on a patch in
> Andrew's series, what happens if that patch does not get sent to Linus
> during the merge window or Linus rejects it?

This doesn't depend on anything. Not sure what is all the fuss about
-- people got confused into thinking we had to drop a patch for some
reason. As explained in the first email, I simply rebased v5 (which is
based on top of rcX) to resolve the conflict myself (i.e. it does
*not* depend on changes in -next). If you are the one solving
conflicts yourself (which is what I asked in my second email), there
is no problem to begin with; I will simply send v6 to you and we are
done.

When I sent the first email, I assumed that changes in -next were
supposed to be clean -- my mistake, but please document somewhere how
-next works! Specially that you are rerere'ing conflicts and
re-resolving them every day.

Then the discussion shifted to what to do with changes that actually
depend on other changes.

Cheers,
Miguel
