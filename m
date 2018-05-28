Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933670AbeE1QH7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:07:59 -0400
Received: from ns.lynxeye.de ([87.118.118.114]:54858 "EHLO lynxeye.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932476AbeE1QHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 12:07:54 -0400
Message-ID: <040f1774efe7430a3802ac48f1980122ba5b1128.camel@lynxeye.de>
Subject: Re: [PATCH v2 4/6] clk: tegra20: init NDFLASH clock to sensible rate
From: Lucas Stach <dev@lynxeye.de>
To: Stefan Agner <stefan@agner.ch>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pgaikwad@nvidia.com, mirza.krak@gmail.com,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Date: Mon, 28 May 2018 17:58:11 +0200
In-Reply-To: <5665b799f763daa82dced238fb494863@agner.ch>
References: <20180527215442.14760-5-stefan@agner.ch>
         <20180528075510.GQ6835@tbergstrom-lnx.Nvidia.com>
         <5665b799f763daa82dced238fb494863@agner.ch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 28.05.2018, 17:53 +0200 schrieb Stefan Agner:
> On 28.05.2018 09:55, Peter De Schrijver wrote:
> > On Sun, May 27, 2018 at 11:54:40PM +0200, Stefan Agner wrote:
> > > From: Lucas Stach <dev@lynxeye.de>
> > > 
> > > Set up the NAND Flash controller clock to run at 150MHz
> > > instead of the rate set by the bootloader. This is a
> > > conservative rate which also yields good performance.
> > > 
> > > Signed-off-by: Lucas Stach <dev@lynxeye.de>
> > > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > > ---
> > >  drivers/clk/tegra/clk-tegra20.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
> > > index 0ee56dd04cec..dff8c425cd28 100644
> > > --- a/drivers/clk/tegra/clk-tegra20.c
> > > +++ b/drivers/clk/tegra/clk-tegra20.c
> > > @@ -1049,6 +1049,7 @@ static struct tegra_clk_init_table init_table[] __initdata = {
> > >  	{ TEGRA20_CLK_GR2D, TEGRA20_CLK_PLL_C, 300000000, 0 },
> > >  	{ TEGRA20_CLK_GR3D, TEGRA20_CLK_PLL_C, 300000000, 0 },
> > >  	{ TEGRA20_CLK_VDE, TEGRA20_CLK_CLK_MAX, 300000000, 0 },
> > > +	{ TEGRA20_CLK_NDFLASH, TEGRA20_CLK_PLL_P, 150000000, 0 },
> > >  	/* must be the last entry */
> > >  	{ TEGRA20_CLK_CLK_MAX, TEGRA20_CLK_CLK_MAX, 0, 0 },
> > >  };
> > > --
> > > 2.17.0
> > > 
> > 
> > Maybe better to specify this in the Tegra20 dtsi? See 
> > "Assigned clock parents and rates" in
> > Documentation/devicetree/bindings/clock/clock-bindings.txt
> 
> assigned-clocks indeed works just fine for this case. Thanks for
> bringing this up, will drop this patch and add the device tree
> properties in v3.
> 
> Hm, interesting that none of the Tegra device tree make use of the
> feature so far. I guess there would be other cases where this would be
> useful as well (the one just above, VDE?).

Most of the Tegra clock init stuff (including this patch) was written
before we had assigned-clocks as some common DT facility. But fully
agree on dropping this patch.

Regards,
Lucas
