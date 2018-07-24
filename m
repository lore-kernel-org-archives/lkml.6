Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870F2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4276620852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eWUZz/+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4276620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388415AbeGXEsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:48:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38353 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388090AbeGXEsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:48:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3-v6so1844978pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 20:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bOhIYe6UupxbH7LStmIXmTkyDfRXjBoLkxZNjDd47bM=;
        b=eWUZz/+F5ZwOsdInhU4cbvOT9Ld4xVyz4QIMwWFLVDebUGVkDAAY5t073O7hdonQ92
         yASJzPgxRLYNfMZWr/8zmioeUgq54tpWVTlqGbkk8H5sYF6oVA89YtPdo71th6xznlHx
         /2FBs8MbVn/rCz4hUMyAI7fhAYhlUnh/MJFZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bOhIYe6UupxbH7LStmIXmTkyDfRXjBoLkxZNjDd47bM=;
        b=UvbzAfWbpT1AFiL/nhcRtCUBWkUwiypD6Ex43pRjAuz8oyq485tRluslv28GdTqfQH
         vDMP23ac8En8z9rz9nOgfvNezNqU0up2h1gnaOtgQHJebd12IrWmfZZlBLI5J4q3S1Sj
         +eXbRmnxfF1nNJv/8ePfK2ON62rYb3W2S1ew+2wewTHhdbkYXxl3QuZqYGzGYSj3hesA
         kvW2I2WK1bbq2swllenQD8KsR5zVeNE55LrGzSUMfCN2KnuvdgF98sDiO030QQOiokmb
         M2bXCQCCOyGsBJ3P4Mz7i9wmKQBE2FZ4VRGpulMzE7u7HB0MeLA5mtQSd3f2psuR9TiF
         ZcNQ==
X-Gm-Message-State: AOUpUlFLE/nxIY+8gkgJq+fRDu2XcpwAfxg4iWbfBcZhWoyCV6diohn0
        OfmKD2Pb5xfWj/xTbKNw765PUg==
X-Google-Smtp-Source: AAOMgpfzUW8Tvh4fxUvd0I5puBw3DFjDhJwLKClCdEG1Jzk1hpFh3ZeRI7Qfp5bMEVwQoqbIcgPbfQ==
X-Received: by 2002:a65:6258:: with SMTP id q24-v6mr14670123pgv.131.1532403818874;
        Mon, 23 Jul 2018 20:43:38 -0700 (PDT)
Received: from localhost ([122.172.132.125])
        by smtp.gmail.com with ESMTPSA id b11-v6sm12131002pgw.79.2018.07.23.20.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 20:43:37 -0700 (PDT)
Date:   Tue, 24 Jul 2018 09:13:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     ilia.lin@gmail.com, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-kryo: add NULL entry to the end
 of_device_id array
Message-ID: <20180724034335.v76tfqk2imlyf2eg@vireshk-i7>
References: <20180723123429.20040-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723123429.20040-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-18, 20:34, YueHaibing wrote:
> Make sure of_device_id tables are NULL terminated
> Found by coccinelle spatch "misc/of_table.cocci"
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index 29389ac..efc9a7a 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -183,6 +183,7 @@ static struct platform_driver qcom_cpufreq_kryo_driver = {
>  static const struct of_device_id qcom_cpufreq_kryo_match_list[] __initconst = {
>  	{ .compatible = "qcom,apq8096", },
>  	{ .compatible = "qcom,msm8996", },
> +	{}
>  };
>  
>  /*

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
