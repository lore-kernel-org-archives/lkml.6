Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5739EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C64D20656
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbeLQM7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:59:09 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53269 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeLQM7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:59:08 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gYsUE-0004Ce-Cp; Mon, 17 Dec 2018 13:59:06 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gYsUD-0002Ou-G0; Mon, 17 Dec 2018 13:59:05 +0100
Date:   Mon, 17 Dec 2018 13:59:05 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/2] irq/irq_sim: provide irq_sim_fire_edge()
Message-ID: <20181217125905.fwbmipvmx4kahlge@pengutronix.de>
References: <CAMRc=Mfu=e3BsjMN=_H9CbUvumdmT1pvNjsyivTo1WN+LC1+2A@mail.gmail.com>
 <20181202215613.jcfrxwl4taiqgsql@pengutronix.de>
 <CAMRc=Me=FP537vMVx-jkuff2GqO66T+i3XUBza2Xb4oWzGNcLw@mail.gmail.com>
 <CAMRc=MeD-O5-7sBfrFn2rt27VHXwcOQ5cX2ybLHXU8kFyA_dLQ@mail.gmail.com>
 <20181203104923.gcb2bcsaoczjcjhk@pengutronix.de>
 <CAMRc=Me3srKHXLvdAVLAaVOyW79D378EGVh=dTXbCxo7FiyAsA@mail.gmail.com>
 <20181203110654.53o3prw3qu3u2uyf@pengutronix.de>
 <CACRpkdahWTts9Vz_vdC8dfd_HxCb3NmiFcwK=x-tVvFRcRm3tg@mail.gmail.com>
 <CAMpxmJWAZevmCkDDgLVTY5REGPB3HA5JAtNDtxT0NMt964GQCQ@mail.gmail.com>
 <CAMRc=MdaEPVTx6u0XsLJ8RFH2Kw+8DE1pJMe3H+e3KY2ycETaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdaEPVTx6u0XsLJ8RFH2Kw+8DE1pJMe3H+e3KY2ycETaw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 11:32:45AM +0100, Bartosz Golaszewski wrote:
> śr., 5 gru 2018 o 13:38 Bartosz Golaszewski
> <bgolaszewski@baylibre.com> napisał(a):
> >
> > śr., 5 gru 2018 o 13:20 Linus Walleij <linus.walleij@linaro.org> napisał(a):
> > >
> > > On Mon, Dec 3, 2018 at 12:06 PM Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > On Mon, Dec 03, 2018 at 11:57:26AM +0100, Bartosz Golaszewski wrote:
> > >
> > > > > It used to live in the gpio-mockup driver and I generalized it
> > > > > precisely because there was another driver - iio evgen - which was
> > > > > doing basically the same thing. While I don't know if there'll be more
> > > > > users (I'd guess it would be useful for testing purposes of other
> > > > > subsystems) having the same functionality implemented once is better
> > > > > than twice.
> > > >
> > > > The iio testing driver only needs the trigger and relies on an irq that
> > > > then calls the registerd handler. The iio driver doesn't need to tune
> > > > the edge sensitivity though and if your mockup driver just only calls
> > > > the fire routine if the configured sensitivity justifies that,
> > > > everything should work as expected.
> > >
> > > Simulating edges in the generic IRQ simulator codes seems
> > > generally useful to me, even if there is just one user now.
> > >
> > > Certainly for any kind of IRQ testing, it could be interesting to
> > > throw several low-to-high and high-to-low transitions
> > > on a driver and see how it reacts.
> > >
> > > But it is up to the irqchip maintainers to state whether they
> > > agree.
> > >
> >
> > All that would be great, but at this point I just want to fix broken
> > tests in user-space. After that we can think about how to
> > improve/approach simulating interrupts all we want.
> >
> > Marc: is my explanation for using an int instead of bool for
> > irq_sim_fire_edge() fine? Can Linus pick this up for fixes?
> >
> 
> Ping. We have only this week left to fix the regression - can we get
> your Ack Marc?

I don't understand the urge. The problem is that libgpiod's test is
failing. And that is because when userspace requested
IRQF_TRIGGER_FALLING the mockup driver also fires if the line rised and
with my change libgpiod now sees that and wonders about it. Apart from
the test failure both libgpiod and the gpio framework are entirely fine
(AFAICT).

The "fix" under discussion is to modify the mockup driver to only report
a falling irq if the output is set to 0. But it also fires if the value
is already 0 and is set to 0 again. So the problem isn't addressed
completely, but only enough to make libgpiod's test suite report
success.

In my eyes this is not how test-driven development works. Tests are
here to bring breakage into the light. That worked just fine here. And
now as a test fails, the goal is to fix the breakage, but not to change
just enough details to get the test to pass and then urge them through
because "we're already at -rc7 and userspace broke!"

And no, the right fix isn't hard. My concerns were expressed Tuesday
last week, and the problem wasn't important enough since then to fix the
patch set.

But maybe it's just me and the Linux development process changed since I
learned about it and today the demand on quality isn't that high any
more.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
