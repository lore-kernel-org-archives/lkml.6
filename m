Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeEVIpC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:45:02 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:43280 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbeEVIo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:44:57 -0400
Subject: Re: [PATCH v11 01/27] clk: davinci: pll: allow dev == NULL
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20180518164829.27052-1-david@lechnology.com>
 <20180518164829.27052-2-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <fb68ea47-9d94-143d-0ee1-b7ba7da2c378@ti.com>
Date: Tue, 22 May 2018 14:13:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518164829.27052-2-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 May 2018 10:18 PM, David Lechner wrote:
> @@ -711,11 +777,11 @@ int of_davinci_pll_init(struct device *dev,
>  		int n_clks =  max_sysclk_id + 1;
>  		int i;
>  
> -		clk_data = devm_kzalloc(dev, sizeof(*clk_data), GFP_KERNEL);
> +		clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
>  		if (!clk_data)
>  			return -ENOMEM;
>  
> -		clks = devm_kmalloc_array(dev, n_clks, sizeof(*clks), GFP_KERNEL);
> +		clks = kmalloc_array(n_clks, sizeof(*clks), GFP_KERNEL);
>  		if (!clks)
>  			return -ENOMEM;

This should be:

		if (!clks) {
			kfree(clk_data);
			return -ENOMEM;
		}

With that fixed:

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
