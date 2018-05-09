Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933941AbeEIJye (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:54:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56401 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933810AbeEIJyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:54:32 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Laszlo Toth <laszlth@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: add missing newline to printk
Date: Wed, 09 May 2018 11:54:06 +0200
Message-ID: <89768760.ar4GnIqtnF@aspire.rjw.lan>
In-Reply-To: <20180410171038.GA4189@laszlth>
References: <20180410171038.GA4189@laszlth>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 10, 2018 7:10:38 PM CEST Laszlo Toth wrote:
> ...and restore reverse xmas tree while at it.
> 
> Signed-off-by: Laszlo Toth <laszlth@gmail.com>
> ---
>  drivers/acpi/reboot.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
> index 71769fd..6fa9c2a 100644
> --- a/drivers/acpi/reboot.c
> +++ b/drivers/acpi/reboot.c
> @@ -8,8 +8,8 @@ void acpi_reboot(void)
>  {
>  	struct acpi_generic_address *rr;
>  	struct pci_bus *bus0;
> -	u8 reset_value;
>  	unsigned int devfn;
> +	u8 reset_value;
>  
>  	if (acpi_disabled)
>  		return;
> @@ -40,7 +40,7 @@ void acpi_reboot(void)
>  		/* Form PCI device/function pair. */
>  		devfn = PCI_DEVFN((rr->address >> 32) & 0xffff,
>  				  (rr->address >> 16) & 0xffff);
> -		printk(KERN_DEBUG "Resetting with ACPI PCI RESET_REG.");
> +		printk(KERN_DEBUG "Resetting with ACPI PCI RESET_REG.\n");
>  		/* Write the value that resets us. */
>  		pci_bus_write_config_byte(bus0, devfn,
>  				(rr->address & 0xffff), reset_value);
> 

Applied, thanks!
