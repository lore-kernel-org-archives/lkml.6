Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2313C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E68520821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dC5pVdM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbfAIJMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:12:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43414 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfAIJMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:12:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so3293472plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 01:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mvAF5uZ8Aq+0Nk6HAHd7TfhJ7VbT97IZFkx2MyCCcvs=;
        b=dC5pVdM8fZ6GJmOvaWkevh8XsSd+8sHYo6+efAEbTO9yv09jVBdknkEHTKJJVDL7RO
         lReSj1W0fAaSPFEUgNVLLhko6al52H4OaDB/1WsKc9cQ59Ghs3LWYaxaF3pjI7nUWErG
         /vG9B/yLC8f3757h9DFXTWM08ThNrGvwAzCaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mvAF5uZ8Aq+0Nk6HAHd7TfhJ7VbT97IZFkx2MyCCcvs=;
        b=tMOIkFq8X6j8XAQcgfsu+OcpzIHWo30ASNgrAyNS+3n+6/NEDwbMb71FcpV+96e8Mp
         kjCpMG5aRgRmhHAx9NjR90Q0COrZk7NYWBqjtVNyiwYxYLc9aHLmRk2NhbXx6a0m0oh5
         GkdwwnZkyjxGkRBoTYzWCHTzSFjXGgn9LIRXpXW9j1cE0me8qMzSpAl/kXtkKH9IKfWd
         w3Bv/0tTH/TBbdlyEfVKqmkw+kc8wEsB1htoIy0L3Cq9SLagCXSHBZ+32GQFLGmvHUMS
         2G9M9OL02prF3/L0ZQQTphnY+6cTROQaXZ7owlJTTQ9u+h0cRZjJKzs3cs4tqHQCgRiU
         P+Cw==
X-Gm-Message-State: AJcUukdK2hCV/qK3DgVQUeMt3g9xA+M9crC5OHEh5gO/Nvgkf55fCbLO
        j5xFFhUTWVy4F0heuGA71H3yMQ==
X-Google-Smtp-Source: ALg8bN52F3Kexes7TUgAkI1oaGjZoHwixp3I3wr0FsaQOAaS0ahq9wqznCDHCQjIKrSt5KF7GKbL9Q==
X-Received: by 2002:a17:902:31a4:: with SMTP id x33mr5151166plb.41.1547025132654;
        Wed, 09 Jan 2019 01:12:12 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id x19sm119828243pfk.14.2019.01.09.01.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 01:12:11 -0800 (PST)
Date:   Wed, 9 Jan 2019 14:42:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     andy.gross@linaro.org, robh@kernel.org, sboyd@kernel.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com
Subject: Re: [PATCH v10 2/9] OPP: Add support for parsing the 'opp-level'
 property
Message-ID: <20190109091210.jw6gw5qif55p7wes@vireshk-i7>
References: <20190109090420.8100-1-rnayak@codeaurora.org>
 <20190109090420.8100-3-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109090420.8100-3-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-01-19, 14:34, Rajendra Nayak wrote:
> Now that the OPP bindings are updated to include an optional
> 'opp-level' property, add support to parse it from device tree
> and store it as part of dev_pm_opp structure.
> Also add and export an helper 'dev_pm_opp_get_level()' that can be
> used to get the level value read from device tree when present.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/opp/core.c     | 18 ++++++++++++++++++
>  drivers/opp/of.c       |  5 ++++-
>  drivers/opp/opp.h      |  2 ++
>  include/linux/pm_opp.h |  7 +++++++
>  4 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index e5507add8f04..738b1783aa65 100644
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
> + * return 0

All a full-stop here.

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
> index 06f0f632ec47..8274d3ba2c5b 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -568,7 +568,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  {
>  	struct dev_pm_opp *new_opp;
>  	u64 rate = 0;
> -	u32 val;
> +	u32 val, level = 0;
>  	int ret;
>  	bool rate_not_available = false;
>  
> @@ -594,6 +594,9 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  		new_opp->rate = (unsigned long)rate;
>  	}
>  
> +	if (!of_property_read_u32(np, "opp-level", &level))
> +		new_opp->level = level;
> +

What about 

        of_property_read_u32(np, "opp-level", &new_opp->level);

??

>  	/* Check if the OPP supports hardware's hierarchy of versions or not */
>  	if (!_opp_is_supported(dev, opp_table, np)) {
>  		dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index e24d81497375..5accdd96867d 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -60,6 +60,7 @@ extern struct list_head opp_tables;
>   * @suspend:	true if suspend OPP
>   * @pstate: Device's power domain's performance state.
>   * @rate:	Frequency in hertz
> + * @level:	level value to be comminucated to remote power manager

Just say "performance level" here. Btw, communicated was also
misspelled here.

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
-- 
viresh
