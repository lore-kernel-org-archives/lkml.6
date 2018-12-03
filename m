Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C66C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A86020848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Qi3jYM64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A86020848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbeLCK6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:58:11 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42811 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLCK6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:58:10 -0500
Received: by mail-io1-f68.google.com with SMTP id x6so10047611ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pzAGF8bpBTlswVikN04sR7r5QMuSxZbyY4gYAUT/Sqg=;
        b=Qi3jYM649xZkGS/pPyGuN/2ni2QlUkB1ev8K3vVDaUJsGAYSbc0aq7nARgdCdnnKHa
         2LJB3h0peFsQasJwjP1E41ICMZF9/q0ahqisaq68jXkEWxnNVBHMAWfnC+Ug18icd7AO
         zM8zxGDgEkNJgRSDBsGcRltLMbMoWXGzaUA1BXi53/LWDXWDF1ctnoO/oxcbaROP+d8U
         tvH+yNGQRCQkt6lcQfhsMHN5i8EH5ijQu9PixBzJVLcpkiQ+uj5ch3EN6KonoZFH5NOl
         HzZYld+IvI4vbYlELcvv3qrZkZEM/llJrWUwMqk4BtfAmNYzF/PpLUJDgjYszppMbwFM
         SC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pzAGF8bpBTlswVikN04sR7r5QMuSxZbyY4gYAUT/Sqg=;
        b=Qfl3GfAXvD9ikoPEONIL1RNWzc/3OdXT5dOa3u3n9uSZ1z8UBMVnTTVyz19Qp+pxQ5
         iFgccwNpt5bBc1p0xH/nrUyrTmcQ3xsuv3VeJTNVFv3Z6tcrRB8+n5ZbHMiIe0fyIYgd
         83CHLVEmxt5yw87DfuekdSKuxAtNVFk8xuMyXP1PYfYI6BVyDsLtOLw675dsN4KgJkwr
         St+4a2oG+IFpPyWolKDIG3GEqkDo4FwiBcqMTKw16XsEhERH68RQYSFdFQcahC9hxDSd
         GEb7COEZ0zaqBeHEWLgwbN0461iL1/VGkH/ZR2uH15sE0iXWpgy8X59bWQYW0hn7N+eD
         JPyA==
X-Gm-Message-State: AA+aEWYpABGO4fZ6PLaqVTobGvBzeXteiVC3adod0ps81IYn5V2LTWBg
        rA7Jl8rca3CfjgLyM/xKnBcsO49CYncuGvVJIdOTbQ==
X-Google-Smtp-Source: AFSGD/XQBb6yxLMxKZeKQnLv1XmvxNY0pUBzYb1SY0AJpfmG0g/iZ2pFXve/c0LinVPjKgrnKV63U922i3o2JI+XmQA=
X-Received: by 2002:a5d:8c89:: with SMTP id g9mr14211533ion.111.1543834657297;
 Mon, 03 Dec 2018 02:57:37 -0800 (PST)
MIME-Version: 1.0
References: <20181120134032.31645-2-brgl@bgdev.pl> <20181120171742.gkwb4s4qbcqvnefj@pengutronix.de>
 <CAMRc=MfKf_f+x3Wt5gScA5yb78kbpphL87bi2arxcKKGjg1S7Q@mail.gmail.com>
 <20181121191509.ia2vcklvx4q2rh56@pengutronix.de> <CAMRc=Mef_O9ANUekZaz7vP7M2PpQFjZxJBoG8EPbXt6enRPL7g@mail.gmail.com>
 <20181125211854.idnqxz4pco3r7ydr@pengutronix.de> <CAMRc=Mfu=e3BsjMN=_H9CbUvumdmT1pvNjsyivTo1WN+LC1+2A@mail.gmail.com>
 <20181202215613.jcfrxwl4taiqgsql@pengutronix.de> <CAMRc=Me=FP537vMVx-jkuff2GqO66T+i3XUBza2Xb4oWzGNcLw@mail.gmail.com>
 <CAMRc=MeD-O5-7sBfrFn2rt27VHXwcOQ5cX2ybLHXU8kFyA_dLQ@mail.gmail.com> <20181203104923.gcb2bcsaoczjcjhk@pengutronix.de>
In-Reply-To: <20181203104923.gcb2bcsaoczjcjhk@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 3 Dec 2018 11:57:26 +0100
Message-ID: <CAMRc=Me3srKHXLvdAVLAaVOyW79D378EGVh=dTXbCxo7FiyAsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] irq/irq_sim: provide irq_sim_fire_edge()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 3 gru 2018 o 11:49 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> On Mon, Dec 03, 2018 at 11:23:38AM +0100, Bartosz Golaszewski wrote:
> > niedz., 2 gru 2018 o 23:20 Bartosz Golaszewski <brgl@bgdev.pl> napisa=
=C5=82(a):
> > >
> > > niedz., 2 gru 2018 o 22:56 Uwe Kleine-K=C3=B6nig
> > > <u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
> > > >
> > > > Hello,
> > > >
> > > > On Thu, Nov 29, 2018 at 07:14:45PM +0100, Bartosz Golaszewski wrote=
:
> > > > > We're getting too much into details of how to handle simulated
> > > > > interrupts and we can continue discussing it, but meanwhile I'd l=
ike
> > > > > to address a different thing:
> > > > >
> > > > > Thomas, Linus: after commit fa38869b0161 ("gpiolib: Don't support=
 irq
> > > > > sharing for userspace") some libgpiod tests are failing because w=
e can
> > > > > no longer depend on reading the value of a dummy GPIO after detec=
ting
> > > > > an interrupt to know the edge of the interrupt. While these inter=
rupts
> > > > > are triggered from debugfs and debugfs is not required to maintai=
n
> > > > > compatibility, I thing having a working test suite for the GPIO
> > > > > subsystem and uAPI is worth applying these two patches and also t=
he
> > > > > previous one[1].
> > > > >
> > > > > Can we have them applied for 4.20 or are there any objections?
> > > >
> > > > Just for the record: I objected the patch, Bartosz agrees to discus=
s
> > > > further and but because this is too much detail the patch should no=
w be
> > > > applied anyhow to fix the test suite of an external project. This s=
eems
> > > > wrong to me.
> > > >
> > >
> > > Just to look at it from a different perspective: we have a project
> > > whose tests rely on a behavior that was changed by Uwe's patch. While
> > > the patch is fine, we need to find a correct way of testing the GPIO
> > > user API. This may take a long time. In order to not break the tests
> > > of an external project in 4.20 I propose to patch the interrupt
> > > simulator (a component only used for testing) for now and to revisit
> > > it later without time pressure.
> > >
> > > Best regards,
> > > Bartosz
> >
> > In fact after re-reading this conversation I'm still not sure what
> > your objection is exactly. You're proposing a solution that may well
> > be nicely engineered but it's specific to your gpio-simulator.
> > Meanwhile I'm trying to provide a more generalized API for more
> > testing modules to use.
>
> I think you're generalizing something that won't find any user apart
> from your mockup driver. So I'd say the generalisation is wrong and the
> added code could better live in the mockup driver directly.
>

It used to live in the gpio-mockup driver and I generalized it
precisely because there was another driver - iio evgen - which was
doing basically the same thing. While I don't know if there'll be more
users (I'd guess it would be useful for testing purposes of other
subsystems) having the same functionality implemented once is better
than twice.

Bart
