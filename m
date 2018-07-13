Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D15ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3862087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIbYVltb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3862087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbeGMWKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 18:10:07 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35005 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbeGMWKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 18:10:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id p10-v6so20127190ljg.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 14:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y+5/MJSLBXd84oFwyffwkNBpilClQDHw1jpnkA+QrTw=;
        b=pIbYVltbG7slyO7r5Qx8ekLx/d8GSq7vU//zzLvWNk0C3h5PJ9NLs8IZM8sOGoB4qP
         K52+COZhnGIxvNFcu/Eyl9K3VsCb+dza90S8yn0b4B/oKzaqazrI3ZnFiMcHwXfdEZRO
         haHps+Yvc6fmbmOefjhhBGpNIvtAll0ENXtfM/dkvrdwusZU+uaIST2uMT7+N0jY/Yqq
         kU+lXlsc0X8Nh019dvsO90RBkLfmOxxLNH2/PAKFjPAKTBsLrWEIO9G6qMZn+ChaLKiK
         YcTMk3k4Dk9D341vran++VUh6NpJJJWXpvmYVv6p6Vm2i7t+Gr4qQo/pEI00gVXYje4S
         w7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y+5/MJSLBXd84oFwyffwkNBpilClQDHw1jpnkA+QrTw=;
        b=pRw5qKY2wRylRPaCIf1euifTmsNEAS8zoKcWwySJTbLMiq1WEgAJfFiRxF30w/I84c
         W+GRJWHBXRbvk5yoMxUpcUezCxDUtNolI+9pCNETbWVFs9XcZhZiBKvbwMPL/kqaP/qB
         fCKzTGMG8wT2wrhyyasD3OLS10oSl4DIB3zIKfqc4sZoOPdEcSuvD/MzzEP0Ayc8mx6p
         nQ96AfGf8yPJ/luj3eyeZvmItvXStzgGIccfBL2xp7DltgMZeB4s5YuwGY7Kfpka/cd7
         FJGxXwc2hv7z4wUGpZbhmHNxK1GOIs1gIzrnQ0uOLU5b+F1X9JB8YXl6MCzr1d6F1r1y
         VOMg==
X-Gm-Message-State: AOUpUlEurwCNkG8hvd0g0t2gdNAZYjGV0RbISSFxHWyUj0x5zE1wgYjn
        NMchaK8V2F133z5PrRRayxw=
X-Google-Smtp-Source: AAOMgpd/CbLCcksHsRB0mlVHLuu/WEO0e2BRPpRahgsRdO/QD3TZbf8eWrV++qTmLwY4UyWPFATwzw==
X-Received: by 2002:a2e:9095:: with SMTP id l21-v6mr4066634ljg.15.1531518817375;
        Fri, 13 Jul 2018 14:53:37 -0700 (PDT)
Received: from z50.localnet (apn-37-248-211-204.dynamic.gprs.plus.pl. [37.248.211.204])
        by smtp.gmail.com with ESMTPSA id n24-v6sm3690884ljc.7.2018.07.13.14.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 14:53:36 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        jacopo <jacopo@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH v4] regulator: fixed: Convert to use GPIO descriptor only
Date:   Fri, 13 Jul 2018 23:54:15 +0200
Message-ID: <1942821.URBRV441KV@z50>
In-Reply-To: <CACRpkdZbT-CpvaG4ZG76T0vkU_uyt20W_=vD-n9T3=Xy_5WqOg@mail.gmail.com>
References: <20180710061112.28736-1-linus.walleij@linaro.org> <5893595.ygSzo8aE2W@z50> <CACRpkdZbT-CpvaG4ZG76T0vkU_uyt20W_=vD-n9T3=Xy_5WqOg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Friday, July 13, 2018 9:35:06 AM CEST Linus Walleij wrote:
> On Tue, Jul 10, 2018 at 7:56 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> 
wrote:
> > > -     .gpio                   = AMS_DELTA_GPIO_PIN_MODEM_NRESET,
> > 
> > This is OK but not enough for clean build of board-ams-delta.c when merged
> > into current linux-next as one more struct fixed_voltage_config introduced
> > there recently - keybrd_pwr_config - needs removal of .gpio member
> > (respective lookup table with NULL function name is already there).
> > 
> > > @@ -538,6 +546,7 @@ static struct gpiod_lookup_table
> > > *ams_delta_gpio_tables[] __initdata = {> > 
> > >  };
> > >  
> > >  static struct gpiod_lookup_table *late_gpio_tables[] __initdata = {
> > > 
> > > +     &ams_delta_nreset_gpiod_table,
> > 
> > That is also OK but may raise a conflict when merged into current
> > linux-next where late_gpio_tables[] has been removed from
> > board-ams-delta.c  and its content integrated into
> > ams_delta_gpio_tables[].
> > 
> > >       &ams_delta_lcd_gpio_table,
> > >       &ams_delta_nand_gpio_table,
> > >  
> > >  };
> > 
> > If that makes your life easier, I can prepare a fix for board-ams-delta.c
> > on top of your patch.  In that case you can add my:
> > Reviewed-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> 
> Hm it's a bit of cross-tree conflict going on here I guess.
> 
> Do you have some idea about how serious the conflicts will be?
> Is it just one patch to the ARM SoC OMAP tree or several?

Just one patch, so ...

> It's a bit of Mark's pick, there are several ways to go about it:
> 
> 1. Simply defer this to the next kernel cycle when your change is upstream
>   and avoid all fuzz (totally OK as long as one is not impatient).
>   I'm definately not in a hurry.
> 
> 2. Mark applies this, conflicts appear in linux-next, you help Stephen
>   to solve it and later on Torvalds has to solve it. Then we need to
>   know how serious the conflicts are.
> 
> 3. Apply this patch with fixes to the ARM SoC tree. Which makes it hard to
>   pull out so I'm not so sure about that.
> 
> 4. An immutable branch with the ARM SoC change for Mark to pull
>   before applying this so I can rebase this patch on that.
> 
> 5. Pick some patch from ARM SoC and apply it *also* to the regulator
>   tree and then this on top so I can rebase the changes and avoid
>   all conflicts. (We do this sometimes as some last resort.)
> 
> 6. ...?

6. The conflict can be easily avoided (or made resolvable automatically) if you 
put the '&ams_delta_nreset_gpiod_table,' entry either at the end of 
late_gpio_tables[] or at the beginning of ams_delta_gpio_tables[]. Then the 
only thing left to do will be a fix removing obsolete .gpio member from the 
board-ams-delta's new "keybrd_pwr" regulator setup.

> BTW I like your OMAP1 cleanups a lot!

Thank you :-),
Janusz



