Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADAFC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 12:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B77D2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 12:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3lz+sWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfAMMwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 07:52:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45115 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfAMMwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 07:52:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so9077844pfd.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 04:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+lTIt4WN5Zdqg0tT2fHcPZBJMQI0kmJFEM2fXFPSJ6I=;
        b=D3lz+sWI526Bc2DUb7mNl+PDm8+poaCQUl+KVJoYkILTz07neCpABnB6HU91WnJHoc
         JT8wfftHa6NMexKCl60yARJQxi4T9Nr/ufsCgQQc1kV0wlbpcxX7PdFHhQC237Hqs3/t
         +znaUdpEPUWsxOaAASa0LEMjNGtv+wy5PXkc9pqXhaXQu1Tf0vInjNImDekp/WmoCclE
         ru3Sa9ZdZkqHYgYXqny3ewsqnBwnasczGbwmJFWC9xrBWPU5n/SDHDRdLMyYWziUFk4y
         PC98jX6pF3u/6AWCvFxcI9Yn2HmgCrxxXGgjgiyGsQjb/Ij5mIu3wlbt91J2Jayj5/gm
         uNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+lTIt4WN5Zdqg0tT2fHcPZBJMQI0kmJFEM2fXFPSJ6I=;
        b=b2TG+wBCx5tcHD8/xexy+4jQoBIByNhnVCBJc1woa7Qplq1eIp8i9nPiAuAWfW/uEa
         cZK3JsNsmzqGGKRGLOmbwetkwwFc7Gl80piubn0ITNPeclmYH6ZLJII0A/JNPMyj7i63
         1O0QvgGyf589QjvBMf8VWBsvKZDQmaHYnePiZstUUuWPGmRkJF96pXvQ3CZ5DMoI3xDO
         6h2nNWDHxYza80GsyjMLYi2AgTzFRaFlB3rfQ7dymCiTFNOsw1alm4Yh+VIMBy+bi012
         tE1vm+/Q3wmAla8Oa9hDzUOTLkXPLhD7Fe4GcJopSzb0uhtXaH7gns2iiNSa0YmSnQVm
         JAtQ==
X-Gm-Message-State: AJcUukdTcScczRbapwfHP0Oo5GscAHWFNtYSgUWueby/4ay2qCj5p/51
        m18OJZAhvThIFMyfpfvmfc0=
X-Google-Smtp-Source: ALg8bN5SvXpCMGu6lSYpPN1uNJ4qgEDFsRCv+fo614pfoOrYagA1RkLzIrRI43hoAxvPq4qgvIWn+g==
X-Received: by 2002:a62:2702:: with SMTP id n2mr22070257pfn.29.1547383939005;
        Sun, 13 Jan 2019 04:52:19 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id y84sm154563747pfb.81.2019.01.13.04.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 04:52:18 -0800 (PST)
Date:   Sun, 13 Jan 2019 18:22:11 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: Re: [PATCH v5 3/3] staging: greybus: arche-platform: Switch to the
 gpio descriptor interface
Message-ID: <20190113125208.GA16542@nishad>
References: <cover.1547141413.git.nishadkamdar@gmail.com>
 <35b03691b11f4c6a8441e6952457f8359b0655aa.1547141413.git.nishadkamdar@gmail.com>
 <20190111084821.GD3383@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111084821.GD3383@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 09:48:21AM +0100, Johan Hovold wrote:
> On Thu, Jan 10, 2019 at 11:23:07PM +0530, Nishad Kamdar wrote:
> > Use the gpiod interface instead of the deprecated old non-descriptor
> > interface while continuing to ignore gpio flags from device tree in
> > "svc_reset_onoff()" for now.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> > Changes in v5:
> >   - Change the commit message.
> >   - Restore the names of the gpio device-tree properties without
> >     the "-gpio" suffix.
> > Changes in v4:
> >  - Move 'gpio_desc *svc_sysboot' below the reset flag
> >    as it is more logical to have reset flag below
> >    reset gpio.
> >  - Remove a few unnecessary line breaks.
> > Changes in v3:
> >  - Add this patch to a patchset.
> > Changes in v2:
> >  - Move comment to the same line as to what it applies to.
> > ---
> 
> Also looks good. Some really minor comments to a couple of the error
> messages. The issues are there in the current code, but since you modify
> these messages anyway you might as well fix them up. Please fix that and
> resend with my
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>
> 
Ok, I'll do that.

