Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260CCC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20332081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="v3ovfyFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20332081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeLKJVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:21:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46294 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeLKJVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:21:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so13216525wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=878CJNjtv0XVmAZsWgH1V3l3wUno7klI+xSj/SBjgHY=;
        b=v3ovfyFUz3FfFDO/IzWSfU28RFe03amkM0cfwbzKnbxqX0LRE8iooCUm1hXu27fFDO
         XplwcPhxQnKOuY9sh5fjOgIS8cc93nNisjiSV9MjbJwSCF8l4SZSWveEdm4u6abTSg/E
         26QHURbYnBGaygtXxlfzpO3yJFsw/apExq27Opd/AHj3laa5DmBvPV9yjgCa1H/SjKt2
         qvFh47V2u1uwFT+jLycbKjkIppaiUKmyaxf9ZzWe5Kez943OIxAF7sSE++Gf/qmfZtgB
         t+zVR8vvn3fDgLUvNhHcSDPP++kXBMJVVtXv1o4Rc9iw7qQGfSO2CkwNXmnINFt2YLw1
         kTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=878CJNjtv0XVmAZsWgH1V3l3wUno7klI+xSj/SBjgHY=;
        b=nFPrLfcon8MUO41V79+CBFeDBVN19VhV1pWP7toCV1o3P9+sT8PybO2qsCibl3UbEa
         xXTo2ltFu0nH3Rr/WVYOvwFvpWq1y5DkQ3BRTn8FIw1PM42oyi/W6d3R02hwvmBOqrev
         cVlWMTipUggl5DsctX3oQwRGBniPbxmebLNxNfPVXjoSJnWCITC9RGZpLdpBhn3oQBo8
         OCV/q3y/4fq8GtC4m75gZRB+9gr8XniEuwx1J5e09CRugVjdIbpdQx+PI4lXQWNI+2m0
         YfEO2YWixJ1CKGnE7mkYEjFK7eQKOa2uaFq8FR118h72XouwG7Hmggs31WdpZfTgRcnW
         NXzQ==
X-Gm-Message-State: AA+aEWYVlAJ1i6H8MMyfSoIez2jQlZYyxB4VHBhc9F48sBwLvYcjrV8S
        DbxjddW5RlcIWs+0PfJVQvkfBQ==
X-Google-Smtp-Source: AFSGD/WStqXt2Biz3FtAo56pLJW3fTPsd9tYzzWmPMiQ1lBu5ySPUIe8hOcn42/yLkIVOCgD7l/7oQ==
X-Received: by 2002:a5d:4d11:: with SMTP id z17mr12055066wrt.209.1544520102202;
        Tue, 11 Dec 2018 01:21:42 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:a5f8:3197:dbfa:c157? ([2a01:cb1d:4ce:ea00:a5f8:3197:dbfa:c157])
        by smtp.gmail.com with ESMTPSA id n127sm1323150wmd.20.2018.12.11.01.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 01:21:41 -0800 (PST)
