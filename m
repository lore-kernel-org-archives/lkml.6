Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D44C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFB9208CD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHWT3lgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbeLNT7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:59:44 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44201 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730493AbeLNT7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 14:59:44 -0500
Received: by mail-qt1-f196.google.com with SMTP id n32so7524159qte.11;
        Fri, 14 Dec 2018 11:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uBatSFJx1CXJz26gK6EMaGD2mkvDz+TFKUHFbJTmjOk=;
        b=nHWT3lgCCcZu5AnU2hGBlw1pHcKfjS/BXwn8GvyplUm/PfQFrKr3Qge2DwdpHY/qnl
         yiXzscoqiwyMNukkMyVrrXvfeKNCQC5JTWHSgEGTdpYkepI7GyYjiuNXl170vuI3Mq6m
         ENeh28qvo0EKDeipeDKNBasmb3b5Rdj35j2TnC7t7FT9MFqjR9q/yepiGSotkRfC4d6H
         pQ2qAhvUPko+1WSwu3+vpcrzMhrpqsxQrw4nk1ovtKuwVrcHi8vX9MgS5OJvtmiz7jUk
         bhOnyRKFvXXanvj/TKcPykKIeDBICffdn9XrpPqPmoa9MC5CDW9Rya2seB5ZJnrIGzBS
         GZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uBatSFJx1CXJz26gK6EMaGD2mkvDz+TFKUHFbJTmjOk=;
        b=U01ys0HU+mPAXLlAsJtsVosLnPRZNT7JrWc484rpdUG4ThnXw46Iz8aeXY3js3CxlY
         3cT6b4KGQdpiJeS0cab78+PVNml8DFPZyw6O7BWDPkfY1/BOBKuyGAOVUfi6km1fscSk
         Y/ZrAngetRXfjaPpAg41ve0d3klOtOq4U0O5NH7kXLcLqELDQpuYnAD2QTiKvIzHowOo
         9X0ED+g3Jd3gRe9qUDeIx3EaETMHWyuU2D933A5VVrVZ/4v47WwB9KcPQjgkTcNatpyd
         LWwPybWoKbQiccj6nJrmcP2CMLVxmj97r++bm/aZexKaaOfhJO0mcTOL6hiIQ6dlIb6W
         OxGg==
X-Gm-Message-State: AA+aEWb02Ym/vhuNb1MZmdvWXqws+XcqLvTcEZbZl+21F2uP/280ZLz/
        M8F9iITWo6ZxUmc27k4TLylukICDyEuzZSvB+ig=
X-Google-Smtp-Source: AFSGD/XKx2hxYh9Jd89S4zNz3nIW4OIwjYo5Zy9vItTUOKrGMOQub4LHrwB8PgsRSS9RQNzW2Tus+s+R4BVllute8es=
X-Received: by 2002:ac8:839:: with SMTP id u54mr4249224qth.313.1544817583218;
 Fri, 14 Dec 2018 11:59:43 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <70bb54b2-8ed3-b5ee-c02d-6ef66c4f27eb@physik.fu-berlin.de>
 <20181213160242.GV23599@brightrain.aerifal.cx> <c8987b31-ed79-acef-a300-31ebf2c29d2e@petrovitsch.priv.at>
 <20181214161732.GY23599@brightrain.aerifal.cx> <87mup8gj1y.fsf@oldenburg2.str.redhat.com>
 <20181214165535.GZ23599@brightrain.aerifal.cx> <EC1F028D-4382-41D6-B539-A9662FD53820@amacapital.net>
In-Reply-To: <EC1F028D-4382-41D6-B539-A9662FD53820@amacapital.net>
From:   Lance Richardson <lance.richardson.net@gmail.com>
Date:   Fri, 14 Dec 2018 14:59:32 -0500
Message-ID: <CAPmeqMoqNO2ps5tnGJX+Q7BgjdPKHt_vb3h+hDXC4=yth+r+dA@mail.gmail.com>
Subject: Re: Can we drop upstream Linux x32 support?
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Rich Felker <dalias@libc.org>, Florian Weimer <fweimer@redhat.com>,
        Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Mike Frysinger <vapier@gentoo.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, x32@buildd.debian.org,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My impression is it was mostly a desire to reuse existing x86_64 system cal=
ls
as much as possible without modification or additional compat layer work.

The 64-bit time requirement seems to have come from an lkml discussion, whi=
ch
has quite a bit of interesting background about x32:
    https://lkml.org/lkml/2011/8/26/415
    https://lkml.org/lkml/2011/8/26/453


On Fri, Dec 14, 2018 at 2:05 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
>
>
> > On Dec 14, 2018, at 8:55 AM, Rich Felker <dalias@libc.org> wrote:
> >
> >> On Fri, Dec 14, 2018 at 05:38:33PM +0100, Florian Weimer wrote:
> >> * Rich Felker:
> >>
> >>> This is all useless (and wrong since tv_nsec is required to have type
> >>> long as part of C and POSIX, regardless of ILP32-vs-LP64; that's a bu=
g
> >>> in glibc's x32).
> >>
> >> We should be able to fix standards if they prove unworkable in practic=
e.
> >> In my opinion, if standards require complex solutions where an obvious
> >> and simple solution exists, then standards are wrong.
> >
> > The requirement doesn't mandate complex solutions. There's nothing
> > complex about tv_nsec being long. long is the smallest type that C
> > guarantees to be large enough to store the range of values, which is
> > forever fixed and can't grow (because the definition of "nano" prefix
> > is fixed :). The type has been long ever since the structure was
> > introduced, and its being long means that there's lots of (correct!)
> > code using %ld (e.g. ".%.9ld" to format results as a decimal without
> > using floating point approximations) to print it. There might also be
> > code taking pointers to it to pass to functions, etc.
> >
> > The only reason a "complex" need arises is that Linux did something
> > horribly wrong here, ignoring the specified type, when introducing an
> > obscure subarch that almost nobody uses. This kind of mistake is
> > becoming a theme in Linux (see also: msghdr). Application authors
> > should not have to pay the price for fixing this by retrofitting yet
> > another silly type like "snseconds_t" or something into programs to
> > accommodate the mistakes of x32.
> >
> >
>
> Does anyone know *why* Linux=E2=80=99s x32 has __kernel_long_t defined as=
 long long?  I assume that this is where this bug, and most of the other bu=
gs, came from.
>
> This may be silly, but the kernel could plausibly add a x32v2 where long =
is genuinely 32-bit, and then maybe we could drop the old x32 at some point=
.  From all the discussion so far, it seems like there really is some deman=
d for ILP32, but it=E2=80=99s still not really clear that preserving compat=
ibility with existing x32 binaries in the long run is critical.