> Really good job with this!
> 
Thank you.
> > @@ -435,6 +428,7 @@ static int arche_platform_probe(struct platform_device *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	struct device_node *np = dev->of_node;
> >  	int ret;
> > +	unsigned int flags;
> >  
> >  	arche_pdata = devm_kzalloc(&pdev->dev, sizeof(*arche_pdata),
> >  				   GFP_KERNEL);
> > @@ -444,61 +438,33 @@ static int arche_platform_probe(struct platform_device *pdev)
> >  	/* setup svc reset gpio */
> >  	arche_pdata->is_reset_act_hi = of_property_read_bool(np,
> >  							     "svc,reset-active-high");
> > -	arche_pdata->svc_reset_gpio = of_get_named_gpio(np,
> > -							"svc,reset-gpio",
> > -							0);
> > -	if (!gpio_is_valid(arche_pdata->svc_reset_gpio)) {
> > -		dev_err(dev, "failed to get reset-gpio\n");
> > -		return arche_pdata->svc_reset_gpio;
> > -	}
> > -	ret = devm_gpio_request(dev, arche_pdata->svc_reset_gpio, "svc-reset");
> > -	if (ret) {
> > -		dev_err(dev, "failed to request svc-reset gpio:%d\n", ret);
> > -		return ret;
> > -	}
> > -	ret = gpio_direction_output(arche_pdata->svc_reset_gpio,
> > -				    arche_pdata->is_reset_act_hi);
> > -	if (ret) {
> > -		dev_err(dev, "failed to set svc-reset gpio dir:%d\n", ret);
> > +	if (arche_pdata->is_reset_act_hi)
> > +		flags = GPIOD_OUT_HIGH;
> > +	else
> > +		flags = GPIOD_OUT_LOW;
> > +
> > +	arche_pdata->svc_reset = devm_gpiod_get(dev, "svc,reset", flags);
> > +	if (IS_ERR(arche_pdata->svc_reset)) {
> > +		ret = PTR_ERR(arche_pdata->svc_reset);
> > +		dev_err(dev, "failed to request svc-reset GPIO:%d\n", ret);
> 
> Add a space after ':' for consistency.
> 
Ok. I'll do that.
> > @@ -515,19 +481,11 @@ static int arche_platform_probe(struct platform_device *pdev)
> >  	arche_pdata->num_apbs = of_get_child_count(np);
> >  	dev_dbg(dev, "Number of APB's available - %d\n", arche_pdata->num_apbs);
> >  
> > -	arche_pdata->wake_detect_gpio = of_get_named_gpio(np,
> > -							  "svc,wake-detect-gpio",
> > -							  0);
> > -	if (arche_pdata->wake_detect_gpio < 0) {
> > -		dev_err(dev, "failed to get wake detect gpio\n");
> > -		return arche_pdata->wake_detect_gpio;
> > -	}
> > -
> > -	ret = devm_gpio_request(dev, arche_pdata->wake_detect_gpio,
> > -				"wake detect");
> > -	if (ret) {
> > -		dev_err(dev, "Failed requesting wake_detect gpio %d\n",
> > -			arche_pdata->wake_detect_gpio);
> > +	arche_pdata->wake_detect = devm_gpiod_get(dev, "svc,wake-detect",
> > +						  GPIOD_IN);
> > +	if (IS_ERR(arche_pdata->wake_detect)) {
> > +		ret = PTR_ERR(arche_pdata->wake_detect);
> > +		dev_err(dev, "Failed requesting wake_detect GPIO %d\n", ret);
> 
> Add colon after "GPIO" for consistency (and to avoid ambiguity).
> 

Ok, I'll do that.

Thanks for the review,
Nishad
> >  		return ret;
> >  	}
> 
> Thanks,
> Johan
