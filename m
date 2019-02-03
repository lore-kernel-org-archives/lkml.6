Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA6CC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934BA2083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW2ZpxtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfBCHys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 02:54:48 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33253 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfBCHyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 02:54:47 -0500
Received: by mail-qt1-f196.google.com with SMTP id l11so12475571qtp.0;
        Sat, 02 Feb 2019 23:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=BSnmeNvE3EBhH2SfbdbcYylaib6DqHpMf3vu6r4CZqc=;
        b=eW2ZpxtXpeL0dNqBqV7T9P3rj0Jr0ySMM8IyBtnRNfCAmV0FHPBXmJKiVUhRr6c7Ek
         5FLvIRS1mPrUFGNUJudBTkWCAb2BNyPBqY1Z3bqNYECtv/uYnrbpEwe+egAy//YLW+89
         1iAdSv3L0cw+C740nL0PqHJWpzKVyrjH3GRfFVPCKnMP4NiqdQtoxDksMaBNPv9Xk6OS
         amoO3Jbh2w2YPueGnRJa2EQYtW4Sb2eCsuRToDzixFcgrEXqnC9936Ud+Ev7admKd+c+
         VHk24NLymfTLr5tTwZEIk71wGZXhzcCr9EokcMcuzF0wdKGnhRhogrLsbLttm8RJrBu/
         dlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=BSnmeNvE3EBhH2SfbdbcYylaib6DqHpMf3vu6r4CZqc=;
        b=XkqHA/cwb7/vkyU/fboFqIodkzWwfKPl+2Xtvt4PH2rpuzIKpSTmXZvDF64e1zN57v
         6G2NBQqOI8OHy6jAq9rL/oE1Nf6lIX0Ng3adXVHWonMKKbKCLsZfqz1bAcTlP0uSopGH
         gEQ2qO6to9J4lljXJN1MsV5zQhDSV3w8oVrBVBrbnk6J20v8HDTqhTp2SOtUXGgrHUGC
         C/MCOhjo8w/mszHBLu0W5a29t/jHEop3iMuvMvUfXJHpgKNH6yQ50N0CaSSVOLTv8Vgt
         fuGUUWtg3rFUryj0Py8vQ1wbup4ou0wcoCRr63R5E8hcy3WfOEUhRd0altQUgvrLjaHA
         0B4A==
X-Gm-Message-State: AJcUukdwFYflH34EEzwneycsIYZaY3+FWwqNnefigIV49GMZnwHSSneI
        GJ6IGaZslj7ozXrYLgKZXqtAhKorOvDCT3InYFg=
X-Google-Smtp-Source: ALg8bN6TGRGK9yUSn/KtlbJaLCxO8NxFh6bnJMO0CSftNvbm5YZSkYi/73xup7Ku8vai1TkQ9hzA+bISKdSoMOpKTUE=
X-Received: by 2002:ac8:1617:: with SMTP id p23mr45983910qtj.239.1549180485631;
 Sat, 02 Feb 2019 23:54:45 -0800 (PST)
MIME-Version: 1.0
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190131085007eucas1p2f16107042b8ce5638811840618bcf017@eucas1p2.samsung.com>
 <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
 <d5b8d165-564e-b776-77de-31a069118067@samsung.com> <0ca15b4c-ddaa-1be5-35be-e76b008b28a8@partner.samsung.com>
In-Reply-To: <0ca15b4c-ddaa-1be5-35be-e76b008b28a8@partner.samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sun, 3 Feb 2019 16:54:09 +0900
Message-ID: <CAGTfZH05zn_FiNt3zSHZJfspvo4RXWPrAtWLUq5xsqKoB3qxBA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos 5422 SoC
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

2019=EB=85=84 2=EC=9B=94 1=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 11:22, L=
ukasz Luba <l.luba@partner.samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:

