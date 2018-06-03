Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeFCM6v (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:58:51 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34266 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeFCM6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:58:50 -0400
X-Google-Smtp-Source: ADUXVKIuQ1TbOwTq0mAIEwzUmqGKtGuVkYWjp2rGyQYtsKpYk46sQniFtElvC097swHvFxUfgrX7o7tb5xZh/ytnPlA=
MIME-Version: 1.0
In-Reply-To: <1527994847-2363-3-git-send-email-Anson.Huang@nxp.com>
References: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com> <1527994847-2363-3-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 3 Jun 2018 09:52:13 -0300
Message-ID: <CAOMZO5A7-P265zhzwFBMv=HzaqJwPXx9fJ6Gom4kvS1X0uZoSg@mail.gmail.com>
Subject: Re: [PATCH 3/4] clk: imx6sx: remove clks_init_on array
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, NXP Linux Team <Linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 3, 2018 at 12:00 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Clock framework will enable those clocks registered
> with CLK_IS_CRITICAL flag, so no need to have
> clks_init_on array during clock initialization now.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx6sx.c | 40 ++++++++++++++--------------------------
>  1 file changed, 14 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
> index 10c771b..aed4391 100644
> --- a/drivers/clk/imx/clk-imx6sx.c
> +++ b/drivers/clk/imx/clk-imx6sx.c
> @@ -92,14 +92,6 @@ static const char *pll7_bypass_sels[] = { "pll7", "pll7_bypass_src", };
>  static struct clk *clks[IMX6SX_CLK_CLK_END];
>  static struct clk_onecell_data clk_data;
>
> -static int const clks_init_on[] __initconst = {
> -       IMX6SX_CLK_AIPS_TZ1, IMX6SX_CLK_AIPS_TZ2, IMX6SX_CLK_AIPS_TZ3,
> -       IMX6SX_CLK_IPMUX1, IMX6SX_CLK_IPMUX2, IMX6SX_CLK_IPMUX3,
> -       IMX6SX_CLK_WAKEUP, IMX6SX_CLK_MMDC_P0_FAST, IMX6SX_CLK_MMDC_P0_IPG,
> -       IMX6SX_CLK_ROM, IMX6SX_CLK_ARM, IMX6SX_CLK_IPG, IMX6SX_CLK_OCRAM,
> -       IMX6SX_CLK_PER2_MAIN, IMX6SX_CLK_PERCLK, IMX6SX_CLK_TZASC1,
> -};


MX6SX_CLK_ARM and IMX6SX_CLK_IPG did not have the CLK_IS_CRITICAL flag.

Is this on purpose?
