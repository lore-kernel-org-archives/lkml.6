Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_PAST_96_XX,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3D4C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DF32241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZQGJA0mU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DF32241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbeKMINz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:13:55 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38736 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730587AbeKMINz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:13:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id p4-v6so4972169plo.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 14:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=a4u/jlBP9RZOVfS8Va4jGnFIBZxgatKBrrn5fbtqYyg=;
        b=ZQGJA0mUDXgIjmklBpx+FpUR4trb8RcS4g0vZsO2DsEhgmVw65ibg6bczE8kBmR3ZV
         AmwkJOi9U7FeeCe1rYJUxQEaHYNd/l1oVKe4LkQrl7NWXrKVXjUBd1FmtimwgHCR9TvF
         LsFhs94ePU9gWjWFfqn3Veq88NR4W08VMtn1Rcpiv7d9Evgu8/RHgoAauGQVcSd4dZtG
         H5bE96uNJZDsqYx2xcMmXbCYkU+PqPoDK+Ud0DqqZGZtTF8CzGWx6wN2HFH2TR5tWueN
         Ks7pETP7NcHjOPatW/oZUe68sF5rIfh6ng2w1ZnFov6cJpRXvNg6UvdM3KqKXf+iO4wI
         tKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=a4u/jlBP9RZOVfS8Va4jGnFIBZxgatKBrrn5fbtqYyg=;
        b=ln6KMM/sYiyQxP6OcVL1FamDozEuehTmOkxnjeH/RLpgxzz5guQKm3sQPQIJHocG3r
         9EwzuMnzZWuvE0YSIwKUFhK1ptAQVNXY7YM9JDsQT2TAyvxHo4MYRJsR/Clj5ZQVdH/G
         xWie8+wNZyz8MXZ8giHROtzii3dv2KC4AdWHLPd2FncGUj9VQ6kxyWGJRtg+Yma38j60
         oyjY6Rlq579gZSbHj3RqfLQLcH3p58yhPtkCojBjZORXjjlmiqdBbvd22CoCmrtz1Hwr
         ieK04D9TY2GPL4CLKSa2cJ4Z5bPIuTZi7uslwQG9pEmo7t7HVUbcOy8AXnrlIDMaE4t0
         C2Vg==
X-Gm-Message-State: AGRZ1gLGevnD3YYKIGyU/PiO0Fmg4ysse0IKFgrB8JKwWgt0P8Z5Wby0
        qanFWWrYP27XHcH0ASDVjnhrMQ==
X-Google-Smtp-Source: AJdET5cHYZcf4hGOBBwhAciWAWtFrmjdf4vVxsXmMzSRpJHImPjTDldMetS4K8/5WAcNt1fHipttrg==
X-Received: by 2002:a17:902:c7:: with SMTP id a65-v6mr2649345pla.296.1542061126816;
        Mon, 12 Nov 2018 14:18:46 -0800 (PST)
Received: from localhost ([2605:e000:151d:2254:69be:948f:308c:ece4])
        by smtp.gmail.com with ESMTPSA id m12-v6sm21436821pff.173.2018.11.12.14.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 14:18:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
From:   Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <1540127173-21346-2-git-send-email-aisheng.dong@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
References: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
 <1540127173-21346-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20181105005928.12299.56045@resonance>
User-Agent: alot/0.7
Subject: Re: [PATCH RESEND V4 1/9] clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk
 support
Date:   Sun, 04 Nov 2018 16:59:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dong,

Quoting A.s. Dong (2018-10-21 06:10:48)
> For dividers with zero indicating clock is disabled, instead of giving a
> warning each time like "clkx: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not
> set" in exist code, we'd like to introduce enable/disable function for it.
> e.g.
> 000b - Clock disabled
> 001b - Divide by 1
> 010b - Divide by 2
> ...

I feel bad to NAK this patch after it's been on the list for so long,
but this implementation really should belong in your hardware specific
clock provider driver.

