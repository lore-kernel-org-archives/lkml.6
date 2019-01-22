Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D926C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5929921726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfAVQVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:21:05 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40394 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbfAVQVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:21:04 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18-v6so21133861lji.7;
        Tue, 22 Jan 2019 08:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PkOklqGVwHq7ll/rbU8Gr2vyzx12G/yCiDYJZx1VSDM=;
        b=WBMoRGlgxX0D6GftKGxZ4N7CTt7eY99/9t+w4xitQuDnXs05FrU9ve6X09TeHr5MRx
         Rsxq1X68mU2VDCUxNb26ilD3mmSyJ81WunYuOKc9C/tR3Ds6hcoTmol7fWCpXtqOIVFG
         fs2gCUDJ1ydG2a388byRKCLVvBO8+5/nGu3EzPldaWLx6fkd8UK+lx/qlkCU8XVjrMwY
         iIzNXT7b2g12A+yWfalgbr9K8iCxuhJTlBUJVmGwL31E+JIkfB0+8JahffCpPIlZzd62
         Vb3XaBjrHIqNep/FvPG6XQCLuU24SVP30RbiJNbBRBCKeMUfCS0Kzenjql5915lnI/fi
         w8jw==
X-Gm-Message-State: AJcUukdcujUYXPw5vua3sFOcmwJa6c0ljVe0Nt3bF/+OoXQ+XlHv3fUe
        ki/a15MIHvkXp97XdyXczsY=
X-Google-Smtp-Source: ALg8bN4mDWVXczefW4x1mB9qVDLVkxgh8++OZDBh4hKX7AE4i55P6LtjZf+JxhuAaO9fVvImu1xCKQ==
X-Received: by 2002:a2e:841:: with SMTP id g1-v6mr22650096ljd.21.1548174060850;
        Tue, 22 Jan 2019 08:21:00 -0800 (PST)
Received: from localhost.localdomain (82-203-157-3.bb.dnainternet.fi. [82.203.157.3])
        by smtp.gmail.com with ESMTPSA id p10-v6sm72214ljh.59.2019.01.22.08.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 08:21:00 -0800 (PST)
Date:   Tue, 22 Jan 2019 18:20:51 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     mazziesaccount@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [RFC PATCH v1 05/13] mfd: bd70528: Support ROHM bd70528 PMIC -
 core
Message-ID: <20190122162051.GA2559@localhost.localdomain>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <fea02522fe54190cfc7f3500f4e6540c8af82453.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <9abdc69e-6aea-e1a5-c170-ebcba7f5b20f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9abdc69e-6aea-e1a5-c170-ebcba7f5b20f@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guenter,

Thanks for taking the time and doing review!

On Tue, Jan 22, 2019 at 06:51:26AM -0800, Guenter Roeck wrote:
> On 1/22/19 1:44 AM, Matti Vaittinen wrote:
> > +static DEFINE_MUTEX(rtc_timer_mutex);

// snip

> > +static int bd70528_i2c_probe(struct i2c_client *i2c,
> > +			    const struct i2c_device_id *id)
> > +{
> > +	struct bd70528 *bd70528;
> > +	struct regmap_irq_chip_data *irq_data;
> > +	int ret, i;
> > +
> > +	if (!i2c->irq) {
> > +		dev_err(&i2c->dev, "No IRQ configured\n");
> > +		return -EINVAL;
> > +	}
> > +	bd70528 = devm_kzalloc(&i2c->dev, sizeof(*bd70528), GFP_KERNEL);
> > +
> > +	if (!bd70528)
> > +		return -ENOMEM;
> > +
> > +	dev_set_drvdata(&i2c->dev, bd70528);
> > +	bd70528->rtc_timer_lock = &rtc_timer_mutex;
> 
> One global mutex for all instances of this driver is odd.
> Why isn't this just part of struct bd70528 ?
> 

You are right. This was a brainfart from my side. I don't think there
is many cases where this would har though. I don't expect to see
many instances of PMIC drivers load. But you are correct nevertheless.
I will fix this in future version. Thanks for pointing it out!

Br,
	Matti Vaittinen


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
