Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB60CECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20BA20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3tXl8BW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20BA20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeKIBIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:08:17 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40293 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbeKIBIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:08:16 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so4528474oth.7;
        Thu, 08 Nov 2018 07:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=murMYxtjWPsWn9Aubu2j4AsNnVLvszMG5YHqdZB2qe4=;
        b=i3tXl8BWJOdHRZUV4KXvQZ76eTmEWJ+PjnqFJJivUriQ6IOZvp9C5sY9GF7wpnMdv2
         g9fdb98n5IOdJcFrB5jcbIgBC1Ld/2s6cWZhsscONbLtpnwLtw7MiuOisUJFZZjHc6z3
         uKeLwde0FsC6ApPET52GOdPpQSJ5xZGie1cOUcx7YDkE6mvxdknUZPDSW6BgkV/qtKSU
         AxWpd0Hl7r+KltIBhJRH6V9T5lbDlMCEEYzHFWpj3eU0dZHb4MpxRlhRZ+XTVeW7/eGX
         A7hPUhHTu0gk1tm23v789APzZCJjufgFojAdOL6WxsYt/qiO4+sZaCW2MYBvE4Hm1u6K
         MOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=murMYxtjWPsWn9Aubu2j4AsNnVLvszMG5YHqdZB2qe4=;
        b=sG3UklGCSXevf0kC8wZHjLk5Lth76/OGFLIKkcLrtXEGeNTIfj5W+Ri9R0WqydyFNn
         I8+ZSKMk/yL351xkgN1grVK86VQQdAEI13Fuo8L4dLhjG3C8WKqOM3BflqAPzo7pxrH+
         mY4X2ichdKzsU7kT0mAuAc4SLwYIoDMayir6GDJ/zNxu6MkQKA3ndYe/B4V700DS0uGk
         PnQ0UEBQihamFnqAWdjxjky8irjvWtZI0CUpRArY8K0DflPVDBzHaV6mGY6I1tJaKOut
         o33ZN0Z7igUoVyJDDlZMoBhtEwOQEbW69jDOfkMHB6x4agZxwag5E8mXtAHtJEUwKdbh
         tGcA==
X-Gm-Message-State: AGRZ1gJJWPSs9u0O5Jof1cUQc4U/rlO5I1Fp1BZ9h5DDA0zPA6W4Q0lN
        w/wi6zeedokKYIkdhMKF76oAPEhPiD+nE+H5rLo=
X-Google-Smtp-Source: AJdET5dhOTVCUa6dFe0lnzqJCThX48pUPU5pocFwNbB3LrF7dzXhWfGp5tATgAm/omLGkOuEcSnKfajASyNFjOCD8OY=
X-Received: by 2002:a9d:784a:: with SMTP id c10mr3108826otm.175.1541691134530;
 Thu, 08 Nov 2018 07:32:14 -0800 (PST)
MIME-Version: 1.0
References: <20181107093613.26734-1-peron.clem@gmail.com> <20181107093613.26734-2-peron.clem@gmail.com>
 <20181107162908.tejzekhc35pbknut@pengutronix.de> <CAJiuCccMtBsCVHeqxQhXRj_Ltdv91Qk-6WDKAhb5S7whZOWsAw@mail.gmail.com>
 <20181108105922.p557jxrebjlhnsho@pengutronix.de>
In-Reply-To: <20181108105922.p557jxrebjlhnsho@pengutronix.de>
From:   Tim Kryger <tim.kryger@gmail.com>
Date:   Thu, 8 Nov 2018 07:32:02 -0800
Message-ID: <CAD7vxxKA3feHK97WiQsb-003qp4Cvj2CQ3C+1sfpo9iZUBhm_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] pwm: bcm-kona: apply pwm settings on enable
To:     u.kleine-koenig@pengutronix.de
Cc:     peron.clem@gmail.com, Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Linux PWM <linux-pwm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        suji.velupillai@broadcom.com, Tim Kryger <tim.kryger@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 2:59 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> adding Tim Kryger as the initial author of the bcm-kona driver to Cc:.
> Maybe he can shed some light to the questions below?
>
> On Thu, Nov 08, 2018 at 11:47:17AM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > On Wed, 7 Nov 2018 at 17:29, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Wed, Nov 07, 2018 at 10:36:13AM +0100, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > > > From: Suji Velupillai <suji.velupillai@broadcom.com>
> > > >
> > > > When pwm_bl framework calls enable, a call to pwm_is_enabled(pwm) s=
till
> > > > return false, this prevents the backlight being turn on at boot tim=
e.
> > > >
> > > > Signed-off-by: Suji Velupillai <suji.velupillai@broadcom.com>
> > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > > ---
> > > >  drivers/pwm/pwm-bcm-kona.c | 16 +++++++++++-----
> > > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.=
c
> > > > index 09a95aeb3a70..d991d53c4b38 100644
> > > > --- a/drivers/pwm/pwm-bcm-kona.c
> > > > +++ b/drivers/pwm/pwm-bcm-kona.c
> > > > @@ -108,8 +108,8 @@ static void kona_pwmc_apply_settings(struct kon=
a_pwmc *kp, unsigned int chan)
> > > >       ndelay(400);
> > > >  }
> > > >
> > > > -static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> > > > -                         int duty_ns, int period_ns)
> > > > +static int __pwmc_config(struct pwm_chip *chip, struct pwm_device =
*pwm,
> > > > +                      int duty_ns, int period_ns, bool pwmc_enable=
d)
> > > >  {
> > > >       struct kona_pwmc *kp =3D to_kona_pwmc(chip);
> > > >       u64 val, div, rate;
> > > > @@ -155,7 +155,7 @@ static int kona_pwmc_config(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> > > >        * always calculated above to ensure the new values are
> > > >        * validated immediately instead of on enable.
> > > >        */
> > > > -     if (pwm_is_enabled(pwm)) {
> > > > +     if (pwm_is_enabled(pwm) || pwmc_enabled) {
> > >
> > > Having pwm-API-calls in hw-drivers is ugly. Apart from not giving the
> > > intended return code this function should IMHO be reserved to pwm
> > > consumers. The underlaying problem is that pwm-bl does:
> > >
> > >         pwm_config(pwm, duty_cycle, period);
> > >         pwm_enable(pwm);
> > >
> > > and expects that the duty_cycle and period is used then. Doesn't
> > > everything works just fine if the if-block is always executed?
> >
> > Tested and works fine for me. But I only have a Cygnus proc.
> > Maybe there is some issue with Kona as explained by the comment (even
> > if I don't understand it well).
> >
> >  * Don't apply settings if disabled. The period and duty cycle are
> >  * always calculated above to ensure the new values are
> >  * validated immediately instead of on enable.
>
> I wouldn't understand that as "If you apply settings on a disabled PWM a
> kitten dies". I think it only means: At the current point in time
> duty_cycle and period are not important as the hardware is off. So don't
> bother to write these values to the hardware.
>
> @Tim: Do you think (or can test if) there is a problem when doing
>
> -       if (pwm_is_enabled(pwm)) {
> +       if (1) {
>
> in kona_pwmc_config? (For sure the comment needs adaption and the if (1)
> shouldn't make it into the driver, just used that as shorthand for the
> change I want to suggest.)
>
> But still better than dropping the check is to convert the driver to the
> atomic API. With that this problem would simply not occur.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|

There is no per channel disable in the hardware so to simulate a
disable, duty is set to zero.

The check is there to prevent new config values from applying until
the channel is enabled.
