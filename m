Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448BAC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0341420823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP4p4gHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfAUH0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:26:20 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37078 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbfAUH0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:26:17 -0500
Received: by mail-it1-f194.google.com with SMTP id b5so13890141iti.2;
        Sun, 20 Jan 2019 23:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P7L47SeNL8gKRFMa6DNEXYkSDaR1nIU0kO1QecejcVQ=;
        b=eP4p4gHUK/ChLsEzsmw89/vLBbCLszwDfLWEaKGlAYXO9sqcX1d9w1PsORamRofcTW
         GJMb3w+Vp4GueaUeoEAkfzRmff6VUpad3XFXNoGMNKaB0gAdfrtehNDxNnrRwx4AqA4v
         tWu4QeK9sfdTuBRkQHqVdSzHFFvfwAj+AlI0H3vDvbZdKdKZIE14xHcA7PpWZCvYuBQv
         3wmYU97P1JyVVP3CNmshYn22AIS48cowvRiYAAZ5MCK8KwU4uEgjB46apnfcrs/0UWMF
         LlJLbeEg84//PwgsBekF5ZvmHOifKehPPOcnjVt428ezAQ286GUTSb+WLsVi29z3V03S
         45Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P7L47SeNL8gKRFMa6DNEXYkSDaR1nIU0kO1QecejcVQ=;
        b=eK0NtCOsUXaM+Llbk2Ydz0C5HuTItMdVWv+MY8yzsb4UuusNLbqY91VK+6Q19p2xxZ
         2boaog2XKboMOv6DbDsVY+n9tDlaveMjBvN5D0rPPHPdRNGOyafCjoviAe/m5A1mFdez
         hBIInAfaO9ykYcnh8ZG99k1EHlbjR/WMz/09Qg2Y39wTPdL3LKG7bOus9gDWt1iI8RmF
         M6AJJHFlCr5/SIkswG/tIC/589gU8J0sNJXcDBsw3XHJKSLiUZY80vbLuUbioSuUbZiW
         Eooh3lq49pJizhJdwMj3X7dOhospiDoEVNQQyoFz5A1LOL1JwmdaY1mJ9lxjUbJ2l9Gr
         wsyQ==
X-Gm-Message-State: AJcUukcnoxKQj5RJ264hAT6cGw/dGFNHBLrkL+4a3BfVlJThqRGub5IA
        K6eOkd4bXajuuChGBcPa9p3U3h115XymWgKPwbIkItZEoKE=
X-Google-Smtp-Source: ALg8bN6ND5f1jmZ5NrPM1hX/ayEeM6OXO+2k/Z9p1u6y4npIvAVE8WeZJTLcMcDk4npvn4hMjmkKqyzbwa1knLiAK7g=
X-Received: by 2002:a24:7b90:: with SMTP id q138mr15285205itc.37.1548039635298;
 Sun, 20 Jan 2019 19:00:35 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190121021940epcms1p57620581b960dba9805dfddee903ccd6c@epcms1p5>
 <20190121021940epcms1p57620581b960dba9805dfddee903ccd6c@epcms1p5> <eb5b190b-0940-1ab1-5d28-0803f31e9448@samsung.com>
