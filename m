Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A8EC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601362177E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5xevF4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfBDGbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 01:31:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36933 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfBDGbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 01:31:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so6307360pfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 22:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GgKHHuhs9dnQ4YnB72TOVBL4aSIVvL7IYx53gzABlxY=;
        b=Q5xevF4VVfTFbBAe7n13CoypDlUZx0Nhd+p/xQNpNrEnNqckhMAUZgCLvhGh9LWP5t
         bBgZ0H0LRoab19WUVgsUBFpTlVNjMxdvS8NKritTDJBCIkchNnopugWPa9T1G5Fwddm+
         1UTEGpYfuasMuppbSTUNhYh6kuvjH0n8wYNb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GgKHHuhs9dnQ4YnB72TOVBL4aSIVvL7IYx53gzABlxY=;
        b=Es/X+Ju7IMjEulP3HCFap9s7H5zlFOwEKhIYSpDhnv3Bp4Vqedhd9yNPT7k8QaXTVs
         bHNdhNmZW+vyvEdHSbMKCJaN2BycDiYpV9sA7+z4EWMhHxET5/quFvnTJ+pBWFOv1M50
         4adiRy5vRkVMefRBC/etpMqH8PYHd2fW7D/h+njvH6NJ+t7TlctyMx3ZjyBVAHoZtuOm
         IWAaDCQgzX7bcoH0RqoMabhCVZTtUdkxhyGgfbOd65NS2apVl3rCBinQIFVL6CLCyUkP
         n6fUEZ4rVVg+MV3i1jVhKGTTJUqT6fXyz6YytENNN/7IugbC39s/XTnJqpywfY8gcyCy
         KkwA==
X-Gm-Message-State: AJcUukeNPQku1j/+aDlyu+rtl+Oy5SEPuh17xXhwLdA0D6xArLeImg6K
        TEUxd44oN5ewzTqEMTS6f1Obyw==
X-Google-Smtp-Source: ALg8bN5EFrMU0emeXIbI8+2OH5A01XajS4BrsC1llLpppkT2nwCY/HOY7j+N+F7CORnfkMnGcrWipA==
X-Received: by 2002:a63:5664:: with SMTP id g36mr44751758pgm.313.1549261863643;
        Sun, 03 Feb 2019 22:31:03 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id q187sm35017931pfq.128.2019.02.03.22.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 22:31:02 -0800 (PST)
Date:   Mon, 4 Feb 2019 12:01:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     ilia.lin@gmail.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-kryo: make some variables static
Message-ID: <20190204063100.v3ebrh52hm5kxxtw@vireshk-i7>
References: <20190204061310.1211-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204061310.1211-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-02-19, 01:13, Yangtao Li wrote:
> The variables are local to the source and do not
> need to be in global scope, so make them static.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index 2a3675c24032..1c8583cc06a2 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -42,7 +42,7 @@ enum _msm8996_version {
>  	NUM_OF_MSM8996_VERSIONS,
>  };
>  
> -struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
> +static struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
>  
>  static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
>  {

Applied. Thanks.

-- 
viresh
