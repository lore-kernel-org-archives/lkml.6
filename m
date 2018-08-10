Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E980C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02842240A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jg4FurIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02842240A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeHJO5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 10:57:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35423 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeHJO5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 10:57:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id g1-v6so8160938wru.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 05:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q5asY75E9axyOs06QvUyn35cV9Qzuxa7Byev2CApaPY=;
        b=jg4FurIO1QfhlCmPAuO4j4A8WBqT9XBwKIn+igyEml+E7GVgdNeydKfqyMCxE/iKbD
         F/zgaskMU0PNMI25JRtgM+KHo77JRct2bS+Bpr7nnPIMnMcVo2YrMc3l1JPbZfyqrtVB
         1U3Sa08C62i9+3+ffzTXHv+OSeBVIX5hfoZJ5oPNk94h7WVV9UxG5jJ946wlu2SOzgTb
         wr50t1yufUJieCmV4vrPz/CiAEkofVPkUiSfr3R9/4vdBotLWU4k1C2WlRz7QZK8qQuF
         r3oMtJqMcM0jo9ChtAlM+tRDb09s0t9nrAXs8/hB+ZppIx8D9IOjlORbeN42q+ZsJklX
         KS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q5asY75E9axyOs06QvUyn35cV9Qzuxa7Byev2CApaPY=;
        b=W8H/Rb7jtUuzDBIKz1hTcGClWocKayEwrGfiocY+nMyVcP4aqZ2LCArX3erDB8scoq
         es3IYOmChwHLvMXBE2KICwNt8I9HbJ8Yj8PvqfF8zyt2bWSydiItkO8ISTt881OmkmKG
         eALDIPWZEdMyZSqw5kTpToyYKlC0ixjioyZv/bNRMW80iAy2TAFksuUSVPZTjLLifPhW
         mtH2vzLmHnqLIhEb8sHIlSseWkjvtrGX4TG4jvrKF2DdtCn7yZXQnuOwLA5RtP4ispyk
         2/4UnKCXLnL2WjTLTpmJpITycC+VYv9lCD1aTiEN05S4Kz/+8zTjPMPhq9dDcVUZdjLt
         A48Q==
X-Gm-Message-State: AOUpUlE+PeEtAMD2uLvzC8tjppcftd3zqViVj7G6AW1r38j62A97xYUO
        AueMMwv6yTHf/PC7THz7/IkNww==
X-Google-Smtp-Source: AA+uWPyUc3Wsd1gW7sANyzLF3UnP+6jdMaiE6VWHea/7yJina/aZliX24NiTFRZXNrMMBelZLDyAUg==
X-Received: by 2002:adf:ee4e:: with SMTP id w14-v6mr4261168wro.63.1533904044468;
        Fri, 10 Aug 2018 05:27:24 -0700 (PDT)
