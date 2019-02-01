Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBADC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346D420811
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXe80BnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfBAISs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:18:48 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50274 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfBAISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:18:47 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so7967632iti.0;
        Fri, 01 Feb 2019 00:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EhdkLYPhIrkywla6ZFsePAbGcVZ1glcLH7OXk2ftQw4=;
        b=dXe80BnBenz0ZHQsl4hitk2D+AhkvCAQvrBj73GwQKOXx2okoZ3YzjDJD6QM6oSVMi
         gfUWbqQeTg+voas/EgI/EFrTIaOJFedUhtLaPba9Lvzs8dm+btBqIcFDudDqYXQgEvOa
         LfIbXzqTA7rWAerH9DKfKeQ1N1xgp7+A6ZIe/W9uMt9DuZAD1yOchcRWAcoV/eTNyDxs
         2C1l2fDjPtX9nCXxIjbqFvmobBtv3mq3FG6yUX6TZaLSNKwMeAizAbPzMpieYR6hNovV
         KmdjqB+q7m4Qp6rjD8mlBWO4s0m8GAVBXBQVxUYQNpZzIQw0uRFqTrsAv/ZQo+pgWYip
         5Chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EhdkLYPhIrkywla6ZFsePAbGcVZ1glcLH7OXk2ftQw4=;
        b=ftaL9wmeOtVaujn8yM3Q3iRRS6DRzb7cBR6ASfSt7CBJF/fhMkT6Y2js3hjsEK6G5P
         H9Qnhsv4ohfG2blhc1P66rRW07ZyO9mVQgr1ndAIoZ8SFsWzji4Yx6bdBT8oJiA0kRZc
         Hq9A45JzobzEPLlM3I0y5ZosdqxsUd2usIUKPo2iDlEtoH2hKY9vMZgZsPQhxZ+NTNsB
         e9OsX5XgsmQ9eXS4RsEuqhB2qXPk0+c1XdIF7BCYDn2JSDujzr4MYPnWiP91pLnQhFmT
         xkbOKUpiaIyU2ELSuM7YUauE0rvcmPWOQyF4o5ZMKrkxPKyNevNyGIFC/SGNq2u7yKcT
         upmA==
X-Gm-Message-State: AHQUAuawnNIoZTz0pfHc7ye673Lrza5/Hprd+10eyXZKQ6g+9KSmP7VW
        BdeBvGZ6VAacefi7BEEmEzZhXA7kSfkIwfc4AoQ=
X-Google-Smtp-Source: AHgI3IargkMixzub0Z9jZjo7F+uwW8dpa5F1wggx0785MeVnGZmqvDOtIGqXzVcYIH8IhLMwJZqABPDBpRvVwSJbduQ=
X-Received: by 2002:a24:36cf:: with SMTP id l198mr872220itl.102.1549009126294;
 Fri, 01 Feb 2019 00:18:46 -0800 (PST)
MIME-Version: 1.0
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
 <20181215151802.18592-3-jagan@amarulasolutions.com> <20190107230009.wfzozb6g6ucymngw@penguin>
 <CAMty3ZB_=VaX+_03B=ATVKzRyBHnTijC3Z8y3+DNAZcPf-=3-Q@mail.gmail.com>
