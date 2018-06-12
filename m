Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6B17CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DD4208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkwQAMUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DD4208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933816AbeFLIYH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:24:07 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39921 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932794AbeFLIYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:24:02 -0400
Received: by mail-lf0-f66.google.com with SMTP id t134-v6so34652239lff.6;
        Tue, 12 Jun 2018 01:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9fw98D9jaasRphXlrCPqgNQDSroDLmYZEKbQKtma97g=;
        b=MkwQAMUhAp6N+M29hp9bCilMGQzfhgg4DZMKQvaqajhLzMG9mtHcWIsW0D3htZOnap
         Us1wlJrBDa07fXZ7O0V69wbr5PCvyrPlxW6sBCuW2EoEWPN8cxxmmrlOoCOIrPzzVaCH
         0H7sC0idz0w+m6sq0QtpxZ8fkQUNAwUNvo8D10DCqm2IbUG3GgXxjvqAvoqwkJBlNLHB
         xC+Q7if18BxFyfTwK+0Od/1dzlSEj2COCevXjaOAEJoxYOvUBAU3+GjTbL5aJBQqwNqC
         eWEM9K/fP0wZuhr0+4FJE5EZ00LVqqUoQ91ZAVhlRP1J3c8mljZ/xGc5RDL03qBBfDg0
         Gwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9fw98D9jaasRphXlrCPqgNQDSroDLmYZEKbQKtma97g=;
        b=DlvhqXqkK9/mLrFFys/ayE7O7kjxnIQ99SvjlLBZozriovLZr3v7IWew+PES5Q2beY
         05yr1cBTlYKMZ3LEbOsUlsp3595cmaBaOfEl3eXavr0y446L4CmAXld+wSIJO+55BCGD
         Cqkdx+200PK2/OIA66qwRtj+GhC8chd3rjYGLRvigL6ZEmx8gvYVYDZn2XWTlUJzu3PN
         bmbEyNLQ+I2lzGHnrtW9d74fcQ7GxREVMeirQvrk6B69cGM/OJdQDNY1gQriwc5kAH1t
         Xv9rc67V83RX6ACEf/KOg3eNADwFFVe+4xvw2s0+s0v1deMPq+ButyUzOptFgV+zUaDJ
         Qqsg==
X-Gm-Message-State: APt69E17B0X9v27VjFGqgULrN2W6uycRDqlvS4WEM/9r4Kmv0GcMGQPC
        V5lXtqDdHJdLYQxWtyKAOrwv2aHY
X-Google-Smtp-Source: ADUXVKI4ZQ9bzh1BYRMQp2cnsPMSu6UdUTgZvzHRRo5ZDDVX0dSOIHC0OEOY+SS/D/f6PI1gnTS8vg==
X-Received: by 2002:a19:de0a:: with SMTP id v10-v6mr1426680lfg.94.1528791840175;
        Tue, 12 Jun 2018 01:24:00 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.34])
        by smtp.gmail.com with ESMTPSA id w6-v6sm81127ljw.70.2018.06.12.01.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 01:23:59 -0700 (PDT)
From:   Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date:   Tue, 12 Jun 2018 11:23:54 +0300
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        broonie@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
        mark.rutland@arm.com, mazziesaccount@gmail.com,
        mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v5 4/4] clk: bd71837: Add driver for BD71837 PMIC clock
Message-ID: <20180612082354.GG20078@localhost.localdomain>
References: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <d99c8762b0fbbcb18ec4f4d104191364c0ea798c.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <152878945117.16708.12422348324182290971@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152878945117.16708.12422348324182290971@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thanks again for the review. I'll do new patch which fixes these issues.

On Tue, Jun 12, 2018 at 12:44:11AM -0700, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2018-06-04 06:19:13)
> > +config COMMON_CLK_BD71837
> > +       tristate "Clock driver for ROHM BD71837 PMIC MFD"
> > +       depends on MFD_BD71837
> > +       help
> > +         This driver supports ROHM BD71837 PMIC clock.
> > +
> > +
> 
> Drop one newline above.
Right.

