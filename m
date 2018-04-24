Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757024AbeDXKGP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 06:06:15 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47610 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756959AbeDXKGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 06:06:12 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Yu Chen <yu.c.chen@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Lee <robinlee.sysu@gmail.com>,
        Hans de Goede <jwrdegoede@fedoraproject.org>
Subject: Re: [PATCH] ACPI / PM: Blacklist Low Power S0 Idle _DSM for ThinkPad X1 Tablet(2016)
Date: Tue, 24 Apr 2018 12:06:01 +0200
Message-ID: <4652718.cogBrKaOA5@aspire.rjw.lan>
In-Reply-To: <20180410150751.31580-1-yu.c.chen@intel.com>
References: <20180410150751.31580-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 10, 2018 5:07:51 PM CEST Yu Chen wrote:
> From: Chen Yu <yu.c.chen@intel.com>
> 
> ThinkPad X1 Tablet(2016) is reported to have issues with
> the Low Power S0 Idle _DSM interface and since this machine
> model generally can do ACPI S3 just fine, and user would
> like to use S3 as default sleep model, add a blacklist
> entry to disable that interface for ThinkPad X1 Tablet(2016).
> 
> Reported-and-tested-by: Robin Lee <robinlee.sysu@gmail.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/acpi/sleep.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 46cde0912762..465f33aa0bd8 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -364,6 +364,19 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9360"),
>  		},
>  	},
> +	/*
> +	 * https://bugzilla.kernel.org/show_bug.cgi?id=199057
> +	 * ThinkPad X1 Tablet(2016) cannot do suspend-to-idle using the Low Power
> +	 * S0 Idle firmware interface.
> +	 */
> +	{
> +	.callback = init_no_lps0,
> +	.ident = "ThinkPad X1 Tablet(2016)",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "20GGA00L00"),
> +		},
> +	},
>  	{},
>  };
>  
> 

Applied, thanks!
