Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5688C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DB32133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Y8u9JrjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbeLQN7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:59:34 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40034 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732181AbeLQN7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:59:34 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so20005294ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 05:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/OMAstYOXq9/mHifG0nh1DT9G42qKuoQsAC7vNZo/JE=;
        b=Y8u9JrjNpaHlFdYZl49GdMNoFN464lFX7WXP0HR2oyycMsmX2zPnDo9tcAPcezI3lR
         FEXs1c+ZSvd/0wVmXGrTEZCs9354Stcw7kUH77UWC4vmMviKhIbsvajL8j7dd4q41Xz6
         4nQaQe5ADONqLgNbU7gHKcS2EmQh6iR1T7pFQJJ41/ydRh7B4x+9kXHPR4TuOSZIUlKu
         oS35CzhHtdDjXuprVydgeK8dP9f8hBb4U9Er76PQ2hFu7e0Q3ImX4OrKb9ehu7sMMv7h
         MsRxOHBMN5pNA2jcSwMewhBFYCoRKFJ4dSYaE46fl77My62wd8dRuchTML3OujYlcr4/
         axPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/OMAstYOXq9/mHifG0nh1DT9G42qKuoQsAC7vNZo/JE=;
        b=mujz7rBij8+nkbBmrszr75/d6RTsBsPgGJzO6LSOd/lxun6CLXitYXPlcxRkCilfWL
         CeibRqbybp07hetldQhqxhl/c8jHHhgK2gE0QH8ozBuS2zscW8DZvCsJPEZ7b3keum7o
         gT0hyYkf2iki8S0MlRSCVJRG0LE8o2mdem8fXt0OshVygYk+N/dJ58CBpUNLhh+/gaZQ
         RFpG4F71G1/7jwLay8al61aMtSledzth69V0KCJhL53FuDiQFelaR11Y7shy41kD0Khl
         tXMLE/b20qlLHcklxRhttfXNaVIJ5Mwrjp0pwb+CHgXVrRUIkDVBvX5E10IQqaom+MR8
         F+IA==
X-Gm-Message-State: AA+aEWarUcXEaZsxTCFoTq2+VbCgvT0gSo/AWXZAA3eHWTF5KyEJz2uL
        KXiFTY59rQ/qCajeHmGfxFjjiclj/BX25PK5BXxWdg==
X-Google-Smtp-Source: AFSGD/VLsMGuZwgaQv1XBaTRlUuxflAvJR6OipVoVzR0UDhjOeFMRcxYBGNKNBUupqv3TeeZkhDX1yrNPsCDtsWWeqY=
X-Received: by 2002:a02:98bb:: with SMTP id q56mr11975513jaj.24.1545055172592;
 Mon, 17 Dec 2018 05:59:32 -0800 (PST)
MIME-Version: 1.0
References: <CAMRc=Mfu=e3BsjMN=_H9CbUvumdmT1pvNjsyivTo1WN+LC1+2A@mail.gmail.com>
 <20181202215613.jcfrxwl4taiqgsql@pengutronix.de> <CAMRc=Me=FP537vMVx-jkuff2GqO66T+i3XUBza2Xb4oWzGNcLw@mail.gmail.com>
 <CAMRc=MeD-O5-7sBfrFn2rt27VHXwcOQ5cX2ybLHXU8kFyA_dLQ@mail.gmail.com>
 <20181203104923.gcb2bcsaoczjcjhk@pengutronix.de> <CAMRc=Me3srKHXLvdAVLAaVOyW79D378EGVh=dTXbCxo7FiyAsA@mail.gmail.com>
 <20181203110654.53o3prw3qu3u2uyf@pengutronix.de> <CACRpkdahWTts9Vz_vdC8dfd_HxCb3NmiFcwK=x-tVvFRcRm3tg@mail.gmail.com>
 <CAMpxmJWAZevmCkDDgLVTY5REGPB3HA5JAtNDtxT0NMt964GQCQ@mail.gmail.com>
 <CAMRc=MdaEPVTx6u0XsLJ8RFH2Kw+8DE1pJMe3H+e3KY2ycETaw@mail.gmail.com> <20181217125905.fwbmipvmx4kahlge@pengutronix.de>
In-Reply-To: <20181217125905.fwbmipvmx4kahlge@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 17 Dec 2018 14:59:21 +0100
Message-ID: <CAMRc=MecZ3a8cO_yaXOZkteoA5fY=X3kTjj4ZFY-X039mn6wKA@mail.gmail.com>
Subject: Re: [PATCH 1/2] irq/irq_sim: provide irq_sim_fire_edge()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
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

