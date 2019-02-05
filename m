Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED755C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEFD2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbfBEHUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 02:20:41 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42280 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfBEHUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 02:20:40 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so1828628lfh.9;
        Mon, 04 Feb 2019 23:20:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZGIyaG9pkVoo/n1eYjzRvLRr1Le0O9TGcAoe8Hji2ns=;
        b=QmT2UB3wfmd2hUltouZU5Q8N6/Z7RHfcMPkNkO/bBw8LA/Bf5gDRNmSFBDmMbGJNpB
         1kqDGWTNFLZldU853ZGzZTaX9dK+9fwTbqz+xDmgGfDCzacisF3w95aPb3bRB4KN3rgM
         6uW083evrNS5xsvdczQ+dl+ux8Xc4CtTH33UX8aULiyI5RxzI/D/peRaH8+H7F+bFiXd
         Zqo06Mjm4QytdqCkzh9QZCzMdloZTOzQiSoP/ut8QFrA4wu2xp84XGV1GZyQczuyBuG4
         ZUq4wznIiGi5eU4qdKf07S2fjXSqMKll8N0BytABiLaSNC2v+VCCn0YMXc7C+dXkNXa6
         U/Ig==
X-Gm-Message-State: AHQUAuYhnKrYPaVYINVZvyTNJR/nukB9YNH/07DJlXwQ30EuIf4TKrj0
        IKK5fr+lVHxukhYfTu0nWlxSeUtc0vM=
X-Google-Smtp-Source: AHgI3IaBxHgeGq9vLiVqzYSqQ0NcctqBy8gEjitnG33Wv0XgrKNajuQusiglQLQCCmnORZljFsZHnw==
X-Received: by 2002:ac2:5085:: with SMTP id f5mr2117535lfm.30.1549351236462;
        Mon, 04 Feb 2019 23:20:36 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id o5-v6sm3064587ljh.75.2019.02.04.23.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 23:20:35 -0800 (PST)
Date:   Tue, 5 Feb 2019 09:20:27 +0200
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
Subject: Re: [RFC PATCH v5 10/10] watchdog: bd70528: Initial support for ROHM
 BD70528 watchdog block
Message-ID: <20190205072027.GA2817@localhost.localdomain>
References: <cover.1549283919.git.matti.vaittinen@fi.rohmeurope.com>
 <c03a470dac74047a72dc3ed8f51ab81f456594d1.1549283920.git.matti.vaittinen@fi.rohmeurope.com>
 <a76ec2b9-a95e-a17a-f231-c1d04ec8e846@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a76ec2b9-a95e-a17a-f231-c1d04ec8e846@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 06:38:43AM -0800, Guenter Roeck wrote:
> On 2/4/19 4:49 AM, Matti Vaittinen wrote:
> > Initial support for watchdog block included in ROHM BD70528
> > power management IC.
> > 
> > Configurations for low power states are still to be checked.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >   drivers/watchdog/Kconfig       |  12 +++
> >   drivers/watchdog/Makefile      |   1 +
> >   drivers/watchdog/bd70528_wdt.c | 187 +++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 200 insertions(+)
> >   create mode 100644 drivers/watchdog/bd70528_wdt.c
> > 
> > +
> > +struct wdtbd70528 {
> > +	struct device *dev;
> > +	struct regmap *regmap;
> > +	struct mutex *rtc_lock;
> > +	struct watchdog_device wdt;
> > +};
> > +
> > +static int bd70528_wdt_set_locked(struct wdtbd70528 *w, int enable)
> > +{
> > +	struct bd70528 *bd70528;
> > +
> > +	bd70528 = container_of(w->rtc_lock, struct bd70528, rtc_timer_lock);
> > +	return bd70528->wdt_set(bd70528, enable, NULL);
> > +}
> 
> Please add an empty line here.

Ok. 

