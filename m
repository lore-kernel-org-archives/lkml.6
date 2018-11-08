Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9913CC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8E72086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euL+hg3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8E72086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeKHUWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:22:23 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:47017 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeKHUWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:22:22 -0500
Received: by mail-yw1-f67.google.com with SMTP id v5-v6so3354419ywa.13;
        Thu, 08 Nov 2018 02:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PzVp2vehovBKgbVNnHHKfUEFWz4EG4q13FH78e+GO6o=;
        b=euL+hg3riR0hcLsDR+TA0Nw19YLiLP37xHRb4ugzqC+OY64XYGWIdGttm+BiwP+EXM
         lxqcGPb147nieelu0mfR23DX1LAWPvZxh2GIaXphnx4S+7u6N/DSA2F1ymrDAZIMHZ9m
         Ec0F+foMCZqP6htaf+FjGQFG4RM/1eyRYSvT1ctppmnq8ic7GqhbK35WHIrRm9wNiSs4
         tln1JInogVIwqmxfV0eKtroMPVypnMfUb+2HTgYXjhJsA3LuRe0huYXvwTuD9DrXHBIK
         GpTpNk3twT27nkF+UQJXq1ygiOlyABoZ1oX3ZztTwYkOGoUa8qKmYF8c+hwVHy9NPCMC
         ly/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PzVp2vehovBKgbVNnHHKfUEFWz4EG4q13FH78e+GO6o=;
        b=gcu2BLlT8XrlDWGYIWd2i+DTOfSqBODkxGyoyULdt9+l2ovzobi/WLtgwLQEZacF0u
         cA0SD9DLMndnylCHvXJ96U0fYe/AefYh1ZecGIvAt8GX4L9qguXGp0k7UrN8hJ56SrKI
         VXKg/82/jEBUOYTZ8s1sN2/g3WTntl5n5QMFLpYTwpo7qbQlHAW3icwqub6fJLzKCfPx
         u/cbu788Rjq73Hi9emaJR3IE/+Q8knl8GyjZLuC/66BH4sJbOCtsTQeCRSicZeNCuyks
         /gbKW2VC5WXxq9jxfB+dWLMe5yJwyS3e/2GtbB4PMopWALyNjoKYFZWdwhOQr4ShPvbh
         nKVg==
X-Gm-Message-State: AGRZ1gL/hlBA+ElW9E0nKE2rqucvk008Eoiwm4SNyJelPuGRUAbjacAm
        E40wRckWxjndXsfgZ/QzSNrH+Nkn6tdLN9NuCQk=
X-Google-Smtp-Source: AJdET5fy398feTlGoe4qZvv3jPaxfj+errinRqUNbuhRpx2ZvH2gUD6T4gYB6C56Ifcr83p5cm2+gopyCB6rIO1LlNU=
X-Received: by 2002:a81:5044:: with SMTP id e65-v6mr3663155ywb.392.1541674049220;
 Thu, 08 Nov 2018 02:47:29 -0800 (PST)
MIME-Version: 1.0
References: <20181107093613.26734-1-peron.clem@gmail.com> <20181107093613.26734-2-peron.clem@gmail.com>
 <20181107162908.tejzekhc35pbknut@pengutronix.de>
In-Reply-To: <20181107162908.tejzekhc35pbknut@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 8 Nov 2018 11:47:17 +0100
Message-ID: <CAJiuCccMtBsCVHeqxQhXRj_Ltdv91Qk-6WDKAhb5S7whZOWsAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pwm: bcm-kona: apply pwm settings on enable
To:     u.kleine-koenig@pengutronix.de
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Suji Velupillai <suji.velupillai@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On Wed, 7 Nov 2018 at 17:29, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Wed, Nov 07, 2018 at 10:36:13AM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Suji Velupillai <suji.velupillai@broadcom.com>
> >
> > When pwm_bl framework calls enable, a call to pwm_is_enabled(pwm) still
> > return false, this prevents the backlight being turn on at boot time.
> >
> > Signed-off-by: Suji Velupillai <suji.velupillai@broadcom.com>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  drivers/pwm/pwm-bcm-kona.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
> > index 09a95aeb3a70..d991d53c4b38 100644
> > --- a/drivers/pwm/pwm-bcm-kona.c
> > +++ b/drivers/pwm/pwm-bcm-kona.c
> > @@ -108,8 +108,8 @@ static void kona_pwmc_apply_settings(struct kona_pw=
mc *kp, unsigned int chan)
> >       ndelay(400);
> >  }
> >
> > -static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *=
pwm,
> > -                         int duty_ns, int period_ns)
> > +static int __pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm=
,
> > +                      int duty_ns, int period_ns, bool pwmc_enabled)
> >  {
> >       struct kona_pwmc *kp =3D to_kona_pwmc(chip);
> >       u64 val, div, rate;
> > @@ -155,7 +155,7 @@ static int kona_pwmc_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >        * always calculated above to ensure the new values are
> >        * validated immediately instead of on enable.
> >        */
> > -     if (pwm_is_enabled(pwm)) {
> > +     if (pwm_is_enabled(pwm) || pwmc_enabled) {
>
> Having pwm-API-calls in hw-drivers is ugly. Apart from not giving the
> intended return code this function should IMHO be reserved to pwm
> consumers. The underlaying problem is that pwm-bl does:
>
>         pwm_config(pwm, duty_cycle, period);
>         pwm_enable(pwm);
>
> and expects that the duty_cycle and period is used then. Doesn't
> everything works just fine if the if-block is always executed?

Tested and works fine for me. But I only have a Cygnus proc.
Maybe there is some issue with Kona as explained by the comment (even
if I don't understand it well).

 * Don't apply settings if disabled. The period and duty cycle are
 * always calculated above to ensure the new values are
 * validated immediately instead of on enable.

Regards,
Clement

>
> The better fix here would be to convert the driver to the atomic API
> (i.e. implement .apply instead of .config, .set_polarity, .enable and
> .disable).
>
> Alternatively in .enable ensure that the hardware is programmed with the
> parameters from pwm->state. (But converting to the atomic API is the
> better approach.)
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
