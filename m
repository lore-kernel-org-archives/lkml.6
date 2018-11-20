Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F63FC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53AC20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGuD8KkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53AC20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeKUEcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:32:08 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35192 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeKUEcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:32:08 -0500
Received: by mail-qt1-f194.google.com with SMTP id v11so985090qtc.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 10:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3bK/y037BwoZghWmHEwcAdTqxrK18NmNqRW3guyt6PM=;
        b=TGuD8KkQ/2k4DA1nLkBUtTEgijKCsoCyILAxOFB1Qg6sffVaqqT55AIfCST2FZfCQI
         h7sQgU3xWrQh1qlbYflJ5uz3Lggh4hmlpxuDQZbdJtAhhKoxLXaqxPTaBQvBjRGe6ofr
         tYsBdgtebZJx23SiaB9Rcb4U8msaqcfreF0qHO5oQ8tXT3I5RbZem4kSrdz5JEE1I1Np
         wuVWwPzbRavSBh6xX4w/0FbM0Kw4H3CQpxLFtq0Nvyf8jrg8b8Hjnf2LYEGdmg4A/56A
         A5573sm+zxmkl61CS8PA9f2sThYPHrYFsvZ8L8pUV+39/0uutMV0LS2zqSYI+/XW2e1q
         1gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3bK/y037BwoZghWmHEwcAdTqxrK18NmNqRW3guyt6PM=;
        b=COwiXprbKUWTGXnNYy1auzmyZzgIbN+Mvr5jSHvvEnemFuyHcaW0FPHoqHFxoPccsv
         EtY5+kQwTxhcb71f/uI/kh9VsBmOVJhAkOwHVl2o/yq8PFi+m54YdF9KBjo7bXz62ti3
         XA0+2XZcEVT/GvJD7l9YouXyHmJ20TDxOtE6d8NZ1e1UAbgRoZOK0ijuVz/i2kO3DtEi
         TW1kIzWNiXGmTfa99IxCbYl6C2mbZli7IL+RBExb0fmRV3Q2eYdglwyI4YFczkItgwmf
         RNDLIjmQV59mKAmxorCbkwdiXB9nbggtKvTCrFdySKD0iou0rJ44pdQeDtI2Owg0Hdd6
         HwEg==
X-Gm-Message-State: AA+aEWYBw31/W0goL2DrTJL9iL1I7WxwuF5UN4Y+89po8SmKAXzxJIel
        z+/HkZ4qP1pDCa8q8MxbXEq0w5wj91Jq7/iI62SnbQ==
X-Google-Smtp-Source: AFSGD/UvhvFgm+v2BNoeFdagHfQPLu2y8UKQJofuJB6WoL4m7p2+6Tn1kEqtt29z3OQ3q4DUnf6KORFafZwRauTaWGM=
X-Received: by 2002:ad4:5282:: with SMTP id v2mr2875522qvr.195.1542736904532;
 Tue, 20 Nov 2018 10:01:44 -0800 (PST)
MIME-Version: 1.0
References: <20181120165737.4998-1-romain.izard.pro@gmail.com> <20181120171612.GF8367@piout.net>
In-Reply-To: <20181120171612.GF8367@piout.net>
From:   Romain Izard <romain.izard.pro@gmail.com>
Date:   Tue, 20 Nov 2018 19:01:32 +0100
Message-ID: <CAGkQfmPHRKqMvm6bNDf8S5qM7uE5T-izij=jm2nob0zrOgOM-w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: at91: sama5d2: use the divided clock for SMC
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar. 20 nov. 2018 =C3=A0 18:16, Alexandre Belloni
<alexandre.belloni@bootlin.com> a =C3=A9crit :
>
> Hello Romain,
>
> On 20/11/2018 17:57:37+0100, Romain Izard wrote:
> > The SAMA5D2 is different from SAMA5D3 and SAMA5D4, as there are two
> > different clocks for the peripherals in the SoC. The Static Memory
> > controller is connected to the divided master clock.
> >
> > Unfortunately, the device tree does not correctly show this and uses th=
e
> > master clock directly. This clock is then used by the code for the NAND
> > controller to calculate the timings for the controller, and we end up w=
ith
> > slow NAND Flash access.
> >
> > Fix the device tree, and the performance of Flash access is improved.
> >
> > Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> > ---
> >  arch/arm/boot/dts/sama5d2.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2=
.dtsi
> > index 61f68e5c48e9..b405992eb601 100644
> > --- a/arch/arm/boot/dts/sama5d2.dtsi
> > +++ b/arch/arm/boot/dts/sama5d2.dtsi
> > @@ -308,7 +308,7 @@
> >                                 0x1 0x0 0x60000000 0x10000000
> >                                 0x2 0x0 0x70000000 0x10000000
> >                                 0x3 0x0 0x80000000 0x10000000>;
> > -                     clocks =3D <&mck>;
> > +                     clocks =3D <&h32ck>;
>
> You will have to rebase on top of at91-dt. And if I'm not mistaken, this
> line should be:
>
> +                       clocks =3D <&pmc PMC_TYPE_CORE PMC_MCK2>;
>
> >                       status =3D "disabled";
> >
> >                       nand_controller: nand-controller {

I guess you're right but this will only reach mainline in 4.21. I get slow
flash access with 4.19 as well...

After a second look, it looks like the SAMA5D4 is affected too.

Best regards,
--=20
Romain Izard
