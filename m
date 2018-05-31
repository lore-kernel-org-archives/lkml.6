Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeEaED5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 00:03:57 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:46956 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeEaEDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 00:03:52 -0400
X-Google-Smtp-Source: ADUXVKLFw9qwLZQATk4lp4WYTGBGEnFEWBbU7TmaTe9A1l4hx6ycj1WXNXgPJwZGixcudqza4v4slg==
Date: Wed, 30 May 2018 23:03:50 -0500
From: Rob Herring <robh@kernel.org>
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com,
        paul@pwsan.com, t-kristo@ti.com
Subject: Re: [PATCH v2 3/6] clk: ti: dra7: Add clkctrl clock data for the
 mcan clocks
Message-ID: <20180531040350.GA25132@rob-hp-laptop>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-4-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530141133.3711-4-faiz_abbas@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 07:41:30PM +0530, Faiz Abbas wrote:
> Add clkctrl data for the m_can clocks and register it within the
> clkctrl driver
> 
> CC: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/clk/ti/clk-7xx.c         | 1 +
>  include/dt-bindings/clock/dra7.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
> index fb249a1637a5..71a122b2dc67 100644
> --- a/drivers/clk/ti/clk-7xx.c
> +++ b/drivers/clk/ti/clk-7xx.c
> @@ -708,6 +708,7 @@ static const struct omap_clkctrl_reg_data dra7_wkupaon_clkctrl_regs[] __initcons
>  	{ DRA7_COUNTER_32K_CLKCTRL, NULL, 0, "wkupaon_iclk_mux" },
>  	{ DRA7_UART10_CLKCTRL, dra7_uart10_bit_data, CLKF_SW_SUP, "wkupaon_cm:clk:0060:24" },
>  	{ DRA7_DCAN1_CLKCTRL, dra7_dcan1_bit_data, CLKF_SW_SUP, "wkupaon_cm:clk:0068:24" },
> +	{ DRA7_ADC_CLKCTRL, NULL, CLKF_SW_SUP, "mcan_clk" },
>  	{ 0 },
>  };
>  
> diff --git a/include/dt-bindings/clock/dra7.h b/include/dt-bindings/clock/dra7.h
> index 5e1061b15aed..d7549c57cac3 100644
> --- a/include/dt-bindings/clock/dra7.h
> +++ b/include/dt-bindings/clock/dra7.h
> @@ -168,5 +168,6 @@
>  #define DRA7_COUNTER_32K_CLKCTRL	DRA7_CLKCTRL_INDEX(0x50)
>  #define DRA7_UART10_CLKCTRL	DRA7_CLKCTRL_INDEX(0x80)
>  #define DRA7_DCAN1_CLKCTRL	DRA7_CLKCTRL_INDEX(0x88)
> +#define DRA7_ADC_CLKCTRL	DRA7_CLKCTRL_INDEX(0xa0)

ADC and mcan are the same thing?

>  
>  #endif
> -- 
> 2.17.0
> 
