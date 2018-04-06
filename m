Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbeDFUH5 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 16:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751494AbeDFUHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 16:07:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CFC20CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Carlo Caione <carlo@caione.org>, Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Yixun Lan <yixun.lan@amlogic.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180328025050.221585-5-yixun.lan@amlogic.com>
Cc: Qiufang Dai <qiufang.dai@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180328025050.221585-1-yixun.lan@amlogic.com>
 <20180328025050.221585-5-yixun.lan@amlogic.com>
Message-ID: <152304527293.94378.2019634000949753214@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 4/6] clk: meson-axg: Add AO Clock and Reset controller driver
Date: Fri, 06 Apr 2018 13:07:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yixun Lan (2018-03-27 19:50:48)
> +       [CLKID_AO_SAR_ADC_CLK]  = &axg_saradc_gate,
> +};
> +
> +static struct clk_hw_onecell_data axg_aoclk_onecell_data = {

const?

> +       .hws = {
> +               [CLKID_AO_REMOTE]       = &remote_ao.hw,
> +               [CLKID_AO_I2C_MASTER]   = &i2c_master_ao.hw,
> +               [CLKID_AO_I2C_SLAVE]    = &i2c_slave_ao.hw,
> +               [CLKID_AO_UART1]        = &uart1_ao.hw,
> +               [CLKID_AO_UART2]        = &uart2_ao.hw,
> +               [CLKID_AO_IR_BLASTER]   = &ir_blaster_ao.hw,
> +               [CLKID_AO_SAR_ADC]      = &saradc_ao.hw,
> +               [CLKID_AO_CLK81]        = &ao_clk81.hw,
> +               [CLKID_AO_SAR_ADC_SEL]  = &axg_saradc_mux.hw,
> +               [CLKID_AO_SAR_ADC_DIV]  = &axg_saradc_div.hw,
> +               [CLKID_AO_SAR_ADC_CLK]  = &axg_saradc_gate.hw,
> +       },
> +       .num = NR_CLKS,
> +};
> +
> +static struct meson_aoclk_data axg_aoclkc_data = {

const?

> +       .reset_reg      = AO_RTI_GEN_CNTL_REG0,
> +       .num_reset      = ARRAY_SIZE(axg_aoclk_reset),
> +       .reset          = axg_aoclk_reset,
> +       .num_clks       = ARRAY_SIZE(axg_aoclk_regmap),
> +       .clks           = axg_aoclk_regmap,
> +       .hw_data        = &axg_aoclk_onecell_data,
> +};
