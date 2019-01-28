Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AD3C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2692E20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfA1Hs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:48:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42851 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfA1Hs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:48:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so13341677lja.9;
        Sun, 27 Jan 2019 23:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tcOCp8of7K1VvdRoo3+VkXtmUKgqAO/Ldh/NbgNbGSs=;
        b=hNi6Wz11RlBDasAtV5vT/DKuaEKX3bDo+FrPP+QBfAtLsysvPcOaEIDu1KhkX1wUx3
         A37AyCG0uJgF5npc4AizObfODZoaHj57Z5oT5UI/DczXvKQMeO9kG5HXpWok34dhnxNG
         LuxqE9FTQ7gLEldD+P7jfaRNM1RoU2VqGEgs+pBuQrBxZA0c5UV0IgVRP3DCesRdMWu/
         0W9rWDIeMp7m8TtGKfQLVaW02Qq9OykxNtd3wl8nc/OiMPl/zGATIos+PlMtLj7lxz52
         a/szjQGxckZKuTfxdUSlOaA0cWV0EXJd+jBHlvz8wodMrZdM8f8TtvbGi3KQrDc+DdIu
         lbWA==
X-Gm-Message-State: AJcUukcP9wDecenHTriixaifRyyUTevHYuSB0EN3a6/C2hwtlt6/c5KD
        UheUoUXZE26TWi9YH76ke80=
X-Google-Smtp-Source: ALg8bN5ANr1VznXWl85llSwR9jiZE+NOQY5Am11MEe55qpPe73C2UGWFkq2jlNqw1DpN8uXmtkXl/g==
X-Received: by 2002:a2e:c41:: with SMTP id o1-v6mr16399186ljd.152.1548661734332;
        Sun, 27 Jan 2019 23:48:54 -0800 (PST)
Received: from localhost.localdomain (dytkl7s9vpj00trvf9g2y-4.rev.dnainternet.fi. [2001:14bb:410:9dbf:b161:fde8:3a24:e96c])
        by smtp.gmail.com with ESMTPSA id 18-v6sm2870799ljg.83.2019.01.27.23.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 23:48:53 -0800 (PST)
Date:   Mon, 28 Jan 2019 09:48:49 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
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
Message-ID: <20190128074849.GB2030@localhost.localdomain>
References: <20190125110536.GA29321@localhost.localdomain>
 <35bbc5b9-5f8c-ec80-3eaa-bb2c0e2812c9@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35bbc5b9-5f8c-ec80-3eaa-bb2c0e2812c9@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks again Guenter,

On Sat, Jan 26, 2019 at 08:30:24AM -0800, Guenter Roeck wrote:
> On 1/25/19 3:05 AM, Matti Vaittinen wrote:
> > +/*
> > + * We read regs RTC_SEC => RTC_YEAR
> > + * this struct is ordered according to chip registers.
> > + * Keep it u8 only to avoid padding issues.
> > + */
> > +struct bd70528_rtc_day {
> > +	u8 sec;
> > +	u8 min;
> > +	u8 hour;
> > +};
> > +
> > +struct bd70528_rtc_data {
> > +	struct bd70528_rtc_day time;
> > +	u8 week;
> > +	u8 day;
> > +	u8 month;
> > +	u8 year;
> > +};
> > +
> > +struct bd70528_rtc_wake {
> > +	struct bd70528_rtc_day time;
> > +	u8 ctrl;
> > +};
> > +
> > +struct bd70528_rtc_alm {
> > +	struct bd70528_rtc_data data;
> > +	u8 alm_mask;
> > +	u8 alm_repeat;
> > +};
> 
> At least some of the above are directly associated with chip registers.
> I don't think this will work for all architectures without explicit packed
> attribute.

Allright. I was thinking of that but thought that most of the
architectures using this PMIC would handle alignments fine if I used
only u8 members. I did consider using __attribute__((packed)) - but I'm
not sure if we hit into troubles with that too. I guess some people
would like to compile kernel with other compiler(s) but gcc - although
I'm not sure if this should be taken into account. I'll try doing some
study on this - unless someone replies to this and just tells how this
should be done. (I am pretty sure I can find the answer from mail
archives though). I'll try adding some packing hint for compiler at v3.

> > +		if ((!enable) == (!(*old_state & BD70528_WAKE_STATE_BIT)))
> > +			return 0;
> 
> I think
> 		if (enable == !!(*old_state & BD70528_WAKE_STATE_BIT))
> would be much better readable. Even if not, there are way too many ()
> in the above conditional.

Allright. I'll fix this
 
> > +	if (alm.alm_mask & BD70528_MASK_ALM_EN)
> > +		a->enabled = 0;
> > +	else
> > +		a->enabled = 1;
> > +
> Without conditional:
> 	a->enabled = !(alm.alm_mask & BD70528_MASK_ALM_EN);
> 

Right. Much nicer, thanks! I'll change this.

> > +static int bd70528_set_time(struct device *dev, struct rtc_time *t)
> > +{
> > +	int ret, old_states;
> > +	struct bd70528_rtc_data rtc_data;
> > +	struct bd70528_rtc *r = dev_get_drvdata(dev);
> > +	struct bd70528 *bd70528 = r->mfd;
> > +
> > +	ret = bd70528_disable_rtc_based_timers(r, &old_states);
> > +
> 
> AFAICS the disable/enable functions are only called once. Since they
> also apply set / clear a mutex, I find that a bit confusing. I think
> it would be better to fold the code into this function. If anything,
> I could imagine something like
> 
> 	mutex_lock();
> 	ret = bd70528_set_time_locked();
> 	mutex_unlock()
> 
> to simplify error handling.

Yep. Makes sense. I'll tidy this.

> > +	ret = regmap_bulk_read(bd70528->chip.regmap,
> > +			       BD70528_REG_RTC_START, &rtc_data,
> > +			       sizeof(rtc_data));
> > +
> > +	tm2rtc(t, &rtc_data);
> > +
> > +	ret = regmap_bulk_write(bd70528->chip.regmap,
> > +				BD70528_REG_RTC_START, &rtc_data,
> > +				sizeof(rtc_data));
> > +
> > +	ret = bd70528_re_enable_rtc_based_timers(r, old_states);
> > +
> 
> Kind of off that all the error returns are ignored here.

And I'll fix this too.

Br,
	Matti Vaittinen
