Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38D3C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24F720817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmoPyepk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24F720817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeK0BaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:30:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54473 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbeK0BaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:30:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id z18so3790185wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 06:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rs4puKBd5l///9yokUopQT1mdSsSbluxkXSk8De5g9M=;
        b=AmoPyepkaumCiRAqOfZeyDzy0KA82cjg7zzdzmT+nSnwAAklahcE5BEeEw75yJugu7
         mASmA8aEcZWAuFOXG1b5R0PdI7583FxX7BfDpISsd+FmsAeM3bgLFcOm+h6I1WUyv6Cs
         o4p6JKA2X2Qb36dWtozBrbLyQW9W4X96TExEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rs4puKBd5l///9yokUopQT1mdSsSbluxkXSk8De5g9M=;
        b=FPNQlJKyp786olMbDMnA/FA7oWNrzSTz7FghuVxDjnlWdw0djmAt7eBWY/I7Ar92vQ
         pSaqultqsLp8ae2fqczHEHun8vLKFvPZBKuo8Zxy4zDt3XolQEjsLvZd7izvl5asbG0c
         H5rgY3mGb8UyDqTY6FxZERda0vpS/7FDyXrQPw5iX+4gMC6i+J0tmGYpn9BBqie7hHyj
         FZFZhJYmZYail5CUxexDVQcHbUu6rJ3dDCjNOVYDwsPjVE8Iu9/ofEJaa67wjDgFBUvt
         dbrTqQBjfmUgQ7weZZ5JZTdYs34PGUO/kUxJ/64B7KkoTZKE5+KimWynIa0rtCRgjnWt
         Q14g==
X-Gm-Message-State: AGRZ1gKoGPIrGLkWjfJSi+Pp3VPrwal80pJT2anM63rbaXvA/rbrJqV7
        Fzu22PIGIl14kdW7S1wSFtKKrIaMIjD4S/D+SMDQ4g==
X-Google-Smtp-Source: AJdET5e6HRnWlaAx/bm7Hj3DLCPihZp/DqZ9Ft9yLv45vEWp2QiQREF310Ktj9CH7IC3p1t6JsnK7n3DhjkCoHDZ5u0=
X-Received: by 2002:a1c:3a07:: with SMTP id h7mr24590049wma.41.1543242947437;
 Mon, 26 Nov 2018 06:35:47 -0800 (PST)
MIME-Version: 1.0
References: <20181029200311.16947-1-semen.protsenko@linaro.org>
 <CAKaJLVvpNZW2a+3xc7PE0+iU1nm39A7PEjCu8F9ijrT+wEXOag@mail.gmail.com>
 <20181030063408.GA26627@kroah.com> <CAKaJLVtT+pFzOBjybAXmOC0mJyN=BHavsfAYEzgSWn-i7UYEjA@mail.gmail.com>
 <20181030130401.3ab5gl4fsvpa2fes@cs.cmu.edu> <CAHp75Vff1-z1Q7zgGNgUyDn5kA9fSdFA0o7y_yNih26cJj_csA@mail.gmail.com>
In-Reply-To: <CAHp75Vff1-z1Q7zgGNgUyDn5kA9fSdFA0o7y_yNih26cJj_csA@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 26 Nov 2018 16:35:36 +0200
Message-ID: <CAKaJLVtjP1Y2YgPPLbKyE2nJKT-B-ReDoC-gB2umpnm58KRaoQ@mail.gmail.com>
Subject: Re: [PATCH v2] codafs: Fix build using bare-metal toolchain
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-scsi@vger.kernel.org, Praneeth Bajjuri <praneeth@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu,
        Jan Harkes <jaharkes@cs.cmu.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy, btw, I'm observing some strange mail thread behavior here. I'm
pretty sure you responded to Jan, but he's not in the recipient list
in your last mail. If you check Jan's mail (the one you responded to),
you can notice new "reply-to" field (or "Mail-Followup-To:", in raw
mail). When you respond to his mail, you respond to that list. But Jan
is not in that list. That may be the cause of confusion we're seeing
here.

Anyway, mail settings aside, I'm glad this patch has found its way to
upstream. Thanks everyone.
On Fri, Nov 23, 2018 at 10:07 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Oct 30, 2018 at 3:04 PM Jan Harkes <jaharkes@cs.cmu.edu> wrote:
> >
> > On Tue, Oct 30, 2018 at 02:01:04PM +0200, Sam Protsenko wrote:
> > > On Tue, Oct 30, 2018 at 8:34 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > On Mon, Oct 29, 2018 at 10:05:49PM +0200, Sam Protsenko wrote:
> > > >> Hi Greg,
> > > >>
> > > >> On Mon, Oct 29, 2018 at 10:03 PM, Sam Protsenko
> > > >> <semen.protsenko@linaro.org> wrote:
> > > >> > The kernel is self-contained project and can be built with bare-metal
> > > >> > toolchain. But bare-metal toolchain doesn't define __linux__. Because of
> > > >> > this u_quad_t type is not defined when using bare-metal toolchain and
> > > >> > codafs build fails. This patch fixes it by defining u_quad_t type
> > > >> > unconditionally.
> > > >> >
> > > >> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > >> > ---
> > > >>
> > > >> Can you please pull this one, if this applicable? I sent it a while
> > > >> ago, but I guess it got lost in mailing list. It might be also
> > > >> applicable to stable branch (as it fixes allmodconfig build for ARM
> > > >> with bare-metal toolchain).
> > > >
> > > > Why are you asking me?  I'm not the maintainer of this file :(
> > > >
> > > > confused,
> > > >
> > >
> > > Sorry to bother you. I just thought you might be interested in this
> > > one, as it fixes build for "allmodconfig" configuration, hence it can
> > > be related to stable branch. Also, maintainers didn't respond to that
> > > patch, so I'm kinda dead in the water.
> > >
> > > Anyway, will try to ping maintainers one more time.
> >
> > I thought I had responded,
>
> Oh, this one also was in Spam.
>
> > I didn't see a reason why one would want to
> > compile non-userspace kernel headers outside of the context of the
> > kernel and if you do have to do that why not just add -D__linux__.
> >
> > However, I can also see the point that anything not in uapi/ pretty much
> > by definition will be compiled with __linux__ defined so it actually
> > doesn't make a discernable difference to just drop the ifdef and I'm
> > fine with a patch like this.
> >
> > These trivial patches typically get picked up through kernel janitors,
> > or maybe an akpm linux-next patch queue. In fact, I'm not even sure if
> > there is a designated person I would be passing updates to, I've sent
> > patches to akpm, viro, hellwig, linus, and gregkh at various times.
>
> % scripts/get_maintainer.pl -f include/linux/coda.h
> Jan Harkes <jaharkes@cs.cmu.edu> (maintainer:CODA FILE SYSTEM)
> coda@cs.cmu.edu (maintainer:CODA FILE SYSTEM)
> codalist@coda.cs.cmu.edu (open list:CODA FILE SYSTEM)
> linux-kernel@vger.kernel.org (open list)
>
> Aren't you a maintainer?
>
> --
> With Best Regards,
> Andy Shevchenko
