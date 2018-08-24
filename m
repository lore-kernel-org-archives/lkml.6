Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2ADC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A3A20A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1DA6Hbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A3A20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeHYCvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:51:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36715 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeHYCvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:51:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id e11-v6so1681074plb.3;
        Fri, 24 Aug 2018 16:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ri3oG0x6sTrCl5R82sylEeMIcSdmMX0spB42bFSEQoo=;
        b=c1DA6HbjVJbvqtwzkg+at+1IpXakXmWIJtvGJzqreQO7fO7XfHxfDY9P2MHBl7CH4b
         Fl4IND/nBgoetneNCu17y4Br4tp6FoR2YI4PNLyCdbN485ji2vVe1vGbNn4fT6z9qnU4
         9vqHkTXQLdaNSMtdKjQ0dpm3Qw9rIUqSeRMqc9FFzwoKmkrmFPKgzGrDMEL+6sKGphgt
         kvChl51gGiPtprJB/JokemmYoOY3FKHRxk9PuPWoliCcKYkk6infuNVIT2aZqfgMN78k
         Ij62r9ONNvvqfsEazEaYkHjiFa5rlh5VlKsI+XDDvTTjlaLgACmhlZZuLDDiPP8bkn1/
         KPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ri3oG0x6sTrCl5R82sylEeMIcSdmMX0spB42bFSEQoo=;
        b=hCFLBe0apKnfjAOTdsD8oJEp0iy3MATZI7EpdS/2nKQmoXYaT8zuYNqSTSYC9fDDK4
         kAgVPL7+NrazovbWtY4OzR5LfZ/GGIDyQj+UHSOLWsQFHzbaB4zcOrSvxDknruiOU6n4
         781oZB8dyKagvQeOR+XUJTLFnkQekh2DR73zpmgnihsSmstNvv5FbH4KFC+cLlVUdcFd
         2w6fWr+y93+6JhYbSydhkz5iyX3dHFPDE3vs7QXtZRWvqfuEnHKIrEMDsJAQPgOqrqxA
         pmZB/MmYkf3EPcHbvvJIrZcmCX3RC3gWLkm7hGg3jbdKnnBbXeNwU4j7hUFDulAAeHBz
         5OPg==
X-Gm-Message-State: APzg51DQlPPzBtEuCQKuD4MlqN9KDQWQh8KGDujLkKfSzxpKG6sslEtj
        0YPD9oBfV3GsYYKsGpiMbAA=
X-Google-Smtp-Source: ANB0VdZntlEqK9gSG1whGQA9pOlVT2Ysgy9QKjFOO3Xc2yjCFulEso4DHaFact3bgpqToLk1UQpszg==
X-Received: by 2002:a17:902:f:: with SMTP id 15-v6mr3373656pla.195.1535152461821;
        Fri, 24 Aug 2018 16:14:21 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id x23-v6sm9149777pff.9.2018.08.24.16.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 16:14:21 -0700 (PDT)
Date:   Fri, 24 Aug 2018 16:14:19 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] of: thermal: Allow multiple devices to share cooling
 map
Message-ID: <20180824231417.GB25163@localhost.localdomain>
References: <b5555967e713fd601bc74de0cab8ab45608399c4.1531824436.git.viresh.kumar@linaro.org>
 <438c3792a41b31629fb702c919ad244db97c0283.1533711976.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438c3792a41b31629fb702c919ad244db97c0283.1533711976.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 12:38:14PM +0530, Viresh Kumar wrote:
