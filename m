Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E76C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE42218D9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="V2AROSAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfAVJZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:25:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44238 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfAVJZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:25:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so26392830wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 01:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=MrqgqLWrG7dOfnyu/HnsTbsADl4Cb8OFJ8qYb29zAWE=;
        b=V2AROSAK835futxrdHCAlzGyVw6fGKys3LIDGga9Ij8HpjfzulOi/bxPtslmTqNBro
         3ye6CtrhlIbRZrfHAzDG3q4rJLla7fiTA6wq+x4zoejMPxqRB7PyK/OoKSdjgy5MfoOX
         FfoJU1917WCNMw5dwUXHQYt5X6g3ZMy2EmLVnrtGbwkKg0pvNTS36R5a3+VLuc0Qel/f
         s7u6wWPa+mpVlYq8FY89Nm6uwqMXxlVZ28mu49sXsLcX3mRRp77aN5BVZrc2wGR8FoK7
         4FUnN9Al6mcdi2lejVgc6ql9kXCVmYwiO8rl8yr4eL/sg0bTEJ9poYTAa+ExPGCjhKMr
         a1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MrqgqLWrG7dOfnyu/HnsTbsADl4Cb8OFJ8qYb29zAWE=;
        b=CYHLqKNYGkOp1ljYvQBlEfMXHRRhxRWycwuC7Is3nPRtRACpJ/p5Tx8US7SqtJnDMc
         K5RTQS7TkxjnNaOh9rfA4MtA8cZO5tQvpL1xmVSd9r/WVaOkQXnw7jRkGEU05G9gC7jg
         MCFOm98/fIsIFBcHvRlAb2oDk5KECZEbt6KyCc8rPCiH0gJGUD2tYIUJ+XB4oFqJTmb+
         oyEdvySCnp6RgzrOzcPJah7uGP2fsw/CwtgAPdcWlOaU89zv+KIf3L+v6SWrJC+yonTN
         WV3k8FEaA60PrilZ15DcaWM+lcyEUXaZV/mBGyMPc5zCHkhj9rvd1zkolysj6N2G/qqi
         xcKg==
X-Gm-Message-State: AJcUukcxSC+Z4PNjoRcCFnQsQj3tRQKuyP/+80FDRzNeYNDXI/Jk0G24
        /la8k8xnKn9zkXs+m5kC2CW/ww==
X-Google-Smtp-Source: ALg8bN7SPU5L5L7hko79UgVOMttii1gtPIUS3KyEQ+skdqx9v0b+CucL8tbF2+WwtXkAMJdMuinwzA==
X-Received: by 2002:adf:9c01:: with SMTP id f1mr33110215wrc.286.1548149118765;
        Tue, 22 Jan 2019 01:25:18 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id h17sm96526521wrt.59.2019.01.22.01.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 01:25:18 -0800 (PST)
Message-ID: <024e1206ad8c103ef67a72fb2a48cdd5ec634a12.camel@baylibre.com>
Subject: Re: [PATCH v9 1/4] clk: meson: add one based divider support for
 sclk divider
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Tue, 22 Jan 2019 10:25:15 +0100
In-Reply-To: <1546955444-7549-2-git-send-email-jianxin.pan@amlogic.com>
References: <1546955444-7549-1-git-send-email-jianxin.pan@amlogic.com>
         <1546955444-7549-2-git-send-email-jianxin.pan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-08 at 21:50 +0800, Jianxin Pan wrote:
