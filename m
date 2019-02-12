Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2E1C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CD82077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfBLJjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:39:23 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41474 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfBLJjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:39:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id e27so1454117lfj.8;
        Tue, 12 Feb 2019 01:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IYzTZa8cMrYHVdAvDdmKbju5m8+XCJc2uxdGTPkEE9c=;
        b=V/yZ/+cxnBDMLJpg5InreWGWAV7/GyLPLpUUantZNCv+t+wxVqbGEH4rtM7xZq9Sqn
         lZOUK9Vkhrtfk5T8ba8YQFxP0FfjRj5GliRCcpf8wnRY6NiPSv43UH4/eCkuNUcnfFXc
         Upn7axSypF8nmVwRwgH+oFPyYtAkP7pCGHz/g9YQtrde2wna+tdSRaJzhLEIaeD5Nf5H
         62IqEvjFesGAMf5VvhzE34CiBcvLSiI3W0jaJ33kZ5nuE5KVsceFfce0Njg2SQ5UStOW
         eNvIXyaHZgJWUdk9261SredwQ53Gem7mc3fIbd5AFB17RtnvZAcofUnLlm3z0sWuK4PC
         iseQ==
X-Gm-Message-State: AHQUAuZ4n3b6zpUxqyTEGXSrb9BcosqrKaxdPd46nrKEJeaggsFa4FD7
        0pe409m2VWjZMPLMxYkQvFf7c5vT
X-Google-Smtp-Source: AHgI3IaB/hrmn5dbNT2bh9vbY8McYTMyFn7sJ7vPahR0Mq3C55IPyOWXQBeQYvhDVS/rgfhA4S1B2g==
X-Received: by 2002:a19:2794:: with SMTP id n142mr1790046lfn.77.1549964359414;
        Tue, 12 Feb 2019 01:39:19 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id p14sm2829049lfk.16.2019.02.12.01.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 01:39:18 -0800 (PST)
Date:   Tue, 12 Feb 2019 11:37:59 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
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
Subject: Re: [PATCH v8 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Message-ID: <20190212093759.GA12247@localhost.localdomain>
References: <cover.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <50d1debf03bbd07f49b2c5a85cf9672439cbd0ac.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <20190207140053.GG20638@dell>
 <20190207162807.GB1920@localhost.localdomain>
 <20190208105743.GI20638@dell>
 <20190208124111.GB3012@localhost.localdomain>
 <20190212091723.GZ20638@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212091723.GZ20638@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Again Lee,

On Tue, Feb 12, 2019 at 09:17:23AM +0000, Lee Jones wrote:
> On Fri, 08 Feb 2019, Matti Vaittinen wrote:
> 
> > > I think an exported function with comments would be better.
> > So do you mean you would prefer exported function over the pointer from
> Yes please.  Call-back pointers for non-subsystem level actions are a
> bit messy IMHO.

That's fine. I'll go with exported function then =)

> > case it just hides the meaning of values we are passing as arguments.
> > With raw assignment we at least have some idea what the 0x40 or 0x20 are
> > referring to =)
> 
> Well I do agree with your last comment.
> 
> Maybe doing the following would help with the ugliness (i.e. the shear
> number of chars):
> 
>  unsigned int type_reg_offset_inc = 0;
>  for (i = BD70528_INT_GPIO0; i <=  BD70528_INT_GPIO3; i++) {
>         <blar> *t = irqs[i].type;
>         t->type_reg_offset     = type_reg_offset_inc;
>  	t->type_rising_val     = 0x20;
>  	t->type_falling_val    = 0x10;
>  	t->type_level_high_val = 0x40;
>  	t->type_level_low_val  = 0x50;
>  	t->types_supported =
>  		(IRQ_TYPE_EDGE_BOTH | IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
>  	type_reg_offset_inc += 2;
>  }

I'll go with this for next version.

> > > > > > +	/* wdt_set must be called rtc_timer_lock held */
> > > > > 
> > > > > This doesn't make sense.
> > > > 
> > > > Umm.. The comment does not make sense? Maybe I can explain it further.
> > > 
> > > "wdt_set must be called when the rtc_timer_lock is held"
> > 
> > Yes. I wanted to say that who-ever is calling the wdt_set function
> > below, should have locked the rtc_timer_lock mutex (last in this
> > struct). The function does not do locking inside because we want the RTC
> > to be able to perform:
> > 
> > lock
> > disable wdt (store original state)
> > set RTC
> > return wdt original state
> > unlock
> > 
> > Locking is needed so that we can exclude the watchdog enabling or
> > disabling the WDT timer between moments when RTC is getting the original
> > WDT state and re-turning back the old state. Without the lock we have a
> > risk that WDT-driver enables or disables the timer when RTC is being
> > set, and RTC overwrites the watchdog driver changes when writing back
> > the old state. I hope this makes sense now... Any suggestions how to
> > explain this nicely in english?
> 
> I think I did already:
> 
>  "wdt_set must be called when the rtc_timer_lock is held"
> 
> Actually, this is a little ambiguous.  A better sentence could read:
> 
>  "rtc_timer_lock must be taken before calling wdt_set()"

Sure. I'll ruthlessy plagiarize that sentence. (And as I am not at all
sure if "ruthlessy plagiarize" actually means what I think it does -
I tried to say that I'll take your suggestion and use it :] )

Once again, thanks for the help =)

Br,
	Matti

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
