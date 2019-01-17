Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A75C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1ACE20856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgT3jPwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbfAQIpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:45:03 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37712 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfAQIpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:45:03 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so135298iti.2;
        Thu, 17 Jan 2019 00:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mNoYgnoK6Sq97IB5r7oJHX/u6PnkKfci+uucCnTnl6o=;
        b=YgT3jPwC90Eb9cHD6CB483mrQw6Bel14Dg6ze537NIa60zNR1K0p+zmCp5UElTXqfo
         02ltYi/I+IXpXLruSnBveEhzTnRhvaX7TYI9BpPcHBveHvzNQ2PJmHhaAys+BgZNZcXS
         nYUubfVJyIGr52hIWevWn6I/JtLfRbM4jdKB2lCtVRxcZr9gGPv2C++a1j2mrmM3JVty
         9o2PrtWmCF1BTCI+JgPh0fWed2p1F7CzmgIRGuPCJehLalW2BhjhltQIVxsy6LT+qeWM
         eC15NpFdb5UNF9nr0RvJUZm/vA5MZNJWEabnuX2fN80giAWviydtC+RN3xr2hQFLVusV
         VTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mNoYgnoK6Sq97IB5r7oJHX/u6PnkKfci+uucCnTnl6o=;
        b=ST4sMGi5RTRB9zm4pLmOfZwBcQxFVU7QY4f/wm4Qkq98jpHTqbY5jLvTQmLXGgElYw
         qeqP+fHb0+eiLKE490VIzDzB2iqqowzgywJ+DCOnRpowW6C7TVttg8ChcJp1N6owoSEX
         b3pmXc9SJIi0Iv2ron27lC3pHTgbiRTbirSM1xWvvj6MabkvxhpfStN+Qpt7pg20wP7S
         w7x07a6atBv8mZaIeYm3pQc7xl8d0O7qYo1A/dcA9hVVgXPHBhph1ubMAgwx+YKD7p9b
         oZerCHP66a34w0XykUy9F146YcMSJhbxLXjC4nAiACfqW9TLgSTxpZmOBRFsAC10EyYE
         D1EA==
X-Gm-Message-State: AJcUukfK03vy98O1YEWgpnk87ZXPARVNXFI5PIEbMgcxDDMA75JjCkgY
        25tk7Pw3WHRKCN4XXpt7PNklVCUxNoU4f0MgsBFxAvWl
X-Google-Smtp-Source: ALg8bN6fy5ELodo/vh7ps4AV16mXTcKYNRWQj2Nzl5RkNe/anoUc4cMKuGZqlwGJ8NECz2XutO2UcyRdK84Jg8W32xk=
X-Received: by 2002:a24:b34f:: with SMTP id z15mr7570776iti.61.1547714702357;
 Thu, 17 Jan 2019 00:45:02 -0800 (PST)
MIME-Version: 1.0
References: <20190116211131.18809-1-pawel.mikolaj.chmiel@gmail.com> <20190117070838.GA8109@dtor-ws>
In-Reply-To: <20190117070838.GA8109@dtor-ws>
From:   =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Date:   Thu, 17 Jan 2019 09:44:51 +0100
Message-ID: <CAKpie0QcLf+M7YirVcX8AMXQYi8v+_kaKTSC7QZY1-0-op+aSQ@mail.gmail.com>
Subject: Re: [PATCH] input: misc: pwm-vibra: Prevent unbalanced regulator
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 17 sty 2019 o 08:08 Dmitry Torokhov <dmitry.torokhov@gmail.com>
napisa=C5=82(a):
>
> Hi Pawe=C5=82,
>
> On Wed, Jan 16, 2019 at 10:11:31PM +0100, Pawe=C5=82 Chmiel wrote:
> > From: Jonathan Bakker <xc-racer2@live.ca>
> >
> > pwm_vibrator_stop disables the regulator, but it can be called from
> > multiple places, even when the regulator is already disabled. Fix this
> > by using regulator_is_enabled check when starting and stopping device.
> >
> > Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> >  drivers/input/misc/pwm-vibra.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vi=
bra.c
> > index 55da191ae550..66677ee770ca 100644
> > --- a/drivers/input/misc/pwm-vibra.c
> > +++ b/drivers/input/misc/pwm-vibra.c
> > @@ -42,10 +42,12 @@ static int pwm_vibrator_start(struct pwm_vibrator *=
vibrator)
> >       struct pwm_state state;
> >       int err;
> >
> > -     err =3D regulator_enable(vibrator->vcc);
> > -     if (err) {
> > -             dev_err(pdev, "failed to enable regulator: %d", err);
> > -             return err;
> > +     if (!regulator_is_enabled(vibrator->vcc)) {
>
> I do not think this is correct in case of shared supply, as this checks
> global state of regulator. That means that if there is another user, we
> may forego enabling regulator here, and that anther user may power it
> down and vibrator will stop working.
>
> I think you need a local flag here.
Ok will fix this (funny that in first version of patch there was such flag)=
.
>
> > +             err =3D regulator_enable(vibrator->vcc);
> > +             if (err) {
> > +                     dev_err(pdev, "failed to enable regulator: %d", e=
rr);
> > +                     return err;
> > +             }
> >       }
> >
> >       pwm_get_state(vibrator->pwm, &state);
> > @@ -76,7 +78,8 @@ static int pwm_vibrator_start(struct pwm_vibrator *vi=
brator)
> >
> >  static void pwm_vibrator_stop(struct pwm_vibrator *vibrator)
> >  {
> > -     regulator_disable(vibrator->vcc);
> > +     if (regulator_is_enabled(vibrator->vcc))
> > +             regulator_disable(vibrator->vcc);
>
> Looking at this, I wonder if we should not disable PWMs first and the
> disable regulator.
I will create and send separate patch for this.

Thanks for review
>
> >
> >       if (vibrator->pwm_dir)
> >               pwm_disable(vibrator->pwm_dir);
> > --
> > 2.17.1
> >
>
> Thanks.
>
> --
> Dmitry
