Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C90C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4B22087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="U2OKvrFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfADFKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 00:10:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36453 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfADFKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 00:10:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so31500359ljk.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 21:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OWbEwfPubjq0NaWWAxIQeAnQxn47xm0j0nxY5ZbcMH0=;
        b=U2OKvrFDbCh2BufZJKA7dzETG7GV7qnMAogiHwfSECrvA44C3wt+VzKcouhkef8HuX
         9gXA4fgHSFE9aGTmsjX8anV2LAGJziR6q0bv0AWMqoh+snLVtr8o/8CW5UxE8n6NmF/L
         83MwWdd8gCUMeobCl6GnWkKK1A/3C+fsc4pIaRrxrmtM3zQiVXWVS9CFTUr8VfE+x2j4
         JRzdU6R8iR/V5Kd0Mc0pjkGRKfUSjCVLgN/v3u+SavqTN8XWMfR+gGLNZdo/5LnMSL0H
         H7WJx1dXHN5804O4xPfbUlEvKu1+WBgU5j4O2yiBEFyjnyQz1zD0G6m+y7gPXvfImHOL
         X50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OWbEwfPubjq0NaWWAxIQeAnQxn47xm0j0nxY5ZbcMH0=;
        b=cQ6TarpzYfDaQ91a5zOxwJvBYyVkFRXHqLY1nMdSlhp0momQkCgStFvaSe9en0vn0i
         7PnDzCnh8BfCbSiSWYpHypUh9AGM5npmo26SKgjej1ZH7rGRTw2UkRuNVQi/ovMiXBgH
         5d/8fuDfnR9QGauP1XO+LNolAgGpP3hcU/JwW83epehO8s6qRU+VHHv38GWZIx3F3tr3
         tpF5hR+bvfoOQvVe2CjF60aem+QOGpv46h3KWZ7/MBiwpwWmpcvmdPJqfOHTA+8Q3a4g
         76BGeB31hR7f7T0AqlFOIROdd44EPyZ4hSQaXmkJEcS0KiNWaJQooGBQYAdJulP9Sxcz
         22Aw==
X-Gm-Message-State: AJcUukcfXIS9+o27AqUAdlJNwPeIKdj00nPKF4DaqX0lW/00EMP//bgP
        QX4KwkH6a/XCyLVdh35ukzfJByHcbZ8Vsrq0hwT2Hg==
X-Google-Smtp-Source: ALg8bN4NX1q9qUFDJuRi1APhXoCbCHOOEDefs8t7aFX3ddJu5xWVbeWWV2/MnDcQMXltIY7TuVQ/1NRifcFSmOCiq50=
X-Received: by 2002:a2e:8786:: with SMTP id n6-v6mr18777732lji.100.1546578596992;
 Thu, 03 Jan 2019 21:09:56 -0800 (PST)
MIME-Version: 1.0
References: <1544768442-12530-1-git-send-email-yash.shah@sifive.com>
 <1544768442-12530-2-git-send-email-yash.shah@sifive.com> <20181217211624.5sj4n6pyartnd3fc@pengutronix.de>
In-Reply-To: <20181217211624.5sj4n6pyartnd3fc@pengutronix.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Fri, 4 Jan 2019 10:39:20 +0530
Message-ID: <CAJ2_jOGBK6OtXe0UO6nYc1KPDVi39NtD8f+hUkpxROhzukPw7w@mail.gmail.com>
Subject: Re: [RFC v2 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 2:46 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Fri, Dec 14, 2018 at 11:50:41AM +0530, Yash Shah wrote:
> > DT documentation for PWM controller added with updated compatible
> > string.
> >
> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > [Atish: Compatible string update]
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  .../devicetree/bindings/pwm/pwm-sifive.txt         | 44 ++++++++++++++=
++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.tx=
t
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Doc=
umentation/devicetree/bindings/pwm/pwm-sifive.txt
> > new file mode 100644
> > index 0000000..250d8ee
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > @@ -0,0 +1,44 @@
> > +SiFive PWM controller
> > +
> > +Unlike most other PWM controllers, the SiFive PWM controller currently=
 only
> > +supports one period for all channels in the PWM. This is set globally =
in DTS.
> > +The period also has significant restrictions on the values it can achi=
eve,
> > +which the driver rounds to the nearest achievable frequency.
> > +
> > +Required properties:
> > +- compatible: should be something similar to "sifive,<chip>-pwm" for
> > +           the PWM as integrated on a particular chip, and
> > +           "sifive,pwm<version>" for the general PWM IP block
> > +           programming model. Supported compatible strings are:
> > +           "sifive,fu540-c000-pwm" for the SiFive PWM v0 as
> > +           integrated onto the SiFive FU540 chip, and "sifive,pwm0"
> > +           for the SiFive PWM v0 IP block with no chip integration
> > +           tweaks.
> > +- reg: physical base address and length of the controller's registers
> > +- clocks: The frequency the controller runs at
>
> This is unusual and the example below lists a clock phandle (which is
> the common thing), so I guess the description is just wrong.

You are right, I will correct the description.

>
> > +- #pwm-cells: Should be 2.
> > +  The first cell is the PWM channel number
> > +  The second cell is the PWM polarity
> > +- sifive,approx-period: the driver will get as close to this period as=
 it can
>
> What is the unit? I'd drop "approx", that the driver might not be able
> to exactly hit the specified period is (IMHO) obvious and doesn't need
> to be mentioned in the property name.

The unit is nanoseconds. Will add the unit suffix to the property name.

>
> > +- interrupts: one interrupt per PWM channel
> > +
> > +PWM RTL that corresponds to the IP block version numbers can be found
> > +here:
> > +
> > +https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/dev=
ices/pwm
> > +
> > +Further information on the format of the IP
> > +block-specific version numbers can be found in
> > +Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.t=
xt
> > +
> > +Examples:
> > +
> > +pwm:  pwm@10020000 {
> > +     compatible =3D "sifive,fu540-c000-pwm","sifive,pwm0";
> > +     reg =3D <0x0 0x10020000 0x0 0x1000>;
> > +     clocks =3D <&tlclk>;
> > +     interrupt-parent =3D <&plic>;
> > +     interrupts =3D <42 43 44 45>;
> > +     #pwm-cells =3D <2>;
> > +     sifive,approx-period =3D <1000000>;
> > +};
>
> Best regards
> Uwe

Thanks for the comments!

>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