Received: from boomer (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id q3-v6sm984152wmf.21.2018.08.10.05.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 05:27:23 -0700 (PDT)
Message-ID: <8ba84364847ae800fcfcab34573a25996d8724fd.camel@baylibre.com>
Subject: Re: [PATCH v4 1/3] clk: meson: add emmc sub clock phase delay driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 10 Aug 2018 14:27:21 +0200
In-Reply-To: <20180809070724.11935-2-yixun.lan@amlogic.com>
References: <20180809070724.11935-1-yixun.lan@amlogic.com>
         <20180809070724.11935-2-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-09 at 15:07 +0800, Yixun Lan wrote:
> Export the emmc sub clock phase delay ops which will be used
> by the emmc sub clock driver itself.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  drivers/clk/meson/Makefile          |  2 +-
>  drivers/clk/meson/clk-phase-delay.c | 96 +++++++++++++++++++++++++++++
>  drivers/clk/meson/clkc.h            | 13 ++++
>  3 files changed, 110 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/meson/clk-phase-delay.c
> 
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 72ec8c40d848..39ce5661b654 100644
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
> index 000000000000..6f226814cfec
> --- /dev/null
> +++ b/drivers/clk/meson/clk-phase-delay.c
> @@ -0,0 +1,96 @@
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
> +#define SD_EMMC_CLOCK			0

Drop this and use struct parm please.

> +
> +static int meson_clk_phase_delay_get_phase(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_clk_phase_delay_data *ph =
> +		meson_clk_get_phase_delay_data(clk);
> +	unsigned int phase_num = 1 <<  hweight_long(ph->phase_mask);
> +	unsigned long period_ps, p, d;
> +	int degrees;
> +	u32 val;
> +
> +	regmap_read(clk->map, SD_EMMC_CLOCK, &val);
> +	p = (val & ph->phase_mask) >> __ffs(ph->phase_mask);
> +	degrees = p * 360 / phase_num;
> +
> +	if (ph->delay_mask) {
> +		period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
> +					 clk_hw_get_rate(hw));
> +		d = (val & ph->delay_mask) >> __ffs(ph->delay_mask);
> +		degrees += d * ph->delay_step_ps * 360 / period_ps;
> +		degrees %= 360;
> +	}
> +
> +	return degrees;
> +}
> +
> +static void meson_clk_apply_phase_delay(struct clk_regmap *clk,
> +					unsigned int phase,
> +					unsigned int delay)
> +{
> +	struct meson_clk_phase_delay_data *ph = clk->data;
> +	u32 val;
> +
> +	regmap_read(clk->map, SD_EMMC_CLOCK, &val);
> +
> +	val &= ~ph->phase_mask;
> +	val |= phase << __ffs(ph->phase_mask);
> +
> +	if (ph->delay_mask) {

This imply that delay is delay is optional. In such case, it would be a regular
"phase" and we already have a  driver for this. Please remove all the related
code and make this parameter required for this clock type.

In the future, maybe we'll merge the 2 drivers.

> +		val &= ~ph->delay_mask;
> +		val |= delay << __ffs(ph->delay_mask);
> +	}
> +
> +	regmap_write(clk->map, SD_EMMC_CLOCK, val);
> +}
> +
> +static int meson_clk_phase_delay_set_phase(struct clk_hw *hw, int degrees)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_clk_phase_delay_data *ph =
> +		meson_clk_get_phase_delay_data(clk);
> +	unsigned int phase_num = 1 <<  hweight_long(ph->phase_mask);
> +	unsigned long period_ps, d = 0, r;
> +	u64 p;
> +
> +	p = degrees % 360;
> +
> +	if (!ph->delay_mask) {
> +		p = DIV_ROUND_CLOSEST_ULL(p, 360 / phase_num);
> +	} else {
> +		period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
> +					 clk_hw_get_rate(hw));
> +
> +		/* First compute the phase index (p), the remainder (r) is the
> +		 * part we'll try to acheive using the delays (d).
> +		 */
> +		r = do_div(p, 360 / phase_num);
> +		d = DIV_ROUND_CLOSEST(r * period_ps,
> +				      360 * ph->delay_step_ps);
> +		d = min(d, ph->delay_mask >> __ffs(ph->delay_mask));
> +	}
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
> index 24cec16b6038..499834dd34f2 100644
> --- a/drivers/clk/meson/clkc.h
> +++ b/drivers/clk/meson/clkc.h
> @@ -113,6 +113,18 @@ struct clk_regmap _name = {						\
>  	},								\
>  };
>  
> +struct meson_clk_phase_delay_data {
> +	unsigned long			phase_mask;
> +	unsigned long			delay_mask;

Like every other clock drivers in the amlogic directory, please use struct parm
to decribe the fields.

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
> @@ -120,5 +132,6 @@ extern const struct clk_ops meson_clk_cpu_ops;
>  extern const struct clk_ops meson_clk_mpll_ro_ops;
>  extern const struct clk_ops meson_clk_mpll_ops;
>  extern const struct clk_ops meson_clk_phase_ops;
> +extern const struct clk_ops meson_clk_phase_delay_ops;
>  
>  #endif /* __CLKC_H */


