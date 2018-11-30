Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C763BC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E47D20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E47D20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeK3V72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:59:28 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42289 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbeK3V71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:59:27 -0500
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so4572926lja.9;
        Fri, 30 Nov 2018 02:50:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=daG1XJ3xEPZRYjxjHEIMiZ2KfFhva5k8E7JnZvAC+Oo=;
        b=t1vOHbKtA6GzLMRWcFKBWXm+ZWfE5Fuc/MjmLs9WMrlcGqH6QALguVNktXYq6AXKwM
         vK9VHmDH8+SK2xZntDQv+42sawvOzn3x92xjXDwz0T/BkORvQ1U9EQ7IKuaMVAaq3NN0
         2rXYzPVgx3zvA+rD6Nihz1K2qI+PsVg+LVXvKIIBbWfzpkCpYINJTXVvSdEemiYiNEYv
         ZK3rb2ETNvvM5lrNS61q/nTW3yWdscjRkw4At6X64V6oIoHQ89mj+m3mbs6vGuI+cXI7
         7Vch2QSI25+imi2Ko1AmFy6PxgEPdx+G+nNNF+LItfHRWtuh79q5M64tOB6qONTEvzWc
         E2Vg==
X-Gm-Message-State: AA+aEWYKg7ykht0n1B7NpK6hWD0Uvp0HsuNlZTflXwgY7pPBz+cM5BHZ
        XuEtCIyxJxr+WHqVHh+r1wE=
X-Google-Smtp-Source: AFSGD/XFPJ1MMWBlTqXBpTiP9WCmLCT4QKpGGG+olHyyiMLUAlROfdFfvehxLuxm1UY3PtnHFDGMbQ==
X-Received: by 2002:a2e:2281:: with SMTP id i123-v6mr3117217lji.154.1543575031301;
        Fri, 30 Nov 2018 02:50:31 -0800 (PST)
Received: from localhost.localdomain (84-253-205-125.bb.dnainternet.fi. [84.253.205.125])
        by smtp.gmail.com with ESMTPSA id s127sm753225lfe.8.2018.11.30.02.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 02:50:30 -0800 (PST)
Date:   Fri, 30 Nov 2018 12:50:22 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     mazziesaccount@gmail.com, Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH v4 1/8] clk: clkdev/of_clk - add managed lookup and
 provider registrations
Message-ID: <20181130105022.GA15388@localhost.localdomain>
References: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <ec0d6ee7ea79f0e05041ed3e564b0aadb297ef5f.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <154356805035.88331.16867826308376667832@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154356805035.88331.16867826308376667832@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thanks a bunch for taking the time and reviewing this!

On Fri, Nov 30, 2018 at 12:54:10AM -0800, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2018-11-13 03:55:58)
> > With MFD devices the clk properties may be contained in MFD (parent) DT
> > node. Current devm_of_clk_add_hw_provider assumes the clk is bound to MFD
> > subdevice not to MFD device (parent). Add
> > devm_of_clk_add_hw_provider_parent to tackle this issue.
> > 
> > Also clkdev registration lacks of managed registration functions and it
> > seems few drivers do not drop clkdev lookups at exit. Add
> > devm_clk_hw_register_clkdev and devm_clk_release_clkdev to ease lookup
> > releasing at exit.
> 
> Please split this into clkdev and non-clkdev devm functionality.
Allright. I'll split this to two patches.

> > --- a/Documentation/driver-model/devres.txt
> > +++ b/Documentation/driver-model/devres.txt
> > @@ -238,6 +238,9 @@ CLOCK
> >    devm_clk_put()
> >    devm_clk_hw_register()
> >    devm_of_clk_add_hw_provider()
> > +  devm_of_clk_add_parent_hw_provider()
> > +  devm_clk_hw_register_clkdev()
> > +  devm_clk_release_clkdev()
> 
> The 'release' or non-common functions shouldn't be documented here.
So I will drop the line mentioning devm_clk_release_clkdev()

> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index af011974d4ec..9bb921eb90f6 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -3893,12 +3893,12 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
> >         of_clk_del_provider(*(struct device_node **)res);
> >  }
> >  
> > -int devm_of_clk_add_hw_provider(struct device *dev,
> > +static int __devm_of_clk_add_hw_provider(struct device *dev,
> >                         struct clk_hw *(*get)(struct of_phandle_args *clkspec,
> >                                               void *data),
> > -                       void *data)
> > +                       struct device_node *of_node, void *data)
> >  {
> > -       struct device_node **ptr, *np;
> > +       struct device_node **ptr;
> >         int ret;
> >  
> >         ptr = devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
> > @@ -3906,10 +3906,9 @@ int devm_of_clk_add_hw_provider(struct device *dev,
> >         if (!ptr)
> >                 return -ENOMEM;
> >  
> > -       np = dev->of_node;
> > -       ret = of_clk_add_hw_provider(np, get, data);
> > +       *ptr = of_node;
> > +       ret = of_clk_add_hw_provider(of_node, get, data);
> >         if (!ret) {
> > -               *ptr = np;
> 
> Why is this moved outside of the if condition?
I completely removed the local variable np and just unconditionally set
the allocated devres to point at the node (if allocation succeeded). We
could of course only do this if the provider registration succeeded and
save one assignment - but I guess I intended to remove the curly braces
and thus decided to go for one liner after if. But apparently I didn't
remove the braces O_o. Well, I can put the assignment inside the
condition if you prefer that.

> In fact, why isn't just
> the first line in this hunk deleted and passed to this function as
> struct device_node *np?

I am sorry but I don't quite follow your suggestion here. Do you mean we
could just pass the struct device_node *np in devres_add()? I thought
the pointer passed to devress_add() should be allocated using
devres_alloc. Can you please elaborate what you mean?

> 
> >                 devres_add(dev, ptr);
> >         } else {
> >                 devres_free(ptr);
> > @@ -3917,8 +3916,25 @@ int devm_of_clk_add_hw_provider(struct device *dev,
> >  
> >         return ret;
> >  }
> 
> Nitpick: Add a newline here.

Will do.

> 
> > +int devm_of_clk_add_hw_provider(struct device *dev,
> > +                       struct clk_hw *(*get)(struct of_phandle_args *clkspec,
> > +                                             void *data),
> > +                       void *data)
> > +{
> > +       return __devm_of_clk_add_hw_provider(dev, get, dev->of_node, data);
> > +}
> >  EXPORT_SYMBOL_GPL(devm_of_clk_add_hw_provider);
> >  
> > +int devm_of_clk_add_parent_hw_provider(struct device *dev,
> > +                       struct clk_hw *(*get)(struct of_phandle_args *clkspec,
> > +                                             void *data),
> > +                       void *data)
> > +{
> > +       return __devm_of_clk_add_hw_provider(dev, get, dev->parent->of_node,
> 
> I'm wondering if we can somehow auto-detect this in
> devm_of_clk_add_hw_provider() by looking for #clock-cells in the node.
> If it isn't there, then we go to the parent node and look for a
> #clock-cells property there in the DT node for that device. Does that
> make sense? Then there isn't any new API and we can attach the lifetime
> of the devm registration to the presence of the property indicating this
> is a clk controller or not.

Huh. I don't know why but building this kind of logic in core is a bit
scary to me. I guess I can try implementing something like this - but I
am not really a fan of this. (Accidentally) omit the #clock-cells from
node and we go to parent node - I am a novice on this area but this
sounds like a potential hazard to me. I believe the driver should know
if it's properties should be in own or parent node - and if they are
not, then there should be no guessing but error. The lifetime is topic
where I would like to get information from you who know the kernel
better than I do =) But I guess the parent node is there at least as
long as the child device is alive. So for me the life time of
get-callback is more crucial - but as I said, I don't understand the
kernel in details so you probably know it better than me. But please let
me know your final take on this and I will follow the guidance =)

> 
> > +                                            data);
> > +}
> > +EXPORT_SYMBOL_GPL(devm_of_clk_add_parent_hw_provider);
> 
> Can we get some kernel doc on these functions?
Sure. I will add the doc. Reason why I didn't do it is that the current
devm_of_clk_add_hw_provider() did not have doc. But I'll add that in
next patch.

> > +       rval = devres_release(dev, devm_clkdev_release,
> > +                             &devm_clk_match_clkdev, cl);
> 
> Nitpick: Drop & on functions taken as pointers.
Ok. Will do.

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
