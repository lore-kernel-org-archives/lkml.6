Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B4BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B676721B18
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="c9bkZv8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfBLKYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:24:45 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51105 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfBLKYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:24:44 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so5981366iti.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OOI8B7HyQw2dzyQxkjkOOnTIw0ylaTwZx4zlYCeOPes=;
        b=c9bkZv8grRSuhVKWvGwv5r6pXezREVJ2ZxARiOIc08fqzurxY/XH07tKMx5X3QQUUx
         ohKo2a4NxsD7cLCHis7Wdy1k8rHbK5iWna7naJJ/Mim021CPTRfqeNMd7rirSxx684TZ
         k4R4PBY1FtqoyUf1q4KplScpIsOeMSIVjPW4WjsfHs021t4neNv0PexA+Q3/p10emRIj
         eqP6nHOZwKqjP37zQgmGKoqG5MIVWMJjXLFMfS+GNQ9+kkKtWCnoTxMOe2dqX8k/igIb
         VywiXfSD3DykR/Tm6yVYmOx2qQct2Jm0Ozt9Uzt8BnMfrj+PM9nOfEaipGX04Q6MwkNJ
         azBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OOI8B7HyQw2dzyQxkjkOOnTIw0ylaTwZx4zlYCeOPes=;
        b=nLXFxTGQfl8pVKH3sVjtJ64Llp/3mi7cF+ki9gfq7v3WEHyg1BWFLvBRWHkpsDQdS4
         KAIehWX9mnJE4qlXoH67xblhKvtsYObT44aE3K0M+6Qo7GL1ZGMP9uUOA4X4o+Eb9h3l
         hyCxd5aF790bUpMcy2jPBIzX7bDqhX31S6NM7j8mC77jY/IMMPa54a3A74owAxVWUdMb
         OT5duJTkm1jETKc6aOxTpKrXbYP/WdHQ6BUWXD8GPIJpj01dwqKv5O03CpPLcUmc1ace
         J26Jq/fnHMi4yOApf1+ONITPF8mmUbyWQ9DEb3r2RD5zTyNkHw3/6bpACyw+n5D5k78+
         qpdw==
X-Gm-Message-State: AHQUAuaGNFli097DrGy9uwZkKOcI2uLjVr+UdxEJuJToulIVShI5bip2
        a8/t1wZoX4ESNd1hvnRERJZFQJLDb71DUpJbyhx9Sg==
X-Google-Smtp-Source: AHgI3Ib0gp/Hk/7Po/24cQgyfhhOK9klQQgCAaxbcAgQvQo+PKwGqWYJCSbHbn0Kj5Q390o4WRCNA1RKmcOretLdHdk=
X-Received: by 2002:a5d:91d3:: with SMTP id k19mr1575071ior.258.1549967083638;
 Tue, 12 Feb 2019 02:24:43 -0800 (PST)
MIME-Version: 1.0
References: <20190205091237.6448-1-brgl@bgdev.pl> <20190205091237.6448-6-brgl@bgdev.pl>
 <20190212083642.GT20638@dell> <CAMRc=MderQf20_8aG4-otBkCv60FSNSSqV3NVALPkFL-MqmJbg@mail.gmail.com>
 <20190212095457.GA20638@dell> <CAMRc=MdyT7nMJ7dUTf6M3PvRdynaCurb_TftMyA4eCwzpR9fVA@mail.gmail.com>
 <20190212101835.GB20638@dell>
In-Reply-To: <20190212101835.GB20638@dell>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Feb 2019 11:24:32 +0100
Message-ID: <CAMRc=MfYeVbvY6O03xq4eLN9TVpAKWCAXPk0eP5LSBCU7VU9fA@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] mfd: max77650: new core mfd driver
To:     Lee Jones <lee.jones@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 12 lut 2019 o 11:18 Lee Jones <lee.jones@linaro.org> napisa=C5=82(a):
>
> On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
>
> > wt., 12 lut 2019 o 10:55 Lee Jones <lee.jones@linaro.org> napisa=C5=82(=
a):
> > >
> > >  * The declaration of a superfluous struct
> > >  * 100 lines of additional/avoidable code
> > >  * Hacky hoop jumping trying to fudge VIRQs into resources
> > >  * Resources were designed for HWIRQs (unless a domain is present)
> > >  * Loads of additional/avoidable CPU cycles setting all this up
> >
> > While the above may be right, this one is negligible and you know it. :=
)
>
> You have nested for() loops.  You *are* wasting lots of cycles.
>
> > > Need I go on? :)
> > >
> > > Surely the fact that you are using both sides of an API
> > > (devm_regmap_init_i2c and regmap_irq_get_*) in the same driver, must
> > > set some alarm bells ringing?
> > >
> > > This whole HWIRQ setting, VIRQ getting, resource hacking is a mess.
> > >
> > > And for what?  To avoid passing IRQ data to a child driver?
> >
> > What do you propose? Should I go back to the approach in v1 and pass
> > the regmap_irq_chip_data to child drivers?
>
> I'm saying you should remove all of this hackery and pass IRQs as they
> are supposed to be passed (like everyone else does).
>

I'm not sure what you mean by "like everyone else does" - different
mfd drivers seem to be doing different things. Is a simple struct
containing virtual irq numbers passed to sub-drivers fine?

Bart
