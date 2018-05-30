Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932125AbeE3RWo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 13:22:44 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36490 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932099AbeE3RWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 13:22:43 -0400
X-Google-Smtp-Source: ADUXVKLmwqjgpEkmhCxTxzn9yScF5mMgLYMWNaQvWHBMM/7ZsoXolNp9w4JOMkflJ7sfFCPwmIYm9w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: David Lechner <david@lechnology.com>, Stephen Boyd <sboyd@kernel.org>
From: Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <20180525181150.17873-5-david@lechnology.com>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
References: <20180525181150.17873-1-david@lechnology.com>
 <20180525181150.17873-5-david@lechnology.com>
Message-ID: <20180530172239.982.48723@harbor.lan>
User-Agent: alot/0.7
Subject: Re: [PATCH 4/9] clk: davinci: pll-dm646x: keep PLL2 SYSCLK1 always enabled
Date: Wed, 30 May 2018 10:22:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4UHNKXg002958

Quoting David Lechner (2018-05-25 11:11:45)
> From: Sekhar Nori <nsekhar@ti.com>
> 
> PLL2 SYSCLK1 on DM646x is connected to DDR2 PHY and cannot
> be disabled. Mark it so to prevent unused clock disable
> infrastructure from disabling it.
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> ---
>  drivers/clk/davinci/pll-dm646x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/davinci/pll-dm646x.c b/drivers/clk/davinci/pll-dm646x.c
> index a61cc3256418..0ae827e3ce80 100644
> --- a/drivers/clk/davinci/pll-dm646x.c
> +++ b/drivers/clk/davinci/pll-dm646x.c
> @@ -72,7 +72,7 @@ static const struct davinci_pll_clk_info dm646x_pll2_info = {
>         .flags = 0,
>  };
>  
> -SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, 0);
> +SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, SYSCLK_ALWAYS_ENABLED);

Nitpick: I dislike setting a platform-specific flag that just sets a
framework-specific flag during clk registration.

I know there is some legacy here so I'll take this patch as-is, but
perhaps cleaning this up to directly use CLK_IS_CRITICAL can be added to
someone's todo list?

Thanks,
Mike

>  
>  int dm646x_pll2_init(struct device *dev, void __iomem *base)
>  {
> -- 
> 2.17.0
> 
