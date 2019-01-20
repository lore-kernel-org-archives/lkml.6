Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B664BC61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 08:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD262084C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 08:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="DUlHyDdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbfATIcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 03:32:18 -0500
Received: from mail-vs1-f47.google.com ([209.85.217.47]:42110 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbfATIcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 03:32:17 -0500
Received: by mail-vs1-f47.google.com with SMTP id b74so10915189vsd.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 00:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vuGdsjMedZbRP27gfuWy7CNl4LFB73NmQrOD2muDJh8=;
        b=DUlHyDdvZdIPrufeMKyRsCp5G3yyAbT5hTj7iSXivI+bG4OXl47ttg9E3w8rcfGlZ5
         /8q/XRfNkFrcaw2XXBFJOJd7piGI0dTgikIzy5J5eRzxDg3EPCGf69He+ACXUeR0LUkb
         Vhl0EjXvegpZbX+WAbac7pPliSFU2V+HF0DvvsFUA1nNbcxeqllAgtTQL1HkAvNv+0dS
         VL8AnFB/Su52r4NNz0+0zHY1pl6Bs0C+BJL/Dv4J/ACyjagbRjobRpMbfFVNYB5+cHDk
         //79MvTpwpPEAmqk23hk8W31t+PqVVMbP34v0MWZGWKfvzjQjFJru0jbmfNMYLZzCka0
         CI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vuGdsjMedZbRP27gfuWy7CNl4LFB73NmQrOD2muDJh8=;
        b=BfiwpGZfRyXqEvJoLpH+kLCuqtnWD/qNoeofXOjWeO0Lr7BTs2uss024YENgHGH3ie
         mmAum7xKR5vvZRKtl01QJ7O26y8u5ZK6Vx+5n8miavOm+M/aphytb0Rz0f+o0JE9s3qm
         gcnKYDIJvDkT4dXfkUrhdMnYamDcgq553cJzJGoGs7/QxvAgf7OhL7DNUJWvZ8Q1yDyf
         VWNuLLtjK88xGVPaMLIGRE9vZbCw5kA52MfTAo4MIX3lBmIDcoo5Xz5NtAhZz+JC4sNF
         WtnW6mkxfQlXe5qH0HM1vvvfTEGi2WqwQlQYCAZV9DbcVmRIp7NcG52IQ3oWmvtI53gt
         5ntg==
X-Gm-Message-State: AJcUukd247UyDsYC0mBBuuknPkk1FnI6it7l9iUSxz1agsEiUHS1onxD
        dxT+lmEJqXSLweeB7KqIq633Kvlbm8GfrcBqkvjw9w==
X-Google-Smtp-Source: ALg8bN4c9hRDS7a2JyfJlrwg3DKLXNo3f/WK93NYRzdg5h19VeH0fgHX27x05VBwVRnxACeG22Yx0qlhWf2E2RlCqzc=
X-Received: by 2002:a67:99c2:: with SMTP id b185mr10078491vse.84.1547973135935;
 Sun, 20 Jan 2019 00:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20190119151450.26879-1-Florian.LaRoche@googlemail.com>
 <20190120000138.GI26876@brain-police> <CAHk-=wjKgJ-9ypvzq+CB_NKnRk6iAqFtgVPwSH17C5RqJoYF=A@mail.gmail.com>
In-Reply-To: <CAHk-=wjKgJ-9ypvzq+CB_NKnRk6iAqFtgVPwSH17C5RqJoYF=A@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Sun, 20 Jan 2019 09:31:39 +0100
Message-ID: <CAKv63uuf4e0arj9OvSLXRTxF9pUJUmbe7yApU0StF-B=BcbGZA@mail.gmail.com>
Subject: Re: fix int_sqrt() for very large numbers
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Florian La Roche <florian.laroche@googlemail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2019 at 04:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Jan 20, 2019 at 12:01 PM Will Deacon <will.deacon@arm.com> wrote:
> >
> > > @@ -52,7 +52,7 @@ u32 int_sqrt64(u64 x)
> > >       if (x <= ULONG_MAX)
> > >               return int_sqrt((unsigned long) x);
> > >
> > > -     m = 1ULL << (fls64(x) & ~1ULL);
> > > +     m = 1ULL << ((fls64(x) - 1) & ~1ULL);
> >
> > This just looks like a copy-paste error because there isn't an __fls64().
> > But I think your suggestion here is ok, given the previous check against
> > ULONG_MAX.
>
> Hmm. We probably *should* add a __fls64().
>
> There looks to be only one user of int_sqrt64(), and that one is
> confused. It does int_sqrt64() twice, but since the inner one will
> reduce the range to 32 bits, the outer one is just silly.

II have a usecase (mlx90632) where this calculation worked on arm64
(nexus), but not in normal 32-bit arm (beaglebone). I have tried going
with full u64 to u64, but I was persuaded that it is not necessary and
testing on black body (sensor range from 0 - 80 degrees) confirmed
that for my calculations u32/u64 is enough. Because of the testing
range (and keep in mind it is casted to signed after two sqrts) the
high bit might never affect my end result, but I needed precision, not
the range. Inside the function the b was 32bit on 32bit core, but I
needed it to be 64bit. To keep it similar to existing int_sqrt, I have
decided to just type all variables there to 64bit.

We have implementation of this with doubles (see datasheet) and I
ported it to integer on arm64. The end result was fairly similar
calculation (for within object tempearture range from 0-80), between
both.

> That one user also had better not be overflowing into the high bit -
> it uses "s64" as a type and does seem to use signed operatons, so high
> bit set really means negative. sqrt() returning something odd for a
> negative number wouldn't be all that odd in that context.
>
> But yes, our current int_sqrt64() does seem buggy as-is, because it's
> *supposed* to work on u64's, even if I don't think we really have any
> users that care.

I introduced strong types for existing int_sqrt implementation to keep
it aligned between 64bit and 32bit.

Best regards,
Crt

> And as Will mentioned, the regular int_sqrt() looks perfectly fine,
> and subtracting 1 from the __fls() return value would actually
> _introduce_ a bug.
>
>             Linus
