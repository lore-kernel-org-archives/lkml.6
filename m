Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F5AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965D12087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfAaGk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 01:40:59 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41464 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfAaGk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 01:40:57 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so1443202lfj.8;
        Wed, 30 Jan 2019 22:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lGDb4pkEcCZN6uey1BsMGWCSOOTu/LeMIlzvAljy6eQ=;
        b=DIjHBr45v8j2wknhWEzmkj6nWHOqHOlVUOUW9cusp3n2gKXp915gVncdMFMP6n8XhH
         4jV5JJ+kM4mbOwYPt8ci9BisRUBdGIs+kxCNGwHjw+j8B85mz8hW4vzikTt/+KHC+ErG
         4X3OPeuP1gUw566FMtAoACnN665LgyrvMxz0WWad8U4KQ9ILI/Tl2GImTF932tL3Yeu6
         LHSdLexLrfsDyDFT3TyjXLo2n+Sh1IO91PcWom/loMjPMpW3Dod6uer1AyWCgt7DFBVr
         zy5owTQcjipHygJPXyTRIdaUIBs4QM0OZ149jPTtqy1zI6WuJx+/XUnBhGDZ8w1f6OxL
         6xGg==
X-Gm-Message-State: AJcUukccfErRAOxPj0X9xmeC2e9LsxwkGEq6AFQR/m1PFZXHs1zLQKPj
        +n6WMN9bPM8LbgxwBCWy/OU=
X-Google-Smtp-Source: ALg8bN4eQsL6JP4CC5Iwu+nX2gwKq4Dli/jc1TM7dOP4sfWmQ8gUn2hZbWjjF+kchUNZu4HZHADKlw==
X-Received: by 2002:a19:26ce:: with SMTP id m197mr25913108lfm.23.1548916854578;
        Wed, 30 Jan 2019 22:40:54 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t18sm647469lft.93.2019.01.30.22.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 22:40:53 -0800 (PST)
Date:   Thu, 31 Jan 2019 08:40:51 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Rob Herring <robh@kernel.org>
Cc:     mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org,
        mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [RFC PATCH v3 06/10] devicetree: bindings: Document first ROHM
 BD70528 bindings
Message-ID: <20190131064050.GC23791@localhost.localdomain>
References: <cover.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
 <eb5d03f3adc72db580a10f95ff6cb07aefce5b47.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
 <20190130185344.GA14789@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130185344.GA14789@bogus>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

Thanks for taking the carefull look once again =)

On Wed, Jan 30, 2019 at 12:53:44PM -0600, Rob Herring wrote:
> On Wed, Jan 30, 2019 at 11:09:55AM +0200, Matti Vaittinen wrote:
> > Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
> > drivers) and 4 GPIO pins which can be configured for I/O or
> > as interrupt sources withe configurable trigger levels.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 104 +++++++++++++++++++++

snip

> > + - interrupt-parent	: Phandle to the parent interrupt controller.
> 
> Don't document this. It is implied and could be in a parent node.

Allright. I'll remove this then.

> > + - clock-frequency	: Should be 32768
> 
> Forget to drop this?

Well spotted. The rate should come from parent clock. I'll drop this
too.

> > +Example:
> > +/* external oscillator */
> > +osc: oscillator {
> > +	compatible = "fixed-clock";
> > +	#clock-cells = <1>;
> > +	clock-frequency  = <32768>;
> > +	clock-output-names = "osc";
> > +};
> > +
> > +pmic: bd70528@4b {
> 
> pmic@4b
> 
> Node names should be generic.

Ok. I will change this.

Br,
	Matti

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
