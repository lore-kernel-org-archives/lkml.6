Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4051C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF1B2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="L6N+6ZG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF1B2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLKJS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:18:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36694 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeLKJS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:18:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id a18so1408049wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=b50lWC15gu8mZDu9jZhiwWvJxx3xcw0xuUKOWXm5NRc=;
        b=L6N+6ZG6W9hMLvT1Nw1HM6IhHU/4s9e0jw082cm6BzYDOdrmSoW7qPMUH2pMS444ml
         t81lCRMmEZagdn177RSuYzpMwHcPygh0Wy7D17npB90O7V8n+e9KL6AlAUb/6s1M84Q3
         snPWAx834vWzKIUEFmDATA9KSkk8E9TOF/BYf/oy0UpfjBi3ABa26oKKCQXfx7ZYbNq1
         qFxVyOptqDAAhsPNzOnfw1UccOEbHjuPbtqDSwbgQyMIfVEc3P4MNufL8SicvY/vERiL
         hPAUU/3/KuK3Ry3g0tj60AE0iAe9Nzd9LAbzXsv91pudrqAGrcrHMJBkHiF2RBDTfk6+
         E3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=b50lWC15gu8mZDu9jZhiwWvJxx3xcw0xuUKOWXm5NRc=;
        b=jtZz4k470HhTx3vrEShDnRahBAAvGfjBbNpu4cYSTBGgUAIVjgMRdvUujGweoh/f8R
         o4JCrH0EmWLsQlXGwD95melHewUYuODy0XCJXHDxtWd6oDJISmdUwIgjNG5Eq8lJeACB
         N2i3w/tPht/g/Ju6ro+PSaqBka3EceZtmHiYhlRWHw1XgwAsRPgG5iu8+vSRPAOg/Qsb
         BcC0UXWqbi52B2o3xLoyDLqnjPU8KxmTWOQkXJ8pg1q0T+BI1KRzxB4SP4AgJ3ClLPrD
         K5/vdM7Cba8eE1QHVZHEI4e8R0MyG44KPCGkY5GWgJI6efWs9KlyFmDp2Y87CAPKRsKt
         HHBA==
X-Gm-Message-State: AA+aEWb4TtMABWty0rHgGQVJPxXeEMcKu+FCV+7QsQU2t0dMW2hGqX4e
        f9FKMMwmeTAt6jl+02SYlXKlag==
X-Google-Smtp-Source: AFSGD/XnPh88ZQiSgA8O7NSdmcvIOrnYTSVikpcQGR30XhOr7w94cs34faXUcmiR0eR/HAALbRJbTA==
X-Received: by 2002:a1c:6a09:: with SMTP id f9mr1613371wmc.150.1544519903914;
        Tue, 11 Dec 2018 01:18:23 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:a5f8:3197:dbfa:c157? ([2a01:cb1d:4ce:ea00:a5f8:3197:dbfa:c157])
        by smtp.gmail.com with ESMTPSA id y1sm1162297wme.1.2018.12.11.01.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 01:18:23 -0800 (PST)
