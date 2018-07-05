Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7F3C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC78024056
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC78024056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754015AbeGEM3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 08:29:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39401 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753824AbeGEM3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 08:29:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id t7-v6so6520625ljj.6;
        Thu, 05 Jul 2018 05:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=k4hDbnpU0pC94lS9IlPQDnqeskGV4RK1Jby0SXURIGA=;
        b=e+e0qkbfpq8TnlsLZCU0gBZqjkYUglIwmhqePOP1O0d5ZChWoIp9aWXRxmuX/HuFaD
         dv57neBMntYHbGRsnGMLT/dFrz2ZZi/CcsqqL9diBiUPvSRIUra8iFmW/UFA5twvpFrG
         PV46pRr2n1h0j3o2RPXekqsjcqy2NxESfrjjWDFLq1/Jj9WprWgiGnlKmoFt26Tv+kjL
         9f+bT95PI7xfka+9E1BFIAJj0GtKbD9LZNzri0sHive3Qi/nH5jIOVgvDJzG0p8DsGy+
         +SqfpwJCMD+sbJbF8+syDg2oYdpJ8ocqWs7II5wzWmqm6jxt7Wfbk/O6T9i8Ef1prW1i
         Mp6w==
X-Gm-Message-State: APt69E03xMn/8MtCVRj3bHbkXSCUrZ1RpfuJ9rhNjG3wCEpT62SoAKYr
        rJZ1s1zltuqDoOaI+3jLj80=
X-Google-Smtp-Source: AAOMgpepee0Wb8N2V/viJAHc4CtJ53LdPv/7wAvE4Vz3t37dOXAe3NrnpE5URl9MxW186ItFVXM8tQ==
X-Received: by 2002:a2e:534e:: with SMTP id t14-v6mr3863620ljd.73.1530793767856;
        Thu, 05 Jul 2018 05:29:27 -0700 (PDT)
Received: from localhost.localdomain (82-203-190-162.bb.dnainternet.fi. [82.203.190.162])
        by smtp.gmail.com with ESMTPSA id h24-v6sm489627ljg.55.2018.07.05.05.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 05:29:27 -0700 (PDT)
Date:   Thu, 5 Jul 2018 15:29:23 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        arnd@arndb.de, dmitry.torokhov@gmail.com, sre@kernel.org,
        chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org, eballetbo@gmail.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v9 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180705122923.GD8426@localhost.localdomain>
References: <cover.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <a304164cc3c1b31c7c6b62f8e233ce321a82cdd6.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <20180705091813.GK496@dell>
 <20180705103442.GA8426@localhost.localdomain>
 <20180705111705.GN496@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180705111705.GN496@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 12:17:05PM +0100, Lee Jones wrote:
> On Thu, 05 Jul 2018, Matti Vaittinen wrote:
> 
> > Thanks for taking the time to check this =)
> > 
> > On Thu, Jul 05, 2018 at 10:18:13AM +0100, Lee Jones wrote:
> > > On Thu, 05 Jul 2018, Matti Vaittinen wrote:
> > > 
> > > > --- a/drivers/mfd/Kconfig
> > > > +++ b/drivers/mfd/Kconfig
> > > > @@ -1787,6 +1787,19 @@ config MFD_STW481X
> > > >  	  in various ST Microelectronics and ST-Ericsson embedded
> > > >  	  Nomadik series.
> > > >  
> > > > +config MFD_BD71837
> > > 
> > > It's be nice if you prefix this with the manufacturer.  Rohm?
> > 
> > Like MFD_ROHM_BD71837, right? How important this is? The already applied
> > regulator part has depends_on for MFD_BD71837 in Kconfig so changing
> > this will require change in regulator tree too. I guess it's doable if
> > this is important though =)
> 
> How can it depend on something that doesn't exist. ;)
> 
> It's better, then similar devices can be grouped.
> 
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/input.h>
> > > > +#include <linux/interrupt.h>
> > > > +#include <linux/mfd/bd71837.h>
> > > > +#include <linux/mfd/core.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/regmap.h>
> > > > +#include <linux/gpio_keys.h>
> > > 
> > > Alphabetical please.
> > > 
> > 
> > There is a problem with gpio_key.h - it uses bool but does not include
> > the header defining this type. So I get comple error when compiling this
> > using my GCC arm cross-compiler. I've submitted a patch to fix this but
> > as it is not yet accepted.
> > https://lore.kernel.org/lkml/20180627073458.GA27800@localhost.localdomain/
> >  Hence the gpio_keys.h is last one.
> 
> If the ordering is important, separate it from the pack and place a
> little comment in to say why you've done so.  That way no well meaning
> contributor will attempt to tidy it up in the future.  If this will be
> fixed anyway, perhaps the point is moot?

