Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF61C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A3B20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7K77Q7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404290AbfAPNYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:24:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55066 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732880AbfAPNYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:24:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so1959104wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 05:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VZGE+THsRwEY5N+8xt1GakeqbbAUxTIXTQwNrTtr11s=;
        b=f7K77Q7gmUbCEwYDDMy2pRXG6Gw2fxoGXpTKkHulBV2vYPW9Cm9n6+FWukj08+X25S
         oAYqlCDZdRD8daeE9fNoza9/2oAMoFJch28nbl7MCUJ9VxChgv5YFVzhKHzNnB9aJSlB
         CSs49jFBS9Slm1Vu+HzNfYv0AcBF1X0GJsglo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VZGE+THsRwEY5N+8xt1GakeqbbAUxTIXTQwNrTtr11s=;
        b=Pf+p96mI284ZnnpY5JnjghPU1PQHdbKj6YtZrwG8rV9bctptKagUyhPsvTK/cNY2Zs
         rc8SY3zRaMwx9pzQPY0JrI053xvp095dHmxmBLYjYIpX4MlOReM7ndYvgsCi9BSSyhpp
         6ndfYPhLjP1KjH8/8SqkqZD4WcHWTQLqd8AALhHsTPMdFbQPcG43SZbWUiE0izmgP3Z2
         3E5Vik4r6+NWAA7y9MkM5lYozHHTdnV+R0RtQB8IsblEw9X3rMAJ4DsgOuS3jSR/1cxg
         RGCWjY0n7sorrjHG7YmP0aNK1B0SdCLxtG+m9LqV3aAtami5pVnKCx0ngWAkbi0HhDTH
         KlyA==
X-Gm-Message-State: AJcUukc363aHoSapGf698uNz+y6UrDinK1dgh3bP85BXxkFYdJjMxCVR
        8UHJr3Btvzh36wYcTb2O27VUlC7VO3c=
X-Google-Smtp-Source: ALg8bN5ei4x1z6ktQw4Exv4ov/9ky+Ftv6arfQ09YxA0JE3bx9ZqTdem6CjMRAkJ2bY703iItzj8Og==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr7653216wmi.144.1547645074471;
        Wed, 16 Jan 2019 05:24:34 -0800 (PST)
Received: from dell ([2.27.35.149])
        by smtp.gmail.com with ESMTPSA id o15sm64418504wrp.12.2019.01.16.05.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 05:24:33 -0800 (PST)
Date:   Wed, 16 Jan 2019 13:24:31 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Alessandro Rubini <rubini@gnudd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Cory Maccarrone <darkstar6262@gmail.com>,
        Davide Ciminaghi <ciminaghi@gnudd.com>,
        Dong Aisheng <dong.aisheng@linaro.org>,
        Graeme Gregory <gg@slimlogic.co.uk>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Haojian Zhuang <haojian.zhuang@marvell.com>,
        Jin Park <jinyoungp@nvidia.com>,
        Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Mattias Nilsson <mattias.i.nilsson@stericsson.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Tony Lindgren <tony@atomide.com>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        linux-omap@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v5 00/18] mfd: demodularization of non-modular drivers
Message-ID: <20190116132431.GE23399@dell>
References: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> Paul Gortmaker (18):
>   mfd: aat2870-core: Make it explicitly non-modular
>   mfd: adp5520: Make it explicitly non-modular
>   mfd: as3711: Make it explicitly non-modular
>   mfd: db8500-prcmu: drop unused MODULE_ tags from non-modular code
>   mfd: htc-i2cpld: Make it explicitly non-modular
>   mfd: max8925-core: drop unused MODULE_ tags from non-modular code
>   mfd: rc5t583: Make it explicitly non-modular
>   mfd: sta2x11: drop unused MODULE_ tags from non-modular code
>   mfd: syscon: Make it explicitly non-modular
>   mfd: tps65090: Make it explicitly non-modular
>   mfd: tps65910: Make it explicitly non-modular
>   mfd: tps80031: Make it explicitly non-modular
>   mfd: wm831x-spi: Make it explicitly non-modular
>   mfd: wm831x-i2c: Make it explicitly non-modular
>   mfd: wm831x-core: drop unused module infrastructure from non-modular code
>   mfd: wm8350-i2c: Make it explicitly non-modular
>   mfd: wm8350-core: drop unused module infrastructure from non-modular code
>   mfd: wm8400-core: Make it explicitly non-modular
> 
>  drivers/mfd/aat2870-core.c      | 40 +++-------------------------------------
>  drivers/mfd/adp5520.c           | 30 +++++++-----------------------
>  drivers/mfd/as3711.c            | 14 --------------
>  drivers/mfd/db8500-prcmu.c      | 10 ++++------
>  drivers/mfd/htc-i2cpld.c        | 18 +-----------------
>  drivers/mfd/max8925-core.c      |  7 +------
>  drivers/mfd/rc5t583.c           | 14 --------------
>  drivers/mfd/sta2x11-mfd.c       | 10 ++++------
>  drivers/mfd/syscon.c            | 12 +-----------
>  drivers/mfd/tps65090.c          | 30 +++++-------------------------
>  drivers/mfd/tps65910.c          | 18 +-----------------
>  drivers/mfd/tps80031.c          | 37 ++-----------------------------------
>  drivers/mfd/wm831x-core.c       | 15 ++-------------
>  drivers/mfd/wm831x-i2c.c        | 20 ++------------------
>  drivers/mfd/wm831x-spi.c        | 24 ++----------------------
>  drivers/mfd/wm8350-core.c       | 30 ++----------------------------
>  drivers/mfd/wm8350-i2c.c        | 24 +-----------------------
>  drivers/mfd/wm8400-core.c       | 18 +++---------------
>  include/linux/mfd/wm831x/core.h |  1 -
>  include/linux/mfd/wm8350/core.h |  1 -
>  20 files changed, 41 insertions(+), 332 deletions(-)

All applied!

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
