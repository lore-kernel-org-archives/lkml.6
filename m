Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8E3C4151A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA862218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rYm3pwTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfBGAPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 19:15:12 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44078 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfBGAPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 19:15:12 -0500
Received: by mail-pl1-f194.google.com with SMTP id p4so3906359plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 16:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yje4amOcq5mO6LIgG8ElJEar7nMZ/c/udNFZT9sHtWk=;
        b=rYm3pwTqyB/byqalgLbzHR4GMWJvAH+wWxmY/4wty0tnnkXuo+14gHxt+0AEmqRpCn
         IqdJwHRiUQbil/ooSUjvVCPvbayGMlHWEleuJiiVXYCiDKo+p5FK2Tt4NQNjq2Iy+cXy
         yXwnkdcNAnFcD+5y1PK1uo3+uD6VbWdgdNIo5IXSw/Wjg0HNLlvczFzufmBF/e1fn5PM
         zz2TT0bcLdl9gXca5zaSwyCMxzA2UsIKcG21OZVfOnQUTM0GiiwwyqIJdawGYyrsbC+X
         yn/OUTUCADZI5K46fFKQeQDXHAfIC+aBfT4byKC7b+/X12cr3dadoxXJsYpZm1iI/DMu
         sSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yje4amOcq5mO6LIgG8ElJEar7nMZ/c/udNFZT9sHtWk=;
        b=ldGHGgslIYrAMWp0kwNV/Nnl6wz0FG1YAa4J/A/lwyTt9hT340sgafasAUXJV+omrC
         fJMSRCRiKBh5GPOPHn3RNWKSZnxQao0tj6zWzNQWAZW170PRsdLKh9lUD/GG0Esm4ac/
         u8zxjdr+mRHwBnang5pFJo3eNy9Pr1XsJKxOhw9g5Wv0EsELN5Xm+TIwfILykBAOBsvO
         b/sPXou0ba4iBVtsRlV4IAGkvOGo4bRDDPohSDph5G7C8KO6Z2I7KxRMYVpN//B46BhM
         MyD3FSLbJqV03QtbcGMKbPCCQ5ORnLqz7F/XNUrJd3waLCnGDqFrABtyEkRa54/+nDSn
         YxCw==
X-Gm-Message-State: AHQUAua5+VReY9/ua8XGXEs0xtZ2lHmHMv0QK5Ix2psV7sN2tnyJRgpc
        RhErO6OGKmJX+3isyVdid2EOutb2lT31d0tLuCBe5A==
X-Google-Smtp-Source: AHgI3IaWcd2w98GkwBwvt/3LkH+xQt/k++85mYSNhzxzzSUvTRx5K5UsZtkpbMPo8U1IkJJgIQH/c6UZ02xAd2qa8DI=
X-Received: by 2002:a17:902:4464:: with SMTP id k91mr13673903pld.13.1549498510952;
 Wed, 06 Feb 2019 16:15:10 -0800 (PST)
MIME-Version: 1.0
References: <20190203192401.29170-1-linux@rasmusvillemoes.dk>
 <CAK7LNAQqHgLTJU1tBU+oU+1CrWBrDpnui=dQCrNpzW4N2R-Omw@mail.gmail.com> <e1e125b5-71b4-3694-d7d8-789dfef7a9f5@rasmusvillemoes.dk>
In-Reply-To: <e1e125b5-71b4-3694-d7d8-789dfef7a9f5@rasmusvillemoes.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 6 Feb 2019 16:14:55 -0800
Message-ID: <CAKwvOdn0ssTmUue3YVU_2VJKR=56X4j2JJxNAoZ6x3-inCwwhQ@mail.gmail.com>
Subject: Re: [PATCH] build_bug.h: add wrapper for _Static_assert
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 1:38 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 05/02/2019 09.05, Masahiro Yamada wrote:
> > On Mon, Feb 4, 2019 at 4:24 AM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> >> +#define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__,=
 #expr)
> >> +#define __static_assert(expr, msg, ...) _Static_assert(expr, "" msg "=
")
> >
> > What is the "" "" for?
>
> Good point. It's a leftover from when I had a fallback-implementation of
> _Static_assert for gcc < 4.6, where I wanted to ensure that the second
> argument was a string literal, even if my fallback implementation
> ignored that argument. Now it's actually a little harmful, because

I had assumed it was for the "optional" part of the error message,
since whether you pass a string error message or not, the C
preprocessor should join them all together?

>
> foobar.c:5:34: error: expected string literal before =E2=80=98expected=E2=
=80=99
>  static_assert(sizeof(long) =3D=3D 8, expected 64 bit machine);

Hopefully you'd put `expected` in double quotes?

Note: I'm _very_ happy to see this being added.  Once it's landed, I
too can think of some places that it would work better than
BUILD_BUG_ON().
--=20
Thanks,
~Nick Desaulniers
