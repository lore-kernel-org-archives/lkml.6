Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758337AbeD0NAj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:00:39 -0400
Received: from mout.perfora.net ([74.208.4.196]:35085 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758319AbeD0NAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:00:37 -0400
Message-ID: <1524834018.6979.13.camel@ziswiler.com>
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
Date: Fri, 27 Apr 2018 15:00:18 +0200
In-Reply-To: <a8fc30b9-42ce-b29a-abc6-2867ebf4a9ac@gmail.com>
References: <20180426235818.10018-1-digetx@gmail.com>
         <20180426235818.10018-2-digetx@gmail.com>
         <1524832404.6979.9.camel@ziswiler.com>
         <a8fc30b9-42ce-b29a-abc6-2867ebf4a9ac@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iSN0AVMYOyPBdmu2FOw6rArF5oR0y0fBqkooqC14KgBsXCZdXV8
 D+WnlI0tLTEpUSRVHZa7MYkD+PvVxLZKtTdALIGbWE05dWBerQ4H7D73ng+M5+gV6AFFQDa
 wedfGN9y0IPnwEal6l2DJfegsBsUGpkNW0atqVW28p9FNH0VyhBNT5QDik1iAxVYyVb7IpO
 MdafAyHDquVzTlqB+sBaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BJO0lyfDcg0=:wQamaItjY3iFAMXvInCism
 laU74IH9DWjwZR2V9D/pIcFAe5Nb0AFcYBulUfdyz+uSZan5Wut67JRRBo03R/DuPbIx0YvEB
 QkO5JPplU4XQn0phLsSFRXX9bOXBYR6s+35M41Q94DRdbDht5+kBPgi8cqU7obOvtf7vACnjR
 0bV4lRlTIdGcAfLNgvQ5ZJyMfUwhbY4d8DCIpl0tG3kXgNRCPWcsn588ZEUiCwZc68a5/R0oJ
 tNQ6U+UuJfliyPNVxMA6Vzx2Di6SG1Txqi7M9bYOYavj8RQX4L+H4jEx2elqixn05EmcXFuFp
 9v+0FRcFZxMz3sg+rdFCntfoUi3lXYfQoYfOfYFxSGp0QaKf6Pun1B62PlXCaMgg/i/m7cBap
 Gy9pyvNM6tU16Q+fGr0fFwngIcqbxexoW4t3GU5FQ1m38cp4VQSPpncDSB9gBlmy7AHa6lWEm
 mDf6i9mVVda7lprppEAACXdHayGcFqY2UlGqEoPHAC/y4ahkUoDTt/ZTRWNSzbORyrDPP1XCv
 bIpifSNei56xX1AWLBdkVPru7qDk7vkIlfstS0UJueLRrk/PFrC4l+oK0K86+/SMRoUaCoMoB
 Fn6QPrdz0eV44S7K196SOf1J0iO0dpn44q5ILKt1+qUuYh6yykpPW1CaNBxI/E/S1dHaaHtHy
 7RE+6eZHc7MGEMHPsDqM/D+zW+r7v7Ws5PAyrQ+Nax7cK2CZpPAFSBhdYrKPpem2D4VukyEfP
 OsmDZhIOkUZ/yMdF
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-27 at 15:54 +0300, Dmitry Osipenko wrote:
> Hi Marcel,
> 
> On 27.04.2018 15:33,  Ziswiler wrote:
> > Hi Dmitry
> > 
> > Isn't the CLK_RST_CONTROLLER_MISC_CLK_ENB_0 the other way around
> > e.g.
> > DEV1_OSC_DIV_SEL at bit 23:22 and DEV2_OSC_DIV_SEL at 21:20?
> > 
> > On Fri, 2018-04-27 at 02:58 +0300, Dmitry Osipenko wrote:
> > > CDEV1/CDEV2 clocks could have corresponding oscillator clock
> > > divider
> > > as
> > > a parent. Add these dividers in order to be able to provide that
> > > parent
> > > option.
> > > 
> > > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > ---
> > >  drivers/clk/tegra/clk-tegra20.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/drivers/clk/tegra/clk-tegra20.c
> > > b/drivers/clk/tegra/clk-
> > > tegra20.c
> > > index 0ee56dd04cec..16cf4108f2ff 100644
> > > --- a/drivers/clk/tegra/clk-tegra20.c
> > > +++ b/drivers/clk/tegra/clk-tegra20.c
> > > @@ -26,6 +26,8 @@
> > >  #include "clk.h"
> > >  #include "clk-id.h"
> > >  
> > > +#define MISC_CLK_ENB 0x48
> > > +
> > >  #define OSC_CTRL 0x50
> > >  #define OSC_CTRL_OSC_FREQ_MASK (3<<30)
> > >  #define OSC_CTRL_OSC_FREQ_13MHZ (0<<30)
> > > @@ -831,6 +833,16 @@ static void __init
> > > tegra20_periph_clk_init(void)
> > >  				    periph_clk_enb_refcnt);
> > >  	clks[TEGRA20_CLK_PEX] = clk;
> > >  
> > > +	/* cdev1 OSC divider */
> > > +	clk_register_divider(NULL, "cdev1_osc_div", "clk_m",
> > > +			     0, clk_base + MISC_CLK_ENB, 20, 2,
> > 
> > So it would be:
> > 
> > +			     0, clk_base + MISC_CLK_ENB, 22, 2,
> > 
> > > +			     CLK_DIVIDER_POWER_OF_TWO, NULL);
> > > +
> > > +	/* cdev2 OSC divider */
> > > +	clk_register_divider(NULL, "cdev2_osc_div", "clk_m",
> > > +			     0, clk_base + MISC_CLK_ENB, 22, 2,
> > 
> > And:
> > 
> > +			     0, clk_base + MISC_CLK_ENB, 20, 2,
> > 
> > > +			     CLK_DIVIDER_POWER_OF_TWO, NULL);
> > > +
> > >  	/* cdev1 */
> > >  	clk = clk_register_fixed_rate(NULL, "cdev1_fixed", NULL,
> > > 0,
> > > 26000000);
> > >  	clk = tegra_clk_register_periph_gate("cdev1",
> > > "cdev1_fixed",
> > > 0,
> 
> Indeed, good catch! I'll wait for more comments and then re-spin
> patchset with
> the fix. Thank you.

You are very welcome. Thank you!

Other than that it all looks proper and works fine at least in the
configuration we use on Colibri T20. So you may add my reviewed and
tested bys to the whole series:

Reviewed-by: Marcel Ziswiler <marcel@ziswiler.com>
Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
