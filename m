Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A204FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 01:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B43E21917
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 01:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ba88Flh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391008AbeLVBAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 20:00:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39230 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbeLVBAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 20:00:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id r136so3325225pfc.6;
        Fri, 21 Dec 2018 17:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jwvumPValvImZ31yM8lim6Kj24vFECzKjBWoI+Dz0m8=;
        b=Ba88Flh57PwVmcDDFGi2nrhU7MoE63toqE3E1aBZ+HtZfr4yR6ExwQJ4BnpWYtbsef
         0sL4d/f0PJR5bjQCwFqnsuWdNHgma/sAvCr1DY5r5s3R0cf8O56rVTTviWfBozINNmUb
         RrW9ZUvM03LS3b6cIQHuoMqxm4LQWjimB2oeD9AjBYL9wFYc0k/X5O6TngvjfufQGCz0
         flLbPc+BkfoEt149TZabTKPcc+4+yaDwDJjEW4j4+ZLdxPOyhI6Hp3nrF7rVhmz+CChs
         3JHqEoC77wlqRdH7tZH/EAcEqDd9M0+wH0Y8OBnBMW68Ndf6PvxPb/GmLcTZCBhTdMgP
         9xgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jwvumPValvImZ31yM8lim6Kj24vFECzKjBWoI+Dz0m8=;
        b=fWz3e2kFATj+LV5qicQnwUjQZL2hpaylNvt2+W29sMHQs6otSI8vBVmdTNp6WNBu4J
         P5weC5Vl6az375mBUsHMqciw96YkOg3vI/zbHuUyFX1QRj55Ng4rwRjkdQzW8DzRDk+T
         Y2gi7adKSjRl1PqZRhF3e/uQs6hubwQeCx5hDDTrM/XV6exToPh/5VJoWEgi3fd4dW+a
         FHDKg5tQBMoPejKcrNLqhVm2Tb5Be87r/JBztbo3QOiBrefylTdpyAqNH/7cLDWmXSsq
         LHfA/FySyilMj2+if91Z7BZ6xOZjzPxt7wLWAFKr6K4dp0P5sVPB/h7c4s6AwZTsfa/T
         BHCQ==
X-Gm-Message-State: AJcUuke9WIcjtVFZjOqMh8v9ZjFpmPSIo4mFlV4LVX7N4y1yhzSc5Aun
        0LeGI+SfuiUg9dMKqKokCLw=
X-Google-Smtp-Source: ALg8bN4TVV1WO8BSy37uXZhwMYe/uEHc4JqUCvu0LJiKqT4xV4Bysx214812RDb779RSdgSxZbIf9Q==
X-Received: by 2002:a65:6094:: with SMTP id t20mr4408444pgu.285.1545440433285;
        Fri, 21 Dec 2018 17:00:33 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id j70sm34461881pfc.43.2018.12.21.17.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 17:00:32 -0800 (PST)
Date:   Fri, 21 Dec 2018 17:00:30 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Joe Perches <joe@perches.com>, linux-input@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] touchscreen: elants: fix a missing check of return values
Message-ID: <20181222010030.GA31346@dtor-ws>
References: <20181221065919.60129-1-kjlu@umn.edu>
 <20181221082725.GB211587@dtor-ws>
 <CAK8KejrnOwVmjUGTtx5oBQ2QAWTy1-_2QMHTLSNs2Vy=a=mQCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8KejrnOwVmjUGTtx5oBQ2QAWTy1-_2QMHTLSNs2Vy=a=mQCQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 03:05:29PM -0600, Kangjie Lu wrote:
> Hi Dmitry,
> 
> Thanks for the feedback.
> 
> On Fri, Dec 21, 2018 at 2:27 AM Dmitry Torokhov <dmitry.torokhov@gmail.com>
> wrote:
> 
> > Hi Kangjie,
> >
> > On Fri, Dec 21, 2018 at 12:59:16AM -0600, Kangjie Lu wrote:
> > > elants_i2c_send() may fail, let's check its return values. The fix does
> > > the check and reports an error message upon the failure.
> > >
> > > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > > ---
> > >  drivers/input/touchscreen/elants_i2c.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/input/touchscreen/elants_i2c.c
> > b/drivers/input/touchscreen/elants_i2c.c
> > > index f2cb23121833..cb3c1470bb68 100644
> > > --- a/drivers/input/touchscreen/elants_i2c.c
> > > +++ b/drivers/input/touchscreen/elants_i2c.c
> > > @@ -245,8 +245,14 @@ static int elants_i2c_calibrate(struct elants_data
> > *ts)
> > >       ts->state = ELAN_WAIT_RECALIBRATION;
> > >       reinit_completion(&ts->cmd_done);
> > >
> > > -     elants_i2c_send(client, w_flashkey, sizeof(w_flashkey));
> > > -     elants_i2c_send(client, rek, sizeof(rek));
> > > +     error = elants_i2c_send(client, w_flashkey, sizeof(w_flashkey));
> > > +     error |= elants_i2c_send(client, rek, sizeof(rek));
> >
> > I dislike this kind of error handling as this may result in invalid
> > error code being reported, in case 2 commands produce different results.
> >
> 
> I will fix this.
> 
> 
> > > +     if (error) {
> > > +             dev_err(&client->dev,
> > > +                             "error in sending I2C messages for
> > calibration: %d\n",
> > > +                             error);
> > > +             return error;
> >
> > If we just return like you do it here, interrupts will stay disabled and
> > touchscreen will be completely dead. With the old code we'd report
> > timeout on calibration, and touchscreen would have chance of working. We
> > would also be able to retry calibration.
> >
> 
> How about this: we print out the error message but still continue the
> following execution?

Yes, we could do dev_warn() here, but elants_i2c_send() already logs
errors, so I do not see much benefit from doing this.

> Also, if elants_i2c_send() fails,
> would wait_for_completion_interruptible_timeout() always capture a timeout?

Well, if controller does not get the calibration command(s) it will not
do anything and at worst in <timeout> time
wait_for_completion_interruptible_timeout() will return and we will
properly report this condition.

Another option is to rearrange the code to ensure we are not leaving
interrupts disabled on error.

Thanks.

-- 
Dmitry
