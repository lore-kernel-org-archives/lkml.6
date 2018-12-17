Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693EFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399E92133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="HsAfEsO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbeLQKc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:32:58 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:32859 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732017AbeLQKc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:32:58 -0500
Received: by mail-it1-f194.google.com with SMTP id m8so5115793itk.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 02:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M/hrvpMWylKMYAtzA9GzD07lIiZgy8DdC6TOmQXU8pU=;
        b=HsAfEsO4q61HVUOynRbtoPfO3uOsBjYiugr8mKjzoq42lTm63FMHtuEwyNI56bnTbA
         ZGIf/x1BIShIK4L0CbeDbY1VX/MC7Y/iKFUrL1z33TjFTHtkTM5lDZN+k505t1VSivg5
         3cCKvPW12G66PtlJUtO8bWvrrLhdeLbiD9mp+WGau8Wo9X8Ww9af5c7FwIu+9cVFjogD
         mquLF3itFRjHvtCpaSH+uJZmxU2j2cmF2PAZhGva8Zqw395zGot97rd1z5zlXsuDQS2m
         Aor9A7JaXX/WlijWpkwfTRjbnjxMvYrxT1SVlvpKfXc4SzBjuDbUXQ0kjb9f722auwu2
         gLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M/hrvpMWylKMYAtzA9GzD07lIiZgy8DdC6TOmQXU8pU=;
        b=Xp+h6/HD0kqT1O+HlnUmQJsQ0OZgJ1oumEEuRXmBUgN4QF8RTKg0rhkGXhOsjxh4CU
         /S1QI9Tjt0maQnidP6RJufstICrk/wGFvxE52w3Au9tkzrA59XziiQNeLKDjcGDoLAIG
         fN667Dp4frTGnj93GEVlbX1CNkAoRro4O1SsFpnVTXahYhtHxyS14DoDuqCauaffl0/t
         Q49JPipKKqBvfTPN2UT5xUJqOsOeIj3UMhJUqX4AbmAe33yQtB7VVMM/cMOnMyY8kZGq
         OA7D1x0RAy0W17JQHomrQl2x/o2NRObgbYSDw8kc2I8spqE+33OqV5rpwq4lckPBi3WK
         lkyA==
X-Gm-Message-State: AA+aEWbJrBCEkEq6+XrArx1ksGPhcvdf1EYhiURgiDFApeoq/6xUo9TP
        LnjvN0AGjwt5u5yNCgCFnR+AQZd05E1xi4/6c6lRZg==
X-Google-Smtp-Source: AFSGD/XToPKM6YImP+3OrBDRD/hAP4ESWQCGcaN1+tSs3WZmjhCuYFX4JHdPZ7BMDdf3BVrdgNbOs4SM/hd6sPeDvGA=
X-Received: by 2002:a24:9d1:: with SMTP id 200mr12436190itm.53.1545042776512;
 Mon, 17 Dec 2018 02:32:56 -0800 (PST)
MIME-Version: 1.0
References: <CAMRc=MfKf_f+x3Wt5gScA5yb78kbpphL87bi2arxcKKGjg1S7Q@mail.gmail.com>
 <20181121191509.ia2vcklvx4q2rh56@pengutronix.de> <CAMRc=Mef_O9ANUekZaz7vP7M2PpQFjZxJBoG8EPbXt6enRPL7g@mail.gmail.com>
 <20181125211854.idnqxz4pco3r7ydr@pengutronix.de> <CAMRc=Mfu=e3BsjMN=_H9CbUvumdmT1pvNjsyivTo1WN+LC1+2A@mail.gmail.com>
 <20181202215613.jcfrxwl4taiqgsql@pengutronix.de> <CAMRc=Me=FP537vMVx-jkuff2GqO66T+i3XUBza2Xb4oWzGNcLw@mail.gmail.com>
 <CAMRc=MeD-O5-7sBfrFn2rt27VHXwcOQ5cX2ybLHXU8kFyA_dLQ@mail.gmail.com>
 <20181203104923.gcb2bcsaoczjcjhk@pengutronix.de> <CAMRc=Me3srKHXLvdAVLAaVOyW79D378EGVh=dTXbCxo7FiyAsA@mail.gmail.com>
 <20181203110654.53o3prw3qu3u2uyf@pengutronix.de> <CACRpkdahWTts9Vz_vdC8dfd_HxCb3NmiFcwK=x-tVvFRcRm3tg@mail.gmail.com>
 <CAMpxmJWAZevmCkDDgLVTY5REGPB3HA5JAtNDtxT0NMt964GQCQ@mail.gmail.com>
In-Reply-To: <CAMpxmJWAZevmCkDDgLVTY5REGPB3HA5JAtNDtxT0NMt964GQCQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 17 Dec 2018 11:32:45 +0100
Message-ID: <CAMRc=MdaEPVTx6u0XsLJ8RFH2Kw+8DE1pJMe3H+e3KY2ycETaw@mail.gmail.com>
Subject: Re: [PATCH 1/2] irq/irq_sim: provide irq_sim_fire_edge()
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 5 gru 2018 o 13:38 Bartosz Golaszewski
<bgolaszewski@baylibre.com> napisa=C5=82(a):
>
> =C5=9Br., 5 gru 2018 o 13:20 Linus Walleij <linus.walleij@linaro.org> nap=
isa=C5=82(a):
> >
> > On Mon, Dec 3, 2018 at 12:06 PM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Mon, Dec 03, 2018 at 11:57:26AM +0100, Bartosz Golaszewski wrote:
> >
> > > > It used to live in the gpio-mockup driver and I generalized it
> > > > precisely because there was another driver - iio evgen - which was
> > > > doing basically the same thing. While I don't know if there'll be m=
ore
> > > > users (I'd guess it would be useful for testing purposes of other
> > > > subsystems) having the same functionality implemented once is bette=
r
> > > > than twice.
> > >
> > > The iio testing driver only needs the trigger and relies on an irq th=
at
> > > then calls the registerd handler. The iio driver doesn't need to tune
> > > the edge sensitivity though and if your mockup driver just only calls
> > > the fire routine if the configured sensitivity justifies that,
> > > everything should work as expected.
> >
> > Simulating edges in the generic IRQ simulator codes seems
> > generally useful to me, even if there is just one user now.
> >
> > Certainly for any kind of IRQ testing, it could be interesting to
> > throw several low-to-high and high-to-low transitions
> > on a driver and see how it reacts.
> >
> > But it is up to the irqchip maintainers to state whether they
> > agree.
> >
>
> All that would be great, but at this point I just want to fix broken
> tests in user-space. After that we can think about how to
> improve/approach simulating interrupts all we want.
>
> Marc: is my explanation for using an int instead of bool for
> irq_sim_fire_edge() fine? Can Linus pick this up for fixes?
>

Ping. We have only this week left to fix the regression - can we get
your Ack Marc?

NOTE: this patch must go into v4.20, and will probably conflict with
the bitmap patch you picked up for 4.21. I can take it into my PR for
Linus Walleij and then fix the conflict in next.

Bart
