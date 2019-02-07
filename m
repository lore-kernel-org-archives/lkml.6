Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E308EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93E92175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfBGGBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 01:01:42 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46967 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfBGGBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 01:01:41 -0500
Received: by mail-lf1-f67.google.com with SMTP id f5so7209912lfc.13;
        Wed, 06 Feb 2019 22:01:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YtjE25NANOkRGY0RUxMUUZAOa39JN3YFgyq9uzFUiuw=;
        b=Ap77jc2+5oFDakiGFtYZ53FSoWNdC0WCrIqiqTwqSKSdGfblfEJBPHuQ0l/j2LM/FK
         l14Ihr+AXNqaJ/1LvuPNDM5rPCzqYnVssAeirBkw3bX3gSoD/BNIr2CKr600GlkVM3ox
         b211KzyqNFcjlxqcDyFAwSCBMv7h77Yj3sjX4QEusr4AO7eq0At9pt9s7L4YGRP9eFVC
         UHC6H8nSMXAtnOPh1viGWWExyNo7aw840+hmCQbPot/bqOeiSzO3owSHouF+20g6lEpn
         MAT80Um2NnKuSAM/uMU5QmXYdmyhGtZSlvMupCX95ntihw6+Um0zcBC9AaPm+8QRSIZj
         p+cQ==
X-Gm-Message-State: AHQUAua12tu08/DuVKFAY2YFiSNuxxCl+Ra8uPsxG6A2wbtyCX5/JK6h
        hOI/QkhrlC/NCE8OgkxUguM=
X-Google-Smtp-Source: AHgI3IbNt+QT3jXkTPbYd6sV0xozb+qYK9f6ctBZFsF7tycooX3IvjXSuPN0aBrMYdMsHf893CH2RQ==
X-Received: by 2002:a19:59c2:: with SMTP id n185mr8667443lfb.118.1549519298495;
        Wed, 06 Feb 2019 22:01:38 -0800 (PST)
Received: from localhost.localdomain (82-203-157-3.bb.dnainternet.fi. [82.203.157.3])
        by smtp.gmail.com with ESMTPSA id y10-v6sm4033646ljy.65.2019.02.06.22.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 22:01:37 -0800 (PST)
Date:   Thu, 7 Feb 2019 08:01:04 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     mazziesaccount@gmail.com, Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        wim@linux-watchdog.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v7 05/10] clk: bd718x7: Support ROHM BD70528 clk block
Message-ID: <20190207060104.GB5798@localhost.localdomain>
References: <cover.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
 <88c49b30bbb4b1f3ecc24d333647585e2c82f4e4.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
 <154947428734.74891.4523492147164733315@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154947428734.74891.4523492147164733315@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 09:31:27AM -0800, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2019-02-06 01:39:38)
> > @@ -86,9 +87,21 @@ static int bd71837_clk_probe(struct platform_device *pdev)
> >                 dev_err(&pdev->dev, "No parent clk found\n");
> >                 return -EINVAL;
> >         }
> > -
> > -       c->reg = BD718XX_REG_OUT32K;
> > -       c->mask = BD718XX_OUT32K_EN;
> > +       switch (mfd->chip_type) {
> > +       case ROHM_CHIP_TYPE_BD71837:
> > +       case ROHM_CHIP_TYPE_BD71847:
> > +
> 
> Nitpick: why the extra newline above?
For no obvious reason. I'll fix this as I need to create new version
anyways. I'll squash the first 3 patches and fix some issues pointed out
by the 0-Day test suite.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
