Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2080ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C312083A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFn27bN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C312083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeJVSBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:01:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40721 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbeJVSBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:01:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id r83-v6so36321246ljr.7;
        Mon, 22 Oct 2018 02:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aTsuRC+sfx70YkhfAV1+N98W1zEAs+8GCZO7LWqJ66Y=;
        b=QFn27bN407lJTXn3HcBoCwp0+fsvdXbawisTmi2asb8D928Wqs3ud32wejmDCAed0I
         drcKRwbNLhN99I8DmvEt2WRtm0ffr2rejfK7Zj3LZme/HB58V0GxECDPaA1afRLEM544
         P3+8OPdhiO5YSy8Soh1iIdGTWEJqkvdpQk7eq+mtmKSDrpMDnPOu316pp4FiT1GUEfQP
         EfT4VyUWLNss/aC6KpCT0W4q/vau2cnnZmy5xvdhdHAydidCLk6tIpVKNiHroAxm17wE
         SMZD8xpVMtFpu0MTmr0PmMTQf5g1R9QcnJyGlD2BTznX3jK8Di+gifg0dKHaUjljowyd
         7gFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTsuRC+sfx70YkhfAV1+N98W1zEAs+8GCZO7LWqJ66Y=;
        b=PDSSmKctHGUQvw7rPH0K5Yu/p9ERaiu+D5wpi+3rqdPeXVLIJ/EOjR6R1HrP2ffIDw
         jpZhqGVy+YxBbKCEuGnjnt97Ulwu9Ol6iqa9J+AZ+mC8jaL1XFNe+1SYQ/mVb2opgxD9
         6RqMLhJ2ngY7ANb7jULbw4ftyKNEwpcr+r3obkFJrVY5DpmzqdgDyUQInN5YkJqfl+xD
         eyx8a3Wk2L7nbf+eMZsMv5S/fPE0D14yL3Xk3oNKM9q+/a/9hftAE7VplOJssMRWwYQK
         SwPQA0W1ziHCAqo3wdOGTsDiuGon69p1eaoZqYDelFPbVg16kCnTfVlrjf9lKt42Vreg
         etIg==
X-Gm-Message-State: ABuFfohesigJUwmMatJWGT7fcj0BqbciSXNWJXWGg7XX5OGpAEqQ9ODx
        7ntvc1DCw7vbdFW19wP4ZXQzYgrnVcZtIxwB0xg=
X-Google-Smtp-Source: AJdET5dk9qykMAmjnlWlDVIYcwDar2slhJYgxblV6hkcubBRE6S8V4+yLc3YvlvPvoAv0JcPYsW80WSP0ycWT/rfkok=
X-Received: by 2002:a2e:240b:: with SMTP id k11-v6mr7303575ljk.139.1540201405449;
 Mon, 22 Oct 2018 02:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181021222712.GI1617@thunk.org>
 <CANiq72mXV6WTyHXNZJDTfFOpPrXD0zD6cB30bGOuKO44AvRiog@mail.gmail.com>
 <CAGXu5jKb-0H+smRAW6ngQKDZ-PbTThhMwhmu34iB8vjTa-4H8Q@mail.gmail.com> <CANiq72n4+HDXPqr7xySSGx49g8vEcXaxO7a-By9cSg7YSxOS_A@mail.gmail.com>
In-Reply-To: <CANiq72n4+HDXPqr7xySSGx49g8vEcXaxO7a-By9cSg7YSxOS_A@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Oct 2018 11:43:13 +0200
Message-ID: <CANiq72kNnrhi8OPbF7P+Rw4SGYu=JuvhDKtzGtG2J5AOoC1-Dw@mail.gmail.com>
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

On Mon, Oct 22, 2018 at 11:41 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
>   * clang does *not* support the attribute in C.

...nor the warning at all, by the way (which is why this is OK).

Cheers,
Miguel
