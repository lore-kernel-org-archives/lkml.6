Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CWlPDu+FGFsKUQAAmS7hNA
	; Thu, 07 Jun 2018 01:10:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1C4C1608BF; Thu,  7 Jun 2018 01:10:07 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M0bbecJN"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9DAE5601D2;
	Thu,  7 Jun 2018 01:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9DAE5601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbeFGBKD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 21:10:03 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43451 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbeFGBKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 21:10:02 -0400
Received: by mail-pl0-f66.google.com with SMTP id c41-v6so4910371plj.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 18:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NgcGcwRJQfsC8smF1Adxnkq+QLg1zEYTAb0FfFi51Zc=;
        b=M0bbecJNXpgSViSE9SUgaYuiZW4T5Cix5syuQ+F70X8ir1bIRvvpd/tox5Y9lYMCDJ
         acfmBhyDeZGuRxdIu1FdEeEpw+o4kUi+tVvXvoRjJEPqbgiGmeOIdVYGUU/mcL/oBtWH
         k11FjPwg6ixOAFFG2LxuNF263pRSzIqHMepA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NgcGcwRJQfsC8smF1Adxnkq+QLg1zEYTAb0FfFi51Zc=;
        b=OMywnIa7SEXZt8qbzELqFD9bC70n7C7bWlOSe57JJZjRQs/DnM4MZUDzWnRQ2F39v+
         D/IyK8UxkOvTz619JpqQ/blzAYVW7C1o6oKehc5+9hRC/g6U3A2SYX+GRNogkYtNpdGW
         RZ3qhVC7C+2UPD1fC5TeT/vhWuUCeo+SUt/ejEf0t7PuN9nDio67DYbFiyG+tGPGUyMa
         mW6SMn2HteY4Ub8paCYBWNt3lMoI/R5tgmdQPn8k2b6ffHcNhnesHm2zS8IHDr0lN2PR
         g/9KPf1w4rDFDjOE0AeBHIO82X/7EIShCiXUTZmO72gBqhN3c3ubMzMpq29f4oP0hxMf
         KCDw==
X-Gm-Message-State: APt69E0xwjTIvgqftVFILABp9msM3EFQlLNqEsrceJZj/rbBAJZwwjUX
        TI7A89uqojJ/TzkstWn8LGcVUw==
X-Google-Smtp-Source: ADUXVKLV84VU/WuMv+xoyWFCyinwbfkSC+3zrDRYvkk8yRHIa0ZBgNbjDMWWKPt9mSCRv3WMVjW2ug==
X-Received: by 2002:a17:902:2805:: with SMTP id e5-v6mr5523061plb.55.1528333801572;
        Wed, 06 Jun 2018 18:10:01 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id x24-v6sm52456153pfj.104.2018.06.06.18.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 18:09:59 -0700 (PDT)
Date: Wed, 6 Jun 2018 18:09:57 -0700
From: Brian Norris <briannorris@chromium.org>
To: Phil Reid <preid@electromag.com.au>
Cc: Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Rhyland Klein <rklein@nvidia.com>,
        Alexandru Stan <amstan@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 1/2] power: supply: sbs-battery: don't assume
 MANUFACTURER_DATA formats
Message-ID: <20180607010955.GA209574@rodete-desktop-imager.corp.google.com>
References: <20180602012900.181352-1-briannorris@chromium.org>
 <7cbe27cf-2917-a17b-07bf-e5fdeb5fef15@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cbe27cf-2917-a17b-07bf-e5fdeb5fef15@electromag.com.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Wed, Jun 06, 2018 at 10:03:59AM +0800, Phil Reid wrote:
> On 2/06/2018 09:28, Brian Norris wrote:
> >   drivers/power/supply/sbs-battery.c | 54 +++++++++++++++++++++++++-----
> >   1 file changed, 46 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> > index 83d7b4115857..a9691ea42f44 100644
> > --- a/drivers/power/supply/sbs-battery.c
> > +++ b/drivers/power/supply/sbs-battery.c

...

> > @@ -806,6 +837,7 @@ static int sbs_probe(struct i2c_client *client,
> >   	if (!chip)
> >   		return -ENOMEM;
> > +	chip->flags = (u32)(uintptr_t)of_device_get_match_data(&client->dev);
> >   	chip->client = client;
> >   	chip->enable_detection = false;
> >   	psy_cfg.of_node = client->dev.of_node;
> > @@ -915,12 +947,15 @@ static int sbs_suspend(struct device *dev)
> >   	if (chip->poll_time > 0)
> >   		cancel_delayed_work_sync(&chip->work);
> > -	/*
> > -	 * Write to manufacturer access with sleep command.
> > -	 * Support is manufacturer dependend, so ignore errors.
> > -	 */
> > -	sbs_write_word_data(client, sbs_data[REG_MANUFACTURER_DATA].addr,
> > -		MANUFACTURER_ACCESS_SLEEP);
> > +	if (chip->flags & SBS_FLAGS_TI_BQ20Z75) {
> > +		/*
> > +		 * Write to manufacturer access with sleep command.
> > +		 * Support is manufacturer dependent, so ignore errors.
> > +		 */
> > +		sbs_write_word_data(client,
> > +				    sbs_data[REG_MANUFACTURER_DATA].addr,
> > +				    MANUFACTURER_ACCESS_SLEEP);
> > +	}
> 
> Now that this is only being done for only TI devices that support this I would think the comment
> about ignoring errors needs to go, and errors checks added.
> Ditto in the new sbs_get_ti_battery_presence_and_health()

Seems reasonable. I'll look at doing that and respinning.

> >   	return 0;
> >   }

Thanks,
Brian
