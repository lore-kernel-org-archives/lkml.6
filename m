Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF9FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EB6214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WG4yAuSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfAJRnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:43:52 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33273 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730381AbfAJRnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:43:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so5510780plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1Qc8YuntKPVB3Jr8uD6M80vnG/oRO05SSthJtLrjArA=;
        b=WG4yAuSx2mdcj15oj2GwnNN0Mbp77Cg3GaOB3Vij66KXDj8ek3ZemwIgC03C1p3eEy
         18Z1wjla6kAhNuKe89OCXBv+q6TYQCew79+XZcGENYW7n1I4Ovm81aajqoQcs5weJlpk
         o71puYdaB28xZkHw4FdrhircoUMWtJEvB2I3NRzCoXb4BD63cDLJ0Ogl0Zv3WuEskEFr
         JO5NtmmMmO906XKl7ZdwQA9NDqEuaAxd9iW5MoVNeMa1lp8lL60MRgQ5DMJ8Y3yJYRUP
         zzaQ/HIQN9PJfCXvMBOY7cBNtWvXwBCsGEbtQ6gDpdAY/hgVDU6PliXIBVc+9UZKM9fQ
         mGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Qc8YuntKPVB3Jr8uD6M80vnG/oRO05SSthJtLrjArA=;
        b=VM0cfzGisPm8axiMTESQlIjxyWpWoobN5IcvZKLRJ6GESLGhpVgyMgvumS3Frqobi7
         G09GZ9IabWaAV3BRTIIC6MCC92O/bYD9Ew/XDFZmF4K+AQkQ2Gv8Qy+FuMwzLS9TOcBG
         7fKoYOsg8u6qrICR9Qwob6IfwxHADviqxypixRrvw6/MmYl+2M4CgQXvqrnlocqhYggZ
         OF+Yyl0NQ4tfgv2k0BqR1N4uqgWoxKuRU3JNHj6LjDke9FyB4xetILN7vOMMqB4EhRE4
         DTKE7c8gjL6jVDKxa0B/Tr44lJSPQn70/V4Uj6WeE2oZ2CXgXDAbIk/sWJCLaKRDpszC
         OGJw==
X-Gm-Message-State: AJcUukeBVw46kZJ5Kib/BhUaulV5B7sRyuZ25XptmMllCfs86ewLC+EF
        WhcUPcJJKSLeqHFVKG3XxNM=
X-Google-Smtp-Source: ALg8bN60+0xtkVTXkuNsA5WpLbivbpInQ2BvOXpiQVpc3hddhU49NFntxPCA2Y7gyxJWFbFZJcb66w==
X-Received: by 2002:a17:902:a601:: with SMTP id u1mr11178605plq.77.1547142230702;
        Thu, 10 Jan 2019 09:43:50 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id g2sm102280566pfi.95.2019.01.10.09.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 09:43:50 -0800 (PST)
Date:   Thu, 10 Jan 2019 23:13:43 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, nishadkamdar@gmail.com
Subject: Re: [PATCH v4 4/4] staging: greybus: arche-platform: Switch to the
 gpio descriptor interface
Message-ID: <20190110174341.GD24566@nishad>
References: <cover.1545488665.git.nishadkamdar@gmail.com>
 <fa242dd022340b8cd8fa6bab9138a718980b3871.1545488665.git.nishadkamdar@gmail.com>
 <20190109113547.GL14782@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109113547.GL14782@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:35:47PM +0100, Johan Hovold wrote:
> On Sat, Dec 22, 2018 at 08:23:02PM +0530, Nishad Kamdar wrote:
> > Use the gpiod interface instead of the deprecated
> > old non-descriptor interface.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
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
> > -static inline void svc_reset_onoff(unsigned int gpio, bool onoff)
> > +static inline void svc_reset_onoff(struct gpio_desc *gpio, bool onoff)
> >  {
> > -	gpio_set_value(gpio, onoff);
> > +	gpiod_set_value(gpio, onoff);
> >  }
> 
> Please use the raw interface here too, until we've done away with the
> polarity properties and can honour the generic device tree flags. Please
> make a comment about this in the commit message too.
> 
Ok, I'll do that.
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
> > +	arche_pdata->svc_reset = devm_gpiod_get(dev, "svc,reset-gpio", flags);
> 
> Again, you cannot just rename devicetree properties like this. Keep the
> current names for now (and drop the -gpio suffix when requesting).
> 
Ok, I'll so that.
> Johan

Regards,
Nishad

