Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753301AbeEONdH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 09:33:07 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:28424 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752115AbeEONdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 09:33:05 -0400
Subject: Re: [PATCH v10 02/27] clk: davinci: da850-pll: change PLL0 to
 CLK_OF_DECLARE
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20180509172606.29387-1-david@lechnology.com>
 <20180509172606.29387-3-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <9203489d-0a5a-103a-67ea-d3e89bb7ebc4@ti.com>
Date: Tue, 15 May 2018 19:01:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509172606.29387-3-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 May 2018 10:55 PM, David Lechner wrote:
> +void of_da850_pll0_init(struct device_node *node)
>  {
> -	return of_davinci_pll_init(dev, dev->of_node, &da850_pll0_info,
> -				   &da850_pll0_obsclk_info,
> -				   da850_pll0_sysclk_info, 7, base, cfgchip);
> +	void __iomem *base;
> +	struct regmap *cfgchip;
> +
> +	base = of_iomap(node, 0);
> +	if (!base) {
> +		pr_err("%s: ioremap failed\n", __func__);
> +		return;
> +	}
> +
> +	cfgchip = syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");

It will be nice to handle the error case here.

> +
> +	of_davinci_pll_init(NULL, node, &da850_pll0_info,
> +			    &da850_pll0_obsclk_info,
> +			    da850_pll0_sysclk_info, 7, base, cfgchip);

Apart from that, it looks good to me.

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
