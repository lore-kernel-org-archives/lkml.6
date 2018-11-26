Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7285C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3B320855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q31DbGTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3B320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeKZTpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:45:25 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36658 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeKZTpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:45:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so15844934otk.3;
        Mon, 26 Nov 2018 00:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TIg6599bXYDv0J90J8cqu6N1393IlFzgOndDoXQvKyE=;
        b=q31DbGTzUorNO+1nWDr8mJYpfMueHhmDCaI8GlDjPLqHqUUY5/ShOgwixNs9ZlXVu0
         sKH+ULFEMFjDbNcDc4gzVfeBZU684ljsJL5v3fv5I7yAMjRQKZtHveIKsa9A6gOZoPOe
         wIE6U8kWBIDDU5Yt9E5N+rUHdLv+ebVoyFKLHD+YKYE3VkgoXysE48eeBNOgH9hrQmet
         2LTcglUND0CTpjV7IMQ/U3nZCszQ5EEy0BeVyvEdZG/AEXspDUA2VqkeusUiLV51uT/M
         U6U7xZYdGJJCZWvgIAWSYguMYE6/paCXcNY+Jv+JW7CrNuofkd1gIQZVIO45k9d4GxlB
         /1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TIg6599bXYDv0J90J8cqu6N1393IlFzgOndDoXQvKyE=;
        b=dOCFPgj+foXFq4bWfgDLHdJbvyOtADFRKyRWixemaZK1e2HYPkoMO4gKG013hFdG89
         LVKVfoU3oABYIUWvuGSWUIL3lQ+Y+Yurz+AFWKWbAM5XUX9kIEiQ/FkoDYDNROsOifCu
         x+Ir5MpOMutuy4P4Y2jg5eEx0gP3rN170cGFoY6QvEawlElgHdP38JEaoSpGjmgV0ut9
         utbaNGJdsKapOQbacxSlb9pgSiaDUnHAycNPIWFGk/236vEfwk7cMibz3A/C5UqpAcPw
         2qAPcw8m6lZ6my8UgGngnd977j0GRb/ubq1l97N+e9APVfoF9DOP69jk/ly0la1ZU+kn
         9Rhw==
X-Gm-Message-State: AA+aEWZlZwnAxNunn1gR4aVaq0f81FFFp1H9y8MbCJ86uHxusustx3bU
        arDlF+JN3et7A+XSaBmD6BoFj6kR6fAKt3MPH+Y=
X-Google-Smtp-Source: AFSGD/UrkcqP4W7GcdjlrbLdGCyxJKvNlUF5v8c0tchrzBq5eBDhljBz8cMmFFpV3qJILdliQmQfmtCwX+prgjWYlpc=
X-Received: by 2002:a9d:3b4b:: with SMTP id z69mr14092285otb.167.1543222318630;
 Mon, 26 Nov 2018 00:51:58 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181123094453epcas4p16be0412e0195fe4bf06680111805352a@epcas4p1.samsung.com>
 <20181123094413.1108-1-linux.amoon@gmail.com> <5BFBA550.4020401@samsung.com>
In-Reply-To: <5BFBA550.4020401@samsung.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 26 Nov 2018 14:21:45 +0530
Message-ID: <CANAwSgRqvw454E2twn+RwGGhy0XQE0T=k2dKfD50CWVk88p=rQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: samsung: exynos5420: add VPLL rate table for g3d clock
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Marian Mihailescu <mihailescu2m@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On Mon, 26 Nov 2018 at 13:18, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Hi,
>
> On 2018=EB=85=84 11=EC=9B=94 23=EC=9D=BC 18:44, Anand Moon wrote:
> > From: Marian Mihailescu <mihailescu2m@gmail.com>
> >
> > A specific clock rate table is added for VPLL so it is possible
> > to set frequency of the VPLL output clock that used by the g3d clock.
> >
> > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > Signed-off-by: Marian Mihailescu <mihailescu2m@gmail.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/clk/samsung/clk-exynos5420.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung=
/clk-exynos5420.c
> > index 34cce3c5898f..34156bdfd0d2 100644
> > --- a/drivers/clk/samsung/clk-exynos5420.c
> > +++ b/drivers/clk/samsung/clk-exynos5420.c
> > @@ -1303,6 +1303,18 @@ static const struct samsung_pll_rate_table exyno=
s5420_epll_24mhz_tbl[] =3D {
> >       PLL_36XX_RATE(24 * MHZ,  32768001U, 131, 3, 5, 4719),
> >  };
> >
> > +static const struct samsung_pll_rate_table exynos5420_vpll_24mhz_tbl[]=
 __initconst =3D {
> > +     PLL_35XX_RATE(24 * MHZ, 600000000U, 200, 2, 2),
> > +     PLL_35XX_RATE(24 * MHZ, 543000000U, 181, 2, 2),
> > +     PLL_35XX_RATE(24 * MHZ, 533000000U, 533, 6, 2),
> > +     PLL_35XX_RATE(24 * MHZ, 480000000U, 320, 4, 2),
> > +     PLL_35XX_RATE(24 * MHZ, 420000000U, 140, 2, 2),
> > +     PLL_35XX_RATE(24 * MHZ, 350000000U, 175, 3, 2),
> > +     PLL_35XX_RATE(24 * MHZ, 266000000U, 266, 3, 3),
> > +     PLL_35XX_RATE(24 * MHZ, 177000000U, 118, 2, 3),
> > +     PLL_35XX_RATE(24 * MHZ, 100000000U, 200, 3, 4),
> > +};
>
> VPLL has the same PMS table with apll/kpll/bpll. You don't need to add ne=
w
> 'exynos5420_vpll_24mhz_tbl' table. Just adding the missing frequency entr=
ies
> to 'exynos5420_pll2550x_24mhz_tbl' table.
>
Thanks for your input. I will leave this for the expert to fix this.

> > +
> >  static struct samsung_pll_clock exynos5x_plls[nr_plls] __initdata =3D =
{
> >       [apll] =3D PLL(pll_2550, CLK_FOUT_APLL, "fout_apll", "fin_pll", A=
PLL_LOCK,
> >               APLL_CON0, NULL),
> > @@ -1428,6 +1440,7 @@ static void __init exynos5x_clk_init(struct devic=
e_node *np,
> >               exynos5x_plls[epll].rate_table =3D exynos5420_epll_24mhz_=
tbl;
> >               exynos5x_plls[kpll].rate_table =3D exynos5420_pll2550x_24=
mhz_tbl;
> >               exynos5x_plls[bpll].rate_table =3D exynos5420_pll2550x_24=
mhz_tbl;
> > +             exynos5x_plls[vpll].rate_table =3D exynos5420_vpll_24mhz_=
tbl;
> >       }
> >
> >       samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_=
plls),
> >
>
>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics

Best Regards
-Anand
