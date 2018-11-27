Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BC0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250B7208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1mCvwkEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250B7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbeK1HgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:36:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbeK1HgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:36:19 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 722FB2145D;
        Tue, 27 Nov 2018 20:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543351032;
        bh=v0wvMtxOqqdNvl02rRFzgB6Sf07+8yRqZxK6nOIUG3E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1mCvwkELX895UFs2b/2bVNJt0gaZ5bOnVyvIJXOTnkVoZ2zJOKOLFQMjn9I6x4mh8
         KfwiE/g2XHy7483iFI206nNJdoJ6ZhHW7DCzQ7+Mmf/aBT0pAaCPUdQ3r2+uAEzz9P
         /JTJlW1oHNDQ989+TRIMsZwEl1LFphZf11qw2PT8=
Received: by mail-wr1-f48.google.com with SMTP id t3so24087724wrr.3;
        Tue, 27 Nov 2018 12:37:12 -0800 (PST)
X-Gm-Message-State: AA+aEWbshFSK/LP7neZ11mw+OETkq92hIfN7BOkMTQE++96rIGeeADnx
        LG6RRlzoRgEM1Tr3C2YKBqT7LN/cl/7Qjz5+u4o=
X-Google-Smtp-Source: AFSGD/WYUfyCSPnSNBUnPTK58DrZUZCFCavoCLZHE3y2blcxU2C8gY9xJ9zW3DLBtqwc0HDArYd+QFNO/ZSW7uikPMM=
X-Received: by 2002:adf:f28d:: with SMTP id k13mr30136289wro.78.1543351030926;
 Tue, 27 Nov 2018 12:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20181127034254.24721-1-weiyi.lu@mediatek.com> <20181127034254.24721-5-weiyi.lu@mediatek.com>
In-Reply-To: <20181127034254.24721-5-weiyi.lu@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Tue, 27 Nov 2018 12:36:58 -0800
X-Gmail-Original-Message-ID: <CAGp9Lzro5YHCYqzOWFJJa4g75odf6yK52cean_aS3p2STOtJYg@mail.gmail.com>
Message-ID: <CAGp9Lzro5YHCYqzOWFJJa4g75odf6yK52cean_aS3p2STOtJYg@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] clk: mediatek: Disable tuner_en before change
 PLL rate
To:     weiyi.lu@mediatek.com
Cc:     drinkcat@chromium.org, Matthias Brugger <matthias.bgg@gmail.com>,
        sboyd@codeaurora.org, robh@kernel.org, jamesjj.liao@mediatek.com,
        srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        fan.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        owen.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Weiyi Lu <weiyi.lu@mediatek.com> =E6=96=BC 2018=E5=B9=B411=E6=9C=8826=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:45=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Owen Chen <owen.chen@mediatek.com>
>
> PLLs with tuner_en bit, such as APLL1, need to disable
> tuner_en before apply new frequency settings, or the new frequency
> settings (pcw) will not be applied.
> The tuner_en bit will be disabled during changing PLL rate
> and be restored after new settings applied.

It looks like a bug fix. If so, you should add a fixes tag and even cc
stable tree

>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-pll.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pl=
l.c
> index 1db161aced31..81400601f107 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -27,7 +27,7 @@
>  #define CON0_BASE_EN           BIT(0)
>  #define CON0_PWR_ON            BIT(0)
>  #define CON0_ISO_EN            BIT(1)
> -#define CON0_PCW_CHG           BIT(31)
> +#define CON1_PCW_CHG           BIT(31)

it seems like an unnecessary change

>
>  #define AUDPLL_TUNER_EN                BIT(31)
>
> @@ -97,9 +97,31 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *=
pll, u32 pcw,
>  {
>         u32 con1, val;
>         int pll_en;
> +       u32 tuner_en =3D 0;
> +       u32 tuner_en_mask;
> +       void __iomem *tuner_en_addr =3D NULL;
>
>         pll_en =3D readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
>
> +       /* disable tuner */

similar code pieces are ready on mtk_pll_[un]prepare. maybe we can add
common tuner operations for them to reuse.

> +       if (pll->tuner_en_addr) {
> +               tuner_en_addr =3D pll->tuner_en_addr;
> +               tuner_en_mask =3D BIT(pll->data->tuner_en_bit);
> +       } else if (pll->tuner_addr) {
> +               tuner_en_addr =3D pll->tuner_addr;
> +               tuner_en_mask =3D AUDPLL_TUNER_EN;
> +       }
> +
> +       if (tuner_en_addr) {
> +               val =3D readl(tuner_en_addr);
> +               tuner_en =3D val & tuner_en_mask;
> +
> +               if (tuner_en) {
> +                       val &=3D ~tuner_en_mask;
> +                       writel(val, tuner_en_addr);
> +               }
> +       }
> +
>         /* set postdiv */
>         val =3D readl(pll->pd_addr);
>         val &=3D ~(POSTDIV_MASK << pll->data->pd_shift);
> @@ -120,12 +142,19 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pl=
l *pll, u32 pcw,
>         con1 =3D readl(pll->base_addr + REG_CON1);
>
>         if (pll_en)
> -               con1 |=3D CON0_PCW_CHG;
> +               con1 |=3D CON1_PCW_CHG;
>
>         writel(con1, pll->base_addr + REG_CON1);
>         if (pll->tuner_addr)
>                 writel(con1 + 1, pll->tuner_addr);
>
> +       /* restore tuner_en */
> +       if (tuner_en_addr && tuner_en) {

if (tuner_en) is sufficient

> +               val =3D readl(tuner_en_addr);
> +               val |=3D tuner_en_mask;
> +               writel(val, tuner_en_addr);
> +       }
> +
>         if (pll_en)
>                 udelay(20);
>  }
> --
> 2.18.0
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
