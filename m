Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC4EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AB226A26
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49AB226A26
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964818AbeFZMDQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:03:16 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40297 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933658AbeFZMDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:03:13 -0400
Received: by mail-lf0-f66.google.com with SMTP id q11-v6so17178035lfc.7;
        Tue, 26 Jun 2018 05:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Do4B6UIAjExbte8LFXvNR06Ty0lWIK5b2ePF3XBwtKk=;
        b=b/8C6AZy8qFeGffCjKyARdTkQkS1WQKtU3krdu5E1G1c4PQz6iQ7kVKcGHCfZhdAzS
         6trOJPlhDYr/AwQfI/VsDQs9wdeguD8FNG+t4bx2KgzfCQkzYxored6xDO5sucJgT4ws
         FrueU4hPvpaC4h+fIuUyDa+AwC6qaj9hfHtAleEfgtChO3c2gw77Vd5P1vi/Awp2fIeF
         R4f5YQKVptCq4kK8X/KjS5J2J0DS70HIkFqNOwdUCaWA5olDnw+c6IY1yDtwJqSp0z3R
         7pVhrFd3ZvrfokFGi7egH0/Tr5/qWoqWBBoUybmdHIn7m47oKijbIShdIFVhRquiy/IZ
         eTEA==
X-Gm-Message-State: APt69E3YKG+Nm3ktBghl8f43P/DowOlSFa01OtvoNHZsd4q0wOPHHa43
        04GO7zltZAR1OWzI+fK2iss=
X-Google-Smtp-Source: AAOMgpe0f0h6fJeOQ0vVtwPul4QRTZ1D6ZKunyOShVIMxkdA50Nt2ofrJp6z+ye7pCTq3Q/c4FL4fw==
X-Received: by 2002:a19:2593:: with SMTP id l141-v6mr1189517lfl.10.1530014590543;
        Tue, 26 Jun 2018 05:03:10 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id c84-v6sm323814lfh.10.2018.06.26.05.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 05:03:09 -0700 (PDT)
Date:   Tue, 26 Jun 2018 15:03:06 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, mazziesaccount@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com,
        andrew.smirnov@gmail.com, Linus Walleij <linus.walleij@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v7 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180626120306.GD2118@localhost.localdomain>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <7e1888375c979accc402e9ddd7316e528b2ac52c.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com>
 <20180626112455.GC2118@localhost.localdomain>
 <CAFqH_52NERfORwSkBh0stW+mvzRpw0to9CiWPwLB9mFo_TsW_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqH_52NERfORwSkBh0stW+mvzRpw0to9CiWPwLB9mFo_TsW_w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Again Eric,

On Tue, Jun 26, 2018 at 01:40:40PM +0200, Enric Balletbo Serra wrote:
> Hi Matti,
> Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> dia dt., 26 de juny 2018 a les 13:25:
> > On Tue, Jun 26, 2018 at 11:06:33AM +0200, Enric Balletbo Serra wrote:
> > > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> > > dia dt., 19 de juny 2018 a les 12:57:
> >
> > > > +static const struct of_device_id bd71837_of_match[] = {
> > > > +       { .compatible = "rohm,bd71837", .data = (void *)0},
> > > > +       { },
> > >
> > > nit: { /* sentinel */ }
> >
> > I am sorry but I didn't quite get the point here. Could you please
> > explain what did you expect to be added here?
> >
> 
> It's a nit but It is a good practice to specify that the last entry is
> a sentinel. Just this.
> 
> +static const struct of_device_id bd71837_of_match[] = {
> +       { .compatible = "rohm,bd71837", .data = (void *)0},
> +       { /* sentinel */ }
> +};

Oh, I see. Finally something I can disagree =) I quickly opened few
random drivers which declare match table. None of them practiced this
good practice. So I guess it is not such a standard after all. And I
guess the meaning of last entry in match table should be quite obvious.
Adding the comment /* sentinel */ sounds like stating the obvious at
best - at worst it gets one just to wonder what the "sentinel" means =)

> 
> And just noticed, is .data = (void *)0 really required?
 
As static structs should be initialized to zero I'd say it is not
required. Will remove this. Thanks for pointing this out.

Br,
	Matti Vaittinen

