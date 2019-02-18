Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5E0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730A5218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBXtpmA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfBRExe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 23:53:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40402 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfBRExd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 23:53:33 -0500
Received: by mail-pl1-f193.google.com with SMTP id bj4so8126708plb.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 20:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j86UcfahKzsFa6NJtZ03NxMBaTCekIZNcioiQ8oFeYU=;
        b=LBXtpmA60N52gDa+seH5jDoL6QW2F6DebYVZbyyEucVuLun4F+/SozFJgjl45In7da
         41E2RJsX19yQX08JQDc/HdQPGqsFHFxPGoH1yc+n0ApRgj2Z8GaVBr5WLcwZ0nOzpA/d
         /kwtLrg+G1akRLc5gJggcmD9Fss1BKza+ul0NjBhiP8Y6em9c/as8OZWbEuvVEspbxmI
         62mBYR+Xo/mg+DtG2zU2GPVuMdTXJl9BV4utFK0zbkDp8wrr1Eu+Jl6V071TMBMWfuhA
         gzAVWEFv6zEvn/U7EqeMFYUtPSJpDd1IH4FYVIPXTTU/Mp2hk1x5sWknO7Di/xI9hLj0
         qSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j86UcfahKzsFa6NJtZ03NxMBaTCekIZNcioiQ8oFeYU=;
        b=gbM8aOJoKhN23448ohoUqEN7bK1VqRw54psgUSjsj9hBNB0q1CN7f9E/7nM9nVOiUY
         NDFFbnSxF1G785W7EqRntsCBhWhpoKo5XBuAJF0K0Kil1Sb4lju20JGaa9kzksn9x79G
         GB34QH/aZ+4wLyDotla+Yj/VTfxg8jB1sGGfuyolT2jsODNETHwewVYnuoC06050TsBy
         aQDRVKh1g4LWLCWMeSeK5RupMhgxhsWZeBg0u/+7NseFB10uXH7lCR6oMRxlGUn/qBHs
         qYP6Wli6ohQ8oERapIQeMxoGod1Wu5RXqLs2f3DnSFdrJ3OXymk+EURD1AWLqoFw9MWI
         ONpw==
X-Gm-Message-State: AHQUAuZwhWH5OthLdCSCqSVMHpjBNC2jKsz/r8nd4VC+Cx6BbPzymC07
        kh5GhqTlOMFne/QyFVAEq2Z7BA==
X-Google-Smtp-Source: AHgI3IbuhWpSM85Pnea4k/eny8phFUFt9I/rmezmrqyac75qyM2gu4PG5aDj3K9H6Qh5rgZEwegekA==
X-Received: by 2002:a17:902:be15:: with SMTP id r21mr21220479pls.143.1550465613006;
        Sun, 17 Feb 2019 20:53:33 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id y21sm14522494pfe.57.2019.02.17.20.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 20:53:32 -0800 (PST)
Date:   Mon, 18 Feb 2019 10:23:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     sudeep.holla@arm.com, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scmi: fix use-after-free in scmi_cpufreq_exit()
Message-ID: <20190218045330.zpiivw7mvv4hzctq@vireshk-i7>
References: <20190216163148.12375-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216163148.12375-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-02-19, 11:31, Yangtao Li wrote:
> This issue was detected with the help of Coccinelle. So
> change the order of function calls to fix it.
> 
> Fixes: 1690d8bb91e37 (cpufreq: scpi/scmi: Fix freeing of dynamic OPPs)
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 242c3370544e..9ed46d188cb5 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -187,8 +187,8 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
>  
>  	cpufreq_cooling_unregister(priv->cdev);
>  	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
> -	kfree(priv);
>  	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
> +	kfree(priv);
>  
>  	return 0;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

@Rafael: Please pick it up for 5.0-rc8 as the bug was introduced
during 5.0 cycle only.

The patch it fixes had this tag:

    Cc: 4.20 <stable@vger.kernel.org> # v4.20

And so will get applied to 4.20.N, I guess we need to mark this patch
as well for stable then.

-- 
viresh
