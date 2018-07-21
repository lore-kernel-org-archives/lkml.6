Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2D2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A43E20849
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="elTNiCL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A43E20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeGUUmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:42:07 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37625 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbeGUUmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:42:06 -0400
Received: by mail-oi0-f67.google.com with SMTP id k81-v6so26950022oib.4;
        Sat, 21 Jul 2018 12:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q6oEVn5yx/k3hupDf55Muj3FFGTm5Tc6j8Vz4eNnCN4=;
        b=elTNiCL6ujYtoTU90e53immOKxJNY1HOsHR3yDpMNNBo5ovutWnHWabkVMU1KFNeHu
         1xBKqfnpgHcl5bTffpTUtR5WRxUWI9GVl87JK47Kb/XoG5xLV52XEzZjkQluvIW7weB7
         51mkg0TXJVUpvvsK9l733nkOXRijGTrEb3vyN96G2NUQ6T3LRwHm9DeyGt9bhk3sX8qR
         9/8sqrCVpg7s9IDX9udil204ASOkcvMc3kzSbHjbBUKpgHV6QBLuMXU7FArnyoCdbEZa
         yGf/ExLPpM6r6kGh78Fbu8CXgsxuOod+zGLi8Stz//X8p4G/mXTcI33u6/IOcs0Zz9TJ
         ydVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6oEVn5yx/k3hupDf55Muj3FFGTm5Tc6j8Vz4eNnCN4=;
        b=j6DCUFErLs28F3P69vMenHY6+H/rTQeo3sDUwWlgZylfMAqWNY+Sdrrav1+GcjpLWD
         KT6+NQ/jMKOP3NL88XsdbhwpqShldMV48pn0TtcST317uJfzv++M20O8VExr+mYag083
         8iDfWESFd7J7B46KihYGHN11wbEMoV0PRHLpVRKSfOafMDknYw0wa+LqT06Q34KJrBLF
         S37PRXJ3RoII6pqo2UGnfF4QCvOILtoho1KPxyyw7ZiDYvIzSp6cJKxfHMrKXOeYFr1b
         pJI0ztUkroq/80/BvYc6w/HM21N1fLZ7qThwbmTxvYJBbXiogskWkxVw0ecIQ3gve8sp
         mjEw==
X-Gm-Message-State: AOUpUlGqK5sWXe3pKBw5V9yE2YOmyJaPkBWv2QrhdFr5rjuoJA3IzKxL
        IMAGKwA1bam+9SQyEKv5/wt5TtcWHUP8l7BHayYK8FR8
X-Google-Smtp-Source: AAOMgpfDDFHFBT+0FZihSODahMhtOgKpN+h5WTHkGBRcto952WjZVqg8UepR4OoCyfAViDwquLNE2jE0AZzNkQfLICA=
X-Received: by 2002:aca:cdc2:: with SMTP id d185-v6mr3160812oig.350.1532202493094;
 Sat, 21 Jul 2018 12:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180717095617.12240-1-jbrunet@baylibre.com> <20180717095617.12240-2-jbrunet@baylibre.com>
