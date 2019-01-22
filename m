Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBA6C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9934217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548177744;
	bh=vF+96Vyg18boK/Y5+6O1lYMmxEFQO8F4/fKKrI5ZW8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CZarJ4RCeVHIltwL1j2NwYRVYvUTUv46JnvOPpm7J6XQXSL/cAt58U4uqVfSHXEhx
	 zX4kAbl3aIYQXTfH5NgkqUijsSzilWnOB3XVPM+LNu16JxRNLdsUU+nmAyCnKZQ+cm
	 vD7BT3xaFLD2OnNKsr6+nPksrY2NgTQnZe1Xm6w4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbfAVRWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:22:23 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33619 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbfAVRWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:22:22 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so18708636lfc.0;
        Tue, 22 Jan 2019 09:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BqPvDNJt9bC+rlGQ/qnfH+2DYWKN25Q5lNqN8xIEWG0=;
        b=edtUeERMBTVaXPxXFpwdbDYNVhkV2bvnDQ5S/ZL18ODiGBaBmuKs5VgqW9ShrWdaXj
         q8QJjTvxSjzkSYkPMEXMcICvbDvVnankOSTP3h/Kd1cDyOGPWrOuk1ldiMMvGeZ0c3Jw
         mMG4jHQkehgd7KrSAeaXQX3SSh3omGUJq5EwRZf9nLkO3zYQmfOMwA+zKY+BB+agw51X
         I+O1uXaqCAeTYQAFncKEyLkr6jvNULRuH8scopZKoE6JmpESY63CISgEcwU1H9W7gO/l
         Say+cS8gaXTOErfVJO5r5HVCI/Q2v0hRA2spBDTGff8+Hi8jcqIAPRhTSGgKHjVtIu0f
         G6dQ==
X-Gm-Message-State: AJcUukeAjpDVUkNFBfwpLD2DHg0SohOckSZBhYMLMKEddgJbYDZiMKVk
        K9vUqGINsuDJVP0PtxjqY2K5GRM5
X-Google-Smtp-Source: ALg8bN4xDYTlvUQYoSstqoFu7nDvZAu7/QBc8ZB3dz4XOA16M9oa/OfShWUhDt1CwaA2CRTYqY1Q3Q==
X-Received: by 2002:a19:7006:: with SMTP id h6mr22351020lfc.147.1548177739885;
        Tue, 22 Jan 2019 09:22:19 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id m1sm91908lfb.56.2019.01.22.09.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 09:22:18 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1glzkd-0004f1-Bb; Tue, 22 Jan 2019 18:22:15 +0100
Date:   Tue, 22 Jan 2019 18:22:15 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     letux-kernel@openphoenux.org, johan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] gnss: sirf: set power state initially off
Message-ID: <20190122172215.GQ3691@localhost>
References: <20190116211812.6337-1-andreas@kemnade.info>
 <20190116211812.6337-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116211812.6337-3-andreas@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:18:08PM +0100, Andreas Kemnade wrote:
> On the GTA04 mobile phone, it was observed that the gps was powered
> on sometimes intially. Generally a reboot without powering the device
> off (direct reset of the processor, reboot from a system where gps
> power toggle was done in userspace) or glitches on the gpio pin during
> power on could cause this problem.
> This has the drawback that probing takes some seconds on
> systems without wakeup signal. On systems with wakeup signal
> this penalty is much lower.
> But if the chip is initially on and that is not fixed, the suspend
> current will be multiple times higher, so this sacrifice should
> be justified
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> - was part of 2/5 in v2
> 
>  drivers/gnss/sirf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
> index b21e14351b82..c7706b91f6f0 100644
> --- a/drivers/gnss/sirf.c
> +++ b/drivers/gnss/sirf.c
> @@ -367,6 +367,13 @@ static int sirf_probe(struct serdev_device *serdev)
>  	if (IS_ENABLED(CONFIG_PM)) {
>  		pm_runtime_set_suspended(dev);	/* clear runtime_error flag */
>  		pm_runtime_enable(dev);
> +		/*
> +		 * Device might be enabled at boot, so ensure it is off.
> +		 * This was observed in practice on GTA04.
> +		 */
> +		ret = sirf_set_active(data, false);
> +		if (ret < 0)
> +			goto err_disable_rpm;

I want to handle this case a bit differently. First, we shouldn't
penalise the common case where the receiver is already off by power
cycling when not needed. Second, the above could race with runtime pm.
Third, we mustn't call sirf_set_active() when we have no on-off gpio.

I've prepare a small series which implements this force hibernate mode
at probe if already active. This should be easy to extend with a
function retrieving the current state at boot also for the no-wakeup
case (e.g. keep the port open for one report cycle).

This also allows for a cleaner implementation of sirf_set_active() for
the no-wakeup case (I noticed you added some optimisation there after I
implemented force-hibernate-at-probe).

Johan
