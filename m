Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638E6C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FE020835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0sq8MMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FE020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeJCTCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:02:50 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:44010 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbeJCTCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:02:49 -0400
Received: by mail-qt1-f181.google.com with SMTP id q41-v6so5557528qtq.10;
        Wed, 03 Oct 2018 05:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZ6SjRN7wE51mkqoyKikCoCxFwvUX+jyBke290XiCDk=;
        b=V0sq8MMMen6LrKDcuUxywm1VVsNqbQq63TxDX1M9vgpNPaa1A2t44XhNrKzWO0qfYt
         moNk2lX+iopA2W4EMABwOPppzd8W1h2+LNZebfcMwmd8KML2FoaZ+pQsp4z1Xh/dQOGA
         l3HxmX1VcxQ+oQHcqx+BshfTn1znRG/wUYI2uDSWwiZnKAUqzTpqVTXhBelOzWbnJs0U
         Ch+A1r+H5Tc3YvPH/yoQrfMadE2iy2OkrddzWBs6G/gY3UjUcCLi+H3vKjwOje2ZfnLo
         Zimh6nLaQkXKD+2aLRWle7sSHP1FFN1IeLKRN4ZvmhoXVRQiibL+cxbDQWzcTrt34nJB
         RfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZ6SjRN7wE51mkqoyKikCoCxFwvUX+jyBke290XiCDk=;
        b=lUA9P0rbsN9olbM05efd6YdFmoGWUZ7dhQWc6sJxfOqwiwZo+PcGeeZJSyrwul11qW
         EW94veka+VaPURAEMsHcBwV9w5/0JNPx4AP8Dv7G2JmiTm/4FdVFNz7Xv27hCTfkyoPw
         bNEUMX4uDpSwzxH/b/hDxzxL4JNsmlam4yRSCJ4ukVXsEAnUKUswdRnn6FBgOCk2TcRj
         U6sGTj0aAPoovVqAN4Uqd/vBGzjWnf13/ic9jzr1ngD/yBGtujxrJrxI0b5zufj30Efj
         f+fWNYcglVsdGhDzk1t9YIqiro1VZ/1kHlZEKrQLbAFjgcCfzCrOwuOvnlYHlFFR+Sbo
         07Rw==
X-Gm-Message-State: ABuFfoh4m8zGPRIrIBcIHj7inosmlKnbopaw6AozbDicmvJNrv/RD0kG
        kw2yRnOWl5PSkAHWm+JPkllFhZJzTCnLMrdt/N4=
X-Google-Smtp-Source: ACcGV60yrOCrSVT/HVLbGitvvMGQeN2ROahIvGMiwQJ8XORXpmyPSsiDRgxw1LZ8DVuIwM4s1jWsZQZ8jpfnaOUWyds=
X-Received: by 2002:ad4:4245:: with SMTP id l5-v6mr909546qvq.140.1538568879681;
 Wed, 03 Oct 2018 05:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72=rgT9cPWH64Tf_8gAU09EiH5FvGqFUdOjV=spVbM5m8Q@mail.gmail.com>
 <20181003071059.02b3fd6f@canb.auug.org.au> <CAKwvOdmt4-jFv6d-ZVUH5OOvXSz38jpuNvQy-jtoSS3xEoh78A@mail.gmail.com>
 <CANiq72mmxiO6RWBTQfWYDaa6gmOF01nXmN6BJNCAjAFz3QJqqA@mail.gmail.com> <20181002223652.GA4290@nautica>
In-Reply-To: <20181002223652.GA4290@nautica>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 3 Oct 2018 14:14:28 +0200
Message-ID: <CANiq72=M2xQa6FJ1YZ2kKuNXES-XSn1O9yJ+FbhgMawND_kAqA@mail.gmail.com>
Subject: Re: [GIT PULL linux-next] Add Compiler Attributes tree
To:     Dominique Martinet <asmadeus@codewreck.org>
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
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Dominique,

On Wed, Oct 3, 2018 at 12:37 AM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Miguel Ojeda wrote on Wed, Oct 03, 2018:
> > As I have read, -next is supposed to be a vision of what the merge
> > window will look like after merging everything, i.e. ideally -rc1. For
> > that to work for files out-of-tree (like these ones, which are not
> > maintained by a single tree), changes should be allowed to be stacked
> > on each other; otherwise, we cannot handle conflicts :-(
>
> The rule is the same as with a regular mainline pull; I don't have the
> reference at hand but in some recent-ish pull request Linus said he

That is actually the first problem: there is no
reference/documentation at hand. :-P

Cheers,
Miguel
