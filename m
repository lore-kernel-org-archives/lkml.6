Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696F7C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DC42064E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4KwmSEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DC42064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbeJVTm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:42:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35908 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbeJVTm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:42:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id p89-v6so36613951ljb.3;
        Mon, 22 Oct 2018 04:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FPdjKwjTXI+wwDG0R240CjO2jC/BynSfRerURsScnAw=;
        b=q4KwmSEel4WRxtf44uzynKgKbOBskUsffIGJI3KyRhi6SJXrrkDLeOzdU+3AOdUTyc
         atUaP9R5L9qnx/ir9ieNjZ9KGJLUxBgiRS58c8XLdzUTsH340MBi6NeutShdzxk8TEx2
         1UkqVgMYQde03/alKtuKh2RGQip5gKDWjiWakX73e68B4jvUmAZezkc2Trmo43Xw8O6s
         Gl+8PjNixPMSQCz9jL5TlGTPEs2axof6dWJ/gJmpfRiVyzuHYS1VoA+OmshvUFXW3cF+
         ChiJ6eucfBcBbSsv0BLgO5k3puDPvny+gfY1iSfE32M+JE6J72NFjP2gLfo0xC7AjJN9
         4alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FPdjKwjTXI+wwDG0R240CjO2jC/BynSfRerURsScnAw=;
        b=gJpdODxZChMQEYR30D6coePW/Puyt1hcfnzG+I40FTaKVF3LmIGao/vHkFUB0mSd2c
         5V4gY2FCh5FDnKMP1lVF90IM1hWGagidJWhy0HhuUODYsvIY8H1FvITh+1vXYn7XEPNu
         lhuhXMKfmKnOuwCYagoke0T8OpS/NsKP6MXCIUOlrv7gHsK+kqu+c7qc1r5CGd7mJ1YH
         IZAK6kZkUjVjd/MlidWzrnqaN0rL9bylUnImHKmYEOTdqkZ4lXxt+opZ5kv9c5uqx1tV
         9zOMto8GqYI65+bAMEC4YUn18t9+G13Q0L7MMrddRByOlU5Q4+n8GaW+5VnEQmGyKQHk
         7Xkw==
X-Gm-Message-State: ABuFfoiKVQ//Dvl7EBE4Pdw4WWNB9o2rSrCummS4/8L3DdjBjZp4Cz2R
        MLTxE+Q2ts776ZAmLeJiRKhFnL+tXtrgc//ampo=
X-Google-Smtp-Source: AJdET5fb4kNAI1F5REsLtCZRhjr2yRbap8W0TIhoZpiA6Z4EDqWPNT0TZ/rlnb6QrJzMjN6bFdUhknYHROyRl2C+Zz4=
X-Received: by 2002:a2e:240b:: with SMTP id k11-v6mr7582851ljk.139.1540207454975;
 Mon, 22 Oct 2018 04:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181021222712.GI1617@thunk.org>
 <CANiq72mXV6WTyHXNZJDTfFOpPrXD0zD6cB30bGOuKO44AvRiog@mail.gmail.com>
 <CAGXu5jKb-0H+smRAW6ngQKDZ-PbTThhMwhmu34iB8vjTa-4H8Q@mail.gmail.com>
 <CANiq72n4+HDXPqr7xySSGx49g8vEcXaxO7a-By9cSg7YSxOS_A@mail.gmail.com> <CAGXu5jLzfuEnWpJFL1Caq94nKbPps-QTaYGpge2CfZWj1Zzf9g@mail.gmail.com>
In-Reply-To: <CAGXu5jLzfuEnWpJFL1Caq94nKbPps-QTaYGpge2CfZWj1Zzf9g@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Oct 2018 13:24:03 +0200
Message-ID: <CANiq72kpCoVwCzMUVYB_km+9xr41gBZLo_K203e_t4_QZ9-r1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Ted Ts'o" <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>,
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

On Mon, Oct 22, 2018 at 12:53 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Oct 22, 2018 at 2:41 AM, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> > Please take a look at the rationale (also more details at the linked thread):
> >
> >   * gcc 7.1 added -Wimplicit-fallthrough at the same time as the
> > attribute and the comment parsing.
>
> Ah, perfect. I missed this. :)

No problem! I know the commit message is a bit too long, so I understand :)

>
> >   * clang does *not* support the attribute in C.
>
> Well that's not good. :)

I will see with clang if they plan to add it.

(By the way, if the "*not*" sounded rude, sorry; I wanted to emphasize
it is surprising that it doesn't -- I also assumed the opposite until
I checked it).

Cheers,
Miguel
