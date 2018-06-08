Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KssJCSQGGlvwBgAAmS7hNA
	; Fri, 08 Jun 2018 04:29:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 177C96074D; Fri,  8 Jun 2018 04:29:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1BfT0kA"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 882C460290;
	Fri,  8 Jun 2018 04:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 882C460290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbeFHE3X (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 00:29:23 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44122 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeFHE3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 00:29:21 -0400
Received: by mail-pg0-f67.google.com with SMTP id p21-v6so5766593pgd.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 21:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DXA69csit/S+qXuxygjuAEUvNn+Jw/K1u34cJ5J37nA=;
        b=L1BfT0kAuqk7tyqYt6pVJlGgz9ehRwiB0UkuHJT3aF5RheWVPnQoUx4UFsj8++b/Ho
         qgCNVNhe01tQyRiw7S4X/0RcZNDOmSBrQWiqt8D6+k4cj+8QDy4L+DYYQ1JW7J7kMeJ4
         xa2nCksxz3sbm3TGFo1s3KDVuGb5ffUyuvZww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DXA69csit/S+qXuxygjuAEUvNn+Jw/K1u34cJ5J37nA=;
        b=FpvyJLqrzNb6A7m/Ap17bCyfHqmDRbIasyRfxvg2FB2tK6GSkGGqBRsuTp2i+SdFaI
         P3frquSuHRuqU3X5xI/b46VThoZIl4gippiEdhdByc7uIA6VoT/loxlUn8Se95E2pEz3
         eTkm7YAYH6rD6cscnRL66A3UL2JWgSFbqqWjLjXZyiDGjkWywtmkAdxWFSC0M9PhxT0F
         1FUH3xhSNjlk8ShoXWL3NhM8nXI0AExZqnk/780vBnDdpUPnzENkXbHO/ZqLUe9DClMI
         u9T5NHi5NnlEOG+ka2L9BwpJSFkOEXuUjfruvKm0AiFO4ZTDxL9CXBU1lRuNa8w13rBd
         dYAw==
X-Gm-Message-State: APt69E1Zye56JViGDm/xhZfJSNePv4LsbxtfWbj0MBiRiZDt4raIJshP
        +Ao9VGLxSwt6KsN7jc0gmhuRCQ==
X-Google-Smtp-Source: ADUXVKIXlDrfWX2ryVk+48HRtc18umH61VR2ckF990wktUZShiSESt8aR5lRtVqN7YtGfofhdh+60w==
X-Received: by 2002:a63:6383:: with SMTP id x125-v6mr3744611pgb.277.1528432160970;
        Thu, 07 Jun 2018 21:29:20 -0700 (PDT)
Received: from localhost ([223.226.91.101])
        by smtp.gmail.com with ESMTPSA id p12-v6sm74780978pgn.26.2018.06.07.21.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 21:29:19 -0700 (PDT)
Date: Fri, 8 Jun 2018 09:59:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: ilia.lin@gmail.com
Cc: Ilia Lin <ilialin@codeaurora.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: kryo: Add module remove and exit
Message-ID: <20180608042917.2t3el22xgwaezuqe@vireshk-i7>
References: <20180607205827.1588-1-ilia.lin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607205827.1588-1-ilia.lin@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-06-18, 20:58, ilia.lin@gmail.com wrote:
> From: Ilia Lin <ilia.lin@gmail.com>
> 
> Add device remove and module exit code to make the driver
> functioning as a loadable module.
> 
> Fixes: ac28927659be (cpufreq: kryo: allow building as a loadable module)
> Signed-off-by: Ilia Lin <ilia.lin@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index d049fe4b80c4..a08de0253169 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -71,10 +71,10 @@ static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
>  	return version;
>  }
>  
> +struct platform_device *cpufreq_dt_pdev;

Move this and the other platform device pointer at the top of the file after the
enum declarations. They don't look nice in the middle of nowhere.

>  static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  {
>  	struct opp_table *opp_tables[NR_CPUS] = {0};
> -	struct platform_device *cpufreq_dt_pdev;
>  	enum _msm8996_version msm8996_version;
>  	struct nvmem_cell *speedbin_nvmem;
>  	struct device_node *np;
> @@ -115,6 +115,8 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  
>  	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
>  	nvmem_cell_put(speedbin_nvmem);
> +	if (IS_ERR(speedbin))
> +		return PTR_ERR(speedbin);

This doesn't look related to this patch. Should it be a different commit ?

And I just saw definition of nvmem_cell_read() and it says the returned buffer
must be freed by caller using kfree(). I dont' see you doing that. Please also
check if any other such resources are there which you forgot to free.

>  
>  	switch (msm8996_version) {
>  	case MSM8996_V3:
> @@ -162,8 +164,15 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int qcom_cpufreq_kryo_remove(struct platform_device *pdev)
> +{
> +	platform_device_unregister(cpufreq_dt_pdev);
> +	return 0;
> +}
> +
>  static struct platform_driver qcom_cpufreq_kryo_driver = {
>  	.probe = qcom_cpufreq_kryo_probe,
> +	.remove = qcom_cpufreq_kryo_remove,
>  	.driver = {
>  		.name = "qcom-cpufreq-kryo",
>  	},
> @@ -174,6 +183,7 @@ static const struct of_device_id qcom_cpufreq_kryo_match_list[] __initconst = {
>  	{ .compatible = "qcom,msm8996", },
>  };
>  
> +struct platform_device *kryo_cpufreq_pdev;
>  /*
>   * Since the driver depends on smem and nvmem drivers, which may
>   * return EPROBE_DEFER, all the real activity is done in the probe,
> @@ -198,8 +208,9 @@ static int __init qcom_cpufreq_kryo_init(void)
>  	if (unlikely(ret < 0))
>  		return ret;
>  
> -	ret = PTR_ERR_OR_ZERO(platform_device_register_simple(
> -		"qcom-cpufreq-kryo", -1, NULL, 0));
> +	kryo_cpufreq_pdev = platform_device_register_simple(
> +		"qcom-cpufreq-kryo", -1, NULL, 0);
> +	ret = PTR_ERR_OR_ZERO(kryo_cpufreq_pdev);
>  	if (0 == ret)
>  		return 0;
>  
> @@ -208,5 +219,12 @@ static int __init qcom_cpufreq_kryo_init(void)
>  }
>  module_init(qcom_cpufreq_kryo_init);
>  
> +static void __init qcom_cpufreq_kryo_exit(void)
> +{
> +	platform_device_unregister(kryo_cpufreq_pdev);
> +	platform_driver_unregister(&qcom_cpufreq_kryo_driver);
> +}
> +module_exit(qcom_cpufreq_kryo_exit);
> +
>  MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Kryo CPUfreq driver");
>  MODULE_LICENSE("GPL v2");

-- 
viresh
