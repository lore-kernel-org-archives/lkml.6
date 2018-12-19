Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A2DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8922084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HJs4IbLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbeLSU5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:57:07 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:47011 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbeLSU5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 15:57:06 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so9986323ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 12:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DzTS9QYO2r69hs/bAQE3QHKmKsyi7lPyBvuylOVKON4=;
        b=HJs4IbLLaGIjkZZvJQ/v5+00Y4B3sY2be8h1/ymYiGHJCDaqBOM4r3xMRDfZBLEjL+
         f1CcWbkMAFSx88pdENVMIXG+rOjMbFpQcNDbtLOFIXmUENTmykauLPzARduAxzopHQJk
         kta8zwcMCn2DO5K6lkoI3YDnJsbMpuMGdZU8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DzTS9QYO2r69hs/bAQE3QHKmKsyi7lPyBvuylOVKON4=;
        b=IEfvpFplYVFXBy5LGpuf7zT6rESZ7Tfu0/n8lMmmbwqxspqGBfCULeo3GZmq7JvMT2
         5c6lRg3t3luJDWDBTn6VYN/qEE4EEs3q/sSb6ZoYIGnceTFJR8fKqC2sZBJEqL6cHqB4
         6+zK7MLdidDpkC/MmOemNNrVWy/oGfwDE/D5zm/peei4+dYvNCyIV/BYZ3H4+kqTw5jS
         zq90A87cgpHFM35fiVWnLua/JSj/wDfcAiKxDV2NUt3H4g2LKlyqD861OL8tEAby1vDl
         0DqUka5bI8xPEjLdQ+NWashFRYs1imBgYz/DKc3ng+Cj6iPMokWaHEhRMamw2LNpX6hS
         rHXw==
X-Gm-Message-State: AA+aEWawnpHG3P6XXC3Y0G81Nlu3mriRUu6rSQBb2CnIXX6hfTLFi+zT
        INdq14h5qjHFSyyJYOUdQQgx6r7lDqM=
X-Google-Smtp-Source: AFSGD/XRLmvMlQFZE6ZhBi0SUiuQp79qC668S2wqoQm+hPefEfqeiwnkz6UlSd8gfc4Wqd65idfKgw==
X-Received: by 2002:a17:902:720c:: with SMTP id ba12mr21735371plb.79.1545253025525;
        Wed, 19 Dec 2018 12:57:05 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id s9sm26864111pgl.88.2018.12.19.12.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 12:57:04 -0800 (PST)
Date:   Wed, 19 Dec 2018 12:57:04 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/8] drm/msm/dsi: 28nm PHY: Get ref clock from the DT
Message-ID: <20181219205704.GE109358@google.com>
References: <20181204224234.62619-1-mka@chromium.org>
 <20181204224234.62619-4-mka@chromium.org>
 <20181212220717.GA16710@centauri.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181212220717.GA16710@centauri.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On Wed, Dec 12, 2018 at 11:07:17PM +0100, Niklas Cassel wrote:
