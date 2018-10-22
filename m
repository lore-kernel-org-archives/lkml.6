Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11B4C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9262C20658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGZ2cra+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9262C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeJVRoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:44:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46711 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbeJVRoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:44:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id x3-v6so36265419lji.13;
        Mon, 22 Oct 2018 02:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=3H9axaKui5TKJllg9hWj3PLem3zLVXeS0Xjijn0TS88=;
        b=fGZ2cra+hf6+AwhL4gEZ+VCymGmieYOZcFMC83YSKlx16RDIM1Kp6+01xlHOSVAjuO
         b9mG/O+FEvGxc/AKWU+NazQcv8CGIw1QFhgFySh8ZcuEBfucemVsEEVqfEjOMR5bUrz+
         RCdjkPIr+shBI2MfHKa2TfQcAmQiPhum3bFxPs6I+8yxuro22Hijm0W/qXbMxAcpVg99
         3sZOiMxMy3hHIrwei9yYAN0sfI3m20GEAEhr/7+gbcD6guCRk4rgzZusvte8cnHOUom1
         g3nQqAFfxMqmii02mA5rYNPLu6j/vbph1Fkt5vcxLgn1S6GI126oJVBlQqWzRzTQkhR9
         WFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=3H9axaKui5TKJllg9hWj3PLem3zLVXeS0Xjijn0TS88=;
        b=TTrJtY4YPlInZU2tW34+LkFZcCI0o47OodXm5eguVhppojcDNGJ+TjMgoJh24WMYlT
         KZQXerAvVOZVzfLhVyctbmjqbar4gOPcKT5cz8Bfh+T4fZ5S1brMd3z7zEqsWXIuVPyg
         mT2l74fdB40VGeP18qUhb/IE1nb6lRcwkbBr9lhv59Gjpj40fb//5b/S8hoYUmZagxV3
         JNREjAdLFdTxM7BeoYeQLTI2BL+5yhgYsPo+7Mf2iJzF1lXjixuzhzcdJws+TeF5l7wl
         sKKQ4loMfo2OAlGpoeTL0r6lC8QUgTyFc2iZMzuil/LUPJ8emmKaGg+Qa+7f31ydJxro
         XpXQ==
X-Gm-Message-State: ABuFfojBvPlQU8/M9fuQmgoTPsBWkJ93vn+xT+I0YIGNhuP+TMDRLKsz
        8ArD03OOacyZOubsXhJBHKKOwmcj83FqSDlORi0=
X-Google-Smtp-Source: ACcGV6072dDGmwxuz1oFx3kRlmo8Crg0tiq6x0MDDDPYun7HJ6XrRxGGQJzxVco4IVg1gYwsunRhHxTp9GGn1XGBVxI=
X-Received: by 2002:a2e:6e08:: with SMTP id j8-v6mr31545836ljc.61.1540200399659;
 Mon, 22 Oct 2018 02:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181021222712.GI1617@thunk.org>
In-Reply-To: <20181021222712.GI1617@thunk.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Oct 2018 11:26:28 +0200
Message-ID: <CANiq72mXV6WTyHXNZJDTfFOpPrXD0zD6cB30bGOuKO44AvRiog@mail.gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
To:     "Ted Ts'o" <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan <dan.carpenter@oracle.com>,
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
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 12:27 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Sun, Oct 21, 2018 at 07:14:13PM +0200, Miguel Ojeda wrote:
> > From the GCC manual:
> >
> >   fallthrough
> >
> >     The fallthrough attribute with a null statement serves as a
> >     fallthrough statement. It hints to the compiler that a statement
> >     that falls through to another case label, or user-defined label
> >     in a switch statement is intentional and thus the -Wimplicit-fallthrough
> >     warning must not trigger. The fallthrough attribute may appear
> >     at most once in each attribute list, and may not be mixed with
> >     other attributes. It can only be used in a switch statement
> >     (the compiler will issue an error otherwise), after a preceding
> >     statement and before a logically succeeding case label,
> >     or user-defined label.
> >
> >   https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html
>
> Do we know if coverity understands the fallthrough attribute?  One of
> the reasons why I started using /* fallthrough */ is because it kept
> Coverity happy.

If Coverity is like gcc, they should be doing both (i.e. I see the
comment parsing as an "extra" that gcc did, but the "basic stuff" is
the attribute -- and I would guess it is way easier for them to
support than the comment parsing).

But I cannot test it myself :-( Someone, please?

However, if I understood Greg correctly in his reply to the cover
letter, he replied that Coverity knows about it (?).

>
> If the conversion from /* fallthrough */ to the __fallthrough__
> attribute means that we start gethting a lot of Coverity warnings,
> that would be unfortunate.  OTOH, if this is getting standardized,
> maybe we can get Coverity to understand this attribute?

Indeed! That would be the best for everyone, including Coverity customers.

Cheers,
Miguel
