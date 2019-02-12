Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F225C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9092084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPtteqb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfBLLOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:14:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41477 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbfBLLOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:14:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so2193086wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 03:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4hIHLwfUAJSeqewYADEu2g7Z4YgZdnPP16ibpzE0COE=;
        b=DPtteqb9o+xC6gdPJxVi8kytlxbR64zM3dMeRZiKRB4cZ07KYwL49siXslw42i4Lkd
         bPrwywXwRRBLb/7/lJnGfSUR/4f/WDboiqlAC1woyg05lt1xB5SDVQRWQ4rYBSSM5z5m
         mt9uj2kj9mtPd2btnZlCkFbCThKXOFj3Y4XEUeoRJzxqGXrHRrsi1nzd67dv50gv/K0u
         +DSJwnjYFAFhv+xAIjHh40FvT4ZdOm9FYBUNmXu8kiHPWjFJqgIw2DxQaN6aVy6q2Hfq
         7UdyCKONkxeaZDy2B5qyr3/SJACKDKIjmdnXaIqIDLmFljSKKDgXz8vhMkrs5O/VT1hH
         AVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4hIHLwfUAJSeqewYADEu2g7Z4YgZdnPP16ibpzE0COE=;
        b=Z02W6dopW7dLZMFh205EmDAqgkA0oEUHlOKUk6LWmUQ6QbiRe3BIncD7HiAEllIqFE
         nuvsfz3SwF1iFaVa8cPopDaRdic739KqRms5GQOpLEeOJFluiwaFPDEbr+CC/HtJ4KWm
         zc8we3qwaPxJ5VLtZu0cqRh9WK41/PHkQHNpubFzganbTb4ONDgo77d9ylth1ECT/d+2
         HdmblLztSPXhn56mmZ22jb3Wrcs3w8xgl6hOy+UJ2V2xHPAzJ97pc8BAH/B6+nf04JA+
         curjNqwvGAyPtgLllLCEVmUxuo/hJHz4st6JMS/GVoPaHgBTynDw+zYVof23H/Yibnyq
         knsw==
X-Gm-Message-State: AHQUAuaMrLunVmMNEl62wMBnFF9XkMowz4cGzmjMTf/EqMbjENNzh1h4
        gch60WW8Bm1eUkzbL/lJDtE6rQ==
X-Google-Smtp-Source: AHgI3IZnJ38lsP94Ke44meE0ia8DF9cDGtCPhTaYVshghy6hsWlnEp/nd6meoy+VKkByHGgRkVEJ5A==
X-Received: by 2002:adf:ba12:: with SMTP id o18mr2664464wrg.326.1549970047469;
        Tue, 12 Feb 2019 03:14:07 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id c10sm9828984wrr.69.2019.02.12.03.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 03:14:06 -0800 (PST)
Date:   Tue, 12 Feb 2019 11:14:03 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v4 05/10] mfd: max77650: new core mfd driver
Message-ID: <20190212111403.GC20638@dell>
References: <20190205091237.6448-1-brgl@bgdev.pl>
 <20190205091237.6448-6-brgl@bgdev.pl>
 <20190212083642.GT20638@dell>
 <CAMRc=MderQf20_8aG4-otBkCv60FSNSSqV3NVALPkFL-MqmJbg@mail.gmail.com>
 <20190212095457.GA20638@dell>
 <CAMRc=MdyT7nMJ7dUTf6M3PvRdynaCurb_TftMyA4eCwzpR9fVA@mail.gmail.com>
 <20190212101835.GB20638@dell>
 <CAMRc=MfYeVbvY6O03xq4eLN9TVpAKWCAXPk0eP5LSBCU7VU9fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfYeVbvY6O03xq4eLN9TVpAKWCAXPk0eP5LSBCU7VU9fA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:

> wt., 12 lut 2019 o 11:18 Lee Jones <lee.jones@linaro.org> napisał(a):
> >
> > On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> >
> > > wt., 12 lut 2019 o 10:55 Lee Jones <lee.jones@linaro.org> napisał(a):
> > > >
> > > >  * The declaration of a superfluous struct
> > > >  * 100 lines of additional/avoidable code
> > > >  * Hacky hoop jumping trying to fudge VIRQs into resources
> > > >  * Resources were designed for HWIRQs (unless a domain is present)
> > > >  * Loads of additional/avoidable CPU cycles setting all this up
> > >
> > > While the above may be right, this one is negligible and you know it. :)
> >
> > You have nested for() loops.  You *are* wasting lots of cycles.
> >
> > > > Need I go on? :)
> > > >
> > > > Surely the fact that you are using both sides of an API
> > > > (devm_regmap_init_i2c and regmap_irq_get_*) in the same driver, must
> > > > set some alarm bells ringing?
> > > >
> > > > This whole HWIRQ setting, VIRQ getting, resource hacking is a mess.
> > > >
> > > > And for what?  To avoid passing IRQ data to a child driver?
> > >
> > > What do you propose? Should I go back to the approach in v1 and pass
> > > the regmap_irq_chip_data to child drivers?
> >
> > I'm saying you should remove all of this hackery and pass IRQs as they
> > are supposed to be passed (like everyone else does).
> 
> I'm not sure what you mean by "like everyone else does" - different
> mfd drivers seem to be doing different things. Is a simple struct
> containing virtual irq numbers passed to sub-drivers fine?

How do you plan on deriving the VIRQs to place into the struct?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
