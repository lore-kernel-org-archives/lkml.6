Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80EDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA1320846
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA1320846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932351AbeFZINe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:13:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33122 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932174AbeFZINa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:13:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id t21-v6so8083413lji.0;
        Tue, 26 Jun 2018 01:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4wmUGQGvbdG/KHyn0pRgJwCdvuttsUSlpjialTf7rk8=;
        b=a4RFKMpVEKLh7OeeIQS+TKMTngAqYU4vI4CkB0EmlXp8fLEmcNBxIieSFyXb26l/2c
         2ITm7lTSoqXPMNADV+1svgk2fRyX79wIGIkc2kDW+RFd44XXbEfvOxxmWYOxDL8hPQJR
         DVcxe8Eka3/DokxXVXV0lOaXPgky6bYIFsCrfOVMingw3WT9nZHgLZe6TnZzfSe8z/Os
         DRETZh/V1TNcQI+y62QLma1rj5wi+UQr4MtXaatHGH9dYfDTw28yDQ4n5OcryWPzEHQO
         13wdKojU/p+EI7xtA+AzkfntaLcGO0wR2f+AQ0THucuxfOJxD2e85gsTTiS+e1KXYRfP
         9XDA==
X-Gm-Message-State: APt69E2hXQ/Bx58IRallux4C2CQ6C3gkzqcNJkkpDchV7ZIjpve2+1J8
        sp78t74EH6t62+dwuyWbR4w=
X-Google-Smtp-Source: AAOMgpcW+3e3RPB6cTPm1evp0MugBhAaeBx0tJ9oGyvnZCiSfGAwGtMCPItlXAT8gC9LgKC9m+etUg==
X-Received: by 2002:a2e:5b4a:: with SMTP id p71-v6mr409030ljb.13.1530000808785;
        Tue, 26 Jun 2018 01:13:28 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id l25-v6sm143929ljj.30.2018.06.26.01.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 01:13:27 -0700 (PDT)
Date:   Tue, 26 Jun 2018 11:13:19 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>, broonie@kernel.org,
        lee.jones@linaro.org, lgirdwood@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v5 4/4] clk: bd71837: Add driver for BD71837 PMIC clock
Message-ID: <20180626081319.GA2118@localhost.localdomain>
References: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <d99c8762b0fbbcb18ec4f4d104191364c0ea798c.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <152878945117.16708.12422348324182290971@swboyd.mtv.corp.google.com>
 <20180612082354.GG20078@localhost.localdomain>
 <152997029783.143105.16692843405899913246@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <152997029783.143105.16692843405899913246@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen, Rob and all others

Thanks again Stephen. I appreciate your help. And just to help you
sorting your inbox a bit - I have written patch series v6 and v7 before
receiving these comments. I will write v8 after I get some further input
from you and Rob on how to solve the issue with having the clk stuff in
parent node and usage of devm_of_clk_add_hw_provider where DT node is
fetched from dev pointer. 

The v8 should then address rest of the issues - except the regmap wrappers
which I will send as separate patch. So I guess you can skip the v6 and v7
and just please check for the v8 when I get it done.

On Mon, Jun 25, 2018 at 04:44:57PM -0700, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2018-06-12 01:23:54)
> > On Tue, Jun 12, 2018 at 12:44:11AM -0700, Stephen Boyd wrote:
> > > Quoting Matti Vaittinen (2018-06-04 06:19:13)
> > > Use u8 instead of uint8_t.
> > can you please educate me as to what is this reason?
> 
> This is kernel style to prefer the shorter types within the kernel code.
> Outside of the kernel proper, uint*_t types are used in the UAPI
> headers. You can look through the mailing list about this, but this is
> how I've known it to be for a while now.

