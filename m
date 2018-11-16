Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DED4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545F92086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXi1bkRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545F92086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeKQGus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:50:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33653 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbeKQGus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:50:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id f19-v6so1734636wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 12:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jym+GiPGYUZbhE7huk9vGUGKNcCOgVAuuLAZaTJxr8w=;
        b=fXi1bkRDUPmGu5/qBpNYfXoUC57UN+cieUa8Z/CA53QSssmiJvAyYz3Qc1sVqtpk/d
         rgRxqCWTrAaiCzdFQQ+rXgjXX7kole+QGUo2lqh/4YA1H2EUAgmYrHhmFyRo+dzT5UXH
         vr3aa4CdN4VZhJD3oS5Ft27fWH271f3FeR9kWSaYH6eVNOsMbln0i9Jhdxd2gK3Bg/pA
         S0XVc6u00IRswimYOUQbFzmx0wRveRAPoZauPXmEmURTUGEXhvTmdLwPknWY5b27SwXi
         t981y4bLo878pvODfyCQT1Psl3NT2nh0bs8ly9Yo6a4EwLzh2+w7w4MFU7XzrqR3UR6Z
         qi7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jym+GiPGYUZbhE7huk9vGUGKNcCOgVAuuLAZaTJxr8w=;
        b=X5sW5zAq+gL6j6DBaWVDa7WjHqH/47cdR6UIhAcJAKc5MNc8yM6RT4XK2dXGCsYSsy
         cQPr092QgTTADonJdPRp7tKCGShd9dAk544QKFmTE9ewUHcNuHDtbmBRW3PsXKgLCkDi
         oCaTkXc2GfgRgVZIXfhwxe3iIDuCvuFdM6Z9smimjjIrjCU6mZklTxRXKcnZqvtUArQz
         fva8PpCZy4MDDLajgCdnCbmlOE5Pw+zwl5Br9N6HFIWeTcXC3tQMqTdq+As/b4CXPg8U
         IH3aAJKPtxezwHWxDYOgcw7KcQbPFQXgbBRsE9CH1T2h2e+pj84r22k3vQ4oHOxz7tnV
         TKRQ==
X-Gm-Message-State: AGRZ1gKfO1Ju2pYpcYiBQzhfnGfwSUNK4HgPadpJPFan+Ys/Jb3mtJvc
        X1avs7RJzlOkWTp/bK+2XIAb+BIa/yVYu5NC6xcK4BZf
X-Google-Smtp-Source: AJdET5cnatSIFAZbGoaIPsMhw9UHk+dCKEo4r/ucl6Utqh87fGBIFBbKhFRUdU36Vqn2El/n+c2T/2NYNqDGUSEm93w=
X-Received: by 2002:a1c:ac85:: with SMTP id v127mr9392689wme.62.1542400612180;
 Fri, 16 Nov 2018 12:36:52 -0800 (PST)
MIME-Version: 1.0
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAMuHMdVOJsM=66RrnbOzVthsT9=dFRQtL2rv99tCPC02M=hiXw@mail.gmail.com>
 <20181115061036.1575223d@silica.lan> <20181115162008.GO3759@mtr-leonro.mtl.com>
In-Reply-To: <20181115162008.GO3759@mtr-leonro.mtl.com>
From:   Rodrigo Vivi <rodrigo.vivi@gmail.com>
Date:   Fri, 16 Nov 2018 12:36:40 -0800
Message-ID: <CABVU7+twSz3OZx7PTO+bS-wfLfTTjZVhRAnhgtcs6KWwntattw@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [RFC PATCH 3/3] libnvdimm, MAINTAINERS:
 Subsystem Profile
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        dave.jiang@intel.com, ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org, vishal.l.verma@intel.com,
        linux-kernel@vger.kernel.org, zwisler@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 8:38 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Nov 15, 2018 at 06:10:36AM -0800, Mauro Carvalho Chehab wrote:
> > Em Thu, 15 Nov 2018 09:03:11 +0100
> > Geert Uytterhoeven <geert@linux-m68k.org> escreveu:
> >
> > > Hi Dan,
> > >
> > > On Thu, Nov 15, 2018 at 6:06 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > > Document the basic policies of the libnvdimm subsystem and provide a
> > > > first example of a Subsystem Profile for others to duplicate and edit.
> > > >
> > > > Cc: Ross Zwisler <zwisler@kernel.org>
> > > > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > >
> > > Thanks for your patch!
> > >
> > > > --- /dev/null
> > > > +++ b/Documentation/nvdimm/subsystem-profile.rst
> > >
> > > > +Trusted Reviewers
> > > > +-----------------
> > > > +Johannes Thumshirn
> > > > +Toshi Kani
> > > > +Jeff Moyer
> > > > +Robert Elliott
> > >
> > > Don't you want to add email addresses?
> > > Only the first one is listed in MAINTAINERS.
> >
> > IMO, it makes sense to have their e-mails here, in a way that it could
> > easily be parsed by get_maintainers.pl.
>
> I personally think that list of "trusted reviewers" makes more harm than
> good. It creates unneeded negative feelings to those who wanted to be in
> this list, but for any reason they don't. Those reviewers will feel
> "untrusted".

I'd like to +1 on this concern here. Besides leaving all the other
people demotivated.

A small group of trusted reviewers doesn't scale. People will get overloaded.
Or you won't be able to enforce that all patches need to get Reviews.

Reviews should be coming from everywhere and commiters and maintainers
deciding on what to trust or re-review.

Also the list is hard to maintain and keep the lists updated.

>
> Thanks
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss



-- 
Rodrigo Vivi
Blog: http://blog.vivi.eng.br
