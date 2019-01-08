Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BE9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFA92087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfAHI3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:29:18 -0500
Received: from shell.v3.sk ([90.176.6.54]:47726 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbfAHI3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:29:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9A18FFFE99;
        Tue,  8 Jan 2019 09:29:13 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jJf6GhD-fEXz; Tue,  8 Jan 2019 09:29:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D0ACBFFF72;
        Tue,  8 Jan 2019 09:29:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g-RMr4E43fl6; Tue,  8 Jan 2019 09:29:09 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C4244FFE99;
        Tue,  8 Jan 2019 09:29:08 +0100 (CET)
Message-ID: <04e606dd8551bdf71d3b79b12aed46d1ad5157b6.camel@v3.sk>
Subject: Re: [PATCH v3 03/16] Revert "platform/olpc: Make ec explicitly
 non-modular"
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org
Cc:     James Cameron <quozl@laptop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, x86@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 08 Jan 2019 09:29:07 +0100
In-Reply-To: <20190107183439.50626-4-lkundrak@v3.sk>
References: <20190107183439.50626-1-lkundrak@v3.sk>
         <20190107183439.50626-4-lkundrak@v3.sk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-07 at 19:34 +0100, Lubomir Rintel wrote:
> It doesn't make sense to always have this built-in, e.g. on ARM
> multiplatform kernels.
> 
> A better way to address the problem the original commit aimed to solve is
> to fix Kconfig. That is what the next commit in the series does.
> 
> This reverts commit f48d1496b8537d75776478c6942dd87f34d7f270.

The kBuild but figured out that this is not such a great idea.

I'm going to follow-up with a new patch set; sorry for the noise.

> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - Sort it later in the patch set
> 
>  drivers/platform/olpc/olpc-ec.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
> index 981955dce926..35a21c66cd0d 100644
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
>  
> @@ -327,4 +325,8 @@ static int __init olpc_ec_init_module(void)
>  {
>  	return platform_driver_register(&olpc_ec_plat_driver);
>  }
> +
>  arch_initcall(olpc_ec_init_module);
> +
> +MODULE_AUTHOR("Andres Salomon <dilinger@queued.net>");
> +MODULE_LICENSE("GPL");

