Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932454AbeCISYx convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:24:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932087AbeCISYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:24:52 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2049921723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Rajan Vaja <rajan.vaja@xilinx.com>, mturquette@baylibre.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1520518500-5500-1-git-send-email-rajanv@xilinx.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        JOLLYS@xilinx.com, michals@xilinx.com, Rajan Vaja <rajanv@xilinx.com>
References: <1520518500-5500-1-git-send-email-rajanv@xilinx.com>
Message-ID: <152061989141.26240.15533446439693285034@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: clk-fixed-factor: Use new macro CLK_OF_DECLARE_DRIVER
Date: Fri, 09 Mar 2018 10:24:51 -0800
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajan Vaja (2018-03-08 06:15:00)
> Fixed factor clock has two initialization at of_clk_init()
> time and also during platform driver probe. So declare the
> fixed factor clock with CLK_OF_DECLARE_DRIVER instead of
> CLK_OF_DECLARE.
> 
> See below commit for reference:
> "clk: sunxi: apb0: Use new macro CLK_OF_DECLARE_DRIVER"
> (sha1: 915128b621a05c63fa58ca9e4cbdf394bbe592f3)
> 
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Suggested-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  drivers/clk/clk-fixed-factor.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
> index a5d402d..d72ef2d 100644
> --- a/drivers/clk/clk-fixed-factor.c
> +++ b/drivers/clk/clk-fixed-factor.c
> @@ -196,8 +196,9 @@ void __init of_fixed_factor_clk_setup(struct device_node *node)
>  {
>         _of_fixed_factor_clk_setup(node);
>  }
> -CLK_OF_DECLARE(fixed_factor_clk, "fixed-factor-clock",
> -               of_fixed_factor_clk_setup);
> +
> +CLK_OF_DECLARE_DRIVER(fixed_factor_clk, "fixed-factor-clock",
> +                     of_fixed_factor_clk_setup);
> 

Is the intent to register the clk twice? I believe things are working as
intended without this patch, so maybe you can explain a little more what
you're trying to fix.
