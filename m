Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30B1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CB420874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB4g+XCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbeLSO5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:57:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42319 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbeLSO5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:57:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so9565310plp.9;
        Wed, 19 Dec 2018 06:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XXBl35SiC5sbTtuVVQBVyQMkywsQQ1Wi3yIAEWFyQ1I=;
        b=iB4g+XCkb+jywU2MmeDbdlC+ii8HrEeaOoVzSiSwBn44/8m6l3xkSSKSeO9mM4SvI1
         cRAHUc8Nczj2NyQGNWxU3OnUCZjNoIZrDAcqaTmC4SlJhSUNyD9LO6UCFx29r0/4EbuS
         FbjwKMqy9tPdn5qaPjoMPjuaV6pe6jRux5BgGOry4zuEUuc08eKw59AmFyz6+FsyJgiL
         zq/6J4nrKEVmKDxP7G5dYnZtDa2yEqowYp1F8EjbphVWFwNsf1qGiy2yXrAuK/L86HnE
         YvFRW4+rHCdghVimET9iRc+a9AZVo7Lzak/Kl/ZziA2WwOzvMdAFnNWAYMAjWe703bum
         gmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XXBl35SiC5sbTtuVVQBVyQMkywsQQ1Wi3yIAEWFyQ1I=;
        b=GEjVg8Psyn4exoorwEunyHDONNoDzdf5Dd1FRBV+FY00I8C0pqrpy1sOPnOq8TE74h
         5jdiUX397xIe/DP5uqeR2t2rcEo6qCFS8mY2GaXCQNYRtRH8QgI2LifTNWSFWh1xVsa4
         Njywv8xKAHoF18xqXK2XhQ74BlFkvUKMktOWlBnPTDhbKGqj7R6z0cPTCjAnx7YEBDu4
         GSZahy63pWv9DroZ/8PmsDaUcsGKYPZ70jzQELhUKF7tSHHD0aeS0wUwJzMqkksY3J0t
         Nlpg6RW/06OxJDPjJkcEnQPYsdMo3utRhdnGxst5AUgaXN1oTrNNs22vUZRveq9o5eTs
         mWWg==
X-Gm-Message-State: AA+aEWYPcQCZkzIj8YSRl65CuK7oCC25BZ82fSGTFyTAaghLh6ptf1I0
        ralBm8UpGa3QM1aKmA7Yavw=
X-Google-Smtp-Source: AFSGD/WioJIjXryfWCWlOBG+l6IxCfn8r7l7/+WhTCnnn2iAQgs5p3UUPx5xKpLUCJpNFbMi9ZtUbA==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4mr21004777plp.34.1545231456110;
        Wed, 19 Dec 2018 06:57:36 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id y6sm37507078pfd.104.2018.12.19.06.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 06:57:35 -0800 (PST)
Date:   Wed, 19 Dec 2018 06:57:34 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Wei Ni <wni@nvidia.com>
Cc:     rui.zhang@intel.com, thierry.reding@gmail.com,
        daniel.lezcano@linaro.org, linux-tegra@vger.kernel.org,
        srikars@nvidia.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 3/4] thermal: tegra: parse sensor id before sensor
 register
Message-ID: <20181219145732.GA3516@localhost.localdomain>
References: <1544780993-20744-1-git-send-email-wni@nvidia.com>
 <1544780993-20744-4-git-send-email-wni@nvidia.com>
 <20181219012450.GA2842@localhost.localdomain>
 <5c48701f-aafc-2db0-2191-41f169c8f33f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c48701f-aafc-2db0-2191-41f169c8f33f@nvidia.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 11:00:10AM +0800, Wei Ni wrote:
