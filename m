Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5E6C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE614208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkPlvHT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE614208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967459AbeFRJDL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:03:11 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46476 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967025AbeFRJDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:03:07 -0400
Received: by mail-qt0-f194.google.com with SMTP id h5-v6so14423477qtm.13;
        Mon, 18 Jun 2018 02:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X9WIJ8+jZg1sbYl85qVYfkRoFB4RTicctCVYz1QnyAg=;
        b=FkPlvHT31VFylhwUzVYEi5GI0ovAIPW85pVQ9u4oov0tmVtScKQxVCzzwdiyG2pXcD
         HjnGoU7wQRs+Gee/fVflTCEekRjASpTUDsJZipmGX2ZWakgeIZuqn1jVasQqvjvmKZUx
         H3epJ6eZojJjKX0MntLyJ1f7J0Wb1J0qz/vwXxNxARgeIovLk8/tvVjSNj1IWNwxMsbP
         QRlz/U7A49irGnFNL3Z++ZaHTwKOqKIbei6zcupIjNJKHQgHv1JOXb1T2ymtvMTmI/Gh
         zzPIlUecz3wghi7kFKRn8Fg7QXNknMZsfv/LbnGe8bwNhpTfnZsUgnsYla5emq8msHqr
         fFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X9WIJ8+jZg1sbYl85qVYfkRoFB4RTicctCVYz1QnyAg=;
        b=pNn+5Za7IdPDICz8uB7e3CILyYxpKqWw+H4Jdy3B5mcmL7lXApUrVF63ma9pFJuXUl
         iFUepVwQH7tYi5IxtSp7gscB4AtEWhzHESQ5rNQ1Z3NN3FXmoetT4ezlR9AonyYj+Dup
         V3kP4S+yYjh6nrHuvaekhCHfZ+BZTgJUm0ipuXXaIyIGfeQeSwLR+VKeCW+wYo8CAyFW
         qVph5o7rdQrx0VnuN5GJqrJMUI3zTMwY0+eTTjpU8DTLW2Aal4LLIJqF2FRhzCCC4OAH
         7IO7kqSUKVGIjSbazd7qsBEsFa27ssBz6/L9GpqwG4//7L3P3JAWhOIrm7qVg6mH1T69
         9i4A==
X-Gm-Message-State: APt69E3I7nQ+ULn9C/z8ARo3v9aj9AHdqx9/xqCwGurHpYXESluC52+m
        ED4Kc18XjGRko8q/hS2fy8pL0gzy8YYXkyM0I9E=
X-Google-Smtp-Source: ADUXVKI6i1oYcAuID6J4wNTlHuoeiyoo/MMrZXZH+UJkFAVmQu99HiX99519i33gE1xSS5DYAstACKuWrhuhMli/edM=
X-Received: by 2002:ac8:3617:: with SMTP id m23-v6mr10089080qtb.219.1529312586087;
 Mon, 18 Jun 2018 02:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180615100452.17466-1-enric.balletbo@collabora.com> <CAGTfZH1QkzBjDPfsS23DgVF=EqO1P9RK+YdAnAwt2rDL6eGPTg@mail.gmail.com>
In-Reply-To: <CAGTfZH1QkzBjDPfsS23DgVF=EqO1P9RK+YdAnAwt2rDL6eGPTg@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 18 Jun 2018 11:02:54 +0200
Message-ID: <CAFqH_5344NDHup+u0QtimTJjKaVVj46YB6UDMKtdMr70JJmkng@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: Fix devfreq_add_device() when drivers are
 built as modules.
To:     cwchoi00@gmail.com
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,
Missatge de Chanwoo Choi <cwchoi00@gmail.com> del dia dg., 17 de juny
2018 a les 5:50:
>
> Hi Enric,
>
> This issue will happen on the position to use find_devfreq_governor()
> as following:
> - devfreq_add_governora() and governor_store()
>
> If device driver with module type after loaded want to change the
> scaling governor,
> new governor might be not yet loaded. So, devfreq bettero to consider this case
> in the find_devfreq_governor().
>
Ok, I'll move there and send a v2.

Thanks
 Enric.


> 2018-06-15 19:04 GMT+09:00 Enric Balletbo i Serra
> <enric.balletbo@collabora.com>:
> > When the devfreq driver and the governor driver are built as modules,
> > the call to devfreq_add_device() fails because the governor driver is
> > not loaded at the time the devfreq driver loads. The devfreq driver has
> > a build dependency on the governor but also should have a runtime
> > dependency. We need to make sure that the governor driver is loaded
> > before the devfreq driver.
> >
> > This patch fixes this bug in devfreq_add_device(). First tries to find
> > the governor, and then, if was not found, it requests the module and
> > tries again.
> >
> > Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor using name)
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >
> >  drivers/devfreq/devfreq.c | 36 +++++++++++++++++++++++++++++++-----
> >  1 file changed, 31 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index fe2af6aa88fc..1d917f043e30 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -11,6 +11,7 @@
> >   */
> >
> >  #include <linux/kernel.h>
> > +#include <linux/kmod.h>
> >  #include <linux/sched.h>
> >  #include <linux/errno.h>
> >  #include <linux/err.h>
> > @@ -648,10 +649,35 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >
> >         governor = find_devfreq_governor(devfreq->governor_name);
> >         if (IS_ERR(governor)) {
> > -               dev_err(dev, "%s: Unable to find governor for the device\n",
> > -                       __func__);
> > -               err = PTR_ERR(governor);
> > -               goto err_init;
> > +               list_del(&devfreq->node);
> > +               mutex_unlock(&devfreq_list_lock);
> > +
> > +               /*
> > +                * If the governor is not found, then request the module and
> > +                * try again. This can happen when both drivers (the governor
> > +                * driver and the driver that calls devfreq_add_device) are
> > +                * built as modules.
> > +                */
> > +               if (!strncmp(devfreq->governor_name,
> > +                            DEVFREQ_GOV_SIMPLE_ONDEMAND, DEVFREQ_NAME_LEN))
> > +                       err = request_module("governor_%s", "simpleondemand");
> > +               else
> > +                       err = request_module("governor_%s",
> > +                                            devfreq->governor_name);
> > +               if (err)
> > +                       goto err_unregister;
> > +
> > +               mutex_lock(&devfreq_list_lock);
> > +               list_add(&devfreq->node, &devfreq_list);
> > +
> > +               governor = find_devfreq_governor(devfreq->governor_name);
> > +               if (IS_ERR(governor)) {
> > +                       dev_err(dev,
> > +                               "%s: Unable to find governor for the device\n",
> > +                               __func__);
> > +                       err = PTR_ERR(governor);
> > +                       goto err_init;
> > +               }
> >         }
> >
> >         devfreq->governor = governor;
> > @@ -669,7 +695,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >  err_init:
> >         list_del(&devfreq->node);
> >         mutex_unlock(&devfreq_list_lock);
> > -
> > +err_unregister:
> >         device_unregister(&devfreq->dev);
> >  err_dev:
> >         if (devfreq)
> > --
> > 2.17.1
> >
>
>
>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
