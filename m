Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F4BC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 15:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAF72084A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 15:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JaC7nXYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbeLPPcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 10:32:13 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:53861 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 10:32:13 -0500
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wBGFW6MU003153;
        Mon, 17 Dec 2018 00:32:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wBGFW6MU003153
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544974327;
        bh=imOuGBGs3zRWgUliaqDZAfg5ioGIQaublteAaY4vYog=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JaC7nXYPzaXp+3aDJuCXOOSKRmcPPLZTxjRKXufyoG5QrRmkNqPdENSPPSeCNukPf
         X6ermr1iRtjfd8bC5zc1j9Adr+EYcGM8nrGf08dtfCkz0j1VUpexc1GJeg7W//MtZI
         Ol3UkFN0HxYzEptA/Tph+fpCy89BJTXKwxtG3c06Yl6dOtZ9Z1L666YFAgDjb91EFv
         lzLxKJ722JdJ5UboB7TyKPFyctIwZHeI7crIMdGlWsLJl4qewC2gUuyRiVvqeRyO0J
         tDfv6B0gAj2nlLB73yZ7Zyo41TSFjmicZDKyLoScwpFZG2ODikE8PiQwl5GIzD2OjC
         YyQ3G8DaUSMRg==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id p9so3620213uaa.5;
        Sun, 16 Dec 2018 07:32:07 -0800 (PST)
X-Gm-Message-State: AA+aEWaI8HyNffL5SZZd2lTTb+rvCu9EHdVInbBzhgM7S/sING9AJKS3
        LVFedQrZXWezN+BRXBgxARsDVyTBRzWTsig75Dg=
X-Google-Smtp-Source: AFSGD/WkDKHTgvqvPyaFY9zeUEXym2mFQtUEe0IpDU90+XiD1UcahQltVr8dxZ22lMn3HB5b4T1WGkpVJhfufj9t2yQ=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr4767614uap.6.1544974325816;
 Sun, 16 Dec 2018 07:32:05 -0800 (PST)
MIME-Version: 1.0
References: <1544774739-13471-1-git-send-email-yamada.masahiro@socionext.com>
 <1544774739-13471-2-git-send-email-yamada.masahiro@socionext.com> <CAKwvOdkSSb-EECgCmYnW40Mbd4ibSf22wqUBqaT_X7g7Sn_9UQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkSSb-EECgCmYnW40Mbd4ibSf22wqUBqaT_X7g7Sn_9UQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 17 Dec 2018 00:31:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNATMRvsyiQH3+S==r8xObv5uedQmqnj6zZyv8uwFrt0p+Q@mail.gmail.com>
Message-ID: <CAK7LNATMRvsyiQH3+S==r8xObv5uedQmqnj6zZyv8uwFrt0p+Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] kbuild: add -Werror=strict-prototype flag unconditionally
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 3:34 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Dec 14, 2018 at 12:06 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > -Wstrict-prototype is added to KBUILD_CFLAGS first, then overridden
>
> -Wstrict-prototypes (plural)
>
> > by -Werror=strict-prototype later.
>
> -Werror=strict-prototypes (plural)
>
> LGTM: https://godbolt.org/z/DyEpmU
>
> If you would mind updating the commit message (and subject), then:
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>


Thanks for checking this.

I will locally fix those typos (including the one in the subject).



-- 
Best Regards
Masahiro Yamada
