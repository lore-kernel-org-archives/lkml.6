Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2D0C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5F7206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="G11bWcoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5F7206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbeGSJPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:15:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39013 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbeGSJPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:15:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so7158731wre.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IIZgdjpEZOt2jAZ4/1N7d5kXqTyTp+UVlSzkQeWMC78=;
        b=G11bWcoVl0RaHaPxpXaOWt/IqxZXsI8KU7C1NV+7LUNATyn9LAqbCzuIPEn9OaJSBl
         /Tm1ZYofMl7h92yI1QWMIgAFIu8tf50HSaq1clcf2D8Z3D1LYlYQ3Pi0w4+dhTIUYiuV
         ijv91wMTEUUeCDUnAgp5Xft1+zlOyXhRn/x4XKcA8aOmX+LlOxXJHBFzO3COIHlqhEtu
         y8hxvfb+PnEJQo5TV1CKveMLK/Gff6hXK5suR4TcKve9a+6AqVqLziqyzDiAAg70agPO
         Vcp4UF0ILJMXfP3m2c3I2z1mR48j2xwkdwrPLHr8xLn4UrcJEU7fzOqScOVqnXPnm6x5
         VLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IIZgdjpEZOt2jAZ4/1N7d5kXqTyTp+UVlSzkQeWMC78=;
        b=heELo/Dr9RGRBE91joWyLKgGvWv02PQ3YFvlYEtV5w6FUNgxsLk/+ZQvmo1oAj/9S2
         OGUxeNDmY3S6AQY5BT9FWT4/H8AKfvlBavILU2SLmuhgI8hVMCGPSxmM/OiQTH+Z5wBx
         lIHQd2T2O1KSerUhAAtDajS7f+jIDC0mjzhtnkU8FgEGxqH3leBxLJwpZv1gT8z/cIUd
         bDJb5k/aRvEHnMdd1xZosiMXnGlIf9tSIM/Q733mA4q4SsDfA7OJ66WpM33KdYFF8fJn
         EpExcx/eXyTBjf162l9PHwHKqUrvJKgSCtLO14scie8FixipTn++66wY4Ngc3X/HTymo
         6pOA==
X-Gm-Message-State: AOUpUlG+m1y3HWlh39WdPq1jxo+5sWNZy6ERRaT+3zOKlKmPRGY3x26N
        Ot3mq+r10g6KPON1cxdcHVQWYw==
X-Google-Smtp-Source: AAOMgpc7PwL7kmggy7yK9VKqaU5aRciL8Dg2WIY2cVavx/idoGNcKFkQueXkCOllbV6JXNOo1u15Bg==
X-Received: by 2002:adf:a789:: with SMTP id j9-v6mr6287800wrc.277.1531989226483;
        Thu, 19 Jul 2018 01:33:46 -0700 (PDT)
Received: from [192.168.1.24] (LFbn-MAR-1-570-38.w90-118.abo.wanadoo.fr. [90.118.15.38])
        by smtp.gmail.com with ESMTPSA id q140-v6sm6094045wmb.35.2018.07.19.01.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 01:33:45 -0700 (PDT)
Subject: Re: [PATCH 1/3] clk: meson: clk-pll: add enable bit
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20180717095617.12240-1-jbrunet@baylibre.com>
 <20180717095617.12240-2-jbrunet@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwE0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAcLAXwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8g
