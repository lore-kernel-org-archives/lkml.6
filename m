Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37E0C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1ED208B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4GOcPVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1ED208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387527AbeHFUQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 16:16:10 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46009 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387506AbeHFUQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 16:16:10 -0400
Received: by mail-oi0-f68.google.com with SMTP id q11-v6so23757086oic.12;
        Mon, 06 Aug 2018 11:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QEmd9U5A0x0KnwNNdlSxfo5cfrra4hbBTVeFRWzpP3M=;
        b=X4GOcPVUUdFkxcasPBQd8r1kef8vE6nqNP+PdnopSJ/HWkZ0Bo5ro+9jV8PI2XFn1B
         m651WklQza7cue6Jo34PzZAO8xGgylo3b97qSDnB8lA5pINPU4FCB6tLJXt1UeVe3Emb
         cSA9f2Hl3iGTxgHzp9bRTe4yZ3pC3zSc6eSydajrYHnYXsthoLIqiXHZ7LbdEw0kNqQI
         J4eA5C13PtwJc/AdF3UMDvo8ZIrkfUrJlxFdQHjCQXq+DzNx6hMrh4NnW0iUQi7OIVGo
         TfJbN2bp+O7O1RiZvIGg5HOqBtr/tyOKzXYT0X9SaF3WM1a5MkIUPdYIZ07FAcqcgc2y
         1HyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QEmd9U5A0x0KnwNNdlSxfo5cfrra4hbBTVeFRWzpP3M=;
        b=FQYSW1cwJIg/4Kj93mrVyCk6qdQtmGbBjcvHDiqNFPbi94XNrxldyLXtiePFKNTZ7X
         t+Ls3Uwriv0OSGYPb6hv7bfELiNsClX4MGPYweGZK8KDiegQU7m7DEKstgFK34i0T6jK
         L1ILT6LVBsc623hiuOtolpYCHdqeZh0m6gtGXRpUs50IP3VRBYVBPcdRS2EeUrwEIppP
         FPXbZEiB15jZFvnq3PjSXLZ3jpn+DSGxhJuAJ5BGXTKvfNP7aEaa9hjacg/5+vBR5q35
         xckLsFnmpfFAphakK+bVsP6MlJYcPIGjg+cPgSHgRzz7XfdsNuObZeHRSZ6BLKkPjkjm
         ySzA==
X-Gm-Message-State: AOUpUlEXXVXeUWkfFckVcoUCE9aCa0NDJLGBGX9hhWuGFFmo5TgLtnE2
        W2MmNr9nm8t0qDx70T6uwoMp3AlM
X-Google-Smtp-Source: AAOMgpe+kzIZKRc8arY/7XUCxJN/3a+q2dLtCIFlgx7vgL1ZbEkGUkDiv/KqpKHs+Jk0MPCETFgrDw==
X-Received: by 2002:aca:ed45:: with SMTP id l66-v6mr16425964oih.40.1533578755883;
        Mon, 06 Aug 2018 11:05:55 -0700 (PDT)
Received: from localhost.localdomain ([12.251.228.178])
        by smtp.gmail.com with ESMTPSA id 16-v6sm7934962oin.5.2018.08.06.11.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 11:05:55 -0700 (PDT)
Date:   Mon, 6 Aug 2018 11:05:52 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: thermal: Allow multiple devices to share cooling map
Message-ID: <20180806180551.GA4760@localhost.localdomain>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
 <b5555967e713fd601bc74de0cab8ab45608399c4.1531824436.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5555967e713fd601bc74de0cab8ab45608399c4.1531824436.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jul 17, 2018 at 04:24:16PM +0530, Viresh Kumar wrote:
> A cooling map entry may now contain a list of phandles and their
> arguments representing multiple devices which share the trip point.
> 
> This patch updates the thermal OF core to parse them properly.

I am mostly fine with the patch idea, specially because we wont be
breaking existing DT blobs out there.

See comment below.

> 
> Tested on Hikey960.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> This is a follow up patch to the DT bindings patchset:
> 
> https://lkml.kernel.org/r/cover.1530766981.git.viresh.kumar@linaro.org
> 
>  drivers/thermal/of-thermal.c | 140 +++++++++++++++++++++++++----------
>  1 file changed, 102 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 977a8307fbb1..79c06c4c861b 100644
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

Do you mind elaborating why you needed to do this split and adding a new
struct? More important, please describe in your commit message.

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
> +	count = of_count_phandle_with_args(np, "cooling-device",
> +					   "#cooling-cells");
> +	if (!count) {
>  		pr_err("missing cooling_device property\n");

Probably the above error message deserves a better fit to the current
situation. Maybe:
+  		pr_err("Add a cooling_device property with at least one device\n");

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
> +			pr_err("missing cooling_device property\n");

Here is a wrongly written cooling_device phandle, no?

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
