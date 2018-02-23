Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbeBWVkz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:40:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751455AbeBWVky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:40:54 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD3B205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Fri, 23 Feb 2018 15:40:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] pci: Re-use new dmi_get_bios_year() helper
Message-ID: <20180223214051.GN14632@bhelgaas-glaptop.roam.corp.google.com>
References: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
 <20180222125923.57385-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222125923.57385-4-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please use

  PCI: Re-use ...

to match the prevailing drivers/pci style.

On Thu, Feb 22, 2018 at 02:59:23PM +0200, Andy Shevchenko wrote:
> ...instead of open coding its functionality.

Same comment about making the changelog complete, independent of the
subject.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Let me know if you want me to take the series.  Otherwise I'll assume it
goes elsewhere.

> ---
>  drivers/pci/pci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f6a4dd10d9b0..ae654e21439d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2258,8 +2258,6 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
>   */
>  bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  {
> -	unsigned int year;
> -
>  	if (!pci_is_pcie(bridge))
>  		return false;
>  
> @@ -2287,10 +2285,8 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  		 * It should be safe to put PCIe ports from 2015 or newer
>  		 * to D3.
>  		 */
> -		if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) &&
> -		    year >= 2015) {
> +		if (dmi_get_bios_year() >= 2015)
>  			return true;
> -		}
>  		break;
>  	}
>  
> -- 
> 2.16.1
> 
