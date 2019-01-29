Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEA1C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CD420989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDQaRPr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfA2KNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:13:53 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38744 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfA2KNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:13:53 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so8550829pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 02:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L49h9QkNpx56q8oRbtd1NcnocQ6XxJWs8GSZnc/Zph4=;
        b=XDQaRPr93DDmkZEmzuJ+TObX882ASIJojbiUZq2HzpG6cr0Ejn6xCtoH8l0c273eBP
         frKjTruEPxlhxzCi5M44Z54W8Rh1E6wNJK/Wjzu+8zwvuk6JwRouFOi3yI0JOwIvsmxm
         0hBy6i9KHBaMdL5EHVbQHyHMmsUsEHrXWbLOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L49h9QkNpx56q8oRbtd1NcnocQ6XxJWs8GSZnc/Zph4=;
        b=j/H96UMMAur9+Zj2/F0tVwd0sIvSPQbCHV/EYCLunCOqQO9WEQv3RcJ4K083HIFxlx
         hozrDIzm4bSBfqsiswCEclvbJeirA7nu0qCs4fh+b9vchlZcpGXSLuTWXpPRLwPh3p/0
         ZVvcEoXPG0um7+JPEqQAI2sC57ZXA4MGVmvcnfSou/rnPuCmGN6Yj/QpNMoKQDHbrOg7
         hT7nm0DdLx4OD+DnLpPLVB1KdKwnCzDuvBsozcjkWBRiVnzvDfoQ4kweqODduDHEoQ2e
         BqysyXlBJN1VOlPP292O71dUDR8cIi2Zn5oXgb0lYmUiAZcppvw21gkV1G21uvyHz7a9
         AiCw==
X-Gm-Message-State: AJcUukcEW+KZYhXgBGPCGgJhFx/uHZWX/odxUTZQWNq1Ez+sjWkVW1Tm
        j9hURPTiwg4wV6bVNcsRlxSv9w==
X-Google-Smtp-Source: ALg8bN46Hih6fDtXHr4hYfD3+O5Kms3cLJ2qozDpyOBc6SSOuts7EIkQraPQoRySbp7+DrqmvQsIuQ==
X-Received: by 2002:a62:798f:: with SMTP id u137mr25766277pfc.168.1548756832251;
        Tue, 29 Jan 2019 02:13:52 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id w6sm29978653pga.72.2019.01.29.02.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 02:13:50 -0800 (PST)
Date:   Tue, 29 Jan 2019 15:43:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, fan.chen@mediatek.com
Subject: Re: [PATCH 1/3] cpufreq: mediatek: add mt8183 cpufreq support
Message-ID: <20190129101348.7oxqerszhcopanzr@vireshk-i7>
References: <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1548743704-16821-2-git-send-email-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548743704-16821-2-git-send-email-andrew-sh.cheng@mediatek.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-01-19, 14:35, Andrew-sh Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> For new mediatek chip mt8183,
> cci and little cluster share the same buck,
> so need to modify the attribute of regulator from exclusive to optional
> 
> Intermediate clock is not always enabled by ccf in different projects,
> so cpufreq should always enable it by itself.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  drivers/cpufreq/mediatek-cpufreq.c   | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index b1c5468..5a1c588 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -117,6 +117,7 @@
>  	{ .compatible = "mediatek,mt817x", },
>  	{ .compatible = "mediatek,mt8173", },
>  	{ .compatible = "mediatek,mt8176", },
> +	{ .compatible = "mediatek,mt8183", },
>  
>  	{ .compatible = "nvidia,tegra124", },
>  
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index eb8920d..e956248 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -355,7 +355,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  		goto out_free_resources;
>  	}
>  
> -	proc_reg = regulator_get_exclusive(cpu_dev, "proc");
> +	proc_reg = regulator_get_optional(cpu_dev, "proc");
>  	if (IS_ERR(proc_reg)) {
>  		if (PTR_ERR(proc_reg) == -EPROBE_DEFER)
>  			pr_warn("proc regulator for cpu%d not ready, retry.\n",
> @@ -385,6 +385,9 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  		goto out_free_resources;
>  	}
>  
> +	ret = clk_prepare_enable(inter_clk);
> +	if (ret)
> +		goto out_free_resources;

Add a blank line here please.

Also out_free_resources isn't enough here and you need to free OPP table as
well.


>  	/* Search a safe voltage for intermediate frequency. */
>  	rate = clk_get_rate(inter_clk);
>  	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
> @@ -412,6 +415,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  
>  out_free_opp_table:
>  	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
> +	clk_disable_unprepare(inter_clk);

Clock was enabled after adding the table, and so it must be disabled before
removing the table. Just the opposite sequence.

>  
>  out_free_resources:
>  	if (!IS_ERR(proc_reg))
> @@ -551,6 +555,7 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
>  	{ .compatible = "mediatek,mt817x", },
>  	{ .compatible = "mediatek,mt8173", },
>  	{ .compatible = "mediatek,mt8176", },
> +	{ .compatible = "mediatek,mt8183", },
>  
>  	{ }
>  };
> -- 
> 1.8.1.1.dirty

-- 
viresh
