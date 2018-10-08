Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E101C6787D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4A120841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPz+sQjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4A120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeJHJrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 05:47:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725760AbeJHJrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 05:47:53 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED7DF20841;
        Mon,  8 Oct 2018 02:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538966310;
        bh=8OAN2T6svcB95JnLNRKBOtgkwN7lKejDKS3d4Sl3Wjo=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=JPz+sQjNMTc4B+Vvy6Uojgyv5hzoZImGidw9xA8gxE5cqWCwRowjwQRXH7oWngsgK
         G2/m+JYcjhcW0blGVTyZScOG8BSFJPxMMoroWHVhPle6NqTlPG2pqOP6RvS/PteLuz
         Gdu3Jdmqgg5F7tdAQufL+1XRne9mGJh9/5gz1HsE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Vinod <vkoul@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181003062103.GN19792@vkoul-mobl>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Shefali Jain <shefjain@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
References: <20180921185936.9590-1-vkoul@kernel.org>
 <20180921185936.9590-2-vkoul@kernel.org>
 <153841434099.119890.3912925112860077471@swboyd.mtv.corp.google.com>
 <20181003062103.GN19792@vkoul-mobl>
Message-ID: <153896630923.119890.17169150168947487135@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: qcom: gcc: Add global clock controller driver for QCS404
Date:   Sun, 07 Oct 2018 19:38:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod (2018-10-02 23:21:03)
> Hi Stephen,
> =

> Thanks for the comments,
> =

> On 01-10-18, 10:19, Stephen Boyd wrote:
> > Quoting Vinod Koul (2018-09-21 11:59:36)
> > > From: Shefali Jain <shefjain@codeaurora.org>
> > > =

> > > Add the clocks supported in global clock controller which clock the
> > > peripherals like BLSPs, SDCC, USB, MDSS etc. Register all the clocks
> > > to the clock framework for the clients to be able to request for them.
> > > =

> > > Signed-off-by: Shefali Jain <shefjain@codeaurora.org>
> > > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> > > Co-developed-by: Taniya Das <tdas@codeaurora.org>
> > > Signed-off-by: Anu Ramanathan <anur@codeaurora.org>
> > > [rebase and tidyup for upstream]
> > =

> > Who did the tidying?
> =

> both of us :)

OK, please add the username of both people per the kernel sign off
standards.

> =

> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> > >  - reg : shall contain base register location and length
> > > diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> > > index 064768699fe7..529d84cc7503 100644
> > > --- a/drivers/clk/qcom/Kconfig
> > > +++ b/drivers/clk/qcom/Kconfig
> > > @@ -235,6 +235,14 @@ config MSM_GCC_8998
> > >           Say Y if you want to use peripheral devices such as UART, S=
PI,
> > >           i2c, USB, UFS, SD/eMMC, PCIe, etc.
> > >  =

> > > +config QCS_GCC_404
> > > +       tristate "QCS404 Global Clock Controller"
> > > +       depends on COMMON_CLK_QCOM
> > > +       help
> > > +        Support for the global clock controller on QCS404 devices.
> > > +        Say Y if you want to use peripheral devices such as UART, SP=
I, I2C,
> > > +        USB, SD/eMMC, PCIe, etc.
> > =

> > It seems to include multimedia display clks and ethernet? Maybe include
> > those too.
> =

> Sure will add
> =

> > > +#include <linux/kernel.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/clk.h>
> > =

> > Please don't include this.
> =

> OK will check if this is required, any reason for not including this?

So we can easily split clk consumers and clk providers.

> =

> > > +static struct clk_branch gcc_pwm1_xo512_clk =3D {
> > > +       .halt_reg =3D 0x49004,
> > > +       .halt_check =3D BRANCH_HALT,
> > > +       .clkr =3D {
> > > +               .enable_reg =3D 0x49004,
> > > +               .enable_mask =3D BIT(0),
> > > +               .hw.init =3D &(struct clk_init_data){
> > > +                       .name =3D "gcc_pwm1_xo512_clk",
> > > +                       .ops =3D &clk_branch2_ops,
> > =

> > Do these pwm clks have a parent clk of the XO?
> =

> Yes they do

Cool, we should add them or add a comment explaining why they don't have
parents listed here.

> =

> > > +       [GCC_USB_HS_PHY_CFG_AHB_CLK] =3D &gcc_usb_hs_phy_cfg_ahb_clk.=
clkr,
> > > +       [GCC_USB_HS_SYSTEM_CLK] =3D &gcc_usb_hs_system_clk.clkr,
> > > +       [GFX3D_CLK_SRC] =3D &gfx3d_clk_src.clkr,
> > > +       [GP1_CLK_SRC] =3D &gp1_clk_src.clkr,
> > =

> > Why are some of these missing GCC_ prefix?
> =

> will add..

Thanks!

> =

> > > +static int gcc_qcs404_probe(struct platform_device *pdev)
> > > +{
> > > +       struct regmap *regmap;
> > > +       int ret;
> > > +
> > > +       ret =3D qcom_cc_register_board_clk(&pdev->dev,
> > > +                                        "xo_board", "cxo", 19200000);
> > =

> > You shouldn't need to do this. This function is for transitioning DT
> > that doesn't have the board clk in DT to something the driver wants to
> > use, in this case "cxo". So you can either register a fixed factor 1/1
> > clk to do the translation between board and cxo names, or use xo_board
> > as the parent of things that can take crystal.
> =

> Okay will modify this. If I go about using xo_board as parent, I would
> need to register that right? FWIW I see the same thing done in gcc-msm8916

Yes it would be similar to 8916 or 8996/845.

> =

> > =

> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       regmap =3D qcom_cc_map(pdev, &gcc_qcs404_desc);
> > > +       if (IS_ERR(regmap))
> > > +               return PTR_ERR(regmap);
> > > +
> > > +       clk_alpha_pll_configure(&gpll3_out_main, regmap, &gpll3_confi=
g);
> > > +       clk_set_rate(apss_ahb_clk_src.clkr.hw.clk, 19200000);
> > =

> > use assigned clock rates from DT please.
> =

> ok
> =

> > > +       clk_prepare_enable(apss_ahb_clk_src.clkr.hw.clk);
> > > +       clk_prepare_enable(gpll0_ao_out_main.clkr.hw.clk);
> > =

> > And these should be marked as critical clocks.
> =

> Okay and how do we go about doing that?

You mark the clk flags with CLK_IS_CRITICAL.