In-Reply-To: <CAMty3ZB_=VaX+_03B=ATVKzRyBHnTijC3Z8y3+DNAZcPf-=3-Q@mail.gmail.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Fri, 1 Feb 2019 00:18:35 -0800
Message-ID: <CAKdAkRR8MQvh2CQ6+6d1LcX28CmRASXvmqc3QoJaoMEz92=uxg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] Input: goodix - Add AVDD28-supply regulator support
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 12:00 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Wed, Jan 9, 2019 at 1:10 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Jagan,
> >
> > On Sat, Dec 15, 2018 at 08:48:00PM +0530, Jagan Teki wrote:
> > > Goodix CTP controllers have AVDD28 pin connected to voltage
> > > regulator which may not be turned on by default, like for GT5663.
> > >
> > > Add support for such ctp used boards by adding voltage regulator
> > > handling code to goodix ctp driver.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  drivers/input/touchscreen/goodix.c | 33 +++++++++++++++++++++++++-----
> > >  1 file changed, 28 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> > > index f2d9c2c41885..7371f6946098 100644
> > > --- a/drivers/input/touchscreen/goodix.c
> > > +++ b/drivers/input/touchscreen/goodix.c
> > > @@ -27,6 +27,7 @@
> > >  #include <linux/delay.h>
> > >  #include <linux/irq.h>
> > >  #include <linux/interrupt.h>
> > > +#include <linux/regulator/consumer.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/acpi.h>
> > >  #include <linux/of.h>
> > > @@ -47,6 +48,7 @@ struct goodix_ts_data {
> > >       struct touchscreen_properties prop;
> > >       unsigned int max_touch_num;
> > >       unsigned int int_trigger_type;
> > > +     struct regulator *avdd28;
> > >       struct gpio_desc *gpiod_int;
> > >       struct gpio_desc *gpiod_rst;
> > >       u16 id;
> > > @@ -786,25 +788,41 @@ static int goodix_ts_probe(struct i2c_client *client,
> > >       if (error)
> > >               return error;
> > >
> > > +     ts->avdd28 = devm_regulator_get(&client->dev, "AVDD28");
> > > +     if (IS_ERR(ts->avdd28)) {
> > > +             error = PTR_ERR(ts->avdd28);
> > > +             if (error != -EPROBE_DEFER)
> > > +                     dev_err(&client->dev,
> > > +                             "Failed to get AVDD28 regulator: %d\n", error);
> > > +             return error;
> > > +     }
> > > +
> > > +     /* power the controller */
> > > +     error = regulator_enable(ts->avdd28);
> > > +     if (error) {
> > > +             dev_err(&client->dev, "Controller fail to enable AVDD28\n");
> > > +             return error;
> > > +     }
> > > +
> > >       if (ts->gpiod_int && ts->gpiod_rst) {
> > >               /* reset the controller */
> > >               error = goodix_reset(ts);
> > >               if (error) {
> > >                       dev_err(&client->dev, "Controller reset failed.\n");
> > > -                     return error;
> > > +                     goto error;
> > >               }
> > >       }
> > >
> > >       error = goodix_i2c_test(client);
> > >       if (error) {
> > >               dev_err(&client->dev, "I2C communication failure: %d\n", error);
> > > -             return error;
> > > +             goto error;
> > >       }
> > >
> > >       error = goodix_read_version(ts);
> > >       if (error) {
> > >               dev_err(&client->dev, "Read version failed.\n");
> > > -             return error;
> > > +             goto error;
> > >       }
> > >
> > >       ts->chip = goodix_get_chip_data(ts->id);
> > > @@ -823,23 +841,28 @@ static int goodix_ts_probe(struct i2c_client *client,
> > >                       dev_err(&client->dev,
> > >                               "Failed to invoke firmware loader: %d\n",
> > >                               error);
> > > -                     return error;
> > > +                     goto error;
> > >               }
> > >
> > >               return 0;
> > >       } else {
> > >               error = goodix_configure_dev(ts);
> > >               if (error)
> > > -                     return error;
> > > +                     goto error;
> > >       }
> > >
> > >       return 0;
> > > +
> > > +error:
> > > +     regulator_disable(ts->avdd28);
> > > +     return error;
> > >  }
> > >
> > >  static int goodix_ts_remove(struct i2c_client *client)
> > >  {
> > >       struct goodix_ts_data *ts = i2c_get_clientdata(client);
> > >
> > > +     regulator_disable(ts->avdd28);
> >
> > This may be disabling the regulator too early. Please use
> > devm_add_action_or_reset() to install a custom devm handler that would
> > disable the regulator in line with the rest of devm unwinding flow.
>
> Like handler with only regulator_disable?

Right.

> and would that call from suspend or not need?

No, it will only be called when device is unbound from the driver or
when probe fails. If you need to control regulator in suspend/resume
you can do it with normal regulator_enable() and regulator_disable()
calls.

Thanks.

-- 
Dmitry
