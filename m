Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbeBQQVe (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 11:21:34 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43700 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbeBQQVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 11:21:32 -0500
X-Google-Smtp-Source: AH8x224iXYB4WvaR+U/cMKahvmL8kwVDciIqDGRo0kFhYwmvczzvFQrJk9vzPlpQVWFCmF+CpW0xIA==
Date: Sat, 17 Feb 2018 08:21:30 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com
Subject: Re: [v3,06/11] watchdog/hpwdt: Select WATCHDOG_CORE
Message-ID: <20180217162130.GA30748@roeck-us.net>
References: <20180215234400.5022-7-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215234400.5022-7-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 04:43:55PM -0700, Jerry Hoemann wrote:
> Update Kconfig file to show that hpwdt now selects WATCHDOG_CORE.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

At this point, WATCHDOG_CORE is not required. This patch should
be merged with the next patch, which adds the requirement.

Since it appears that you insist on having it as separate patch,
deferring to Wim.

Guenter

> ---
>  drivers/watchdog/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 6a602f70aaa4..4d219c3fa8b4 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1108,6 +1108,7 @@ config IT87_WDT
>  
>  config HP_WATCHDOG
>  	tristate "HP ProLiant iLO2+ Hardware Watchdog Timer"
> +	select WATCHDOG_CORE
>  	depends on X86 && PCI
>  	help
>  	  A software monitoring watchdog and NMI sourcing driver. This driver
