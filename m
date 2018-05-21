Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbeEUEeC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 00:34:02 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46220 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbeEUEd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 00:33:58 -0400
X-Google-Smtp-Source: AB8JxZoY5LydcWa5wwpVSD2HP7d5Ub6XV3SeXMMcsu+LDpAGM11ePl+R57Agii0TXZGLyf5Ek5RTZt49xxKN2wQ6+vE=
MIME-Version: 1.0
In-Reply-To: <1526633822-17138-1-git-send-email-mine260309@gmail.com>
References: <1526633822-17138-1-git-send-email-mine260309@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 21 May 2018 14:03:36 +0930
X-Google-Sender-Auth: cbTrqK__Re9bMdpidLUn6jF5OA0
Message-ID: <CACPK8XeBXZQVgjZw6AnkMLSBn40Qvv-TXCQiD=n4xouxU-HskA@mail.gmail.com>
Subject: Re: [PATCH] clk: aspeed: Add 24MHz fixed clock
To: Lei YU <mine260309@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 May 2018 at 18:27, Lei YU <mine260309@gmail.com> wrote:
> Add a 24MHz fixed clock.
> This clock will be used for certain devices, e.g. pwm.
>
> Signed-off-by: Lei YU <mine260309@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel

> ---
>  drivers/clk/clk-aspeed.c                 | 9 ++++++++-
>  include/dt-bindings/clock/aspeed-clock.h | 1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index 5eb50c3..4664088 100644
> --- a/drivers/clk/clk-aspeed.c
> +++ b/drivers/clk/clk-aspeed.c
> @@ -14,7 +14,7 @@
>
>  #include <dt-bindings/clock/aspeed-clock.h>
>
> -#define ASPEED_NUM_CLKS                35
> +#define ASPEED_NUM_CLKS                36
>
>  #define ASPEED_RESET_CTRL      0x04
>  #define ASPEED_CLK_SELECTION   0x08
> @@ -474,6 +474,13 @@ static int aspeed_clk_probe(struct platform_device *pdev)
>                 return PTR_ERR(hw);
>         aspeed_clk_data->hws[ASPEED_CLK_BCLK] = hw;
>
> +       /* Fixed 24MHz clock */
> +       hw = clk_hw_register_fixed_rate(NULL, "fixed-24m", "clkin",
> +                                       0, 24000000);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_clk_data->hws[ASPEED_CLK_24M] = hw;
> +
>         /*
>          * TODO: There are a number of clocks that not included in this driver
>          * as more information is required:
> diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
> index d3558d8..ff29d8e 100644
> --- a/include/dt-bindings/clock/aspeed-clock.h
> +++ b/include/dt-bindings/clock/aspeed-clock.h
> @@ -38,6 +38,7 @@
>  #define ASPEED_CLK_MAC                 32
>  #define ASPEED_CLK_BCLK                        33
>  #define ASPEED_CLK_MPLL                        34
> +#define ASPEED_CLK_24M                 35
>
>  #define ASPEED_RESET_XDMA              0
>  #define ASPEED_RESET_MCTP              1
> --
> 2.7.4
>