>
> Hi Chanwoo,
>
> On 2/1/19 9:44 AM, Chanwoo Choi wrote:
> > Hi,
> >
> > On 19. 1. 31. =EC=98=A4=ED=9B=84 5:49, Lukasz Luba wrote:
> >> Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memo=
ry
> >> Controller frequencies for driver's DRAM timings.
> >>
> >> CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
> >> CC: Chanwoo Choi <cw00.choi@samsung.com>
> >> CC: Michael Turquette <mturquette@baylibre.com>
> >> CC: Stephen Boyd <sboyd@kernel.org>
> >> CC: Kukjin Kim <kgene@kernel.org>
> >> CC: Krzysztof Kozlowski <krzk@kernel.org>
> >> CC: linux-samsung-soc@vger.kernel.org
> >> CC: linux-clk@vger.kernel.org
> >> CC: linux-arm-kernel@lists.infradead.org
> >> CC: linux-kernel@vger.kernel.org
> >> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> >> ---
> >>   drivers/clk/samsung/clk-exynos5420.c | 15 ++++++++++++++-
> >>   1 file changed, 14 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsun=
g/clk-exynos5420.c
> >> index 3e87421..8bf9579 100644
> >> --- a/drivers/clk/samsung/clk-exynos5420.c
> >> +++ b/drivers/clk/samsung/clk-exynos5420.c
> >> @@ -1325,6 +1325,19 @@ static const struct samsung_pll_rate_table exyn=
os5420_pll2550x_24mhz_tbl[] __ini
> >>      PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
> >>   };
> >>
> >> +static const struct samsung_pll_rate_table exynos5422_bpll_rate_table=
[] =3D {
> >> +    PLL_35XX_RATE(24 * MHZ, 933000000, 311, 4, 1),
> >> +    PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
> >> +    PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
> >> +    PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
> >> +    PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
> >> +    PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
> >> +    PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
> >> +    PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
> >> +    PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
> >> +    PLL_35XX_RATE(24 * MHZ, 138000000, 184, 2, 4),
> >
> > Except for 825Mhz, I can't find the target frequency
> > on Exynos5422 TRM document. Usually, Exynos TRM specified
> > the supported stable clocks. It means that undefined clocks
> > are not stable as I knew. Where do you find them?
> >
> > When I calculated the PLL frequency with PMS value, it is correct.
> > But, just we need to check the reference of undefined clocks on TRM
> > in order to guarantee the stable operation.
> They values live in vendor code for Android.
> I have tested the DMC & DDR with these ratios in stress scenarios
> for a few days and it was stable.

If possible, please share the url of original vendor code.

>
> >
> > Remove 933/138Mhz because exynos5433-dmc.c doesn't use 933Mhz and 138Mh=
z
> > and also Exynos5422 TRM doesn't define 933/138Mhz on pll table.
> OK, I will remove them.
> >
> >> +};
> >> +
> >>   static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl=
[] =3D {
> >>      PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
> >>      PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
> >> @@ -1467,7 +1480,7 @@ static void __init exynos5x_clk_init(struct devi=
ce_node *np,
> >>              exynos5x_plls[apll].rate_table =3D exynos5420_pll2550x_24=
mhz_tbl;
> >>              exynos5x_plls[epll].rate_table =3D exynos5420_epll_24mhz_=
tbl;
> >>              exynos5x_plls[kpll].rate_table =3D exynos5420_pll2550x_24=
mhz_tbl;
> >> -            exynos5x_plls[bpll].rate_table =3D exynos5420_pll2550x_24=
mhz_tbl;
> >> +            exynos5x_plls[bpll].rate_table =3D exynos5422_bpll_rate_t=
able;
> >
> > Exynos5422 used the same PLL table for apll, kpll, bpll and so on.
> > You don't need to make the separate pll table. Just add new entries
> > to exynos5420_pll2550x_24mhz_tbl table.
> OK, I will extend the exynos5420_pll2550x_24mhz_tbl table.
>
> In v4 patch set, it will be fixed.
>
> Regards,
> Lukasz
> >
> >>      }
> >>
> >>      samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_=
plls),
> >>
> >



--
Best Regards,
Chanwoo Choi
Samsung Electronics
