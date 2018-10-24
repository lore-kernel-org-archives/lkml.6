Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBD3C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286292082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oXcNdu6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286292082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeJXR0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:26:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53479 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbeJXR0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:26:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id f8-v6so2110262wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 01:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1XtO4+oBRrVx/c0XAlW9Z/yti7iEErTfBplykocc6Wk=;
        b=oXcNdu6ln+hsr8SdNQ6+melzSbb6q4h1SJVBNMDSr9xYvUkTEtZ7HdAj1u8MToOCG+
         gCocbKciGf3yrOe+a6tt5NdtIVZy0peEKWAfDAWuKZCUM4ROuMQ32i1cQjv6aiCA1C15
         oNaRw39Z1XvVQNBKFlKjN7I2vkLFlOQiPwDofXX4lLX52JeodzY57qsTp+tsv6GWnpJr
         7a87mYym2/CzOvnGA0Az6mCxXMJDlo0BhuyqZt9oq4X4B7hr4VvOvmiDAP6Dzh8FPXSL
         9fR4NxJTHSPAdxNGT2Gk8hqL3xqV7sTZ63RymbjalweOASaP6UuJ55nXN5fpu+xSOVVV
         mZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1XtO4+oBRrVx/c0XAlW9Z/yti7iEErTfBplykocc6Wk=;
        b=evN2AGhcaes143gqxYT6VhuJ0AUi37PHZcwR+6YXMMcEADrHbeiN38Jo+X3dY/BK/1
         Uvq87+DE/yAVMe/VYKy4vaQzkIW9Q2NYjiGqnY9VgDaI5k1ZeFDRIy6hnV5OljZ/DYhp
         /JWrNbSgQ+pRxWCVYjlLgyhJPRqD48h+K+iSpDtGqZ8aAAvEURYOYLP9a3OFm4bM/Fwz
         ngGy0n2UjWSnUijJc5KQniAwLhwPAHZF0gJIFdMhRIEW1rFxBCepHYRHh0G7O+tDXdIB
         uWlxf2fFlC0+AxnjOWRIJyFYnRbED2tgGsHSwuCjIkoYUi22MPFfDuByZsAyO2AhtHfJ
         arnA==
X-Gm-Message-State: AGRZ1gI9/gYwrMsYO0LfGjV9Nux668ApWZhUN8IfE2m4O5VUrw8Hhl7x
        sxvPHNJWwWUpNAFTa/JArfuhig==
X-Google-Smtp-Source: AJdET5dsvmHJE1ApCxHke8P6hV6bLvFokOibzVC62XqI+NZtAPTakxOuP/+lfbwXL+B155bc4L/AmA==
X-Received: by 2002:a1c:1b91:: with SMTP id b139-v6mr1693330wmb.147.1540371539036;
        Wed, 24 Oct 2018 01:58:59 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 77-v6sm6700260wmv.6.2018.10.24.01.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 01:58:58 -0700 (PDT)
Message-ID: <10a0572db79ef0cb4f345c8ba2685bea5670b1a5.camel@baylibre.com>
Subject: Re: [PATCH v5 1/3] clk: meson: add emmc sub clock phase delay driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Wed, 24 Oct 2018 10:58:56 +0200
In-Reply-To: <1539839245-13793-2-git-send-email-jianxin.pan@amlogic.com>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
         <1539839245-13793-2-git-send-email-jianxin.pan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-18 at 13:07 +0800, Jianxin Pan wrote:
