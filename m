Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1070FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0374223D0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="edDKRQlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0374223D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbeKLXtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:49:01 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:23849 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbeKLXtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:49:01 -0500
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id wACDtHvS029364
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 22:55:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wACDtHvS029364
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542030918;
        bh=kYBrm+H9kkpFSmTYkQyHuk0fXU2LjgMKhZRdchgAkEQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=edDKRQlBsRW860/hmIzmlbxYmgh9bAWeY1RflfK2gcJAZIUGDIaUZjckBxkKNr6IM
         K6Px6Cet/xjHMlit4bYtL3GTWYK+QHNE0rUk8Xirx39j24gI2uhvjA79pdHsurfXAd
         P/QvTiuGADRv1ijewZBMb/4jAxPM1d4ATBcKAE40G88e/XB5VAnd+j9z9/IjitrF5d
         0FPt8HWkg+NHT42DE44uyvbJt4RHP+ango8QoiXjSKxc5HzKzcjJ2nxWAcD1OE1XE/
         rLijqqjYLC94TtRkv6c126PQQh7k9t1MvLpavRIxeEryvCgQ5D8K3lmYpsqeoZl5CO
         4AlE1hGxWDx0Q==
X-Nifty-SrcIP: [209.85.221.180]
Received: by mail-vk1-f180.google.com with SMTP id v70so1966735vkv.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 05:55:17 -0800 (PST)
X-Gm-Message-State: AGRZ1gKlkycd3TlP5ghqZVgNw7yR7ylcY3qEtI1J93PPkoUVvVtcli2K
        MgBWQv8SJSY7O5oISvy77+8v3YJtDLF6JWRsM1c=
X-Google-Smtp-Source: AJdET5cDeQBndd+M9SQzGz1Ll7GgdShkkDggUVIRtiVnMaDl5XM9xMCWxh1rovoepiYx3mk5MQLa5SNfEnbt4cBCVes=
X-Received: by 2002:a1f:5e47:: with SMTP id s68mr411096vkb.64.1542030916756;
 Mon, 12 Nov 2018 05:55:16 -0800 (PST)
MIME-Version: 1.0
References: <1541992013-18657-1-git-send-email-yamada.masahiro@socionext.com> <CAGXu5j+Otsyy3g6BotjzAR3Ek1cTd8uspCqcR7-EpqPJ5xHawA@mail.gmail.com>
In-Reply-To: <CAGXu5j+Otsyy3g6BotjzAR3Ek1cTd8uspCqcR7-EpqPJ5xHawA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 12 Nov 2018 22:54:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8OCO8roYjS8w0_yoUmyUrEZBtnLe_D9y7qNwtGGbNUg@mail.gmail.com>
Message-ID: <CAK7LNAS8OCO8roYjS8w0_yoUmyUrEZBtnLe_D9y7qNwtGGbNUg@mail.gmail.com>
Subject: Re: [PATCH] x86: remove gcc-x86_*-has-stack-protector.sh checks
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sven Joachim <svenjoac@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 5:29 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, Nov 11, 2018 at 9:06 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > gcc-x86_64-has-stack-protector.sh was introduced by commit 4f7fd4d7a791
> > ("[PATCH] Add the -fstack-protector option to the CFLAGS") in 2006
> > to work around buggy compilers.
> >
> > gcc-x86_32-has-stack-protector.sh was introduced by commit 60a5317ff0f4
> > ("x86: implement x86_32 stack protector"), which did not clearly state
> > whether compilers were still producing broken code at that time.
> >
> > Now, the minimum reuquired GCC version is 4.6, which was released in
> > 2011. Probably, we can dump these old compiler checks.
>
> NAK. We need to keep this because we've seen recent regressions with
> stack protection (e.g. gcc briefly used global instead of tls for the
> canary, which silently broke the use of stack protectors). Since the
> gcc/kernel "API" for the canary is so fragile we need to keep these
> tests to make sure things end up where they're expected.

Thanks for your feedback.

I did not know this is still fragile even after ten years time.

One more curious thing is, x86 is the only arch ever
that has had this kind of script check.



-- 
Best Regards
Masahiro Yamada