> A cooling map entry may now contain a list of phandles and their
> arguments representing multiple devices which share the trip point.
> 
> This patch updates the thermal OF core to parse them properly. The trip
> point and contribution value is shared by multiple cooling devices now
> and so a new structure is created, struct __thermal_cooling_bind_param,
> which represents a cooling device and its min/max states and the
> existing struct __thermal_bind_params now contains an array of this new
> cooling device structure.
> 
> Tested on Hikey960.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2:
> - Updated commit log to include new structures information
> - Updated two error messages to give better error log
> 
>  drivers/thermal/of-thermal.c | 142 +++++++++++++++++++++++++----------
>  1 file changed, 103 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 977a8307fbb1..16b890a4fb50 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -19,22 +19,33 @@
>  /***   Private data structures to represent thermal device tree data ***/
>  
>  /**
> - * struct __thermal_bind_param - a match between trip and cooling device
> + * struct __thermal_cooling_bind_param - a cooling device for a trip point
>   * @cooling_device: a pointer to identify the referred cooling device
> - * @trip_id: the trip point index
> - * @usage: the percentage (from 0 to 100) of cooling contribution
>   * @min: minimum cooling state used at this trip point
>   * @max: maximum cooling state used at this trip point
>   */
>  
> -struct __thermal_bind_params {
> +struct __thermal_cooling_bind_param {
>  	struct device_node *cooling_device;
> -	unsigned int trip_id;
> -	unsigned int usage;
>  	unsigned long min;
>  	unsigned long max;
>  };
>  
> +/**
> + * struct __thermal_bind_param - a match between trip and cooling device
> + * @tcbp: a pointer to an array of cooling devices
> + * @count: number of elements in array
> + * @trip_id: the trip point index
> + * @usage: the percentage (from 0 to 100) of cooling contribution
> + */
> +
> +struct __thermal_bind_params {
> +	struct __thermal_cooling_bind_param *tcbp;
> +	unsigned int count;
> +	unsigned int trip_id;
> +	unsigned int usage;
> +};
> +
>  /**
>   * struct __thermal_zone - internal representation of a thermal zone
>   * @mode: current thermal zone device mode (enabled/disabled)
> @@ -192,25 +203,31 @@ static int of_thermal_bind(struct thermal_zone_device *thermal,
>  			   struct thermal_cooling_device *cdev)
>  {
>  	struct __thermal_zone *data = thermal->devdata;
> -	int i;
> +	struct __thermal_bind_params *tbp;
> +	struct __thermal_cooling_bind_param *tcbp;
> +	int i, j;
>  
>  	if (!data || IS_ERR(data))
>  		return -ENODEV;
>  
>  	/* find where to bind */
>  	for (i = 0; i < data->num_tbps; i++) {
> -		struct __thermal_bind_params *tbp = data->tbps + i;
> +		tbp = data->tbps + i;
>  
> -		if (tbp->cooling_device == cdev->np) {
> -			int ret;
> +		for (j = 0; j < tbp->count; j++) {
> +			tcbp = tbp->tcbp + j;
>  
> -			ret = thermal_zone_bind_cooling_device(thermal,
> +			if (tcbp->cooling_device == cdev->np) {
> +				int ret;
> +
> +				ret = thermal_zone_bind_cooling_device(thermal,
>  						tbp->trip_id, cdev,
> -						tbp->max,
> -						tbp->min,
> +						tcbp->max,
> +						tcbp->min,
>  						tbp->usage);
> -			if (ret)
> -				return ret;
> +				if (ret)
> +					return ret;
> +			}
>  		}
>  	}
>  
> @@ -221,22 +238,28 @@ static int of_thermal_unbind(struct thermal_zone_device *thermal,
>  			     struct thermal_cooling_device *cdev)
>  {
>  	struct __thermal_zone *data = thermal->devdata;
> -	int i;
> +	struct __thermal_bind_params *tbp;
> +	struct __thermal_cooling_bind_param *tcbp;
> +	int i, j;
>  
>  	if (!data || IS_ERR(data))
>  		return -ENODEV;
>  
>  	/* find where to unbind */
>  	for (i = 0; i < data->num_tbps; i++) {
> -		struct __thermal_bind_params *tbp = data->tbps + i;
> +		tbp = data->tbps + i;
> +
> +		for (j = 0; j < tbp->count; j++) {
> +			tcbp = tbp->tcbp + j;
>  
> -		if (tbp->cooling_device == cdev->np) {
> -			int ret;
> +			if (tcbp->cooling_device == cdev->np) {
> +				int ret;
>  
> -			ret = thermal_zone_unbind_cooling_device(thermal,
> -						tbp->trip_id, cdev);
> -			if (ret)
> -				return ret;
> +				ret = thermal_zone_unbind_cooling_device(thermal,
> +							tbp->trip_id, cdev);
> +				if (ret)
> +					return ret;
> +			}
>  		}
>  	}
>  
> @@ -652,8 +675,9 @@ static int thermal_of_populate_bind_params(struct device_node *np,
>  					   int ntrips)
>  {
>  	struct of_phandle_args cooling_spec;
> +	struct __thermal_cooling_bind_param *__tcbp;
>  	struct device_node *trip;
> -	int ret, i;
> +	int ret, i, count;
>  	u32 prop;
>  
>  	/* Default weight. Usage is optional */
> @@ -680,20 +704,44 @@ static int thermal_of_populate_bind_params(struct device_node *np,
>  		goto end;
>  	}
>  
> -	ret = of_parse_phandle_with_args(np, "cooling-device", "#cooling-cells",
> -					 0, &cooling_spec);
> -	if (ret < 0) {
> -		pr_err("missing cooling_device property\n");
> +	count = of_count_phandle_with_args(np, "cooling-device",
> +					   "#cooling-cells");
> +	if (!count) {
> +		pr_err("Add a cooling_device property with at least one device\n");
>  		goto end;
>  	}
> -	__tbp->cooling_device = cooling_spec.np;
> -	if (cooling_spec.args_count >= 2) { /* at least min and max */
> -		__tbp->min = cooling_spec.args[0];
> -		__tbp->max = cooling_spec.args[1];
> -	} else {
> -		pr_err("wrong reference to cooling device, missing limits\n");
> +
> +	__tcbp = kcalloc(count, sizeof(*__tcbp), GFP_KERNEL);
> +	if (!__tcbp)
> +		goto end;
> +
> +	for (i = 0; i < count; i++) {
> +		ret = of_parse_phandle_with_args(np, "cooling-device",
> +				"#cooling-cells", i, &cooling_spec);
> +		if (ret < 0) {
> +			pr_err("Invalid cooling-device entry\n");
> +			goto free_tcbp;
> +		}
> +
> +		__tcbp[i].cooling_device = cooling_spec.np;
> +
> +		if (cooling_spec.args_count >= 2) { /* at least min and max */
> +			__tcbp[i].min = cooling_spec.args[0];
> +			__tcbp[i].max = cooling_spec.args[1];
> +		} else {
> +			pr_err("wrong reference to cooling device, missing limits\n");
> +		}
>  	}
>  
> +	__tbp->tcbp= __tcbp;

Applying but manually fixing the above style issue.

> +	__tbp->count = count;
> +
> +	goto end;
> +
> +free_tcbp:
> +	for (i = i - 1; i >= 0; i--)
> +		of_node_put(__tcbp[i].cooling_device);
> +	kfree(__tcbp);
>  end:
>  	of_node_put(trip);
>  
> @@ -900,8 +948,16 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
>  	return tz;
>  
>  free_tbps:
> -	for (i = i - 1; i >= 0; i--)
> -		of_node_put(tz->tbps[i].cooling_device);
> +	for (i = i - 1; i >= 0; i--) {
> +		struct __thermal_bind_params *tbp = tz->tbps + i;
> +		int j;
> +
> +		for (j = 0; j < tbp->count; j++)
> +			of_node_put(tbp->tcbp[j].cooling_device);
> +
> +		kfree(tbp->tcbp);
> +	}
> +
>  	kfree(tz->tbps);
>  free_trips:
>  	for (i = 0; i < tz->ntrips; i++)
> @@ -917,10 +973,18 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
>  
>  static inline void of_thermal_free_zone(struct __thermal_zone *tz)
>  {
> -	int i;
> +	struct __thermal_bind_params *tbp;
> +	int i, j;
> +
> +	for (i = 0; i < tz->num_tbps; i++) {
> +		tbp = tz->tbps + i;
> +
> +		for (j = 0; j < tbp->count; j++)
> +			of_node_put(tbp->tcbp[j].cooling_device);
> +
> +		kfree(tbp->tcbp);
> +	}
>  
> -	for (i = 0; i < tz->num_tbps; i++)
> -		of_node_put(tz->tbps[i].cooling_device);
>  	kfree(tz->tbps);
>  	for (i = 0; i < tz->ntrips; i++)
>  		of_node_put(tz->trips[i].np);
> -- 
> 2.18.0.rc1.242.g61856ae69a2c
> 
