Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B6AC07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EF720892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3EF720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeLESYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:24:37 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46866 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLESYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:24:37 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so19224530ljh.13;
        Wed, 05 Dec 2018 10:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LEpiSlqrR7Ad0w48eDX/Xp8zFO8FXef8bg6emoIDpa8=;
        b=lnheG1kBLy3c6f1YbQRGp32feLqH1KM1FQmjXHBietEk4jCDM5BeqEUl1Kpls9THvh
         Ust51j4VU1ISufOKspcsO0AsSVNy3wq+4EwrSLkeyUfGcfUDhgzw3zzHU8pH/hsYyiN5
         HJvlZYfLbl9FdOVa7Q9x3q5iteu3crb293zUzoxi7VVmZ4YfJF3VpMBjZWv9eTmlzx5i
         OJfcVMHIecUpNZ133wsvT49Q+PczqZ6Qn34SmM9WquwTvJqTe37+dgNJHcFYuGzqeoQI
         UsaGgPhvC7u2czGJXgWWkadVzdnVTMDkAfZS5XEp2TM8RSCs/7LE1MXzc0nK5DvVi8My
         TcBQ==
X-Gm-Message-State: AA+aEWbNM6q2AB52pyK+4znH37eoW2SHnd1dSHErg2qWCwvXMrMtPtJi
        urgYC3iGw8yQGt6Wy3SO/zY=
X-Google-Smtp-Source: AFSGD/UeriZm3dGS9tCBzpYxA7rpbmXrfQX1F0JOK2nh+CYjH42tAqUmnMIrE7uZXc1Fi7e+azPNoQ==
X-Received: by 2002:a2e:4218:: with SMTP id p24-v6mr16364333lja.58.1544034274785;
        Wed, 05 Dec 2018 10:24:34 -0800 (PST)
Received: from localhost.localdomain (84-253-205-125.bb.dnainternet.fi. [84.253.205.125])
        by smtp.gmail.com with ESMTPSA id l21-v6sm3877851ljj.48.2018.12.05.10.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 10:24:34 -0800 (PST)
Date:   Wed, 5 Dec 2018 20:24:30 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     mazziesaccount@gmail.com, mturquette@baylibre.com,
        cw00.choi@samsung.com, krzk@kernel.org, b.zolnierkie@samsung.com,
        linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, pavel@ucw.cz, andrew.smirnov@gmail.com,
        pombredanne@nexb.com, sjhuang@iluvatar.ai, akshu.agrawal@amd.com,
        djkurtz@chromium.org, rafael.j.wysocki@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 10/10] clk: bd718x7: Initial support for ROHM
 bd71837/bd71847 PMIC clock
Message-ID: <20181205182430.GG31204@localhost.localdomain>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <b1a7aa06389ccd46f60db3e63bdf1e9ce9781d49.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <154403090130.88331.18352581261422337586@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154403090130.88331.18352581261422337586@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks again Stephen.

On Wed, Dec 05, 2018 at 09:28:21AM -0800, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2018-12-04 03:39:38)
> > diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
> > new file mode 100644
> > index 000000000000..d486859526ed
> > --- /dev/null
> > +++ b/drivers/clk/clk-bd718x7.c
> > @@ -0,0 +1,131 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 ROHM Semiconductors
> > +// bd71837.c  -- ROHM BD71837MWV clock driver
> 
> This isn't even the name of the file. Please remove. Also, only the SPDX
> tag is supposed to have // on it and the other things should be normal
> /* */ comment style.

I'll drop this name.

> 
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/err.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/mfd/rohm-bd718x7.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/clkdev.h>
> > +#include <linux/regmap.h>
> [....]
> > +
> > +static int bd71837_clk_probe(struct platform_device *pdev)
> > +{
> > +       struct bd718xx_clk *c;
> > +       int rval = -ENOMEM;
> > +       const char *parent_clk;
> > +       struct device *parent = pdev->dev.parent;
> > +       struct bd718xx *mfd = dev_get_drvdata(parent);
> > +       struct clk_init_data init = {
> > +               .name = "bd718xx-32k-out",
> > +               .ops = &bd71837_clk_ops,
> > +       };
> > +
> > +       c = devm_kzalloc(&pdev->dev, sizeof(*c), GFP_KERNEL);
> > +       if (!c)
> > +               return -ENOMEM;
> > +
> > +       init.num_parents = 1;
> > +       parent_clk = of_clk_get_parent_name(parent->of_node, 0);
> > +
> > +       init.parent_names = &parent_clk;
> > +       if (!parent_clk) {
> > +               dev_err(&pdev->dev, "No parent clk found\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       c->reg = BD718XX_REG_OUT32K;
> > +       c->mask = BD718XX_OUT32K_EN;
> > +       c->mfd = mfd;
> > +       c->pdev = pdev;
> > +       c->hw.init = &init;
> > +
> > +       of_property_read_string_index(parent->of_node,
> > +                                     "clock-output-names", 0, &init.name);
> > +
> > +       rval = devm_clk_hw_register(&pdev->dev, &c->hw);
> > +       if (!rval) {
> > +               rval = devm_clk_hw_register_clkdev(&pdev->dev,
> > +                                                  &c->hw, init.name, NULL);
> 
> Do you plan to use the clkdev lookup? This driver looks fairly DT
> dependent, so I would prefer to remove the clkdev part and only add it
> later if anyone needs it.

Right. We depend heavily on DT so I guess I can drop the clkdev portion.

> > +               if (rval)
> > +                       dev_warn(&pdev->dev, "Failed to register clkdev\n");
> > +               if (parent->of_node) {
> > +                       rval = devm_of_clk_add_hw_provider(&pdev->dev,
> > +                                            of_clk_hw_simple_get, &c->hw);
> > +                       if (rval)
> > +                               dev_err(&pdev->dev,
> > +                                       "adding clk provider failed\n");
> > +               }

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
