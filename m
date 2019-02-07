Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A65C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4B62175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hG2TbAlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfBGEgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 23:36:51 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40906 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfBGEgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 23:36:50 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so4210275plq.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 20:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NuUiTdg5faxJQ7kf4yF64nJPbGTKexW/SjO3fjwu6H0=;
        b=hG2TbAlYeEHPlM0Z7Z/IAjrIMU/NmZugk5Qjhq6xqp5dnBIzB6Z/D+iwwjw/pxpcEe
         NxrIsNyNCYWFgCBVD+9KlmoxFosXKrR71DxlZ/JYtTlHzdauYc8Z2yWD6dOcpOliNkLl
         c4pufYAE4Wtd7Nu7xcwO2t+ptqDuBveovFXqzSolNK8AXi5zNZV3fs/LV/UauSl1dOPf
         jvUJjnXthfGHXmnQc9mV9BMnvbAHFZVqyyvOaClQu8ceK/5D4gEdwx0XC/62OtmRWqqO
         5QlelI8WRl1xiAaRy5GxhqzyR+sc6YOFa8Cte1lNh3e/fn18LQykya/LHlMsJzyVAUC7
         mnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NuUiTdg5faxJQ7kf4yF64nJPbGTKexW/SjO3fjwu6H0=;
        b=qV6mkaC/YkIvDnjWRCCthIPWYRshEQXdeD17+7+tMf3LfZtk/kS1zni3pZStEs198J
         cdXcYjHUiqkcCnojZIyM1peb+GcIEsUeDjop7M27YWnPF5uDTqODHdDRirVRBQmEu/Dk
         EsP8HvfSVxgRmLpwwj6NUVNCV05nHnEZmO+jFcTao6yiQeglKihhXJJIOAGJItgdsYyk
         VD39pp7dOnq2p7hEu+KT18FnJdeGftayyGs/ApK9HvmafexnWRDku8TnOhbwDbzmmQs5
         PI9C6loAu2yFyV6EutPj/J6LPj6eiaLODU8RXOZ1vIYB8JtmM9/5VraDkIfttZ2UUhpa
         LzBg==
X-Gm-Message-State: AHQUAuaF8hIBjpBd9EJmst6SmWmqUaDLYu241EtnPYoDiPP1ZwFIn4dC
        HJJzFjTDVLaejrjkZ5TydtoBI1pem8c=
X-Google-Smtp-Source: AHgI3IYmih4NONambW7IElrCsRCZ21TgxgM5TRgLXealSqMxoOiLoSMGRGZPcjxzWUlE4fttPmgA1Q==
X-Received: by 2002:a17:902:9687:: with SMTP id n7mr14158456plp.94.1549514209927;
        Wed, 06 Feb 2019 20:36:49 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id n74sm26378205pfi.163.2019.02.06.20.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 20:36:49 -0800 (PST)
Date:   Thu, 7 Feb 2019 10:06:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: linux-next: manual merge of the opp tree with the cpufreq-arm
 tree
Message-ID: <20190207043647.qc6kxeigxytts5nu@vireshk-i7>
References: <20190207114726.741da653@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207114726.741da653@canb.auug.org.au>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-02-19, 11:47, Stephen Rothwell wrote:
> Hi Viresh,
> 
> Today's linux-next merge of the opp tree got a conflict in:
> 
>   drivers/cpufreq/qcom-cpufreq-hw.c
> 
> between commit:
> 
>   5471b2c9bd08 ("cpufreq: qcom: Read voltage LUT and populate OPP")
> 
> from the cpufreq-arm tree and commit:
> 
>   597457d7e054 ("cpufreq: qcom-hw: Register an Energy Model")
> 
> from the opp tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/cpufreq/qcom-cpufreq-hw.c
> index 15f31e8c09c2,a16b9dca7ea3..000000000000
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@@ -224,13 -205,8 +224,15 @@@ static int qcom_cpufreq_hw_cpu_init(str
>   		goto error;
>   	}
>   
>  +	ret = dev_pm_opp_get_opp_count(cpu_dev);
>  +	if (ret <= 0) {
>  +		dev_err(cpu_dev, "Failed to add OPPs\n");
>  +		ret = -ENODEV;
>  +		goto error;
>  +	}
>  +
> + 	dev_pm_opp_of_register_em(policy->cpus);
> + 
>   	policy->fast_switch_possible = true;
>   
>   	return 0;

Thanks, I have taken care of it now. You shouldn't see it anymore.

-- 
viresh
