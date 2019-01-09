Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3013C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D902075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547066940;
	bh=cb0SYlVzLEaJ/SdiLk39dlCFU+6Ho8pDktRsskgpI9o=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=Nu6US9/XveB/Ek4QE4KTpYb7h9F+YjtO6juJ8Amq0dSWyAfXGnFDCAiZkTEji9Xim
	 WRbwwVbZu48R/QriSGsdr2NZv/sXq8ns2eTl6/oJF/FixB9P/sHd33UovI3RBkUQFq
	 NIOaHii6DRb5UOxQ6pjXhWKh3iS7iHWxWUw/ghkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfAIUs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:48:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfAIUs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 15:48:59 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0549D206B7;
        Wed,  9 Jan 2019 20:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547066938;
        bh=cb0SYlVzLEaJ/SdiLk39dlCFU+6Ho8pDktRsskgpI9o=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=RzUey9NkunWOHBzLzzBYeFXcQ6tvuKr3e1L5WoqF9VG2Gajz1G/JZN6yxYhI0yGxn
         dQokodwVbFtGDELH7FgVJlGXhcfm8Ih48iKGOovTtnFyC77ohAbPPjWWnF5n1h2nnT
         PsnhuhCaSvtcuHMEEuTRQC/KP5zzLp+HuYJOnKvI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 4/4] clk: meson: add sub MMC clock controller driver
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
In-Reply-To: <1545063850-21504-5-git-send-email-jianxin.pan@amlogic.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <1545063850-21504-1-git-send-email-jianxin.pan@amlogic.com> <1545063850-21504-5-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <154706693724.15366.10802936604309826132@swboyd.mtv.corp.google.com>
Date:   Wed, 09 Jan 2019 12:48:57 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jianxin Pan (2018-12-17 08:24:10)
> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
> new file mode 100644
> index 0000000..2582a98
> --- /dev/null
> +++ b/drivers/clk/meson/mmc-clkc.c
> @@ -0,0 +1,304 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Amlogic Meson MMC Sub Clock Controller Driver
> + *
> + * Copyright (c) 2017 Baylibre SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + * Author: Jianxin Pan <jianxin.pan@amlogic.com>
> + */
> +
> +#include <linux/clk.h>

Do you need this include?

> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/syscon.h>

Is this used?

> +#include <linux/platform_device.h>
[...]
> +       init.num_parents =3D 1;
> +
> +       clk =3D mmc_clkc_register_clk(dev, map, &init, suffix, data);
> +       if (IS_ERR(clk))
> +               dev_err(dev, "%s clock registration failed\n", suffix);
> +
> +       return clk;
> +}
> +
> +static int mmc_clkc_probe(struct platform_device *pdev)
> +{
> +       struct clk_hw_onecell_data *onecell_data;
> +       struct device *dev =3D &pdev->dev;
> +       struct mmc_clkc_data *data;
> +       struct regmap *map;
> +       struct clk_regmap *clk, *core;
> +       struct meson_sclk_div_data *div_data;
> +
> +       /*cast to drop the const in match->data*/
> +       data =3D (struct mmc_clkc_data *)of_device_get_match_data(dev);

Is that necessary? Maybe the users of this should take a const argument
and copy things?

> +       if (!data)
> +               return -ENODEV;
> +
> +       map =3D syscon_node_to_regmap(dev->of_node);
> +       if (IS_ERR(map)) {
> +               dev_err(dev, "could not find mmc clock controller\n");
> +               return PTR_ERR(map);
> +       }
> +
> +       onecell_data =3D devm_kzalloc(dev, sizeof(*onecell_data) +
> +                                   sizeof(*onecell_data->hws) * MMC_MAX_=
CLKS,

struct_size()?
