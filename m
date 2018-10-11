Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6378C4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C10A2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C10A2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeJKUxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:53:24 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:60838 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726071AbeJKUxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:53:24 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BDOZWF008516;
        Thu, 11 Oct 2018 08:26:04 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0a-001ae601.pphosted.com with ESMTP id 2mxwhefttp-1;
        Thu, 11 Oct 2018 08:26:04 -0500
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id A5F73611C8B3;
        Thu, 11 Oct 2018 08:28:16 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 11 Oct 2018
 14:26:02 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w9BDQ2Ew002789; Thu,
 11 Oct 2018 14:26:02 +0100
Date:   Thu, 11 Oct 2018 14:26:02 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     <broonie@kernel.org>, <lee.jones@linaro.org>,
        <linus.walleij@linaro.org>, <mturquette@baylibre.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] clk: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181011132602.GD1653@imbe.wolfsonmicro.main>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-3-ckeepax@opensource.cirrus.com>
 <153924124658.207691.10370075148426001371@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <153924124658.207691.10370075148426001371@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810110131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 12:00:46AM -0700, Stephen Boyd wrote:
> Quoting Charles Keepax (2018-10-08 06:25:40)
> > +#include <linux/clk.h>
> 
> Is this used?
> 
> > +#include <linux/clk-provider.h>
> > +#include <linux/delay.h>
> 
> Is this used?
> 
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> 
> Used?

Apparently not, will remove the three of them.

> > +struct lochnagar_regmap_clk {
> > +       unsigned int cfg_reg;
> > +       unsigned int ena_mask;
> > +       unsigned int dir_mask;
> > +
> > +       unsigned int src_reg;
> > +       unsigned int src_mask;
> 
> Are these 32 bits or 16 bits or 8 bits? Please use a u32/u16/u8 so we
> know the register width.
> 

Can do.

> > +struct lochnagar_clk_priv {
> > +       struct device *dev;
> > +       struct lochnagar *lochnagar;
> 
> Is this used for anything besides getting the regmap? Can you get the
> pointer to the parent in probe and use that to get the regmap pointer
> from dev_get_remap() and also use the of_node of the parent to register
> a clk provider? It would be nice to avoid including the mfd header file
> unless it's providing something useful.
> 

It is also used to find out which type of Lochnagar we have
connected, which determines which clocks we should register. I
could perhaps pass that using another mechanism but we would
still want to include the MFD stuff to get the register
definitions. So this approach seems simplest.

> > +#define LN_CLK_FIXED(ID, NAME, RATE) \
> > +       [LOCHNAGAR_##ID] = { \
> > +               .name = NAME, .type = LOCHNAGAR_CLK_TYPE_FIXED, \
> > +               { .fixed.rate = RATE, }, \
> > +       }
> 
> Can all these fixed clks come from DT instead of being populated by this
> driver? Unless they're being generated by this hardware block and not
> actually a crystal or some other on-board clock that goes into this
> hardware block and then right out of it?
> 

Technically they are supplied by a clock generator chip (bunch of
PLLs) which is controlled by the board controller chip. That said
I don't really ever see them changing so will move them in DT.

> > +static int lochnagar_regmap_prepare(struct clk_hw *hw)
> > +{
> > +       struct lochnagar_clk *lclk = lochnagar_hw_to_lclk(hw);
> > +       struct lochnagar_clk_priv *priv = lclk->priv;
> > +       struct regmap *regmap = priv->lochnagar->regmap;
> > +       int ret;
> > +
> > +       dev_dbg(priv->dev, "Prepare %s\n", lclk->name);
> 
> Nitpick: Can you just rely on the clk tracepoints?
> 

Can do they are hardly essential.

> > +
> > +       if (!lclk->regmap.ena_mask)
> 
> Why did we assign the ops to the clk if it can't be enabled? Please make
> different ops for different types of clks so we don't have to check
> something else and bail out early when the op is called.
> 

This is a bit of a leak from earlier versions of the code I
can just remove them.

> > +static int lochnagar_regmap_set_parent(struct clk_hw *hw, u8 index)
> > +{
> > +       struct lochnagar_clk *lclk = lochnagar_hw_to_lclk(hw);
> > +       struct lochnagar_clk_priv *priv = lclk->priv;
> > +       struct regmap *regmap = priv->lochnagar->regmap;
> > +       int ret;
> > +
> > +       dev_dbg(priv->dev, "Reparent %s to %s\n",
> > +               lclk->name, priv->parents[index]);
> > +
> > +       if (lclk->regmap.dir_mask) {
> > +               ret = regmap_update_bits(regmap, lclk->regmap.cfg_reg,
> > +                                        lclk->regmap.dir_mask,
> > +                                        lclk->regmap.dir_mask);
> > +               if (ret < 0) {
> > +                       dev_err(priv->dev, "Failed to set %s direction: %d\n",
> 
> What does direction mean?
> 

Some of the clocks can both generate and receive a clock. For
example the PSIA (external audio interface) MCLKs, the attached
device could be expecting or providing a master audio clock. If
the user assigns a parent to the clock we assume the attached
device is providing a clock to us, otherwise we assume we are
providing the clock.

> > +       ret = regmap_read(regmap, lclk->regmap.src_reg, &val);
> > +       if (ret < 0) {
> > +               dev_err(priv->dev, "Failed to read parent of %s: %d\n",
> > +                       lclk->name, ret);
> > +               return 0;
> 
> Return a number greater than all possible parents of this clk?
> 

Can do.

> > +       for (i = 0; i < ARRAY_SIZE(priv->lclks); i++) {
> > +               lclk = &priv->lclks[i];
> > +
> > +               lclk->priv = priv;
> > +
> > +               switch (lclk->type) {
> > +               case LOCHNAGAR_CLK_TYPE_FIXED:
> > +                       clk = clk_register_fixed_rate(priv->dev, lclk->name,
> > +                                                     NULL, 0,
> > +                                                     lclk->fixed.rate);
> > +                       break;
> > +               case LOCHNAGAR_CLK_TYPE_REGMAP:
> > +                       clk_init.name = lclk->name;
> > +                       lclk->hw.init = &clk_init;
> > +
> > +                       clk = devm_clk_register(priv->dev, &lclk->hw);
> 
> Please use the clk_hw based registration APIs.
> 

Can do.

> > +static int lochnagar_clk_remove(struct platform_device *pdev)
> > +{
> > +       struct lochnagar_clk_priv *priv = platform_get_drvdata(pdev);
> > +       int i;
> > +
> > +       of_clk_del_provider(priv->lochnagar->dev->of_node);
> 
> Use devm variant of clk provider registration?
> 

This isn't using the devm version as it makes the assumption
that the device that contains the DT is the same one we want
to devm against which isn't the case here.

I could update probe to copy the of_node over from the parent, if
you prefer? I think that would also work.

> > +static struct platform_driver lochnagar_clk_driver = {
> > +       .driver = {
> > +               .name = "lochnagar-clk",
> > +       },
> 
> Any id_table?
> 

Doesn't really need one since the driver will only ever be bound
in by the MFD, so matching on the driver name is fine.

Thanks,
Charles
