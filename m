Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FFAC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21832240F4
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21832240F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753250AbeGEH5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:57:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38006 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753041AbeGEH5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 03:57:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so5956868ljc.5;
        Thu, 05 Jul 2018 00:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TtMwFTQwLRRI02NBZgzlLAPSeuksc2RRAAdxxEmDof8=;
        b=W/N0CXuuW8WZqm7NfbQCY2iHIiczLqYbauswb9VwUHwZ6YOqb7bebsHDIDt96HwmhK
         lJDXtUeWvUHRbqDM+YqAMJUJp1i134dXvYt8tN/Wki6shWwWcBqvAqHdy/O+m7KPjK67
         QBZEMhZonKfGksH1GoIauOyqyFHnwLb6XezpzeLyzWh7VHBR/xYteFXtyTrVEBG6Vtgu
         dsaVDP5/nozEJXvgYpt6KPuv6JsBcPIgfW0sd7QuXNb0rN8VchIXN+TB2VOl7080+MEM
         Ob6TrE8c6i4pcN2FSoE/B/VWdN4sDNvVbj2Y8uHK/bbUBmunaGFzko3qEozmRe6kk0jF
         z58g==
X-Gm-Message-State: APt69E3WWbSb9Itvn9UCFKfPfzUT+4CiZikBhq6GA0aK/Gtd4Y9OyUqq
        kKfKiLzS9rkVERRf56aJ1bI=
X-Google-Smtp-Source: AAOMgpeGQOYU9mjTLDnLgrhflrc5pH7AytaoetasO0qa0E5w9LVaQrTqQAgTZ4ZaHn01zKuwhklUWg==
X-Received: by 2002:a2e:40c6:: with SMTP id r67-v6mr3417233lje.41.1530777424005;
        Thu, 05 Jul 2018 00:57:04 -0700 (PDT)
Received: from localhost.localdomain (82-203-185-123.bb.dnainternet.fi. [82.203.185.123])
        by smtp.gmail.com with ESMTPSA id k202-v6sm1283898lfg.15.2018.07.05.00.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 00:57:03 -0700 (PDT)
Date:   Thu, 5 Jul 2018 10:56:50 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
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
Message-ID: <20180705075650.GA7683@localhost.localdomain>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <7e1888375c979accc402e9ddd7316e528b2ac52c.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com>
 <20180704145623.zgei3ehrwdpcu26r@penguin>
 <CAFqH_50UshTTc0Cv0wBhUoPdm0jZVgcvRKr3qzb=M-jCcMhdtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqH_50UshTTc0Cv0wBhUoPdm0jZVgcvRKr3qzb=M-jCcMhdtA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 06:57:39PM +0200, Enric Balletbo Serra wrote:
> Missatge de Dmitry Torokhov <dmitry.torokhov@gmail.com> del dia dc., 4
> de jul. 2018 a les 17:10:
> >
> > Hi Enric,
> >
> > On Tue, Jun 26, 2018 at 11:06:33AM +0200, Enric Balletbo Serra wrote:
> > > Hi Matti,
> > >
> > > Thanks for the patch, a few comments below, some are feedback I
> > > received when I sent some patches to this subsystem.
> > >
> > > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> > > dia dt., 19 de juny 2018 a les 12:57:
> > > > +};
> > > > +
> > > > +/* bd71837 multi function cells */
> > > > +static struct mfd_cell bd71837_mfd_cells[] = {
> > > > +       {
> > > > +               .name = "bd71837-clk",
> > > > +       }, {
> > > > +               .name = "bd718xx-pwrkey",
> > > > +               .resources = &irqs[0],
> > > > +               .num_resources = ARRAY_SIZE(irqs),
> > > > +       }, {
> > > > +               .name = "bd71837-pmic",
> > > > +       },
> > > nit: no comma at the end
> >
> > Actually, trailing comma is preferred on structures/arrays without
> > sentinels, because if one needs to add a new entry/new member, then in
> > the diff there will have only one new line added, instead of one line
> > being changed (adding now necessary comma) and one added.
> >
> 
> Many thanks for sharing your knowledge! That looks to me a good
> reason.

So in this specific ecample leaving the comma does not help. The opening
brace for new array element would be added to same line where the comma
is, right? In any case - this was educating and makes perfect sense for
arrays with simple items. Thanks.

> Matti, I don't want to beat about the bush with these nitpicks. It is
> not my intention. So I'd say, do what the maintainer wants :)
> 
No problem.

Br,
	Matti Vaittinen
