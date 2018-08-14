Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E98C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4582171F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RaKt7meZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4582171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeHOCci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 22:32:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44178 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeHOCci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 22:32:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so9934635pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 16:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g4VIrSueUoq6F7T0yzJ4DleX3lcg5l2kONCb9/NAitU=;
        b=RaKt7meZenlphBRx7e8dNjHEHUrJqu5FaQZG3hId7hWbdUGwTJDcyHX4TI4byrfPY1
         8nkmRtaAIpT6UhxueA3R4iQhCmM37RWmkFGVvw3/500BQ8k8lWYE/OUVp0HISdXknWJY
         2dBvrFf2/6KxRb0I+jpZeho+DhQG5wp1bN0U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g4VIrSueUoq6F7T0yzJ4DleX3lcg5l2kONCb9/NAitU=;
        b=kJJKHcTMm+DVDClmZ5zDTVCCzRD8F/2b9uv3QwJ/tSIpfanajcX5kmmeysv15N8yu9
         Mwa+uKeXOBH+9GFcSniRW1T96TELMeMIQ+hkQ3+/FkkVwfm26XQoGdKMixXQrdhL49f1
         EnUkgmU595uWj5p/KbHuDmssIWP6rpG+0XWcB3tOzTB28WhXmC1iMeMFcaFviPxrW5OO
         LlN5/tiXBKdSN/rg1kaINwZkomRIa7gpQVpOp2eqmZVuFFihWkclOwoc02In3TOgtdOF
         biCpFq8vnMHmfW0zSSAO0MhhZWhlqJx/0SLxy/ea2jW9zzjsOUxEvvLbc5tfD8GBlM0P
         gIew==
X-Gm-Message-State: AOUpUlHHIfc9tj3AyeYC8M+iFEUCZfof/BD2/J9oyOTy+WUiQQlteGvo
        5Th5MQivNMwzDo/hQPcfdiuYWw==
X-Google-Smtp-Source: AA+uWPyE7k59yE/FdXCDSfsbQV1M1ExajBCDlySms+Ln80w7XZ6ovHUG1wMNNQhtme86nSp/lzqfng==
X-Received: by 2002:a63:790b:: with SMTP id u11-v6mr22840111pgc.111.1534290186000;
        Tue, 14 Aug 2018 16:43:06 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y27-v6sm54915479pff.181.2018.08.14.16.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 16:43:04 -0700 (PDT)
Date:   Tue, 14 Aug 2018 17:43:02 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com
Subject: Re: [PATCH 09/13] coresight: etmx: Claim devices before use
Message-ID: <20180814234302.GA8196@xps15>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
 <1533562915-21558-10-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533562915-21558-10-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 02:41:51PM +0100, Suzuki K Poulose wrote:
> Use the CLAIM tags to grab the device for self-hosted usage.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm3x.c | 18 +++++++++++++++---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 15 ++++++++++++---
>  2 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index 771691c..b810bbc 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -357,7 +357,7 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
>  
>  static int etm_enable_hw(struct etm_drvdata *drvdata)
>  {
> -	int i;
> +	int i, rc;
>  	u32 etmcr;
>  	struct etm_config *config = &drvdata->config;
>  
> @@ -369,6 +369,9 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>  	etm_set_pwrup(drvdata);
>  	/* Make sure all registers are accessible */
>  	etm_os_unlock(drvdata);
> +	rc = coresight_claim_device_unlocked(drvdata->base);
> +	if (rc)
> +		goto done;
>  
>  	etm_set_prog(drvdata);
>  
> @@ -417,10 +420,15 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>  	etm_writel(drvdata, 0x0, ETMVMIDCVR);
>  
>  	etm_clr_prog(drvdata);
> +
> +done:
> +	if (rc)
> +		etm_set_pwrdwn(drvdata);
>  	CS_LOCK(drvdata->base);
>  
> -	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
> -	return 0;
> +	dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
> +		drvdata->cpu, rc);
> +	return rc;
>  }
>  
>  struct etm_enable_arg {
> @@ -561,6 +569,8 @@ static void etm_disable_hw(void *info)
>  	struct etm_config *config = &drvdata->config;
>  
>  	CS_UNLOCK(drvdata->base);
> +
> +

This is extra, please remove.

>  	etm_set_prog(drvdata);
>  
>  	/* Read back sequencer and counters for post trace analysis */
> @@ -569,6 +579,8 @@ static void etm_disable_hw(void *info)
>  	for (i = 0; i < drvdata->nr_cntr; i++)
>  		config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
>  
> +	coresight_disclaim_device_unlocked(drvdata->base);
> +
>  	etm_set_pwrdwn(drvdata);
>  	CS_LOCK(drvdata->base);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 4f9e6bb..20d1015 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -84,13 +84,17 @@ struct etm4_enable_arg {
>  
>  static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  {
> -	int i;
> +	int i, rc;
>  	struct etmv4_config *config = &drvdata->config;
>  
>  	CS_UNLOCK(drvdata->base);
>  
>  	etm4_os_unlock(drvdata);
>  
> +	rc = coresight_claim_device_unlocked(drvdata->base);
> +	if (rc)
> +		goto done;
> +
>  	/* Disable the trace unit before programming trace registers */
>  	writel_relaxed(0, drvdata->base + TRCPRGCTLR);
>  
> @@ -178,10 +182,12 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  		dev_err(drvdata->dev,
>  			"timeout while waiting for Idle Trace Status\n");
>  
> +done:
>  	CS_LOCK(drvdata->base);
>  
> -	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
> -	return 0;
> +	dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
> +		drvdata->cpu, rc);
> +	return rc;
>  }
>  
>  static void etm4_enable_hw_smp_call(void *info)
> @@ -326,6 +332,7 @@ static void etm4_disable_hw(void *info)
>  
>  	CS_UNLOCK(drvdata->base);
>  
> +

Same here.

>  	/* power can be removed from the trace unit now */
>  	control = readl_relaxed(drvdata->base + TRCPDCR);
>  	control &= ~TRCPDCR_PU;
> @@ -341,6 +348,8 @@ static void etm4_disable_hw(void *info)
>  	isb();
>  	writel_relaxed(control, drvdata->base + TRCPRGCTLR);
>  
> +	coresight_disclaim_device_unlocked(drvdata->base);
> +
>  	CS_LOCK(drvdata->base);
>  
>  	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
> -- 
> 2.7.4
> 
