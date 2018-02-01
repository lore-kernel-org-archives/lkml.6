Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeBAJSr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 04:18:47 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:19008 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbeBAJSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 04:18:44 -0500
Subject: Re: [PATCH v6 05/41] clk: davinci: Add platform information for TI
 DM355 PLL
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-6-git-send-email-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <53126e1f-cd75-ea19-ed72-8956adaa1547@ti.com>
Date: Thu, 1 Feb 2018 14:47:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1516468460-4908-6-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
> +void __init dm355_pll_clk_init(void __iomem *pll1, void __iomem *pll2)
> +{
> +	const struct davinci_pll_sysclk_info *info;
> +
> +	davinci_pll_clk_register(&dm355_pll1_info, "ref_clk", pll1);
> +
> +	for (info = dm355_pll1_sysclk_info; info->name; info++)
> +		davinci_pll_sysclk_register(info, pll1);
> +
> +	davinci_pll_auxclk_register("pll1_auxclk", pll1);
> +
> +	davinci_pll_sysclkbp_clk_register("pll1_sysclkbp", pll1);
> +
> +	davinci_pll_clk_register(&dm355_pll2_info, "oscin", pll2);

Even on DM355, both PLLs accept reference clock from the same input. So
this can be "ref_clk" as well.

Rest of it looks good to me (and thanks for looking up the data manual
for accurate PLLM max and min settings).

Regards,
Sekhar
