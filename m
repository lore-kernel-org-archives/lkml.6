Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeFCMoX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:44:23 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41708 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeFCMoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:44:21 -0400
X-Google-Smtp-Source: ADUXVKJvT4aM8SudJMnSNf5OryI0wTLG0eVSxucvTTf5R5iZoeZ5xKrhaRBk9SXRlRRrK+1xVCdFzi/bE4lSjS3XMec=
MIME-Version: 1.0
In-Reply-To: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>
References: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 3 Jun 2018 09:44:20 -0300
Message-ID: <CAOMZO5CmgBsaaegVV9OjdyXv5_O0V9iTS2qYbtuH26qkG2_zrA@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: imx6q: remove clks_init_on array
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
>  drivers/clk/imx/clk-imx6q.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
> index b9ea703..8754c61 100644
> --- a/drivers/clk/imx/clk-imx6q.c
> +++ b/drivers/clk/imx/clk-imx6q.c
> @@ -96,12 +96,6 @@ static const char *pll7_bypass_sels[] = { "pll7", "pll7_bypass_src", };
>  static struct clk *clk[IMX6QDL_CLK_END];
>  static struct clk_onecell_data clk_data;
>
> -static unsigned int const clks_init_on[] __initconst = {
> -       IMX6QDL_CLK_MMDC_CH0_AXI,
> -       IMX6QDL_CLK_ROM,
> -       IMX6QDL_CLK_ARM,

 IMX6QDL_CLK_ARM does not have the CLK_IS_CRITICAL flag.

Is this intended? If so, please mention in the commit log.
