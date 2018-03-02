Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936242AbeCBPna (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:43:30 -0500
Received: from gloria.sntech.de ([95.129.55.99]:34336 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935392AbeCBPn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:43:29 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        wxt@rock-chips.com, linux-rockchip@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: rockchip: power-domain: use clk_bulk APIs
Date: Fri, 02 Mar 2018 16:43:09 +0100
Message-ID: <2683576.o9hXnVZqaR@phil>
In-Reply-To: <20180228124143.8364-1-jeffy.chen@rock-chips.com>
References: <20180228124143.8364-1-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffy,

Am Mittwoch, 28. Februar 2018, 13:41:43 CET schrieb Jeffy Chen:
> Use clk_bulk APIs, and also add error handling for clk enable.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

[...]

> -	for (i = 0; i < clk_cnt; i++) {
> -		clk = of_clk_get(node, i);
> -		if (IS_ERR(clk)) {
> -			error = PTR_ERR(clk);
> +	pd->num_clks = of_count_phandle_with_args(node, "clocks",
> +						  "#clock-cells");
> +
> +	pd->clks = devm_kzalloc(pmu->dev, pd->num_clks * sizeof(pd->clks[0]),

applied for 4.17, after changing to devm_kcalloc like below:

pd->clks = devm_kcalloc(pmu->dev, pd->num_clks, sizeof(*pd->clks),


Thanks
Heiko