pon., 17 gru 2018 o 13:59 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> On Mon, Dec 17, 2018 at 11:32:45AM +0100, Bartosz Golaszewski wrote:
> > =C5=9Br., 5 gru 2018 o 13:38 Bartosz Golaszewski
> > <bgolaszewski@baylibre.com> napisa=C5=82(a):
> > >
> > > =C5=9Br., 5 gru 2018 o 13:20 Linus Walleij <linus.walleij@linaro.org>=
 napisa=C5=82(a):
> > > >
> > > > On Mon, Dec 3, 2018 at 12:06 PM Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > On Mon, Dec 03, 2018 at 11:57:26AM +0100, Bartosz Golaszewski wro=
te:
> > > >
> > > > > > It used to live in the gpio-mockup driver and I generalized it
> > > > > > precisely because there was another driver - iio evgen - which =
was
> > > > > > doing basically the same thing. While I don't know if there'll =
be more
> > > > > > users (I'd guess it would be useful for testing purposes of oth=
er
> > > > > > subsystems) having the same functionality implemented once is b=
etter
> > > > > > than twice.
> > > > >
> > > > > The iio testing driver only needs the trigger and relies on an ir=
q that
> > > > > then calls the registerd handler. The iio driver doesn't need to =
tune
> > > > > the edge sensitivity though and if your mockup driver just only c=
alls
> > > > > the fire routine if the configured sensitivity justifies that,
> > > > > everything should work as expected.
> > > >
> > > > Simulating edges in the generic IRQ simulator codes seems
> > > > generally useful to me, even if there is just one user now.
> > > >
> > > > Certainly for any kind of IRQ testing, it could be interesting to
> > > > throw several low-to-high and high-to-low transitions
> > > > on a driver and see how it reacts.
> > > >
> > > > But it is up to the irqchip maintainers to state whether they
> > > > agree.
> > > >
> > >
> > > All that would be great, but at this point I just want to fix broken
> > > tests in user-space. After that we can think about how to
> > > improve/approach simulating interrupts all we want.
> > >
> > > Marc: is my explanation for using an int instead of bool for
> > > irq_sim_fire_edge() fine? Can Linus pick this up for fixes?
> > >
> >
> > Ping. We have only this week left to fix the regression - can we get
> > your Ack Marc?
>
> I don't understand the urge. The problem is that libgpiod's test is
> failing. And that is because when userspace requested
> IRQF_TRIGGER_FALLING the mockup driver also fires if the line rised and
> with my change libgpiod now sees that and wonders about it. Apart from
> the test failure both libgpiod and the gpio framework are entirely fine
> (AFAICT).
>
> The "fix" under discussion is to modify the mockup driver to only report
> a falling irq if the output is set to 0. But it also fires if the value
> is already 0 and is set to 0 again. So the problem isn't addressed
> completely, but only enough to make libgpiod's test suite report
> success.
>

The problem with your approach is that you're treating gpio-mockup as
a regular driver the goal of which is self-contained correctness. I
treat it as a tool to test the userspace API.

Of course libgpiod works correctly - it requests and receives the
correct type of interrupts. So does the gpiolib in-kernel part. The
problem indeed lies with the kernel testing module. But it doesn't
matter - we want to make sure the uAPI works correctly i.e. it behaves
the same with gpio-mockup as it would with a real driver for actual HW
behind. We're not testing gpio-mockup(!) here.

> In my eyes this is not how test-driven development works. Tests are
> here to bring breakage into the light. That worked just fine here. And
> now as a test fails, the goal is to fix the breakage, but not to change
> just enough details to get the test to pass and then urge them through
> because "we're already at -rc7 and userspace broke!"
>

The tests here are to find regressions in a) libgpiod and b) gpiolib
kernel-to-userspace interface. The mockup module isn't part of either.

The breakage in gpio-mockup/irq_sim is really not all that important.
Whether the userspace API works is. And with a breakage like this
we're now unable to check if it behaves correctly for events of
specified types. So yes: for 4.20 I want to fix the gpio-mockup module
just enough to keep the tests passing.

> And no, the right fix isn't hard. My concerns were expressed Tuesday
> last week, and the problem wasn't important enough since then to fix the
> patch set.
>

I already told you on several occasions that I *will* address certain
issues in irq_sim. It will *not* make you happy however because it
will not use the mechanism you suggested in gpio-simulator as I still
want to keep this relatively generic for others to use. I will fix
other problems though - among others the one with multiple subsequent
events of the same edge. I don't want to be in a hurry to propose
something fast, so I want to patch the tests now and then have time to
come up with a better solution.

Linus agrees. I see no objections to that from neither Marc nor
Thomas. I would really like to stop discussing this over and over
again after my every e-mail in this thread.

> But maybe it's just me and the Linux development process changed since I
> learned about it and today the demand on quality isn't that high any
> more.
>

First rule has always been "don't break the userspace" and everything
else came after that.

Best regards,
Bartosz Golaszewski
