Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2A4C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5F120882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WczOwf53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfA2TO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:14:27 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39869 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfA2TO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:14:26 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so10110928pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 11:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Vr3VPlZLYUX2dqW6k3w7msBxvOqgLohul8mFuhLMR0=;
        b=WczOwf53WJU/ByJz8mut8Wu8sqN4u5Mnt3zfxBvvF8U//weHGN8GscPC187W9MR6EA
         9Fzm+W6QkqM4ZSEb3Wk8kctJ4DxKyhsm9WLSpMOCEe9sd1u5LDT9lmNf+ISG8ldqX8fn
         PE0BpNOXUtlQRYDqmJeqikmbg94rd5VJMSfpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Vr3VPlZLYUX2dqW6k3w7msBxvOqgLohul8mFuhLMR0=;
        b=dIc/FRFKQI6BDUMQ9krCQHvygegv7pF9+sES9ZKqmQnpdIESHx+1ubWjs8BE4kZ4rW
         Z2yeJCpd6RAQzvQIk4WyoXz6jeqpKLd5ExWtO6u5hi0zKJGyggPDVSQxG9j8/kkQNbPS
         5SWEttbr84jipvWU5clAaKmrJ/wWkJ+BYbXYx1UifiyhlYkODN9AfHo5j9eS9zZuU+/R
         wrs0IBG7jT2GlM3LfnJh9oLSBLhTKiGcn6gQ77rzmv3TPPdeydMKHR/ykj+lMXKlb/tK
         KU/pboeOB9OVMq2aAD54v7IeuHsSza4gmD/9XIFQM73xOY3qu7q0i5XGOm02V+zoZ5jd
         aN6g==
X-Gm-Message-State: AJcUukerzYaO0VRf5QxEn1EqXl8spKJajgrV9HuKx21SBobAjxvVSCn2
        WDS0py85cbp3wj5rrkUR0fVitA==
X-Google-Smtp-Source: ALg8bN7hzrofYjvkM3KyEI5FM3fxWhDo0lgcpoQBjNO3KPiqJkgwFZwAmIVdieFpTsA6QgpzmAa7kw==
X-Received: by 2002:a65:4381:: with SMTP id m1mr24366352pgp.358.1548789265870;
        Tue, 29 Jan 2019 11:14:25 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id n70sm54935347pfi.185.2019.01.29.11.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 11:14:25 -0800 (PST)
Date:   Tue, 29 Jan 2019 11:14:24 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Yi Zeng <yizeng@asrmicro.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: of-thermal: support to select governor in dts
 for thermal zone
Message-ID: <20190129191424.GL81583@google.com>
References: <1546873479-20415-1-git-send-email-yizeng@asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1546873479-20415-1-git-send-email-yizeng@asrmicro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 11:04:39PM +0800, Yi Zeng wrote:
> Add the governor property parsing that defined in thermal zone node
> in dts. If define the governor property for one thermal zone, for
> example, governor = "step_wise", then parse and register the thermal
> zone will find and set the right governor, except the only choice
> of default governor.
> 
> Signed-off-by: Yi Zeng <yizeng@asrmicro.com>
> ---
>  drivers/thermal/of-thermal.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 4bfdb4a..f9368f4 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -1024,6 +1024,7 @@ int __init of_parse_thermal_zones(void)
>  		struct thermal_zone_params *tzp;
>  		int i, mask = 0;
>  		u32 prop;
> +		const char *name;
>  
>  		tz = thermal_of_build_thermal_zone(child);
>  		if (IS_ERR(tz)) {
> @@ -1049,6 +1050,10 @@ int __init of_parse_thermal_zones(void)
>  		if (!of_property_read_u32(child, "sustainable-power", &prop))
>  			tzp->sustainable_power = prop;
>  
> +		if (!of_property_read_string(child, "governor", &name))
> +			strncpy(tzp->governor_name, name,
> +				THERMAL_NAME_LENGTH);
> +
>  		for (i = 0; i < tz->ntrips; i++)
>  			mask |= 1 << i;

For reference, the discussion of a similar patch about a year ago:
https://patchwork.kernel.org/patch/10259487/

From a board developer POV I can see why you would want this, but
maintainers seem(ed) to think that it could cause more problems
than it solves.

Some arguments that were brought up against configuring the governor
in the DT:

- the DT should describe the hardware, not policy
- the specified governor might not exist / be enabled
- sysfs is more flexible than the DT

Cheers

Matthias
