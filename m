Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02B7C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4590120671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MGatywo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4590120671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbeGSJY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:24:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38701 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730443AbeGSJY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:24:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so5464662wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HWxOxCKDdqt9JgJRo5R8hOSuPgQ5UgCZF+NVmKxjthA=;
        b=MGatywo4AXknWnIpJjmjyqbctUkaR1XlItneglSQsGwLZ81Qe4mOkt+XAdrYFH/OYH
         SP5LFhZr723kPqAELWC1NREu3o3bBrZcV1xPt7djRqAoFznYxqe6cah1zZ0jqJcGsd4M
         sxJU5BlQvGRuEszcWGYBSgfiDvZyWy2iB1jc1jYZ7zZTc+n9D2QGRmnOVrZaFONUhXFX
         XOgHT5RgTG270jO6ImMvML2VhYgn381df1YyEMDo0o13+nuM5fmj4gvpyRPDIPLwUMhl
         wRh1UQvFNF7L1bNlCtCqMAdZ0E6DVegUB4YwogNfqUiuROVD6XKQB0eTZZ7Ka/nmNems
         pFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HWxOxCKDdqt9JgJRo5R8hOSuPgQ5UgCZF+NVmKxjthA=;
        b=fwcv2Rx01jGYN7t/y1GjEq/jN2M9pHt9SjFt0AVUGb1RxSo5UBvriT4hZfmT3FF3dX
         nzfTM5R8/sf7uNrzkkrmohxHMu2OAlUD+s9LI8qtqSzX6sacSvUS4DbIGYBtRHxjjksT
         ApuxhAvDn4bmqZespd7HFNrgQq5FIQzSITpJQwMB5K4BBITJreNmrEvqqN5Iw2lleqME
         +2mGBQO3PhhLUfFq7WHMzm3Ulvft2L+KT+ZDmSeA+2OVjmBAgHIXRRxoT1yXrCiTWtmO
         k6+M3wxAvPvllYaBikvTfgy95F59BvsbYVrYznGjLzFJ5F/GYdaqMJzOMM3aBonofe4u
         U97Q==
X-Gm-Message-State: AOUpUlHCN6YwfkYmeIzoPcAqYqGcX00VveO28041xI5AIb9bF9U5Ao5p
        mQbFowGfALrkPopq0xUVMCuGXg==
X-Google-Smtp-Source: AAOMgpccmWTKU8u8pknzuFnustUGpxNNOcBvRyebPYK6/Mp6DRbMHTyJm5DwDRxHPk/HgiKdHtfGDQ==
X-Received: by 2002:a1c:20cb:: with SMTP id g194-v6mr3770677wmg.102.1531989770022;
        Thu, 19 Jul 2018 01:42:50 -0700 (PDT)
Received: from [192.168.1.24] (LFbn-MAR-1-570-38.w90-118.abo.wanadoo.fr. [90.118.15.38])
        by smtp.gmail.com with ESMTPSA id q1-v6sm8508513wrw.42.2018.07.19.01.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 01:42:49 -0700 (PDT)