Subject: Re: [PATCH 2/5] clk: meson: meson8b: use a separate clock table for
 Meson8
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, khilman@baylibre.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sboyd@kernel.org, mturquette@baylibre.com
References: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
 <20181208171247.22238-3-martin.blumenstingl@googlemail.com>
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
Message-ID: <91b498fd-f09c-e877-f14b-2f21529d7cb0@baylibre.com>
Date:   Tue, 11 Dec 2018 10:18:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181208171247.22238-3-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2018 18:12, Martin Blumenstingl wrote:
> The Meson8 SoC is slightly different compared to Meson8b and Meson8m2
> because it does not have the glitch-free Mali GPU clock mux. For Meson8b
> and Meson8m2 there are currently no known differences.
> 
> Add a separate clk_hw_onecell_data table for Meson8 so these differences
> can be implemented. For now meson8_hw_onecell_data is a clone of our
> existing meson8b_hw_onecell_data.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/meson8b.c | 203 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 197 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index 950d0e548c75..0b9353d8d4fd 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -1659,6 +1659,185 @@ static MESON_GATE(meson8b_ao_ahb_sram, HHI_GCLK_AO, 1);
>  static MESON_GATE(meson8b_ao_ahb_bus, HHI_GCLK_AO, 2);
>  static MESON_GATE(meson8b_ao_iface, HHI_GCLK_AO, 3);
>  
> +static struct clk_hw_onecell_data meson8_hw_onecell_data = {
> +	.hws = {
> +		[CLKID_XTAL] = &meson8b_xtal.hw,
> +		[CLKID_PLL_FIXED] = &meson8b_fixed_pll.hw,
> +		[CLKID_PLL_VID] = &meson8b_vid_pll.hw,
> +		[CLKID_PLL_SYS] = &meson8b_sys_pll.hw,
> +		[CLKID_FCLK_DIV2] = &meson8b_fclk_div2.hw,
> +		[CLKID_FCLK_DIV3] = &meson8b_fclk_div3.hw,
> +		[CLKID_FCLK_DIV4] = &meson8b_fclk_div4.hw,
> +		[CLKID_FCLK_DIV5] = &meson8b_fclk_div5.hw,
> +		[CLKID_FCLK_DIV7] = &meson8b_fclk_div7.hw,
> +		[CLKID_CPUCLK] = &meson8b_cpu_clk.hw,
> +		[CLKID_MPEG_SEL] = &meson8b_mpeg_clk_sel.hw,
> +		[CLKID_MPEG_DIV] = &meson8b_mpeg_clk_div.hw,
> +		[CLKID_CLK81] = &meson8b_clk81.hw,
> +		[CLKID_DDR]		    = &meson8b_ddr.hw,
> +		[CLKID_DOS]		    = &meson8b_dos.hw,
> +		[CLKID_ISA]		    = &meson8b_isa.hw,
> +		[CLKID_PL301]		    = &meson8b_pl301.hw,
> +		[CLKID_PERIPHS]		    = &meson8b_periphs.hw,
> +		[CLKID_SPICC]		    = &meson8b_spicc.hw,
> +		[CLKID_I2C]		    = &meson8b_i2c.hw,
> +		[CLKID_SAR_ADC]		    = &meson8b_sar_adc.hw,
> +		[CLKID_SMART_CARD]	    = &meson8b_smart_card.hw,
> +		[CLKID_RNG0]		    = &meson8b_rng0.hw,
> +		[CLKID_UART0]		    = &meson8b_uart0.hw,
> +		[CLKID_SDHC]		    = &meson8b_sdhc.hw,
> +		[CLKID_STREAM]		    = &meson8b_stream.hw,
> +		[CLKID_ASYNC_FIFO]	    = &meson8b_async_fifo.hw,
> +		[CLKID_SDIO]		    = &meson8b_sdio.hw,
> +		[CLKID_ABUF]		    = &meson8b_abuf.hw,
> +		[CLKID_HIU_IFACE]	    = &meson8b_hiu_iface.hw,
> +		[CLKID_ASSIST_MISC]	    = &meson8b_assist_misc.hw,
> +		[CLKID_SPI]		    = &meson8b_spi.hw,
> +		[CLKID_I2S_SPDIF]	    = &meson8b_i2s_spdif.hw,
> +		[CLKID_ETH]		    = &meson8b_eth.hw,
> +		[CLKID_DEMUX]		    = &meson8b_demux.hw,
> +		[CLKID_AIU_GLUE]	    = &meson8b_aiu_glue.hw,
> +		[CLKID_IEC958]		    = &meson8b_iec958.hw,
> +		[CLKID_I2S_OUT]		    = &meson8b_i2s_out.hw,
> +		[CLKID_AMCLK]		    = &meson8b_amclk.hw,
> +		[CLKID_AIFIFO2]		    = &meson8b_aififo2.hw,
> +		[CLKID_MIXER]		    = &meson8b_mixer.hw,
> +		[CLKID_MIXER_IFACE]	    = &meson8b_mixer_iface.hw,
> +		[CLKID_ADC]		    = &meson8b_adc.hw,
> +		[CLKID_BLKMV]		    = &meson8b_blkmv.hw,
> +		[CLKID_AIU]		    = &meson8b_aiu.hw,
> +		[CLKID_UART1]		    = &meson8b_uart1.hw,
> +		[CLKID_G2D]		    = &meson8b_g2d.hw,
> +		[CLKID_USB0]		    = &meson8b_usb0.hw,
> +		[CLKID_USB1]		    = &meson8b_usb1.hw,
> +		[CLKID_RESET]		    = &meson8b_reset.hw,
> +		[CLKID_NAND]		    = &meson8b_nand.hw,
> +		[CLKID_DOS_PARSER]	    = &meson8b_dos_parser.hw,
> +		[CLKID_USB]		    = &meson8b_usb.hw,
> +		[CLKID_VDIN1]		    = &meson8b_vdin1.hw,
> +		[CLKID_AHB_ARB0]	    = &meson8b_ahb_arb0.hw,
> +		[CLKID_EFUSE]		    = &meson8b_efuse.hw,
> +		[CLKID_BOOT_ROM]	    = &meson8b_boot_rom.hw,
> +		[CLKID_AHB_DATA_BUS]	    = &meson8b_ahb_data_bus.hw,
> +		[CLKID_AHB_CTRL_BUS]	    = &meson8b_ahb_ctrl_bus.hw,
> +		[CLKID_HDMI_INTR_SYNC]	    = &meson8b_hdmi_intr_sync.hw,
> +		[CLKID_HDMI_PCLK]	    = &meson8b_hdmi_pclk.hw,
> +		[CLKID_USB1_DDR_BRIDGE]	    = &meson8b_usb1_ddr_bridge.hw,
> +		[CLKID_USB0_DDR_BRIDGE]	    = &meson8b_usb0_ddr_bridge.hw,
> +		[CLKID_MMC_PCLK]	    = &meson8b_mmc_pclk.hw,
> +		[CLKID_DVIN]		    = &meson8b_dvin.hw,
> +		[CLKID_UART2]		    = &meson8b_uart2.hw,
> +		[CLKID_SANA]		    = &meson8b_sana.hw,
> +		[CLKID_VPU_INTR]	    = &meson8b_vpu_intr.hw,
> +		[CLKID_SEC_AHB_AHB3_BRIDGE] = &meson8b_sec_ahb_ahb3_bridge.hw,
> +		[CLKID_CLK81_A9]	    = &meson8b_clk81_a9.hw,
> +		[CLKID_VCLK2_VENCI0]	    = &meson8b_vclk2_venci0.hw,
> +		[CLKID_VCLK2_VENCI1]	    = &meson8b_vclk2_venci1.hw,
> +		[CLKID_VCLK2_VENCP0]	    = &meson8b_vclk2_vencp0.hw,
> +		[CLKID_VCLK2_VENCP1]	    = &meson8b_vclk2_vencp1.hw,
> +		[CLKID_GCLK_VENCI_INT]	    = &meson8b_gclk_venci_int.hw,
> +		[CLKID_GCLK_VENCP_INT]	    = &meson8b_gclk_vencp_int.hw,
> +		[CLKID_DAC_CLK]		    = &meson8b_dac_clk.hw,
> +		[CLKID_AOCLK_GATE]	    = &meson8b_aoclk_gate.hw,
> +		[CLKID_IEC958_GATE]	    = &meson8b_iec958_gate.hw,
> +		[CLKID_ENC480P]		    = &meson8b_enc480p.hw,
> +		[CLKID_RNG1]		    = &meson8b_rng1.hw,
> +		[CLKID_GCLK_VENCL_INT]	    = &meson8b_gclk_vencl_int.hw,
> +		[CLKID_VCLK2_VENCLMCC]	    = &meson8b_vclk2_venclmcc.hw,
> +		[CLKID_VCLK2_VENCL]	    = &meson8b_vclk2_vencl.hw,
> +		[CLKID_VCLK2_OTHER]	    = &meson8b_vclk2_other.hw,
> +		[CLKID_EDP]		    = &meson8b_edp.hw,
> +		[CLKID_AO_MEDIA_CPU]	    = &meson8b_ao_media_cpu.hw,
> +		[CLKID_AO_AHB_SRAM]	    = &meson8b_ao_ahb_sram.hw,
> +		[CLKID_AO_AHB_BUS]	    = &meson8b_ao_ahb_bus.hw,
> +		[CLKID_AO_IFACE]	    = &meson8b_ao_iface.hw,
> +		[CLKID_MPLL0]		    = &meson8b_mpll0.hw,
> +		[CLKID_MPLL1]		    = &meson8b_mpll1.hw,
> +		[CLKID_MPLL2]		    = &meson8b_mpll2.hw,
> +		[CLKID_MPLL0_DIV]	    = &meson8b_mpll0_div.hw,
> +		[CLKID_MPLL1_DIV]	    = &meson8b_mpll1_div.hw,
> +		[CLKID_MPLL2_DIV]	    = &meson8b_mpll2_div.hw,
> +		[CLKID_CPU_IN_SEL]	    = &meson8b_cpu_in_sel.hw,
> +		[CLKID_CPU_IN_DIV2]	    = &meson8b_cpu_in_div2.hw,
> +		[CLKID_CPU_IN_DIV3]	    = &meson8b_cpu_in_div3.hw,
> +		[CLKID_CPU_SCALE_DIV]	    = &meson8b_cpu_scale_div.hw,
> +		[CLKID_CPU_SCALE_OUT_SEL]   = &meson8b_cpu_scale_out_sel.hw,
> +		[CLKID_MPLL_PREDIV]	    = &meson8b_mpll_prediv.hw,
> +		[CLKID_FCLK_DIV2_DIV]	    = &meson8b_fclk_div2_div.hw,
> +		[CLKID_FCLK_DIV3_DIV]	    = &meson8b_fclk_div3_div.hw,
> +		[CLKID_FCLK_DIV4_DIV]	    = &meson8b_fclk_div4_div.hw,
> +		[CLKID_FCLK_DIV5_DIV]	    = &meson8b_fclk_div5_div.hw,
> +		[CLKID_FCLK_DIV7_DIV]	    = &meson8b_fclk_div7_div.hw,
> +		[CLKID_NAND_SEL]	    = &meson8b_nand_clk_sel.hw,
> +		[CLKID_NAND_DIV]	    = &meson8b_nand_clk_div.hw,
> +		[CLKID_NAND_CLK]	    = &meson8b_nand_clk_gate.hw,
> +		[CLKID_PLL_FIXED_DCO]	    = &meson8b_fixed_pll_dco.hw,
> +		[CLKID_HDMI_PLL_DCO]	    = &meson8b_hdmi_pll_dco.hw,
> +		[CLKID_PLL_SYS_DCO]	    = &meson8b_sys_pll_dco.hw,
> +		[CLKID_CPU_CLK_DIV2]	    = &meson8b_cpu_clk_div2.hw,
> +		[CLKID_CPU_CLK_DIV3]	    = &meson8b_cpu_clk_div3.hw,
> +		[CLKID_CPU_CLK_DIV4]	    = &meson8b_cpu_clk_div4.hw,
> +		[CLKID_CPU_CLK_DIV5]	    = &meson8b_cpu_clk_div5.hw,
> +		[CLKID_CPU_CLK_DIV6]	    = &meson8b_cpu_clk_div6.hw,
> +		[CLKID_CPU_CLK_DIV7]	    = &meson8b_cpu_clk_div7.hw,
> +		[CLKID_CPU_CLK_DIV8]	    = &meson8b_cpu_clk_div8.hw,
> +		[CLKID_ABP_SEL]		    = &meson8b_abp_clk_sel.hw,
> +		[CLKID_ABP]		    = &meson8b_abp_clk_gate.hw,
> +		[CLKID_PERIPH_SEL]	    = &meson8b_periph_clk_sel.hw,
> +		[CLKID_PERIPH]		    = &meson8b_periph_clk_gate.hw,
> +		[CLKID_AXI_SEL]		    = &meson8b_axi_clk_sel.hw,
> +		[CLKID_AXI]		    = &meson8b_axi_clk_gate.hw,
> +		[CLKID_L2_DRAM_SEL]	    = &meson8b_l2_dram_clk_sel.hw,
> +		[CLKID_L2_DRAM]		    = &meson8b_l2_dram_clk_gate.hw,
> +		[CLKID_HDMI_PLL_LVDS_OUT]   = &meson8b_hdmi_pll_lvds_out.hw,
> +		[CLKID_HDMI_PLL_HDMI_OUT]   = &meson8b_hdmi_pll_hdmi_out.hw,
> +		[CLKID_VID_PLL_IN_SEL]	    = &meson8b_vid_pll_in_sel.hw,
> +		[CLKID_VID_PLL_IN_EN]	    = &meson8b_vid_pll_in_en.hw,
> +		[CLKID_VID_PLL_PRE_DIV]	    = &meson8b_vid_pll_pre_div.hw,
> +		[CLKID_VID_PLL_POST_DIV]    = &meson8b_vid_pll_post_div.hw,
> +		[CLKID_VID_PLL_FINAL_DIV]   = &meson8b_vid_pll_final_div.hw,
> +		[CLKID_VCLK_IN_SEL]	    = &meson8b_vclk_in_sel.hw,
> +		[CLKID_VCLK_IN_EN]	    = &meson8b_vclk_in_en.hw,
> +		[CLKID_VCLK_DIV1]	    = &meson8b_vclk_div1_gate.hw,
> +		[CLKID_VCLK_DIV2_DIV]	    = &meson8b_vclk_div2_div.hw,
> +		[CLKID_VCLK_DIV2]	    = &meson8b_vclk_div2_div_gate.hw,
> +		[CLKID_VCLK_DIV4_DIV]	    = &meson8b_vclk_div4_div.hw,
> +		[CLKID_VCLK_DIV4]	    = &meson8b_vclk_div4_div_gate.hw,
> +		[CLKID_VCLK_DIV6_DIV]	    = &meson8b_vclk_div6_div.hw,
> +		[CLKID_VCLK_DIV6]	    = &meson8b_vclk_div6_div_gate.hw,
> +		[CLKID_VCLK_DIV12_DIV]	    = &meson8b_vclk_div12_div.hw,
> +		[CLKID_VCLK_DIV12]	    = &meson8b_vclk_div12_div_gate.hw,
> +		[CLKID_VCLK2_IN_SEL]	    = &meson8b_vclk2_in_sel.hw,
> +		[CLKID_VCLK2_IN_EN]	    = &meson8b_vclk2_clk_in_en.hw,
> +		[CLKID_VCLK2_DIV1]	    = &meson8b_vclk2_div1_gate.hw,
> +		[CLKID_VCLK2_DIV2_DIV]	    = &meson8b_vclk2_div2_div.hw,
> +		[CLKID_VCLK2_DIV2]	    = &meson8b_vclk2_div2_div_gate.hw,
> +		[CLKID_VCLK2_DIV4_DIV]	    = &meson8b_vclk2_div4_div.hw,
> +		[CLKID_VCLK2_DIV4]	    = &meson8b_vclk2_div4_div_gate.hw,
> +		[CLKID_VCLK2_DIV6_DIV]	    = &meson8b_vclk2_div6_div.hw,
> +		[CLKID_VCLK2_DIV6]	    = &meson8b_vclk2_div6_div_gate.hw,
> +		[CLKID_VCLK2_DIV12_DIV]	    = &meson8b_vclk2_div12_div.hw,
> +		[CLKID_VCLK2_DIV12]	    = &meson8b_vclk2_div12_div_gate.hw,
> +		[CLKID_CTS_ENCT_SEL]	    = &meson8b_cts_enct_sel.hw,
> +		[CLKID_CTS_ENCT]	    = &meson8b_cts_enct.hw,
> +		[CLKID_CTS_ENCP_SEL]	    = &meson8b_cts_encp_sel.hw,
> +		[CLKID_CTS_ENCP]	    = &meson8b_cts_encp.hw,
> +		[CLKID_CTS_ENCI_SEL]	    = &meson8b_cts_enci_sel.hw,
> +		[CLKID_CTS_ENCI]	    = &meson8b_cts_enci.hw,
> +		[CLKID_HDMI_TX_PIXEL_SEL]   = &meson8b_hdmi_tx_pixel_sel.hw,
> +		[CLKID_HDMI_TX_PIXEL]	    = &meson8b_hdmi_tx_pixel.hw,
> +		[CLKID_CTS_ENCL_SEL]	    = &meson8b_cts_encl_sel.hw,
> +		[CLKID_CTS_ENCL]	    = &meson8b_cts_encl.hw,
> +		[CLKID_CTS_VDAC0_SEL]	    = &meson8b_cts_vdac0_sel.hw,
> +		[CLKID_CTS_VDAC0]	    = &meson8b_cts_vdac0.hw,
> +		[CLKID_HDMI_SYS_SEL]	    = &meson8b_hdmi_sys_sel.hw,
> +		[CLKID_HDMI_SYS_DIV]	    = &meson8b_hdmi_sys_div.hw,
> +		[CLKID_HDMI_SYS]	    = &meson8b_hdmi_sys.hw,
> +		[CLK_NR_CLKS]		    = NULL,
> +	},
> +	.num = CLK_NR_CLKS,
> +};
> +
>  static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
>  	.hws = {
>  		[CLKID_XTAL] = &meson8b_xtal.hw,
> @@ -2132,7 +2311,6 @@ static int meson8b_cpu_clk_notifier_cb(struct notifier_block *nb,
>  
>  static struct meson8b_nb_data meson8b_cpu_nb_data = {
>  	.nb.notifier_call = meson8b_cpu_clk_notifier_cb,
> -	.onecell_data = &meson8b_hw_onecell_data,
>  };
>  
>  static const struct regmap_config clkc_regmap_config = {
> @@ -2141,7 +2319,8 @@ static const struct regmap_config clkc_regmap_config = {
>  	.reg_stride     = 4,
>  };
>  
> -static void __init meson8b_clkc_init(struct device_node *np)
> +static void __init meson8b_clkc_init_common(struct device_node *np,
> +			struct clk_hw_onecell_data *clk_hw_onecell_data)
>  {
>  	struct meson8b_clk_reset *rstc;
>  	const char *notifier_clk_name;
> @@ -2192,14 +2371,16 @@ static void __init meson8b_clkc_init(struct device_node *np)
>  	 */
>  	for (i = CLKID_XTAL; i < CLK_NR_CLKS; i++) {
>  		/* array might be sparse */
> -		if (!meson8b_hw_onecell_data.hws[i])
> +		if (!clk_hw_onecell_data->hws[i])
>  			continue;
>  
> -		ret = clk_hw_register(NULL, meson8b_hw_onecell_data.hws[i]);
> +		ret = clk_hw_register(NULL, clk_hw_onecell_data->hws[i]);
>  		if (ret)
>  			return;
>  	}
>  
> +	meson8b_cpu_nb_data.onecell_data = clk_hw_onecell_data;
> +
>  	/*
>  	 * FIXME we shouldn't program the muxes in notifier handlers. The
>  	 * tricky programming sequence will be handled by the forthcoming
> @@ -2215,13 +2396,23 @@ static void __init meson8b_clkc_init(struct device_node *np)
>  	}
>  
>  	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
> -				     &meson8b_hw_onecell_data);
> +				     clk_hw_onecell_data);
>  	if (ret)
>  		pr_err("%s: failed to register clock provider\n", __func__);
>  }
>  
> +static void __init meson8_clkc_init(struct device_node *np)
> +{
> +	return meson8b_clkc_init_common(np, &meson8_hw_onecell_data);
> +}
> +
> +static void __init meson8b_clkc_init(struct device_node *np)
> +{
> +	return meson8b_clkc_init_common(np, &meson8b_hw_onecell_data);
> +}
> +
>  CLK_OF_DECLARE_DRIVER(meson8_clkc, "amlogic,meson8-clkc",
> -		      meson8b_clkc_init);
> +		      meson8_clkc_init);
>  CLK_OF_DECLARE_DRIVER(meson8b_clkc, "amlogic,meson8b-clkc",
>  		      meson8b_clkc_init);
>  CLK_OF_DECLARE_DRIVER(meson8m2_clkc, "amlogic,meson8m2-clkc",
> 

This would happen one day !

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Neil