> 
> > +++ b/drivers/clk/clk-bd71837.c
> > +#include <linux/mfd/bd71837.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/clkdev.h>
> > +
> > +
> 
> Drop one newline above.
Right.

> 
> > +struct bd71837_clk {
> > +       struct clk_hw hw;
> > +       uint8_t reg;
> > +       uint8_t mask;
> 
> Use u8 instead of uint8_t.
I can do that but I am afraid I have missed the reason for this. Why u8
is preferred? I would have assumed the standard uint8_t would be
preferred - can you please educate me as to what is this reason?

> > +       unsigned long rate;
> > +       struct platform_device *pdev;
> > +       struct bd71837 *mfd;
> > +};
> > +
> > +static int bd71837_clk_set(struct clk_hw *hw, int status)
> > +{
> > +       struct bd71837_clk *c = container_of(hw, struct bd71837_clk, hw);
> > +
> > +       return bd71837_update_bits(c->mfd, c->reg, c->mask, status);
> 
> Any reason we can't use a regmap?

Not really. These wrappers might become handy if the next chip in series
requires some quirks for access but at the moment I see no reason for
the wrappers. I could switch to direct regmap calls but that change
should then be done to all subdevices and not just for clk one. This
means I should rework also the already applied regulator part. I have
some other changes pending for regulators (adding support for next chip,
renaming bd71837 to bd718x7 or bd718xx, and few comments from  Andy
Shevchenko and Rob Herring). I would rather switch to direct regmap usage
for all subdevices at the same time. So if it is acceptable to keep the
wrappers for now (and then create own patch set to remove them from all
subdevices and the header) I would like to do so.

> 
> > +}
> > +
> > +static void bd71837_clk_disable(struct clk_hw *hw)
> > +{
> > +       int rv;
> > +       struct bd71837_clk *c = container_of(hw, struct bd71837_clk, hw);
> > +
> > +       rv = bd71837_clk_set(hw, 0);
> > +       if (rv)
> > +               dev_dbg(&c->pdev->dev, "Failed to disable 32K clk (%d)\n", rv);
> > +}
> > +
> > +static int bd71837_clk_enable(struct clk_hw *hw)
> > +{
> > +       return bd71837_clk_set(hw, 1);
> > +}
> > +
> > +static int bd71837_clk_is_enabled(struct clk_hw *hw)
> > +{
> > +       struct bd71837_clk *c = container_of(hw, struct bd71837_clk, hw);
> > +
> > +       return c->mask & bd71837_reg_read(c->mfd, c->reg);
> 
> Didn't I ask for local variable for reg_read result?

Yes! Sorry! And thanks for pointing this out again. It seems I missed
this one.

> 
> > +}
> > +
> > +static unsigned long bd71837_clk_recalc_rate(struct clk_hw *hw,
> > +                                            unsigned long parent_rate)
> > +{
> > +       struct bd71837_clk *c = container_of(hw, struct bd71837_clk, hw);
> > +
> > +       return c->rate;
> > +}
> > +
> > +static const struct clk_ops bd71837_clk_ops = {
> > +       .recalc_rate = &bd71837_clk_recalc_rate,
> > +       .prepare = &bd71837_clk_enable,
> > +       .unprepare = &bd71837_clk_disable,
> > +       .is_prepared = &bd71837_clk_is_enabled,
> > +};
> > +
> > +static int bd71837_clk_probe(struct platform_device *pdev)
> > +{
> > +       struct bd71837_clk *c;
> > +       int rval = -ENOMEM;
> > +       struct bd71837 *mfd = dev_get_drvdata(pdev->dev.parent);
> > +       struct clk_init_data init = {
> > +               .name = "bd71837-32k-out",
> > +               .ops = &bd71837_clk_ops,
> > +       };
> > +
> > +       c = devm_kzalloc(&pdev->dev, sizeof(*c), GFP_KERNEL);
> > +       if (!c)
> > +               goto err_out;
> > +
> > +       c->reg = BD71837_REG_OUT32K;
> > +       c->mask = BD71837_OUT32K_EN;
> > +       c->rate = BD71837_CLK_RATE;
> 
> The PMIC has an 'XIN' pin that would be the clk input for this chip, and
> the output clk, this driver, would specify that xin clock as the parent.
> The 'xin' clock would then be listed in DT as a fixed-rate clock. That
> way this driver doesn't hardcode the frequency.

I see. This makes sense. I need to verify from HW colleagues whether
this chip has internal oscillator or not. I originally thought we have
on-chip oscillator - but as you say, we do have XIN pin in documentation.
So now I am not sure if the test board I have contains oscillator driving
the clk on PMIC - or if the PMIC has internal oscillator. I'll clarify this.

> > +       c->mfd = mfd;
> > +       c->pdev = pdev;
> > +
> > +       of_property_read_string_index(pdev->dev.parent->of_node,
> > +                                             "clock-output-names", 0,
> > +                                             &init.name);
> > +
> > +       c->hw.init = &init;
> 
> Do this next to all the other c-> things?

I can do so. I just like the idea of assigning pointers to objects only
after the objects have been initialized. Eg, in this case I add pointer
to init only after I have filled the init.name (if it is given).

> 
> > +
> > +       rval = devm_clk_hw_register(&pdev->dev, &c->hw);
> > +       if (rval) {
> > +               dev_err(&pdev->dev, "failed to register 32K clk");
> > +               goto err_out;
> > +       }
> > +
> > +       if (pdev->dev.parent->of_node) {
> > +               rval = of_clk_add_hw_provider(pdev->dev.parent->of_node,
> > +                                            of_clk_hw_simple_get,
> > +                                            &c->hw);
> > +               if (rval) {
> > +                       dev_err(&pdev->dev, "adding clk provider failed\n");
> > +                       goto err_out;
> 
> Just return rval instead of goto and then remove err_out label.

Is this 'hard requirement'? I prefer single point of exit from functions
(when easily doable) because I have done so many errors with locks /
resources being reserved when exiting from some error branch. For my
personal taste maintaining the one nice cleanup sequence is easier. But
if this is 'hard requirement' this can of course be changed.

> 
> > +               }
> > +       }
> > +
> > +       rval = clk_hw_register_clkdev(&c->hw, init.name, NULL);
> 
> This leaks a clkdev lookup. Sad we don't have a devm version. Maybe it
> should be added. But I really doubt this chip will be used with clkdev
> lookups so please remove clkdev until you have a user who needs it.

Yep. It leaks. I tried to look for an example where the clkdev was
nicely freed at remove - but I didn't find any. Every example I spotted
did leak the clkdev in same way as this does :( And I agree, devm
variant for freeing would be nice - or freeing routines based on hw.

As the leaked clkdev can cause oops at module unload/reload/use your
suggestion about removing it for now makes sense. I'll drop it.

> 
> > +       if (rval) {
> > +               dev_err(&pdev->dev, "failed to register clkdev for bd71837");
> > +               goto err_clean_provider;
> > +       }
> > +
> > +       platform_set_drvdata(pdev, c);
> > +
> > +       return 0;
> > +
> > +err_clean_provider:
> > +       of_clk_del_provider(pdev->dev.parent->of_node);
> > +err_out:
> > +       return rval;
> > +}
> > +
> > +static int bd71837_clk_remove(struct platform_device *pdev)
> > +{
> > +       if (pdev->dev.parent->of_node)
> > +               of_clk_del_provider(pdev->dev.parent->of_node);
> 
> Use devm so this can go away. Or is devm not used because the parent
> of_node is the provider? That's annoying.

What would be the correct workaround for this?

> 
> > +       return 0;
> > +}
> > +

Br,
    Matti Vaittinen

