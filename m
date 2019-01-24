Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D52C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294D021855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfAXKon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:44:43 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44529 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfAXKom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:44:42 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so4759965lji.11;
        Thu, 24 Jan 2019 02:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hGK0TSry9wU/GF16Ejw34cROI9xmo1iBl3H5hZu+ivc=;
        b=ayHvEcyo9NnzIa8udeViMnBD6av9Z1XF3kA4DfhhTpL7aWnAzyAkc45bNBzUcwtf9P
         S113xolBXEtT803Ccy4AuB5ZW5NCLp7ij83+pni+ybOLM27yuhpZKCBvCihws8HLYn6i
         AbooCiV/OIEBsPPBC7Z3QDMdkUe4tk0gtyKL5QjmHxBFw/ix4Qg3fgtEkbGMmQBzwH56
         Uj6ZFeQsXBkwvpVTY2ajrzd+6t0O1HpbAGUhViY8xeBk3NkAld/kf/tNi9eHRcr7u9wy
         V3R6WLtA3mNl0YT7TngeCgDZ7ctuuPQ1nxmy6e5jehf0ZwhRrZqhlEKQNCPqMspVw8N6
         JSDA==
X-Gm-Message-State: AJcUuketEwi8cymifiktBWsU3d8IM2KFn4ENFbTqnNbgi/Y3SfFJIoJl
        UTNzpImWwnCfJrAQND5kPgI=
X-Google-Smtp-Source: ALg8bN6QWN0ZSO4D01kCBuVCpP8osM4lgcttt7BDvcbvj7hAbpR/zZVJii4tJENAW8CKhm9Ts/xvdA==
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr4924150ljb.126.1548326678883;
        Thu, 24 Jan 2019 02:44:38 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id m4-v6sm912945ljb.58.2019.01.24.02.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 02:44:38 -0800 (PST)
Date:   Thu, 24 Jan 2019 12:44:35 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, mazziesaccount@gmail.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        wim@linux-watchdog.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [RFC PATCH v1 13/13] watchdog: bd70528: Initial support for ROHM
 BD70528 watchdog block
Message-ID: <20190124104434.GF2559@localhost.localdomain>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <ec70833179d1953dbc91e01901b79d3319ff013d.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <20190122154750.GB1705@roeck-us.net>
 <20190122171023.GC2559@localhost.localdomain>
 <20190122174056.GB4964@roeck-us.net>
 <20190122180309.GD2559@localhost.localdomain>
 <20190123174728.uu7zhno5xea2bga7@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123174728.uu7zhno5xea2bga7@earth.universe>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 06:47:28PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Jan 22, 2019 at 08:03:09PM +0200, Matti Vaittinen wrote:
> > On Tue, Jan 22, 2019 at 09:40:56AM -0800, Guenter Roeck wrote:
> > > On Tue, Jan 22, 2019 at 07:10:23PM +0200, Matti Vaittinen wrote:
> > > > On Tue, Jan 22, 2019 at 07:47:50AM -0800, Guenter Roeck wrote:
> > > > > On Tue, Jan 22, 2019 at 11:48:36AM +0200, Matti Vaittinen wrote:
> > > > > > +static int bd70528_wdt_probe(struct platform_device *pdev)
> > > > > > +{
> > > > > > +	struct bd70528 *tmp;
> > > > > > +	struct bd70528 *bd70528;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	tmp = dev_get_drvdata(pdev->dev.parent);
> > > > > > +	if (!tmp) {
> > > > > > +		dev_err(&pdev->dev, "No MFD driver data\n");
> > > > > > +		return -EINVAL;
> > > > > > +	}
> > > > > > +	bd70528 = devm_kzalloc(&pdev->dev, sizeof(*bd70528), GFP_KERNEL);
> > > > > > +	if (!bd70528)
> > > > > > +		return -ENOMEM;
> > > > > > +
> > > > > > +	*bd70528 = *tmp;
> > > > > > +	bd70528->chip.dev = &pdev->dev;
> > > > > 
> > > > > This is wrong.
> > > > > You should not copy the parent's driver data but have local driver
> > > > > data as needed which then points to the parent's driver data if
> > > > > needed. I assume this is why the mutex is a pointer, but that
> > > > > just shows that the whole approach is wrong.
> > > > 
> > > > Mutex is a pointer because we want to use same mutex from WDT and RTC.
> > > > We can sure point to parent data but then we still need our own dev
> > > > pointer. So we can have a struct with pointer to parent data and dev
> > > > pointer - but I'm not at all sure it is any clearer.
> > > 
> > > As I said, that is wrong. To say it in plaintext, I won't accept
> > > the driver if it copies the parent's driver data. The driver should
> > > have and use its own driver data, and only maintain a pointer to
> > > its parent's driver data. And most definitely you don't want to
> > > copy and use any device data structure from the parent.
> > 
> > Allright. At the moment the WDT driver only needs regmap pointer from
> > parent. I'm not sure if it will later need DT or "chip type" - but I
> > will change this.
> 
> You probably want to use this:
> 
> dev_get_regmap(pdev->dev.parent, NULL);

Thanks a bunch Sebastian. All help is highly appreciated!! =)

Unfortunately I forgot to mention the key thing - the RTC mutex. We also
need that because RTC needs to stop WDT when RTC is adjusted as the WDT
uses RTC as counter - and jumping the RTC WDT enabled might trigger WDT
or have other consequences.

Se even if we used dev_get_regmap (which is slightly heavier than
accessing direct pointer) - we would still need at least the mutex from
parent data, possibly also the chip type and if we want to avoid code
dublication - then also the WDT start/stop function.

Thus I guess we can as well keep the regmap in parent data because we
need the parent data anyways, right?

Br
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
