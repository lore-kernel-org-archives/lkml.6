Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6E3C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A705220882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbfA2L7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:59:42 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39351 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbfA2LrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:47:02 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so17174623ljh.6;
        Tue, 29 Jan 2019 03:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n0duLS7q5gZJLFQKEZXIgwsdlF4usLdESdPOckaF1MQ=;
        b=BfWrTRkSd/43XiVMb3RIMSJh4uRHCGrOEUfNBrHytTAJ9C0yD+meSmLbizQEPmd4kE
         xUZ/369yw6a+SchmBqIdYbCNvYDsjgMTs9v0D4DLFTIkR+QzJnkQsGa8v/IHq3m2mz1Y
         xbav+uazUg1Jz2WpqkXpETNtQvraRT51EQtjHW6dB4tDa1+SO9qWreU18XPmUdKGq2jp
         pRrxS4J7dcLE/b0yRFh8KzDIIfX2HNRLzhHtXUxbcM3dB7Fd9NHGU/yyRxLrZ1dBy80k
         Davm3hbqJZwRp0UeL87VBSW+EnWKuuT4wbQ+VFhX5TX8MOjkfxXshPPsAMKjygPXJH6h
         QC+g==
X-Gm-Message-State: AJcUukdxYPUTFR+BVrMf2EBaMkCUKW7BPM6NmFHWkbxw3En9oh4/rRRp
        4WIyfJc3lp42TSMfGhrQpTmC2ucxq1w=
X-Google-Smtp-Source: ALg8bN7rVtHX8eOQUY5mFtqygmIJdY4RXMsk/R/OMsNzMkTnFM+bVQlmmIwpqcNb1LgCCGIBGOiHRg==
X-Received: by 2002:a2e:81d3:: with SMTP id s19-v6mr18804774ljg.138.1548762418792;
        Tue, 29 Jan 2019 03:46:58 -0800 (PST)
Received: from localhost.localdomain (dytkl7s9vpj00trvf9g2y-4.rev.dnainternet.fi. [2001:14bb:410:9dbf:b161:fde8:3a24:e96c])
        by smtp.gmail.com with ESMTPSA id q20sm3386630lfj.20.2019.01.29.03.46.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 03:46:57 -0800 (PST)
Date:   Tue, 29 Jan 2019 13:46:53 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        wim@linux-watchdog.org, linux@roeck-us.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [RFC PATCH v2 08/10] rtc: bd70528: Initial support for ROHM
 bd70528 RTC
Message-ID: <20190129114653.GB2551@localhost.localdomain>
References: <20190125110536.GA29321@localhost.localdomain>
 <20190128212009.GE18309@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128212009.GE18309@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexandre,

Big thanks for the review!

On Mon, Jan 28, 2019 at 10:20:09PM +0100, Alexandre Belloni wrote:
> Hello,
> 
> On 25/01/2019 13:05:36+0200, Matti Vaittinen wrote:
> > +static const struct rtc_class_ops bd70528_rtc_ops = {
> > +	.read_time	= bd70528_get_time,
> > +	.set_time	= bd70528_set_time,
> > +	.read_alarm	= bd70528_read_alarm,
> > +	.set_alarm	= bd70528_set_alarm,
> 
> You actually need to provide a .alarm_irq_enable callback, else there is
> no way to disable a set alarm.

Glad that you pointed this out. I thought the RTC core would use
set_alarm with enabled in struct rtc_wkalrm being zero for disabling
the alarm. I'll add alarm_irq_enable for disabling alarm at v3.

> > +	rtc = devm_rtc_device_register(&pdev->dev, "bd70528-rtc",
> > +				       &bd70528_rtc_ops, THIS_MODULE);
> > +	if (IS_ERR(rtc)) {
> > +		dev_err(&pdev->dev, "Registering RTC failed\n");
> > +		return PTR_ERR(rtc);
> > +	}
> 
> Please use devm_rtc_allocate_device() and set rtc->range_min and
> rtc->range_max before registering with rtc_register_device() (which can
> be done after trying to request the irq).

Right. I should've noted that devm_rtc_device_register was marked
deprecated. I'll fix this too at v3.

Br,
	Matti Vaittinen
