Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165383AbeE1NWZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:22:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:48036 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163327AbeE1NWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:22:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,452,1520924400";
   d="scan'208";a="51123573"
Message-ID: <22ae6822d3b1f4b0b73ceb25fd069ed9dd64fdf5.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/3] platform: x86: intel_cht_int33fe: Fix
 dependencies
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Darren Hart <dvhart@infradead.org>
Date: Mon, 28 May 2018 16:22:11 +0300
In-Reply-To: <20180523143758.66348-3-heikki.krogerus@linux.intel.com>
References: <20180523143758.66348-1-heikki.krogerus@linux.intel.com>
         <20180523143758.66348-3-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-23 at 17:37 +0300, Heikki Krogerus wrote:
> The driver will not probe unless bq24190 is loaded, so
> making it a dependency.
> 

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

assuming it will go through some other tree.

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/i2c/busses/Kconfig   | 3 +--
>  drivers/platform/x86/Kconfig | 4 ++--
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 99edffae27f6..4f8df2ec87b1 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -202,8 +202,7 @@ config I2C_CHT_WC
>  
>  	  Note this controller is hooked up to a TI bq24292i charger-
> IC,
>  	  combined with a FUSB302 Type-C port-controller as such it
> is advised
> -	  to also select CONFIG_CHARGER_BQ24190=m and
> CONFIG_TYPEC_FUSB302=m
> -	  (the fusb302 driver currently is in drivers/staging).
> +	  to also select CONFIG_TYPEC_FUSB302=m.
>  
>  config I2C_NFORCE2
>  	tristate "Nvidia nForce2, nForce3 and nForce4"
> diff --git a/drivers/platform/x86/Kconfig
> b/drivers/platform/x86/Kconfig
> index 566644bb496a..f27cb186437d 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -866,6 +866,7 @@ config ACPI_CMPC
>  config INTEL_CHT_INT33FE
>  	tristate "Intel Cherry Trail ACPI INT33FE Driver"
>  	depends on X86 && ACPI && I2C && REGULATOR
> +	depends on CHARGER_BQ24190=y || (CHARGER_BQ24190=m && m)
>  	---help---
>  	  This driver add support for the INT33FE ACPI device found
> on
>  	  some Intel Cherry Trail devices.
> @@ -877,8 +878,7 @@ config INTEL_CHT_INT33FE
>  	  i2c drivers for these chips can bind to the them.
>  
>  	  If you enable this driver it is advised to also select
> -	  CONFIG_TYPEC_FUSB302=m, CONFIG_CHARGER_BQ24190=m and
> -	  CONFIG_BATTERY_MAX17042=m.
> +	  CONFIG_TYPEC_FUSB302=m and CONFIG_BATTERY_MAX17042=m.
>  
>  config INTEL_INT0002_VGPIO
>  	tristate "Intel ACPI INT0002 Virtual GPIO driver"

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
