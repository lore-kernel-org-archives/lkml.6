Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2696C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B4B2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkYbvUpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B4B2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbeKNKMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 05:12:30 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42568 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNKM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 05:12:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so3035164pga.9;
        Tue, 13 Nov 2018 16:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4QR7Dv+QdTTpwESOgXoue0bpc4d3760xOJqfAO3Cxcw=;
        b=UkYbvUpexECjwSrOC2C1TaxQHVTqzIkR66l99O61g9yS8EUlNDfpZ39LnSQRIwsXN/
         t0SjerKuWX6yBXKBpFclu0hWfbU7FhgrOQGQO4ysVPsx/PrwOjDiUhkrW5YxlR7b4Jew
         LX4W2DWKDKTyeVwsV4CqvDmwQnUvlQjhGBVNJZ85ZONrJfaF1Oo/UrRf0kBGb+y0ThVV
         gxBU1VTC79vXLasKRNBiAf5dZYH4Bab5EXbW/v1UF3S2dFqV4FOkQwKV/jGYZYnD8qtA
         gr+Az9yto9BGpGcy2yt7PdS+WtdbxQjFLYNVUwZPsjQQ1rOY+hldY9kJNFiiFYxQjUBq
         3oiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4QR7Dv+QdTTpwESOgXoue0bpc4d3760xOJqfAO3Cxcw=;
        b=bRUBDS5vNjrcMaWBhC0AYdhQa6XM8W4YLrkFC1buMc8OS1MSEZWqohCQpz2azZM1dT
         znGi/I+fAhhJsUiSHgsF9w17YVvN6rCJAU9IcOkxdQFlngJZK3ccmisbR+9vPfD+3v/w
         /9ONiQTTg0dv8FHLCl7F1fShnsUkzhtyzLRrCtpMBnOyXlvj1Sro3/Y/7nt/f65mpj/G
         JzpY0xIRp2YXoIfUpWZcSX0e4KLG05QSrpWr4ljqoVa8qK2J748KJUlXAHERS4Q68ur6
         Xgc8wIO50uOtr+7qwS1LKeWKzbV0U3NmM+/YRGlBgzc/K5N4px3o2COOb0twGY5u+qJT
         1GuA==
X-Gm-Message-State: AGRZ1gIBYOYjK7Uo1SOE9s5tFRPf75yfn+m4WRIHxIj/hLomrCgQWhqm
        Curn0NUotIDgRq2d93hiXJvehtjj
X-Google-Smtp-Source: AJdET5cbbzNVbslSi7OrVHwtXL68Zms9RwrL7HWq+bcqRaH3fZ2jK3yZeAPigKRAe68wVk9O557mrg==
X-Received: by 2002:a63:dc0c:: with SMTP id s12mr6784049pgg.398.1542154306809;
        Tue, 13 Nov 2018 16:11:46 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 202sm4382549pfy.87.2018.11.13.16.11.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 16:11:46 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:11:42 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] hwmon (ina3221) Add single-shot mode support
Message-ID: <20181114001141.GA14925@Asurada-Nvidia.nvidia.com>
References: <20181113042353.1507-1-nicoleotsuka@gmail.com>
 <20181113043248.GB11205@roeck-us.net>
 <20181113045823.GB26327@Asurada-Nvidia.nvidia.com>
 <20181113172102.GA21714@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113172102.GA21714@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Tue, Nov 13, 2018 at 09:21:02AM -0800, Guenter Roeck wrote:
> > > > INA3221 supports both continuous and single-shot modes. When
> > > > running in the continuous mode, it keeps measuring the inputs
> > > > and converting them to the data register even if there are no
> > > > users reading the data out. In this use case, this could be a
> > > > power waste.
> > > > 
> > > > So this patch adds a single-shot mode support so that ina3221
> > > > could do measurement and conversion only if users trigger it,
> > > > depending on the use case where it only needs to poll data in
> > > > a lower frequency.
> > > > 
> > > > The change also exposes "mode" and "available_modes" nodes to
> > > > allow users to switch between two operating modes.
> > > > 
> > > Lots and lots of complexity for little gain. Sorry, I don't see
> > > the point of this change.
> > 
> > The chip is causing considerable power waste on battery-powered
> > devices so we typically use it running in the single-shot mode.
> 
> And you need to be able to do that with a sysfs attribute ?
> Are you planning to have some code switching back and forth
> between the modes ?
>
> You'll need to provide a good rationale why this needs to be
> runtime configurable.

Honestly, our old downstream driver didn't expose it via sysfs.
Instead, it had a built-in "governor" to switch modes based on
the CPU hotplug state and cpufreq. However, the interface used
to register a CPU hotplug notification was already deprecated.
And I don't feel this governor is generic enough to be present
in the mainline code.

For me, it's not that necessary to be a sysfs attribute. I try
to add it merely because I cannot find a good criteria for the
mode switching in a hwmon driver. So having an open sysfs node
may allow user space power daemon to decide its operating mode,
since it knows which power mode the system is running at: full
speed (charging/charged) or power saving (on-battery), and it
knows how often this exact service will poll the sensor data.

An alternative way (without the sysfs node), after looking at
other hwmon code, could be to have a timed polling thread and
read data using an update_interval value from ABI. This might
turn out to be more complicated as it'll also involve settings
of hardware averaging and conversion time. Above all, I cannot
figure out a good threshold of update_interval to switch modes.

If you can give some advice of a better implementation, that'd
be great.

Thanks
Nicolin
