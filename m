Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA55C04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A31208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYgd3yj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A31208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbeK0VjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:39:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbeK0VjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:39:09 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F255221104;
        Tue, 27 Nov 2018 10:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543315300;
        bh=DyZJsvSVpZiwFoyuoWCFGNzx9gR03t22In5jw9nmAA8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dYgd3yj3nLypcEwOzE2u6tLYovZ9joOtsC2UMz5ysPEEt5x9duEJ13vGMyN/i2aju
         qmtK6QOgy+kEaGHHwWP7No8+fnj8sNhb3pAccm94tYVJMWVMjDUZtfDya/eAORtXab
         GAzd+qE+35iXPEVkLBdUcluNvhgvdAub0hcHL6IQ=
Received: by mail-wr1-f41.google.com with SMTP id t27so14173708wra.6;
        Tue, 27 Nov 2018 02:41:39 -0800 (PST)
X-Gm-Message-State: AA+aEWYl2y7tWf8BvWx5zW50qd6IlAkrqdtKHc1ytXHvELzNPoKbP6eO
        3rfmwxyyfK8j43H/8BNFdOASCF76ToPo2gBRpfc=
X-Google-Smtp-Source: AFSGD/U+JLK+lggTSz7DKjytyfvSLvylfqKbN9TVpc5b7NpMmtVPHCkOqhZKF3u+Ekuo35Jv7sIlLc3dR5ivjHS3PW4=
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr26297335wrw.132.1543315298413;
 Tue, 27 Nov 2018 02:41:38 -0800 (PST)
MIME-Version: 1.0
References: <20181127034254.24721-1-weiyi.lu@mediatek.com> <20181127034254.24721-4-weiyi.lu@mediatek.com>
In-Reply-To: <20181127034254.24721-4-weiyi.lu@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Tue, 27 Nov 2018 02:41:29 -0800
X-Gmail-Original-Message-ID: <CAGp9LzpT62GfaX53mrtBCQ_7qG4S1fFjkBkTi-PeCjMp0B7N0Q@mail.gmail.com>
Message-ID: <CAGp9LzpT62GfaX53mrtBCQ_7qG4S1fFjkBkTi-PeCjMp0B7N0Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] clk: mediatek: add new member to mtk_pll_data
To:     weiyi.lu@mediatek.com
Cc:     drinkcat@chromium.org, Matthias Brugger <matthias.bgg@gmail.com>,
        sboyd@codeaurora.org, robh@kernel.org, jamesjj.liao@mediatek.com,
        srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        fan.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        owen.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> From: Owen Chen <owen.chen@mediatek.com>
>
> 1. pcwibits: The integer bits of pcw for plls is extend to 8 bits,
>    add a variable to indicate this change and
>    backward-compatible.
> 2. fmin: The pll freqency lower-bound is vary from 1GMhz to
>    1.5Ghz, add a variable to indicate platform-dependent.

The patch title seems much general. It should be more specific to
reflect the content,
such as add configurable parameters pcwibits and fmin to mtk_pll.

Apart from that: Acked-by: Sean Wang <sean.wang@kernel.org>

>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mtk.h |  2 ++
>  drivers/clk/mediatek/clk-pll.c | 12 +++++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index f83c2bbb677e..11b5517903d0 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -214,8 +214,10 @@ struct mtk_pll_data {
>         unsigned int flags;
>         const struct clk_ops *ops;
>         u32 rst_bar_mask;
> +       unsigned long fmin;
>         unsigned long fmax;
>         int pcwbits;
> +       int pcwibits;
>         uint32_t pcw_reg;
>         int pcw_shift;
>         const struct mtk_pll_div_table *div_table;
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index f54e4015b0b1..1db161aced31 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -32,6 +32,8 @@
>  #define AUDPLL_TUNER_EN                BIT(31)
>
>  #define POSTDIV_MASK           0x7
> +
> +/* default 7 bits integer, can be overridden with pcwibits. */
>  #define INTEGER_BITS           7
>
>  /*
> @@ -69,11 +71,13 @@ static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
>  {
>         int pcwbits = pll->data->pcwbits;
>         int pcwfbits;
> +       int ibits;
>         u64 vco;
>         u8 c = 0;
>
>         /* The fractional part of the PLL divider. */
> -       pcwfbits = pcwbits > INTEGER_BITS ? pcwbits - INTEGER_BITS : 0;
> +       ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
> +       pcwfbits = pcwbits > ibits ? pcwbits - ibits : 0;
>
>         vco = (u64)fin * pcw;
>
> @@ -138,9 +142,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
>  static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
>                 u32 freq, u32 fin)
>  {
> -       unsigned long fmin = 1000 * MHZ;
> +       unsigned long fmin = pll->data->fmin ? pll->data->fmin : (1000 * MHZ);
>         const struct mtk_pll_div_table *div_table = pll->data->div_table;
>         u64 _pcw;
> +       int ibits;
>         u32 val;
>
>         if (freq > pll->data->fmax)
> @@ -164,7 +169,8 @@ static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
>         }
>
>         /* _pcw = freq * postdiv / fin * 2^pcwfbits */
> -       _pcw = ((u64)freq << val) << (pll->data->pcwbits - INTEGER_BITS);
> +       ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
> +       _pcw = ((u64)freq << val) << (pll->data->pcwbits - ibits);
>         do_div(_pcw, fin);
>
>         *pcw = (u32)_pcw;
> --
> 2.18.0
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
