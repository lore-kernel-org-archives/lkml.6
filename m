Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758029AbeD0Mdp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 08:33:45 -0400
Received: from mout.perfora.net ([74.208.4.196]:51689 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756973AbeD0Mdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 08:33:42 -0400
Message-ID: <1524832404.6979.9.camel@ziswiler.com>
Subject: Re: [PATCH v1 1/4] clk: tegra20: Add DEV1/DEV2 OSC dividers
From: Marcel Ziswiler <marcel@ziswiler.com>
To: Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Dietrich <marvin24@gmx.de>
Cc: linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 27 Apr 2018 14:33:24 +0200
In-Reply-To: <20180426235818.10018-2-digetx@gmail.com>
References: <20180426235818.10018-1-digetx@gmail.com>
         <20180426235818.10018-2-digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:458nIBqnDm0GZF8cFHPqdGVbMH6MobpR2iGvBj8WqpdrQSzt1yz
 VRkXKlRTN1ddoUeuhTtgfbxYS0SSJBwEF3T2GNMH4pLeOV6fyBYQQF7iIvNBz+lwgUU+N06
 nIXKV/aoFBp4dPHJhwScrH4eGreZ+cstQRlJp29wmS9XsNHQJ6GRk4igTaka0xf3MpxzxVa
 N7O0EM4o/TkbcwaQISDeQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KVSplTgsK6A=:vd1Q2WTK9/V/2hD9vFNeS2
 FKC7uHXDwUpkqF+zwdPqsjbui2t8xSJbM4J+4aaWW4TnB0vSaPs+YEf+UX/uxCuJhECyqVUHO
 tq8hIqS3PKCJP8Tc65h0cwReOVlj5ZtIXHIm8Ji7hQmoC1icPgsmRHbMw5X4jOnFZ8G9BR2hc
 QqiG45FBZQwiJe3vgjw7GfnLtM52s7DpCgcX2wUx+HDHRpkFFSqH/oiolV3tEkXZ+Y/8yKCQM
 MPQOUxawG49zEqi9ASAklybVaafd2Aeu80sfJDNMxeE6mo77mwpG4fAQb82v6kqdETKnE2TgB
 XGgzlIfrFbAYJ239tYu0wPPtEqjS6w0qqd/EXBfoVkw0Q8KRVkcHZ2hjk4L2h/hbcLq26sZc3
 1uXlwpfEfJY2MBxwTqyFJ7L1XfVE4vjjbGgmLXfNKb3ntEsg3q8G7vipWkV1/nR7BWqmyFEP4
 HSkJjnJs7T5IEsU1Ufh/hPvjYsWgqUOenvofOGwykBOEGY6S8zYZ4JG3Ep0eANCuyK2Ni/IYW
 h/mEGgl5NOcDs4g8ME3FAzuhIDk+HpxVRHSc9kDiBPzkYBEpM+cWTfVKRLQWGlqv1cj6TnUQu
 N+NLp+GaXTaW1gy7qqX6uyF5LAw+MhYVuFMv1LtOceJcyeqaebDPZrBg6Abw25ZDCorKenX6d
 T/ZNRebQ84DIsYyTwRhOhcgNU6ttIssjPiUSLpY5TcGriIo2gIEYbvlsaly8k3JAyDXw2SE/7
 dujxcc4xDbzEGOq+
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry

Isn't the CLK_RST_CONTROLLER_MISC_CLK_ENB_0 the other way around e.g.
DEV1_OSC_DIV_SEL at bit 23:22 and DEV2_OSC_DIV_SEL at 21:20?

On Fri, 2018-04-27 at 02:58 +0300, Dmitry Osipenko wrote:
> CDEV1/CDEV2 clocks could have corresponding oscillator clock divider
> as
> a parent. Add these dividers in order to be able to provide that
> parent
> option.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clk/tegra/clk-tegra20.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-
> tegra20.c
> index 0ee56dd04cec..16cf4108f2ff 100644
> --- a/drivers/clk/tegra/clk-tegra20.c
> +++ b/drivers/clk/tegra/clk-tegra20.c
> @@ -26,6 +26,8 @@
>  #include "clk.h"
>  #include "clk-id.h"
>  
> +#define MISC_CLK_ENB 0x48
> +
>  #define OSC_CTRL 0x50
>  #define OSC_CTRL_OSC_FREQ_MASK (3<<30)
>  #define OSC_CTRL_OSC_FREQ_13MHZ (0<<30)
> @@ -831,6 +833,16 @@ static void __init tegra20_periph_clk_init(void)
>  				    periph_clk_enb_refcnt);
>  	clks[TEGRA20_CLK_PEX] = clk;
>  
> +	/* cdev1 OSC divider */
> +	clk_register_divider(NULL, "cdev1_osc_div", "clk_m",
> +			     0, clk_base + MISC_CLK_ENB, 20, 2,

So it would be:

+			     0, clk_base + MISC_CLK_ENB, 22, 2,

> +			     CLK_DIVIDER_POWER_OF_TWO, NULL);
> +
> +	/* cdev2 OSC divider */
> +	clk_register_divider(NULL, "cdev2_osc_div", "clk_m",
> +			     0, clk_base + MISC_CLK_ENB, 22, 2,

And:

+			     0, clk_base + MISC_CLK_ENB, 20, 2,

> +			     CLK_DIVIDER_POWER_OF_TWO, NULL);
> +
>  	/* cdev1 */
>  	clk = clk_register_fixed_rate(NULL, "cdev1_fixed", NULL, 0,
> 26000000);
>  	clk = tegra_clk_register_periph_gate("cdev1", "cdev1_fixed",
> 0,

Cheers

Marcel
