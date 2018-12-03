Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C75C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9444820851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9444820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeLCLHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:07:31 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41645 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeLCLHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:07:31 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gTm3z-0001DP-0h; Mon, 03 Dec 2018 12:06:55 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gTm3y-0005dq-IX; Mon, 03 Dec 2018 12:06:54 +0100
Date:   Mon, 3 Dec 2018 12:06:54 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/2] irq/irq_sim: provide irq_sim_fire_edge()
Message-ID: <20181203110654.53o3prw3qu3u2uyf@pengutronix.de>
References: <CAMRc=MfKf_f+x3Wt5gScA5yb78kbpphL87bi2arxcKKGjg1S7Q@mail.gmail.com>
 <20181121191509.ia2vcklvx4q2rh56@pengutronix.de>
 <CAMRc=Mef_O9ANUekZaz7vP7M2PpQFjZxJBoG8EPbXt6enRPL7g@mail.gmail.com>
 <20181125211854.idnqxz4pco3r7ydr@pengutronix.de>
 <CAMRc=Mfu=e3BsjMN=_H9CbUvumdmT1pvNjsyivTo1WN+LC1+2A@mail.gmail.com>
 <20181202215613.jcfrxwl4taiqgsql@pengutronix.de>
 <CAMRc=Me=FP537vMVx-jkuff2GqO66T+i3XUBza2Xb4oWzGNcLw@mail.gmail.com>
 <CAMRc=MeD-O5-7sBfrFn2rt27VHXwcOQ5cX2ybLHXU8kFyA_dLQ@mail.gmail.com>
 <20181203104923.gcb2bcsaoczjcjhk@pengutronix.de>
 <CAMRc=Me3srKHXLvdAVLAaVOyW79D378EGVh=dTXbCxo7FiyAsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Me3srKHXLvdAVLAaVOyW79D378EGVh=dTXbCxo7FiyAsA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:57:26AM +0100, Bartosz Golaszewski wrote:
> pon., 3 gru 2018 o 11:49 Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> napisał(a):
> >
> > On Mon, Dec 03, 2018 at 11:23:38AM +0100, Bartosz Golaszewski wrote:
> > > niedz., 2 gru 2018 o 23:20 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
> > > >
> > > > niedz., 2 gru 2018 o 22:56 Uwe Kleine-König
> > > > <u.kleine-koenig@pengutronix.de> napisał(a):
> > > > >
> > > > > Hello,
> > > > >
> > > > > On Thu, Nov 29, 2018 at 07:14:45PM +0100, Bartosz Golaszewski wrote:
> > > > > > We're getting too much into details of how to handle simulated
> > > > > > interrupts and we can continue discussing it, but meanwhile I'd like
> > > > > > to address a different thing:
> > > > > >
> > > > > > Thomas, Linus: after commit fa38869b0161 ("gpiolib: Don't support irq
> > > > > > sharing for userspace") some libgpiod tests are failing because we can
> > > > > > no longer depend on reading the value of a dummy GPIO after detecting
> > > > > > an interrupt to know the edge of the interrupt. While these interrupts
> > > > > > are triggered from debugfs and debugfs is not required to maintain
> > > > > > compatibility, I thing having a working test suite for the GPIO
> > > > > > subsystem and uAPI is worth applying these two patches and also the
> > > > > > previous one[1].
> > > > > >
> > > > > > Can we have them applied for 4.20 or are there any objections?
> > > > >
> > > > > Just for the record: I objected the patch, Bartosz agrees to discuss
> > > > > further and but because this is too much detail the patch should now be
> > > > > applied anyhow to fix the test suite of an external project. This seems
> > > > > wrong to me.
> > > > >
> > > >
> > > > Just to look at it from a different perspective: we have a project
> > > > whose tests rely on a behavior that was changed by Uwe's patch. While
> > > > the patch is fine, we need to find a correct way of testing the GPIO
> > > > user API. This may take a long time. In order to not break the tests
> > > > of an external project in 4.20 I propose to patch the interrupt
> > > > simulator (a component only used for testing) for now and to revisit
> > > > it later without time pressure.
> > > >
> > > > Best regards,
> > > > Bartosz
> > >
> > > In fact after re-reading this conversation I'm still not sure what
> > > your objection is exactly. You're proposing a solution that may well
> > > be nicely engineered but it's specific to your gpio-simulator.
> > > Meanwhile I'm trying to provide a more generalized API for more
> > > testing modules to use.
> >
> > I think you're generalizing something that won't find any user apart
> > from your mockup driver. So I'd say the generalisation is wrong and the
> > added code could better live in the mockup driver directly.
> >
> 
> It used to live in the gpio-mockup driver and I generalized it
> precisely because there was another driver - iio evgen - which was
> doing basically the same thing. While I don't know if there'll be more
> users (I'd guess it would be useful for testing purposes of other
> subsystems) having the same functionality implemented once is better
> than twice.

The iio testing driver only needs the trigger and relies on an irq that
then calls the registerd handler. The iio driver doesn't need to tune
the edge sensitivity though and if your mockup driver just only calls
the fire routine if the configured sensitivity justifies that,
everything should work as expected.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