> When CLK_DIVIDER_ONE_BASED flag is set, the sclk divider will be:
> one based divider (div = val), and zero value gates the clock
> 
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  drivers/clk/meson/Makefile     |  3 ++-
>  drivers/clk/meson/clkc-audio.h |  8 ------
>  drivers/clk/meson/clkc.h       | 10 ++++++-
>  drivers/clk/meson/sclk-div.c   | 59 ++++++++++++++++++++++++++++-----------
> ---
>  4 files changed, 50 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index a849aa8..acd8694 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -4,7 +4,8 @@
>  
>  obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o vid-
> pll-div.o
>  obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-input.o
> -obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o sclk-div.o
> +obj-$(CONFIG_COMMON_CLK_AMLOGIC) += sclk-div.o
> +obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO) += clk-triphase.o
>  obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>  obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-
> 32k.o
> diff --git a/drivers/clk/meson/clkc-audio.h b/drivers/clk/meson/clkc-audio.h
> index 0a7c157..286ff12 100644
> --- a/drivers/clk/meson/clkc-audio.h
> +++ b/drivers/clk/meson/clkc-audio.h
> @@ -15,14 +15,6 @@ struct meson_clk_triphase_data {
>  	struct parm ph2;
>  };
>  
> -struct meson_sclk_div_data {
> -	struct parm div;
> -	struct parm hi;
> -	unsigned int cached_div;
> -	struct clk_duty cached_duty;
> -};
> -
>  extern const struct clk_ops meson_clk_triphase_ops;
> -extern const struct clk_ops meson_sclk_div_ops;
>  
>  #endif /* __MESON_CLKC_AUDIO_H */
> diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
> index 6183b22..00b3320 100644
> --- a/drivers/clk/meson/clkc.h
> +++ b/drivers/clk/meson/clkc.h
> @@ -27,6 +27,14 @@ struct parm {
>  	u8	width;
>  };
>  
> +struct meson_sclk_div_data {
> +	struct parm div;
> +	struct parm hi;
> +	unsigned int cached_div;
> +	struct clk_duty cached_duty;
> +	u8 flags;
> +};
> +
>  static inline unsigned int meson_parm_read(struct regmap *map, struct parm
> *p)
>  {
>  	unsigned int val;
> @@ -118,10 +126,10 @@ struct clk_regmap _name = {				
> 		\
>  extern const struct clk_ops meson_clk_mpll_ops;
>  extern const struct clk_ops meson_clk_phase_ops;
>  extern const struct clk_ops meson_vid_pll_div_ro_ops;
> +extern const struct clk_ops meson_sclk_div_ops;
>  
>  struct clk_hw *meson_clk_hw_register_input(struct device *dev,
>  					   const char *of_name,
>  					   const char *clk_name,
>  					   unsigned long flags);
> -
>  #endif /* __CLKC_H */
> diff --git a/drivers/clk/meson/sclk-div.c b/drivers/clk/meson/sclk-div.c
> index bc64019..a6c425b 100644
> --- a/drivers/clk/meson/sclk-div.c
> +++ b/drivers/clk/meson/sclk-div.c
> @@ -4,42 +4,60 @@
>   * Author: Jerome Brunet <jbrunet@baylibre.com>
>   *
>   * Sample clock generator divider:
> - * This HW divider gates with value 0 but is otherwise a zero based
> divider:
> + * This HW divider gates with value 0
>   *
>   * val >= 1
> - * divider = val + 1
> + * divider = val + 1 if ONE_BASED is not set, otherwise divider = val.
>   *
>   * The duty cycle may also be set for the LR clock variant. The duty cycle
>   * ratio is:
>   *
>   * hi = [0 - val]
> - * duty_cycle = (1 + hi) / (1 + val)
> + * duty_cycle = (1 + hi) / (1 + val) if ONE_BASED is not set, otherwise:
> + * duty_cycle = hi / (1 + val)
>   */
>  
> -#include "clkc-audio.h"
> +#include "clkc.h"
>  
> -static inline struct meson_sclk_div_data *
> -meson_sclk_div_data(struct clk_regmap *clk)
> +static inline int get_reg(int val, unsigned char flag)

s/get_reg/sclk_get_reg

>  {
> -	return (struct meson_sclk_div_data *)clk->data;
> +	WARN_ON(val < 1);

I don't think this WARN is justified, especially since you are using this
function to set the hi value.

> +	if ((flag & CLK_DIVIDER_ONE_BASED) || !val)

I don't like that you make a dependency on the generic divider just for this.
Please make your own flag like MESON_SCLK_ONE_BASED

> +		return val;
> +	else
> +		return val - 1;
> +}
> +
> +static inline int get_value(int reg, unsigned char flag)

s/get_value/sclk_get_divider

> +{
> +	if (flag & CLK_DIVIDER_ONE_BASED)
> +		return reg;
> +	else
> +		return reg + 1;
>  }
>  
> -static int sclk_div_maxval(struct meson_sclk_div_data *sclk)
> +static inline struct meson_sclk_div_data *
> +meson_sclk_div_data(struct clk_regmap *clk)
>  {
> -	return (1 << sclk->div.width) - 1;
> +	return (struct meson_sclk_div_data *)clk->data;
>  }
>  
>  static int sclk_div_maxdiv(struct meson_sclk_div_data *sclk)
>  {
> -	return sclk_div_maxval(sclk) + 1;
> +	unsigned int reg = clk_div_mask(sclk->div.width);

same here, leave the generic divider alone.
 
`(1 << sclk->div.width) - 1` was fine to get max register value.

> +
> +	return get_value(reg, sclk->flags);
>  }
>  
>  static int sclk_div_getdiv(struct clk_hw *hw, unsigned long rate,
>  			   unsigned long prate, int maxdiv)
>  {
>  	int div = DIV_ROUND_CLOSEST_ULL((u64)prate, rate);
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
> +	int mindiv = get_value(1, sclk->flags);

maxdiv is provided as a param while mindiv is computed inside this function.
let's be coherent and pick one approach.

>  
> -	return clamp(div, 2, maxdiv);
> +	return clamp(div, mindiv, maxdiv);
>  }
>  
>  static int sclk_div_bestdiv(struct clk_hw *hw, unsigned long rate,
> @@ -47,7 +65,7 @@ static int sclk_div_bestdiv(struct clk_hw *hw, unsigned
> long rate,
>  			    struct meson_sclk_div_data *sclk)
>  {
>  	struct clk_hw *parent = clk_hw_get_parent(hw);
> -	int bestdiv = 0, i;
> +	int bestdiv = 0, i, mindiv;
>  	unsigned long maxdiv, now, parent_now;
>  	unsigned long best = 0, best_parent = 0;
>  
> @@ -64,8 +82,9 @@ static int sclk_div_bestdiv(struct clk_hw *hw, unsigned
> long rate,
>  	 * unsigned long in rate * i below
>  	 */
>  	maxdiv = min(ULONG_MAX / rate, maxdiv);
> +	mindiv = get_value(1, sclk->flags);
>  
> -	for (i = 2; i <= maxdiv; i++) {
> +	for (i = mindiv; i <= maxdiv; i++) {
>  		/*
>  		 * It's the most ideal case if the requested rate can be
>  		 * divided from parent clock without needing to change
> @@ -111,10 +130,7 @@ static void sclk_apply_ratio(struct clk_regmap *clk,
>  					    sclk->cached_duty.num,
>  					    sclk->cached_duty.den);
>  
> -	if (hi)
> -		hi -= 1;
> -
> -	meson_parm_write(clk->map, &sclk->hi, hi);
> +	meson_parm_write(clk->map, &sclk->hi, get_reg(hi, sclk->flags));
>  }
>  
>  static int sclk_div_set_duty_cycle(struct clk_hw *hw,
> @@ -145,7 +161,7 @@ static int sclk_div_get_duty_cycle(struct clk_hw *hw,
>  	}
>  
>  	hi = meson_parm_read(clk->map, &sclk->hi);
> -	duty->num = hi + 1;
> +	duty->num = get_value(hi, sclk->flags);
>  	duty->den = sclk->cached_div;
>  	return 0;
>  }
> @@ -153,10 +169,13 @@ static int sclk_div_get_duty_cycle(struct clk_hw *hw,
>  static void sclk_apply_divider(struct clk_regmap *clk,
>  			       struct meson_sclk_div_data *sclk)
>  {
> +	unsigned int div;
> +
>  	if (MESON_PARM_APPLICABLE(&sclk->hi))
>  		sclk_apply_ratio(clk, sclk);
>  
> -	meson_parm_write(clk->map, &sclk->div, sclk->cached_div - 1);
> +	div = get_reg(sclk->cached_div, sclk->flags);
> +	meson_parm_write(clk->map, &sclk->div, div);
>  }
>  
>  static int sclk_div_set_rate(struct clk_hw *hw, unsigned long rate,
> @@ -224,7 +243,7 @@ static void sclk_div_init(struct clk_hw *hw)
>  	if (!val)
>  		sclk->cached_div = sclk_div_maxdiv(sclk);
>  	else
> -		sclk->cached_div = val + 1;
> +		sclk->cached_div = get_value(val, sclk->flags);
>  
>  	sclk_div_get_duty_cycle(hw, &sclk->cached_duty);
>  }


