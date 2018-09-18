Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD321ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743A2214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qugDmGVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743A2214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbeIRH1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:27:46 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55210 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeIRH1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 03:27:46 -0400
Received: by mail-it0-f66.google.com with SMTP id f14-v6so1026950ita.4;
        Mon, 17 Sep 2018 18:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+ph/CdI69Cz/dt8dzdqU1h+T+B6FVoZon4S8uHDN0Fs=;
        b=qugDmGVjATfRb7WnCpRzqAbYDpvGArrYFN9RN02uoDJfNHKIrqwlty0pbEzKHaxPlC
         lTXktfthASCbctuSLvTBs/daBrxieZFwqS18DJEg0/VG/XbXjMRH5LMkSCALkY3pua6M
         3yYfk8buIfjQG2nCmc6fTqlgE3b4/VNSC3c4VVXii5bTa1YBklT28BBiBCsjRmWpmRod
         2X8aRAsxu9ZfrQHNYPL1yu2wmHmHJuY319x+ERzb4b4Gw0ccjMxokDSYOucXmWlRSzIl
         oKraY5ToTnlp2VirQrJUETiJunQ8ZrHXRXSvnUE61x95t15+fTts6tBGNNQSeMQiXJZ1
         6w0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+ph/CdI69Cz/dt8dzdqU1h+T+B6FVoZon4S8uHDN0Fs=;
        b=fZMKb+4/Lt/3W7EC4HflXmKJIXu6rOnq+NyQH9l8gQZEaWwf0vxZhCALwRpym8rPVk
         q5iAAnd9w1RHOTsmf9BvFQbNOZFK4wEf0TjNdxbEEYWIEZYy6NknAcGskh+pFlGYkDxW
         P3GESPG6LTARGtxJntCJ4QVZaMcG9TjXOmv3SXN0FG8a52GlfUG/MPt6pnm4iQKIE9H9
         ss2Jeic3j2Jnm+C7pUumm0YtyNOqavqbrX1PWkkxQkOa+cn7OzHSheZn7wUqmaiJnz8f
         CUlJe3Ldz9EdkXGEgWY/yLeNm+9LeeVB1lPTadlSpAYvuJQJ6qi3sQcd0E4Kcn0GZV6i
         ggzQ==
X-Gm-Message-State: APzg51BBUkzm2GCPYYXk0kswKowRlAEf47ocwCM4hQInAD3LB1QkKQ9S
        3JCnwQ4JxBnBgWYdh4TC1Q==
X-Google-Smtp-Source: ANB0VdYFOUI4tHzJk27zkA0XiyCaZ0Pmxz/DGJ700ga6nU9jcZF+mk/qJQP2Jv0OPskkCbIpcgDj2A==
X-Received: by 2002:a24:8a42:: with SMTP id v63-v6mr901427itd.26.1537235857502;
        Mon, 17 Sep 2018 18:57:37 -0700 (PDT)
Received: from r (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id 138-v6sm11514792ioe.20.2018.09.17.18.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 18:57:36 -0700 (PDT)
Date:   Mon, 17 Sep 2018 21:57:33 -0400
From:   r yang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: bh1750: Add device tree support
Message-ID: <20180918015733.GA19976@r>
References: <c414a26cdc176d9982f3c609fa39cf245ac939be.1537033044.git.decatf@gmail.com>
 <387c145949692c0318f90d98426be95c82ea2e58.1537033044.git.decatf@gmail.com>
 <20180916104526.2c386591@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180916104526.2c386591@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 10:45:26AM +0100, Jonathan Cameron wrote:
> On Sat, 15 Sep 2018 13:42:14 -0400
> ryang <decatf@gmail.com> wrote:
> 
> > Add device tree support for ROHM BH1750 series ambient light sensors.
> > 
> > Signed-off-by: ryang <decatf@gmail.com>
> Just to check, how is it picking up on the enum value which is provided
> in the i2c_device_id entries?
> 
> i.e. What is setting id->driver_data in the probe?
> There may be something in the i2c core that I'm missing that will do the
> association but I don't remember anything trying to do this.
> 
> Jonathan
>

I've looked through it and it is indeed in the i2c core.
The i2c core probe function picks the id entry based on the i2c client
name.

The i2c client name is assigned based on the device tree compatible
string.

  of_i2c_register_device()
    of_i2c_get_board_info()
      of_modalias_node()

During probe the i2c_device_id is picked by matching the i2c
client->name to i2c_device_id->name in the i2c_match_id() function.

  i2c_device_probe()
    driver->probe(client, i2c_match_id(driver->id_table, client));

I've tested this on device. It's Samsung Galaxy Tab 10.1. It has a
BH1721.

> > ---
> >  drivers/iio/light/bh1750.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> > index a814828e69f5..50b599abb383 100644
> > --- a/drivers/iio/light/bh1750.c
> > +++ b/drivers/iio/light/bh1750.c
> > @@ -315,9 +315,19 @@ static const struct i2c_device_id bh1750_id[] = {
> >  };
> >  MODULE_DEVICE_TABLE(i2c, bh1750_id);
> >  
> > +static const struct of_device_id bh1750_of_match[] = {
> > +	{ .compatible = "rohm,bh1710", },
> > +	{ .compatible = "rohm,bh1715", },
> > +	{ .compatible = "rohm,bh1721", },
> > +	{ .compatible = "rohm,bh1750", },
> > +	{ .compatible = "rohm,bh1751", },
> > +	{ }
> > +};
> > +
> >  static struct i2c_driver bh1750_driver = {
> >  	.driver = {
> >  		.name = "bh1750",
> > +		.of_match_table = of_match_ptr(bh1750_of_match),
> >  		.pm = BH1750_PM_OPS,
> >  	},
> >  	.probe = bh1750_probe,
> 