> > +static int bd70528_wdt_set(struct wdtbd70528 *w, int enable)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(w->rtc_lock);
> > +	ret = bd70528_wdt_set_locked(w, enable);
> > +	mutex_unlock(w->rtc_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int bd70528_wdt_start(struct watchdog_device *wdt)
> > +{
> > +	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
> > +
> > +	dev_dbg(w->dev, "WDT ping...\n");
> > +	return bd70528_wdt_set(w, 1);
> > +}
> > +
> > +static int bd70528_wdt_stop(struct watchdog_device *wdt)
> > +{
> > +	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
> > +
> > +	dev_dbg(w->dev, "WDT stopping...\n");
> > +	return bd70528_wdt_set(w, 0);
> > +}
> > +
> > +static int bd70528_wdt_set_timeout(struct watchdog_device *wdt,
> > +				    unsigned int timeout)
> > +{
> > +	unsigned int hours;
> > +	unsigned int minutes;
> > +	unsigned int seconds;
> > +	int ret;
> > +	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
> > +
> > +	seconds = timeout;
> > +	hours = timeout / (60 * 60);
> > +	/* Maximum timeout is 1h 59m 59s => hours is 1 or 0 */
> > +	if (hours)
> > +		seconds -= (60 * 60);
> > +	minutes = seconds / 60;
> > +	seconds = seconds % 60;
> > +
> > +	mutex_lock(w->rtc_lock);
> > +
> > +	ret = bd70528_wdt_set_locked(w, 0);
> > +	if (ret)
> > +		goto out_unlock;
> > +
> > +	ret = regmap_update_bits(w->regmap, BD70528_REG_WDT_HOUR,
> > +				 BD70528_MASK_WDT_HOUR, hours);
> > +	if (ret) {
> > +		dev_err(w->dev, "Failed to set WDT hours\n");
> > +		goto out_en_unlock;
> > +	}
> > +	ret = regmap_update_bits(w->regmap, BD70528_REG_WDT_MINUTE,
> > +				 BD70528_MASK_WDT_MINUTE, bin2bcd(minutes));
> > +	if (ret) {
> > +		dev_err(w->dev, "Failed to set WDT minutes\n");
> > +		goto out_en_unlock;
> > +	}
> > +	ret = regmap_update_bits(w->regmap, BD70528_REG_WDT_SEC,
> > +				 BD70528_MASK_WDT_SEC, bin2bcd(seconds));
> > +	if (ret)
> > +		dev_err(w->dev, "Failed to set WDT seconds\n");
> > +	else
> > +		dev_dbg(w->dev, "WDT tmo set to %u\n", timeout);
> > +
> > +out_en_unlock:
> > +	ret = bd70528_wdt_set_locked(w, 1);
> > +out_unlock:
> > +	mutex_unlock(w->rtc_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct watchdog_info bd70528_wdt_info = {
> > +	.identity = "bd70528-wdt",
> > +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> > +};
> > +
> > +static const struct watchdog_ops bd70528_wdt_ops = {
> > +	.start		= bd70528_wdt_start,
> > +	.stop		= bd70528_wdt_stop,
> > +	.set_timeout	= bd70528_wdt_set_timeout,
> > +};
> > +
> > +/* Max time we can set is 1 hour, 59 minutes and 59 seconds */
> > +#define WDT_MAX_MS ((2 * 60 * 60 - 1) * 1000)
> > +/* Minimum time is 1 second */
> > +#define WDT_MIN_MS 1000
> > +#define DEFAULT_TIMEOUT 60
> > +
> 
> Please move to top, and tab-align the values.

Ok.

> Otherwise I am ok with the patch.
> 
> On a side note, isn't it past time to drop the RFC ?

Well, the two main things for me to send this as RFC were the
regmap-irq change (which I had already discussed with Mark, and which is
now applied already - so that's Ok) and splitting the existing
include/linux/mfd/rohm-bd718x7.h header (patches 1 - 3). I hoped to get
commnts from Lee, Stephen and Mark for the idea of header split (this
impacts to already submitted bd718x7 driver and I was unsure if this good
or bad approach) but I haven't heard of Lee or Stephen yet.

Still, I have now received acks for dt-bindings, regulators, gpio and
now also for wdt - and I don't think these are heavily impacted even if
the header split was not Ok - so I guess dropping the RFC makes sense.
Thanks for pointing that out.

I'll send v6 with changes you suggested here and drop the RFC.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
