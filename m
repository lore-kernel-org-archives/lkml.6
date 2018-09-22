Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7217ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFAF214C1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFShKLh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFAF214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbeIVVWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 17:22:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44458 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeIVVWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 17:22:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so7238033pff.11;
        Sat, 22 Sep 2018 08:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6t3JV44tEgyRy4YvyZjDyEBMQeFXr+J6QlvBu/7eJeM=;
        b=PFShKLh28Yp5lTDS7Rge2insATc+e9+mRl7aTahlbn9azOgYLabwlZzuKn99HG2+a8
         M0LtOn5hpQCxbY5xf0P2fO4iZYYLN7pQ/k1ruVvbmX7lcvNNyL6acoH+69e+9v4TYkgf
         ks2dy2DrJMZ3sYH3V6+GF31WUDfTUpLe3ElQsuHHWj1Foyq2MxLGe28pZZVHAHWZ+me7
         K9RpeOBbymAv4T4jcZ5ycx1KtjZHOvDvdx1+0ENAEfCyajh5PK5pcFTz4ZrLucUy7XnC
         xFp9ROOnMXD5WiIvN11ivpYqUwy7jyIyKGdtJ3URHL5T6OCYwDVr3GLraP2wijZALFYa
         71iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6t3JV44tEgyRy4YvyZjDyEBMQeFXr+J6QlvBu/7eJeM=;
        b=Qa/9HCPc5WocrKYsnPSTDHCx/IRM6loGIpW3e6pdkVXXOoYPiGHEG1Y2cHKj5iQwv7
         dXAe2e0fWFM+A01CcwjoPg8/xMVi+jkmX+FMuGr3rcAdPVgpYY476BZ6bz4ZB6njHPtp
         phbclRwqpOCc5QEP4lKC1O5yTAOL4v/NtMj6vpii433G9UInqAtSMoMnMaRq3QZ5p8Jn
         SLfjY7o75Qdb1nPoPBzr24JaFUakKgxRd7X4u9RsyCAy2SJ3xkHqfEQJixNIoHkGPPr7
         r+qflyVdt+Jm/AxcEh9EFOHbUUJcI2xWJ1FU2m2N5DYLPew4ijT4TQmM3l0KVNN2sTCs
         BolA==
X-Gm-Message-State: ABuFfohyx6aZd8tEk5nKV5dhjHajDV274tIBhL9Xs3asQeLpkuvtfSAS
        ijemkRV4rAO/U0E9uDr2KuA=
X-Google-Smtp-Source: ACcGV62Bd37uMWxFafUi5y1I4bK5zldAQCJSbUORaRJ6xk6JzBl5mLpN9ZM4O5CMtlTsX4i5I5Ol3A==
X-Received: by 2002:a63:d048:: with SMTP id s8-v6mr2643806pgi.311.1537630093545;
        Sat, 22 Sep 2018 08:28:13 -0700 (PDT)
Received: from Eros (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id z5-v6sm38629074pfh.83.2018.09.22.08.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 08:28:13 -0700 (PDT)
Date:   Sat, 22 Sep 2018 23:28:04 +0800
From:   Song Qiang <songqiang1304521@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        andriy.shevchenko@linux.intel.com, matt.ranostay@konsulko.com,
        tglx@linutronix.de, ak@it-klinger.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] iio: proximity: Add driver support for ST's
 VL53L0X ToF ranging sensor.
Message-ID: <20180922152621.GA953@Eros>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
 <20180922154658.752f2fbf@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922154658.752f2fbf@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 03:46:58PM +0100, Jonathan Cameron wrote:
> On Tue, 18 Sep 2018 16:24:21 +0800
> Song Qiang <songqiang1304521@gmail.com> wrote:
> 
> > This driver was originally written by ST in 2016 as a misc input device
> > driver, and hasn't been maintained for a long time. I grabbed some code
> > from it's API and reformed it into an iio proximity device driver.
> > This version of driver uses i2c bus to talk to the sensor and
> > polling for measuring completes, so no irq line is needed.
> > It can be tested with reading from
> > /sys/bus/iio/devices/iio:deviceX/in_distance_input
> > 
> > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> There are a few bits and bobs in here, but as they are all minor and
> one at least was me giving you wrong advise, I've fixed it up.
> 
> Please check I haven't made a mess of it! 
> 
> Applied with changes to the togreg branch of iio.git and pushed out
> as testing (where it should be visible now) for the autobuilders to
> play with it.
> 
> Thanks,
> 
> Jonathan
> > ---

> > +	indio_dev->name = "vl53l0x";
> > +	indio_dev->info = &vl53l0x_info;
> > +	indio_dev->channels = vl53l0x_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(vl53l0x_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	return devm_iio_device_register(&client->dev, indio_dev);
> > +}
> > +
> > +static const struct of_device_id st_vl53l0x_dt_match[] = {
> > +	{ .compatible = "st,vl53l0x-i2c", },
> 
> Ah, this suffers from the same thing that was picked up in a driver
> you sent later in the week.  No need to have -i2c in the compatible
> as this is clear from the bus type.
> 
> (I might just fix this up).
> 

Hi Jonathan,

Sorry for the newbie mistakes you and Himanshu pointed out, I'm just
writing them down on my little checklist!
I just checked the code, found that this compatible string was not
getting corrected in the DT binding doc file, sorry that you have
to help correct my mistakes, thanks a lot!

yours,
Song Qiang

> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, st_vl53l0x_dt_match);
> > +
> > +static struct i2c_driver vl53l0x_driver = {
> > +	.driver = {
> > +		.name = "vl53l0x-i2c",
> > +		.of_match_table = st_vl53l0x_dt_match,
> > +	},
> > +	.probe_new = vl53l0x_probe,
> > +};
> > +module_i2c_driver(vl53l0x_driver);
> > +
> > +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> > +MODULE_DESCRIPTION("ST vl53l0x ToF ranging sensor driver");
> > +MODULE_LICENSE("GPL v2");
> 
