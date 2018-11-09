Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C143C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B821220855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUmBgpw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B821220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbeKIUVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:21:07 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43725 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeKIUVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:21:07 -0500
Received: by mail-qk1-f196.google.com with SMTP id r71so719327qkr.10;
        Fri, 09 Nov 2018 02:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1U26R17OTDPgCqGJgtXdyJ7eIGa/4FbKsptt8VlSw8=;
        b=TUmBgpw7BGNV0wK6vQC+jauudsESLQ90gMfF75ylasslwwRkWj150AongexEDCG1as
         GALW+eeFZxqMlGZNk4SUvliDuVO8TklhG8USOni7Wzn01JmIyxqSPgnVdcJsAvxYT/dx
         dLnQ9c6JcQAgDVJ5UuKRxT/lvv9s+cz5VEnG4NAGxJrIZPk+YBxVgJpRk5S9K7WRsKIa
         2ZE7pSBslShKtUCSaVPnpNsuvZ4VbYKJlUlMaLxYLmQJDk6UrAzx+yRPpp36lIYHEuMx
         E/7KWuA9gdRpPE7x2NI9SQJjSIA5GfxBemJ64wTU1Gth77v0i73pG6j/9oD2j5QvoI8+
         BnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1U26R17OTDPgCqGJgtXdyJ7eIGa/4FbKsptt8VlSw8=;
        b=Zc0rUvj00ZK2rBVEz4+8VLzf5U4cFwC9T5TkBIUUg4sm67McWMLUGRLbHnuNSvgR19
         H3XVzw0DnsdCkLkkD2sDNT3BnSKFVaSditMd/acTdXuetkcTZRSaW4BnXXbjyW54utw2
         uVFeJLXiix06rECYF1ougwakEsq5r9oGKd/l6kt3KXj4GAuZ6Z6CrRm6mz5pLvJwAmg6
         aXBLQLD/aEVjKP5s4+gDEwT0ZgWT2SPPW3zZQtkX6MpgMXzxuGIBA7KcyDZN9eEChGo6
         8bfjr/qYFiY+ZO9v4aTz1VQQ6FVepW7XM1XDpZJWVhXYkJnCRAm5xiEIvKjYVodh1dqn
         WTTQ==
X-Gm-Message-State: AGRZ1gKecyY1QI61vbRy9zs6pWOhmiv01Mx4euPt86VZMnu4QWOYMq4w
        gICMXxxICSPqjVyatv2HLNuWTMuLDZ9tDS1MG5I=
X-Google-Smtp-Source: AJdET5cuSo8IR9T6gMDB41vtBHgH/Pzt7GETJQCedaUgVbhLaW7zDh5EqEQl9Xr4sNh+D/M5rcLBSB177diYibR+zxM=
X-Received: by 2002:a0c:b3c2:: with SMTP id b2mr33481qvf.138.1541760065361;
 Fri, 09 Nov 2018 02:41:05 -0800 (PST)
MIME-Version: 1.0
References: <20181108171701.4444-1-ayman.bagabas@gmail.com>
 <20181108171701.4444-2-ayman.bagabas@gmail.com> <CAHp75Vev_0ObO=KLHfON8JAco=a9MURycH9uk-a+h1JqrSSQFA@mail.gmail.com>
 <d3c913eb8854efbbf6b737cf94edc95179d58f59.camel@gmail.com>
In-Reply-To: <d3c913eb8854efbbf6b737cf94edc95179d58f59.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 9 Nov 2018 12:40:54 +0200
Message-ID: <CAHp75VeOixbKnYKyGCZ9_vJ-+X1M9FUYPZQsGOrAirkKYdbB2g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] x86: add support for Huawei WMI hotkeys.
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it does.
On Fri, Nov 9, 2018 at 5:52 AM <ayman.bagabas@gmail.com> wrote:
>
> On Thu, 2018-11-08 at 21:58 +0200, Andy Shevchenko wrote:
> > On Thu, Nov 8, 2018 at 7:17 PM Ayman Bagabas <ayman.bagabas@gmail.com
> > > wrote:
> > > This driver adds support for missing hotkeys on some Huawei
> > > laptops.
> > > Currently, only Huawei Matebook X and Matebook X Pro is supported.
> > >
> >
> > Thanks for an update, my comments below.
> >
> >
> > > +config HUAWEI_LAPTOP
> > > +       tristate "Huawei WMI hotkeys driver"
> > > +       depends on ACPI
> >
> > Do you need an ACPI dependency be explicit here?
>
> Probably don't need it.
>
> >
> > > +       depends on ACPI_WMI
> > > +       depends on INPUT
> > > +       select INPUT_SPARSEKMAP
> > > +       help
> > > +         This driver provides support for Huawei WMI hotkeys.
> > > +         It enables the missing keys and adds support to the
> > > micmute
> > > +         LED found on some of these laptops.
> > > +/*
> > > + *  Huawei WMI hotkeys
> > > + *
> > > + *  Copyright (C) 2018       Ayman Bagabas <
> > > ayman.bagabas@gmail.com>
> > > + *
> > > + *  This program is free software: you can redistribute it and/or
> > > modify
> > > + *  it under the terms of the GNU General Public License as
> > > published by
> > > + *  the Free Software Foundation, either version 2 of the License,
> > > or
> > > + *  (at your option) any later version.
> > > + *
> > > + *  This program is distributed in the hope that it will be
> > > useful,
> > > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + *  GNU General Public License for more details.
> > > + *
> > > + *  You should have received a copy of the GNU General Public
> > > License
> > > + *  along with this program.  If not, see <
> > > https://www.gnu.org/licenses/>;.
> > > + *
> >
> > Please, replace this boilerplate text with appropriate SPDX
> > identifier.
>
> Soryy about that. This alright?
>
> // SPDX-License-Identifier: GPL-2.0
> /*
>  * Huawei WMI hotkeys
>  *
>  * Copyright (C) 2018           Ayman Bagabas <ayman.bagabas@gmail.com>
>  */
>
>
>


-- 
With Best Regards,
Andy Shevchenko
