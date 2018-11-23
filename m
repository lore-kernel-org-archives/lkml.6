Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2921C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B138020820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPojN90a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B138020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409141AbeKWUO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:14:58 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37463 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502937AbeKWUO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:14:58 -0500
Received: by mail-yw1-f67.google.com with SMTP id h193so3331056ywc.4;
        Fri, 23 Nov 2018 01:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bzjcUHl1w//ssAapa6A5RQcSSMDTYUDZk9FHeTjejYo=;
        b=gPojN90awjuIdPcPkcY3kxibKmRq7Z2f0j+3CPWaqtKCJvbPnAbpRX/MDPShrSmmcx
         9P/8szFIgW2t+a0xZa8iboavnx5K75s8kdW6Jh8yzi2eiVYCKSpCNjeak/5xjTg+kPmv
         TgyLwkyArTEbWnG5m6pW/gW37ZakhJfPr+UWd1C0HaiDVOAnag5WaRcjlLiXt3a90yMs
         SGGyzZMbQXciNT+Tw0cJ0V0N4JXoq0/JJ2HD2IKmPtc0A1iuooGqSj5cMbUtUeNaeVxf
         DUSFwhGJTMBv1iSR+GupflizH1v0G7UYLMqqf5OOfv2mkcyYGRS3EDCkVRX+4G7hpe8s
         yU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bzjcUHl1w//ssAapa6A5RQcSSMDTYUDZk9FHeTjejYo=;
        b=lOPj5U8yDeEWVFIWCp19OueYEQRvKco7DESF8po/5nvucccVSrcct4uy/DnGH3C3QX
         RcQ9c24LJK1NBT0OKjTAE7saTSqHpl+S+uADOt/Huq5WryQsw2jzKwknU+lmBvoohnJe
         p5Xe38gjU7yOf0eHLoPw7zNuTx38YoGJWN9tJ4rSWtJsOtLAT6Q4hLa6jWAnI85Pnenl
         VDr6cnVdUUGvyqUImIVavyDXTdMt+S76xVveNwuskm3fx+tVkAG+Cg/bOZ9Y2gJHCT0x
         hSW6CXFkWro34lZjoQcr4f5RcTAZ0HX3V/bfK6S5l3QNpD7d+EJkGbRI/TSGaHX00nM5
         VYyQ==
X-Gm-Message-State: AGRZ1gIKUf6aF4/aB1CfiVmX48fB2mjK1pIdXX+B5VIMBus6zWv9mWl7
        4uMqLjMrO8+RAgAHvMOCB6zoeRPWxw8XY9vjUq9I01ay4z0=
X-Google-Smtp-Source: AJdET5fDumazKDuhg2tlZM+KX1ci3Fdc07HjfUHCZ7XH+LJVfnYPwdNmG90d18Cf2YWw0rWXJjgPZ3ZEBssOhUwRtBY=
X-Received: by 2002:a81:a40d:: with SMTP id b13-v6mr14987783ywh.345.1542965489953;
 Fri, 23 Nov 2018 01:31:29 -0800 (PST)
MIME-Version: 1.0
References: <20181121123508.25119-1-peron.clem@gmail.com> <20181122200536.ndgrxuxealtovngy@pengutronix.de>
In-Reply-To: <20181122200536.ndgrxuxealtovngy@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 23 Nov 2018 10:31:18 +0100
Message-ID: <CAJiuCcdt9Kk3z6gsr68O1JrPfan-ENpRjo0dnBaGxs4xDidOzQ@mail.gmail.com>
Subject: Re: [PATCH v2] pwm: kconfig: enable kona pwm to be built for cygnus arch
To:     u.kleine-koenig@pengutronix.de
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 22 Nov 2018 at 21:05, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Cl=C3=A9ment,
>
> On Wed, Nov 21, 2018 at 01:35:08PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > The Cygnus architecture use a Kona PWM. This is already present
> > in the device tree but can't be built actually. Hence, allow the
> > Kona PWM to be built for Cygnus arch.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  drivers/pwm/Kconfig | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 27e5dd47a01f..982f4059f4e8 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -88,7 +88,9 @@ config PWM_BCM_IPROC
> >
> >  config PWM_BCM_KONA
> >       tristate "Kona PWM support"
> > -     depends on ARCH_BCM_MOBILE
> > +     depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS || COMPILE_TEST
> > +     depends on HAVE_CLK && HAS_IOMEM
> > +     default ARCH_BCM_CYGNUS
>
> This looks good. As pointed out before the default is a bit strange
> and could include ARCH_BCM_MOBILE for symmetry.

Ok, let me resend a v3

>
> Anyhow:
>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> Related to this driver I have a set of questions: If the disable
> callback completed, does the hardware still drive the pin? If yes, would
> it be possible to disable the pin driver such that the pin gets high-Z?
> If yes, how?

The output pin type is configured with the bit "21:16 PWMOUT_TYPE RW
default 0x3F" in the Control register
PWM_CONTROL_TYPE_SHIFT macro in the driver
Datasheets says : "When set to 1 the PWM Output signal will have a
push/pull type.When set to 0 the PWM Output signal will have an open
drain output type.Recommend to leave it push/pull type."

In the driver we actually set push/pull mode for all channels :
/* Set push/pull for all channels */
for (chan =3D 0; chan < kp->chip.npwm; chan++)
value |=3D (1 << PWM_CONTROL_TYPE_SHIFT(chan));

Regards,
Clement

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
