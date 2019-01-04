Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EADC43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0120020665
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfADICb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:02:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44846 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfADICa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:02:30 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so31742969lji.11;
        Fri, 04 Jan 2019 00:02:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NvhY3wu/fHL0DJZcMatDD+if2531/0VbYTjX0hfgGMs=;
        b=YX0TLqdMfBw+QIZ8bMRgg8NWYjLysFgU1oOHzeez2ZzXt6qwNCoGbNaMO7/2FM/Hgv
         7N1NMKlSo1tqtP4tJj+joczOPDa8zBXloZBa8E5Gv6K0PIGHY5dVWKpr2JTOl8exV90D
         641F8mGI1OgAibx3CsEYQn1Vj1Ib+gvUnxlLH3rpK/EgopWNE/ZDduZu6C6o9XvMHUi1
         JJFJ/7U1iTTeIhUwLZvgkNhk/iOmz/t0fnSfhHHktKGMOBx9v8P3Kf1862K/TBXGyUyL
         IHSgpSG6GAdKRGCFo1BR7U8BLU9knYbeZZAHrhknXqBu0fCnYPqUnAHMSIZvgwCQv5z0
         moZQ==
X-Gm-Message-State: AJcUukcOQtvSU5dT4vCczOSxFJq+O4PvKxPDUb2wPnWId9t+5oXV7oAH
        RfH6HbOLQ8IeC/qWYFQwTPs=
X-Google-Smtp-Source: ALg8bN4JEahuPi89rMYKgRdcQIjTp/1mOGdcIqXTN1fAldBy4ewXU2bVQwbFnCr4nVpI6gBr5wyqUg==
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr28443082lji.112.1546588948122;
        Fri, 04 Jan 2019 00:02:28 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id b128sm11161004lfe.91.2019.01.04.00.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 00:02:26 -0800 (PST)
Date:   Fri, 4 Jan 2019 10:02:24 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v3] regmap: regmap-irq/gpio-max77620: add level-irq
 support
Message-ID: <20190104080224.GB8865@localhost.localdomain>
References: <20181218115931.GA21253@localhost.localdomain>
 <CAMuHMdUbXeuemACL+GGx0HFjn2oKUb2UbDUKJedzCrm8JDfNaA@mail.gmail.com>
 <20181227073531.GA2461@localhost.localdomain>
 <20181227075648.GB2461@localhost.localdomain>
 <20181228080533.GC2461@localhost.localdomain>
 <20181231191127.GL1846@sirena.org.uk>
 <20190102074251.GA8865@localhost.localdomain>
 <20190103172008.GO16508@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103172008.GO16508@imbe.wolfsonmicro.main>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 05:20:08PM +0000, Charles Keepax wrote:
> On Wed, Jan 02, 2019 at 09:42:51AM +0200, Matti Vaittinen wrote:
> > On Mon, Dec 31, 2018 at 07:11:27PM +0000, Mark Brown wrote:
> > > On Fri, Dec 28, 2018 at 10:05:33AM +0200, Matti Vaittinen wrote:
> > > 
> > > > Last night - just when I was about to get some sleep - it stroke me. I
> > > > think the correct thing to do would be leaving the irq_set_type to NULL
> > > > for those IRQ chips which do not support type setting. If we do that,
> > > > then the irq core will take care of situations where user requests type
> > > > setting but the chip does not support it. Which means the regmap-irq
> > > > would be no different from any other irq chip where type setting is not
> > > > supported.
> > > 
> > > Yes, this is the best fix - let the framework handle things properly.
> > > We'll need a second set of operations and to select which to use based
> > > on having type information but that's fine.
> > > 
> > > > So at the cost of removing "const" from regmap_irq_chip we could do:
> > > 
> > > ...
> > > 
> > > > Mark, Geert, what do you think? (And maybe same for the .irq_set_wake -
> > > > but I did omit this as I have never looked at the wake functionality
> > > > before).
> > > 
> > > We need a separate struct as otherwise if there's multiple devices with
> > > regmap irq_chip implementations then they'll collide with each other
> > 
> > Right. I must admit I didn't notice this! I was about to make a nasty
> > error there...
> > 
> 
> Looking at the code I think it just copies the struct anyway,
> basically using it as a template so I think this should be fine.

Rigth. It seems to be:

d->irq_chip = regmap_irq_chip;
not:
d->irq_chip = &regmap_irq_chip;

and

struct regmap_irq_chip_data {
        struct mutex lock;
        struct irq_chip irq_chip;

        struct regmap *map;
	...
};

not
struct regmap_irq_chip_data {
        struct mutex lock;
        struct irq_chip *irq_chip;

        struct regmap *map;
	...
};
 
> > > you're probably right that we need to do the same thing for the wake
> > > configuration.  I'll still look at applying your patch as a temporary
> > > fix though.

I won't touch the wake thing (at least not yet) as I am not familiar
with it. Is it Ok to change it with another patch later?

> > 
> > Thanks Mark. I try to cook a patch with copying of struct irq_chip still
> > at this week but I wont rush it (I have some other topics under work) as
> > the regression should be fixed by the other patch.
> > 
> 
> Just to check that is this patch here:
> 
> https://lore.kernel.org/lkml/20181227084443.GA23991@localhost.localdomain/
> 
> Just want to check what will be applied so I know it will fix the
> regression I am seeing as well.

Yep. That's the patch Mark did apply.

> 
> Thanks,
> Charles

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