Subject: Re: [PATCH 3/5] clk: meson: meson8b: add the GPU clock tree
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, khilman@baylibre.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sboyd@kernel.org, mturquette@baylibre.com
References: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
 <20181208171247.22238-4-martin.blumenstingl@googlemail.com>
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
Message-ID: <7345cb90-b63d-5461-d97c-89ef563dc421@baylibre.com>
Date:   Tue, 11 Dec 2018 10:21:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181208171247.22238-4-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2018 18:12, Martin Blumenstingl wrote:
> Add the GPU clock tree on Meson8, Meson8b and Meson8m2.
> 
> The GPU clock tree on Meson8b and Meson8m2 is almost identical to the
> one one GXBB:
> - there's a glitch-free mux at HHI_MALI_CLK_CNTL[31]
> - there are two identical parents for this mux: mali_0 and mali_1, each
>   with a gate, divider and mux
> - the parents of mali_0_sel and mali_1_sel are identical to GXBB except
>   there's no GP0_PLL on these 32-bit SoCs
> 
> Meson8 is different because it does not have the glitch-free mux.
> Instead if only has the mali_0 clock tree. The parents of mali_0_sel are
> identical to the ones on Meson8b and Meson8m2.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/meson8b.c | 146 ++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/meson8b.h |   9 ++-
>  2 files changed, 154 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index 0b9353d8d4fd..748552c5f6c8 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -1573,6 +1573,135 @@ static struct clk_regmap meson8b_hdmi_sys = {
>  	},
>  };
>  
> +/*
> + * The MALI IP is clocked by two identical clocks (mali_0 and mali_1)
> + * muxed by a glitch-free switch on Meson8b and Meson8m2. Meson8 only
> + * has mali_0 and no glitch-free mux.
> + */
> +static const char * const meson8b_mali_0_1_parent_names[] = {
> +	"xtal", "mpll2", "mpll1", "fclk_div7", "fclk_div4", "fclk_div3",
> +	"fclk_div5"
> +};
> +
> +static u32 meson8b_mali_0_1_mux_table[] = { 0, 2, 3, 4, 5, 6, 7 };
> +
> +static struct clk_regmap meson8b_mali_0_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_MALI_CLK_CNTL,
> +		.mask = 0x7,
> +		.shift = 9,
> +		.table = meson8b_mali_0_1_mux_table,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali_0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_names = meson8b_mali_0_1_parent_names,
> +		.num_parents = ARRAY_SIZE(meson8b_mali_0_1_parent_names),
> +		/*
> +		 * Don't propagate rate changes up because the only changeable
> +		 * parents are mpll1 and mpll2 but we need those for audio and
> +		 * RGMII (Ethernet). We don't want to change the audio or
> +		 * Ethernet clocks when setting the GPU frequency.
> +		 */
> +		.flags = 0,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_mali_0_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_MALI_CLK_CNTL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali_0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_names = (const char *[]){ "mali_0_sel" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_mali_0 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_MALI_CLK_CNTL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali_0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_names = (const char *[]){ "mali_0_div" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_mali_1_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_MALI_CLK_CNTL,
> +		.mask = 0x7,
> +		.shift = 25,
> +		.table = meson8b_mali_0_1_mux_table,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali_1_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_names = meson8b_mali_0_1_parent_names,
> +		.num_parents = ARRAY_SIZE(meson8b_mali_0_1_parent_names),
> +		/*
> +		 * Don't propagate rate changes up because the only changeable
> +		 * parents are mpll1 and mpll2 but we need those for audio and
> +		 * RGMII (Ethernet). We don't want to change the audio or
> +		 * Ethernet clocks when setting the GPU frequency.
> +		 */
> +		.flags = 0,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_mali_1_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_MALI_CLK_CNTL,
> +		.shift = 16,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali_1_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_names = (const char *[]){ "mali_1_sel" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_mali_1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_MALI_CLK_CNTL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali_1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_names = (const char *[]){ "mali_1_div" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_mali = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_MALI_CLK_CNTL,
> +		.mask = 1,
> +		.shift = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_names = (const char *[]){ "mali_0", "mali_1" },
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
>  /* Everything Else (EE) domain gates */
>  
>  static MESON_GATE(meson8b_ddr, HHI_GCLK_MPEG0, 0);
> @@ -1833,6 +1962,9 @@ static struct clk_hw_onecell_data meson8_hw_onecell_data = {
>  		[CLKID_HDMI_SYS_SEL]	    = &meson8b_hdmi_sys_sel.hw,
>  		[CLKID_HDMI_SYS_DIV]	    = &meson8b_hdmi_sys_div.hw,
>  		[CLKID_HDMI_SYS]	    = &meson8b_hdmi_sys.hw,
> +		[CLKID_MALI_0_SEL]	    = &meson8b_mali_0_sel.hw,
> +		[CLKID_MALI_0_DIV]	    = &meson8b_mali_0_div.hw,
> +		[CLKID_MALI]		    = &meson8b_mali_0.hw,
>  		[CLK_NR_CLKS]		    = NULL,
>  	},
>  	.num = CLK_NR_CLKS,
> @@ -2012,6 +2144,13 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
>  		[CLKID_HDMI_SYS_SEL]	    = &meson8b_hdmi_sys_sel.hw,
>  		[CLKID_HDMI_SYS_DIV]	    = &meson8b_hdmi_sys_div.hw,
>  		[CLKID_HDMI_SYS]	    = &meson8b_hdmi_sys.hw,
> +		[CLKID_MALI_0_SEL]	    = &meson8b_mali_0_sel.hw,
> +		[CLKID_MALI_0_DIV]	    = &meson8b_mali_0_div.hw,
> +		[CLKID_MALI_0]		    = &meson8b_mali_0.hw,
> +		[CLKID_MALI_1_SEL]	    = &meson8b_mali_1_sel.hw,
> +		[CLKID_MALI_1_DIV]	    = &meson8b_mali_1_div.hw,
> +		[CLKID_MALI_1]		    = &meson8b_mali_1.hw,
> +		[CLKID_MALI]		    = &meson8b_mali.hw,
>  		[CLK_NR_CLKS]		    = NULL,
>  	},
>  	.num = CLK_NR_CLKS,
> @@ -2167,6 +2306,13 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
>  	&meson8b_hdmi_sys_sel,
>  	&meson8b_hdmi_sys_div,
>  	&meson8b_hdmi_sys,
> +	&meson8b_mali_0_sel,
> +	&meson8b_mali_0_div,
> +	&meson8b_mali_0,
> +	&meson8b_mali_1_sel,
> +	&meson8b_mali_1_div,
> +	&meson8b_mali_1,
> +	&meson8b_mali,
>  };
>  
>  static const struct meson8b_clk_reset_line {
> diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
> index 87fba739af81..f212e2304ff5 100644
> --- a/drivers/clk/meson/meson8b.h
> +++ b/drivers/clk/meson/meson8b.h
> @@ -33,6 +33,7 @@
>  #define HHI_VID_CLK_CNTL2		0x194 /* 0x65 offset in data sheet */
>  #define HHI_VID_DIVIDER_CNTL		0x198 /* 0x66 offset in data sheet */
>  #define HHI_SYS_CPU_CLK_CNTL0		0x19c /* 0x67 offset in data sheet */
> +#define HHI_MALI_CLK_CNTL		0x1b0 /* 0x6c offset in data sheet */
>  #define HHI_HDMI_CLK_CNTL		0x1cc /* 0x73 offset in data sheet */
>  #define HHI_NAND_CLK_CNTL		0x25c /* 0x97 offset in data sheet */
>  #define HHI_MPLL_CNTL			0x280 /* 0xa0 offset in data sheet */
> @@ -139,8 +140,14 @@
>  #define CLKID_HDMI_SYS_SEL	172
>  #define CLKID_HDMI_SYS_DIV	173
>  #define CLKID_HDMI_SYS		174
> +#define CLKID_MALI_0_SEL	175
> +#define CLKID_MALI_0_DIV	176
> +#define CLKID_MALI_0		177
> +#define CLKID_MALI_1_SEL	178
> +#define CLKID_MALI_1_DIV	179
> +#define CLKID_MALI_1		180
>  
> -#define CLK_NR_CLKS		175
> +#define CLK_NR_CLKS		181
>  
>  /*
>   * include the CLKID and RESETID that have
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Changing mali clock for Meson8 will be fun aswell !
How amlogic does that ? the only change the divider ?

Neil
