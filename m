Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F1CC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6A221473
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dV6LAhZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6A221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeK3LbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:31:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeK3LbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 06:31:19 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42F6820834;
        Fri, 30 Nov 2018 00:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543537436;
        bh=yqFUDKxdhkCSdoOfGf067LjqLpeskD0HSr6L5zeDJfM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=dV6LAhZDIyJyrOkjlnQiGvXRjslhitcnHMh2uwwiHVuG8gU8OYmlrfTAMjf9XwQJL
         tTW5d14SoMOgxMCs3LAGra8dm29zs4yl9f7IrsB/PwW7nqC631E8fYNgmlzkrN/0QD
         p45JtECm476vcRdf++duOP8d2ipnizwykBQiniSI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     avifishman70@gmail.com, brendanhiggins@google.com,
        linux@armlinux.org.uk, mark.rutland@arm.com,
        mturquette@baylibre.com, raltherr@google.com, robh+dt@kernel.org,
        sboyd@codeaurora.org, tali.perry1@gmail.com, tmaimon77@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181111134712.318321-2-tali.perry1@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-clk@vger.kernel.org, Tali Perry <tali.perry1@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
References: <20181111134712.318321-1-tali.perry1@gmail.com>
 <20181111134712.318321-2-tali.perry1@gmail.com>
Message-ID: <154353743563.88331.13076671872913666949@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 1/1] clk: npcm7xx: get fixed clocks from DT
Date:   Thu, 29 Nov 2018 16:23:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting tali.perry1@gmail.com (2018-11-11 05:47:12)
> From: Tali Perry <tali.perry1@gmail.com>
> =

> Nuvoton NPCM7XX Clock Controller
> fix base address and of_clk_get_by_name error handling.
>     Also update error messages to be more informative.
>     =

>     In case clk_base allocation is erronoeous the return value is null.
>     Also fix handling of of_clk_get_by_name returns an error. =

>     Print a better error message pointing to the dt-binding documention.
> =

> This patch is re-submitted since it was already pushed to main =

> (just the diff, without the full driver which is already in =

> master branch.)
> =

> =

> Signed-off-by: Tali Perry <tali.perry1@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> =


I don't know what's going on with this patch. Is it something new? Can
you break it up into logical changes and submit them with proper commit
text? The signoff chain is also odd. Can you follow
Documentation/process/submitting-patches.rst?

> ---
>  drivers/clk/clk-npcm7xx.c | 99 +++++++++++++++++++++++++++++++++++------=
------
>  1 file changed, 75 insertions(+), 24 deletions(-)
> =

> diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
> index 740af90a9508..91a937720f4e 100644
> --- a/drivers/clk/clk-npcm7xx.c
> +++ b/drivers/clk/clk-npcm7xx.c
> @@ -7,17 +7,26 @@
>   * Copyright (C) 2018 Nuvoton Technologies tali.perry@nuvoton.com
>   */
>  =

> -#include <linux/module.h>
> -#include <linux/clk-provider.h>
> -#include <linux/io.h>
> -#include <linux/kernel.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/slab.h>
> -#include <linux/err.h>
> -#include <linux/bitfield.h>
> -
> -#include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
> +
> +
> +
> + #include <linux/module.h>
> + #include <linux/clk.h>
> + #include <linux/clk-provider.h>
> + #include <linux/device.h>
> + #include <linux/io.h>
> + #include <linux/kernel.h>
> + #include <linux/of.h>
> + #include <linux/of_device.h>
> + #include <linux/of_platform.h>
> + #include <linux/of_address.h>
> + #include <linux/platform_device.h>
> + #include <linux/slab.h>
> + #include <linux/err.h>
> + #include <linux/rational.h>
> + #include <linux/bitfield.h>
> + #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>

Is any of this hunk necessary or relevant to the subject of this patch?

> +
>  =

