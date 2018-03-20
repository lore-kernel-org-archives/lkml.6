Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeCTQ5t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:57:49 -0400
Received: from vern.gendns.com ([206.190.152.46]:36630 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751411AbeCTQ5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:57:47 -0400
Subject: Re: [PATCH v8 18/42] clk: davinci: New driver for TI DA8XX CFGCHIP
 clocks
To: Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-19-git-send-email-david@lechnology.com>
 <152156485535.183971.1627687499726447092@swboyd.mtv.corp.google.com>
From: David Lechner <david@lechnology.com>
Message-ID: <b4ea5efb-3fa0-b2f3-cd5f-75343e841153@lechnology.com>
Date: Tue, 20 Mar 2018 11:57:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152156485535.183971.1627687499726447092@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/2018 11:54 AM, Stephen Boyd wrote:
> Quoting David Lechner (2018-03-15 19:52:34)
>> +
>> +typedef int (*da8xx_cfgchip_init)(struct device *dev, void __iomem *base);
> 
> Should be struct regmap *regmap?

Yes. It looks like this was copied and pasted from one of the other drivers.

Thank you for fixing it.

> 
> I've squashed this in.
> 
> diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
> index 858d3786b27b..c971111d2601 100644
> --- a/drivers/clk/davinci/da8xx-cfgchip.c
> +++ b/drivers/clk/davinci/da8xx-cfgchip.c
> @@ -736,7 +736,7 @@ static const struct platform_device_id da8xx_cfgchip_id_table[] = {
>   	{ }
>   };
>   
> -typedef int (*da8xx_cfgchip_init)(struct device *dev, void __iomem *base);
> +typedef int (*da8xx_cfgchip_init)(struct device *dev, struct regmap *regmap);
>   
>   static int da8xx_cfgchip_probe(struct platform_device *pdev)
>   {
> 
