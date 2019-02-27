Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CC7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D63218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L8uPvWsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfB0Hwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 02:52:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39179 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfB0Hwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 02:52:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id h8so7042228pgp.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 23:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XSrAlgG6VhJedlmr+pQmi+EgS9OsXLXzjmZGc5W4rpk=;
        b=L8uPvWsXSaMxb4tj8+Oo2q0w8P2HO6d9Nl07Wd6Ic3s+3AnpLFdO2OiNZAnMZKWf+A
         lGrHlSy+Y34CnXLV/hASCsHzsKXRNjtZpUzH/3Ll9pdmJ+dkS6FNt/Fe2nIfR5BlIYwx
         j4vkk+Lgpr8j2Va9QotPXP1VMHObdXHAZtce0ILqT+maY1mnz2LSHjusbWo2g3EwjJjR
         SPeuh8ssUwahoYECqkckQkrGpNOxglUmWqntpPQQAUetpcTK9vUN1BukthsvooDIbBOf
         uQ+Fya7wcr6cG3OAY0DVpin8IP4fnSrGx8UrpYoVOd1gaFLpJjOVEXtHTOGcc/adNi1d
         gxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XSrAlgG6VhJedlmr+pQmi+EgS9OsXLXzjmZGc5W4rpk=;
        b=d310iGFC6aV21ZtUSM1d666i5z6xpiEsT6NmJOe+NTqIehWws2n03wxpLyUQm839+3
         WHLmw7a5HPuC8Yj2XnnEkhzOn6qsMEeFQHeG17MRCIi1t0whq/nIa2eFpDCVu4sSx+ct
         RpvaCxQW2A4GIFmunKdUVreMRisI9gDEd5Xg17sV+97mCJ1xlIbR7Fgl0fWv3x4nbiNI
         j69AtHQqcJxdhqxoIy0SrSyg5HY0tZm5R/aA2a1/6td4Be6Uay7AW27TKhBQ4qcIrhR0
         d5Yx5iQ+SWstXyWx1WlSBJyuavY4H2/iWmXCUsoD4bFEN6rtxcgA6bgjdpgtoIs/MNa6
         M6BQ==
X-Gm-Message-State: AHQUAubqdtR1Z5kEyYMMM4p0I1WEh30wSucWjNdbLgP98kf+/Z+ro87Z
        CU0Q0cWuW23902SGlUSQfWXvsg==
X-Google-Smtp-Source: AHgI3IbWdQb6N1Exu/UvT1XGm3k1fOSmBov7Zog1KlVCrePFLgm8PH7SXbhBRd60JWudnhevhRvUpg==
X-Received: by 2002:a63:3193:: with SMTP id x141mr1561015pgx.438.1551253949488;
        Tue, 26 Feb 2019 23:52:29 -0800 (PST)
Received: from localhost ([122.167.168.92])
        by smtp.gmail.com with ESMTPSA id t23sm22570443pfa.111.2019.02.26.23.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 23:52:24 -0800 (PST)
Date:   Wed, 27 Feb 2019 13:22:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, Ilia Lin <ilia.lin@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: kyro: Reduce frame-size of
 qcom_cpufreq_kryo_probe()
Message-ID: <20190227075222.ib7qg6ycrwyztms5@vireshk-i7>
References: <5919a74b74f466e803e07f70136517119dcd4560.1550661235.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5919a74b74f466e803e07f70136517119dcd4560.1550661235.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-02-19, 16:44, Viresh Kumar wrote:
> With the introduction of commit 846a415bf440 ("arm64: default NR_CPUS to
> 256"), we have started getting following compilation warning:
> 
> qcom-cpufreq-kryo.c:168:1: warning: the frame size of 2160 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> 
> Fix that by dynamically allocating opp_tables and freeing it later.
> 
> Compile tested only.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index 1c8583cc06a2..6888cb6db2ef 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -75,7 +75,7 @@ static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
>  
>  static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  {
> -	struct opp_table *opp_tables[NR_CPUS] = {0};
> +	struct opp_table **opp_tables;
>  	enum _msm8996_version msm8996_version;
>  	struct nvmem_cell *speedbin_nvmem;
>  	struct device_node *np;
> @@ -133,6 +133,10 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  	}
>  	kfree(speedbin);
>  
> +	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables), GFP_KERNEL);
> +	if (!opp_tables)
> +		return -ENOMEM;
> +
>  	for_each_possible_cpu(cpu) {
>  		cpu_dev = get_cpu_device(cpu);
>  		if (NULL == cpu_dev) {
> @@ -149,6 +153,8 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	kfree(opp_tables);
> +
>  	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
>  							  NULL, 0);
>  	if (!IS_ERR(cpufreq_dt_pdev))

We can fail here and then we will try to use opp_tables which is already freed.

I wonder how this stupid patch made it through the reviews :)

> @@ -163,6 +169,7 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  			break;
>  		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
>  	}
> +	kfree(opp_tables);
>  
>  	return ret;
>  }

Having said that, there is another problem which I just noticed in the remove()
path where we don't call dev_pm_opp_put_supported_hw(). That will create
problems if we try to remove module of this driver and then reinstall it as the
OPP table was never freed. The fix for that problem needs to go into stable
kernels past 4.18 and so I will abandon this patch and send a new fix which will
fix the issues of $subject patch as well.

-- 
viresh
