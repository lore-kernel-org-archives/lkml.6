Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF71C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E312083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx6nlVQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E312083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeJCE5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:57:55 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43408 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725753AbeJCE5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:57:55 -0400
Received: by mail-qt1-f194.google.com with SMTP id q41-v6so3810897qtq.10;
        Tue, 02 Oct 2018 15:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sWxNWmiqns+AOyqKu02Nwm5Gg98duCkCdWxz4spYG9s=;
        b=mx6nlVQq3QAyG+y+1k2S1PVD/6CiTYx3o1hDYFdaLQMltH0VZq9TakW0astZzMja9v
         8oHIAe+fnIEitLEdYjpRnK2nh34lqkOOu2TLv9BwrI/wQmt13M5qwIdl8Z6/m7Jp36ar
         uqNnRUKISzX1DD/+XnNEYFwzLlx/cjwpIM7U0wxWEzrPO8Mwd3qTW+/M6DR9+g2ZSYzo
         UWkY+6NupMhyc7mimrECD45UEjFwL5pmd/CrNQGD2iJIM7XNEYY2UzVLX7j4UEi45GYi
         p4y2LuKfIpSR3nq1w+b8ksXTqIX1GNjdZ6FkUR17UNH+gF/osrn+tE8Q7Ymm6qTeknaj
         r+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sWxNWmiqns+AOyqKu02Nwm5Gg98duCkCdWxz4spYG9s=;
        b=U0IvrKo5sfynXdf1WIFR3IGsPgocGc1vU/DHwMmPZ41+nzUbtuuzGudaO8EniA4Ifl
         81M9SAF3LmqNE2j0AMlN52/G7aHLor0owAlAixEarvIMTzRFPJQ//wsswE6W9N6Ofni0
         YasjoOP1K7qJQVWUyvpR1xF+Ft8LBQ34aqILORFazAq26/1qFaYvci0hkp5//Kf4kpBR
         un1cbn/Fl9OuLsWI1sANSsmlzCaFAnASAwN5I+0wr5qr6XZEFPH2yzk+mAi6zg5843ea
         voYyQpg+uTm+zSNKs/7KC3sPbbLF7tCiJpXrHPOFbr47NjmTsWtjz6VBSZUFxhCoM59Q
         wnQw==
X-Gm-Message-State: ABuFfojusvIDYxg6WbD8hZItF2MEXm4dXZ0vrP1Jxxcg1TJpdeI9f4EQ
        B+050ObtHMNx6WoIV0jEXGkVeyBSzps3Si1ojuQ=
X-Google-Smtp-Source: ACcGV63rLBKhI9U2VnGnErJc/+FeS6HhA3Ut3M6i+oYZuiC3NcSprAATchZQlVkoLL7VZjCV5y4HVA3jyI3XCYymTeA=
X-Received: by 2002:ac8:3509:: with SMTP id y9-v6mr14455209qtb.241.1538518341837;
 Tue, 02 Oct 2018 15:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72=rgT9cPWH64Tf_8gAU09EiH5FvGqFUdOjV=spVbM5m8Q@mail.gmail.com>
 <20181003071059.02b3fd6f@canb.auug.org.au> <CAKwvOdmt4-jFv6d-ZVUH5OOvXSz38jpuNvQy-jtoSS3xEoh78A@mail.gmail.com>
In-Reply-To: <CAKwvOdmt4-jFv6d-ZVUH5OOvXSz38jpuNvQy-jtoSS3xEoh78A@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 3 Oct 2018 00:12:10 +0200
Message-ID: <CANiq72mmxiO6RWBTQfWYDaa6gmOF01nXmN6BJNCAjAFz3QJqqA@mail.gmail.com>
Subject: Re: [GIT PULL linux-next] Add Compiler Attributes tree
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

Hi Nick,

On Tue, Oct 2, 2018 at 11:16 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Oct 2, 2018 at 2:11 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi Miguel,
> >
> > On Tue, 2 Oct 2018 15:47:12 +0200 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> > >
> > > The Compiler Attributes series has been stable for 10+ days. To
> > > increase testing before 4.20, I would to request it being picked up
> > > for -next.
> > >
> > > The changes w.r.t. v5 in the LKML:
> > >
> > >   - Rebased on top of next-20180928, which required removing
> >
> > Unfortunately, trees/branches included in linux-next must be based on
> > something stable (usually Linus' tree, but it could be another
> > tree/branch that is included in linux-next that does not rebase).
> > Linux-next itself rebases every day, so snything based on it would drag
> > in a previous version of all the other trees :-(
>
> I think of this like a branch that's force pushed to.  Can't base
> other branches or trees off of it cause it's always moving/force
> rewriting history.

As I have read, -next is supposed to be a vision of what the merge
window will look like after merging everything, i.e. ideally -rc1. For
that to work for files out-of-tree (like these ones, which are not
maintained by a single tree), changes should be allowed to be stacked
on each other; otherwise, we cannot handle conflicts :-(

>
> >
> > > aligned_largest, which was removed by 9503cd9cbaba
> > > ("include/linux/compiler*.h: add version detection to
> > > asm_volatile_goto").
> >
> > That commit is from Andrew's patch series which also rebases (usually
> > at least every week), so you cannot depend on it.
>
> Miguel, you should be able to drop that patch from your set then,
> since Andrew's -mm tree flows into this -next tree as well, IIUC.
> We'll take up that patch from there.

Not sure what you mean by "drop that patch". There is no patch to
drop, there is a conflict with a change already in -next.

Cheers,
Miguel
