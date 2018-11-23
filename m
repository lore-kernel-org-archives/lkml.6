Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2C0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8FA20824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdv6HpGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8FA20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395453AbeKXGxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 01:53:34 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41604 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbeKXGxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 01:53:34 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so11596817qto.8;
        Fri, 23 Nov 2018 12:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=19tzt73gyv+9yHhyNMOrMd4Cr9f9+QqN3Gx1YgZ+EoM=;
        b=kdv6HpGaPSytPaevKrCeMoi71rb4TFMkedVcVriNl6e9eOq3QnzCSJ1QuwTZWAA3ns
         eqTw3trDa0dl7143nPNlnTSHC3SJUfccqXffHy6ADGUwiYGi1I6RENqCVS1FeSFUE9OE
         70yY7N48iUJwzTFxfBFshSYtZ2zfsFBeyP/zZdh7HCVWW0S5Kpw/8rI0+56Y2z+yAs7S
         SuDXPQm1OUIfjMjyAxQ3U+2Mkh2LpYmFB5VWWlaxCT3aly+YrGjBg9LGFzHv5XbBp3C0
         wgMY++aWXJU02TAapq6JQJ4g5JOwijJgGw3QQLg2Ne7RxJxHSG3dzgNO0iVVPUmjCfRm
         /lDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=19tzt73gyv+9yHhyNMOrMd4Cr9f9+QqN3Gx1YgZ+EoM=;
        b=FI+gDR0Gi9Y+e6KahMuqICUeXLSa04StUE2i7Sth2xLghxjeYh8ZxwK/PFJw0qrWKv
         oqzsCvsipNN1R4phhsCfddqk86uM11kVGeQGCSgiO4nVJjALtDjazWA1FR6bS1slzq+D
         LnOuR/X0mVPgnhFULBJTVaVW7b7eFeiDMy4Hj2jJmG/GJmUn5qGCEG9kMpbqUCoNqFht
         amQVb5UC2Xq1MFswZHVLVt3E4SQL21SU0TBAcfvIUvM4lvQkYxa3SA3xi0uZqVDab7ew
         dm1BQNlyPKw2Unon8q1NuPK6N6AZLWMnE0c7B3X7hi87u8Z4jMosPrijrQLYNN9npNWT
         ADZA==
X-Gm-Message-State: AGRZ1gJXqHIkCEQxjvqtUDTdVR7ScXhU+6tDaT0hyzxh/YYiBMBoB17+
        o1VWPq6ZIkDGNn4jOXlHsV3aVjfqSauPKRfWALk=
X-Google-Smtp-Source: AJdET5erRDY1M3lLevtM5fuWlBA/QAt3N7GADPNePLmjSzKp+x1WvuDEH7ZZosFP53ypOZ78OwY87mhXUEVptpbmUpM=
X-Received: by 2002:aed:2d26:: with SMTP id h35mr16147509qtd.373.1543003670809;
 Fri, 23 Nov 2018 12:07:50 -0800 (PST)
MIME-Version: 1.0
References: <20181029200311.16947-1-semen.protsenko@linaro.org>
 <CAKaJLVvpNZW2a+3xc7PE0+iU1nm39A7PEjCu8F9ijrT+wEXOag@mail.gmail.com>
 <20181030063408.GA26627@kroah.com> <CAKaJLVtT+pFzOBjybAXmOC0mJyN=BHavsfAYEzgSWn-i7UYEjA@mail.gmail.com>
 <20181030130401.3ab5gl4fsvpa2fes@cs.cmu.edu>
In-Reply-To: <20181030130401.3ab5gl4fsvpa2fes@cs.cmu.edu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 23 Nov 2018 22:07:39 +0200
Message-ID: <CAHp75Vff1-z1Q7zgGNgUyDn5kA9fSdFA0o7y_yNih26cJj_csA@mail.gmail.com>
Subject: Re: [PATCH v2] codafs: Fix build using bare-metal toolchain
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 3:04 PM Jan Harkes <jaharkes@cs.cmu.edu> wrote:
>
> On Tue, Oct 30, 2018 at 02:01:04PM +0200, Sam Protsenko wrote:
> > On Tue, Oct 30, 2018 at 8:34 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > On Mon, Oct 29, 2018 at 10:05:49PM +0200, Sam Protsenko wrote:
> > >> Hi Greg,
> > >>
> > >> On Mon, Oct 29, 2018 at 10:03 PM, Sam Protsenko
> > >> <semen.protsenko@linaro.org> wrote:
> > >> > The kernel is self-contained project and can be built with bare-metal
> > >> > toolchain. But bare-metal toolchain doesn't define __linux__. Because of
> > >> > this u_quad_t type is not defined when using bare-metal toolchain and
> > >> > codafs build fails. This patch fixes it by defining u_quad_t type
> > >> > unconditionally.
> > >> >
> > >> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > >> > ---
> > >>
> > >> Can you please pull this one, if this applicable? I sent it a while
> > >> ago, but I guess it got lost in mailing list. It might be also
> > >> applicable to stable branch (as it fixes allmodconfig build for ARM
> > >> with bare-metal toolchain).
> > >
> > > Why are you asking me?  I'm not the maintainer of this file :(
> > >
> > > confused,
> > >
> >
> > Sorry to bother you. I just thought you might be interested in this
> > one, as it fixes build for "allmodconfig" configuration, hence it can
> > be related to stable branch. Also, maintainers didn't respond to that
> > patch, so I'm kinda dead in the water.
> >
> > Anyway, will try to ping maintainers one more time.
>
> I thought I had responded,

Oh, this one also was in Spam.

> I didn't see a reason why one would want to
> compile non-userspace kernel headers outside of the context of the
> kernel and if you do have to do that why not just add -D__linux__.
>
> However, I can also see the point that anything not in uapi/ pretty much
> by definition will be compiled with __linux__ defined so it actually
> doesn't make a discernable difference to just drop the ifdef and I'm
> fine with a patch like this.
>
> These trivial patches typically get picked up through kernel janitors,
> or maybe an akpm linux-next patch queue. In fact, I'm not even sure if
> there is a designated person I would be passing updates to, I've sent
> patches to akpm, viro, hellwig, linus, and gregkh at various times.

% scripts/get_maintainer.pl -f include/linux/coda.h
Jan Harkes <jaharkes@cs.cmu.edu> (maintainer:CODA FILE SYSTEM)
coda@cs.cmu.edu (maintainer:CODA FILE SYSTEM)
codalist@coda.cs.cmu.edu (open list:CODA FILE SYSTEM)
linux-kernel@vger.kernel.org (open list)

Aren't you a maintainer?

-- 
With Best Regards,
Andy Shevchenko
