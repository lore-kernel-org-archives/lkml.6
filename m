Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D432C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149592171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfA1UNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:13:18 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50667 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfA1UNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:13:18 -0500
X-Originating-IP: 86.202.150.119
Received: from localhost (lfbn-lyo-1-59-119.w86-202.abo.wanadoo.fr [86.202.150.119])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id EDEDF6000A;
        Mon, 28 Jan 2019 20:13:13 +0000 (UTC)
Date:   Mon, 28 Jan 2019 21:13:13 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        a.zummo@towertech.it, robh+dt@kernel.org, paul.burton@mips.com,
        mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
Subject: Re: [PATCH 3/3] RTC: Ingenic: Replace jz47xx with XBurst.
Message-ID: <20190128201313.GD18309@piout.net>
References: <1548696599-53639-1-git-send-email-zhouyanjie@zoho.com>
 <1548696599-53639-4-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548696599-53639-4-git-send-email-zhouyanjie@zoho.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/2019 01:29:59+0800, Zhou Yanjie wrote:
> Ingenic had changed their product code name.
> Latest SoCs had divided to several series such as
> T30/M200/X1000 and no longer called JZ47xx.
> 
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
> ---
>  drivers/rtc/Kconfig      |  4 ++--
>  drivers/rtc/rtc-jz4740.c | 15 +++------------
>  2 files changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 225b0b8..8b41853 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1576,10 +1576,10 @@ config RTC_DRV_MPC5121
>  	  will be called rtc-mpc5121.
>  
>  config RTC_DRV_JZ4740
> -	tristate "Ingenic JZ4740 SoC"
> +	tristate "Ingenic XBurst SoC"
>  	depends on MIPS || COMPILE_TEST
>  	help
> -	  If you say yes here you get support for the Ingenic JZ47xx SoCs RTC
> +	  If you say yes here you get support for the Ingenic XBurst SoCs RTC
>  	  controllers.
>  
>  	  This driver can also be built as a module. If so, the module
> diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
> index 0c7ae65..a262632 100644
> --- a/drivers/rtc/rtc-jz4740.c
> +++ b/drivers/rtc/rtc-jz4740.c
> @@ -1,17 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
>   *  Copyright (C) 2010, Paul Cercueil <paul@crapouillou.net>
> - *	 JZ4740 SoC RTC driver
> - *
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under  the terms of  the GNU General Public License as published by the
> - *  Free Software Foundation;  either version 2 of the License, or (at your
> - *  option) any later version.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
> - *

This change is unrelated.

> + *	Ingenic XBurst platform RTC support
>   */
>  
>  #include <linux/clk.h>
> @@ -450,5 +441,5 @@ module_platform_driver(jz4740_rtc_driver);
>  
>  MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
>  MODULE_LICENSE("GPL");
> -MODULE_DESCRIPTION("RTC driver for the JZ4740 SoC\n");
> +MODULE_DESCRIPTION("RTC driver for Ingenic XBurst platform\n");
>  MODULE_ALIAS("platform:jz4740-rtc");
> -- 
> 2.7.4
> 
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