> From: Yixun Lan <yixun.lan@amlogic.com>
> 
> Export the emmc sub clock phase delay ops which will be used
> by the emmc sub clock driver itself.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  drivers/clk/meson/Makefile          |  2 +-
>  drivers/clk/meson/clk-phase-delay.c | 79 +++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/clkc.h            | 13 ++++++
>  3 files changed, 93 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/meson/clk-phase-delay.c
> 
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 72ec8c4..39ce566 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for Meson specific clk
>  #
>  
> -obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o
> +obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o clk-phase-delay.o
>  obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o sclk-div.o
>  obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
> diff --git a/drivers/clk/meson/clk-phase-delay.c b/drivers/clk/meson/clk-phase-delay.c
> new file mode 100644
> index 0000000..b9573a7
> --- /dev/null
> +++ b/drivers/clk/meson/clk-phase-delay.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Amlogic Meson MMC Sub Clock Controller Driver
> + *
> + * Copyright (c) 2017 Baylibre SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include "clkc.h"
> +
> +static int meson_clk_phase_delay_get_phase(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_clk_phase_delay_data *ph =
> +		meson_clk_get_phase_delay_data(clk);
> +	unsigned long period_ps, p, d;
> +	int degrees;
> +	u32 val;
> +
> +	regmap_read(clk->map, ph->phase.reg_off, &val);
> +	p = PARM_GET(ph->phase.width, ph->phase.shift, val);

there is an helper for this: meson_parm_read()

> +	degrees = p * 360 / (1 << (ph->phase.width));
> +
> +	period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
> +				 clk_hw_get_rate(hw));
> +
> +	d = PARM_GET(ph->delay.width, ph->delay.shift, val);
> +	degrees += d * ph->delay_step_ps * 360 / period_ps;
> +	degrees %= 360;
> +
> +	return degrees;
> +}
> +
> +static void meson_clk_apply_phase_delay(struct clk_regmap *clk,
> +					unsigned int phase,
> +					unsigned int delay)

This helper function is a bit overkill.
simply call meson_parm_write() twice in meson_clk_phase_delay_set_phase().

> +{
> +	struct meson_clk_phase_delay_data *ph = clk->data;
> +	u32 val;
> +
> +	regmap_read(clk->map, ph->delay.reg_off, &val);
> +	val = PARM_SET(ph->phase.width, ph->phase.shift, val, phase);
> +	val = PARM_SET(ph->delay.width, ph->delay.shift, val, delay);
> +	regmap_write(clk->map, ph->delay.reg_off, val);
> +}
> +
> +static int meson_clk_phase_delay_set_phase(struct clk_hw *hw, int degrees)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_clk_phase_delay_data *ph =
> +		meson_clk_get_phase_delay_data(clk);
> +	unsigned long period_ps, d = 0, r;
> +	u64 p;
> +
> +	p = degrees % 360;
> +	period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
> +				 clk_hw_get_rate(hw));
> +
> +	/* First compute the phase index (p), the remainder (r) is the
> +	 * part we'll try to acheive using the delays (d).
> +	 */
> +	r = do_div(p, 360 / (1 << (ph->phase.width)));
> +	d = DIV_ROUND_CLOSEST(r * period_ps,
> +			      360 * ph->delay_step_ps);
> +	d = min(d, PMASK(ph->delay.width));
> +
> +	meson_clk_apply_phase_delay(clk, p, d);
> +	return 0;
> +}
> +
> +const struct clk_ops meson_clk_phase_delay_ops = {
> +	.get_phase = meson_clk_phase_delay_get_phase,
> +	.set_phase = meson_clk_phase_delay_set_phase,
> +};
> +EXPORT_SYMBOL_GPL(meson_clk_phase_delay_ops);
> diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
> index 6b96d55..3309d78 100644
> --- a/drivers/clk/meson/clkc.h
> +++ b/drivers/clk/meson/clkc.h
> @@ -105,6 +105,18 @@ struct clk_regmap _name = {						\
>  	},								\
>  };
>  
> +struct meson_clk_phase_delay_data {
> +	struct parm			phase;
> +	struct parm			delay;
> +	unsigned int			delay_step_ps;
> +};
> +
> +static inline struct meson_clk_phase_delay_data *
> +meson_clk_get_phase_delay_data(struct clk_regmap *clk)
> +{
> +	return (struct meson_clk_phase_delay_data *)clk->data;
> +}
> +
>  /* clk_ops */
>  extern const struct clk_ops meson_clk_pll_ro_ops;
>  extern const struct clk_ops meson_clk_pll_ops;
> @@ -112,5 +124,6 @@ struct clk_regmap _name = {						\
>  extern const struct clk_ops meson_clk_mpll_ro_ops;
>  extern const struct clk_ops meson_clk_mpll_ops;
>  extern const struct clk_ops meson_clk_phase_ops;
> +extern const struct clk_ops meson_clk_phase_delay_ops;
>  
>  #endif /* __CLKC_H */


