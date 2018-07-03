Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE751C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6339A204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGGqe4ev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6339A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754733AbeGCKPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:15:20 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38432 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754673AbeGCKPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:15:18 -0400
Received: by mail-qt0-f195.google.com with SMTP id c5-v6so1026499qth.5;
        Tue, 03 Jul 2018 03:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EiwHKfSzIvR9rK5eXnKsGb035e/axfazoZ+21J3PVOk=;
        b=VGGqe4ev1vbhdBXQbsyB9enTWz4J4bNWvG5WIfL/7EFIsWBQLwOzVU/u4l3lYRLxtQ
         /t6dOo+STB3cW81hAH/Wl2W8Y0nVXnMv4L/sffBMAQo2Hppt0oFPcYjDzvPDR2CrUYBN
         KurxE45JnA4ES06AJAO418t5Ax55eJJE52FTtCjHbhZY+sPr2XYqE8b0Glptglvm1sDQ
         q1N7iJpcx/svk325zpXQP/NYqpSD43XbaYUDy5RMpIajmYFFu/WoDzu9YV14fyE6302S
         5jE6V86WimGFtFo3ZdkWRhcXkQqQ7x2TOMkjN6oWqXSBFzpXSpZhF3OXLcyyg5UOypEQ
         sfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EiwHKfSzIvR9rK5eXnKsGb035e/axfazoZ+21J3PVOk=;
        b=FVqDHTf/hMlqtfI07Hl09X80pKwl7IpMABJLE8keE02M+xGd+QqlArl9U1A1ccbmbE
         zCtAJbFUPEtDruGF7oNPUDq0ZP+crxbgVMRu8f/4czuh/K1Yzp7n16IlY0uLdLOORQBk
         dz2KPq9H8gVbro7eKITpiYPpZPMNcDMzmN075GhfSFbGUngg19oizT8zcyx2biwO5Upf
         3ffU9MzuVkDxWouyjzD8ZMXU/icWoyRyD5oFyOubGtuD02ubSCpXzO4OQQpLfG34D6zw
         w/3lav5F/YvqQOO0o5w4mfIG3XemRx+zXWEriOemLlajKwq5R3hC7IntzU2ZYf0G/3Oh
         ONlQ==
X-Gm-Message-State: APt69E0MqjgQPhcz363RHFn+yLr4qgEc8W7iQgnS836JUiYyM0VRMqyY
        eHuEWGKOOBAISDXZNCETxFWyoToHb4FUQUbr4TI=
X-Google-Smtp-Source: AAOMgpdwy92cLhjj/gIIKvhAqz/ny5qnfgqDHNgILVJ2Xo0GlqovWxtZ6C3FU9G5QP2ifGVkEGHifJo2KfHdbr6GI+I=
X-Received: by 2002:ac8:2dc1:: with SMTP id q1-v6mr10886502qta.219.1530612917094;
 Tue, 03 Jul 2018 03:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180621220430.25644-1-enric.balletbo@collabora.com>
 <0383b4a703a0b619023c0654a4a7637419c72ebd.camel@collabora.com>
 <addc4280-729f-85d7-a314-35afbb7c8bb1@codeaurora.org> <1e792d3c972998f92109c127886243e32c4cde71.camel@collabora.com>
 <7c67974e40afd15abfca5907b27de097@codeaurora.org>
In-Reply-To: <7c67974e40afd15abfca5907b27de097@codeaurora.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 3 Jul 2018 12:15:05 +0200
Message-ID: <CAFqH_52rh7-DaG+nagxRw=egRqkt2yJtDtkBnVD1hOyf-oVBQg@mail.gmail.com>
Subject: Re: [PATCH v3] PM / devfreq: Fix devfreq_add_device() when drivers
 are built as modules.
To:     akhilpo@codeaurora.org
Cc:     ezequiel@collabora.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

Any comments?

Just a gentle ping to make sure the parallel conversation regarding
the mutex didn't distract you :)

