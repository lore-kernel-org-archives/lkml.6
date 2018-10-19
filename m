Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856AEECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB0520644
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY0T9+4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB0520644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeJSVKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:10:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35939 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeJSVKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:10:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id u34-v6so38126230qth.3;
        Fri, 19 Oct 2018 06:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oylsM2zK6/l3A+PXXsb1ZIpUQ35rMzTgyxoyXHPqRLA=;
        b=gY0T9+4JvnxXQsUxQHurAxo96O4u0FERd6ehsEoQth7m2l+DIf9xJQUPmzAfCJYumC
         QwPukLbV++0zK/Ak7SccKBlUSlWmerLLEhp2BpqEfVK/5FWnppkBDtnvktcpEBqJdISu
         yOYN+ktmts+UMybKKOVUB85y7IAKbDWNlfxIE2Xv6dz1M2DvtaS7kJIjFuAtQ7wr7uMm
         GA7PYQQOK1LQnmKVZzyjigT9CreG6lDACDBtLrhxxAqGZ3qzlGBdvGCgTxf/rNwJzQvb
         yt2gsHzJOhKMHSCRwspa9MONNQdVK6JGNv1MEnCSnGRvgoZphPwEKDyZe+rxsfnk49t0
         9BmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oylsM2zK6/l3A+PXXsb1ZIpUQ35rMzTgyxoyXHPqRLA=;
        b=S4mdX/wwweqfN4uAFkTLFisCWn3Kx/mG12yFwPsaHQFpJpNerE8QnqXEajnAYKL/FC
         61py8WU2lt9b65D2dqXXtMEJE+61XYDGv6Zgo5kGbgK9e/UPgmHHj+6lyN9p61QNHnUZ
         zl0Bx6Sr80sc/e75eW5dv87A6SW92K3oyKLV/6pMNgBDJydq+N0RfT3duV7RSVT6t7+r
         DTdB+gnhC3z7l1qqOfACVTLeqM7z79pmTp+nqCM2N2cBcJzGYHmKrekRBkyCpwY3lmvS
         45wPEEB98K4jGzqkikKQmUdCwZ92EV8K/IuXYDLjj8euAluoq41YuscX9l+DBFERkAZI
         4lsg==
X-Gm-Message-State: ABuFfojPcC6MrZtTMHbKIFp2KRMPVCt2fbt6kEmGsAv7PFZ18s63gefO
        zsJowbuDW7rpVCmhRk0eIyqGxKMFiteRwpQ6VUs=
X-Google-Smtp-Source: ACcGV61P4bGsVm0DdogMOICDNaYYhBzqohuFy3378RAKqMR7f+WIoLNTPOmk26dxkY4gJi+wFfmKy0W8T5aoPsRTgvg=
X-Received: by 2002:ac8:2413:: with SMTP id c19-v6mr32532192qtc.194.1539954268123;
 Fri, 19 Oct 2018 06:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181010172300.317643-1-lkundrak@v3.sk> <20181010172300.317643-3-lkundrak@v3.sk>
In-Reply-To: <20181010172300.317643-3-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 16:04:17 +0300
Message-ID: <CAHp75Vfrna+htxyDQmmUnyoP3Q=61WWF0LYWNWpNjfScwX2irg@mail.gmail.com>
Subject: Re: [PATCH 02/15] Revert "platform/olpc: Make ec explicitly non-modular"
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> It doesn't make sense to always have this built-in, e.g. on ARM
> multiplatform kernels. A better way to address the problem the original
> commit aimed to solve is to fix Kconfig.
>
> This reverts commit f48d1496b8537d75776478c6942dd87f34d7f270.
>

This change doesn't make any sense when put in _this_ order in the series.

First, you need to show the CONFIG_OLPC as tristate, which doesn't (Am
I missing something?).

> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/platform/olpc/olpc-ec.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
> index 374a8028fec7..f99b183d5296 100644
> --- a/drivers/platform/olpc/olpc-ec.c
> +++ b/drivers/platform/olpc/olpc-ec.c
> @@ -1,8 +1,6 @@
>  /*
>   * Generic driver for the OLPC Embedded Controller.
>   *
> - * Author: Andres Salomon <dilinger@queued.net>
> - *
>   * Copyright (C) 2011-2012 One Laptop per Child Foundation.
>   *
>   * Licensed under the GPL v2 or later.
> @@ -14,7 +12,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
> -#include <linux/init.h>
> +#include <linux/module.h>
>  #include <linux/list.h>
>  #include <linux/olpc-ec.h>
>  #include <asm/olpc.h>
> @@ -328,4 +326,8 @@ static int __init olpc_ec_init_module(void)
>  {
>         return platform_driver_register(&olpc_ec_plat_driver);
>  }
> +
>  arch_initcall(olpc_ec_init_module);
> +
> +MODULE_AUTHOR("Andres Salomon <dilinger@queued.net>");
> +MODULE_LICENSE("GPL");
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
