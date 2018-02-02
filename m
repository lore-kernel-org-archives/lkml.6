Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeBBNUX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:20:23 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:26394 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeBBNUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:20:16 -0500
Subject: Re: [PATCH v6 18/41] clk: davinci: New driver for TI DA8XX CFGCHIP
 clocks
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-19-git-send-email-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <c2138795-edcd-bb7d-094d-47dc049c33df@ti.com>
Date: Fri, 2 Feb 2018 18:49:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1516468460-4908-19-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
> +static const struct clk_ops da8xx_cfgchip_div4p5_clk_ops = {
> +	.enable		= da8xx_cfgchip_gate_clk_enable,
> +	.disable	= da8xx_cfgchip_gate_clk_disable,
> +	.is_enabled	= da8xx_cfgchip_gate_clk_is_enabled,

I assume the reason for not using clk-gate.c is lack of regmap support
there?

> +	.recalc_rate	= da8xx_cfgchip_div4p5_recalc_rate,
> +};
> +
> +static struct clk * __init
> +da8xx_cfgchip_gate_clk_register(const struct da8xx_cfgchip_gate_clk_info *info,
> +				const char *parent_name,
> +				struct regmap *regmap)
> +{
> +	struct da8xx_cfgchip_gate_clk *gate;
> +	struct clk_init_data init;
> +
> +	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +	if (!gate)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = info->name;
> +	if (info->flags & DA8XX_GATE_CLOCK_IS_DIV4P5)
> +		init.ops = &da8xx_cfgchip_div4p5_clk_ops;
> +	else
> +		init.ops = &da8xx_cfgchip_gate_clk_ops;

This will be easier to read using ternary operator, I think. But you
will probably have line breaks.

Thanks,
Sekhar