I have no idea if my patch to add missing include is going to be
applied. I've not heard anything from it in a week or so. So I'll just
do as you suggested and drop a comment on why it is left last.

> > > > +	/*
> > > > +	 * According to BD71847 datasheet the HW default for long press
> > > > +	 * detection is 10ms. So lets change it to 10 sec so we can actually
> > > > +	 * get the short push and allow gracefull shut down
> > > > +	 */
> > > 
> > > I don't think this comment is necessary.
> > > 
> > > If anything it only needs to say "Configure long press to 10 seconds".
> > > 
> > > And if you do that, please add one for short press too.
> 
> > Difference between short and long push is that if PMIC detects log push
> > it will kill the power without any gracefull handling. And the chip I am
> > supporting right now is BD71837 - which has more sane default value (10
> > seconds). But I am going to add support for BD71847 - which was shipped
> > to me yesterday - and according the draft data-sheet the default on it
> > is 10ms - which makes short push unusable. So comment is intended to
> > point out _why_ I configure the long push here. Also someone might want
> > to use the HW default (I guess such default was selected for some
> > specific reason) so comment helps on removing this configuration for
> > specific use-cases. But I guess I can reduce the comment to "Configure
> > long press to 10 seconds" as you suggested - or do you think I should
> > make difference between ICs BD71837 and BD71847 more visible here?
> 
> Honestly, I don't think it's required.  If anyone were to try to
> change it, I would hope that they too would have read the datasheet
> and understand what they are doing.

You still have the hope and believe in good developers? ;) Allright,
I'll drop the comment.

> > > > +	ret = regmap_update_bits(bd71837->regmap,
> > > > +				 BD71837_REG_PWRONCONFIG1,
> > > > +				 BD718XX_PWRBTN_PRESS_DURATION_MASK,
> > > > +				 BD718XX_PWRBTN_LONG_PRESS_10S);
> > > > +
> > > > +	if (ret < 0) {
> > > > +		dev_err(&i2c->dev, "Failed to configure button long press timeout\n");
> > > > +		goto err_out;
> > > > +	}
> > > > +
> > > > +	btns[0].irq = regmap_irq_get_virq(bd71837->irq_data,
> > > > +					  BD71837_INT_PWRBTN_S);
> > > > +
> > > > +	if (btns[0].irq < 0) {
> > > > +		ret = btns[0].irq;
> > > > +		dev_err(&i2c->dev, "Failed to get the IRQ\n");
> > > > +		goto err_out;
> > > 
> > > No unwinding to be done, just return directly and save yourself an
> > > superflouous goto.
> > 
> > So should I replace _all_ the gotos by in-place returns as Enric suggested
> > yesterday? As I explained yesterday, my preference is to have only one
> > point of exit but I can change gotos to returns if needed.
> 
> I'm not sure where the 'one point of exit' thing stems from and I
> can't think of any good reason for it.  The main reason for using a
> goto in the exit path is to save lines of code and code duplication.
> Your method *adds* lines of code by firstly setting 'ret', then
> calling the goto.  If nothing needs to be done before returning, just
> return the error value with one line.

The point stems from my personal experiences =) I've once spent almost
two years cleaning/fixing up a code which left resources/locks leaking
from various function exits at error branches. Back then I sweared I
would always build just one clean-up sequence at the end of function and
never return from the middle. So this is my personal fixation. But as I
said, I will replace gotos with in place returns - and cross my fingers
no one adds a (non devm) resource allocation or locking in the probe =)

> > > > +++ b/include/linux/mfd/bd71837.h
> > > > @@ -0,0 +1,391 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > 
> > > I thought these were meant to use C++ (//) comments?
> > 
> > The checkpatch.pl did complain if I used // comment on SPDX line for
> > header file. OTOH for c-file it required // comments and complained
> > about /* */ - version. So I did as it suggested and used 
> 
> Well that's just dandy -- who comes up with this stuff?

Engineers I bet =)

