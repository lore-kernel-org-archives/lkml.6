Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5B1C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 09:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312092084F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 09:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="F9ysS8TT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbfATJaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 04:30:30 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:38559 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfATJaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 04:30:30 -0500
Received: by mail-vk1-f193.google.com with SMTP id w72so3999243vkd.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 01:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L7zq7IkVJhTeHbp5/18+VfTyk7rsexVWEViIdV2skzw=;
        b=F9ysS8TTNfGCItBrINSNwSgZr8HMiTiBnhuhsbAFPI4cm1IhzyidsnS3lW8vahUXtj
         uwIq3B5exHoPhRO1Tt3P/7F4qzbXMXOEzatrFcYT4wnFsKwGwUIEmf/svBF8zAYve0Lf
         bvUCfQSgXGsb1/yOlDxhcLFI2cy3Ly0rbHbIA3MMvIlIgdk+b04mGI3LLRP5y0mGtyxm
         nQbCTK1TetPq3xOoqPjkITpeg0z24FleO8TWKowdkU61S9IXcL7DnYkyEtGJwOQ7dP3S
         TJymSwq+ZF+BhBEVBX8Lnt/qpKTXY3y/MbORdOntLotpdZ5b4o2UCwKf0MRbeM0LYfjH
         eR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L7zq7IkVJhTeHbp5/18+VfTyk7rsexVWEViIdV2skzw=;
        b=ZqbZ9EpNWFN2vijcDGl+6+uPhlYf7dRJyZVZP7yjP4BTeqZvBZOJ8BXUUCW6gyW1eR
         s/mSo/wwBUVisumc0DfkIdU3674BLIcuuQoxPLjiuvEQ/4azwBekw2jpWAsPEs4KnrEl
         LpMvvDHhJxLtTyExJhEFG3UTus/SCuV1qj1nlWPIAryK9Pi0IknuAmPlDpkOFuKvz20G
         mJuBRFPj+mC9QPzan5LLERORHNdE3AIigHwbYAfRjnJ4TdG7lIe2Ps7aqKQjGtiHPmJU
         TA0MPDi/koij7OZ48Xv+lVz46a33RmzdLlkMZKitU0KprPo9EkvkAlBoPgj/tKRSGI7u
         qBkA==
X-Gm-Message-State: AJcUukeWI1c6TwfCSQJK05V5bp0P6Xpc/51TnxAmVHAubuGZdb/jA26A
        A+8qM7ZG9Zgp54cvUDcxGIiGS8upeBF+30mDvOuy2g==
X-Google-Smtp-Source: ALg8bN6dMHcUChks+e6lQcJOyW5F2t+LJC08RR6BYN+x+m+xFRzheBQllsExTTdRJmcuxZEhdvVkx9MEEsUJurRj6NE=
X-Received: by 2002:a1f:1d41:: with SMTP id d62mr10037172vkd.25.1547976628235;
 Sun, 20 Jan 2019 01:30:28 -0800 (PST)
MIME-Version: 1.0
References: <20190119151450.26879-1-Florian.LaRoche@googlemail.com>
 <20190120000138.GI26876@brain-police> <CAHk-=wjKgJ-9ypvzq+CB_NKnRk6iAqFtgVPwSH17C5RqJoYF=A@mail.gmail.com>
 <CAKv63uuf4e0arj9OvSLXRTxF9pUJUmbe7yApU0StF-B=BcbGZA@mail.gmail.com>
In-Reply-To: <CAKv63uuf4e0arj9OvSLXRTxF9pUJUmbe7yApU0StF-B=BcbGZA@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Sun, 20 Jan 2019 10:29:52 +0100
Message-ID: <CAKv63utKUuXTBT44anBT17-O4puzJsesHmAOFPDN=qFPjzPGTQ@mail.gmail.com>
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

On Sun, 20 Jan 2019 at 09:31, Crt Mori <cmo@melexis.com> wrote:
>
> On Sun, 20 Jan 2019 at 04:49, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sun, Jan 20, 2019 at 12:01 PM Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > > @@ -52,7 +52,7 @@ u32 int_sqrt64(u64 x)
> > > >       if (x <= ULONG_MAX)
> > > >               return int_sqrt((unsigned long) x);
> > > >
> > > > -     m = 1ULL << (fls64(x) & ~1ULL);
> > > > +     m = 1ULL << ((fls64(x) - 1) & ~1ULL);
> > >
> > > This just looks like a copy-paste error because there isn't an __fls64().
> > > But I think your suggestion here is ok, given the previous check against
> > > ULONG_MAX.
> >
> > Hmm. We probably *should* add a __fls64().
> >
> > There looks to be only one user of int_sqrt64(), and that one is
> > confused. It does int_sqrt64() twice, but since the inner one will
> > reduce the range to 32 bits, the outer one is just silly.
>
> II have a usecase (mlx90632) where this calculation worked on arm64
> (nexus), but not in normal 32-bit arm (beaglebone). I have tried going
> with full u64 to u64, but I was persuaded that it is not necessary and
> testing on black body (sensor range from 0 - 80 degrees) confirmed
> that for my calculations u32/u64 is enough. Because of the testing

I have just re-read the patch submit discussion and a sqrt of 64bit
number can never be more than 32bit. That is why u32 return value is
enough. But I do not clearly remember if I tested with outside
int_sqrt (insted int_sqrt64). We still have everything, so I could
test if that is the suggestion.

> range (and keep in mind it is casted to signed after two sqrts) the
> high bit might never affect my end result, but I needed precision, not
> the range. Inside the function the b was 32bit on 32bit core, but I
> needed it to be 64bit. To keep it similar to existing int_sqrt, I have
> decided to just type all variables there to 64bit.
>
> We have implementation of this with doubles (see datasheet) and I
> ported it to integer on arm64. The end result was fairly similar
> calculation (for within object tempearture range from 0-80), between
> both.
>
> > That one user also had better not be overflowing into the high bit -
> > it uses "s64" as a type and does seem to use signed operatons, so high
> > bit set really means negative. sqrt() returning something odd for a
> > negative number wouldn't be all that odd in that context.
> >
> > But yes, our current int_sqrt64() does seem buggy as-is, because it's
> > *supposed* to work on u64's, even if I don't think we really have any
> > users that care.
>
> I introduced strong types for existing int_sqrt implementation to keep
> it aligned between 64bit and 32bit.
>
> Best regards,
> Crt
>
> > And as Will mentioned, the regular int_sqrt() looks perfectly fine,
> > and subtracting 1 from the __fls() return value would actually
> > _introduce_ a bug.
> >
> >             Linus