In-Reply-To: <eb5b190b-0940-1ab1-5d28-0803f31e9448@samsung.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Mon, 21 Jan 2019 10:59:31 +0800
Message-ID: <CAEExFWtQBSg+jbH3fRJn0s5C9wqmPZTOPL=YPfMh-Q3yFd0Ovg@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: consistent indentation
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:28 AM Chanwoo Choi <cw00.choi@samsung.com> wrote=
:
>
> On 19. 1. 21. =EC=98=A4=EC=A0=84 11:19, MyungJoo Ham wrote:
> > Following up with complaints on inconsistent indentation from
> > Yangtao Li, this fixes indentation inconsistency.
> >
> > In principle, this tries to put arguments aligned to the left
> > including the first argument except for in the case where
> > the first argument is on the far-right side.
Acked-by: Yangtao Li <tiny.windzz@gmail.com>
> >
> > Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> > ---
> >  drivers/devfreq/devfreq.c | 49 +++++++++++++++++++++++----------------=
--------
> >  1 file changed, 24 insertions(+), 25 deletions(-)
>
> Looks better before.
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>
> >
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 4af608a..428a1de 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -528,7 +528,7 @@ void devfreq_interval_update(struct devfreq *devfre=
q, unsigned int *delay)
> >               mutex_lock(&devfreq->lock);
> >               if (!devfreq->stop_polling)
> >                       queue_delayed_work(devfreq_wq, &devfreq->work,
> > -                           msecs_to_jiffies(devfreq->profile->polling_=
ms));
> > +                             msecs_to_jiffies(devfreq->profile->pollin=
g_ms));
> >       }
> >  out:
> >       mutex_unlock(&devfreq->lock);
> > @@ -537,7 +537,7 @@ EXPORT_SYMBOL(devfreq_interval_update);
> >
> >  /**
> >   * devfreq_notifier_call() - Notify that the device frequency requirem=
ents
> > - *                      has been changed out of devfreq framework.
> > + *                        has been changed out of devfreq framework.
> >   * @nb:              the notifier_block (supposed to be devfreq->nb)
> >   * @type:    not used
> >   * @devp:    not used
> > @@ -683,12 +683,11 @@ struct devfreq *devfreq_add_device(struct device =
*dev,
> >               goto err_out;
> >       }
> >
> > -     devfreq->trans_table =3D
> > -             devm_kzalloc(&devfreq->dev,
> > -                          array3_size(sizeof(unsigned int),
> > -                                      devfreq->profile->max_state,
> > -                                      devfreq->profile->max_state),
> > -                          GFP_KERNEL);
> > +     devfreq->trans_table =3D devm_kzalloc(&devfreq->dev,
> > +                     array3_size(sizeof(unsigned int),
> > +                                 devfreq->profile->max_state,
> > +                                 devfreq->profile->max_state),
> > +                     GFP_KERNEL);
> >       if (!devfreq->trans_table) {
> >               mutex_unlock(&devfreq->lock);
> >               err =3D -ENOMEM;
> > @@ -696,9 +695,9 @@ struct devfreq *devfreq_add_device(struct device *d=
ev,
> >       }
> >
> >       devfreq->time_in_state =3D devm_kcalloc(&devfreq->dev,
> > -                                             devfreq->profile->max_sta=
te,
> > -                                             sizeof(unsigned long),
> > -                                             GFP_KERNEL);
> > +                     devfreq->profile->max_state,
> > +                     sizeof(unsigned long),
> > +                     GFP_KERNEL);
> >       if (!devfreq->time_in_state) {
> >               mutex_unlock(&devfreq->lock);
> >               err =3D -ENOMEM;
> > @@ -1184,7 +1183,7 @@ static ssize_t available_governors_show(struct de=
vice *d,
> >        */
> >       if (df->governor->immutable) {
> >               count =3D scnprintf(&buf[count], DEVFREQ_NAME_LEN,
> > -                                "%s ", df->governor_name);
> > +                               "%s ", df->governor_name);
> >       /*
> >        * The devfreq device shows the registered governor except for
> >        * immutable governors such as passive governor .
> > @@ -1497,8 +1496,8 @@ EXPORT_SYMBOL(devfreq_recommended_opp);
> >
> >  /**
> >   * devfreq_register_opp_notifier() - Helper function to get devfreq no=
tified
> > - *                              for any changes in the OPP availabilit=
y
> > - *                              changes
> > + *                                for any changes in the OPP availabil=
ity
> > + *                                changes
> >   * @dev:     The devfreq user device. (parent of devfreq)
> >   * @devfreq: The devfreq object.
> >   */
> > @@ -1510,8 +1509,8 @@ EXPORT_SYMBOL(devfreq_register_opp_notifier);
> >
> >  /**
> >   * devfreq_unregister_opp_notifier() - Helper function to stop getting=
 devfreq
> > - *                                notified for any changes in the OPP
> > - *                                availability changes anymore.
> > + *                                  notified for any changes in the OP=
P
> > + *                                  availability changes anymore.
> >   * @dev:     The devfreq user device. (parent of devfreq)
> >   * @devfreq: The devfreq object.
> >   *
> > @@ -1530,8 +1529,8 @@ static void devm_devfreq_opp_release(struct devic=
e *dev, void *res)
> >  }
> >
> >  /**
> > - * devm_ devfreq_register_opp_notifier()
> > - *           - Resource-managed devfreq_register_opp_notifier()
> > + * devm_devfreq_register_opp_notifier() - Resource-managed
> > + *                                     devfreq_register_opp_notifier()
> >   * @dev:     The devfreq user device. (parent of devfreq)
> >   * @devfreq: The devfreq object.
> >   */
> > @@ -1559,8 +1558,8 @@ int devm_devfreq_register_opp_notifier(struct dev=
ice *dev,
> >  EXPORT_SYMBOL(devm_devfreq_register_opp_notifier);
> >
> >  /**
> > - * devm_devfreq_unregister_opp_notifier()
> > - *           - Resource-managed devfreq_unregister_opp_notifier()
> > + * devm_devfreq_unregister_opp_notifier() - Resource-managed
> > + *                                       devfreq_unregister_opp_notifi=
er()
> >   * @dev:     The devfreq user device. (parent of devfreq)
> >   * @devfreq: The devfreq object.
> >   */
> > @@ -1579,8 +1578,8 @@ EXPORT_SYMBOL(devm_devfreq_unregister_opp_notifie=
r);
> >   * @list:    DEVFREQ_TRANSITION_NOTIFIER.
> >   */
> >  int devfreq_register_notifier(struct devfreq *devfreq,
> > -                             struct notifier_block *nb,
> > -                             unsigned int list)
> > +                           struct notifier_block *nb,
> > +                           unsigned int list)
> >  {
> >       int ret =3D 0;
> >
> > @@ -1686,9 +1685,9 @@ EXPORT_SYMBOL(devm_devfreq_register_notifier);
> >   * @list:    DEVFREQ_TRANSITION_NOTIFIER.
> >   */
> >  void devm_devfreq_unregister_notifier(struct device *dev,
> > -                             struct devfreq *devfreq,
> > -                             struct notifier_block *nb,
> > -                             unsigned int list)
> > +                                   struct devfreq *devfreq,
> > +                                   struct notifier_block *nb,
> > +                                   unsigned int list)
> >  {
> >       WARN_ON(devres_release(dev, devm_devfreq_notifier_release,
> >                              devm_devfreq_dev_match, devfreq));
> >
>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
