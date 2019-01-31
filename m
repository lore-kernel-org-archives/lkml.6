Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708BAC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A000620881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jOTe0bSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfAaUAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:00:18 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34854 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfAaUAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:00:17 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so6320991itp.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 12:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mV2h2Z6gsMWqvBHBLwk47tNlMlUPLbAXigoNg6LSwls=;
        b=jOTe0bSUgANtindrC0JMbvE5/YIRiIG5pA2U24KQAVtMbh/ztdnf2ngTZXSzOQJprR
         v/rACFNIvAO9Q25BhFNCLOOB40FCTptNuyPjhJJArqqXNFqscj1kh6oolDth9CG4oOVb
         xDJSWCPftXusdN96sMjsp6ZHEhLMgbZG3EWw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mV2h2Z6gsMWqvBHBLwk47tNlMlUPLbAXigoNg6LSwls=;
        b=Af3+LLIThNxxOo/jyMBXrn8NWc5jmr+Dhknq31ZnNJbo3SdE7AuFMSKjNkaS+yszfy
         y/05dCDSiYv4cs30YLY92EHX29ds7TAlxcUQ8YDKgmdvyucDLYpicB56MWEJcv23F0p9
         105NUT2Q7Dmf0G+EIBWJ/XeajlStrFlIWIdfX8tIsoSW4EKrdUDHtLEqSzYQnfezxCdj
         wTZzEUr0jIFwUvUJaAb1lWUZQKBNDMwGnQM6SbezpL+VTksBHX42KUQztkC/BuqSrZ9r
         +k46YVgdMXtTYgPSXBQw2tycn1ohjMeCJrnWuPsktwwdh2HEiB71RnrZKwLoLgzvzK/e
         gPeA==
X-Gm-Message-State: AJcUukctpq8A4Qz6438/3X0PVJ3klLDBHyYnSpJNLAATktFlrGJrCi7q
        QOkQRPXlweRGEY0St5NAl1wlyj2wHmOvJWI7nYFlmw==
X-Google-Smtp-Source: ALg8bN5r9UFy165HAgal0S+P+8z/pZnnxITrdLKvxU0ZFUqDiigLuLeyFVKaFcsByJPSJyrAhygQ+DltKm/KQovyZHs=
X-Received: by 2002:a24:4f07:: with SMTP id c7mr19885836itb.107.1548964816432;
 Thu, 31 Jan 2019 12:00:16 -0800 (PST)
MIME-Version: 1.0
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
 <20181215151802.18592-3-jagan@amarulasolutions.com> <20190107230009.wfzozb6g6ucymngw@penguin>
In-Reply-To: <20190107230009.wfzozb6g6ucymngw@penguin>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 1 Feb 2019 01:30:04 +0530
Message-ID: <CAMty3ZB_=VaX+_03B=ATVKzRyBHnTijC3Z8y3+DNAZcPf-=3-Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] Input: goodix - Add AVDD28-supply regulator support
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 1:10 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Jagan,
>
> On Sat, Dec 15, 2018 at 08:48:00PM +0530, Jagan Teki wrote:
> > Goodix CTP controllers have AVDD28 pin connected to voltage
> > regulator which may not be turned on by default, like for GT5663.
> >
> > Add support for such ctp used boards by adding voltage regulator
> > handling code to goodix ctp driver.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/input/touchscreen/goodix.c | 33 +++++++++++++++++++++++++-----
> >  1 file changed, 28 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> > index f2d9c2c41885..7371f6946098 100644
> > --- a/drivers/input/touchscreen/goodix.c
> > +++ b/drivers/input/touchscreen/goodix.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/irq.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <linux/slab.h>
> >  #include <linux/acpi.h>
> >  #include <linux/of.h>
> > @@ -47,6 +48,7 @@ struct goodix_ts_data {
> >       struct touchscreen_properties prop;
> >       unsigned int max_touch_num;
> >       unsigned int int_trigger_type;
> > +     struct regulator *avdd28;
> >       struct gpio_desc *gpiod_int;
> >       struct gpio_desc *gpiod_rst;
> >       u16 id;
> > @@ -786,25 +788,41 @@ static int goodix_ts_probe(struct i2c_client *client,
> >       if (error)
> >               return error;
> >
> > +     ts->avdd28 = devm_regulator_get(&client->dev, "AVDD28");
> > +     if (IS_ERR(ts->avdd28)) {
> > +             error = PTR_ERR(ts->avdd28);
> > +             if (error != -EPROBE_DEFER)
> > +                     dev_err(&client->dev,
> > +                             "Failed to get AVDD28 regulator: %d\n", error);
> > +             return error;
> > +     }
> > +
> > +     /* power the controller */
> > +     error = regulator_enable(ts->avdd28);
> > +     if (error) {
> > +             dev_err(&client->dev, "Controller fail to enable AVDD28\n");
> > +             return error;
> > +     }
> > +
> >       if (ts->gpiod_int && ts->gpiod_rst) {
> >               /* reset the controller */
> >               error = goodix_reset(ts);
> >               if (error) {
> >                       dev_err(&client->dev, "Controller reset failed.\n");
> > -                     return error;
> > +                     goto error;
> >               }
> >       }
> >
> >       error = goodix_i2c_test(client);
> >       if (error) {
> >               dev_err(&client->dev, "I2C communication failure: %d\n", error);
> > -             return error;
> > +             goto error;
> >       }
> >
> >       error = goodix_read_version(ts);
> >       if (error) {
> >               dev_err(&client->dev, "Read version failed.\n");
> > -             return error;
> > +             goto error;
> >       }
> >
> >       ts->chip = goodix_get_chip_data(ts->id);
> > @@ -823,23 +841,28 @@ static int goodix_ts_probe(struct i2c_client *client,
> >                       dev_err(&client->dev,
> >                               "Failed to invoke firmware loader: %d\n",
> >                               error);
> > -                     return error;
> > +                     goto error;
> >               }
> >
> >               return 0;
> >       } else {
> >               error = goodix_configure_dev(ts);
> >               if (error)
> > -                     return error;
> > +                     goto error;
> >       }
> >
> >       return 0;
> > +
> > +error:
> > +     regulator_disable(ts->avdd28);
> > +     return error;
> >  }
> >
> >  static int goodix_ts_remove(struct i2c_client *client)
> >  {
> >       struct goodix_ts_data *ts = i2c_get_clientdata(client);
> >
> > +     regulator_disable(ts->avdd28);
>
> This may be disabling the regulator too early. Please use
> devm_add_action_or_reset() to install a custom devm handler that would
> disable the regulator in line with the rest of devm unwinding flow.

Like handler with only regulator_disable? and would that call from
suspend or not need?
