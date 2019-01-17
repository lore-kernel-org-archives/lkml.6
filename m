Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75606C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E4F20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NP0si3ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbfAQG20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:28:26 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45161 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfAQG20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:28:26 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so4226650plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 22:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mCTsp1TTN24owrN3MkvyzPcw6V8d8yP34TwiCxlzb8c=;
        b=NP0si3icH+q949vp9PsZlav441VAes3Iasb9e4lrP2xKcjFSv+lD5enZ3ImNJRIg0t
         CWlEtH81nkckNERuyHwAjjRkMuqI3ZBPy0sRTv+3QKhdBfEwJPsMV4eIeb6Let2qgYUW
         ucQI2iMJfKSQ9OPf4jtd3543DnAh+mqShy4Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mCTsp1TTN24owrN3MkvyzPcw6V8d8yP34TwiCxlzb8c=;
        b=thCOjVOr1J9eNFsAdhTW7IstlWT9E8GLoqs/3Otl3Tk0acdtEoapFPRzxPX9EAAtwy
         dJFSm9tPts060D46A/oOBQQqQcjEmK1Qgb1pBTgNKE00MdxG6r8K6zrG6MnZeOuWIrhr
         2LjZDN5J61YEaqVaVVAc18ptkfYGAP102uCrR2oUR8OUask7+w950KzU1YsD6sBEVqqo
         W33VrlfAq+OS1sMd1aotK7sZGGn6ywocm/FEmLwQIN+slkFRPTnSbeRTv2Vljn1gT51N
         Qpwe3CIwovu8wv67WsSLg2CMEs5ZJsmzjsXEiC/cg10xOIjmC0JCUwWBEVuWFmsNVFYW
         wKKQ==
X-Gm-Message-State: AJcUukclA3dFIk7gSJVwKiHb1n2KzNZ9o9yw5fqO+xycLtbrYBvwGfkn
        MOY/bEOO2ZcYa7w6K4tQHMMcAg==
X-Google-Smtp-Source: ALg8bN6S2LSSTkwbXEfiV7zbbXX4x9A+nE0YeIh5T7O3Cy3pZEJW9a6Jh4dS+fn7V4CINpZ1PZX4CA==
X-Received: by 2002:a17:902:24d:: with SMTP id 71mr13353580plc.225.1547706505216;
        Wed, 16 Jan 2019 22:28:25 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y29sm755820pga.59.2019.01.16.22.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 22:28:24 -0800 (PST)
Date:   Wed, 16 Jan 2019 22:27:44 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com,
        vkoul@kernel.org, niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 06/13] clk: qcom: hfpll: get parent clock names from DT
Message-ID: <20190117062744.GC25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-7-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545039990-19984-7-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 Dec 01:46 PST 2018, Jorge Ramirez-Ortiz wrote:

> Allow accessing the parent clock name required for the driver
> operation using the device tree node.
> 
> This permits extending the driver to other platforms without having to
> modify its source code.
> 
> For backwards compatibility leave the previous value as default.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  drivers/clk/qcom/hfpll.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
> index a6de7101..87b7f46 100644
> --- a/drivers/clk/qcom/hfpll.c
> +++ b/drivers/clk/qcom/hfpll.c
> @@ -52,6 +52,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
>  	void __iomem *base;
>  	struct regmap *regmap;
>  	struct clk_hfpll *h;
> +	struct clk *pclk;
>  	struct clk_init_data init = {
>  		.parent_names = (const char *[]){ "xo" },
>  		.num_parents = 1,
> @@ -75,6 +76,13 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
>  					  0, &init.name))
>  		return -ENODEV;
>  
> +	/* get parent clock from device tree (optional) */
> +	pclk = devm_clk_get(dev, "xo");
> +	if (!IS_ERR(pclk))
> +		init.parent_names = (const char *[]){ __clk_get_name(pclk) };
> +	else if (PTR_ERR(pclk) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
>  	h->d = &hdata;
>  	h->clkr.hw.init = &init;
>  	spin_lock_init(&h->lock);
> -- 
> 2.7.4
> 