Missatge de l'adre=C3=A7a <akhilpo@codeaurora.org> del dia dv., 22 de juny
2018 a les 23:22:
>
> On 2018-06-22 22:43, Ezequiel Garcia wrote:
> > Hey Akhil,
> >
> > On Fri, 2018-06-22 at 12:33 +0530, Akhil P Oommen wrote:
> >> On 6/22/2018 6:41 AM, Ezequiel Garcia wrote:
> >> > Hey Enric,
> >> >
> >> > On Fri, 2018-06-22 at 00:04 +0200, Enric Balletbo i Serra wrote:
> >> > > When the devfreq driver and the governor driver are built as
> >> > > modules,
> >> > > the call to devfreq_add_device() or governor_store() fails
> >> > > because
> >> > > the
> >> > > governor driver is not loaded at the time the devfreq driver
> >> > > loads.
> >> > > The
> >> > > devfreq driver has a build dependency on the governor but also
> >> > > should
> >> > > have a runtime dependency. We need to make sure that the governor
> >> > > driver
> >> > > is loaded before the devfreq driver.
> >> > >
> >> > > This patch fixes this bug by adding a try_then_request_governor()
> >> > > function. First tries to find the governor, and then, if it is
> >> > > not
> >> > > found,
> >> > > it requests the module and tries again.
> >> > >
> >> > > Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to
> >> > > governor
> >> > > using name)
> >> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.c
> >> > > om>
> >> > > ---
> >> > >
> >> > > Changes in v3:
> >> > > - Remove unneded change in dev_err message.
> >> > > - Fix err returned value in case to not find the governor.
> >> > >
> >> > > Changes in v2:
> >> > > - Add a new function to request the module and call that function
> >> > > from
> >> > >    devfreq_add_device and governor_store.
> >> > >
> >> > >   drivers/devfreq/devfreq.c | 65
> >> > > ++++++++++++++++++++++++++++++++-----
> >> > > --
> >> >
> >> > [snip snip]
> >> > > -        governor =3D find_devfreq_governor(devfreq-
> >> > > >governor_name);
> >> > > +        governor =3D try_then_request_governor(devfreq-
> >> > > > governor_name);
> >> > >
> >> > >          if (IS_ERR(governor)) {
> >> > >                  dev_err(dev, "%s: Unable to find governor for
> >> > > the
> >> > > device\n",
> >> > >                          __func__);
> >> > >                  err =3D PTR_ERR(governor);
> >> > > -                goto err_init;
> >> > > +                goto err_unregister;
> >> > >          }
> >> > >
> >> > > +        mutex_lock(&devfreq_list_lock);
> >> > > +
> >> >
> >> > I know it's not something we are introducing in this patch,
> >> > but still... calling a hook with a mutex held looks
> >> > fishy to me.
> >> >
> >> > This lock should only protect the list, unless I am missing
> >> > something.
> >> >
> >> > >          devfreq->governor =3D governor;
> >> > >          err =3D devfreq->governor->event_handler(devfreq,
> >> > > DEVFREQ_GOV_START,
> >> > >                                                  NULL);
> >> > > @@ -663,14 +703,16 @@ struct devfreq *devfreq_add_device(struct
> >> > > device *dev,
> >> > >                          __func__);
> >> > >                  goto err_init;
> >> > >          }
> >> > > +
> >> > > +        list_add(&devfreq->node, &devfreq_list);
> >> > > +
> >> > >          mutex_unlock(&devfreq_list_lock);
> >> > >
> >> > >          return devfreq;
> >> > >
> >> > >   err_init:
> >> > > -        list_del(&devfreq->node);
> >> > >          mutex_unlock(&devfreq_list_lock);
> >> > > -
> >> > > +err_unregister:
> >> > >          device_unregister(&devfreq->dev);
> >> > >   err_dev:
> >> > >          if (devfreq)
> >> > > @@ -988,12 +1030,13 @@ static ssize_t governor_store(struct
> >> > > device
> >> > > *dev, struct device_attribute *attr,
> >> > >          if (ret !=3D 1)
> >> > >                  return -EINVAL;
> >> > >
> >> > > -        mutex_lock(&devfreq_list_lock);
> >> > > -        governor =3D find_devfreq_governor(str_governor);
> >> > > +        governor =3D try_then_request_governor(str_governor);
> >> > >          if (IS_ERR(governor)) {
> >> > > -                ret =3D PTR_ERR(governor);
> >> > > -                goto out;
> >> > > +                return PTR_ERR(governor);
> >> > >          }
> >> > > +
> >> > > +        mutex_lock(&devfreq_list_lock);
> >> > > +
> >> > >          if (df->governor =3D=3D governor) {
> >> > >                  ret =3D 0;
> >> > >                  goto out;
> >> > > --
> >> > > 2.17.1
> >> > >
> >> > >
> >> >
> >> > Regards,
> >> > Eze
> >>
> >> Adding to Ezequiel's point, shouldn't we take more granular lock
> >> (devfreq->lock) first and then call devfreq_list_lock at the time of
> >> adding to the list?
> >>
> >
> > Not sure why we should do that. devfreq->lock should be used to
> > protect the struct devfreq state, while the devfreq_list_lock
> > is apparently protecting the two lists (which seem unrelated
> > lists).
> >
> > So, the two locks are not correlated.
> >
> > Regards,
> > Eze
> In governor_store(), we do 'df->governor =3D governor;' without taking
> df->lock. So it is possible to switch governor while update_devfreq() is
> in progress. I smell trouble there. Don't you think so?
> I am assuming df->lock protects 'struct devfreq' and devfreq_list_lock
> protects both device and governor lists.
>
> -Akhil.