> > > > +/* Copyright (C) 2018 ROHM Semiconductors */
> > > > +
> > > > +/*
> > > > + * ROHM BD71837MWV header file
> > > > + */
> > > 
> > > If you prefix the mentions of (BD,bd)71837 with (ROHM,rohm) then this
> > > comment becomes redundant and you can remove it.
> > 
> > I am sorry but I am not sure what you suggest here. Do you mean I should
> > add ROHM or rohm to all definitions here? I think that would make
> > definitions pretty long so I would certinly need to split more lines.
> > Such cange would also impact already applied patches. So maybe I
> > misinterpreted your comment? And in case I did not - can this prefixing of
> > types - be done as a separate patch set as it impacts to regulators and
> > clk too? (clk is not yet applied so that is easy to change though).
> 
> Any lines which are already long, you can justify as not having to do
> this, however I think for the filenames and function names it would
> be nice if they were prefixed.

Right. For file names this should be easily doable. And when the regmap
wrappers are removed there are no public functions left. And I think the
name of file containing the functions is sufficient for grouping
functions under "Rohm", right? 

> Filenames are particularly important.  That way all of the Rohm
> drivers will be grouped.  Unless you can be assured that all Rohm
> devices will be prefixed by 'bd', then the point is slightly mooted,
> however since 'bd' doesn't really correlate with 'rohm' it's still
> difficult to assume that bd* drivers are associated with Rohm -- if
> you catch my drift.

I guess I do catch it. And no, all ROHM stuff will definitely not be
prefixed with bd - which is the name of the power chip - I mean power IC
series.

> > > > +struct bd71837_pmic;
> > > > +struct bd71837_clk;
> > > > +struct bd718xx_pwrkey;
> > > 
> > > Where are these forward declared from?
> > 
> > bd71837_pmic is in drivers/regulator/bd71837-regulator.c
> > clk will be in clk subdevice patch that is not yet applied.
> > It is pending some fixes. Pwrkey must be dropped as the power-key driver
> > I originally wrote was replaced using gpio_keys instead. Should there be
> > some comment explaining this? Suggestions on how to do this without
> > referring to file names which are subject to change... Should I just say
> > they are defined in subdevice drivers? 
> 
> I just wanted you to think about if they were really necessary.

Right =) Well done on that=)

> > > > +/*
> > > > + * Board platform data may be used to initialize regulators.
> > > > + */
> > > > +
> > > > +struct bd71837_board {
> > > > +	struct regulator_init_data *init_data[BD71837_REGULATOR_CNT];
> > > > +	int	gpio_intr;
> > > > +};
> > > 
> > > Where is this populated?
> > > 
> > Currently nowhere as I use device-tree for getting the regulator/irq
> > config. This is for architectures which do not use DT - but as I don't
> > have one for testing I did leave the depends_on OF. If it was populated
> > I would expect it to be done in some setup code.
> 
> Please don't add code for 'what ifs'.
> 
> Please remove it and add it back when you need it.

Allright. Although this will also break the regulator part then...

> > > > +/*
> > > > + * bd71837 sub-driver chip access routines
> > > > + */
> > > > +
> > > 
> > > Please don't abstract APIs for no reason.
> > > 
> > > Use the regmap_* API directly instead.
> > > 
> > 
> > Yes. This was already pointed out by Stephen Boyd. But again, as part of
> > the patches (reguators) were already applied using the wrappers - I asked
> > if I can remove these in separate patch set after getting this initial
> > version out.
> 
> That is one of the issues with applying related patches without each
> of them being reviewed first.  Applying unsuitable code is not the
> correct thing to do, sorry.

So I assume you are not Ok with adding the wrappers and removing them
with later set of patches? I'll do following workaround then:

1. Change MFD Kconfig option name => current regulator code will not be
compiled even if the MFD would be applied.
2. Change MFD according to this discussion (and break the compatibility
with applied regulator code)
3. Fix the regulator code with further patches to Mark
4. Fix the depends_on Kconfig option in regulator tree to match the new
one suggested here.

Does this sound reasonable?

Best Regards
    Matti Vaittinen

> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
