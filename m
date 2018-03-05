Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932544AbeCEXDz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 18:03:55 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41464 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbeCEXDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 18:03:53 -0500
X-Google-Smtp-Source: AG47ELtDMWe+CScMeBuhrBGjaZRweKhl2rY4qVnkuJfQKxZysWgE+VwcZ0BPPvzsi5xf/lkokxz+Hw==
Date: Mon, 5 Mar 2018 15:03:50 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>
Cc: linux-hwmon@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] k10temp support for AMD Ryzen w/ Vega gfx
Message-ID: <20180305230350.GA13099@roeck-us.net>
References: <1769691A-DD1D-4641-B7BA-62C1BA571EBF@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1769691A-DD1D-4641-B7BA-62C1BA571EBF@exactcode.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 11:38:24PM +0100, René Rebe wrote:
> Hi,
> 
> This enables k10temp for the new AMD Ryzen APUs w/ Vega Mobile Gfx.
> Tested on Ryzen 5 2500U, the temperature looked plausible.
> 
>   Signed-off-by: René Rebe <rene@exactcode.de>
> 
> PS: 1st RFC - might get white-space damaged, will resend when ACKed.
> Sorry my Xemacs/Mew broke.
> 
> --- linux-4.15/drivers/hwmon/k10temp.c.vanilla	2018-03-05 22:22:30.974331180 +0000
> +++ linux-4.15/drivers/hwmon/k10temp.c	2018-03-05 22:24:17.186327291 +0000
> @@ -40,6 +40,10 @@
>  #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
>  #endif
>  
> +#ifndef PCI_DEVICE_ID_AMD_17H_RR_NB
> +#define PCI_DEVICE_ID_AMD_17H_RR_NB	0x15d0
> +#endif
> +
>  /* CPUID function 0x80000001, ebx */
>  #define CPUID_PKGTYPE_MASK	0xf0000000
>  #define CPUID_PKGTYPE_F		0x00000000
> @@ -89,6 +93,8 @@
>  	{ 0x17, "AMD Ryzen Threadripper 1950", 10000 },
>  	{ 0x17, "AMD Ryzen Threadripper 1920", 10000 },
>  	{ 0x17, "AMD Ryzen Threadripper 1910", 10000 },
> +	{ 0x17, "AMD Ryzen 5 2500U with Radeon Vega Mobile Gfx", 20000 },
> +	{ 0x17, "AMD Ryzen 7 2700U with Radeon Vega Mobile Gfx", 20000 },

Do you have a confirmation that the temperature offset is correct ?

Thanks,
Guenter

>  };
>  
>  static void read_tempreg_pci(struct pci_dev *pdev, u32 *regval)
> @@ -289,6 +2944,7 @@
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_RR_NB) },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(pci, k10temp_id_table);
> 
> -- 
>  ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
>  http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t2-project.org | http://rene.rebe.de
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
