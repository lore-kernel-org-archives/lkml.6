Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753975AbeDZIkE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:40:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39091 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753256AbeDZIj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:39:59 -0400
X-Google-Smtp-Source: AIpwx4/SyrUu1SgRDbVuoOP2257vPPIWe55dYypfMbcTIs8NXRR99u8YBrGSN8XDWHMnC2wStSeW/g==
Subject: Re: [PATCH 1/2] clk: meson: mpll: add round closest support
To: Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180420095603.29964-1-jbrunet@baylibre.com>
 <20180420095603.29964-2-jbrunet@baylibre.com>
From: Neil Armstrong <narmstrong@baylibre.com>
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
Message-ID: <f60eb9b0-c9dc-e9bd-1c2d-6df01a583a35@baylibre.com>
Date: Thu, 26 Apr 2018 10:39:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420095603.29964-2-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2018 11:56, Jerome Brunet wrote:
> Allow the mpll driver to round the requested rate up if
> CLK_MESON_MPLL_ROUND_CLOSEST is set and it provides a rate closer to the
> requested rate.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/clk-mpll.c | 25 ++++++++++++++++++++-----
>  drivers/clk/meson/clkc.h     |  3 +++
>  2 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
> index 0df1227b65b3..4e5283eb892a 100644
> --- a/drivers/clk/meson/clk-mpll.c
> +++ b/drivers/clk/meson/clk-mpll.c
> @@ -89,10 +89,23 @@ static long rate_from_params(unsigned long parent_rate,
>  static void params_from_rate(unsigned long requested_rate,
>  			     unsigned long parent_rate,
>  			     unsigned int *sdm,
> -			     unsigned int *n2)
> +			     unsigned int *n2,
> +			     u8 flags)
>  {
>  	uint64_t div = parent_rate;
> -	unsigned long rem = do_div(div, requested_rate);
> +	uint64_t frac = do_div(div, requested_rate);
> +	unsigned long rem;
> +
> +	frac *= SDM_DEN;
> +	rem = do_div(frac, requested_rate);
> +
> +	/* Should we round up ? */
> +	if (flags & CLK_MESON_MPLL_ROUND_CLOSEST
> +	    && rem > (requested_rate / 2)) {
> +		frac = (frac + 1) % SDM_DEN;
> +		if (frac == 0)
> +			div += 1;
> +	}
>  
>  	if (div < N2_MIN) {
>  		*n2 = N2_MIN;
> @@ -102,7 +115,7 @@ static void params_from_rate(unsigned long requested_rate,
>  		*sdm = SDM_DEN - 1;
>  	} else {
>  		*n2 = div;
> -		*sdm = DIV_ROUND_UP_ULL((u64)rem * SDM_DEN, requested_rate);
> +		*sdm = frac;
>  	}
>  }
>  
> @@ -125,9 +138,11 @@ static long mpll_round_rate(struct clk_hw *hw,
>  			    unsigned long rate,
>  			    unsigned long *parent_rate)
>  {
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_clk_mpll_data *mpll = meson_clk_mpll_data(clk);
>  	unsigned int sdm, n2;
>  
> -	params_from_rate(rate, *parent_rate, &sdm, &n2);
> +	params_from_rate(rate, *parent_rate, &sdm, &n2, mpll->flags);
>  	return rate_from_params(*parent_rate, sdm, n2);
>  }
>  
> @@ -140,7 +155,7 @@ static int mpll_set_rate(struct clk_hw *hw,
>  	unsigned int sdm, n2;
>  	unsigned long flags = 0;
>  
> -	params_from_rate(rate, parent_rate, &sdm, &n2);
> +	params_from_rate(rate, parent_rate, &sdm, &n2, mpll->flags);
>  
>  	if (mpll->lock)
>  		spin_lock_irqsave(mpll->lock, flags);
> diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
> index 8fe73c4edca8..8cc265cd3d2b 100644
> --- a/drivers/clk/meson/clkc.h
> +++ b/drivers/clk/meson/clkc.h
> @@ -97,8 +97,11 @@ struct meson_clk_mpll_data {
>  	struct parm ssen;
>  	struct parm misc;
>  	spinlock_t *lock;
> +	u8 flags;
>  };
>  
> +#define CLK_MESON_MPLL_ROUND_CLOSEST	BIT(0)
> +
>  struct meson_clk_audio_div_data {
>  	struct parm div;
>  	u8 flags;
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
