Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E951C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00634208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DKUdbT6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00634208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933096AbeGIW1w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:27:52 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36169 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932949AbeGIW1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:27:50 -0400
Received: by mail-io0-f196.google.com with SMTP id k3-v6so18527096iog.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 15:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tmGwaax75hEXlAIj+SruvPyzbEnv0/uJBmnxetNMwDY=;
        b=DKUdbT6SlxMKGeuQZrZqAiSBSBSvyQZmTu/BBdCOvB8KmQK63TqLLi9EJPvn+zoIDK
         StIgUqc9uS/Aq9IGgo5/ixt6CbI0JBuhwL+E2BhwINOFl5UEO5jmRUHIlVUbUbBcONDA
         ie6O4/Kd2ld+FcDF18CWX6pww3ZJarKRN6tYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tmGwaax75hEXlAIj+SruvPyzbEnv0/uJBmnxetNMwDY=;
        b=KlJN7wFPtZEtnlTobi3H5M65IwZVS7gGkTAeTKdpBkGT9fqLLQHAZuhYYSmyAtubXI
         lnengyWhWvJc5VlRJU6vJ5kI7z0MvHJoUIVVz59SFlzyTLtJgb5xpo6IrqiytgowwhZC
         EcBZZe8TfrEsR5/gfX9CJg+sTowNTub25m1vY2fJdebQn88syjFeNg70wZfxuXh7EDU7
         ice/nA+s+siKHajl655Ve6bd2uGb/heHdSbd+cVApvdu7ghrYsEUPQHsD21J5tC4IR2A
         AMzsmaYGKXxfilc4T9mjmGEIQyWlBt+oyd8+qVJV1155s7AgSJIZcU/k0TC/51nn8hSS
         4CBQ==
X-Gm-Message-State: APt69E0WOJ4EYOJtr+O+mK2wCvMQkxhyRnOxSKBTVzC5WIDzENVaqj8I
        IPo7gjTKLVgtdl55j9TRX2IAURDqMKIWyC/V+c7hVw==
X-Google-Smtp-Source: AAOMgpccGdzI9knWNwEbdygzaGpAeh8QlSJl2TtODJLfeDWKJToEGSa40Ucjm80xhkjJ5EPzlWeFml5ckByPSJlQBOI=
X-Received: by 2002:a6b:e403:: with SMTP id u3-v6mr18061792iog.131.1531175269985;
 Mon, 09 Jul 2018 15:27:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 15:27:49 -0700 (PDT)
In-Reply-To: <ab0c7997bdb0caf6fe7e842315bb9565c2cb059d.1530895248.git.leonard.crestez@nxp.com>
References: <ab0c7997bdb0caf6fe7e842315bb9565c2cb059d.1530895248.git.leonard.crestez@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Jul 2018 00:27:49 +0200
Message-ID: <CAPDyKFqb6eZ2SYG612yqiNisv7UV1q3UHYfZfemmvv9Q4w=Png@mail.gmail.com>
Subject: Re: [PATCH v3] soc: imx: gpc: Turn PU domain on/off in sleep on 6qp
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 July 2018 at 18:46, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> On imx6qp power gating on the PU domain is disabled because of errata
> ERR009619. However power gating during suspend/resume can still be
> performed.

Sounds a bit hand wavy. Exactly why can it be done during system suspend/resume?

>
> Enable this by implementing SLEEP_PM_OPS in imx_pgc_power_domain_driver.
>
> In order to ensure correct ordering add device links from devices inside
> the PU domain to the pgc platform_device.

In genpd, the PM domain gets powered off after all device's
corresponding ->suspend_noirq() callback has been invoked - and it
also considers if there are some wakeup settings enabled, possibly
avoiding to do the power off.

It sound like the imx's power domain driver ->power_off|on() callback
should deal with this, to make get a consistent behavior. I understand
that you currently can't tell under what circumstances the
->power_off|on() callbacks are being invoked, that may need some
changes in genpd.

Currently we have a flag, GENPD_FLAG_ALWAYS_ON which makes genpd to
always prevent power off. Perhaps we should add a new flag
"GENPD_FLAG_RUNTIME_ON", which makes genpd to call the
->power_on|off() callbacks, but only during system wide PM.

Thoughts?

[...]

Kind regards
Uffe