> On Tue, Dec 04, 2018 at 02:42:29PM -0800, Matthias Kaehlcke wrote:
> > Get the ref clock of the PHY from the device tree instead of
> > hardcoding its name and rate.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v4:
> > - always use parent rate in dsi_pll_28nm_clk_set_rate() and
> >    dsi_pll_28nm_clk_recalc_rate()
> > - pass name of VCO ref clock to pll_28nm_register() instead of
> >   storing it in a struct field
> > - updated commit message
> > 
> > Changes in v3:
> > - use default name and rate if the ref clock is not specified
> >   in the DT
> > - store vco_ref_clk_name instead of vco_ref_clk
> > - dsi_pll_28nm_clk_set_rate: changed data type of ref_clk_rate to
> >   unsigned long
> > - fixed check for EPROBE_DEFER
> > - renamed VCO_REF_CLK_RATE to VCO_REF_CLK_DEFAULT_RATE
> > 
> > Changes in v2:
> > - patch added to the series
> > ---
> >  drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c | 36 +++++++++++++++-------
> >  1 file changed, 25 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c
> > index 26e3a01a99c2b..7777340b03e8d 100644
> > --- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c
> > +++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c
> > @@ -40,7 +40,6 @@
> >  
> >  #define NUM_PROVIDED_CLKS		2
> >  
> > -#define VCO_REF_CLK_RATE		19200000
> >  #define VCO_MIN_RATE			350000000
> >  #define VCO_MAX_RATE			750000000
> >  
> > @@ -166,17 +165,17 @@ static int dsi_pll_28nm_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> >  	pll_write(base + REG_DSI_28nm_PHY_PLL_LPFC1_CFG, 0x70);
> >  	pll_write(base + REG_DSI_28nm_PHY_PLL_LPFC2_CFG, 0x15);
> >  
> > -	rem = rate % VCO_REF_CLK_RATE;
> > +	rem = rate % parent_rate;
> >  	if (rem) {
> >  		refclk_cfg = DSI_28nm_PHY_PLL_REFCLK_CFG_DBLR;
> >  		frac_n_mode = 1;
> > -		div_fbx1000 = rate / (VCO_REF_CLK_RATE / 500);
> > -		gen_vco_clk = div_fbx1000 * (VCO_REF_CLK_RATE / 500);
> > +		div_fbx1000 = rate / (parent_rate / 500);
> > +		gen_vco_clk = div_fbx1000 * (parent_rate / 500);
> >  	} else {
> >  		refclk_cfg = 0x0;
> >  		frac_n_mode = 0;
> > -		div_fbx1000 = rate / (VCO_REF_CLK_RATE / 1000);
> > -		gen_vco_clk = div_fbx1000 * (VCO_REF_CLK_RATE / 1000);
> > +		div_fbx1000 = rate / (parent_rate / 1000);
> > +		gen_vco_clk = div_fbx1000 * (parent_rate / 1000);
> >  	}
> >  
> >  	DBG("refclk_cfg = %d", refclk_cfg);
> > @@ -265,7 +264,7 @@ static unsigned long dsi_pll_28nm_clk_recalc_rate(struct clk_hw *hw,
> >  	void __iomem *base = pll_28nm->mmio;
> >  	u32 sdm0, doubler, sdm_byp_div;
> >  	u32 sdm_dc_off, sdm_freq_seed, sdm2, sdm3;
> > -	u32 ref_clk = VCO_REF_CLK_RATE;
> > +	u32 ref_clk = parent_rate;
> >  	unsigned long vco_rate;
> >  
> >  	VERB("parent_rate=%lu", parent_rate);
> > @@ -273,7 +272,7 @@ static unsigned long dsi_pll_28nm_clk_recalc_rate(struct clk_hw *hw,
> >  	/* Check to see if the ref clk doubler is enabled */
> >  	doubler = pll_read(base + REG_DSI_28nm_PHY_PLL_REFCLK_CFG) &
> >  			DSI_28nm_PHY_PLL_REFCLK_CFG_DBLR;
> > -	ref_clk += (doubler * VCO_REF_CLK_RATE);
> > +	ref_clk += (doubler * ref_clk);
> >  
> >  	/* see if it is integer mode or sdm mode */
> >  	sdm0 = pll_read(base + REG_DSI_28nm_PHY_PLL_SDM_CFG0);
> > @@ -514,11 +513,12 @@ static void dsi_pll_28nm_destroy(struct msm_dsi_pll *pll)
> >  	pll_28nm->clk_data.clk_num = 0;
> >  }
> >  
> > -static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm)
> > +static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm,
> > +			     const char *ref_clk_name)
> >  {
> >  	char clk_name[32], parent1[32], parent2[32], vco_name[32];
> >  	struct clk_init_data vco_init = {
> > -		.parent_names = (const char *[]){ "xo" },
> > +		.parent_names = &ref_clk_name,
> >  		.num_parents = 1,
> >  		.name = vco_name,
> >  		.flags = CLK_IGNORE_UNUSED,
> > @@ -593,6 +593,8 @@ struct msm_dsi_pll *msm_dsi_pll_28nm_init(struct platform_device *pdev,
> >  {
> >  	struct dsi_pll_28nm *pll_28nm;
> >  	struct msm_dsi_pll *pll;
> > +	struct clk *vco_ref_clk;
> > +	const char *vco_ref_clk_name;
> >  	int ret;
> >  
> >  	if (!pdev)
> > @@ -605,6 +607,18 @@ struct msm_dsi_pll *msm_dsi_pll_28nm_init(struct platform_device *pdev,
> >  	pll_28nm->pdev = pdev;
> >  	pll_28nm->id = id;
> >  
> > +	vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
> > +	if (!IS_ERR(vco_ref_clk)) {
> > +		vco_ref_clk_name = __clk_get_name(vco_ref_clk);
> > +	} else {
> > +		ret = PTR_ERR(vco_ref_clk);
> > +		if (ret == -EPROBE_DEFER)
> > +			ERR_PTR(ret);
> 
> It looks like you are missing the return keyword here.

Indeed, thanks for pointing that out!

Cheers

Matthias
