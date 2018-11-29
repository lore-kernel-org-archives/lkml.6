Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278C0C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C562146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi4b4/UM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C562146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbeK3EHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:07:53 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39552 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729845AbeK3EHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:07:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id c72so1308296pfc.6;
        Thu, 29 Nov 2018 09:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hCUwooEbkMF159RAafla/e9edKRNnc7SiSUzaUWiC/g=;
        b=Fi4b4/UMfqjgkhgoabIGQi8WzqzDVDMzKJ/sfAGQEzZg51vXviwooeQQ8FMTi05M5D
         H8ymvmOc/5L1khb/PYWn29H5594uUgl+39chjIaEHutGS6j5DkgFUukQvq+upAbqOLTj
         fchquASoHv3GoUKmg4/e8suLADaq5B/5JN/JnPCYueZWotQPtdRWFI+ExBP3Ljvl12jh
         mZ2ABHrHJA0Lsz6VkvI7SEfjFmB7Pj4Jq5qJg3EywhUjNKGDqwWbZGOHgkvIVsnGSL46
         gqr1jV+EWFYTJIzLgmtkiE+D7n0xxMsOg2UyatwSRkx2MM9RGjapppWOK2pu8lNQ3NrX
         21+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hCUwooEbkMF159RAafla/e9edKRNnc7SiSUzaUWiC/g=;
        b=WxVcpQsJ/P84OLOpTZQKBEjYrZQnVj21jHV655GFwQhnIoe6jgy7Hq2kJTm49olmPT
         1kHaO8lDGevCjzKLRsv0NsImKxrVES59CUu25iLI64DEH32gBYBW6wvms67W1hGeI7pP
         XcsKTIN0pZFZO+6EPBGUhWs1e8v/FCqpJ5/n2UPGzvkFE887cA+XaH8AUsdIQnozfQKH
         LqS9LcoUCrqQUtafPHrjDPv2GNtOlxKhlNHz0wVPTTlt71xx3DWaF2JM2Kr0Hu2YDme6
         fNgCim1rQmujeO0wqpalNFQ5UgXeWwCz2fBsybCvwVqXfTCHhQ+rtpFsnifKQXzt9xOz
         6BYA==
X-Gm-Message-State: AA+aEWbXhyW4j0hOMOBTYWtEF5j/+FBvt0h1luPQ7jwvcTQYk9+IcaAA
        h5Yt1YulsXTflw0SfIR561M=
X-Google-Smtp-Source: AFSGD/USTGjFkikok7+grIhnAT7/b+kdlFbGdd/1y+w3yyGD/LU3yuC3nT3xWAQOz0Z7419CiTQGyQ==
X-Received: by 2002:a63:170c:: with SMTP id x12mr1819631pgl.364.1543510909225;
        Thu, 29 Nov 2018 09:01:49 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id f62sm3027611pgc.67.2018.11.29.09.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:01:48 -0800 (PST)
Date:   Thu, 29 Nov 2018 09:01:46 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Wei Ni <wni@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        daniel.lezcano@linaro.org, linux-tegra@vger.kernel.org,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: tegra: add get_trend ops
Message-ID: <20181129170145.GG2688@localhost.localdomain>
References: <1542705077-29697-1-git-send-email-wni@nvidia.com>
 <20181120153833.GB28796@ulmo>
 <d510d768-452f-5f70-a9b6-37d6a63a56c9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d510d768-452f-5f70-a9b6-37d6a63a56c9@nvidia.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 02:36:10PM +0800, Wei Ni wrote:
> 
> 
> On 20/11/2018 11:38 PM, Thierry Reding wrote:
> > On Tue, Nov 20, 2018 at 05:11:17PM +0800, Wei Ni wrote:
> >> Add support for get_trend ops that allows soctherm
> >> sensors to be used with the step-wise governor.
> >>
> >> Signed-off-by: Wei Ni <wni@nvidia.com>
> >> ---
> >>  drivers/thermal/tegra/soctherm.c | 34 ++++++++++++++++++++++++++++++++++
> >>  1 file changed, 34 insertions(+)
> >>
> >> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> >> index ed28110a3535..d2951fbe2b7c 100644
> >> --- a/drivers/thermal/tegra/soctherm.c
> >> +++ b/drivers/thermal/tegra/soctherm.c
> >> @@ -488,9 +488,43 @@ static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
> >>  	return 0;
> >>  }
> >>  
> >> +static int tegra_thermctl_get_trend(void *data, int trip,
> >> +				    enum thermal_trend *trend)
> >> +{
> >> +	struct tegra_thermctl_zone *zone = data;
> >> +	struct thermal_zone_device *tz = zone->tz;
> >> +	int trip_temp, temp, last_temp, ret;
> >> +
> >> +	if (!tz)
> >> +		return -EINVAL;
> >> +
> >> +	ret = tz->ops->get_trip_temp(zone->tz, trip, &trip_temp);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	mutex_lock(&tz->lock);
> >> +	temp = tz->temperature;
> >> +	last_temp = tz->last_temperature;
> >> +	mutex_unlock(&tz->lock);
> >> +
> >> +	if (temp > trip_temp) {
> >> +		if (temp >= last_temp)
> >> +			*trend = THERMAL_TREND_RAISING;
> >> +		else
> >> +			*trend = THERMAL_TREND_STABLE;
> >> +	} else if (temp < trip_temp) {
> >> +		*trend = THERMAL_TREND_DROPPING;
> >> +	} else {
> >> +		*trend = THERMAL_TREND_STABLE;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> > 
> > This looks like a reimplementation of the get_tz_trend() helper. Is
> > seems like that helper already has everything we need. Perhaps this
> > isn't working because of-thermal installs of_thermal_get_trend(), a
> > function that returns -EINVAL if the driver doesn't implement the
> > ->get_trend() callback.
> 
> 1. The get_tz_trend() helper can work, because it has:
> if (tz->emul_temperature || !tz->ops->get_trend ||
>             tz->ops->get_trend(tz, trip, &trend)) {
> ...
> }
> the tz->ops->get_trend is of_thermal_get_trend(). If without special
> get_trend(), it will return -EINVAL, so it will implement the if block
> to get the "trend". If we have the special get_trend(), then the
> of_thermal_get_trend() will return 0, so this helper will not implement
> the if block, it will get the "trend" from the special get_trend().

The idea of the helper is to provide a trend in case drivers dont have
a specific way of doing so. 

> 
> 2. There has a little difference between the helper and our special
> callback. The tegra_thermctl_get_trend() consider the trip_temp, but the
> get_tz_trend() helper didn't.
> 

Yeah, if you are computing trend towards a trip, then yes, that is
different and this patch is needed.

> > 
> > Perhaps a better way would be to do something like this in
> > thermal_zone_of_add_sensor():
> > 
> > 	if (ops->get_trend)
> > 		tzd->ops->get_trend = of_thermal_get_trend;
> > 
> > That's similar to how ->set_trips() and ->set_emul_temp() are set up
> > and should make sure that get_tz_trend() will do the right thing for
> > all drivers that don't implement a special ->get_trend().
> 
> As above description, I think the of_thermal_get_trend() already can
> handle this case, doesn't need to change.
> 
> Wei.
> 
> > 
> > Thierry
> > 
