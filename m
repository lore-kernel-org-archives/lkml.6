Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3BEC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 21:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54CD222CD
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 21:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aLv2aXvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfAEVyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 16:54:24 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:47037 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfAEVyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 16:54:24 -0500
Received: by mail-lf1-f66.google.com with SMTP id y14so8731164lfg.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 13:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+1ou9Ablj7aPz54GczAfBZDoTjLzri1LRQMpX+g56pk=;
        b=aLv2aXvuQ2PcnOES4bn3an92ZWFwet2D8xWSCbWkNHh0ScTlLJjUThLCdtqbEwdzdq
         KwMAljejKSH453sW9kRjuoDOKAO+SJ9pEZzB2L0igqHXwWwGHe0+QdjWIuFF/3H43T1S
         OQj3p5p+5O3bs8MJLbC8JhX9XV5Puwstpxp0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1ou9Ablj7aPz54GczAfBZDoTjLzri1LRQMpX+g56pk=;
        b=TQ7EShg/hL7j33D7KcnGjIya8+F5AHLKSQdoO60CA22qkzYSU8TdLWtQW4R30RM/P6
         bA4+q90TdMgPSHPcWqRMOlqFmMX9/U5+djEY5CZPrwp915z0nez0GaGZ3YDaI3ljYPs5
         GgRGJTOEHqiIttf2zrFL/rjhy6ZXHh7i6VEFrzU5RxVyXdLHCXfVLhxfOAsOenucbv1X
         xTCE0O5iaxy1ZETPPke5ag6uycyjvyHV3xrAeM69+eDJVOZ5PiI+z/ChZ7FEyqgHkTUW
         X4EYX6a1z8LNekGTcuOdnTuUwOlfWtpwH2tOwPKeJ0gtNroE6vcVVBghF9J18Z0XDzAg
         d1IQ==
X-Gm-Message-State: AA+aEWZgWpi83LEXoFVxatkt/9L7IDvZqz6xUYTRf+fRi5Kd+0MGDMoR
        Jo8Xa04psrjYMK4pD/uXCEsS+H7LV9Y=
X-Google-Smtp-Source: AFSGD/VOeealcQy3kSRMjmXUYOElzKD9xjeFu/iO51UQGswF7syl8O1wIpo7LEW2nPHemfnm6o9+tw==
X-Received: by 2002:a19:ee08:: with SMTP id g8mr28957882lfb.72.1546725261748;
        Sat, 05 Jan 2019 13:54:21 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id q21-v6sm12936082ljc.5.2019.01.05.13.54.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 13:54:20 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id v1-v6so35240530ljd.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 13:54:20 -0800 (PST)
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr24066633ljj.120.1546725259853;
 Sat, 05 Jan 2019 13:54:19 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <CAHk-=wicks2BEwm1BhdvEj_P3yawmvQuG3NOnjhdrUDEtTGizw@mail.gmail.com>
 <nycvar.YFH.7.76.1901052108390.16954@cbobk.fhfr.pm> <CAHk-=whGmE4QVr6NbgHnrVGVENfM3s1y6GNbsfh8PcOg=6bpqw@mail.gmail.com>
 <nycvar.YFH.7.76.1901052131480.16954@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1901052131480.16954@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jan 2019 13:54:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgrSKyN23yp-npq6+J-4pGqbzxb3mJ183PryjHw7PWDyA@mail.gmail.com>
Message-ID: <CAHk-=wgrSKyN23yp-npq6+J-4pGqbzxb3mJ183PryjHw7PWDyA@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Jiri Kosina <jikos@kernel.org>, Masatake YAMATO <yamato@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 12:43 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> > Who actually _uses_ mincore()? That's probably the best guide to what
> > we should do. Maybe they open the file read-only even if they are the
> > owner, and we really should look at file ownership instead.
>
> Yeah, well
>
>         https://codesearch.debian.net/search?q=mincore
>
> is a bit too much mess to get some idea quickly I am afraid.

Yeah, heh.

And the first hit is 'fincore', which probably nobody cares about
anyway, but it does

    fd = open (name, O_RDONLY)
    ..
    mmap(window, len, PROT_NONE, MAP_PRIVATE, ..

so if we want to keep that working, we'd really need to actually check
file ownership rather than just looking at f_mode.

But I don't know if anybody *uses* and cares about fincore, and it's
particularly questionable for non-root users.

And the Android go runtime code seems to oddly use mincore to figure
out page size:

  // try using mincore to detect the physical page size.
  // mincore should return EINVAL when address is not a multiple of
system page size.

which is all kinds of odd, but whatever.. Why mincore, rather than
something sane and obvious like mmap? Don't ask me...

Anyway, the Debian code search just results in mostly non-present
stuff. It's sad that google code search is no more. It was great for
exactly these kinds of questions.

The mono runtime seems to have some mono_pages_not_faulted() function,
but I don't know if people use it for file mappings, and I couldn't
find any interesting users of it.

I didn't find anything that seems to really care, but I gave up after
a few pages of really boring stuff.

                    Linus
