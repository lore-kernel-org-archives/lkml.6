Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92137C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8A924098
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8A924098
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbeGFHt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:49:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33275 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753056AbeGFHt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:49:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id t21-v6so8483129lji.0;
        Fri, 06 Jul 2018 00:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jtKRJFd1RjWrPnWhdJ3iPtOs38PXaWw655XgRBWBFXU=;
        b=QClzol4uKX8gJ2sVa/aUBvMjqfIdOv+A6cMnLqzbqJYgGxxBT9aNWKWII2DwSaT2TH
         GT7+bHYAxhUX/BbqQJbMtVjvTPoeiJgnxC6E+KpVfgwVJOgbNTzgVZ2tlYGwBX1X8M3N
         PLdFQ+JfaRBezZhT3j23U8BmYokMUiO5qXc3VvH+KldHj9Ux1+rF0BOKz3f0N+lHZbI+
         igOUiaLVTBpEBCbUl5pi6YWYyud+76PVPGGR0F9R2OQ+ofduxaZo5/Lal3OlZBgjlhZR
         6wSffCsLhj+2R0mkgsZb0nlcs4epMdgJ1JeiOHxcwP75a1QHRgat/dSnYFy3wzKiagUy
         9s/g==
X-Gm-Message-State: APt69E2xoIIGUygBDdeQWQw4TSQJrPpcGszx3GCYgrP+pQbskaavV41B
        SQvTxDO/FXhy2XgicW7OjB8=
X-Google-Smtp-Source: AAOMgpeDct27mlACEe1yZMRztvDd1pdw/eX5WLjxkTT6WY/u1KixhXDP9a9OD+y+AdJ2tQ1725BRuQ==
X-Received: by 2002:a2e:944:: with SMTP id 65-v6mr6024873ljj.30.1530863364335;
        Fri, 06 Jul 2018 00:49:24 -0700 (PDT)
Received: from localhost.localdomain (82-203-172-137.bb.dnainternet.fi. [82.203.172.137])
        by smtp.gmail.com with ESMTPSA id n7-v6sm1947392lfe.87.2018.07.06.00.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 00:49:23 -0700 (PDT)
Date:   Fri, 6 Jul 2018 10:49:15 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v7 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180706074915.GA11209@localhost.localdomain>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <7e1888375c979accc402e9ddd7316e528b2ac52c.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com>
 <20180704145623.zgei3ehrwdpcu26r@penguin>
 <CAFqH_50UshTTc0Cv0wBhUoPdm0jZVgcvRKr3qzb=M-jCcMhdtA@mail.gmail.com>
 <20180705075650.GA7683@localhost.localdomain>
 <31712EE3-4FA5-4A52-8F84-0EDC1AEEF868@gmail.com>
 <20180706070559.GW496@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706070559.GW496@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 08:05:59AM +0100, Lee Jones wrote:
> On Thu, 05 Jul 2018, Dmitry Torokhov wrote:
> 
> > On July 5, 2018 12:56:50 AM PDT, Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> wrote:
> > >On Wed, Jul 04, 2018 at 06:57:39PM +0200, Enric Balletbo Serra wrote:
> > >> Missatge de Dmitry Torokhov <dmitry.torokhov@gmail.com> del dia dc.,
> > >4
> > >> de jul. 2018 a les 17:10:
> > >> >
> > >> > Hi Enric,
> > >> >
> > >> > On Tue, Jun 26, 2018 at 11:06:33AM +0200, Enric Balletbo Serra
> > >wrote:
> > >> > > > +static struct mfd_cell bd71837_mfd_cells[] = {
> > >> > > > +       {
> > >> > > > +               .name = "bd71837-clk",
> > >> > > > +       }, {
> > >> > > > +               .name = "bd718xx-pwrkey",
> > >> > > > +               .resources = &irqs[0],
> > >> > > > +               .num_resources = ARRAY_SIZE(irqs),
> > >> > > > +       }, {
> > >> > > > +               .name = "bd71837-pmic",
> > >> > > > +       },
> > >> > > nit: no comma at the end
> > >> >
> > >> > Actually, trailing comma is preferred on structures/arrays without
> > >> > sentinels, because if one needs to add a new entry/new member, then
> > >in
> > >> > the diff there will have only one new line added, instead of one
> > >line
> > >> > being changed (adding now necessary comma) and one added.
> > >> >
> > >> 
> > >> Many thanks for sharing your knowledge! That looks to me a good
> > >> reason.
> > >
> > >So in this specific ecample leaving the comma does not help. The
> > >opening
> > >brace for new array element would be added to same line where the comma
> > >is, right?
> > 
> > Ah, yes,  you are right. We usually have either:
> > 
> >         { /* element 1 */ },
> >         { / *element 2 */ },
> >         ...
> > 
> > or:
> > 
> >         {
> >                 /* element 1 */
> >         },
> >         {
> >                 /* element 2 */
> >         },
> > 
> > but I do not think that it is codified in the CodingStyle.
> 
> FWIW, my *strong* preference for single line entries in the
> aforementioned single line format.  Then Dmitry's explanation rings
> true.

The reasoning given by Dmitry makes perfect sense. And to my eyes:
	{
		/* element 1 */
	},
	{
		/* element 2 */
 	},

actually looks better than:
> 	{
		/* element 1 */
	}, {
		/* element 2 */
 	},

So if first one is not enforced in order to minimize almost empty lines
- then I will try to be using the latter in the future. (In such cases
  where element consists of more than one value).

Thanks for this little lesson =)

Br,
	Matti Vaittinen

