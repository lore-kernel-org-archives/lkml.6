Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4279DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4C32081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QMDpWxfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4C32081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeK1Qzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:55:33 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15924 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeK1Qzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 11:55:33 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bfe2dbc0000>; Tue, 27 Nov 2018 21:55:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 27 Nov 2018 21:55:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 27 Nov 2018 21:55:06 -0800
Received: from [10.19.225.182] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 28 Nov
 2018 05:55:04 +0000
Subject: Re: [PATCH v3 3/3] thermal: tegra: parse sensor id before sensor
 register
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>
References: <1543383877-20555-1-git-send-email-wni@nvidia.com>
 <1543383877-20555-4-git-send-email-wni@nvidia.com>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <53d249f6-58a5-89b7-9e95-74c8b036251b@nvidia.com>
Date:   Wed, 28 Nov 2018 13:55:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543383877-20555-4-git-send-email-wni@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543384508; bh=PGAqS0UP1aKisDzMp68cgAdcSV4kvQM5QQTXO3RZRb8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=QMDpWxfvq5JYHZGGsQYcYa4b/VADPai1Ai9WYdmHxPzBlQMfqSRM6tK4qQT54EmKO
         2F+1DTXtlSvmBXYpExIeK5ItXaCqrlhnm0BZZXMo0UREzCFY5Aefrxjd8OTUV8oX1E
         lviDBkr55WhqgVU1ulXi6f34a0ECfc7eAOL7/SgNk8dP0TN3TSTHqyH6dJPUAV/gcO
         MczHTjxxsURynPMOyALVmkAx0EULZr+XjAdL7biWdnW1jsO4LrG5t0dFFSx5LZJ5Zo
         o4U3DwsrC6ezEXlqQ50i08nN2zBn3hoXvmA4qst08PFW4Se3MvOnTiKrhO1yYGrZCX
         KoFqmuOCquT7g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,
I updated my patch to parse the sensor id, please take a look.

Wei.

On 28/11/2018 1:44 PM, Wei Ni wrote:
> Since different platforms may not support all 4
> sensors, so the sensor registration may be failed.
> Add codes to parse dt to find sensor id which
> need to be registered. So that the registration
> can be successful on all platform.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 46 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index 375cadbc24cd..79e4628224d7 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -1224,6 +1224,44 @@ static void soctherm_init(struct platform_device *pdev)
>  	tegra_soctherm_throttle(&pdev->dev);
>  }
>  
> +static bool tegra_soctherm_find_sensor_id(int sensor_id)
> +{
> +	int id;
> +	bool ret = false;
> +	struct of_phandle_args sensor_specs;
> +	struct device_node *np, *sensor_np;
> +
> +	np = of_find_node_by_name(NULL, "thermal-zones");
> +	if (!np)
> +		return ret;
> +
> +	sensor_np = of_get_next_child(np, NULL);
> +	for_each_available_child_of_node(np, sensor_np) {
> +		if (of_parse_phandle_with_args(sensor_np, "thermal-sensors",
> +						 "#thermal-sensor-cells",
> +						 0, &sensor_specs))
> +			continue;
> +
> +		if (sensor_specs.args_count != 1) {
> +			WARN(sensor_specs.args_count > 1,
> +			     "%s: wrong cells in sensor specifier %d\n",
> +			     sensor_specs.np->name, sensor_specs.args_count);
> +			continue;
> +		} else {
> +			id = sensor_specs.args[0];
> +			if (sensor_id == id) {
> +				ret = true;
> +				break;
> +			}
> +		}
> +	}
> +
> +	of_node_put(np);
> +	of_node_put(sensor_np);
> +
> +	return ret;
> +}
> +
>  static const struct of_device_id tegra_soctherm_of_match[] = {
>  #ifdef CONFIG_ARCH_TEGRA_124_SOC
>  	{
> @@ -1365,13 +1403,15 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
>  		zone->sg = soc->ttgs[i];
>  		zone->ts = tegra;
>  
> +		if (!tegra_soctherm_find_sensor_id(soc->ttgs[i]->id))
> +			continue;
>  		z = devm_thermal_zone_of_sensor_register(&pdev->dev,
>  							 soc->ttgs[i]->id, zone,
>  							 &tegra_of_thermal_ops);
>  		if (IS_ERR(z)) {
>  			err = PTR_ERR(z);
> -			dev_err(&pdev->dev, "failed to register sensor: %d\n",
> -				err);
> +			dev_err(&pdev->dev, "failed to register sensor %s: %d\n",
> +				soc->ttgs[i]->name, err);
>  			goto disable_clocks;
>  		}
>  
> @@ -1434,6 +1474,8 @@ static int __maybe_unused soctherm_resume(struct device *dev)
>  		struct thermal_zone_device *tz;
>  
>  		tz = tegra->thermctl_tzs[soc->ttgs[i]->id];
> +		if (!tz)
> +			continue;
>  		err = tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
>  		if (err) {
>  			dev_err(&pdev->dev,
> 
