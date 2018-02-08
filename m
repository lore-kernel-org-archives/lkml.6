Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751066AbeBHJcO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:32:14 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:44081 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeBHJcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:32:10 -0500
Subject: Re: [PATCH 2/7] soc: davinci: new genpd driver
To: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180207134553.13510-1-brgl@bgdev.pl>
 <20180207134553.13510-3-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <65f2690c-c605-3c66-9d8a-9a882aaf446d@ti.com>
Date: Thu, 8 Feb 2018 15:00:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180207134553.13510-3-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 February 2018 07:15 PM, Bartosz Golaszewski wrote:
> +	/*
> +	 * DaVinci always uses a single clock for power-management. We assume
> +	 * it's the first one in the clocks property.
> +	 */
> +	clk = of_clk_get(dev->of_node, 0);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);

We already get this today with drivers/base/power/clock_ops.c once
.con_ids list is dropped from pm_clk_notifier_block (which I think it
should).

If there is no reason to introduce thus functionality at this stage,
perhaps we should wait till such a time when its clearly needed?

Thanks,
Sekhar
