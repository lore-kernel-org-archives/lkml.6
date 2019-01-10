Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A544C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2BA2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Szooz2gC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfAJG3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:29:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33891 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfAJG3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 01:29:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so4762008plz.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 22:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LpsZpfl0yTYzLhDf1hmoX5y5LYMqU4C9oPbwgnf4+fg=;
        b=Szooz2gC8UiGiuSnjSJm8deCTvvN4isrnXDdODscKuCJ+EnTOGAg+eAWhDCCoJRU36
         wpDlhGC0tVW2sBts1zFx+QIh7WOBlMZ4V9noiZuEUMkIqI3c/Bq05x2T7MHPdSed80yE
         cCSsJ4C1mm4PXoyR7ypWc2pNXa7tFOe1WYuzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LpsZpfl0yTYzLhDf1hmoX5y5LYMqU4C9oPbwgnf4+fg=;
        b=DAzyoUMu8xICZPTzhhks+Tm6NpmLOJ/TvePVKWo2rUzY/T0LJVI9F7t/Leeb341rL6
         q7xUbzWBA9CE0CkaXZdPG5ZAXIMyBp9wIaIIR7k985Nry03w6kBSIbkRagkGoexzzkyu
         T/Qqb+4E3Xo5ZaFwHM0xNUe39DRgeAYwLgpjNHT+l+/BE6nXb76FizOkii5Hu3Dd3ACF
         zTvxEKA/6ZIRR8EHiObzhKWQnriCUnUPK8zcVAnLB9+2HBv0hj/Nn1tJ2I0uiNgvymAT
         8cI/PtJ4lZ2V9/tSR5Y+SrSL8vGMxNlg1yRX2qBQ5CKKLTz7T0JjQv98p7VklJeMcPpg
         VOYw==
X-Gm-Message-State: AJcUukfC8U0yujkBtHEiBJq3wUHEHVcw51pOr0fpcrv1yYDPco61UXsd
        9D7VgARobEoRLKY8pQjdrSpCiw==
X-Google-Smtp-Source: ALg8bN68r2TJEM5YTjXFPYcv4t9dFQYJO9HG0wNwIHaaEd2MnSqpciH2krZzPN8nPZZ4q8tfKEFdLg==
X-Received: by 2002:a17:902:4624:: with SMTP id o33mr8933459pld.289.1547101743642;
        Wed, 09 Jan 2019 22:29:03 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id k63sm151109189pfc.76.2019.01.09.22.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 22:29:02 -0800 (PST)
Date:   Thu, 10 Jan 2019 11:59:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     andy.gross@linaro.org, robh@kernel.org, sboyd@kernel.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com
Subject: Re: [PATCH v11 2/9] OPP: Add support for parsing the 'opp-level'
 property
Message-ID: <20190110062900.2cwqquwdbipxo6hb@vireshk-i7>
References: <20190110040209.6028-1-rnayak@codeaurora.org>
 <20190110040209.6028-3-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110040209.6028-3-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-01-19, 09:32, Rajendra Nayak wrote:
> Now that the OPP bindings are updated to include an optional
> 'opp-level' property, add support to parse it from device tree
> and store it as part of dev_pm_opp structure.
> Also add and export an helper 'dev_pm_opp_get_level()' that can be
> used to get the level value read from device tree when present.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/opp/core.c     | 18 ++++++++++++++++++
>  drivers/opp/of.c       |  2 ++
>  drivers/opp/opp.h      |  2 ++
>  include/linux/pm_opp.h |  7 +++++++
>  4 files changed, 29 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index e5507add8f04..90b78a122be9 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -130,6 +130,24 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
>  
> +/**
> + * dev_pm_opp_get_level() - Gets the level corresponding to an available opp
> + * @opp:	opp for which level value has to be returned for
> + *
> + * Return: level read from device tree corresponding to the opp, else
> + * return 0.
> + */
> +unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
> +{
> +	if (IS_ERR_OR_NULL(opp) || !opp->available) {
> +		pr_err("%s: Invalid parameters\n", __func__);
> +		return 0;
> +	}
> +
> +	return opp->level;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_get_level);
> +
>  /**
>   * dev_pm_opp_is_turbo() - Returns if opp is turbo OPP or not
>   * @opp: opp for which turbo mode is being verified
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 06f0f632ec47..1779f2c93291 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -594,6 +594,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  		new_opp->rate = (unsigned long)rate;
>  	}
>  
> +	of_property_read_u32(np, "opp-level", &new_opp->level);
> +
>  	/* Check if the OPP supports hardware's hierarchy of versions or not */
>  	if (!_opp_is_supported(dev, opp_table, np)) {
>  		dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index e24d81497375..4458175aa661 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -60,6 +60,7 @@ extern struct list_head opp_tables;
>   * @suspend:	true if suspend OPP
>   * @pstate: Device's power domain's performance state.
>   * @rate:	Frequency in hertz
> + * @level:	Performance level
>   * @supplies:	Power supplies voltage/current values
>   * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
>   *		frequency from any other OPP's frequency.
> @@ -80,6 +81,7 @@ struct dev_pm_opp {
>  	bool suspend;
>  	unsigned int pstate;
>  	unsigned long rate;
> +	unsigned int level;
>  
>  	struct dev_pm_opp_supply *supplies;
>  
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 0a2a88e5a383..473d2c7516f0 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -86,6 +86,8 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
>  
>  unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
>  
> +unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp);
> +
>  bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp);
>  
>  int dev_pm_opp_get_opp_count(struct device *dev);
> @@ -157,6 +159,11 @@ static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
>  	return 0;
>  }
>  
> +static inline unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
> +{
> +	return 0;
> +}
> +
>  static inline bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp)
>  {
>  	return false;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