Subject: Re: [PATCH 2/3] clk: meson: clk-pll: remove od parameters
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20180717095617.12240-1-jbrunet@baylibre.com>
 <20180717095617.12240-3-jbrunet@baylibre.com>
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
Message-ID: <fa95a61b-3fde-1401-e2bc-f3465e5f4417@baylibre.com>
Date:   Thu, 19 Jul 2018 10:42:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180717095617.12240-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2018 11:56, Jerome Brunet wrote:
> Remove od parameters from pll clocks and add post dividers clocks
> instead. Some clock, especially the one which feature several ods,
> may provide output between those ods. Also, some drivers, such
> as the hdmi driver, may require a more detailed control of the
> clock dividers, compared to what CCF would perform automatically.
> 
> One added benefit of removing ods is that it also greatly reduce the
> size of the rate parameter tables.
> 
> In the future, we could possibly take the predivider 'n' out of this
> driver as well. To do so, we will need to understand the constraints
> for the PLL to lock and whether or not it depends on the input clock
> rate.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/axg.c     | 279 ++++++++++++++------------
>  drivers/clk/meson/axg.h     |   8 +-
>  drivers/clk/meson/clk-pll.c |  40 ++--
>  drivers/clk/meson/clkc.h    |   9 +-
>  drivers/clk/meson/gxbb.c    | 474 +++++++++++++++++++++-----------------------
>  drivers/clk/meson/gxbb.h    |  10 +-
>  drivers/clk/meson/meson8b.c | 148 +++++++-------
>  drivers/clk/meson/meson8b.h |   5 +-
>  8 files changed, 480 insertions(+), 493 deletions(-)
> 
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index 6d8976554656..572358062459 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -22,7 +22,7 @@
>  
>  static DEFINE_SPINLOCK(meson_clk_lock);
>  
> -static struct clk_regmap axg_fixed_pll = {
> +static struct clk_regmap axg_fixed_pll_dco = {
>  	.data = &(struct meson_clk_pll_data){
>  		.en = {
>  			.reg_off = HHI_MPLL_CNTL,
> @@ -39,11 +39,6 @@ static struct clk_regmap axg_fixed_pll = {
>  			.shift   = 9,
>  			.width   = 5,
>  		},
> -		.od = {
> -			.reg_off = HHI_MPLL_CNTL,
> -			.shift   = 16,
> -			.width   = 2,
> -		},
>  		.frac = {
>  			.reg_off = HHI_MPLL_CNTL2,
>  			.shift   = 0,
> @@ -61,14 +56,29 @@ static struct clk_regmap axg_fixed_pll = {
>  		},
>  	},
>  	.hw.init = &(struct clk_init_data){
> -		.name = "fixed_pll",
> +		.name = "fixed_pll_dco",
>  		.ops = &meson_clk_pll_ro_ops,
>  		.parent_names = (const char *[]){ "xtal" },
>  		.num_parents = 1,
>  	},
>  };
>  
> -static struct clk_regmap axg_sys_pll = {
> +static struct clk_regmap axg_fixed_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_MPLL_CNTL,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fixed_pll",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_names = (const char *[]){ "fixed_pll_dco" },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap axg_sys_pll_dco = {
>  	.data = &(struct meson_clk_pll_data){
>  		.en = {
>  			.reg_off = HHI_SYS_PLL_CNTL,
> @@ -85,11 +95,6 @@ static struct clk_regmap axg_sys_pll = {
>  			.shift   = 9,
>  			.width   = 5,
>  		},
> -		.od = {
> -			.reg_off = HHI_SYS_PLL_CNTL,
> -			.shift   = 16,
> -			.width   = 2,
> -		},
>  		.l = {
>  			.reg_off = HHI_SYS_PLL_CNTL,
>  			.shift   = 31,
> @@ -102,7 +107,7 @@ static struct clk_regmap axg_sys_pll = {
>  		},
>  	},
>  	.hw.init = &(struct clk_init_data){
> -		.name = "sys_pll",
> +		.name = "sys_pll_dco",
>  		.ops = &meson_clk_pll_ro_ops,
>  		.parent_names = (const char *[]){ "xtal" },
>  		.num_parents = 1,
> @@ -110,94 +115,51 @@ static struct clk_regmap axg_sys_pll = {
>  	},
>  };
>  
> +static struct clk_regmap axg_sys_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_SYS_PLL_CNTL,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "sys_pll",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_names = (const char *[]){ "sys_pll_dco" },
> +		.num_parents = 1,
> +	},
> +};
> +
>  static const struct pll_rate_table axg_gp0_pll_rate_table[] = {
> -	PLL_RATE(240000000, 40, 1, 2),
> -	PLL_RATE(246000000, 41, 1, 2),
> -	PLL_RATE(252000000, 42, 1, 2),
> -	PLL_RATE(258000000, 43, 1, 2),
> -	PLL_RATE(264000000, 44, 1, 2),
> -	PLL_RATE(270000000, 45, 1, 2),
> -	PLL_RATE(276000000, 46, 1, 2),
> -	PLL_RATE(282000000, 47, 1, 2),
> -	PLL_RATE(288000000, 48, 1, 2),
> -	PLL_RATE(294000000, 49, 1, 2),
> -	PLL_RATE(300000000, 50, 1, 2),
> -	PLL_RATE(306000000, 51, 1, 2),
> -	PLL_RATE(312000000, 52, 1, 2),
> -	PLL_RATE(318000000, 53, 1, 2),
> -	PLL_RATE(324000000, 54, 1, 2),
> -	PLL_RATE(330000000, 55, 1, 2),
> -	PLL_RATE(336000000, 56, 1, 2),
> -	PLL_RATE(342000000, 57, 1, 2),
> -	PLL_RATE(348000000, 58, 1, 2),
> -	PLL_RATE(354000000, 59, 1, 2),
> -	PLL_RATE(360000000, 60, 1, 2),
> -	PLL_RATE(366000000, 61, 1, 2),
> -	PLL_RATE(372000000, 62, 1, 2),
> -	PLL_RATE(378000000, 63, 1, 2),
> -	PLL_RATE(384000000, 64, 1, 2),
> -	PLL_RATE(390000000, 65, 1, 3),
> -	PLL_RATE(396000000, 66, 1, 3),
> -	PLL_RATE(402000000, 67, 1, 3),
> -	PLL_RATE(408000000, 68, 1, 3),
> -	PLL_RATE(480000000, 40, 1, 1),
> -	PLL_RATE(492000000, 41, 1, 1),
> -	PLL_RATE(504000000, 42, 1, 1),
> -	PLL_RATE(516000000, 43, 1, 1),
> -	PLL_RATE(528000000, 44, 1, 1),
> -	PLL_RATE(540000000, 45, 1, 1),
> -	PLL_RATE(552000000, 46, 1, 1),
> -	PLL_RATE(564000000, 47, 1, 1),
> -	PLL_RATE(576000000, 48, 1, 1),
> -	PLL_RATE(588000000, 49, 1, 1),
> -	PLL_RATE(600000000, 50, 1, 1),
> -	PLL_RATE(612000000, 51, 1, 1),
> -	PLL_RATE(624000000, 52, 1, 1),
> -	PLL_RATE(636000000, 53, 1, 1),
> -	PLL_RATE(648000000, 54, 1, 1),
> -	PLL_RATE(660000000, 55, 1, 1),
> -	PLL_RATE(672000000, 56, 1, 1),
> -	PLL_RATE(684000000, 57, 1, 1),
> -	PLL_RATE(696000000, 58, 1, 1),
> -	PLL_RATE(708000000, 59, 1, 1),
> -	PLL_RATE(720000000, 60, 1, 1),
> -	PLL_RATE(732000000, 61, 1, 1),
> -	PLL_RATE(744000000, 62, 1, 1),
> -	PLL_RATE(756000000, 63, 1, 1),
> -	PLL_RATE(768000000, 64, 1, 1),
> -	PLL_RATE(780000000, 65, 1, 1),
> -	PLL_RATE(792000000, 66, 1, 1),
> -	PLL_RATE(804000000, 67, 1, 1),
> -	PLL_RATE(816000000, 68, 1, 1),
> -	PLL_RATE(960000000, 40, 1, 0),
> -	PLL_RATE(984000000, 41, 1, 0),
> -	PLL_RATE(1008000000, 42, 1, 0),
> -	PLL_RATE(1032000000, 43, 1, 0),
> -	PLL_RATE(1056000000, 44, 1, 0),
> -	PLL_RATE(1080000000, 45, 1, 0),
> -	PLL_RATE(1104000000, 46, 1, 0),
> -	PLL_RATE(1128000000, 47, 1, 0),
> -	PLL_RATE(1152000000, 48, 1, 0),
> -	PLL_RATE(1176000000, 49, 1, 0),
> -	PLL_RATE(1200000000, 50, 1, 0),
> -	PLL_RATE(1224000000, 51, 1, 0),
> -	PLL_RATE(1248000000, 52, 1, 0),
> -	PLL_RATE(1272000000, 53, 1, 0),
> -	PLL_RATE(1296000000, 54, 1, 0),
> -	PLL_RATE(1320000000, 55, 1, 0),
> -	PLL_RATE(1344000000, 56, 1, 0),
> -	PLL_RATE(1368000000, 57, 1, 0),
> -	PLL_RATE(1392000000, 58, 1, 0),
> -	PLL_RATE(1416000000, 59, 1, 0),
> -	PLL_RATE(1440000000, 60, 1, 0),
> -	PLL_RATE(1464000000, 61, 1, 0),
> -	PLL_RATE(1488000000, 62, 1, 0),
> -	PLL_RATE(1512000000, 63, 1, 0),
> -	PLL_RATE(1536000000, 64, 1, 0),
> -	PLL_RATE(1560000000, 65, 1, 0),
> -	PLL_RATE(1584000000, 66, 1, 0),
> -	PLL_RATE(1608000000, 67, 1, 0),
> -	PLL_RATE(1632000000, 68, 1, 0),
> +	PLL_RATE(960000000, 40, 1),
> +	PLL_RATE(984000000, 41, 1),
> +	PLL_RATE(1008000000, 42, 1),
> +	PLL_RATE(1032000000, 43, 1),
> +	PLL_RATE(1056000000, 44, 1),
> +	PLL_RATE(1080000000, 45, 1),
> +	PLL_RATE(1104000000, 46, 1),
> +	PLL_RATE(1128000000, 47, 1),
> +	PLL_RATE(1152000000, 48, 1),
> +	PLL_RATE(1176000000, 49, 1),
> +	PLL_RATE(1200000000, 50, 1),
> +	PLL_RATE(1224000000, 51, 1),
> +	PLL_RATE(1248000000, 52, 1),
> +	PLL_RATE(1272000000, 53, 1),
> +	PLL_RATE(1296000000, 54, 1),
> +	PLL_RATE(1320000000, 55, 1),
> +	PLL_RATE(1344000000, 56, 1),
> +	PLL_RATE(1368000000, 57, 1),
> +	PLL_RATE(1392000000, 58, 1),
> +	PLL_RATE(1416000000, 59, 1),
> +	PLL_RATE(1440000000, 60, 1),
> +	PLL_RATE(1464000000, 61, 1),
> +	PLL_RATE(1488000000, 62, 1),
> +	PLL_RATE(1512000000, 63, 1),
> +	PLL_RATE(1536000000, 64, 1),
> +	PLL_RATE(1560000000, 65, 1),
> +	PLL_RATE(1584000000, 66, 1),
> +	PLL_RATE(1608000000, 67, 1),
> +	PLL_RATE(1632000000, 68, 1),
>  	{ /* sentinel */ },
>  };
>  
> @@ -209,7 +171,7 @@ static const struct reg_sequence axg_gp0_init_regs[] = {
>  	{ .reg = HHI_GP0_PLL_CNTL5,	.def = 0x00078000 },
>  };
>  
> -static struct clk_regmap axg_gp0_pll = {
> +static struct clk_regmap axg_gp0_pll_dco = {
>  	.data = &(struct meson_clk_pll_data){
>  		.en = {
>  			.reg_off = HHI_GP0_PLL_CNTL,
> @@ -226,11 +188,6 @@ static struct clk_regmap axg_gp0_pll = {
>  			.shift   = 9,
>  			.width   = 5,
>  		},
> -		.od = {
> -			.reg_off = HHI_GP0_PLL_CNTL,
> -			.shift   = 16,
> -			.width   = 2,
> -		},
>  		.frac = {
>  			.reg_off = HHI_GP0_PLL_CNTL1,
>  			.shift   = 0,
> @@ -251,13 +208,29 @@ static struct clk_regmap axg_gp0_pll = {
>  		.init_count = ARRAY_SIZE(axg_gp0_init_regs),
>  	},
>  	.hw.init = &(struct clk_init_data){
> -		.name = "gp0_pll",
> +		.name = "gp0_pll_dco",
>  		.ops = &meson_clk_pll_ops,
>  		.parent_names = (const char *[]){ "xtal" },
>  		.num_parents = 1,
>  	},
>  };
>  
> +static struct clk_regmap axg_gp0_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_GP0_PLL_CNTL,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "gp0_pll",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_names = (const char *[]){ "gp0_pll_dco" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
>  static const struct reg_sequence axg_hifi_init_regs[] = {
>  	{ .reg = HHI_HIFI_PLL_CNTL1,	.def = 0xc084b000 },
>  	{ .reg = HHI_HIFI_PLL_CNTL2,	.def = 0xb75020be },
> @@ -266,7 +239,7 @@ static const struct reg_sequence axg_hifi_init_regs[] = {
>  	{ .reg = HHI_HIFI_PLL_CNTL5,	.def = 0x00058000 },
>  };
>  
> -static struct clk_regmap axg_hifi_pll = {
> +static struct clk_regmap axg_hifi_pll_dco = {
>  	.data = &(struct meson_clk_pll_data){
>  		.en = {
>  			.reg_off = HHI_HIFI_PLL_CNTL,
> @@ -283,11 +256,6 @@ static struct clk_regmap axg_hifi_pll = {
>  			.shift   = 9,
>  			.width   = 5,
>  		},
> -		.od = {
> -			.reg_off = HHI_HIFI_PLL_CNTL,
> -			.shift   = 16,
> -			.width   = 2,
> -		},
>  		.frac = {
>  			.reg_off = HHI_HIFI_PLL_CNTL5,
>  			.shift   = 0,
> @@ -309,13 +277,29 @@ static struct clk_regmap axg_hifi_pll = {
>  		.flags = CLK_MESON_PLL_ROUND_CLOSEST,
>  	},
>  	.hw.init = &(struct clk_init_data){
> -		.name = "hifi_pll",
> +		.name = "hifi_pll_dco",
>  		.ops = &meson_clk_pll_ops,
>  		.parent_names = (const char *[]){ "xtal" },
>  		.num_parents = 1,
>  	},
>  };
>  
> +static struct clk_regmap axg_hifi_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_HIFI_PLL_CNTL,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hifi_pll",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_names = (const char *[]){ "hifi_pll_dco" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
>  static struct clk_fixed_factor axg_fclk_div2_div = {
>  	.mult = 1,
>  	.div = 2,
> @@ -645,11 +629,9 @@ static struct clk_regmap axg_mpll3 = {
>  
>  static const struct pll_rate_table axg_pcie_pll_rate_table[] = {
>  	{
> -		.rate	= 100000000,
> +		.rate	= 1600000000,
>  		.m	= 200,
>  		.n	= 3,
> -		.od	= 1,
> -		.od2	= 3,
>  	},
>  	{ /* sentinel */ },
>  };
> @@ -661,9 +643,10 @@ static const struct reg_sequence axg_pcie_init_regs[] = {
>  	{ .reg = HHI_PCIE_PLL_CNTL4,	.def = 0xc000004d },
>  	{ .reg = HHI_PCIE_PLL_CNTL5,	.def = 0x00078000 },
>  	{ .reg = HHI_PCIE_PLL_CNTL6,	.def = 0x002323c6 },
> +	{ .reg = HHI_PCIE_PLL_CNTL,     .def = 0x400106c8 },
>  };
>  
> -static struct clk_regmap axg_pcie_pll = {
> +static struct clk_regmap axg_pcie_pll_dco = {
>  	.data = &(struct meson_clk_pll_data){
>  		.en = {
>  			.reg_off = HHI_PCIE_PLL_CNTL,
> @@ -680,16 +663,6 @@ static struct clk_regmap axg_pcie_pll = {
>  			.shift   = 9,
>  			.width   = 5,
>  		},
> -		.od = {
> -			.reg_off = HHI_PCIE_PLL_CNTL,
> -			.shift   = 16,
> -			.width   = 2,
> -		},
> -		.od2 = {
> -			.reg_off = HHI_PCIE_PLL_CNTL6,
> -			.shift   = 6,
> -			.width   = 2,
> -		},
>  		.frac = {
>  			.reg_off = HHI_PCIE_PLL_CNTL1,
>  			.shift   = 0,
> @@ -710,13 +683,45 @@ static struct clk_regmap axg_pcie_pll = {
>  		.init_count = ARRAY_SIZE(axg_pcie_init_regs),
>  	},
>  	.hw.init = &(struct clk_init_data){
> -		.name = "pcie_pll",
> +		.name = "pcie_pll_dco",
>  		.ops = &meson_clk_pll_ops,
>  		.parent_names = (const char *[]){ "xtal" },
>  		.num_parents = 1,
>  	},
>  };
>  
> +static struct clk_regmap axg_pcie_pll_od = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_PCIE_PLL_CNTL,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pcie_pll_od",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_names = (const char *[]){ "pcie_pll_dco" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap axg_pcie_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_PCIE_PLL_CNTL6,
> +		.shift = 6,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pcie_pll",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_names = (const char *[]){ "pcie_pll_od" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
>  static struct clk_regmap axg_pcie_mux = {
>  	.data = &(struct clk_regmap_mux_data){
>  		.offset = HHI_PCIE_PLL_CNTL6,
> @@ -1129,6 +1134,12 @@ static struct clk_hw_onecell_data axg_hw_onecell_data = {
>  		[CLKID_GEN_CLK_SEL]		= &axg_gen_clk_sel.hw,
>  		[CLKID_GEN_CLK_DIV]		= &axg_gen_clk_div.hw,
>  		[CLKID_GEN_CLK]			= &axg_gen_clk.hw,
> +		[CLKID_SYS_PLL_DCO]		= &axg_sys_pll_dco.hw,
> +		[CLKID_FIXED_PLL_DCO]		= &axg_fixed_pll_dco.hw,
> +		[CLKID_GP0_PLL_DCO]		= &axg_gp0_pll_dco.hw,
> +		[CLKID_HIFI_PLL_DCO]		= &axg_hifi_pll_dco.hw,
> +		[CLKID_PCIE_PLL_DCO]		= &axg_pcie_pll_dco.hw,
> +		[CLKID_PCIE_PLL_OD]		= &axg_pcie_pll_od.hw,
>  		[NR_CLKS]			= NULL,
>  	},
>  	.num = NR_CLKS,
> @@ -1207,6 +1218,8 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
>  	&axg_fclk_div4,
>  	&axg_fclk_div5,
>  	&axg_fclk_div7,
> +	&axg_pcie_pll_dco,
> +	&axg_pcie_pll_od,
>  	&axg_pcie_pll,
>  	&axg_pcie_mux,
>  	&axg_pcie_ref,
> @@ -1216,6 +1229,12 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
>  	&axg_gen_clk_sel,
>  	&axg_gen_clk_div,
>  	&axg_gen_clk,
> +	&axg_fixed_pll_dco,
> +	&axg_sys_pll_dco,
> +	&axg_gp0_pll_dco,
> +	&axg_hifi_pll_dco,
> +	&axg_pcie_pll_dco,
> +	&axg_pcie_pll_od,
>  };
>  
>  static const struct of_device_id clkc_match_table[] = {
> diff --git a/drivers/clk/meson/axg.h b/drivers/clk/meson/axg.h
> index 1d04144a1b2c..0431dabac629 100644
> --- a/drivers/clk/meson/axg.h
> +++ b/drivers/clk/meson/axg.h
> @@ -133,8 +133,14 @@
>  #define CLKID_PCIE_REF				78
>  #define CLKID_GEN_CLK_SEL			82
>  #define CLKID_GEN_CLK_DIV			83
> +#define CLKID_SYS_PLL_DCO			85
> +#define CLKID_FIXED_PLL_DCO			86
> +#define CLKID_GP0_PLL_DCO			87
> +#define CLKID_HIFI_PLL_DCO			88
> +#define CLKID_PCIE_PLL_DCO			89
> +#define CLKID_PCIE_PLL_OD			90
>  
> -#define NR_CLKS					85
> +#define NR_CLKS					91
>  
>  /* include the CLKIDs that have been made part of the DT binding */
>  #include <dt-bindings/clock/axg-clkc.h>
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index 8aaefe67025f..348a866f09eb 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -11,15 +11,19 @@
>   * In the most basic form, a Meson PLL is composed as follows:
>   *
>   *                     PLL
> - *      +------------------------------+
> - *      |                              |
> - * in -----[ /N ]---[ *M ]---[ >>OD ]----->> out
> - *      |         ^        ^           |
> - *      +------------------------------+
> - *                |        |
> - *               FREF     VCO
> + *        +--------------------------------+
> + *        |                                |
> + *        |             +--+               |
> + *  in >>-----[ /N ]--->|  |      +-----+  |
> + *        |             |  |------| DCO |---->> out
> + *        |  +--------->|  |      +--v--+  |
> + *        |  |          +--+         |     |
> + *        |  |                       |     |
> + *        |  +--[ *(M + (F/Fmax) ]<--+     |
> + *        |                                |
> + *        +--------------------------------+
>   *
> - * out = in * (m + frac / frac_max) / (n << sum(ods))
> + * out = in * (m + frac / frac_max) / n
>   */
>  
>  #include <linux/clk-provider.h>
> @@ -46,7 +50,6 @@ static unsigned long __pll_params_to_rate(unsigned long parent_rate,
>  					  struct meson_clk_pll_data *pll)
>  {
>  	u64 rate = (u64)parent_rate * pllt->m;
> -	unsigned int od = pllt->od + pllt->od2 + pllt->od3;
>  
>  	if (frac && MESON_PARM_APPLICABLE(&pll->frac)) {
>  		u64 frac_rate = (u64)parent_rate * frac;
> @@ -55,7 +58,7 @@ static unsigned long __pll_params_to_rate(unsigned long parent_rate,
>  					 (1 << pll->frac.width));
>  	}
>  
> -	return DIV_ROUND_UP_ULL(rate, pllt->n << od);
> +	return DIV_ROUND_UP_ULL(rate, pllt->n);
>  }
>  
>  static unsigned long meson_clk_pll_recalc_rate(struct clk_hw *hw,
> @@ -68,15 +71,6 @@ static unsigned long meson_clk_pll_recalc_rate(struct clk_hw *hw,
>  
>  	pllt.n = meson_parm_read(clk->map, &pll->n);
>  	pllt.m = meson_parm_read(clk->map, &pll->m);
> -	pllt.od = meson_parm_read(clk->map, &pll->od);
> -
> -	pllt.od2 = MESON_PARM_APPLICABLE(&pll->od2) ?
> -		meson_parm_read(clk->map, &pll->od2) :
> -		0;
> -
> -	pllt.od3 = MESON_PARM_APPLICABLE(&pll->od3) ?
> -		meson_parm_read(clk->map, &pll->od3) :
> -		0;
>  
>  	frac = MESON_PARM_APPLICABLE(&pll->frac) ?
>  		meson_parm_read(clk->map, &pll->frac) :
> @@ -93,8 +87,6 @@ static u16 __pll_params_with_frac(unsigned long rate,
>  	u16 frac_max = (1 << pll->frac.width);
>  	u64 val = (u64)rate * pllt->n;
>  
> -	val <<= pllt->od + pllt->od2 + pllt->od3;
> -
>  	if (pll->flags & CLK_MESON_PLL_ROUND_CLOSEST)
>  		val = DIV_ROUND_CLOSEST_ULL(val * frac_max, parent_rate);
>  	else
> @@ -242,13 +234,7 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  
>  	meson_parm_write(clk->map, &pll->n, pllt->n);
>  	meson_parm_write(clk->map, &pll->m, pllt->m);
> -	meson_parm_write(clk->map, &pll->od, pllt->od);
> -
> -	if (MESON_PARM_APPLICABLE(&pll->od2))
> -		meson_parm_write(clk->map, &pll->od2, pllt->od2);
>  
> -	if (MESON_PARM_APPLICABLE(&pll->od3))
> -		meson_parm_write(clk->map, &pll->od3, pllt->od3);
>  
>  	if (MESON_PARM_APPLICABLE(&pll->frac)) {
>  		frac = __pll_params_with_frac(rate, parent_rate, pllt, pll);
> diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
> index c2ee37a78ceb..a2245e857f70 100644
> --- a/drivers/clk/meson/clkc.h
> +++ b/drivers/clk/meson/clkc.h
> @@ -47,17 +47,13 @@ struct pll_rate_table {
>  	unsigned long	rate;
>  	u16		m;
>  	u16		n;
> -	u16		od;
> -	u16		od2;
> -	u16		od3;
>  };
>  
> -#define PLL_RATE(_r, _m, _n, _od)					\
> +#define PLL_RATE(_r, _m, _n)						\
>  	{								\
>  		.rate		= (_r),					\
>  		.m		= (_m),					\
>  		.n		= (_n),					\
> -		.od		= (_od),				\
>  	}
>  
>  #define CLK_MESON_PLL_ROUND_CLOSEST	BIT(0)
> @@ -67,9 +63,6 @@ struct meson_clk_pll_data {
>  	struct parm m;
>  	struct parm n;
>  	struct parm frac;
> -	struct parm od;
> -	struct parm od2;
> -	struct parm od3;
>  	struct parm l;
>  	struct parm rst;
>  	const struct reg_sequence *init_regs;
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index 5ed34566917c..e2d94498f098 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -19,163 +19,70 @@
>  static DEFINE_SPINLOCK(meson_clk_lock);
>  
>  static const struct pll_rate_table gxbb_gp0_pll_rate_table[] = {
> -	PLL_RATE(96000000, 32, 1, 3),
> -	PLL_RATE(99000000, 33, 1, 3),
> -	PLL_RATE(102000000, 34, 1, 3),
> -	PLL_RATE(105000000, 35, 1, 3),
> -	PLL_RATE(108000000, 36, 1, 3),
> -	PLL_RATE(111000000, 37, 1, 3),
> -	PLL_RATE(114000000, 38, 1, 3),
> -	PLL_RATE(117000000, 39, 1, 3),
> -	PLL_RATE(120000000, 40, 1, 3),
> -	PLL_RATE(123000000, 41, 1, 3),
> -	PLL_RATE(126000000, 42, 1, 3),
> -	PLL_RATE(129000000, 43, 1, 3),
> -	PLL_RATE(132000000, 44, 1, 3),
> -	PLL_RATE(135000000, 45, 1, 3),
> -	PLL_RATE(138000000, 46, 1, 3),
> -	PLL_RATE(141000000, 47, 1, 3),
> -	PLL_RATE(144000000, 48, 1, 3),
> -	PLL_RATE(147000000, 49, 1, 3),
> -	PLL_RATE(150000000, 50, 1, 3),
> -	PLL_RATE(153000000, 51, 1, 3),
> -	PLL_RATE(156000000, 52, 1, 3),
> -	PLL_RATE(159000000, 53, 1, 3),
> -	PLL_RATE(162000000, 54, 1, 3),
> -	PLL_RATE(165000000, 55, 1, 3),
> -	PLL_RATE(168000000, 56, 1, 3),
> -	PLL_RATE(171000000, 57, 1, 3),
> -	PLL_RATE(174000000, 58, 1, 3),
> -	PLL_RATE(177000000, 59, 1, 3),
> -	PLL_RATE(180000000, 60, 1, 3),
> -	PLL_RATE(183000000, 61, 1, 3),
> -	PLL_RATE(186000000, 62, 1, 3),
> -	PLL_RATE(192000000, 32, 1, 2),
> -	PLL_RATE(198000000, 33, 1, 2),
> -	PLL_RATE(204000000, 34, 1, 2),
> -	PLL_RATE(210000000, 35, 1, 2),
> -	PLL_RATE(216000000, 36, 1, 2),
> -	PLL_RATE(222000000, 37, 1, 2),
> -	PLL_RATE(228000000, 38, 1, 2),
> -	PLL_RATE(234000000, 39, 1, 2),
> -	PLL_RATE(240000000, 40, 1, 2),
> -	PLL_RATE(246000000, 41, 1, 2),
> -	PLL_RATE(252000000, 42, 1, 2),
> -	PLL_RATE(258000000, 43, 1, 2),
> -	PLL_RATE(264000000, 44, 1, 2),
> -	PLL_RATE(270000000, 45, 1, 2),
> -	PLL_RATE(276000000, 46, 1, 2),
> -	PLL_RATE(282000000, 47, 1, 2),
> -	PLL_RATE(288000000, 48, 1, 2),
> -	PLL_RATE(294000000, 49, 1, 2),
> -	PLL_RATE(300000000, 50, 1, 2),
> -	PLL_RATE(306000000, 51, 1, 2),
> -	PLL_RATE(312000000, 52, 1, 2),
> -	PLL_RATE(318000000, 53, 1, 2),
> -	PLL_RATE(324000000, 54, 1, 2),
> -	PLL_RATE(330000000, 55, 1, 2),
> -	PLL_RATE(336000000, 56, 1, 2),
> -	PLL_RATE(342000000, 57, 1, 2),
> -	PLL_RATE(348000000, 58, 1, 2),
> -	PLL_RATE(354000000, 59, 1, 2),
> -	PLL_RATE(360000000, 60, 1, 2),
> -	PLL_RATE(366000000, 61, 1, 2),
> -	PLL_RATE(372000000, 62, 1, 2),
> -	PLL_RATE(384000000, 32, 1, 1),
> -	PLL_RATE(396000000, 33, 1, 1),
> -	PLL_RATE(408000000, 34, 1, 1),
> -	PLL_RATE(420000000, 35, 1, 1),
> -	PLL_RATE(432000000, 36, 1, 1),
> -	PLL_RATE(444000000, 37, 1, 1),
> -	PLL_RATE(456000000, 38, 1, 1),
> -	PLL_RATE(468000000, 39, 1, 1),
> -	PLL_RATE(480000000, 40, 1, 1),
> -	PLL_RATE(492000000, 41, 1, 1),
> -	PLL_RATE(504000000, 42, 1, 1),
> -	PLL_RATE(516000000, 43, 1, 1),
> -	PLL_RATE(528000000, 44, 1, 1),
> -	PLL_RATE(540000000, 45, 1, 1),
> -	PLL_RATE(552000000, 46, 1, 1),
> -	PLL_RATE(564000000, 47, 1, 1),
> -	PLL_RATE(576000000, 48, 1, 1),
> -	PLL_RATE(588000000, 49, 1, 1),
> -	PLL_RATE(600000000, 50, 1, 1),
> -	PLL_RATE(612000000, 51, 1, 1),
> -	PLL_RATE(624000000, 52, 1, 1),
> -	PLL_RATE(636000000, 53, 1, 1),
> -	PLL_RATE(648000000, 54, 1, 1),
> -	PLL_RATE(660000000, 55, 1, 1),
> -	PLL_RATE(672000000, 56, 1, 1),
> -	PLL_RATE(684000000, 57, 1, 1),
> -	PLL_RATE(696000000, 58, 1, 1),
> -	PLL_RATE(708000000, 59, 1, 1),
> -	PLL_RATE(720000000, 60, 1, 1),
> -	PLL_RATE(732000000, 61, 1, 1),
> -	PLL_RATE(744000000, 62, 1, 1),
> -	PLL_RATE(768000000, 32, 1, 0),
> -	PLL_RATE(792000000, 33, 1, 0),
> -	PLL_RATE(816000000, 34, 1, 0),
> -	PLL_RATE(840000000, 35, 1, 0),
> -	PLL_RATE(864000000, 36, 1, 0),
> -	PLL_RATE(888000000, 37, 1, 0),
> -	PLL_RATE(912000000, 38, 1, 0),
> -	PLL_RATE(936000000, 39, 1, 0),
> -	PLL_RATE(960000000, 40, 1, 0),
> -	PLL_RATE(984000000, 41, 1, 0),
> -	PLL_RATE(1008000000, 42, 1, 0),
> -	PLL_RATE(1032000000, 43, 1, 0),
> -	PLL_RATE(1056000000, 44, 1, 0),
> -	PLL_RATE(1080000000, 45, 1, 0),
> -	PLL_RATE(1104000000, 46, 1, 0),
> -	PLL_RATE(1128000000, 47, 1, 0),
> -	PLL_RATE(1152000000, 48, 1, 0),
> -	PLL_RATE(1176000000, 49, 1, 0),
> -	PLL_RATE(1200000000, 50, 1, 0),
> -	PLL_RATE(1224000000, 51, 1, 0),
> -	PLL_RATE(1248000000, 52, 1, 0),
> -	PLL_RATE(1272000000, 53, 1, 0),
> -	PLL_RATE(1296000000, 54, 1, 0),
> -	PLL_RATE(1320000000, 55, 1, 0),
> -	PLL_RATE(1344000000, 56, 1, 0),
> -	PLL_RATE(1368000000, 57, 1, 0),
> -	PLL_RATE(1392000000, 58, 1, 0),
> -	PLL_RATE(1416000000, 59, 1, 0),
> -	PLL_RATE(1440000000, 60, 1, 0),
> -	PLL_RATE(1464000000, 61, 1, 0),
> -	PLL_RATE(1488000000, 62, 1, 0),
> +	PLL_RATE(768000000, 32, 1),
> +	PLL_RATE(792000000, 33, 1),
> +	PLL_RATE(816000000, 34, 1),
> +	PLL_RATE(840000000, 35, 1),
> +	PLL_RATE(864000000, 36, 1),
> +	PLL_RATE(888000000, 37, 1),
> +	PLL_RATE(912000000, 38, 1),
> +	PLL_RATE(936000000, 39, 1),
> +	PLL_RATE(960000000, 40, 1),
> +	PLL_RATE(984000000, 41, 1),
> +	PLL_RATE(1008000000, 42, 1),
> +	PLL_RATE(1032000000, 43, 1),
> +	PLL_RATE(1056000000, 44, 1),
> +	PLL_RATE(1080000000, 45, 1),
> +	PLL_RATE(1104000000, 46, 1),
> +	PLL_RATE(1128000000, 47, 1),
> +	PLL_RATE(1152000000, 48, 1),
> +	PLL_RATE(1176000000, 49, 1),
> +	PLL_RATE(1200000000, 50, 1),
> +	PLL_RATE(1224000000, 51, 1),
> +	PLL_RATE(1248000000, 52, 1),
> +	PLL_RATE(1272000000, 53, 1),
> +	PLL_RATE(1296000000, 54, 1),
> +	PLL_RATE(1320000000, 55, 1),
> +	PLL_RATE(1344000000, 56, 1),
> +	PLL_RATE(1368000000, 57, 1),
> +	PLL_RATE(1392000000, 58, 1),
> +	PLL_RATE(1416000000, 59, 1),
> +	PLL_RATE(1440000000, 60, 1),
> +	PLL_RATE(1464000000, 61, 1),
> +	PLL_RATE(1488000000, 62, 1),
>  	{ /* sentinel */ },
>  };
>  
>  static const struct pll_rate_table gxl_gp0_pll_rate_table[] = {
> -	PLL_RATE(504000000, 42, 1, 1),
> -	PLL_RATE(516000000, 43, 1, 1),
> -	PLL_RATE(528000000, 44, 1, 1),
> -	PLL_RATE(540000000, 45, 1, 1),
> -	PLL_RATE(552000000, 46, 1, 1),
> -	PLL_RATE(564000000, 47, 1, 1),
> -	PLL_RATE(576000000, 48, 1, 1),
> -	PLL_RATE(588000000, 49, 1, 1),
> -	PLL_RATE(600000000, 50, 1, 1),
> -	PLL_RATE(612000000, 51, 1, 1),
> -	PLL_RATE(624000000, 52, 1, 1),
> -	PLL_RATE(636000000, 53, 1, 1),
> -	PLL_RATE(648000000, 54, 1, 1),
> -	PLL_RATE(660000000, 55, 1, 1),
> -	PLL_RATE(672000000, 56, 1, 1),
> -	PLL_RATE(684000000, 57, 1, 1),
> -	PLL_RATE(696000000, 58, 1, 1),
> -	PLL_RATE(708000000, 59, 1, 1),
> -	PLL_RATE(720000000, 60, 1, 1),
> -	PLL_RATE(732000000, 61, 1, 1),
> -	PLL_RATE(744000000, 62, 1, 1),
> -	PLL_RATE(756000000, 63, 1, 1),
> -	PLL_RATE(768000000, 64, 1, 1),
> -	PLL_RATE(780000000, 65, 1, 1),
> -	PLL_RATE(792000000, 66, 1, 1),
> +	PLL_RATE(1008000000, 42, 1),
> +	PLL_RATE(1032000000, 43, 1),
> +	PLL_RATE(1056000000, 44, 1),
> +	PLL_RATE(1080000000, 45, 1),
> +	PLL_RATE(1104000000, 46, 1),
> +	PLL_RATE(1128000000, 47, 1),
> +	PLL_RATE(1152000000, 48, 1),
> +	PLL_RATE(1176000000, 49, 1),
> +	PLL_RATE(1200000000, 50, 1),
> +	PLL_RATE(1224000000, 51, 1),
> +	PLL_RATE(1248000000, 52, 1),
> +	PLL_RATE(1272000000, 53, 1),
> +	PLL_RATE(1296000000, 54, 1),
> +	PLL_RATE(1320000000, 55, 1),
> +	PLL_RATE(1344000000, 56, 1),
> +	PLL_RATE(1368000000, 57, 1),
> +	PLL_RATE(1392000000, 58, 1),
> +	PLL_RATE(1416000000, 59, 1),
> +	PLL_RATE(1440000000, 60, 1),
> +	PLL_RATE(1464000000, 61, 1),
> +	PLL_RATE(1488000000, 62, 1),
> +	PLL_RATE(1512000000, 63, 1),
> +	PLL_RATE(1536000000, 64, 1),
> +	PLL_RATE(1560000000, 65, 1),
> +	PLL_RATE(1584000000, 66, 1),
>  	{ /* sentinel */ },
>  };
>  
> -static struct clk_regmap gxbb_fixed_pll = {
> +static struct clk_regmap gxbb_fixed_pll_dco = {
>  	.data = &(struct meson_clk_pll_data){
>  		.en = {
>  			.reg_off = HHI_MPLL_CNTL,
> @@ -192,11 +99,6 @@ static struct clk_regmap gxbb_fixed_pll = {
>  			.shift   = 9,
>  			.width   = 5,
>  		},
> -		.od = {
> -			.reg_off = HHI_MPLL_CNTL,
> -			.shift   = 16,
> -			.width   = 2,
> -		},
>  		.frac = {
>  			.reg_off = HHI_MPLL_CNTL2,
>  			.shift   = 0,
> @@ -214,7 +116,7 @@ static struct clk_regmap gxbb_fixed_pll = {
>  		},
>  	},
>  	.hw.init = &(struct clk_init_data){
> -		.name = "fixed_pll",
> +		.name = "fixed_pll_dco",
>  		.ops = &meson_clk_pll_ro_ops,
>  		.parent_names = (const char *[]){ "xtal" },
>  		.num_parents = 1,
> @@ -222,6 +124,21 @@ static struct clk_regmap gxbb_fixed_pll = {
>  	},
>  };
>  
> +static struct clk_regmap gxbb_fixed_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_MPLL_CNTL,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fixed_pll",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_names = (const char *[]){ "fixed_pll_dco" },
> +		.num_parents = 1,
> +	},
> +};
> +
>  static struct clk_fixed_factor gxbb_hdmi_pll_pre_mult = {
>  	.mult = 2,
>  	.div = 1,
> @@ -233,7 +150,7 @@ static struct clk_fixed_factor gxbb_hdmi_pll_pre_mult = {
>  	},
>  };
>  
> -static struct clk_regmap gxbb_hdmi_pll = {
> +static struct clk_regmap gxbb_hdmi_pll_dco = {
>  	.data = &(struct meson_clk_pll_data){
>  		.en = {
>  			.reg_off = HHI_HDMI_PLL_CNTL,
> @@ -255,21 +172,6 @@ static struct clk_regmap gxbb_hdmi_pll = {
>  			.shift   = 0,
>  			.width   = 12,
>  		},
> -		.od = {
> -			.reg_off = HHI_HDMI_PLL_CNTL2,
> -			.shift   = 16,
> -			.width   = 2,
> -		},
> -		.od2 = {
> -			.reg_off = HHI_HDMI_PLL_CNTL2,
> -			.shift   = 22,
> -			.width   = 2,
> -		},
> -		.od3 = {
> -			.reg_off = HHI_HDMI_PLL_CNTL2,
> -			.shift   = 18,
> -			.width   = 2,
> -		},
>  		.l = {
>  			.reg_off = HHI_HDMI_PLL_CNTL,
>  			.shift   = 31,
> @@ -282,7 +184,7 @@ static struct clk_regmap gxbb_hdmi_pll = {
>  		},
>  	},
>  	.hw.init = &(struct clk_init_data){
> -		.name = "hdmi_pll",
> +		.name = "hdmi_pll_dco",
>  		.ops = &meson_clk_pll_ro_ops,
>  		.parent_names = (const char *[]){ "hdmi_pll_pre_mult" },
>  		.num_parents = 1,
> @@ -290,70 +192,103 @@ static struct clk_regmap gxbb_hdmi_pll = {
>  	},
>  };
>  
> +static struct clk_regmap gxbb_hdmi_pll_od = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_HDMI_PLL_CNTL2,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hdmi_pll_od",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_names = (const char *[]){ "hdmi_pll_dco" },
> +		.num_parents = 1,
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
> +static struct clk_regmap gxbb_hdmi_pll_od2 = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_HDMI_PLL_CNTL2,
> +		.shift = 22,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hdmi_pll_od2",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_names = (const char *[]){ "hdmi_pll_od" },
> +		.num_parents = 1,
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
> +static struct clk_regmap gxbb_hdmi_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_HDMI_PLL_CNTL2,
> +		.shift = 18,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hdmi_pll",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_names = (const char *[]){ "hdmi_pll_od2" },
> +		.num_parents = 1,
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
> +static struct clk_regmap gxl_hdmi_pll_od = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_HDMI_PLL_CNTL + 8,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hdmi_pll_od",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_names = (const char *[]){ "hdmi_pll_dco" },
> +		.num_parents = 1,
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};

In my code, the GXL OD1 is at bit 21

> +
> +static struct clk_regmap gxl_hdmi_pll_od2 = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_HDMI_PLL_CNTL + 8,
> +		.shift = 22,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hdmi_pll_od2",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_names = (const char *[]){ "hdmi_pll_od" },
> +		.num_parents = 1,
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};


In my code, the GXL OD3 is at bit 23

> +
>  static struct clk_regmap gxl_hdmi_pll = {
> -	.data = &(struct meson_clk_pll_data){
> -		.en = {
> -			.reg_off = HHI_HDMI_PLL_CNTL,
> -			.shift   = 30,
> -			.width   = 1,
> -		},
> -		.m = {
> -			.reg_off = HHI_HDMI_PLL_CNTL,
> -			.shift   = 0,
> -			.width   = 9,
> -		},
> -		.n = {
> -			.reg_off = HHI_HDMI_PLL_CNTL,
> -			.shift   = 9,
> -			.width   = 5,
> -		},
> -		.frac = {
> -			/*
> -			 * On gxl, there is a register shift due to
> -			 * HHI_HDMI_PLL_CNTL1 which does not exist on gxbb,
> -			 * so we compute the register offset based on the PLL
> -			 * base to get it right
> -			 */
> -			.reg_off = HHI_HDMI_PLL_CNTL + 4,
> -			.shift   = 0,
> -			.width   = 12,
> -		},
> -		.od = {
> -			.reg_off = HHI_HDMI_PLL_CNTL + 8,
> -			.shift   = 21,
> -			.width   = 2,
> -		},
> -		.od2 = {
> -			.reg_off = HHI_HDMI_PLL_CNTL + 8,
> -			.shift   = 23,
> -			.width   = 2,
> -		},
> -		.od3 = {
> -			.reg_off = HHI_HDMI_PLL_CNTL + 8,
> -			.shift   = 19,
> -			.width   = 2,
> -		},
> -		.l = {
> -			.reg_off = HHI_HDMI_PLL_CNTL,
> -			.shift   = 31,
> -			.width   = 1,
> -		},
> -		.rst = {
> -			.reg_off = HHI_HDMI_PLL_CNTL,
> -			.shift   = 29,
> -			.width   = 1,
> -		},
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_HDMI_PLL_CNTL + 8,
> +		.shift = 18,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,


In my code, the GXL OD3 is at bit 19

It's only a copy/paste error, the original code had the correct shifts.

>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "hdmi_pll",
> -		.ops = &meson_clk_pll_ro_ops,
> -		.parent_names = (const char *[]){ "xtal" },
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_names = (const char *[]){ "hdmi_pll_od2" },
>  		.num_parents = 1,
>  		.flags = CLK_GET_RATE_NOCACHE,
>  	},
>  };
>  
> -static struct clk_regmap gxbb_sys_pll = {
> +static struct clk_regmap gxbb_sys_pll_dco = {
>  	.data = &(struct meson_clk_pll_data){
>  		.en = {
>  			.reg_off = HHI_SYS_PLL_CNTL,
> @@ -370,11 +305,6 @@ static struct clk_regmap gxbb_sys_pll = {
>  			.shift   = 9,
>  			.width   = 5,
>  		},
> -		.od = {
> -			.reg_off = HHI_SYS_PLL_CNTL,
> -			.shift   = 10,
> -			.width   = 2,
> -		},
>  		.l = {
>  			.reg_off = HHI_SYS_PLL_CNTL,
>  			.shift   = 31,
> @@ -387,7 +317,7 @@ static struct clk_regmap gxbb_sys_pll = {
>  		},
>  	},
>  	.hw.init = &(struct clk_init_data){
> -		.name = "sys_pll",
> +		.name = "sys_pll_dco",
>  		.ops = &meson_clk_pll_ro_ops,
>  		.parent_names = (const char *[]){ "xtal" },
>  		.num_parents = 1,
> @@ -395,13 +325,29 @@ static struct clk_regmap gxbb_sys_pll = {
>  	},
>  };
>  
> +static struct clk_regmap gxbb_sys_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_SYS_PLL_CNTL,
> +		.shift = 10,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "sys_pll",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_names = (const char *[]){ "sys_pll_dco" },
> +		.num_parents = 1,
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
>  static const struct reg_sequence gxbb_gp0_init_regs[] = {
>  	{ .reg = HHI_GP0_PLL_CNTL2,	.def = 0x69c80000 },
>  	{ .reg = HHI_GP0_PLL_CNTL3,	.def = 0x0a5590c4 },
>  	{ .reg = HHI_GP0_PLL_CNTL4,	.def = 0x0000500d },
>  };
>  
> -static struct clk_regmap gxbb_gp0_pll = {
> +static struct clk_regmap gxbb_gp0_pll_dco = {
>  	.data = &(struct meson_clk_pll_data){
>  		.en = {
>  			.reg_off = HHI_GP0_PLL_CNTL,
> @@ -418,11 +364,6 @@ static struct clk_regmap gxbb_gp0_pll = {
>  			.shift   = 9,
>  			.width   = 5,
>  		},
> -		.od = {
> -			.reg_off = HHI_GP0_PLL_CNTL,
> -			.shift   = 16,
> -			.width   = 2,
> -		},
>  		.l = {
>  			.reg_off = HHI_GP0_PLL_CNTL,
>  			.shift   = 31,
> @@ -438,7 +379,7 @@ static struct clk_regmap gxbb_gp0_pll = {
>  		.init_count = ARRAY_SIZE(gxbb_gp0_init_regs),
>  	},
>  	.hw.init = &(struct clk_init_data){
> -		.name = "gp0_pll",
> +		.name = "gp0_pll_dco",
>  		.ops = &meson_clk_pll_ops,
>  		.parent_names = (const char *[]){ "xtal" },
>  		.num_parents = 1,
> @@ -454,7 +395,7 @@ static const struct reg_sequence gxl_gp0_init_regs[] = {
>  	{ .reg = HHI_GP0_PLL_CNTL5,	.def = 0x00078000 },
>  };
>  
> -static struct clk_regmap gxl_gp0_pll = {
> +static struct clk_regmap gxl_gp0_pll_dco = {
>  	.data = &(struct meson_clk_pll_data){
>  		.en = {
>  			.reg_off = HHI_GP0_PLL_CNTL,
> @@ -471,11 +412,6 @@ static struct clk_regmap gxl_gp0_pll = {
>  			.shift   = 9,
>  			.width   = 5,
>  		},
> -		.od = {
> -			.reg_off = HHI_GP0_PLL_CNTL,
> -			.shift   = 16,
> -			.width   = 2,
> -		},
>  		.frac = {
>  			.reg_off = HHI_GP0_PLL_CNTL1,
>  			.shift   = 0,
> @@ -496,7 +432,7 @@ static struct clk_regmap gxl_gp0_pll = {
>  		.init_count = ARRAY_SIZE(gxl_gp0_init_regs),
>  	},
>  	.hw.init = &(struct clk_init_data){
> -		.name = "gp0_pll",
> +		.name = "gp0_pll_dco",
>  		.ops = &meson_clk_pll_ops,
>  		.parent_names = (const char *[]){ "xtal" },
>  		.num_parents = 1,
> @@ -504,6 +440,22 @@ static struct clk_regmap gxl_gp0_pll = {
>  	},
>  };
>  
> +static struct clk_regmap gxbb_gp0_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_GP0_PLL_CNTL,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "gp0_pll",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_names = (const char *[]){ "gp0_pll_dco" },
> +		.num_parents = 1,
> +		.flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> +	},
> +};
> +
>  static struct clk_fixed_factor gxbb_fclk_div2_div = {
>  	.mult = 1,
>  	.div = 2,
> @@ -1961,6 +1913,12 @@ static struct clk_hw_onecell_data gxbb_hw_onecell_data = {
>  		[CLKID_GEN_CLK_SEL]	    = &gxbb_gen_clk_sel.hw,
>  		[CLKID_GEN_CLK_DIV]	    = &gxbb_gen_clk_div.hw,
>  		[CLKID_GEN_CLK]		    = &gxbb_gen_clk.hw,
> +		[CLKID_FIXED_PLL_DCO]	    = &gxbb_fixed_pll_dco.hw,
> +		[CLKID_HDMI_PLL_DCO]	    = &gxbb_hdmi_pll_dco.hw,
> +		[CLKID_HDMI_PLL_OD]	    = &gxbb_hdmi_pll_od.hw,
> +		[CLKID_HDMI_PLL_OD2]	    = &gxbb_hdmi_pll_od2.hw,
> +		[CLKID_SYS_PLL_DCO]	    = &gxbb_sys_pll_dco.hw,
> +		[CLKID_GP0_PLL_DCO]	    = &gxbb_gp0_pll_dco.hw,
>  		[NR_CLKS]		    = NULL,
>  	},
>  	.num = NR_CLKS,
> @@ -1976,7 +1934,7 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
>  		[CLKID_FCLK_DIV4]	    = &gxbb_fclk_div4.hw,
>  		[CLKID_FCLK_DIV5]	    = &gxbb_fclk_div5.hw,
>  		[CLKID_FCLK_DIV7]	    = &gxbb_fclk_div7.hw,
> -		[CLKID_GP0_PLL]		    = &gxl_gp0_pll.hw,
> +		[CLKID_GP0_PLL]		    = &gxbb_gp0_pll.hw,
>  		[CLKID_MPEG_SEL]	    = &gxbb_mpeg_clk_sel.hw,
>  		[CLKID_MPEG_DIV]	    = &gxbb_mpeg_clk_div.hw,
>  		[CLKID_CLK81]		    = &gxbb_clk81.hw,
> @@ -2126,19 +2084,29 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
>  		[CLKID_GEN_CLK_SEL]	    = &gxbb_gen_clk_sel.hw,
>  		[CLKID_GEN_CLK_DIV]	    = &gxbb_gen_clk_div.hw,
>  		[CLKID_GEN_CLK]		    = &gxbb_gen_clk.hw,
> +		[CLKID_FIXED_PLL_DCO]	    = &gxbb_fixed_pll_dco.hw,
> +		[CLKID_HDMI_PLL_DCO]	    = &gxbb_hdmi_pll_dco.hw,
> +		[CLKID_HDMI_PLL_OD]	    = &gxl_hdmi_pll_od.hw,
> +		[CLKID_HDMI_PLL_OD2]	    = &gxl_hdmi_pll_od2.hw,
> +		[CLKID_SYS_PLL_DCO]	    = &gxbb_sys_pll_dco.hw,
> +		[CLKID_GP0_PLL_DCO]	    = &gxl_gp0_pll_dco.hw,
>  		[NR_CLKS]		    = NULL,
>  	},
>  	.num = NR_CLKS,
>  };
>  
>  static struct clk_regmap *const gxbb_clk_regmaps[] = {
> -	&gxbb_gp0_pll,
> +	&gxbb_gp0_pll_dco,
>  	&gxbb_hdmi_pll,
> +	&gxbb_hdmi_pll_od,
> +	&gxbb_hdmi_pll_od2,
>  };
>  
>  static struct clk_regmap *const gxl_clk_regmaps[] = {
> -	&gxl_gp0_pll,
> +	&gxl_gp0_pll_dco,
>  	&gxl_hdmi_pll,
> +	&gxl_hdmi_pll_od,
> +	&gxl_hdmi_pll_od2,
>  };
>  
>  static struct clk_regmap *const gx_clk_regmaps[] = {
> @@ -2293,6 +2261,10 @@ static struct clk_regmap *const gx_clk_regmaps[] = {
>  	&gxbb_gen_clk_sel,
>  	&gxbb_gen_clk_div,
>  	&gxbb_gen_clk,
> +	&gxbb_fixed_pll_dco,
> +	&gxbb_hdmi_pll_dco,
> +	&gxbb_sys_pll_dco,
> +	&gxbb_gp0_pll,
>  };
>  
>  struct clkc_data {
> diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
> index 20dfb1daf5b8..72bc077d9663 100644
> --- a/drivers/clk/meson/gxbb.h
> +++ b/drivers/clk/meson/gxbb.h
> @@ -159,8 +159,14 @@
>  #define CLKID_VDEC_HEVC_DIV	  155
>  #define CLKID_GEN_CLK_SEL	  157
>  #define CLKID_GEN_CLK_DIV	  158
> -
> -#define NR_CLKS			  160
> +#define CLKID_FIXED_PLL_DCO	  160
> +#define CLKID_HDMI_PLL_DCO	  161
> +#define CLKID_HDMI_PLL_OD	  162
> +#define CLKID_HDMI_PLL_OD2	  163
> +#define CLKID_SYS_PLL_DCO	  164
> +#define CLKID_GP0_PLL_DCO	  165
> +
> +#define NR_CLKS			  166
>  
>  /* include the CLKIDs that have been made part of the DT binding */
>  #include <dt-bindings/clock/gxbb-clkc.h>
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index fd4c414893f5..17bcf0be56ba 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -30,58 +30,21 @@ struct meson8b_clk_reset {
>  };
>  
>  static const struct pll_rate_table sys_pll_rate_table[] = {
> -	PLL_RATE(312000000, 52, 1, 2),
> -	PLL_RATE(336000000, 56, 1, 2),
> -	PLL_RATE(360000000, 60, 1, 2),
> -	PLL_RATE(384000000, 64, 1, 2),
> -	PLL_RATE(408000000, 68, 1, 2),
> -	PLL_RATE(432000000, 72, 1, 2),
> -	PLL_RATE(456000000, 76, 1, 2),
> -	PLL_RATE(480000000, 80, 1, 2),
> -	PLL_RATE(504000000, 84, 1, 2),
> -	PLL_RATE(528000000, 88, 1, 2),
> -	PLL_RATE(552000000, 92, 1, 2),
> -	PLL_RATE(576000000, 96, 1, 2),
> -	PLL_RATE(600000000, 50, 1, 1),
> -	PLL_RATE(624000000, 52, 1, 1),
> -	PLL_RATE(648000000, 54, 1, 1),
> -	PLL_RATE(672000000, 56, 1, 1),
> -	PLL_RATE(696000000, 58, 1, 1),
> -	PLL_RATE(720000000, 60, 1, 1),
> -	PLL_RATE(744000000, 62, 1, 1),
> -	PLL_RATE(768000000, 64, 1, 1),
> -	PLL_RATE(792000000, 66, 1, 1),
> -	PLL_RATE(816000000, 68, 1, 1),
> -	PLL_RATE(840000000, 70, 1, 1),
> -	PLL_RATE(864000000, 72, 1, 1),
> -	PLL_RATE(888000000, 74, 1, 1),
> -	PLL_RATE(912000000, 76, 1, 1),
> -	PLL_RATE(936000000, 78, 1, 1),
> -	PLL_RATE(960000000, 80, 1, 1),
> -	PLL_RATE(984000000, 82, 1, 1),
> -	PLL_RATE(1008000000, 84, 1, 1),
> -	PLL_RATE(1032000000, 86, 1, 1),
> -	PLL_RATE(1056000000, 88, 1, 1),
> -	PLL_RATE(1080000000, 90, 1, 1),
> -	PLL_RATE(1104000000, 92, 1, 1),
> -	PLL_RATE(1128000000, 94, 1, 1),
> -	PLL_RATE(1152000000, 96, 1, 1),
> -	PLL_RATE(1176000000, 98, 1, 1),
> -	PLL_RATE(1200000000, 50, 1, 0),
> -	PLL_RATE(1224000000, 51, 1, 0),
> -	PLL_RATE(1248000000, 52, 1, 0),
> -	PLL_RATE(1272000000, 53, 1, 0),
> -	PLL_RATE(1296000000, 54, 1, 0),
> -	PLL_RATE(1320000000, 55, 1, 0),
> -	PLL_RATE(1344000000, 56, 1, 0),
> -	PLL_RATE(1368000000, 57, 1, 0),
> -	PLL_RATE(1392000000, 58, 1, 0),
> -	PLL_RATE(1416000000, 59, 1, 0),
> -	PLL_RATE(1440000000, 60, 1, 0),
> -	PLL_RATE(1464000000, 61, 1, 0),
> -	PLL_RATE(1488000000, 62, 1, 0),
> -	PLL_RATE(1512000000, 63, 1, 0),
> -	PLL_RATE(1536000000, 64, 1, 0),
> +	PLL_RATE(1200000000, 50, 1),
> +	PLL_RATE(1224000000, 51, 1),
> +	PLL_RATE(1248000000, 52, 1),
> +	PLL_RATE(1272000000, 53, 1),
> +	PLL_RATE(1296000000, 54, 1),
> +	PLL_RATE(1320000000, 55, 1),
> +	PLL_RATE(1344000000, 56, 1),
> +	PLL_RATE(1368000000, 57, 1),
> +	PLL_RATE(1392000000, 58, 1),
> +	PLL_RATE(1416000000, 59, 1),
> +	PLL_RATE(1440000000, 60, 1),
> +	PLL_RATE(1464000000, 61, 1),
> +	PLL_RATE(1488000000, 62, 1),
> +	PLL_RATE(1512000000, 63, 1),
> +	PLL_RATE(1536000000, 64, 1),
>  	{ /* sentinel */ },
>  };
>  
> @@ -94,7 +57,7 @@ static struct clk_fixed_rate meson8b_xtal = {
>  	},
>  };
>  
> -static struct clk_regmap meson8b_fixed_pll = {
> +static struct clk_regmap meson8b_fixed_pll_dco = {
>  	.data = &(struct meson_clk_pll_data){
>  		.en = {
>  			.reg_off = HHI_MPLL_CNTL,
> @@ -111,11 +74,6 @@ static struct clk_regmap meson8b_fixed_pll = {
>  			.shift   = 9,
>  			.width   = 5,
>  		},
> -		.od = {
> -			.reg_off = HHI_MPLL_CNTL,
> -			.shift   = 16,
> -			.width   = 2,
> -		},
>  		.frac = {
>  			.reg_off = HHI_MPLL_CNTL2,
>  			.shift   = 0,
> @@ -133,7 +91,7 @@ static struct clk_regmap meson8b_fixed_pll = {
>  		},
>  	},
>  	.hw.init = &(struct clk_init_data){
> -		.name = "fixed_pll",
> +		.name = "fixed_pll_dco",
>  		.ops = &meson_clk_pll_ro_ops,
>  		.parent_names = (const char *[]){ "xtal" },
>  		.num_parents = 1,
> @@ -141,7 +99,23 @@ static struct clk_regmap meson8b_fixed_pll = {
>  	},
>  };
>  
> -static struct clk_regmap meson8b_vid_pll = {
> +static struct clk_regmap meson8b_fixed_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_MPLL_CNTL,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fixed_pll",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_names = (const char *[]){ "fixed_pll_dco" },
> +		.num_parents = 1,
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_vid_pll_dco = {
>  	.data = &(struct meson_clk_pll_data){
>  		.en = {
>  			.reg_off = HHI_VID_PLL_CNTL,
> @@ -158,11 +132,6 @@ static struct clk_regmap meson8b_vid_pll = {
>  			.shift   = 9,
>  			.width   = 5,
>  		},
> -		.od = {
> -			.reg_off = HHI_VID_PLL_CNTL,
> -			.shift   = 16,
> -			.width   = 2,
> -		},
>  		.l = {
>  			.reg_off = HHI_VID_PLL_CNTL,
>  			.shift   = 31,
> @@ -175,7 +144,7 @@ static struct clk_regmap meson8b_vid_pll = {
>  		},
>  	},
>  	.hw.init = &(struct clk_init_data){
> -		.name = "vid_pll",
> +		.name = "vid_pll_dco",
>  		.ops = &meson_clk_pll_ro_ops,
>  		.parent_names = (const char *[]){ "xtal" },
>  		.num_parents = 1,
> @@ -183,7 +152,23 @@ static struct clk_regmap meson8b_vid_pll = {
>  	},
>  };
>  
> -static struct clk_regmap meson8b_sys_pll = {
> +static struct clk_regmap meson8b_vid_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_VID_PLL_CNTL,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vid_pll",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_names = (const char *[]){ "vid_pll_dco" },
> +		.num_parents = 1,
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_sys_pll_dco = {
>  	.data = &(struct meson_clk_pll_data){
>  		.en = {
>  			.reg_off = HHI_SYS_PLL_CNTL,
> @@ -200,11 +185,6 @@ static struct clk_regmap meson8b_sys_pll = {
>  			.shift   = 9,
>  			.width   = 5,
>  		},
> -		.od = {
> -			.reg_off = HHI_SYS_PLL_CNTL,
> -			.shift   = 16,
> -			.width   = 2,
> -		},
>  		.l = {
>  			.reg_off = HHI_SYS_PLL_CNTL,
>  			.shift   = 31,
> @@ -218,7 +198,7 @@ static struct clk_regmap meson8b_sys_pll = {
>  		.table = sys_pll_rate_table,
>  	},
>  	.hw.init = &(struct clk_init_data){
> -		.name = "sys_pll",
> +		.name = "sys_pll_dco",
>  		.ops = &meson_clk_pll_ro_ops,
>  		.parent_names = (const char *[]){ "xtal" },
>  		.num_parents = 1,
> @@ -226,6 +206,22 @@ static struct clk_regmap meson8b_sys_pll = {
>  	},
>  };
>  
> +static struct clk_regmap meson8b_sys_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_SYS_PLL_CNTL,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "sys_pll",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_names = (const char *[]){ "sys_pll_dco" },
> +		.num_parents = 1,
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
>  static struct clk_fixed_factor meson8b_fclk_div2_div = {
>  	.mult = 1,
>  	.div = 2,
> @@ -894,6 +890,9 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
>  		[CLKID_NAND_SEL]	    = &meson8b_nand_clk_sel.hw,
>  		[CLKID_NAND_DIV]	    = &meson8b_nand_clk_div.hw,
>  		[CLKID_NAND_CLK]	    = &meson8b_nand_clk_gate.hw,
> +		[CLKID_PLL_FIXED_DCO]	    = &meson8b_fixed_pll_dco.hw,
> +		[CLKID_PLL_VID_DCO]	    = &meson8b_vid_pll_dco.hw,
> +		[CLKID_PLL_SYS_DCO]	    = &meson8b_sys_pll_dco.hw,
>  		[CLK_NR_CLKS]		    = NULL,
>  	},
>  	.num = CLK_NR_CLKS,
> @@ -1002,6 +1001,9 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
>  	&meson8b_nand_clk_sel,
>  	&meson8b_nand_clk_div,
>  	&meson8b_nand_clk_gate,
> +	&meson8b_fixed_pll_dco,
> +	&meson8b_vid_pll_dco,
> +	&meson8b_sys_pll_dco,
>  };
>  
>  static const struct meson8b_clk_reset_line {
> diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
> index 5d09412b5084..1c6fb180e6a2 100644
> --- a/drivers/clk/meson/meson8b.h
> +++ b/drivers/clk/meson/meson8b.h
> @@ -75,8 +75,11 @@
>  #define CLKID_FCLK_DIV7_DIV	109
>  #define CLKID_NAND_SEL		110
>  #define CLKID_NAND_DIV		111
> +#define CLKID_PLL_FIXED_DCO	113
> +#define CLKID_PLL_VID_DCO	114
> +#define CLKID_PLL_SYS_DCO	115
>  
> -#define CLK_NR_CLKS		113
> +#define CLK_NR_CLKS		116
>  
>  /*
>   * include the CLKID and RESETID that have
> 

Apart the small mismatch in the OD GXL bit, this will make this simpler to move the DRM code to CCF :

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
