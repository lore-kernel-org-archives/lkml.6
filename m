Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8143CC282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46375217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="NAAXiA+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfAWAoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:44:18 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46109 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfAWAoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:44:18 -0500
Received: by mail-qt1-f195.google.com with SMTP id y20so490756qtm.13;
        Tue, 22 Jan 2019 16:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dx3TwqSOv1EutmQ/1LrWO3DnMbQtsVHAoaO29C4LdD8=;
        b=NAAXiA+/9P0CAzbjfWcTz2IvWvPKNQkFBk+rTazxCBxEl2wdyaIXsFxZQeEFCJ3vsv
         JAKqym8XRomj9UiHpEnKd+WiHn1m16u/6h3e3wNAL9YtlGM+zVzSopiZGzFbl9jsFt86
         RbJ6DCZ+j3ruS/TIsPUcZKTsSMwvO3nXvX9TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dx3TwqSOv1EutmQ/1LrWO3DnMbQtsVHAoaO29C4LdD8=;
        b=hPNYyMF9diW6hMpPKgpLAN3Vm6mPObj0TX65mqjG2OTsGUzHaesUZLm5tQYc6c1xGy
         Yb8tMNAgOtgRDrB3YFwEYVI8ZAQgmepWovZYQ8pYf3udv2Iw4i7C/VVfoui/OW8vQbuu
         /44P5As6KhiDHr5dw3rBpitW4RoF3X+f6K25H64aP3L8tRE7QPz5JDJ/Kt3ItCcvcFKU
         p8jMLeyj7s71ZhbuVDRoO7iyrs22HZAPQbjWNafPlZ4TtqIiNJ5chFab7t2UyqBV36sy
         ejw15RIUYXMYUPQ0BetJ4Cu8huSpGGC4dIdlRTBNeQgjqFg8O+ZN4v2UkHsWxIplgdql
         kzhw==
X-Gm-Message-State: AJcUukdF/XgF5damnP0l0fcDdssrFalHb4AZOBVhf9C6PDMKPUUBAEpk
        JpBuvV51qBExLuqjw8bZIPjS7hIMNI9Ub/F+IZI=
X-Google-Smtp-Source: ALg8bN6BmtxQefI5M5HjjEvADzcYfvuDhhQ4/sfEJY7qr/jHAJd/OPq0E2v3dAhbkIAP4JKsr756WWhPepMAsj2TKM4=
X-Received: by 2002:a0c:e751:: with SMTP id g17mr130603qvn.160.1548204256472;
 Tue, 22 Jan 2019 16:44:16 -0800 (PST)
MIME-Version: 1.0
References: <20181010083007.239938-1-matthewgarrett@google.com>
 <20181010083007.239938-2-matthewgarrett@google.com> <1543849707.2841.9.camel@intel.com>
In-Reply-To: <1543849707.2841.9.camel@intel.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 23 Jan 2019 11:44:02 +1100
Message-ID: <CACPK8Xdb0fEjU3kf_ZETtYE+D42QF-fNQacaHjVsLeE4MU0qFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal/int340x_thermal: Add additional UUIDs
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Nisha Aram <nisha.aram@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rui,

On Tue, 4 Dec 2018 at 02:12, Zhang Rui <rui.zhang@intel.com> wrote:
> On =E4=B8=89, 2018-10-10 at 01:30 -0700, Matthew Garrett wrote:
> > Platforms support more DPTF policies than the driver currently
> > exposes.
> > Add them. This effectively reverts
> > 31908f45a583e8f21db37f402b6e8d5739945afd which removed several UUIDs
> > without explaining why.
> >
> I'm going to apply this patch series, just with two minor changes,
> 1. 31908f45a583e8f21db37f402b6e8d5739945afd does not follow the git
> commit description style 'commit <12+ chars of sha1> ("<title line>")'
> 2. the UUIDs were removed previously because these policies were not
> used.

Which tree did this series get applied to?

Cheers,

Joel

>
> thanks,
> rui
>
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Nisha Aram <nisha.aram@intel.com>
> > ---
> >  drivers/thermal/int340x_thermal/int3400_thermal.c | 14
> > ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c
> > b/drivers/thermal/int340x_thermal/int3400_thermal.c
> > index e26b01c05e82..51c9097eaf7a 100644
> > --- a/drivers/thermal/int340x_thermal/int3400_thermal.c
> > +++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
> > @@ -22,6 +22,13 @@ enum int3400_thermal_uuid {
> >       INT3400_THERMAL_PASSIVE_1,
> >       INT3400_THERMAL_ACTIVE,
> >       INT3400_THERMAL_CRITICAL,
> > +     INT3400_THERMAL_ADAPTIVE_PERFORMANCE,
> > +     INT3400_THERMAL_EMERGENCY_CALL_MODE,
> > +     INT3400_THERMAL_PASSIVE_2,
> > +     INT3400_THERMAL_POWER_BOSS,
> > +     INT3400_THERMAL_VIRTUAL_SENSOR,
> > +     INT3400_THERMAL_COOLING_MODE,
> > +     INT3400_THERMAL_HARDWARE_DUTY_CYCLING,
> >       INT3400_THERMAL_MAXIMUM_UUID,
> >  };
> >
> > @@ -29,6 +36,13 @@ static char
> > *int3400_thermal_uuids[INT3400_THERMAL_MAXIMUM_UUID] =3D {
> >       "42A441D6-AE6A-462b-A84B-4A8CE79027D3",
> >       "3A95C389-E4B8-4629-A526-C52C88626BAE",
> >       "97C68AE7-15FA-499c-B8C9-5DA81D606E0A",
> > +     "63BE270F-1C11-48FD-A6F7-3AF253FF3E2D",
> > +     "5349962F-71E6-431D-9AE8-0A635B710AEE",
> > +     "9E04115A-AE87-4D1C-9500-0F3E340BFE75",
> > +     "F5A35014-C209-46A4-993A-EB56DE7530A1",
> > +     "6ED722A7-9240-48A5-B479-31EEF723D7CF",
> > +     "16CAF1B7-DD38-40ED-B1C1-1B8A1913D531",
> > +     "BE84BABF-C4D4-403D-B495-3128FD44dAC1",
> >  };
> >
> >  struct int3400_thermal_priv {
