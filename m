Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbeBQQRi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 11:17:38 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35915 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeBQQRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 11:17:36 -0500
X-Google-Smtp-Source: AH8x226xlMX1vvewGwzs2K/YFQ0+RR0C9+KvqjQ0zlekWdzQGsGcqpMmFIjijLpXa2HH70IkDrsg+g==
Date: Sat, 17 Feb 2018 08:17:34 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com
Subject: Re: [v3,04/11] watchdog/hpwdt: white space changes
Message-ID: <20180217161734.GA671@roeck-us.net>
References: <20180215234400.5022-5-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215234400.5022-5-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 04:43:53PM -0700, Jerry Hoemann wrote:
> Minor white space changes and some name clean up.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>  drivers/watchdog/hpwdt.c | 49 +++++++++++++++++++++++-------------------------
>  1 file changed, 23 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 07810caabf74..d5989acf3e37 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -1,11 +1,9 @@
>  /*
>   *	HPE WatchDog Driver
> - *	based on
>   *
> - *	SoftDog	0.05:	A Software Watchdog Device
> - *
> - *	(c) Copyright 2015 Hewlett Packard Enterprise Development LP
> + *	(c) Copyright 2018 Hewlett Packard Enterprise Development LP
>   *	Thomas Mingarelli <thomas.mingarelli@hpe.com>
> + *	Jerry Hoemann <jerry.hoemann@hpe.com>
>   *
>   *	This program is free software; you can redistribute it and/or
>   *	modify it under the terms of the GNU General Public License
> @@ -53,7 +51,7 @@ static unsigned long __iomem *hpwdt_timer_con;
>  static const struct pci_device_id hpwdt_devices[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_COMPAQ, 0xB203) },	/* iLO2 */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_HP, 0x3306) },	/* iLO3 */
> -	{0},			/* terminate list */
> +	{0},						/* terminate list */
>  };
>  MODULE_DEVICE_TABLE(pci, hpwdt_devices);
>  
> @@ -102,7 +100,7 @@ static int hpwdt_time_left(void)
>  	return TICKS_TO_SECS(ioread16(hpwdt_timer_reg));
>  }
>  
> -#ifdef CONFIG_HPWDT_NMI_DECODING
> +#ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
>  static int hpwdt_my_nmi(void)
>  {
>  	return ioread8(hpwdt_nmistat) & 0x6;
> @@ -133,7 +131,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>  
>  	return NMI_HANDLED;
>  }
> -#endif /* CONFIG_HPWDT_NMI_DECODING */
> +#endif					/* } */

I disagree with those changes. While I don't object to adding the '{'
per se, I find it very useful to have the 'CONFIG_HPWDT_NMI_DECODING'
with an endif to be able to associate it with the matching #ifdef.

Deferring to Wim.

Guenter

>  
>  /*
>   *	/dev/watchdog handling
> @@ -198,11 +196,11 @@ static ssize_t hpwdt_write(struct file *file, const char __user *data,
>  	return len;
>  }
>  
> -static const struct watchdog_info ident = {
> -	.options = WDIOF_SETTIMEOUT |
> -		   WDIOF_KEEPALIVEPING |
> -		   WDIOF_MAGICCLOSE,
> -	.identity = "HPE iLO2+ HW Watchdog Timer",
> +static const struct watchdog_info hpwdt_info = {
> +	.options	= WDIOF_SETTIMEOUT    |
> +			  WDIOF_KEEPALIVEPING |
> +			  WDIOF_MAGICCLOSE,
> +	.identity	= "HPE iLO2+ HW Watchdog Timer",
>  };
>  
>  static long hpwdt_ioctl(struct file *file, unsigned int cmd,
> @@ -216,7 +214,7 @@ static long hpwdt_ioctl(struct file *file, unsigned int cmd,
>  	switch (cmd) {
>  	case WDIOC_GETSUPPORT:
>  		ret = 0;
> -		if (copy_to_user(argp, &ident, sizeof(ident)))
> +		if (copy_to_user(argp, &hpwdt_info, sizeof(hpwdt_info)))
>  			ret = -EFAULT;
>  		break;
>  
> @@ -313,7 +311,7 @@ static int hpwdt_init_nmi_decoding(struct pci_dev *dev)
>  	return 0;
>  
>  error2:
> -	unregister_nmi_handler(NMI_SERR, "hpwdt");
> +	unregister_nmi_handler(NMI_SERR,    "hpwdt");
>  error1:
>  	unregister_nmi_handler(NMI_UNKNOWN, "hpwdt");
>  error:
> @@ -327,15 +325,14 @@ static int hpwdt_init_nmi_decoding(struct pci_dev *dev)
>  
>  static void hpwdt_exit_nmi_decoding(void)
>  {
> -#ifdef CONFIG_HPWDT_NMI_DECODING
> -	unregister_nmi_handler(NMI_UNKNOWN, "hpwdt");
> -	unregister_nmi_handler(NMI_SERR, "hpwdt");
> +#ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
> +	unregister_nmi_handler(NMI_UNKNOWN,  "hpwdt");
> +	unregister_nmi_handler(NMI_SERR,     "hpwdt");
>  	unregister_nmi_handler(NMI_IO_CHECK, "hpwdt");
> -#endif
> +#endif					/* } */
>  }
>  
> -static int hpwdt_init_one(struct pci_dev *dev,
> -					const struct pci_device_id *ent)
> +static int hpwdt_probe(struct pci_dev *dev, const struct pci_device_id *ent)
>  {
>  	int retval;
>  
> @@ -422,10 +419,10 @@ static void hpwdt_exit(struct pci_dev *dev)
>  }
>  
>  static struct pci_driver hpwdt_driver = {
> -	.name = "hpwdt",
> -	.id_table = hpwdt_devices,
> -	.probe = hpwdt_init_one,
> -	.remove = hpwdt_exit,
> +	.name		= "hpwdt",
> +	.id_table	= hpwdt_devices,
> +	.probe		= hpwdt_probe,
> +	.remove		= hpwdt_exit,
>  };
>  
>  MODULE_AUTHOR("Tom Mingarelli");
> @@ -440,9 +437,9 @@ module_param(nowayout, bool, 0);
>  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>  		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
> -#ifdef CONFIG_HPWDT_NMI_DECODING
> +#ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
>  module_param(allow_kdump, int, 0);
>  MODULE_PARM_DESC(allow_kdump, "Start a kernel dump after NMI occurs");
> -#endif /* !CONFIG_HPWDT_NMI_DECODING */
> +#endif					/* } */
>  
>  module_pci_driver(hpwdt_driver);