This patch expands clk-divider to also be a gate, which is a
non-starter.  Basic clock types were meant to remain basic. I'm already
imagining how this precedent would cause other submissions: "why should
I use composite clock when we can just add new clk_ops to the basic
clock types!" :-(

Also the implementation becomes cleaner when you don't have to make it
coexist with clk-divider.c. You can drop the flags and just implement a
machine specific clock type that combines gates and dividers.

Best regards,
Mike

> =

> Set rate when the clk is disabled will cache the rate request and only
> when the clk is enabled will the driver actually program the hardware to
> have the requested divider value. Similarly, when the clk is disabled we'=
ll
> write a 0 there, but when the clk is enabled we'll restore whatever rate
> (divider) was chosen last.
> =

> It does mean that recalc rate will be sort of odd, because when the clk is
> off it will return 0, and when the clk is on it will return the right rat=
e.
> So to make things work, we'll need to return the cached rate in recalc ra=
te
> when the clk is off and read the hardware when the clk is on.
> =

> NOTE for the default off divider, the recalc rate will still return 0 as
> there's still no proper preset rate. Enable such divider will give user
> a reminder error message.
> =

> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> =

> ---
> ChangeLog:
> v3->v4:
>  * no changes
> v2->v3:
>  * split normal and gate ops
>  * fix the possible racy
> v1->v2:
>  * add enable/disable for the type of CLK_DIVIDER_ZERO_GATE dividers
> ---
>  drivers/clk/clk-divider.c    | 152 +++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/clk-provider.h |   9 +++
>  2 files changed, 161 insertions(+)
> =

> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index b6234a5..b3566fd 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -122,6 +122,9 @@ unsigned long divider_recalc_rate(struct clk_hw *hw, =
unsigned long parent_rate,
>  =

>         div =3D _get_div(table, val, flags, width);
>         if (!div) {
> +               if (flags & CLK_DIVIDER_ZERO_GATE)
> +                       return 0;
> +
>                 WARN(!(flags & CLK_DIVIDER_ALLOW_ZERO),
>                         "%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not =
set\n",
>                         clk_hw_get_name(hw));
> @@ -145,6 +148,34 @@ static unsigned long clk_divider_recalc_rate(struct =
clk_hw *hw,
>                                    divider->flags, divider->width);
>  }
>  =

> +static unsigned long clk_divider_gate_recalc_rate(struct clk_hw *hw,
> +                                                 unsigned long parent_ra=
te)
> +{
> +       struct clk_divider *divider =3D to_clk_divider(hw);
> +       unsigned long flags =3D 0;
> +       unsigned int val;
> +
> +       if (divider->lock)
> +               spin_lock_irqsave(divider->lock, flags);
> +       else
> +               __acquire(divider->lock);
> +
> +       if (!clk_hw_is_enabled(hw)) {
> +               val =3D divider->cached_val;
> +       } else {
> +               val =3D clk_readl(divider->reg) >> divider->shift;
> +               val &=3D clk_div_mask(divider->width);
> +       }
> +
> +       if (divider->lock)
> +               spin_unlock_irqrestore(divider->lock, flags);
> +       else
> +               __release(divider->lock);
> +
> +       return divider_recalc_rate(hw, parent_rate, val, divider->table,
> +                                  divider->flags, divider->width);
> +}
> +
>  static bool _is_valid_table_div(const struct clk_div_table *table,
>                                                          unsigned int div)
>  {
> @@ -437,6 +468,108 @@ static int clk_divider_set_rate(struct clk_hw *hw, =
unsigned long rate,
>         return 0;
>  }
>  =

> +static int clk_divider_gate_set_rate(struct clk_hw *hw, unsigned long ra=
te,
> +                               unsigned long parent_rate)
> +{
> +       struct clk_divider *divider =3D to_clk_divider(hw);
> +       unsigned long flags =3D 0;
> +       int value;
> +       u32 val;
> +
> +       value =3D divider_get_val(rate, parent_rate, divider->table,
> +                               divider->width, divider->flags);
> +       if (value < 0)
> +               return value;
> +
> +       if (divider->lock)
> +               spin_lock_irqsave(divider->lock, flags);
> +       else
> +               __acquire(divider->lock);
> +
> +       if (clk_hw_is_enabled(hw)) {
> +               if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
> +                       val =3D clk_div_mask(divider->width) << (divider-=
>shift + 16);
> +               } else {
> +                       val =3D clk_readl(divider->reg);
> +                       val &=3D ~(clk_div_mask(divider->width) << divide=
r->shift);
> +               }
> +               val |=3D (u32)value << divider->shift;
> +               clk_writel(val, divider->reg);
> +       } else {
> +               divider->cached_val =3D value;
> +       }
> +
> +       if (divider->lock)
> +               spin_unlock_irqrestore(divider->lock, flags);
> +       else
> +               __release(divider->lock);
> +
> +       return 0;
> +}
> +
> +static int clk_divider_enable(struct clk_hw *hw)
> +{
> +       struct clk_divider *divider =3D to_clk_divider(hw);
> +       unsigned long flags =3D 0;
> +       u32 val;
> +
> +       if (!divider->cached_val) {
> +               pr_err("%s: no valid preset rate\n", clk_hw_get_name(hw));
> +               return -EINVAL;
> +       }
> +
> +       if (divider->lock)
> +               spin_lock_irqsave(divider->lock, flags);
> +       else
> +               __acquire(divider->lock);
> +
> +       /* restore div val */
> +       val =3D clk_readl(divider->reg);
> +       val |=3D divider->cached_val << divider->shift;
> +       clk_writel(val, divider->reg);
> +
> +       if (divider->lock)
> +               spin_unlock_irqrestore(divider->lock, flags);
> +       else
> +               __release(divider->lock);
> +
> +       return 0;
> +}
> +
> +static void clk_divider_disable(struct clk_hw *hw)
> +{
> +       struct clk_divider *divider =3D to_clk_divider(hw);
> +       unsigned long flags =3D 0;
> +       u32 val;
> +
> +       if (divider->lock)
> +               spin_lock_irqsave(divider->lock, flags);
> +       else
> +               __acquire(divider->lock);
> +
> +       /* store the current div val */
> +       val =3D clk_readl(divider->reg) >> divider->shift;
> +       val &=3D clk_div_mask(divider->width);
> +       divider->cached_val =3D val;
> +       clk_writel(0, divider->reg);
> +
> +       if (divider->lock)
> +               spin_unlock_irqrestore(divider->lock, flags);
> +       else
> +               __release(divider->lock);
> +}
> +
> +static int clk_divider_is_enabled(struct clk_hw *hw)
> +{
> +       struct clk_divider *divider =3D to_clk_divider(hw);
> +       u32 val;
> +
> +       val =3D clk_readl(divider->reg) >> divider->shift;
> +       val &=3D clk_div_mask(divider->width);
> +
> +       return val ? 1 : 0;
> +}
> +
>  const struct clk_ops clk_divider_ops =3D {
>         .recalc_rate =3D clk_divider_recalc_rate,
>         .round_rate =3D clk_divider_round_rate,
> @@ -444,6 +577,16 @@ const struct clk_ops clk_divider_ops =3D {
>  };
>  EXPORT_SYMBOL_GPL(clk_divider_ops);
>  =

> +const struct clk_ops clk_divider_gate_ops =3D {
> +       .recalc_rate =3D clk_divider_gate_recalc_rate,
> +       .round_rate =3D clk_divider_round_rate,
> +       .set_rate =3D clk_divider_gate_set_rate,
> +       .enable =3D clk_divider_enable,
> +       .disable =3D clk_divider_disable,
> +       .is_enabled =3D clk_divider_is_enabled,
> +};
> +EXPORT_SYMBOL_GPL(clk_divider_gate_ops);
> +
>  const struct clk_ops clk_divider_ro_ops =3D {
>         .recalc_rate =3D clk_divider_recalc_rate,
>         .round_rate =3D clk_divider_round_rate,
> @@ -459,6 +602,7 @@ static struct clk_hw *_register_divider(struct device=
 *dev, const char *name,
>         struct clk_divider *div;
>         struct clk_hw *hw;
>         struct clk_init_data init;
> +       u32 val;
>         int ret;
>  =

>         if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {
> @@ -476,6 +620,8 @@ static struct clk_hw *_register_divider(struct device=
 *dev, const char *name,
>         init.name =3D name;
>         if (clk_divider_flags & CLK_DIVIDER_READ_ONLY)
>                 init.ops =3D &clk_divider_ro_ops;
> +       else if (clk_divider_flags & CLK_DIVIDER_ZERO_GATE)
> +               init.ops =3D &clk_divider_gate_ops;
>         else
>                 init.ops =3D &clk_divider_ops;
>         init.flags =3D flags | CLK_IS_BASIC;
> @@ -491,6 +637,12 @@ static struct clk_hw *_register_divider(struct devic=
e *dev, const char *name,
>         div->hw.init =3D &init;
>         div->table =3D table;
>  =

> +       if (div->flags & CLK_DIVIDER_ZERO_GATE) {
> +               val =3D clk_readl(reg) >> shift;
> +               val &=3D clk_div_mask(width);
> +               div->cached_val =3D val;
> +       }
> +
>         /* register the clock */
>         hw =3D &div->hw;
>         ret =3D clk_hw_register(dev, hw);
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 08b1aa7..08f135a 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -387,6 +387,7 @@ struct clk_div_table {
>   * @shift:     shift to the divider bit field
>   * @width:     width of the divider bit field
>   * @table:     array of value/divider pairs, last entry should have div =
=3D 0
> + * @cached_val: cached div hw value used for CLK_DIVIDER_ZERO_GATE
>   * @lock:      register lock
>   *
>   * Clock with an adjustable divider affecting its output frequency.  Imp=
lements
> @@ -415,6 +416,12 @@ struct clk_div_table {
>   * CLK_DIVIDER_MAX_AT_ZERO - For dividers which are like CLK_DIVIDER_ONE=
_BASED
>   *     except when the value read from the register is zero, the divisor=
 is
>   *     2^width of the field.
> + * CLK_DIVIDER_ZERO_GATE - For dividers which are like CLK_DIVIDER_ONE_B=
ASED
> + *     when the value read from the register is zero, it means the divis=
or
> + *     is gated. For this case, the cached_val will be used to store the
> + *     intermediate div for the normal rate operation, like set_rate/get=
_rate/
> + *     recalc_rate. When the divider is ungated, the driver will actually
> + *     program the hardware to have the requested divider value.
>   */
>  struct clk_divider {
>         struct clk_hw   hw;
> @@ -423,6 +430,7 @@ struct clk_divider {
>         u8              width;
>         u8              flags;
>         const struct clk_div_table      *table;
> +       u32             cached_val;
>         spinlock_t      *lock;
>  };
>  =

> @@ -436,6 +444,7 @@ struct clk_divider {
>  #define CLK_DIVIDER_ROUND_CLOSEST      BIT(4)
>  #define CLK_DIVIDER_READ_ONLY          BIT(5)
>  #define CLK_DIVIDER_MAX_AT_ZERO                BIT(6)
> +#define CLK_DIVIDER_ZERO_GATE          BIT(7)
>  =

>  extern const struct clk_ops clk_divider_ops;
>  extern const struct clk_ops clk_divider_ro_ops;
> -- =

> 2.7.4
>=20