Thanks. I have changed this from patch v6 onwards.
> > > > +
> > > > +       rval = devm_clk_hw_register(&pdev->dev, &c->hw);
> > > > +       if (rval) {
> > > > +               dev_err(&pdev->dev, "failed to register 32K clk");
> > > > +               goto err_out;
> > > > +       }
> > > > +
> > > > +       if (pdev->dev.parent->of_node) {
> > > > +               rval = of_clk_add_hw_provider(pdev->dev.parent->of_node,
> > > > +                                            of_clk_hw_simple_get,
> > > > +                                            &c->hw);
> > > > +               if (rval) {
> > > > +                       dev_err(&pdev->dev, "adding clk provider failed\n");
> > > > +                       goto err_out;
> > > 
> > > Just return rval instead of goto and then remove err_out label.
> > 
> > Is this 'hard requirement'? I prefer single point of exit from functions
> > (when easily doable) because I have done so many errors with locks /
> > resources being reserved when exiting from some error branch. For my
> > personal taste maintaining the one nice cleanup sequence is easier. But
> > if this is 'hard requirement' this can of course be changed.
> 
> There are no locks though. And this uses devm. So please remove the goto
> so my style alarms don't go off. Thanks!

I did rework this piece from patch v6 onwards so that there is no goto but
we still have single exit point. I hope that is Ok, so please re-check
this when you find the time.

> > > > +       rval = clk_hw_register_clkdev(&c->hw, init.name, NULL);
> > > 
> > > This leaks a clkdev lookup. Sad we don't have a devm version. Maybe it
> > > should be added. But I really doubt this chip will be used with clkdev
> > > lookups so please remove clkdev until you have a user who needs it.
> > 
> > Yep. It leaks. I tried to look for an example where the clkdev was
> > nicely freed at remove - but I didn't find any. Every example I spotted
> > did leak the clkdev in same way as this does :( And I agree, devm
> > variant for freeing would be nice - or freeing routines based on hw.
> > 
> > As the leaked clkdev can cause oops at module unload/reload/use your
> > suggestion about removing it for now makes sense. I'll drop it.
> 
> Ok! Sometimes drivers don't free them because they're lazy and don't
> expect to be unloaded or to fail. I guess you ran into those. I'm happy
> to apply patches to clean those up.

When I get the moment of "hmm, what should I do next" - I'll keep this
in mind... Unfortunately those moments have been pretty rare occasions
since I found my wife and got my kids - but OTOH, we have working
pension scheme in Finland - so I expect this to change during the next
30 years or so =] (Truth is that I'll keep this in mind but can't
promise anything more as promises might be empty).

> > > > +       if (rval) {
> > > > +               dev_err(&pdev->dev, "failed to register clkdev for bd71837");
> > > > +               goto err_clean_provider;
> > > > +       }
> > > > +
> > > > +       platform_set_drvdata(pdev, c);
> > > > +
> > > > +       return 0;
> > > > +
> > > > +err_clean_provider:
> > > > +       of_clk_del_provider(pdev->dev.parent->of_node);
> > > > +err_out:
> > > > +       return rval;
> > > > +}
> > > > +
> > > > +static int bd71837_clk_remove(struct platform_device *pdev)
> > > > +{
> > > > +       if (pdev->dev.parent->of_node)
> > > > +               of_clk_del_provider(pdev->dev.parent->of_node);
> > > 
> > > Use devm so this can go away. Or is devm not used because the parent
> > > of_node is the provider? That's annoying.
> > 
> > What would be the correct workaround for this?
> 
> Smash the clk driver into the overall PMIC node. That should work. Or
> possibly assign the same of_node to the child device when creating it?
> I'm not sure if that causes some sort of problem with DT code though, so
> it would be good to check with Rob H if that's a bad idea or not.

I'd rather keep the clk in own subdevice so that it can be used or not
used based on the clk Kconfig options. I also rather keep the clk codes
in clk folders. So I guess the use of devm is not correct justification
for bundling the MFD and clk. I basically see 3 ways:

1. Assign MFD node to subdevice node in MFD when creating the cells.
2. Assign parent->of_node to dev.of_node in clk subdevice.
3. Create devm_of_clk_add_hw_provider_w_node() which does something
like (not compiled pseudo) code below

int devm_of_clk_add_hw_provider_w_node(struct device *dev,
			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
					      void *data),
			struct device_node *of_node,
			void *data)
{
	struct device_node **ptr;
	int ret;
	ptr = devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
			   GFP_KERNEL);
	if (!ptr)
		return -ENOMEM;

	*ptr = of_node;
	ret = of_clk_add_hw_provider(of_node, get, data);
	if (!ret)
		devres_add(dev, ptr);
	else
		devres_free(ptr);

	return ret;
}
EXPORT_SYMBOL_GPL(devm_of_clk_add_hw_provider_w_node);

int devm_of_clk_add_hw_provider(struct device *dev,
			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
					      void *data),
			void *data)
{
	return devm_of_clk_add_hw_provider_w_node(dev, get, dev->of_node,
						  data);
}
EXPORT_SYMBOL_GPL(devm_of_clk_add_hw_provider);

To me the third option sounds like correct one - but you guys probably
have the idea how these subsystems should look like in the future - so I
trust on your judgement on this. So whatäs your take on this?

I'll also add Rob in the 'to' field of this email so maybe we get his opinion
on this.

Best Regards
    Matti Vaittinen

