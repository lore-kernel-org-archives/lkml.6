Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD907C282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 00:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974DF218FF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 00:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQf6hAa1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfAZAzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 19:55:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35498 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfAZAzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 19:55:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so5311069plo.2;
        Fri, 25 Jan 2019 16:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y9iFsUiO/WbQXdNfoAP0UGyMHMfi/LlzHR8NdSQFJcQ=;
        b=TQf6hAa1/eMqenX671m0CLGxi23K5uWiKG9KgNp3OvIoHffKbeTCBC8q3YJdocggRp
         g8Hb0/NW3vyg04SLfLiFgHxJeC8z3ds9I8Lux5mZd1CsA0PZq3AFrh72imrhyUNWSfdF
         gUK8oSoU/fKkR4TbIqNgmwwEYzplVsRU3D0bdgsVRMIlO2Qf3MGU8rXrmBn2YwXqSsRL
         2vknLXknR3Z9VA9NRvMp4vg438PNzj282ZzmaeW3x/tCf2fjsl9/5YHg03SYy0SQZ3Md
         W8455UYlUz+ucM6riOWDK93h0QtNLJSnVSdn/Yril6ovSh/uiTLHwfQXWXw/EBxsduk7
         WboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y9iFsUiO/WbQXdNfoAP0UGyMHMfi/LlzHR8NdSQFJcQ=;
        b=h8nZKvb/JDDBirnZWrmH1ndjnsOmNSpT90a03VafhiiuL1n5pJ5U6oqqkeCCfAsx8M
         8BFjvTg3VyDLn9i9/vNaokt7VzQ7yGeUSkjG2b9OK2bl3WOt5RuyrI48sFNj/5N5wGPn
         a4P6hb5pEVtN2cm0ONlSZaGSPlO+Qv6yTes+i/vFJnxh9GAXwctyUMc7jZmSpNHouhA3
         2DJwNJwQJiSd8y86drNiyxZrqa3df429G0pJBaeY8enx/N++6V4as2Yqc2SilO+sWrWt
         TxoK78ifsT1FpfvllQ8vLql7LH40AdaOmkhRLfnYlBf1NC04zwR36Qv85/OvgTkuUbyG
         gq1g==
X-Gm-Message-State: AJcUukfI/w3RuP6D7s02iB3o3mgPfG2N6LMNX6lydOGYxC4pj/7+rR4u
        E4w6x548RikiLfSBFlUqrcQ=
X-Google-Smtp-Source: ALg8bN48m8CZXojx36XPO3/pcEhW3AX6H/yfHswvgMDw/hFtplSFx7UpcIS848cD1fwx6Pi5YYQ2XQ==
X-Received: by 2002:a17:902:4222:: with SMTP id g31mr13176078pld.240.1548464139118;
        Fri, 25 Jan 2019 16:55:39 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id g15sm107380895pfj.131.2019.01.25.16.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 16:55:38 -0800 (PST)
Date:   Fri, 25 Jan 2019 16:55:36 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        chinyeow.sim.xt@renesas.com, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: Re: [PATCH v2 2/2] Input: st1232 - add support for st1633
Message-ID: <20190126005536.GA212026@dtor-ws>
References: <20190124102125.25458-1-martink@posteo.de>
 <20190124102125.25458-2-martink@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124102125.25458-2-martink@posteo.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Thu, Jan 24, 2019 at 11:21:25AM +0100, Martin Kepplinger wrote:
> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> 
> Add support for the Sitronix ST1633 touchscreen controller to the st1232
> driver. A protocol spec can be found here:
> www.ampdisplay.com/documents/pdf/AM-320480B6TZQW-TC0H.pdf
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
> 
> while this works, I'm not totally convinced by how the i2c path of probe
> looks. what do you say?

Not quite what I had in mind. See below...

>  static int st1232_ts_probe(struct i2c_client *client,
>  			   const struct i2c_device_id *id)
>  {
>  	struct st1232_ts_data *ts;
> +	struct st1232_ts_finger *finger;
>  	struct input_dev *input_dev;
>  	int error;
> +	const struct st_chip_info *match = NULL;
> +
> +	if (dev_fwnode(&client->dev))
> +		match = device_get_match_data(&client->dev);
> +	else if (id && id->driver_data == st1232)
> +		match = &st1232_chip_info;
> +	else if (id && id->driver_data == st1633)
> +		match = &st1633_chip_info;
> +	if (!match) {
> +		dev_err(&client->dev, "unknown device model\n");
> +		return -ENODEV;
> +	}

If you do:

static const struct i2c_device_id st1232_ts_id[] = {
	{ ST1232_TS_NAME, (unsigned long)&st1232_chip_info },
	{ ST1633_TS_NAME, (unsigned long)&st1633_chip_info },
	{ }
};


Then you can do:

	match = device_get_match_data(&client->dev);
	if (!match && id)
		match = (const void *)id->driver_data;
	if (!match) {
		dev_err(&client->dev, "unknown device model\n");
		return -ENODEV;
	}

Thanks.

-- 
Dmitry
