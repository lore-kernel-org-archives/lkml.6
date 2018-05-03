Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeECNTo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:19:44 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:9646 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbeECNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:19:41 -0400
Subject: Re: [PATCH v9 09/27] ARM: davinci: dm644x: add new clock init using
 common clock framework
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20180427001745.4116-1-david@lechnology.com>
 <20180427001745.4116-10-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <cfce1685-296a-a669-bb7d-bf14d43004ed@ti.com>
Date: Thu, 3 May 2018 18:48:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427001745.4116-10-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 April 2018 05:47 AM, David Lechner wrote:
>  void __init dm644x_init_time(void)
>  {
> +#ifdef CONFIG_COMMON_CLK
> +	void __iomem *pll1, *psc;
> +	struct clk *clk;
> +
> +	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM644X_REF_FREQ);
> +
> +	pll1 = ioremap(DAVINCI_PLL1_BASE, SZ_1K);
> +	dm355_pll1_init(NULL, pll1, NULL);

This should be dm644x_*()

> +
> +	psc = ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
> +	dm355_psc_init(NULL, psc);

This one should be dm644x_*()

With those fixes, I was able to bootup on DM644x EVM and a visual
inspection of clock debug dump shows it remains same before and after
the conversion.

Thanks,
Sekhar