In-Reply-To: <20180717095617.12240-2-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 21 Jul 2018 21:48:02 +0200
Message-ID: <CAFBinCCDGKu5U1xY1WG2BHF28YEWd1HbKdDeTCc9fEV_YjSNew@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: meson: clk-pll: add enable bit
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, Jul 17, 2018 at 11:56 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Add the enable the bit of the pll clocks.
> These pll clocks may be disabled but we can't model this as an external
> gate since the pll needs to lock when enabled.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
I have some questions inline, but with those answered:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  drivers/clk/meson/axg.c     | 28 ++++++++++++++++++++++++---
>  drivers/clk/meson/clk-pll.c | 47 ++++++++++++++++++++++++++++++++++++++++-----
>  drivers/clk/meson/clkc.h    |  1 +
>  drivers/clk/meson/gxbb.c    | 32 ++++++++++++++++++++++++++++--
>  drivers/clk/meson/meson8b.c | 15 +++++++++++++++
>  5 files changed, 113 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index 00ce62ad6416..6d8976554656 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -24,6 +24,11 @@ static DEFINE_SPINLOCK(meson_clk_lock);
>
>  static struct clk_regmap axg_fixed_pll = {
>         .data = &(struct meson_clk_pll_data){
> +               .en = {
> +                       .reg_off = HHI_MPLL_CNTL,
> +                       .shift   = 30,
> +                       .width   = 1,
> +               },
>                 .m = {
>                         .reg_off = HHI_MPLL_CNTL,
>                         .shift   = 0,
> @@ -65,6 +70,11 @@ static struct clk_regmap axg_fixed_pll = {
>
>  static struct clk_regmap axg_sys_pll = {
>         .data = &(struct meson_clk_pll_data){
> +               .en = {
> +                       .reg_off = HHI_SYS_PLL_CNTL,
> +                       .shift   = 30,
> +                       .width   = 1,
> +               },
>                 .m = {
>                         .reg_off = HHI_SYS_PLL_CNTL,
>                         .shift   = 0,
> @@ -197,11 +207,15 @@ static const struct reg_sequence axg_gp0_init_regs[] = {
>         { .reg = HHI_GP0_PLL_CNTL3,     .def = 0x0a59a288 },
>         { .reg = HHI_GP0_PLL_CNTL4,     .def = 0xc000004d },
>         { .reg = HHI_GP0_PLL_CNTL5,     .def = 0x00078000 },
> -       { .reg = HHI_GP0_PLL_CNTL,      .def = 0x40010250 },
>  };
>
>  static struct clk_regmap axg_gp0_pll = {
>         .data = &(struct meson_clk_pll_data){
> +               .en = {
> +                       .reg_off = HHI_GP0_PLL_CNTL,
> +                       .shift   = 30,
> +                       .width   = 1,
> +               },
>                 .m = {
>                         .reg_off = HHI_GP0_PLL_CNTL,
>                         .shift   = 0,
> @@ -250,11 +264,15 @@ static const struct reg_sequence axg_hifi_init_regs[] = {
>         { .reg = HHI_HIFI_PLL_CNTL3,    .def = 0x0a6a3a88 },
>         { .reg = HHI_HIFI_PLL_CNTL4,    .def = 0xc000004d },
>         { .reg = HHI_HIFI_PLL_CNTL5,    .def = 0x00058000 },
> -       { .reg = HHI_HIFI_PLL_CNTL,     .def = 0x40010250 },
is this change on purpose? this line set en, m, n, l and od before
maybe you can document it in the commit message

>  };
>
>  static struct clk_regmap axg_hifi_pll = {
>         .data = &(struct meson_clk_pll_data){
> +               .en = {
> +                       .reg_off = HHI_HIFI_PLL_CNTL,
> +                       .shift   = 30,
> +                       .width   = 1,
> +               },
>                 .m = {
>                         .reg_off = HHI_HIFI_PLL_CNTL,
>                         .shift   = 0,
> @@ -637,7 +655,6 @@ static const struct pll_rate_table axg_pcie_pll_rate_table[] = {
>  };
>
>  static const struct reg_sequence axg_pcie_init_regs[] = {
> -       { .reg = HHI_PCIE_PLL_CNTL,     .def = 0x400106c8 },
same as above: is this change on purpose?

>         { .reg = HHI_PCIE_PLL_CNTL1,    .def = 0x0084a2aa },
>         { .reg = HHI_PCIE_PLL_CNTL2,    .def = 0xb75020be },
>         { .reg = HHI_PCIE_PLL_CNTL3,    .def = 0x0a47488e },
> @@ -648,6 +665,11 @@ static const struct reg_sequence axg_pcie_init_regs[] = {
>
>  static struct clk_regmap axg_pcie_pll = {
>         .data = &(struct meson_clk_pll_data){
> +               .en = {
> +                       .reg_off = HHI_PCIE_PLL_CNTL,
> +                       .shift   = 30,
> +                       .width   = 1,
> +               },
>                 .m = {
>                         .reg_off = HHI_PCIE_PLL_CNTL,
>                         .shift   = 0,
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index 3e04617ac47f..8aaefe67025f 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -185,12 +185,45 @@ static void meson_clk_pll_init(struct clk_hw *hw)
>         }
>  }
>
> +static int meson_clk_pll_enable(struct clk_hw *hw)
> +{
> +       struct clk_regmap *clk = to_clk_regmap(hw);
> +       struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
> +
> +       /* Make sure the pll is in reset */
> +       meson_parm_write(clk->map, &pll->rst, 1);
> +
> +       /* Enable the pll */
> +       meson_parm_write(clk->map, &pll->en, 1);
> +
> +       /* Take the pll out reset */
> +       meson_parm_write(clk->map, &pll->rst, 0);
> +
> +       if (meson_clk_pll_wait_lock(hw))
> +               return -EIO;
> +
> +       return 0;
> +}
> +
> +static void meson_clk_pll_disable(struct clk_hw *hw)
> +{
> +       struct clk_regmap *clk = to_clk_regmap(hw);
> +       struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
> +
> +       /* Put the pll is in reset */
> +       meson_parm_write(clk->map, &pll->rst, 1);
> +
> +       /* Disable the pll */
> +       meson_parm_write(clk->map, &pll->en, 0);
> +}
> +
>  static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>                                   unsigned long parent_rate)
>  {
>         struct clk_regmap *clk = to_clk_regmap(hw);
>         struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
>         const struct pll_rate_table *pllt;
> +       unsigned int enabled;
>         unsigned long old_rate;
>         u16 frac = 0;
>
> @@ -203,8 +236,9 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>         if (!pllt)
>                 return -EINVAL;
>
> -       /* Put the pll in reset to write the params */
> -       meson_parm_write(clk->map, &pll->rst, 1);
> +       enabled = meson_parm_read(clk->map, &pll->en);
> +       if (enabled)
> +               meson_clk_pll_disable(hw);
>
>         meson_parm_write(clk->map, &pll->n, pllt->n);
>         meson_parm_write(clk->map, &pll->m, pllt->m);
> @@ -221,10 +255,11 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>                 meson_parm_write(clk->map, &pll->frac, frac);
>         }
>
> -       /* make sure the reset is cleared at this point */
> -       meson_parm_write(clk->map, &pll->rst, 0);
> +       /* If the pll is stopped, bail out now */
> +       if (!enabled)
> +               return 0;
>
> -       if (meson_clk_pll_wait_lock(hw)) {
> +       if (meson_clk_pll_enable(hw)) {
>                 pr_warn("%s: pll did not lock, trying to restore old rate %lu\n",
>                         __func__, old_rate);
>                 /*
> @@ -244,6 +279,8 @@ const struct clk_ops meson_clk_pll_ops = {
>         .recalc_rate    = meson_clk_pll_recalc_rate,
>         .round_rate     = meson_clk_pll_round_rate,
>         .set_rate       = meson_clk_pll_set_rate,
> +       .enable         = meson_clk_pll_enable,
> +       .disable        = meson_clk_pll_disable
>  };
>
>  const struct clk_ops meson_clk_pll_ro_ops = {
> diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
> index 24cec16b6038..c2ee37a78ceb 100644
> --- a/drivers/clk/meson/clkc.h
> +++ b/drivers/clk/meson/clkc.h
> @@ -63,6 +63,7 @@ struct pll_rate_table {
>  #define CLK_MESON_PLL_ROUND_CLOSEST    BIT(0)
>
>  struct meson_clk_pll_data {
> +       struct parm en;
>         struct parm m;
>         struct parm n;
>         struct parm frac;
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index 86d3ae58e84c..5ed34566917c 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -177,6 +177,11 @@ static const struct pll_rate_table gxl_gp0_pll_rate_table[] = {
>
>  static struct clk_regmap gxbb_fixed_pll = {
>         .data = &(struct meson_clk_pll_data){
> +               .en = {
> +                       .reg_off = HHI_MPLL_CNTL,
> +                       .shift   = 30,
> +                       .width   = 1,
> +               },
>                 .m = {
>                         .reg_off = HHI_MPLL_CNTL,
>                         .shift   = 0,
> @@ -230,6 +235,11 @@ static struct clk_fixed_factor gxbb_hdmi_pll_pre_mult = {
>
>  static struct clk_regmap gxbb_hdmi_pll = {
>         .data = &(struct meson_clk_pll_data){
> +               .en = {
> +                       .reg_off = HHI_HDMI_PLL_CNTL,
> +                       .shift   = 30,
> +                       .width   = 1,
> +               },
>                 .m = {
>                         .reg_off = HHI_HDMI_PLL_CNTL,
>                         .shift   = 0,
> @@ -282,6 +292,11 @@ static struct clk_regmap gxbb_hdmi_pll = {
>
>  static struct clk_regmap gxl_hdmi_pll = {
>         .data = &(struct meson_clk_pll_data){
> +               .en = {
> +                       .reg_off = HHI_HDMI_PLL_CNTL,
> +                       .shift   = 30,
> +                       .width   = 1,
> +               },
>                 .m = {
>                         .reg_off = HHI_HDMI_PLL_CNTL,
>                         .shift   = 0,
> @@ -340,6 +355,11 @@ static struct clk_regmap gxl_hdmi_pll = {
>
>  static struct clk_regmap gxbb_sys_pll = {
>         .data = &(struct meson_clk_pll_data){
> +               .en = {
> +                       .reg_off = HHI_SYS_PLL_CNTL,
> +                       .shift   = 30,
> +                       .width   = 1,
> +               },
>                 .m = {
>                         .reg_off = HHI_SYS_PLL_CNTL,
>                         .shift   = 0,
> @@ -379,11 +399,15 @@ static const struct reg_sequence gxbb_gp0_init_regs[] = {
>         { .reg = HHI_GP0_PLL_CNTL2,     .def = 0x69c80000 },
>         { .reg = HHI_GP0_PLL_CNTL3,     .def = 0x0a5590c4 },
>         { .reg = HHI_GP0_PLL_CNTL4,     .def = 0x0000500d },
> -       { .reg = HHI_GP0_PLL_CNTL,      .def = 0x4a000228 },
same as above: is this change on purpose?

>  };
>
>  static struct clk_regmap gxbb_gp0_pll = {
>         .data = &(struct meson_clk_pll_data){
> +               .en = {
> +                       .reg_off = HHI_GP0_PLL_CNTL,
> +                       .shift   = 30,
> +                       .width   = 1,
> +               },
>                 .m = {
>                         .reg_off = HHI_GP0_PLL_CNTL,
>                         .shift   = 0,
> @@ -428,11 +452,15 @@ static const struct reg_sequence gxl_gp0_init_regs[] = {
>         { .reg = HHI_GP0_PLL_CNTL3,     .def = 0x0a59a288 },
>         { .reg = HHI_GP0_PLL_CNTL4,     .def = 0xc000004d },
>         { .reg = HHI_GP0_PLL_CNTL5,     .def = 0x00078000 },
> -       { .reg = HHI_GP0_PLL_CNTL,      .def = 0x40010250 },
same as above: is this change on purpose?


Regards
Martin
