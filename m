Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20B1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B8C20855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="CrE8ljU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfBUAXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:23:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34388 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfBUAXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:23:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id f14so28132613wrg.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 16:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jjWqUbBDvK3nC729N/p7FCit75OVtoymj2KU/ULiaRI=;
        b=CrE8ljU9PZbxOcslc9gmjImDEsWL7V6eptvX8xLRCjA+UxrrJeOgg6Me+gg9Cy6pYb
         iBmzTiFqMybTy6Z5GQQ6cHhStM5kBt1vtVQ3QD6w9Mn/Vnlz5ANa6oHyaO8i0dmQEnm+
         qxk/MoHFKPwcx1AXZbG2d07LdDQBscqQjWEeh2E/YGGYu3Qv1N0/KwsC5mHJSIQ4hINc
         mIYx9qGqu5TfC+rJXCEW2sGsojrO5cpmlmyO/PdSLTBQHuJjlpOa1kFvWt39/sBQGf+y
         CLkty0EX6lQpOMcVshcE00w4ijRECShBaT8UKSThI2bDWYDaIkUc2jt+nrCxxettiLi/
         DqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jjWqUbBDvK3nC729N/p7FCit75OVtoymj2KU/ULiaRI=;
        b=UeshkTgBbC1qwg2n5juz/IvwYKd1LOMnqojmTX+9KSbP5Wq+kvztOwIeyrJxuWOX+0
         ETH8tUEcuhrss/RAO5xNk+vvwEn9uHrgcoaSuk3fIIpHD/WH1VtlbVbOVWtuLW6ptFeg
         rtVP9zoLX4xZD+tHW4w7dvQY+5jD2Z4PKzKYLtWAWebjfWJv9X/cg13gnFmxzrmN2zz3
         IOAgXL3QBwILbta2qUhXm1faEFqSd4bO+FGgdWEKMyTGFvqkRaI1AmPOSqxqabY9j6Gx
         23BK2QtDN1GaDJrgFibPBPhsyXqR9qALSghKMLJ3/KTpHaSlcUJkmXFrsXk3FwMr4zn8
         343A==
X-Gm-Message-State: AHQUAuZfNzjd9UhvhHdPSIH4RcZVtqooK4PhXxTQHlbL0nUiyYsnDKlj
        GMs0jLtFjZMb/5bo37wbVA7HSamfoxQLUDyCo38yGg==
X-Google-Smtp-Source: AHgI3IYyve/u6v42wo5fHdgtRwSaO3oP63tj8AWuFIkKIRvRYj+b/G1hwbvMAUuZCApFsRGrVk+poP18s/TbJrCTFf0=
X-Received: by 2002:adf:e48a:: with SMTP id i10mr27779817wrm.257.1550708585334;
 Wed, 20 Feb 2019 16:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20190220165013.12774-1-axel.lin@ingics.com> <24E35288-677D-4223-B94A-52A4F37792A8@schinagl.nl>
In-Reply-To: <24E35288-677D-4223-B94A-52A4F37792A8@schinagl.nl>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Thu, 21 Feb 2019 08:22:53 +0800
Message-ID: <CAFRkauAPGEBxj7k2GvmFwhyc7ZuofhXou17b75F3G-mUWVaf9A@mail.gmail.com>
Subject: Re: [PATCH] regulator: axp20x: Get rid of AXP20X_xxx_START/END/STEPS defines
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Priit Laes <plaes@plaes.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Olliver Schinagl <oliver@schinagl.nl> =E6=96=BC 2019=E5=B9=B42=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=886:57=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hey Axel,
>
> On February 20, 2019 5:50:13 PM GMT+01:00, Axel Lin <axel.lin@ingics.com>=
 wrote:
> >The AXP20X_xxx_START/END/STEPS defines make the code hard to read and
> >very hard to check the linear range settings because it needs to check
> >the defines one-by-one.
> >The original code without the defines is very good in readability
> >as the meaning of each field of REGULATOR_LINEAR_RANGE is clear.
> >So I suggest to get rid of AXP20X_xxx_START/END/STEPS defines.
> Are you suggesting that magic values and hex numbers are more readable?

For example:
static const struct regulator_linear_range axp803_dcdc234_ranges[] =3D {
       REGULATOR_LINEAR_RANGE(500000, 0x0, 0x46, 10000),
       REGULATOR_LINEAR_RANGE(1220000, 0x47, 0x4b, 20000),
};
Above looks very clear to me as it describes the linear ranges:
1st linear range: min_uV is 500000, from selector 0 ~ 0x46, the uV_step is =
10000
2nd linear range: min_uV is 1220000, from selector 0x47 ~ 0x4b, the
uV_step is 20000
And it's easy to check the min_sel and max_sel in each linear range.

Now, take a look at below code:
static const struct regulator_linear_range axp803_dcdc234_ranges[] =3D {
       REGULATOR_LINEAR_RANGE(500000,
                              AXP803_DCDC234_500mV_START,
                              AXP803_DCDC234_500mV_END,
                              10000),
       REGULATOR_LINEAR_RANGE(1220000,
                              AXP803_DCDC234_1220mV_START,
                              AXP803_DCDC234_1220mV_END,
                              20000),
};
1st linear range:
I have to check what is AXP803_DCDC234_500mV_START for min_sel,
then check what is AXP803_DCDC234_500mV_END for max_sel,
and AXP803_DCDC234_500mV_END is AXP803_DCDC234_500mV_START +
AXP803_DCDC234_500mV_STEPS
so I have to check if AXP803_DCDC234_500mV_STEPS is correct or not.
The same for 2nd linear range.
It's unnecessary complexity.
And it's just for 2 linear ranges, for axp20x_ldo4_ranges with 5 linear ran=
ge,
it's really hard to check the settings.

IMHO, In such case, the defines does not help.
It's a rare case that I suggest to remove the defines.

>
> Maybe you can explain what your problem is, as it appears you are trying =
to debug something?
well, I just read the code.
I just found it's very hard to read the linear range setting for this drive=
r.

Regards,
Axel
