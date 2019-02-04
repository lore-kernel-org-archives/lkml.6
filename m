Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ECBC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFC4217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GXitPmOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfBDGgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 01:36:19 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44101 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfBDGgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 01:36:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id y1so2023669pgk.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 22:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NcAfQicxXWZTrt/Hfspenng77Exh6TkaR7mUfzin5V8=;
        b=GXitPmOkzB2jmq4G84ioIx/ZLngUmLtIuQ9LSK/IKW2bxwMbkV5kVVd7fsERwH92W/
         wTyXJpeKeh6lZud0en4CjPtJHMl0ROt3aGEF+C/KVIx66lHwKgg0vU0zWwnkKBRUDPbl
         WEmXIVK6c2AL+STOJioyuH89xQhqPFWETjkQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NcAfQicxXWZTrt/Hfspenng77Exh6TkaR7mUfzin5V8=;
        b=hmeVdfUJRJjz3gK3rHW1NbhKs5m9R7VeZNHhw0Mzkt8ymf40AhsczdSiMlAIy9cOnc
         Lzvs540wReY7JuXHNfOaAni8rK8iWB2kskAmZ6WEtP/XRkowZ+6QL2WKKkdFVVIsqMwc
         QnIMqUfH8JHSfZLze4gYY5XLSB5n2ziC3CWachfDsGKohJviMESwZFPplrH8AHdmb6gX
         kOGQTp6pHY5KOfY5xgIn/9nL3HaulBP4oezGJFJCskDHQ+6ZS2+bUhQ7Dwo2x8Fh6pEx
         HC5PqzVNh7dx+L1Vhilv1J3HKptoUDDARPdWxnKuMcpeZ3bIAstw5ZiargfxenGudFAJ
         PEBA==
X-Gm-Message-State: AJcUukfn5GoA4UHiyjLaqB8FZl+Alup15RdsOimweWY3F47wkhKTFsUz
        JOhm4H3waQQVthti3RjkSwbEJw==
X-Google-Smtp-Source: ALg8bN5/YwqWBKjgYi0cDYpqVO3NmYVDscXG+aCQVna6kHKZf0O3hqlL/eBqdhw1+tkfw3OhK8Asiw==
X-Received: by 2002:a62:4d81:: with SMTP id a123mr51388550pfb.122.1549262178038;
        Sun, 03 Feb 2019 22:36:18 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id c13sm34170785pfe.93.2019.02.03.22.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 22:36:17 -0800 (PST)
Date:   Mon, 4 Feb 2019 12:06:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: tegra124: add missing of_node_put()
Message-ID: <20190204063615.yr4fbz3b7ovbm7a2@vireshk-i7>
References: <20190204063501.1348-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204063501.1348-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-02-19, 01:35, Yangtao Li wrote:
> of_cpu_device_node_get() will increase the refcount of device_node,
> it is necessary to call of_node_put() at the end to release the
> refcount.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/tegra124-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
> index 43530254201a..140a9266b64a 100644
> --- a/drivers/cpufreq/tegra124-cpufreq.c
> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> @@ -118,6 +118,8 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
>  		goto out_put_pllx_clk;
>  	}
>  
> +	of_node_put(np);
> +
>  	ret = tegra124_cpu_switch_to_dfll(priv);
>  	if (ret)
>  		goto out_put_pllp_clk;

Fixes and stable tags ?

-- 
viresh
