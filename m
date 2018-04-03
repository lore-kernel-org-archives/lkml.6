Return-Path: <p.zabel@pengutronix.de>
X-Google-Smtp-Source: AIpwx4++N74XQhFV+11mft1RidaJkjKCrfJu72h8DrEGebm1tGtxal/l3V1c848r7FJ/vFOIzMFq
ARC-Seal: i=1; a=rsa-sha256; t=1522745185; cv=none;
        d=google.com; s=arc-20160816;
        b=mswkzzYMmEFimYXBsVyVaEg8UUVJM+wdyND1VPilmybED2cfeP6Emv9y6Qquuv0cA0
         0sGHWvcG2mRFAyHr32WB22Kv1uEfKCdao2DI9r+pxbVOs+P4lpxh7/wE+ONAZGWnC2K5
         jvIi1WXDx2wDEq/i2ufQurTq+2knUdV8BmTFCdrKpUJwyiWU1vGv3KYbwpp/FEYaPiMB
         C42o7SQkxXAixJT4Jlath/zOlWRxxOiiN5QrguyNttU0+5tWBd5XOKlbtwF/ukk1cvTv
         ia1ln99x+Ker15S0++pdevfp4nSIAvutU65tq7BR4R8Lv4+foaXLjV1Eyhx4v22UMvYH
         JLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=NI2hETqlKFQO5yNaoLkNQAmwd6S3WZAD+JvyKtcUtpU=;
        b=WyjnSLejXMiacAhhqxDJeYF1KEi8DSKzscxC6Yn7HcxJP7OnD9Lu8colKT2ANmeNLX
         KZSwRP+4vLoo70mVRlXckB47EpNVAwbrKrQIX5PIy54uw0RcTs5vzH4oO78qHs/pqYWd
         ujDZRFYOIyNsQAGHfv+Q4u0sg461U7t+Q9zOEm02ZHVp8QgVdZdwT3rg3mSKR/9Nvwy6
         ZiH4M7DJJw2rkSAReXzUhB93pYg9Uqz6OVy6VThZXu3fEKh1b3GCZ5fJyTJRY0Mq5M4a
         ykYY5MKGmX3JH26XVeqI1hbjHax4MG018HMaOTHpI3b8tf+vFjaTzbpXFuOQko5tG1aq
         JHtw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of p.zabel@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=p.zabel@pengutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of p.zabel@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=p.zabel@pengutronix.de
Message-ID: <1522745178.5089.10.camel@pengutronix.de>
Subject: Re: [PATCH] usb: dwc3: of-simple: use managed and shared reset
 control
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>, linux-usb@vger.kernel.org,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Date: Tue, 03 Apr 2018 10:46:18 +0200
In-Reply-To: <CAK7LNARmw5-d5v41GRPhmVk69obK0gVt_EEGnpydk3GU2UaV9Q@mail.gmail.com>
References: <1522303676-7035-1-git-send-email-yamada.masahiro@socionext.com>
	 <1522742421.5089.1.camel@pengutronix.de>
	 <CAK7LNARmw5-d5v41GRPhmVk69obK0gVt_EEGnpydk3GU2UaV9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: gregkh@linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596251133980885597?=
X-GMAIL-MSGID: =?utf-8?q?1596714055552950819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-04-03 at 17:30 +0900, Masahiro Yamada wrote:
> 2018-04-03 17:00 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> > On Thu, 2018-03-29 at 15:07 +0900, Masahiro Yamada wrote:
> > > This driver handles the reset control in a common manner; deassert
> > > resets before use, assert them after use.  There is no good reason
> > > why it should be exclusive.
> > 
> > Is this preemptive cleanup, or do you have hardware on the horizon that
> > shares these reset lines with other peripherals?
> 
> This patch is necessary for Socionext SoCs.
> 
> The same reset lines are shared between
> this dwc3-of_simple and other glue circuits.

Thanks, this is helpful information.

> > > Also, use devm_ for clean-up.
> > > 
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > ---
> > > 
> > > CCing Philipp Zabel.
> > > I see his sob in commit 06c47e6286d5.
> > 
> > At the time I was concerned with the reset_control_array addition and
> > didn't look closely at the exclusive vs shared issue.
> > >  drivers/usb/dwc3/dwc3-of-simple.c | 7 ++-----
> > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> > > index e54c362..bd6ab65 100644
> > > --- a/drivers/usb/dwc3/dwc3-of-simple.c
> > > +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> > > @@ -91,7 +91,7 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
> > >       platform_set_drvdata(pdev, simple);
> > >       simple->dev = dev;
> > > 
> > > -     simple->resets = of_reset_control_array_get_optional_exclusive(np);
> > > +     simple->resets = devm_reset_control_array_get_optional_shared(dev);
> > 
> > From the usage in the driver, it does indeed look like _shared reset
> > usage is appropriate. I assume that the hardware has no need for the
> > reset to be asserted right before probe or after remove, it just
> > requires that the reset line is kept deasserted while the driver is
> > probed.
> > 
> > >       if (IS_ERR(simple->resets)) {
> > >               ret = PTR_ERR(simple->resets);
> > >               dev_err(dev, "failed to get device resets, err=%d\n", ret);
> > > @@ -100,7 +100,7 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
> > > 
> > >       ret = reset_control_deassert(simple->resets);
> > >       if (ret)
> > > -             goto err_resetc_put;
> > > +             return ret;
> > > 
> > >       ret = dwc3_of_simple_clk_init(simple, of_count_phandle_with_args(np,
> > >                                               "clocks", "#clock-cells"));
> > > @@ -126,8 +126,6 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
> > >  err_resetc_assert:
> > >       reset_control_assert(simple->resets);
> > > 
> > > -err_resetc_put:
> > > -     reset_control_put(simple->resets);
> > >       return ret;
> > >  }
> > > 
> > > @@ -146,7 +144,6 @@ static int dwc3_of_simple_remove(struct platform_device *pdev)
> > >       simple->num_clocks = 0;
> > > 
> > >       reset_control_assert(simple->resets);
> > > -     reset_control_put(simple->resets);
> > > 
> > >       pm_runtime_put_sync(dev);
> > >       pm_runtime_disable(dev);
> > 
> > Changing to devm_ changes the order here. Whether or not it could be a
> > problem to assert the reset only after pm_runtime_put (or potentially
> > never), I can't say. I assume this is a non-issue, but somebody who
> > knows the hardware better would have to decide.
> 
> 
> 
> I do not understand what you mean.

Sorry for the confusion, I have mixed up things here.

> Can you describe your concern in more details?
> 
> I am not touching reset_control_assert() here.

With the change to shared reset control, reset_control_assert
potentially does nothing, so it could be possible that
pm_runtime_put_sync cuts the power before the reset es asserted again.

> I am delaying the call for reset_control_put().

Yes, please disregard my comment about the devm_ change, that should
have no effect whatsoever and looks fine to me.

> If I understand reset_control_put() correctly,
> the effects of this change are:
>   - The ref_count and module ownership for the reset controller
>     driver will be held a little longer
>   - The call for kfree() will be a little bit delayed.

Correct.

> Why do you need knowledge about this hardware?

Is it ok to keep the reset deasserted while the power is cut? Or do you
have to guarantee that drivers sharing the same reset also keep the same
power domains active?

regards
Philipp
