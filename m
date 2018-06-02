Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeFBGat (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 02:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbeFBGao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 02:30:44 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Matti Vaittinen <mazziesaccount@gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180601105105.GD5150@localhost.localdomain>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
References: <cover.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <3b05ca98a671a762013c312f8b70543402ee7556.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <20180531030129.GA16122@rob-hp-laptop>
 <20180531071717.GG13528@localhost.localdomain>
 <20180531102315.GA5150@localhost.localdomain>
 <CAL_Jsq+33G7zMEDOUXHQijxqqbvqykxZENLe1-52ECkXwo2o4g@mail.gmail.com>
 <152777867392.144038.18188452389972834689@swboyd.mtv.corp.google.com>
 <20180601105105.GD5150@localhost.localdomain>
Message-ID: <152792104337.225090.2257556980786807638@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 2/6] mfd: bd71837: Devicetree bindings for ROHM BD71837 PMIC
Date: Fri, 01 Jun 2018 23:30:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w526Ur3h004055

Quoting Matti Vaittinen (2018-06-01 03:51:05)
> On Thu, May 31, 2018 at 07:57:53AM -0700, Stephen Boyd wrote:
> > Quoting Rob Herring (2018-05-31 07:07:24)
> > > 
> > > I don't think it should. The h/w either has an interrupt controller or
> > > it doesn't. My concern is you added it but nothing uses it which tells
> > > me your binding is incomplete. I'd rather see complete bindings even
> > > if you don't have drivers. For example, as-is, there's not really any
> > > need for the clocks child node. You can just make the parent a clock
> > > provider. But we need a complete picture of the h/w to make that
> > > determination.
> > > 
> > 
> > I don't see a reason to have the clk subnode either.
> 
> After some pondering - do you mean I could:
> 1. remove clk binfing document and clk node.
> 2. add clock-output-names etc to pmic node (and describe them in pmic
> node binding document)
> 3. use parent DT node in clk driver and do something like:
>         if (parent->of_node)
>                 ret = of_clk_add_hw_provider(parent->of_node, of_clk_hw_simple_get,
>                                              hw);
> 4. remove the clkdev
> 

This sounds ok to me. As Rob said, a more complete picture of the
hardware would make this easier.
