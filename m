Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742A2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4722C214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeLRJAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:00:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34781 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:00:09 -0500
Received: by mail-lj1-f194.google.com with SMTP id u89-v6so2803803lje.1;
        Tue, 18 Dec 2018 01:00:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O+4Z1PwHtMGisKvMErpnlYDdGeoTlr2lS8aNw4AuYF0=;
        b=frCHEj0C3Jj8cPvQjJewq/NeWZMYcSRk2JJM3WNlV2jw4yAzXorStPPfvDG2FQOCY+
         ZLkwG6mmoECpZRBD4iE+YHcLNNyMXOqBrjiDOhacLj7ZiQfKB1vPd/7dFmX8NdRS5UGi
         CxULshLwl4TURC1E+sN+P+ypDbMtYErvZNbfGdENTtIKUen9S4jq0mjsdH8INjpcIYrw
         jgRBzYX3Y81Nt4sSv4XUaFfC1BrBB32PDrcyWfEua5L1YFhU8PEEYHU/Ekn2RPmxKA1V
         l3QFM9M2eO7c6zlZ205zerkZ0WN1kxPZla6cr0k2wh6US3B1KeJ2PQEXW6yBkzGByZ7q
         lUHA==
X-Gm-Message-State: AA+aEWYw8fmWf+NFNQYNUEJHuGsUFL/vTF9YcXe2zXIoDn0h+OMqC0Dp
        Q8FI7jaRjTYMEAllycmN4Rw=
X-Google-Smtp-Source: AFSGD/VHIkZouIRYmiVJ0Dnd6h/5HGUvlISADfUcdQptYtg+b2wPYZ0j4tzOxkDh5ygzQ3mOMB2wQw==
X-Received: by 2002:a2e:b04f:: with SMTP id d15-v6mr10625554ljl.3.1545123606812;
        Tue, 18 Dec 2018 01:00:06 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id o17sm3046650lff.77.2018.12.18.01.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 01:00:05 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:00:03 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     mazziesaccount@gmail.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        vladimir_zapolskiy@mentor.com
Subject: Re: [RFC PATCH v2] regmap: regmap-irq/gpio-max77620: add level-irq
 support
Message-ID: <20181218090003.GE2477@localhost.localdomain>
References: <20181211140555.GA5872@localhost.localdomain>
 <20181213182026.GX10669@sirena.org.uk>
 <20181217084248.GC2477@localhost.localdomain>
 <20181217180722.GG27909@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217180722.GG27909@sirena.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 06:07:22PM +0000, Mark Brown wrote:
> On Mon, Dec 17, 2018 at 10:42:48AM +0200, Matti Vaittinen wrote:
> > On Thu, Dec 13, 2018 at 06:20:26PM +0000, Mark Brown wrote:
> 
> > > I can't remember and can't find any record of any discussion of it which
> > > is odd, might've been on IRC or something.  Let's just remove it and see
> > > what breaks, since we generally provide the type along with the request
> > > for the interrupt I'm not sure how often the default actually gets used.  
> > > Possibly safer as a second patch though in case there is a good reason
> > > that I missed so we can easily revert it.
> 
> > So how do you see this - should the regmap_add_irq_chip read the current
> > type setting information from HW and populate the cached type values
> > based on the current HW configuration? (I think that would be corect
> > thing to do).
> 
> Yes.

I'll go with this then. I'll try sending the patch removing the default
edge configuration still today.

> 
> > >  It
> > > does look safe to me but it's possible I missed something.  Equally it
> > > only seems to be some quite old Tegra systems using the max77620 so
> > > perhaps mainline usage of affected devices is limited anyway...
> 
> > Right. This makes me wonder if there is some other preferred approach on
> > this... How other drivers are doing the type configurations? Why they
> > are not using regmap-irq? Am I missing something? But what comes to
> > changing the regmap-irq type-setting this is definitely a good news =)
> 
> I suspect a lot of devices lack configurability or have never actually
> done anything where configurability would matter - probably the biggest
> use of regmap-irq is interrupts internal to a chip where there's no real
> need for that, and even where there are GPIOs I'd be surprised if many
> of them were actually used as interrupts rather than dumb outputs or
> something given that most embedded systems have an abundance of GPIOs
> directly on the SoC which are much better.

Thanks for the explanation =) This makes sense.


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
