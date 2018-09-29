Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D76AC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05FB204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMIHefDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05FB204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbeI3Blr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 21:41:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41824 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbeI3Blr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 21:41:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id m77-v6so6461325pfi.8;
        Sat, 29 Sep 2018 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vfqo778IyMYAQWDACqUhXbm0JKuyuwSseqFy5rOXp2o=;
        b=TMIHefDPcxyWLio+UC299cEVdc1ilzoPq9L/SduMuaMxRnFVa+aWvBxHeZms8Pa/tM
         kzWqHmJury/QtXdtrC5PlqHmdhh19F0H1el81t1DCq4SvORnN0zFR9CnHuv0fyr5BxJw
         Z4ebqKgZSuF2xr4pHEltUAcYkYkK6IQENaOy9DcUh21rnpu5HRMrDb3k4A39hhCrAf0P
         K+k+GdgCKsUMiGhCTuTn00RPx82kjKc1++1bKbxHdKgR2xPDN2WZQ97cAx2aONWaHoHC
         NkdBFS6atXwAMbSGCvlcU/qChTS1YSqWQwBqrJNEKBuY8ScqNBQPNvaUWin5RjJ4ke85
         kbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vfqo778IyMYAQWDACqUhXbm0JKuyuwSseqFy5rOXp2o=;
        b=bUSPodzGOmYcQOlfZnKhSdyOuDKpZ3QrnlT2VzqM/dn0LlXSAgLaOVAEttrYtWTkxw
         2+B+hZ99pkWh4P5nBNj48uHzr0D2J7Rm8DHS4K7INiWqL6n0i85nByRxdeQwQiHnA7vh
         VbkehcehbpWNvBA6Q4rSLsKNDE4h/B6VzUVeWuNDTksarpNut0jqRwHfg6YSTRrJHcMP
         r4dNCfqEr8cFZblNXWQebeY4R2XFGfLQhb8fOMhqZ/VBOz3FE3hYkl/MR1rXxKqwfcns
         kPVGt6gYK+rR7NPbN+fmlm3JBu/iKrgdiBLAkyhPwDiHQCVtnn2s4KaTYyYPB2pGG2X/
         9oEQ==
X-Gm-Message-State: ABuFfoj525L+eegR/SFUmKn2xjC9fJ5+ji84m6pYRl7HZi/DCOu7+Ouo
        +h00YzzBmwVltT0GbNeWlsU=
X-Google-Smtp-Source: ACcGV62YzfgfGrA/EZxK9UtmgWek2/e5q5tuqH7SfmgIc3DQk1m1Zn6eSt0BiOtm3Dx9xApwSxam6A==
X-Received: by 2002:a17:902:bcc4:: with SMTP id o4-v6mr4335909pls.42.1538248331544;
        Sat, 29 Sep 2018 12:12:11 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r12-v6sm10948218pfh.79.2018.09.29.12.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 12:12:11 -0700 (PDT)
Date:   Sat, 29 Sep 2018 12:12:05 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: ina3221: Add suspend and resume functions
Message-ID: <20180929191122.GA19962@Asurada-Nvidia.nvidia.com>
References: <20180928214921.11528-1-nicoleotsuka@gmail.com>
 <20180928214921.11528-3-nicoleotsuka@gmail.com>
 <20180929153346.GA26651@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929153346.GA26651@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 08:33:46AM -0700, Guenter Roeck wrote:
> On Fri, Sep 28, 2018 at 02:49:21PM -0700, Nicolin Chen wrote:
> > Depending on the hardware design, an INA3221 chip might lose
> > its power during system suspend/resume. So this patch adds
> > a pair of suspend and resume functions to cache the register
> > values including config register value and limit settings.
> > 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> >  drivers/hwmon/ina3221.c | 54 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> > 
> > diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> > index cfe65ff01051..26f66f728b27 100644
> > --- a/drivers/hwmon/ina3221.c
> > +++ b/drivers/hwmon/ina3221.c
> > @@ -91,11 +91,13 @@ static const unsigned int register_channel[] = {
> >   * @regmap: Register map of the device
> >   * @fields: Register fields of the device
> >   * @shunt_resistors: Array of resistor values per channel
> > + * @reg_config: Register value of INA3221_CONFIG
> >   */
> >  struct ina3221_data {
> >  	struct regmap *regmap;
> >  	struct regmap_field *fields[F_MAX_FIELDS];
> >  	int shunt_resistors[INA3221_NUM_CHANNELS];
> > +	u32 reg_config;
> >  };
> >  
> >  static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
> > @@ -415,8 +417,59 @@ static int ina3221_probe(struct i2c_client *client,
> >  		return PTR_ERR(hwmon_dev);
> >  	}
> >  
> > +	dev_set_drvdata(dev, ina);
> > +
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int ina3221_suspend(struct device *dev)
> > +{
> > +	struct ina3221_data *ina = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	/* Save config register value and enable cache-only */
> > +	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
> > +	if (ret)
> > +		return ret;
> > +
> 
> Would it make sense to explicitly disable all channels here ?

For power saving? I could add it to v2.

Thanks
Nicolin
