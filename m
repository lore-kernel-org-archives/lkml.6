Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB652C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7362177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbfA2HBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:01:18 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38834 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfA2HBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:01:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so16506459lja.5;
        Mon, 28 Jan 2019 23:01:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+/qwbFdY2Na2O0rltiLqHVRyBmVnE1tqShBeGQVCfYo=;
        b=D97IzD7d+iSTgpczYajGpmstLRYE7BWFhf3DlkbObNQKpYLjrUL9hlMh8qnlyt0K20
         oFzgXUNhWkzdyiBaRKi7byT27UWr5G6nMFMg7vtxJfbwlu0+5TLwySsHfE+e6wLbSRKk
         b9229jmyG4CvKenK34d/b1FeMi9Bp5Qzlluhg5PcCBYDpdRI8JWmYqDcK/HMyu/fhffX
         ov+qRmL0GNX3ew023cL3It3hRH0dt/9qe+ss3HzULqF9NyfUjCd8qnpJdERX+DOFDgSW
         k2sUM0KJBKky5yZ1L/bnoontLls/sAhdBDtN9x4zUwzv1t/PC6QIFGDJWw+uf7hwnks7
         gXCA==
X-Gm-Message-State: AJcUukfBq5vJjRwACFUOUz2ZqB1TmT68sB1nAX0SKJg+Rfa/Cp8CqiLT
        jY3Ol0pzz2mIyriDNgpgB/k=
X-Google-Smtp-Source: ALg8bN4MehNiWJ2Bq2slhWgMve4uHvp78jlZUoPkr8MoWVegVKz49ykLgUBMZVF8/qz9xQjw8Ghzsg==
X-Received: by 2002:a2e:8e8e:: with SMTP id z14-v6mr16475950ljk.84.1548745275175;
        Mon, 28 Jan 2019 23:01:15 -0800 (PST)
Received: from localhost.localdomain (dytkl7s9vpj00trvf9g2y-4.rev.dnainternet.fi. [2001:14bb:410:9dbf:b161:fde8:3a24:e96c])
        by smtp.gmail.com with ESMTPSA id s9-v6sm3062759lja.12.2019.01.28.23.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 23:01:14 -0800 (PST)
Date:   Tue, 29 Jan 2019 09:01:03 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, mazziesaccount@gmail.com,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [RFC PATCH v2 08/10] rtc: bd70528: Initial support for ROHM
 bd70528 RTC
Message-ID: <20190129070103.GA2551@localhost.localdomain>
References: <20190125110536.GA29321@localhost.localdomain>
 <35bbc5b9-5f8c-ec80-3eaa-bb2c0e2812c9@roeck-us.net>
 <20190128202656.GA17466@anatevka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128202656.GA17466@anatevka>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 01:26:56PM -0700, Jerry Hoemann wrote:
> On Sat, Jan 26, 2019 at 08:30:24AM -0800, Guenter Roeck wrote:
> > On 1/25/19 3:05 AM, Matti Vaittinen wrote:
> > > +static int bd70528_set_wake(struct bd70528 *bd70528,
> > > +			    int enable, int *old_state)
> > > +{
> > > +	int ret;
> > > +	unsigned int ctrl_reg;
> > > +
> > > +	ret = regmap_read(bd70528->chip.regmap, BD70528_REG_WAKE_EN, &ctrl_reg);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (old_state) {
> > > +		if (ctrl_reg & BD70528_MASK_WAKE_EN)
> > > +			*old_state |= BD70528_WAKE_STATE_BIT;
> > > +		else
> > > +			*old_state &= ~BD70528_WAKE_STATE_BIT;
> > > +
> > > +		if ((!enable) == (!(*old_state & BD70528_WAKE_STATE_BIT)))
> > > +			return 0;
> > 
> > I think
> > 		if (enable == !!(*old_state & BD70528_WAKE_STATE_BIT))
> > would be much better readable. Even if not, there are way too many ()
> > in the above conditional.
> > 
> 
> The substitution is not equivalent to original.  I think you mean:
> 
>  		if (!!enable == !!(*old_state & BD70528_WAKE_STATE_BIT))

Thanks Jerry! Good catch! I originally wanted that all non-zero values
of 'enable' would be 'true'. So maybe I just use the original approach
but get rid of extra parenthesis which were pointed out by Guenter.

		if (!enable == !(*old_state & BD70528_WAKE_STATE_BIT))
should do it just fine, right?

Br,
	Matti
