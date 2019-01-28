Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D125C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8EF20844
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbfA1QRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:17:15 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45751 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388142AbfA1QRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:17:13 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so14699789ljd.12;
        Mon, 28 Jan 2019 08:17:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=02Z4Y/VtUKNB+3hQYTEh9goJq0x6vAgNA823SkAWJAk=;
        b=ZZKQdwiuhat0Xul/nbD0JIgGPKW+3P/vHEyJiFyN4k1xoYK3lwcLpWJs88e9mSUwiP
         ruhilUDsvYlO+fvOW4yKEC+8p4ViuXIc+rqdlc7T/6XIfNvBVNvQI2yu0FDTAonn1wLU
         O7EEz7KHyLepqNThPHI5R+2xOmt1KhYBV6Lf+0FvvUwZQYY7A07F9KBEQuaBf1gNydBW
         kRsC0l9PCwtyZFqkoG+8RddZS+KiDgPTaZogKhM/W+lLt06nPkEZXFnnRVZrmS15wvGs
         ceOj0oVcO1/cjOxw9i/TgDz7Jom2jdHfI1pss1U+9iDxmh4NFhrc8JcegahhgZ+fhNIT
         0lHg==
X-Gm-Message-State: AJcUukcZCVgIzpxthOQdmUYAu4fm/0wVMyqFD/5dx0c3kaSecCPlY3qz
        rFbIilMEf3nAztFovXd/hww=
X-Google-Smtp-Source: ALg8bN41z723oGKt3ZuGbr0tHZmfSBAk/gvqUgRXEU+HcWVT7Jd8jVwv3ncU7TTZeTLytmh5bT+Tkw==
X-Received: by 2002:a2e:6503:: with SMTP id z3-v6mr17780348ljb.153.1548692229874;
        Mon, 28 Jan 2019 08:17:09 -0800 (PST)
Received: from localhost.localdomain (dytkl7s9vpj00trvf9g2y-4.rev.dnainternet.fi. [2001:14bb:410:9dbf:b161:fde8:3a24:e96c])
        by smtp.gmail.com with ESMTPSA id 85-v6sm3135206lja.16.2019.01.28.08.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 08:17:09 -0800 (PST)
Date:   Mon, 28 Jan 2019 18:16:59 +0200
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
Message-ID: <20190128161659.GA2121@localhost.localdomain>
References: <20190125110536.GA29321@localhost.localdomain>
 <35bbc5b9-5f8c-ec80-3eaa-bb2c0e2812c9@roeck-us.net>
 <20190128074849.GB2030@localhost.localdomain>
 <11ff93bf-c71f-7489-841f-09bf757a8ba7@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11ff93bf-c71f-7489-841f-09bf757a8ba7@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 06:02:47AM -0800, Guenter Roeck wrote:
> On 1/27/19 11:48 PM, Matti Vaittinen wrote:
> > Thanks again Guenter,
> > 
> > On Sat, Jan 26, 2019 at 08:30:24AM -0800, Guenter Roeck wrote:
> > > On 1/25/19 3:05 AM, Matti Vaittinen wrote:
> > > > +/*
> > > > + * We read regs RTC_SEC => RTC_YEAR
> > > > + * this struct is ordered according to chip registers.
> > > > + * Keep it u8 only to avoid padding issues.
> > > > + */
> > > > +struct bd70528_rtc_day {
> > > > +	u8 sec;
> > > > +	u8 min;
> > > > +	u8 hour;
> > > > +};
> > > > +
> > > > +struct bd70528_rtc_data {
> > > > +	struct bd70528_rtc_day time;
> > > > +	u8 week;
> > > > +	u8 day;
> > > > +	u8 month;
> > > > +	u8 year;
> > > > +};
> > > > +
> > > > +struct bd70528_rtc_wake {
> > > > +	struct bd70528_rtc_day time;
> > > > +	u8 ctrl;
> > > > +};
> > > > +
> > > > +struct bd70528_rtc_alm {
> > > > +	struct bd70528_rtc_data data;
> > > > +	u8 alm_mask;
> > > > +	u8 alm_repeat;
> > > > +};
> > > 
> > > At least some of the above are directly associated with chip registers.
> > > I don't think this will work for all architectures without explicit packed
> > > attribute.
> > 
> > Allright. I was thinking of that but thought that most of the
> > architectures using this PMIC would handle alignments fine if I used
> > only u8 members. I did consider using __attribute__((packed)) - but I'm
> > not sure if we hit into troubles with that too. I guess some people
> > would like to compile kernel with other compiler(s) but gcc - although
> > I'm not sure if this should be taken into account. I'll try doing some
> > study on this - unless someone replies to this and just tells how this
> > should be done. (I am pretty sure I can find the answer from mail
> > archives though). I'll try adding some packing hint for compiler at v3.
> > 
> 
> Use __packed ?

Right. That appends to __attribute__((packed)) on gcc. I'll use that.
Thanks for the tip :)

Br,
	Matti Vaittinen
