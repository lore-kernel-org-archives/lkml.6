Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbeEKP1u (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:27:50 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:19657 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeEKP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:27:48 -0400
Subject: =?UTF-8?Q?Re:_[PATCH_v10_00/27]_ARM:_davinci:_convert_to_common_clo?=
 =?UTF-8?B?Y2sgZnJhbWV3b3Jr4oCL?=
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20180509172606.29387-1-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <45ce3129-4a9e-54d2-e594-49b451571842@ti.com>
Date: Fri, 11 May 2018 20:56:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509172606.29387-1-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wednesday 09 May 2018 10:55 PM, David Lechner wrote:
> This series converts mach-davinci to use the common clock framework.
> 
> The series works like this, the first 3 patches fix some issues with the clock
> drivers that have already been accepted into the mainline kernel.

I have not yet looked at the patches, but I got a bunch of W=1 warnings 
and some sparse warnings when building your branch. Please take a look 
at these. Unfortunately the output is mixed between sparse and compiler.
The "expression using sizeof(void)" can be ignored as its a known issue
with sparse, I believe.

Thanks,
Sekhar

drivers/clk/davinci/pll-da830.c:39:5: warning: symbol 'da830_pll_init' was not declared. Should it be static?
drivers/clk/davinci/pll.c:142:16: warning: expression using sizeof(void)
drivers/clk/davinci/pll.c:142:16: warning: expression using sizeof(void)
drivers/clk/davinci/pll-da850.c:87:5: warning: symbol 'da850_pll0_init' was not declared. Should it be static?
drivers/clk/davinci/pll-da830.c:39:5: warning: no previous prototype for ‘da830_pll_init’ [-Wmissing-prototypes]
 int da830_pll_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
     ^~~~~~~~~~~~~~
drivers/clk/davinci/pll-da850.c:87:5: warning: no previous prototype for ‘da850_pll0_init’ [-Wmissing-prototypes]
 int da850_pll0_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
     ^~~~~~~~~~~~~~~
drivers/clk/davinci/pll-dm355.c:30:5: warning: symbol 'dm355_pll1_init' was not declared. Should it be static?
drivers/clk/davinci/pll-dm365.c:59:5: warning: symbol 'dm365_pll1_init' was not declared. Should it be static?
drivers/clk/davinci/pll-dm365.c:122:5: warning: symbol 'dm365_pll2_init' was not declared. Should it be static?
drivers/clk/davinci/da8xx-cfgchip.c:581: warning: Function parameter or member 'dev' not described in 'da8xx_cfgchip_register_usb1_clk48'
drivers/clk/davinci/pll-dm646x.c:32:5: warning: symbol 'dm646x_pll1_init' was not declared. Should it be static?
drivers/clk/davinci/pll-dm644x.c:30:5: warning: symbol 'dm644x_pll1_init' was not declared. Should it be static?
drivers/clk/davinci/pll-dm365.c:59:5: warning: no previous prototype for ‘dm365_pll1_init’ [-Wmissing-prototypes]
 int dm365_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
     ^~~~~~~~~~~~~~~
drivers/clk/davinci/pll-dm365.c:122:5: warning: no previous prototype for ‘dm365_pll2_init’ [-Wmissing-prototypes]
 int dm365_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
     ^~~~~~~~~~~~~~~
drivers/clk/davinci/pll-dm355.c:30:5: warning: no previous prototype for ‘dm355_pll1_init’ [-Wmissing-prototypes]
 int dm355_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
     ^~~~~~~~~~~~~~~
drivers/clk/davinci/psc.c:310:5: warning: symbol 'davinci_clk_reset_assert' was not declared. Should it be static?
drivers/clk/davinci/psc.c:316:5: warning: symbol 'davinci_clk_reset_deassert' was not declared. Should it be static?
drivers/clk/davinci/psc-dm644x.c:66:5: warning: symbol 'dm644x_psc_init' was not declared. Should it be static?
drivers/clk/davinci/psc-dm355.c:71:5: warning: symbol 'dm355_psc_init' was not declared. Should it be static?
drivers/clk/davinci/pll-dm646x.c:32:5: warning: no previous prototype for ‘dm646x_pll1_init’ [-Wmissing-prototypes]
 int dm646x_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
     ^~~~~~~~~~~~~~~~
drivers/clk/davinci/psc-dm365.c:76:5: warning: symbol 'dm365_psc_init' was not declared. Should it be static?
drivers/clk/davinci/psc-dm646x.c:61:5: warning: symbol 'dm646x_psc_init' was not declared. Should it be static?
drivers/clk/davinci/pll-dm644x.c:30:5: warning: no previous prototype for ‘dm644x_pll1_init’ [-Wmissing-prototypes]
 int dm644x_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
     ^~~~~~~~~~~~~~~~
drivers/clk/davinci/psc-dm355.c:71:5: warning: no previous prototype for ‘dm355_psc_init’ [-Wmissing-prototypes]
 int dm355_psc_init(struct device *dev, void __iomem *base)
     ^~~~~~~~~~~~~~
In file included from drivers/clk/davinci/psc-dm355.c:15:0:
drivers/clk/davinci/psc-dm355.c:26:14: warning: ‘mcbsp0_clkdev’ defined but not used [-Wunused-const-variable=]
 LPSC_CLKDEV1(mcbsp0_clkdev,  NULL,  "davinci-mcbsp.0");
              ^
drivers/clk/davinci/psc.h:31:46: note: in definition of macro ‘LPSC_CLKDEV1’
 static const struct davinci_lpsc_clkdev_info n[] __initconst = { \
                                              ^
drivers/clk/davinci/psc-dm355.c:21:14: warning: ‘mcbsp1_clkdev’ defined but not used [-Wunused-const-variable=]
 LPSC_CLKDEV1(mcbsp1_clkdev,  NULL,  "davinci-mcbsp.1");
              ^
drivers/clk/davinci/psc.h:31:46: note: in definition of macro ‘LPSC_CLKDEV1’
 static const struct davinci_lpsc_clkdev_info n[] __initconst = { \
                                              ^
drivers/clk/davinci/psc-dm365.c:76:5: warning: no previous prototype for ‘dm365_psc_init’ [-Wmissing-prototypes]
 int dm365_psc_init(struct device *dev, void __iomem *base)
     ^~~~~~~~~~~~~~
drivers/clk/davinci/psc-dm646x.c:61:5: warning: no previous prototype for ‘dm646x_psc_init’ [-Wmissing-prototypes]
 int dm646x_psc_init(struct device *dev, void __iomem *base)
     ^~~~~~~~~~~~~~~
drivers/clk/davinci/psc-dm644x.c:66:5: warning: no previous prototype for ‘dm644x_psc_init’ [-Wmissing-prototypes]
 int dm644x_psc_init(struct device *dev, void __iomem *base)
     ^~~~~~~~~~~~~~~
drivers/clk/davinci/pll.c:496: warning: Function parameter or member 'dev' not described in 'davinci_pll_auxclk_register'
drivers/clk/davinci/psc.c:310:5: warning: no previous prototype for ‘davinci_clk_reset_assert’ [-Wmissing-prototypes]
 int davinci_clk_reset_assert(struct clk *clk)
     ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/clk/davinci/psc.c:316:5: warning: no previous prototype for ‘davinci_clk_reset_deassert’ [-Wmissing-prototypes]
 int davinci_clk_reset_deassert(struct clk *clk)
     ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/clk/davinci/pll.c:509: warning: Function parameter or member 'dev' not described in 'davinci_pll_sysclkbp_clk_register'
drivers/clk/davinci/pll.c:524: warning: Function parameter or member 'dev' not described in 'davinci_pll_obsclk_register'
drivers/clk/davinci/pll.c:605: warning: Function parameter or member 'dev' not described in 'davinci_pll_sysclk_register'
