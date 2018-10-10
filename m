Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5629CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9122086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAX+S8AB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9122086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeJKAea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:34:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34367 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJKAea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:34:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so2962831pfi.1;
        Wed, 10 Oct 2018 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mnPyEC9AAQ26uW9Sw3mdIbdLPkLmkycfQC4VA11XVbU=;
        b=KAX+S8ABiXpG9d1nMi/W40g2Q6CE2jyaYZ53cZLaKXGk4Bp9H6JlULt0WKasDxPMCn
         ZE1weJ7X9Br71XlFQ74dcnxABwJ7Yi2jUHKlxwHalDRJ3YYMgqluWq43hLVQPWW0UXPz
         frBpjQTdQCb8mMnQ6Z00q1ThJE3HH3Ou+Fc3PefERrPE8MzDThuToSQCL0xVuhM7hcXr
         e7PjPRWu4MmDTkrVpJJUqXf8sUpBbGfLtuCVlEODe9ztKxrgPQxPSaTjLwxki50Rou1Y
         RH9feEFCSkkogrfqeFOEy65Z7Q63ZogyVaZqZXbz1NFP1LeQz0dU7xYtaTMg/irnYTlR
         QvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mnPyEC9AAQ26uW9Sw3mdIbdLPkLmkycfQC4VA11XVbU=;
        b=Vx2PQbhA1zuW1iMJfxHCFao7szNlQjHIw5N1/g0Vmw5l29rTbYLBdJ/WN9Uc/yQfeO
         aKzB11mYA1wS/WKyAYdkTVd9bqR4cNJNFxxSjVqsCgffDszrzoIUBZQBcC1Sp9IUhBQJ
         sUgufDog+mz44C7GVibutoUvmDn94PrarUKuQyNg1sAU6UDH7FU+AjFAV6r1/gsDZOAr
         7GtmPOVmh3eudSkwyhGmivRr+cZa7G9NthwWNauQUwzkPX/VZ1ITnmyC9aOtyQRcrfB1
         ULz7DjSFCGPcecaXAbLJt1Ukpagd7jHpUAxU6ylgexYX5mA0qersHdawXrbqWGhochfl
         BXKg==
X-Gm-Message-State: ABuFfoiHqmi0qCRNyJ14r63OaOekk7IFR5aTl7c9eh9DkB5ur5DUbvvP
        Lwn9a9sXmTmgon8fA/d1jok=
X-Google-Smtp-Source: ACcGV63JDU7ct9mIC5NgRDpG2rZE5+ds4jQRij0VxOBh0gWWZ44Idu9TAQqv4kmqklFHkIsWpB7/Qw==
X-Received: by 2002:a62:302:: with SMTP id 2-v6mr34829564pfd.145.1539191485191;
        Wed, 10 Oct 2018 10:11:25 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id z11-v6sm55775165pfd.99.2018.10.10.10.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 10:11:23 -0700 (PDT)
Date:   Wed, 10 Oct 2018 10:11:21 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 8/8] Input: olpc_apsp: allocate the GPIOs used
Message-ID: <20181010171121.GE47260@dtor-ws>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181010142504.233467-9-lkundrak@v3.sk>
 <20181010171013.GD47260@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010171013.GD47260@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 10:10:13AM -0700, Dmitry Torokhov wrote:
> On Wed, Oct 10, 2018 at 04:25:04PM +0200, Lubomir Rintel wrote:
> > Take the GPIO lines are used by the SP. The driver doesn't touch the
> > lines -- this is done to disallow anything else from fiddling with
> > them because that would confuse the SP firmware.
> > 
> > Also, the lines are now nicely visible in /sys/kernel/debug/gpio.
> 
> Linus, is this something that should be handled by GPIO "hogs"?

Argh, meant to add Linus Walleij here.

> 
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  drivers/input/serio/olpc_apsp.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_apsp.c
> > index fe9e19014e70..287759c5f36d 100644
> > --- a/drivers/input/serio/olpc_apsp.c
> > +++ b/drivers/input/serio/olpc_apsp.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/delay.h>
> >  #include <linux/clk.h>
> > +#include <linux/gpio/consumer.h>
> >  
> >  /*
> >   * The OLPC XO-1.75 and XO-4 laptops do not have a hardware PS/2 controller.
> > @@ -76,6 +77,8 @@ struct olpc_apsp {
> >  	struct serio *padio;
> >  	void __iomem *base;
> >  	struct clk *clk;
> > +	struct gpio_desc *clk_gpio;
> > +	struct gpio_desc *data_gpio;
> >  	int open_count;
> >  	int irq;
> >  };
> > @@ -211,6 +214,16 @@ static int olpc_apsp_probe(struct platform_device *pdev)
> >  	if (IS_ERR(priv->clk))
> >  		return PTR_ERR(priv->clk);
> >  
> > +	priv->clk_gpio = devm_gpiod_get_optional(&pdev->dev, "clk",
> > +							GPIOD_ASIS);
> > +	if (IS_ERR(priv->clk_gpio))
> > +		return PTR_ERR(priv->clk_gpio);
> > +
> > +	priv->data_gpio = devm_gpiod_get_optional(&pdev->dev, "data",
> > +							GPIOD_ASIS);
> > +	if (IS_ERR(priv->data_gpio))
> > +		return PTR_ERR(priv->data_gpio);
> > +
> >  	/* KEYBOARD */
> >  	kb_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
> >  	if (!kb_serio)
> > -- 
> > 2.19.0
> > 
> 
> -- 
> Dmitry

-- 
Dmitry