>  struct npcm7xx_clk_pll {
> @@ -44,7 +56,8 @@ static unsigned long npcm7xx_clk_pll_recalc_rate(struct=
 clk_hw *hw,
>         u64 ret;
>  =

>         if (parent_rate =3D=3D 0) {
> -               pr_err("%s: parent rate is zero", __func__);
> +               pr_err("%s: parent rate is zero. reg=3D%x\n", __func__,
> +                       (u32)(pll->pllcon));

Maybe you should print clk name instead of register?

>                 return 0;
>         }
>  =

> @@ -61,13 +74,12 @@ static unsigned long npcm7xx_clk_pll_recalc_rate(stru=
ct clk_hw *hw,
>         return ret;
>  }
>  =

> -static const struct clk_ops npcm7xx_clk_pll_ops =3D {
> +const struct clk_ops npcm7xx_clk_pll_ops =3D {

Why?

>         .recalc_rate =3D npcm7xx_clk_pll_recalc_rate,
>  };
>  =

> -static struct clk_hw *
> -npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
> -                        const char *parent_name, unsigned long flags)
> +static struct clk_hw *npcm7xx_clk_register_pll(void __iomem *pllcon,
> +               const char *name, const char *parent_name, unsigned long =
flags)
>  {
>         struct npcm7xx_clk_pll *pll;
>         struct clk_init_data init;
> @@ -78,7 +90,8 @@ npcm7xx_clk_register_pll(void __iomem *pllcon, const ch=
ar *name,
>         if (!pll)
>                 return ERR_PTR(-ENOMEM);
>  =

> -       pr_debug("%s reg, name=3D%s, p=3D%s\n", __func__, name, parent_na=
me);
> +       pr_debug("%s reg, reg=3D0x%x, name=3D%s, p=3D%s\n",
> +               __func__, (unsigned int)pllcon, name, parent_name);

What's going on here? Why cast?

>  =

>         init.name =3D name;
>         init.ops =3D &npcm7xx_clk_pll_ops;
> @@ -544,9 +557,11 @@ static void __init npcm7xx_clk_init(struct device_no=
de *clk_np)
>         void __iomem *clk_base;
>         struct resource res;
>         struct clk_hw *hw;
> +       struct clk *clk;
>         int ret;
>         int i;
>  =

> +       clk_base =3D NULL;

Why?

>         ret =3D of_address_to_resource(clk_np, 0, &res);
>         if (ret) {
>                 pr_err("%s: failed to get resource, ret %d\n", clk_np->na=
me,
> @@ -560,14 +575,44 @@ static void __init npcm7xx_clk_init(struct device_n=
ode *clk_np)
>  =

>         npcm7xx_clk_data =3D kzalloc(sizeof(*npcm7xx_clk_data->hws) *
>                 NPCM7XX_NUM_CLOCKS + sizeof(npcm7xx_clk_data), GFP_KERNEL=
);
> -       if (!npcm7xx_clk_data)
> +
> +       npcm7xx_clk_data->num =3D 0;

kzalloc already does that initialization to 0 for you.

> +
> +       if (!npcm7xx_clk_data->hws) {
> +               pr_err("Can't alloc npcm7xx_clk_data\n");

We don't need allocation error messages.

>                 goto npcm7xx_init_np_err;
> +       }
>  =

>         npcm7xx_clk_data->num =3D NPCM7XX_NUM_CLOCKS;
>  =

>         for (i =3D 0; i < NPCM7XX_NUM_CLOCKS; i++)
>                 npcm7xx_clk_data->hws[i] =3D ERR_PTR(-EPROBE_DEFER);
>  =

> +       /* Read fixed clocks. These 3 clocks must be defined in DT */
> +       clk =3D of_clk_get_by_name(clk_np, NPCM7XX_CLK_S_REFCLK);
> +       if (IS_ERR(clk)) {
> +               pr_err("failed to find external REFCLK on device tree, er=
r=3D%ld\n",
> +                       PTR_ERR(clk));
> +               clk_put(clk);
> +               goto npcm7xx_init_fail_no_clk_on_dt;
> +       }
> +
> +       clk =3D of_clk_get_by_name(clk_np, NPCM7XX_CLK_S_SYSBYPCK);
> +       if (IS_ERR(clk)) {
> +               pr_err("failed to find external SYSBYPCK on device tree, =
err=3D%ld\n",
> +                       PTR_ERR(clk));
> +               clk_put(clk);
> +               goto npcm7xx_init_fail_no_clk_on_dt;
> +       }
> +
> +       clk =3D of_clk_get_by_name(clk_np, NPCM7XX_CLK_S_MCBYPCK);
> +       if (IS_ERR(clk)) {
> +               pr_err("failed to find external MCBYPCK on device tree, e=
rr=3D%ld\n",
> +                       PTR_ERR(clk));
> +               clk_put(clk);
> +               goto npcm7xx_init_fail_no_clk_on_dt;
> +       }

I assume the DTS is not shipped?

> +
>         /* Register plls */
>         for (i =3D 0; i < ARRAY_SIZE(npcm7xx_plls); i++) {
>                 const struct npcm7xx_clk_pll_data *pll_data =3D &npcm7xx_=
plls[i];
> @@ -584,16 +629,16 @@ static void __init npcm7xx_clk_init(struct device_n=
ode *clk_np)
>         }
>  =

>         /* Register fixed dividers */
> -       hw =3D clk_hw_register_fixed_factor(NULL, NPCM7XX_CLK_S_PLL1_DIV2,
> +       clk =3D clk_register_fixed_factor(NULL, NPCM7XX_CLK_S_PLL1_DIV2,

This is going backwards. Please use clk_hw APIs.

>                         NPCM7XX_CLK_S_PLL1, 0, 1, 2);
> -       if (IS_ERR(hw)) {
> +       if (IS_ERR(clk)) {
>                 pr_err("npcm7xx_clk: Can't register fixed div\n");
>                 goto npcm7xx_init_fail;
>         }
>  =

> -       hw =3D clk_hw_register_fixed_factor(NULL, NPCM7XX_CLK_S_PLL2_DIV2,
> +       clk =3D clk_register_fixed_factor(NULL, NPCM7XX_CLK_S_PLL2_DIV2,
>                         NPCM7XX_CLK_S_PLL2, 0, 1, 2);
> -       if (IS_ERR(hw)) {
> +       if (IS_ERR(clk)) {
>                 pr_err("npcm7xx_clk: Can't register div2\n");
>                 goto npcm7xx_init_fail;
>         }
> @@ -646,11 +691,17 @@ static void __init npcm7xx_clk_init(struct device_n=
ode *clk_np)
>  =

>         return;
>  =

> +npcm7xx_init_fail_no_clk_on_dt:
> +       pr_err("see Documentation/devicetree/bindings/clock/");
> +       pr_err("nuvoton,npcm750-clk.txt  for details\n");
>  npcm7xx_init_fail:
> -       kfree(npcm7xx_clk_data->hws);
> +       if (npcm7xx_clk_data->num)
> +               kfree(npcm7xx_clk_data->hws);
>  npcm7xx_init_np_err:
> -       iounmap(clk_base);
> +       if (clk_base !=3D NULL)
> +               iounmap(clk_base);
>  npcm7xx_init_error:
>         of_node_put(clk_np);
> +       pr_err("clk setup fail\n");

Is this hunk of changes related to the subject of this patch? I don't
think it is, so it just leads to more confusion.

