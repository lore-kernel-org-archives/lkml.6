Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CD1C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 07:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5BE206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 07:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfABHnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 02:43:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46541 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfABHnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 02:43:02 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so26305289ljh.13;
        Tue, 01 Jan 2019 23:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZiUjL8hMbXhRpfCriQOI2mRYBvtGHvdgTeT8LQkhk18=;
        b=QCOA9uVmsXMQokVK9HybjlQMjFdSLAcCi7Tx0nc1thtLoqUFDds6zy/h9FpWX1Fa/a
         Xxn4vMax3WuMdd2EbyVSMx8DV4IXLObrHyRZmP4hHp/ry9OA74XQfo+Z28x8Krjj4GnN
         gutoYoJqwb9z7tGPPeif1r6diLp4NrA+0bwQgYkLGoq7gkBK/DNTjHenw+hJzmpPqJdn
         3zFnZLcehd5AkDbpaPsFGCF2wbjV+YLV0lvuv91QmyMHnKs3bHz1kdLEoLTAtiREqlOr
         ml3LTRyLTFHqFk+15MuJMwmG4uBambgioQUqQCJwFwM/SmPj/Xh57FlA0RFXAWlzNgps
         xmRQ==
X-Gm-Message-State: AJcUukeFEN054VCJhK8bKWSZ1+X6bXbluRMK41mDoPbx0x2ptrgVhnbA
        9S0CjQu4NbxL7wfmdaTwxfg=
X-Google-Smtp-Source: ALg8bN4kiLdt9sSYYw/XjCAYpT31s7b8/Lci4Abo3hA+3vLmdsVL+e0heVfuEjhLR+VeS5hv71suaw==
X-Received: by 2002:a2e:8643:: with SMTP id i3-v6mr20398868ljj.43.1546414979573;
        Tue, 01 Jan 2019 23:42:59 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id c2-v6sm11077428ljj.41.2019.01.01.23.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Jan 2019 23:42:59 -0800 (PST)
Date:   Wed, 2 Jan 2019 09:42:51 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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
Message-ID: <20190102074251.GA8865@localhost.localdomain>
References: <20181218115931.GA21253@localhost.localdomain>
 <CAMuHMdUbXeuemACL+GGx0HFjn2oKUb2UbDUKJedzCrm8JDfNaA@mail.gmail.com>
 <20181227073531.GA2461@localhost.localdomain>
 <20181227075648.GB2461@localhost.localdomain>
 <20181228080533.GC2461@localhost.localdomain>
 <20181231191127.GL1846@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181231191127.GL1846@sirena.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 07:11:27PM +0000, Mark Brown wrote:
> On Fri, Dec 28, 2018 at 10:05:33AM +0200, Matti Vaittinen wrote:
> 
> > Last night - just when I was about to get some sleep - it stroke me. I
> > think the correct thing to do would be leaving the irq_set_type to NULL
> > for those IRQ chips which do not support type setting. If we do that,
> > then the irq core will take care of situations where user requests type
> > setting but the chip does not support it. Which means the regmap-irq
> > would be no different from any other irq chip where type setting is not
> > supported.
> 
> Yes, this is the best fix - let the framework handle things properly.
> We'll need a second set of operations and to select which to use based
> on having type information but that's fine.
> 
> > So at the cost of removing "const" from regmap_irq_chip we could do:
> 
> ...
> 
> > Mark, Geert, what do you think? (And maybe same for the .irq_set_wake -
> > but I did omit this as I have never looked at the wake functionality
> > before).
> 
> We need a separate struct as otherwise if there's multiple devices with
> regmap irq_chip implementations then they'll collide with each other

Right. I must admit I didn't notice this! I was about to make a nasty
error there...

> otherwise I like this approach (or we could copy the irq_chip struct
> when registering and then modify which is going to scale a bit better -

I am really not a fan of dynamic allocation - I'd rather had static
structs with different set of operations. But I admit I can't think of a
sane system where we would have more than few regmap_irq controllers so
memory consumption of allocating new structs is hardly an issue here. 

> you're probably right that we need to do the same thing for the wake
> configuration.  I'll still look at applying your patch as a temporary
> fix though.

Thanks Mark. I try to cook a patch with copying of struct irq_chip still
at this week but I wont rush it (I have some other topics under work) as
the regression should be fixed by the other patch.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
