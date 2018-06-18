Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCA1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E18C20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d6OIX2YR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E18C20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754572AbeFREz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 00:55:28 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45349 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753936AbeFREz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 00:55:26 -0400
Received: by mail-pl0-f67.google.com with SMTP id c23-v6so8325213plz.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 21:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N+mUPoeRV+ZCimlzTxr/kcVrlScxw00s1WJcGkEGoIY=;
        b=d6OIX2YRUG0mEzc02K763Bd1LbqVfJZc9BJ5UFLg9z9vZZOy43WCybpGXZLUK67ZNt
         4p35WKi/yxVfL4/w2Q9YuhOxqqPpAHpW1xgV4Od2uzaxXQ1Bm0cMgackyKMdMDR1YXuO
         rWbp4zk5jtYH6oVNehicfjYI79WFx78tPAjls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N+mUPoeRV+ZCimlzTxr/kcVrlScxw00s1WJcGkEGoIY=;
        b=W11ZwvRDBTduYZrSPqrxdUOBQTUS9pwcbbfNKX0V9I1w32/OTZ+sIxXjOBuMCbn3rU
         meJd8yb/uAzSQ3OxTQSQ+3XP4i0I5ZPw64L/hVOKEspIpRGvmEb85hMbuUquMDsY0Lvv
         pWY4k4cp2oBSLIz0GZQZ0EXaTf873YWyDU3CO0cho537L3bLjoOkGOtLMDJB0S9Z+hui
         MsS7j2i1x8E5n1gFrPqKwo540Nk7UPqhtPMRuKpxXL1yZJyCGCU2IBK/3jngCATLZjMX
         l1unK0sqwWyfYumJkTRsHKyOvwNq1Jw5JKBEYRi5f3e/29Zcv2LPkcfg8eotwfxYtNC5
         nEIA==
X-Gm-Message-State: APt69E1OQ3umxEEwFW1l2SdkwHfqe34Cs8G9oNbQk33AOqRfuxZRGsf7
        cYBfHBFRQiKGqggVi8B9dFLC2Lzr1OM=
X-Google-Smtp-Source: ADUXVKJerXXlKv8q4AL2b7suOUE7ZsLhrA4h8VjyRWZr4VXAIhTtACBNPER1cMNokI+6Z/9ftp6iAw==
X-Received: by 2002:a17:902:1127:: with SMTP id d36-v6mr12579413pla.267.1529297726314;
        Sun, 17 Jun 2018 21:55:26 -0700 (PDT)
Received: from localhost ([122.172.130.27])
        by smtp.gmail.com with ESMTPSA id 74-v6sm4155970pfj.127.2018.06.17.21.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 21:55:25 -0700 (PDT)
Date:   Mon, 18 Jun 2018 10:25:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ilia.lin@gmail.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: kryo: Fix possible error code dereference
Message-ID: <20180618045523.p5keat3323wymvpu@vireshk-i7>
References: <20180614202921.32535-1-ilia.lin@gmail.com>
 <20180617195842.22818-1-ilia.lin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180617195842.22818-1-ilia.lin@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-06-18, 21:58, ilia.lin@gmail.com wrote:
> From: Ilia Lin <ilia.lin@gmail.com>
> 
> In event of error returned by the nvmem_cell_read() non-pointer value
> may be dereferenced. Fix this with error handling.
> Additionally free the allocated speedbin buffer, as per the API.
> 
> Fixes: 9ce36edd1a52 (cpufreq: Add Kryo CPU scaling driver)
> Signed-off-by: Ilia Lin <ilia.lin@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index d049fe4b80c4..74b9b93d511b 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -115,6 +115,8 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  
>  	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
>  	nvmem_cell_put(speedbin_nvmem);
> +	if (IS_ERR(speedbin))
> +		return PTR_ERR(speedbin);
>  
>  	switch (msm8996_version) {
>  	case MSM8996_V3:
> @@ -127,6 +129,7 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  		BUG();
>  		break;
>  	}
> +	kfree(speedbin);
>  
>  	for_each_possible_cpu(cpu) {
>  		cpu_dev = get_cpu_device(cpu);

Ideally this should have been two patches as you were fixing two
different problems. But anyway, you can go through this time.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
