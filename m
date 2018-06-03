Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbeFCMRM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:17:12 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:45210 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbeFCMRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:17:11 -0400
X-Google-Smtp-Source: ADUXVKJF/qinF2yOi+oSdFs7pRXs1IVBsNGWAJwjHS7xLUi+voiqFj4LYOj65BFLXc+Y34JV9Hm6UQfHHs0oArvK8os=
MIME-Version: 1.0
In-Reply-To: <1527994847-2363-2-git-send-email-Anson.Huang@nxp.com>
References: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com> <1527994847-2363-2-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 3 Jun 2018 09:17:09 -0300
Message-ID: <CAOMZO5Af_Wdp=MNR28v3ALiguxQSQv4x2Zf224FXSiEGtP68Bw@mail.gmail.com>
Subject: Re: [PATCH 2/4] clk: imx6sl: remove clks_init_on array
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

Hi Anson,

On Sun, Jun 3, 2018 at 12:00 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Clock framework will enable those clocks registered
> with CLK_IS_CRITICAL flag, so no need to have
> clks_init_on array during clock initialization now.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx6sl.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
> index 66b1dd1..eb6bcbf 100644
> --- a/drivers/clk/imx/clk-imx6sl.c
> +++ b/drivers/clk/imx/clk-imx6sl.c
> @@ -104,10 +104,6 @@ static struct clk_onecell_data clk_data;
>  static void __iomem *ccm_base;
>  static void __iomem *anatop_base;
>
> -static const u32 clks_init_on[] __initconst = {
> -       IMX6SL_CLK_IPG, IMX6SL_CLK_ARM, IMX6SL_CLK_MMDC_ROOT,
> -};

It looks like you missed to pass the CLK_IS_CRITICAL flag to these clocks.
