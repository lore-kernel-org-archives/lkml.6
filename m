Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26133C10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE21E2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550665969;
	bh=A0dJT+S5/lTtXIo/R+Fee9rv5wkd1+EjMrpNESP7wv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OsWTa+UGHoal8guANdT4KZOopIxjihW7XuLwmG+txEtGDFFl0gm2PIFAh43/ZvfZh
	 PWA5d1DlidKImayEiMfL5qrUgukuycKRyXkgZyIm7AOYKEL5BMgUU/9VgFelSMlTHI
	 A+OCgLU01H4F2R0tvQXXFObk9NJrzoZsNvZ+IIcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfBTMcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:32:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfBTMcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:32:47 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF73B2086C;
        Wed, 20 Feb 2019 12:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550665965;
        bh=A0dJT+S5/lTtXIo/R+Fee9rv5wkd1+EjMrpNESP7wv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SaIhBLg3AqbyWmZZcRCe6DdCHeWsOJoFgIqYEl/Bj4rDGaduGrzR+OUxKIQuOY3RT
         9wzHuntECxoP8HykdNk7SxwZtCGRQa1ODlbvLD51y0w1a6ffP3NcP0g5i/gAUXq5xf
         41IFON5WW6o8KReXGayS4vbulnpZfgk3paiqFopc=
Date:   Wed, 20 Feb 2019 12:32:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: light: Add driver for ap3216c
Message-ID: <20190220123240.77d764ea@archlinux>
In-Reply-To: <CAGngYiVQLwFxNJcCCH3byL=_p=L_BjMHJ1kCbjR8XkOF2mN3Ew@mail.gmail.com>
References: <89716a4433cd83aea5f4200359b184b0ee2cc8bd.1549828313.git.bobbyeshleman@gmail.com>
        <CAGngYiV6zm12XhB6WChSXNndLMSJ3e4NAB=BLq_mrXtWLKEruQ@mail.gmail.com>
        <20190211212734.01909e62@archlinux>
        <CAGngYiV_6MzKOSomAWs1znp8ThPRAL-e2CVZfn+ZHZOq8DiD0A@mail.gmail.com>
        <20190212204730.16864802@archlinux>
        <CAGngYiVGjPSnVfnJhR+0YJg+qOzMQfJM+Cd9ZRe===9pk1_3pA@mail.gmail.com>
        <20190218151606.00000d10@huawei.com>
        <CAGngYiVQLwFxNJcCCH3byL=_p=L_BjMHJ1kCbjR8XkOF2mN3Ew@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 14:35:51 -0500
Sven Van Asbroeck <thesven73@gmail.com> wrote:

> Hi Jonathan,
> 
> Thanks again for your clear and extensive feedback !
> 
> On Mon, Feb 18, 2019 at 10:16 AM Jonathan Cameron
> <jonathan.cameron@huawei.com> wrote:
> >
> > I suspect that would break lots of devices if it happened, but
> > fair enough that explicit might be good.  One option would be
> > to document clearly in regmap the requirement that bulk read is ordered.
> >  
> 
> Yes, it would be interesting to hear the regmap people's opinion on ordering.
> In the mean time, we can make this explicit.
> Re-reading the thread, I can also see that Peter Meerwald-Stadler was first
> to spot this race condition.
> 
> > What we need to guarantee is:
> >
> > 1) If the sensor reads on an occasion where the threshold is passed, we do not miss the event
> >    The event is the threshold being passed, not the existence of the reading, or how many
> >    readings etc.
> >
> > 2) A data read will result in a value.  There is no guarantee that it will match with the
> >    event.  All manner of delays could result in new data having occurred before that read.
> >  
> 
> My feedback was based on two incorrect assumptions:
> a. the interrupt fires whenever new PS/ALS values become available (wrong)
> b. there are strict consistency guarantees between the THRESH event, and what
> userspace will read out (also wrong)
> 
> Taking that into account, I am 100% in agreement with your other comments.
> Thank you so much for the explanation!
> 
> There is one exception, though:
> 
> > > +static int ap3216c_write_event_config(struct iio_dev *indio_dev,
> > > +                                    const struct iio_chan_spec *chan,
> > > +                                    enum iio_event_type type,
> > > +                                    enum iio_event_direction dir, int state)
> > > +{
> > > +       struct ap3216c_data *data = iio_priv(indio_dev);
> > > +
> > > +       switch (chan->type) {
> > > +       case IIO_LIGHT:
> > > +               data->als_thresh_en = state;
> > > +               return 0;
> > > +
> > > +       case IIO_PROXIMITY:
> > > +               data->prox_thresh_en = state;
> > > +               return 0;
> > > +
> > > +       default:
> > > +               return -EINVAL;
> > > +       }
> > > +static irqreturn_t ap3216c_event_handler(int irq, void *p)
> > > +{
> > > + if ((status & AP3216C_INT_STATUS_PS_MASK) && data->prox_thresh_en)
> > > + iio_push_event(...);
> > > +
> > >
> > > I think this may not work as intended. One thread (userspace) writes
> > > a variable, another thread (threaded irq handler) checks it. but there
> > > is no explicit or implicit memory barrier. So when userspace activates
> > > thresholding, it may take a long time for the handler to 'see' it !  
> >
> > Yes.  But if userspace took a while to get around to writing this value,
> > it would also take longer...  It's not time critical exactly when you
> > enable the event.  One can create cases where someone might
> > care, but they are pretty obscure.
> >  
> 
> Are you sure? I suspect that it's perfectly possible for the threaded irq
> handler not to 'see' the store to (als|prox)_thresh_en for a _very_ long time.

That is a serious - "in theory" circumstance.  The moment we hit any path at
all that results in a memory barrier it will see it.  Here its not critical
so we can wait.  In this case this is triggered by a userspace write.

Looks to me like that happens (I haven't checked that thoroughly) via
kernfs_fops_write which takes a mutex - so we have a barrier.

There are of course cases where multiple concurrent in kernel actions need
to be protected and need a memory barrier, but this doesn't look like one
of those to me.

> 
> AFAIK only a memory barrier will guarantee that the handler 'sees' the store
> right away. A lock will do - it issues an implicit memory barrier.
> 
> Most drivers use a lock to guarantee visibility. There are a few drivers that
> resort to explicit barriers to make a flag visible from one thread to another.

That's misleading. Most drivers use a lock to protect state against concurrent
inconsistent writes.  They don't take a lock because of it's memory barrier.
I have no objection to seeing one here as it's easier to know it is correct,
and the scope of lock can be nice and apparent.

> 
> E.g. search for mb() or wmb() in:
> drivers/input/keyboard/matrix_keypad.c
> drivers/input/misc/cm109.c
> drivers/input/misc/yealink.c

