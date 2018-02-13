Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965499AbeBMRt4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:49:56 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46816 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965260AbeBMRtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:49:52 -0500
X-Google-Smtp-Source: AH8x225kKxHbY4exEkEqQkahEQbM909J4HBWr8f4NYg+BeXvx7mK1t1O3t9T0tg7yQgcqhfIt6G2BA==
Date: Tue, 13 Feb 2018 09:49:50 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com
Subject: Re: [PATCH v2 05/11] watchdog/hpwdt: Update Module info.
Message-ID: <20180213174950.GC22401@roeck-us.net>
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
 <20180212052111.12010-6-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212052111.12010-6-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 10:21:05PM -0700, Jerry Hoemann wrote:
> Update Module Author and permission on parameters so that the
> parameters show up in sysfs.
> 

Does it really add value to see the module parameters in sysfs ?
You would get both in standardized form by enabling WATCHDOG_SYSFS.

> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>  drivers/watchdog/hpwdt.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index ee9a92220ece..dead59f9ca80 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -432,20 +432,20 @@ static struct pci_driver hpwdt_driver = {
>  	.remove		= hpwdt_exit,
>  };
>  
> -MODULE_AUTHOR("Tom Mingarelli");
> -MODULE_DESCRIPTION("hp watchdog driver");
> +MODULE_AUTHOR("Jerry Hoemann");
> +MODULE_DESCRIPTION("hpe watchdog driver");
>  MODULE_LICENSE("GPL");
>  MODULE_VERSION(HPWDT_VERSION);
>  
> -module_param(soft_margin, int, 0);
> +module_param(soft_margin, int, 0444);
>  MODULE_PARM_DESC(soft_margin, "Watchdog timeout in seconds");
>  
> -module_param(nowayout, bool, 0);
> +module_param(nowayout, bool, 0444);
>  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>  		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
>  #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
> -module_param(allow_kdump, int, 0);
> +module_param(allow_kdump, int, 0444);
>  MODULE_PARM_DESC(allow_kdump, "Start a kernel dump after NMI occurs");
>  #endif					/* } */
>  
> -- 
> 2.13.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