> 
> 
> On 19/12/2018 9:24 AM, Eduardo Valentin wrote:
> > On Fri, Dec 14, 2018 at 05:49:52PM +0800, Wei Ni wrote:
> >> Since different platforms may not support all 4
> >> sensors, so the sensor registration may be failed.
> >> Add codes to parse dt to find sensor id which
> >> need to be registered. So that the registration
> >> can be successful on all platform.
> >>
> >> Signed-off-by: Wei Ni <wni@nvidia.com>
> >> ---
> >>  drivers/thermal/tegra/soctherm.c | 45 ++++++++++++++++++++++++++++++++++++++--
> >>  1 file changed, 43 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> >> index fd2703c0cfc5..6bee31cd4621 100644
> >> --- a/drivers/thermal/tegra/soctherm.c
> >> +++ b/drivers/thermal/tegra/soctherm.c
> >> @@ -1224,6 +1224,41 @@ static void soctherm_init(struct platform_device *pdev)
> >>  	tegra_soctherm_throttle(&pdev->dev);
> >>  }
> >>  
> >> +static bool tegra_soctherm_find_sensor_id(unsigned int sensor_id)
> >> +{
> >> +	bool ret = false;
> >> +	struct of_phandle_args sensor_specs;
> >> +	struct device_node *np, *sensor_np;
> >> +
> >> +	np = of_find_node_by_name(NULL, "thermal-zones");
> >> +	if (!np)
> >> +		return ret;
> >> +
> >> +	for_each_available_child_of_node(np, sensor_np) {
> >> +		if (of_parse_phandle_with_args(sensor_np, "thermal-sensors",
> >> +						 "#thermal-sensor-cells",
> >> +						 0, &sensor_specs))
> >> +			continue;
> >> +
> >> +		if (sensor_specs.args_count != 1) {
> >> +			WARN(sensor_specs.args_count != 1,
> >> +			     "%s: wrong cells in sensor specifier %d\n",
> >> +			     sensor_specs.np->name, sensor_specs.args_count);
> >> +			continue;
> >> +		}
> >> +
> >> +		if (sensor_specs.args[0] == sensor_id) {
> >> +			of_node_put(sensor_np);
> >> +			ret = true;
> >> +			break;
> >> +		}
> >> +	}
> >> +
> >> +	of_node_put(np);
> >> +
> >> +	return ret;
> >> +}
> > 
> > So, I am still failing to see why this is really needed. 
> > 
> > Why can't you simply resolve this with different compatibles?
> > If the sensor is not present or disabled, the compatible is not, well,
> > compatible anymore.
> 
> This driver can support three Tegra chip t124, t132 and t210. And we
> also support some platforms for every chips. As the description in the
> commit, different platforms may not support all 4 sensors, so I
> upstreamed this patch.

ok.. Which means, all platforms need to have a proper DT that describes
the correct amount of sensors.

> If we use different compatibles, I think we can't resolve it simply,
> because we also need to add codes to configure which platform support
> which sensors, and may add more in the future. If use this patch, we

There is a very common way of solving this, you can pass .data and grab
after calling of_node_match(), just like the tegra soc thermal driver
already does.

> doesn't need to do any more in the future.

Well, if the patch is needed to add support for different versions of
your sensor block, then there is no reason why not patching.

> Actually in my original change, I just ignore the registration failure
> to fix this issue, it will not affect loading driver, but as Daniel's
> comment, it's not better to ignore, so I followed his comment to refer

It is not good to ignore. The correct thing to do here is for tegra to
have correct DT entries for each sensor block version, to correctly
represent the amount of sensors present in the RTL, then you reflect
that in device driver using compatible. This way you wont need to ignore
failures, and you will support the correct amount of sensors for each
block version.

> the QORIQ thermal driver to get the sensor id.
> 

I am not sure that is a good example to follow.

> Thanks.
> Wei.
> 
> > 
> >> +
> >>  static const struct of_device_id tegra_soctherm_of_match[] = {
> >>  #ifdef CONFIG_ARCH_TEGRA_124_SOC
> >>  	{
> >> @@ -1365,13 +1400,16 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
> >>  		zone->sg = soc->ttgs[i];
> >>  		zone->ts = tegra;
> >>  
> >> +		if (!tegra_soctherm_find_sensor_id(soc->ttgs[i]->id))
> >> +			continue;
> >> +
> >>  		z = devm_thermal_zone_of_sensor_register(&pdev->dev,
> >>  							 soc->ttgs[i]->id, zone,
> >>  							 &tegra_of_thermal_ops);
> >>  		if (IS_ERR(z)) {
> >>  			err = PTR_ERR(z);
> >> -			dev_err(&pdev->dev, "failed to register sensor: %d\n",
> >> -				err);
> >> +			dev_err(&pdev->dev, "failed to register sensor %s: %d\n",
> >> +				soc->ttgs[i]->name, err);
> >>  			goto disable_clocks;
> >>  		}
> >>  
> >> @@ -1434,6 +1472,9 @@ static int __maybe_unused soctherm_resume(struct device *dev)
> >>  		struct thermal_zone_device *tz;
> >>  
> >>  		tz = tegra->thermctl_tzs[soc->ttgs[i]->id];
> >> +		if (!tz)
> >> +			continue;
> >> +
> >>  		err = tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
> >>  		if (err) {
> >>  			dev_err(&pdev->dev,
> >> -- 
> >> 2.7.4
> >>
