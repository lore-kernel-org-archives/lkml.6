Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21EDC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26072083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9sjZ6AO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26072083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJCEuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:50:13 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36940 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeJCEuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:50:12 -0400
Received: by mail-qk1-f193.google.com with SMTP id x8-v6so2220846qka.4;
        Tue, 02 Oct 2018 15:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZamy6iYH5OSZp4S2SNF2Cb1OLsvnlEgThQoQVJBMjc=;
        b=N9sjZ6AOqUpBZk0ysYQ6cgHQBRnIqCZaYCj5j6yzTC44L8DZev6yhcREm2E6mAD4PI
         1WEwBml4zBfboNlPVQebkliopaEXbwOckgpZ65nt//HbVADsdfcsZaT2PBra1XDZ4cYV
         mSEHAW8xvQQ3nKXLUDLda3YFbs5PeOZB6+Mhyf8SQukykBu3i28sBSlfLkonKCWchvJC
         ktcXZsscWxheXHeZa0TjVT6dgVE0zXyzGgj6oa7jyuZhWuaXnuF1lGNGHY3C/gpj4RU3
         oMmVgI6ZDIoeoJzgDP5KJhF+1ME4W0xF5D/K897vMjsL9LMY4vvmY6vRZKFi1vh250eW
         0Ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZamy6iYH5OSZp4S2SNF2Cb1OLsvnlEgThQoQVJBMjc=;
        b=Qxdt8Oi/IzXKbC/IZbwJgBBUFUkTTiG5MUCbgmcAl6qgVEhQmIoT1EOwb1L0GhXF6/
         qoi3djKX3yZdQm/8UUC/Sa/KE7r8U1/Ihod+QxX4lnoRORECtoifZxosv1k8C0u2jAZs
         TzGy56rc4hATASoe2FU8i34GWrMHMHlw6M5fNkl/Thn3S0vqefqDZx15qyfFrw74q8vQ
         Q3QrmEb7xyBF+gEKfkkm8+3Ri31qJzsM+H9Ai8bm4yaYNGfYRmXlHKuLp/pQZVGCthkv
         oHuMJmxYAzkSA+YR3PkzBD8/LMNlVa7oYi4UGbncze7TKERWAWalJ6Nl+AYsV79KJDmc
         oGkA==
X-Gm-Message-State: ABuFfoh13ASgHDS3xMQGIGWDLi5DQIQVUeAraJqdZiBbxDb5A5CEAxnd
        FC858BZl90sb18AaQFzmyJ/VdcK8Wy+UG6X4h48=
X-Google-Smtp-Source: ACcGV62yJiBCABKQHJNPL4GDfab7gXLSTFMor8k11c7JkpBtupGVZqrH5eOwEY7uEKPZIt46Zw34StGdXn75Vx1O2Lo=
X-Received: by 2002:a37:7a05:: with SMTP id v5-v6mr13498967qkc.129.1538517880586;
 Tue, 02 Oct 2018 15:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72=rgT9cPWH64Tf_8gAU09EiH5FvGqFUdOjV=spVbM5m8Q@mail.gmail.com>
 <20181003071059.02b3fd6f@canb.auug.org.au>
In-Reply-To: <20181003071059.02b3fd6f@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 3 Oct 2018 00:04:29 +0200
Message-ID: <CANiq72nh0nybEC8SizQ9rv=RvncMuTH-dt5vciRtvQ1aFBzJcg@mail.gmail.com>
Subject: Re: [GIT PULL linux-next] Add Compiler Attributes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
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
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Tue, Oct 2, 2018 at 11:11 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Miguel,
>
> On Tue, 2 Oct 2018 15:47:12 +0200 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > The Compiler Attributes series has been stable for 10+ days. To
> > increase testing before 4.20, I would to request it being picked up
> > for -next.
> >
> > The changes w.r.t. v5 in the LKML:
> >
> >   - Rebased on top of next-20180928, which required removing
>
> Unfortunately, trees/branches included in linux-next must be based on
> something stable (usually Linus' tree, but it could be another
> tree/branch that is included in linux-next that does not rebase).
> Linux-next itself rebases every day, so snything based on it would drag
> in a previous version of all the other trees :-(

I assumed you could apply changes as a diff/patches/cherry-pick, not
as a merge, for those that went on top of others (so that at the new
merge window, conflicts were already solved). Otherwise, why are
next-* tags/branches provided anyway?

>
> > aligned_largest, which was removed by 9503cd9cbaba
> > ("include/linux/compiler*.h: add version detection to
> > asm_volatile_goto").
>
> That commit is from Andrew's patch series which also rebases (usually
> at least every week), so you cannot depend on it.

Then who is solving the conflict?

Thanks!

Cheers,
Miguel