Organization: Baylibre
Message-ID: <82297468-1729-099d-72cc-88072759c797@baylibre.com>
Date:   Thu, 19 Jul 2018 10:33:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180717095617.12240-2-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2018 11:56, Jerome Brunet wrote:
> Add the enable the bit of the pll clocks.
> These pll clocks may be disabled but we can't model this as an external
> gate since the pll needs to lock when enabled.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
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
>  	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = HHI_MPLL_CNTL,
> +			.shift   = 30,
> +			.width   = 1,
> +		},
>  		.m = {
>  			.reg_off = HHI_MPLL_CNTL,
>  			.shift   = 0,
> @@ -65,6 +70,11 @@ static struct clk_regmap axg_fixed_pll = {
>  
>  static struct clk_regmap axg_sys_pll = {
>  	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = HHI_SYS_PLL_CNTL,
> +			.shift   = 30,
> +			.width   = 1,
> +		},
>  		.m = {
>  			.reg_off = HHI_SYS_PLL_CNTL,
>  			.shift   = 0,
> @@ -197,11 +207,15 @@ static const struct reg_sequence axg_gp0_init_regs[] = {
>  	{ .reg = HHI_GP0_PLL_CNTL3,	.def = 0x0a59a288 },
>  	{ .reg = HHI_GP0_PLL_CNTL4,	.def = 0xc000004d },
>  	{ .reg = HHI_GP0_PLL_CNTL5,	.def = 0x00078000 },
> -	{ .reg = HHI_GP0_PLL_CNTL,	.def = 0x40010250 },
>  };
>  
>  static struct clk_regmap axg_gp0_pll = {
>  	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = HHI_GP0_PLL_CNTL,
> +			.shift   = 30,
> +			.width   = 1,
> +		},
>  		.m = {
>  			.reg_off = HHI_GP0_PLL_CNTL,
>  			.shift   = 0,
> @@ -250,11 +264,15 @@ static const struct reg_sequence axg_hifi_init_regs[] = {
>  	{ .reg = HHI_HIFI_PLL_CNTL3,	.def = 0x0a6a3a88 },
>  	{ .reg = HHI_HIFI_PLL_CNTL4,	.def = 0xc000004d },
>  	{ .reg = HHI_HIFI_PLL_CNTL5,	.def = 0x00058000 },
> -	{ .reg = HHI_HIFI_PLL_CNTL,	.def = 0x40010250 },
>  };
>  
>  static struct clk_regmap axg_hifi_pll = {
>  	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = HHI_HIFI_PLL_CNTL,
> +			.shift   = 30,
> +			.width   = 1,
> +		},
>  		.m = {
>  			.reg_off = HHI_HIFI_PLL_CNTL,
>  			.shift   = 0,
> @@ -637,7 +655,6 @@ static const struct pll_rate_table axg_pcie_pll_rate_table[] = {
>  };
>  
>  static const struct reg_sequence axg_pcie_init_regs[] = {
> -	{ .reg = HHI_PCIE_PLL_CNTL,	.def = 0x400106c8 },
>  	{ .reg = HHI_PCIE_PLL_CNTL1,	.def = 0x0084a2aa },
>  	{ .reg = HHI_PCIE_PLL_CNTL2,	.def = 0xb75020be },
>  	{ .reg = HHI_PCIE_PLL_CNTL3,	.def = 0x0a47488e },
> @@ -648,6 +665,11 @@ static const struct reg_sequence axg_pcie_init_regs[] = {
>  
>  static struct clk_regmap axg_pcie_pll = {
>  	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = HHI_PCIE_PLL_CNTL,
> +			.shift   = 30,
> +			.width   = 1,
> +		},
>  		.m = {
>  			.reg_off = HHI_PCIE_PLL_CNTL,
>  			.shift   = 0,
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index 3e04617ac47f..8aaefe67025f 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -185,12 +185,45 @@ static void meson_clk_pll_init(struct clk_hw *hw)
>  	}
>  }
>  
> +static int meson_clk_pll_enable(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
> +
> +	/* Make sure the pll is in reset */
> +	meson_parm_write(clk->map, &pll->rst, 1);
> +
> +	/* Enable the pll */
> +	meson_parm_write(clk->map, &pll->en, 1);
> +
> +	/* Take the pll out reset */
> +	meson_parm_write(clk->map, &pll->rst, 0);
> +
> +	if (meson_clk_pll_wait_lock(hw))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static void meson_clk_pll_disable(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
> +
> +	/* Put the pll is in reset */
> +	meson_parm_write(clk->map, &pll->rst, 1);
> +
> +	/* Disable the pll */
> +	meson_parm_write(clk->map, &pll->en, 0);
> +}
> +
>  static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  				  unsigned long parent_rate)
>  {
>  	struct clk_regmap *clk = to_clk_regmap(hw);
>  	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
>  	const struct pll_rate_table *pllt;
> +	unsigned int enabled;
>  	unsigned long old_rate;
>  	u16 frac = 0;
>  
> @@ -203,8 +236,9 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  	if (!pllt)
>  		return -EINVAL;
>  
> -	/* Put the pll in reset to write the params */
> -	meson_parm_write(clk->map, &pll->rst, 1);
> +	enabled = meson_parm_read(clk->map, &pll->en);
> +	if (enabled)
> +		meson_clk_pll_disable(hw);
>  
>  	meson_parm_write(clk->map, &pll->n, pllt->n);
>  	meson_parm_write(clk->map, &pll->m, pllt->m);
> @@ -221,10 +255,11 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  		meson_parm_write(clk->map, &pll->frac, frac);
>  	}
>  
> -	/* make sure the reset is cleared at this point */
> -	meson_parm_write(clk->map, &pll->rst, 0);
> +	/* If the pll is stopped, bail out now */
> +	if (!enabled)
> +		return 0;
>  
> -	if (meson_clk_pll_wait_lock(hw)) {
> +	if (meson_clk_pll_enable(hw)) {
>  		pr_warn("%s: pll did not lock, trying to restore old rate %lu\n",
>  			__func__, old_rate);
>  		/*
> @@ -244,6 +279,8 @@ const struct clk_ops meson_clk_pll_ops = {
>  	.recalc_rate	= meson_clk_pll_recalc_rate,
>  	.round_rate	= meson_clk_pll_round_rate,
>  	.set_rate	= meson_clk_pll_set_rate,
> +	.enable		= meson_clk_pll_enable,
> +	.disable	= meson_clk_pll_disable
>  };
>  
>  const struct clk_ops meson_clk_pll_ro_ops = {
> diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
> index 24cec16b6038..c2ee37a78ceb 100644
> --- a/drivers/clk/meson/clkc.h
> +++ b/drivers/clk/meson/clkc.h
> @@ -63,6 +63,7 @@ struct pll_rate_table {
>  #define CLK_MESON_PLL_ROUND_CLOSEST	BIT(0)
>  
>  struct meson_clk_pll_data {
> +	struct parm en;
>  	struct parm m;
>  	struct parm n;
>  	struct parm frac;
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index 86d3ae58e84c..5ed34566917c 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -177,6 +177,11 @@ static const struct pll_rate_table gxl_gp0_pll_rate_table[] = {
>  
>  static struct clk_regmap gxbb_fixed_pll = {
>  	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = HHI_MPLL_CNTL,
> +			.shift   = 30,
> +			.width   = 1,
> +		},
>  		.m = {
>  			.reg_off = HHI_MPLL_CNTL,
>  			.shift   = 0,
> @@ -230,6 +235,11 @@ static struct clk_fixed_factor gxbb_hdmi_pll_pre_mult = {
>  
>  static struct clk_regmap gxbb_hdmi_pll = {
>  	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = HHI_HDMI_PLL_CNTL,
> +			.shift   = 30,
> +			.width   = 1,
> +		},
>  		.m = {
>  			.reg_off = HHI_HDMI_PLL_CNTL,
>  			.shift   = 0,
> @@ -282,6 +292,11 @@ static struct clk_regmap gxbb_hdmi_pll = {
>  
>  static struct clk_regmap gxl_hdmi_pll = {
>  	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = HHI_HDMI_PLL_CNTL,
> +			.shift   = 30,
> +			.width   = 1,
> +		},
>  		.m = {
>  			.reg_off = HHI_HDMI_PLL_CNTL,
>  			.shift   = 0,
> @@ -340,6 +355,11 @@ static struct clk_regmap gxl_hdmi_pll = {
>  
>  static struct clk_regmap gxbb_sys_pll = {
>  	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = HHI_SYS_PLL_CNTL,
> +			.shift   = 30,
> +			.width   = 1,
> +		},
>  		.m = {
>  			.reg_off = HHI_SYS_PLL_CNTL,
>  			.shift   = 0,
> @@ -379,11 +399,15 @@ static const struct reg_sequence gxbb_gp0_init_regs[] = {
>  	{ .reg = HHI_GP0_PLL_CNTL2,	.def = 0x69c80000 },
>  	{ .reg = HHI_GP0_PLL_CNTL3,	.def = 0x0a5590c4 },
>  	{ .reg = HHI_GP0_PLL_CNTL4,	.def = 0x0000500d },
> -	{ .reg = HHI_GP0_PLL_CNTL,	.def = 0x4a000228 },
>  };
>  
>  static struct clk_regmap gxbb_gp0_pll = {
>  	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = HHI_GP0_PLL_CNTL,
> +			.shift   = 30,
> +			.width   = 1,
> +		},
>  		.m = {
>  			.reg_off = HHI_GP0_PLL_CNTL,
>  			.shift   = 0,
> @@ -428,11 +452,15 @@ static const struct reg_sequence gxl_gp0_init_regs[] = {
>  	{ .reg = HHI_GP0_PLL_CNTL3,	.def = 0x0a59a288 },
>  	{ .reg = HHI_GP0_PLL_CNTL4,	.def = 0xc000004d },
>  	{ .reg = HHI_GP0_PLL_CNTL5,	.def = 0x00078000 },
> -	{ .reg = HHI_GP0_PLL_CNTL,	.def = 0x40010250 },
>  };
>  
>  static struct clk_regmap gxl_gp0_pll = {
>  	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = HHI_GP0_PLL_CNTL,
> +			.shift   = 30,
> +			.width   = 1,
> +		},
>  		.m = {
>  			.reg_off = HHI_GP0_PLL_CNTL,
>  			.shift   = 0,
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index 7447d96a265f..fd4c414893f5 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -96,6 +96,11 @@ static struct clk_fixed_rate meson8b_xtal = {
>  
>  static struct clk_regmap meson8b_fixed_pll = {
>  	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = HHI_MPLL_CNTL,
> +			.shift   = 30,
> +			.width   = 1,
> +		},
>  		.m = {
>  			.reg_off = HHI_MPLL_CNTL,
>  			.shift   = 0,
> @@ -138,6 +143,11 @@ static struct clk_regmap meson8b_fixed_pll = {
>  
>  static struct clk_regmap meson8b_vid_pll = {
>  	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = HHI_VID_PLL_CNTL,
> +			.shift   = 30,
> +			.width   = 1,
> +		},
>  		.m = {
>  			.reg_off = HHI_VID_PLL_CNTL,
>  			.shift   = 0,
> @@ -175,6 +185,11 @@ static struct clk_regmap meson8b_vid_pll = {
>  
>  static struct clk_regmap meson8b_sys_pll = {
>  	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = HHI_SYS_PLL_CNTL,
> +			.shift   = 30,
> +			.width   = 1,
> +		},
>  		.m = {
>  			.reg_off = HHI_SYS_PLL_CNTL,
>  			.shift   = 0,
> 

This makes the pll reset path much clearer !

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
