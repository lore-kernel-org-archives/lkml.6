Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B680DC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A56C2152C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDOs+3pL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A56C2152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeHOW2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:28:30 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45033 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbeHOW2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:28:30 -0400
Received: by mail-io0-f196.google.com with SMTP id q19-v6so1911695ioh.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 12:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BLKCDSV/k+zcxSthG9zvO5mepRDW16wcJUsDdqm8yr0=;
        b=UDOs+3pLeafGSyuu48FZXNAi73MpUFwZc/QSfut9RhqgMW2024NqzTqqOKgydGH6fE
         K/HOMMb9ZbGMcqV9ZvN5RSnnMf2feW3+iu1UYSMEchbrdjv5NfsYlGctPQTQW8DpQcDG
         RFuSwWsIVjgQU+ue9hIbrc+pPyz04gxd1pUzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BLKCDSV/k+zcxSthG9zvO5mepRDW16wcJUsDdqm8yr0=;
        b=F+0hPz3RoA0Iq/AxoHphPO8H0bM7TYxc5mBVyhkBxPaFsuCjDDGxnB5nKX/o1RAPP0
         clgEjKgiuayepnBWtZUlxgczHNnfLcTiGrEO9s9oINJJzKRdGL3xR4h/RF3inTECxQfn
         SPWDm1bASLTEidrPG7inwo3ia24GXHRdmfrD8Adypm12AaMODm/rCtV9iXzW+AF00NMt
         +Fe6KBlLz4ISQcoj2H22TJsVYcX46BDSoiRupcEJDedZDbkTKlg0uAdSpMVpPv5SmDJW
         ZBpUyfbpu0VwW9Ny8zjhbE3zw/f5UFiTbAOX/uOZv5eGvn0cvsUoTy1yAGfDyeKwTsB+
         K8DA==
X-Gm-Message-State: AOUpUlEx9y4bH9rHaeshaqumAOajW5IrT5MEPVc0RKhF/h+FHUWCwHVz
        yHue4Q4lUmQRRgjKIBHFXhKP3g==
X-Google-Smtp-Source: AA+uWPygXFOYLRsaxOwsFJkdPDchdnxeiE+d1pIzg5x+axUmnSaTWeTixIP5m0mzOXOayStmmXpj3A==
X-Received: by 2002:a5e:8518:: with SMTP id i24-v6mr15850020ioj.301.1534361699841;
        Wed, 15 Aug 2018 12:34:59 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id v82-v6sm9773629iod.14.2018.08.15.12.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 12:34:58 -0700 (PDT)
Date:   Wed, 15 Aug 2018 13:34:56 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com
Subject: Re: [PATCH 05/13] coresight: etm3: Add support for handling errors
Message-ID: <20180815193456.GA17954@xps15>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
 <1533562915-21558-6-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533562915-21558-6-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 02:41:47PM +0100, Suzuki K Poulose wrote:
> Add support for reporting errors back from the SMP cross
> function call for enabling ETM.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm3x.c | 42 ++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index 9ce8fba..771691c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -355,11 +355,10 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
>  	return 0;
>  }
>  
> -static void etm_enable_hw(void *info)
> +static int etm_enable_hw(struct etm_drvdata *drvdata)
>  {
>  	int i;
>  	u32 etmcr;
> -	struct etm_drvdata *drvdata = info;
>  	struct etm_config *config = &drvdata->config;
>  
>  	CS_UNLOCK(drvdata->base);
> @@ -421,6 +420,21 @@ static void etm_enable_hw(void *info)
>  	CS_LOCK(drvdata->base);
>  
>  	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
> +	return 0;
> +}
> +
> +struct etm_enable_arg {
> +	struct etm_drvdata *drvdata;
> +	int rc;
> +}

This doesn't compile a ';' is missing.

> +
> +static void etm_enable_hw_smp_call(void *info)
> +{
> +	struct etm_enable_arg *arg = info;
> +
> +	if (WARN_ON(!arg))
> +		return;
> +	arg->rc = etm_enable_hw(arg->drvdata);
>  }
>  
>  static int etm_cpu_id(struct coresight_device *csdev)
> @@ -475,14 +489,13 @@ static int etm_enable_perf(struct coresight_device *csdev,
>  	/* Configure the tracer based on the session's specifics */
>  	etm_parse_event_config(drvdata, event);
>  	/* And enable it */
> -	etm_enable_hw(drvdata);
> -
> -	return 0;
> +	return etm_enable_hw(drvdata);
>  }
>  
>  static int etm_enable_sysfs(struct coresight_device *csdev)
>  {
>  	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct etm_enable_arg arg = { 0 };
>  	int ret;
>  
>  	spin_lock(&drvdata->spinlock);
> @@ -492,20 +505,21 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
>  	 * hw configuration will take place on the local CPU during bring up.
>  	 */
>  	if (cpu_online(drvdata->cpu)) {
> +		arg.drvdata = drvdata;
>  		ret = smp_call_function_single(drvdata->cpu,
> -					       etm_enable_hw, drvdata, 1);
> -		if (ret)
> -			goto err;
> +					       etm_enable_hw_smp_call, &arg, 1);
> +		if (!ret)
> +			ret = arg.rc;
> +		if (!ret)
> +			drvdata->sticky_enable = true;
> +	} else {
> +		ret = -ENODEV;
>  	}
>  
> -	drvdata->sticky_enable = true;
>  	spin_unlock(&drvdata->spinlock);
>  
> -	dev_dbg(drvdata->dev, "ETM tracing enabled\n");
> -	return 0;
> -
> -err:
> -	spin_unlock(&drvdata->spinlock);
> +	if (!ret)
> +		dev_dbg(drvdata->dev, "ETM tracing enabled\n");
>  	return ret;
>  }
>  
> -- 
> 2.7.4
> 
