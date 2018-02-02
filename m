Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeBBJ2i convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 04:28:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:40423 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750773AbeBBJ2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 04:28:24 -0500
Date: Fri, 2 Feb 2018 08:00:27 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <mnhu@prevas.dk>
Cc: <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] firmware: dmi_scan: avoid printing error on non-efi
 systems
Message-ID: <20180202080027.36a7f102@endymion>
In-Reply-To: <20180201080805.8076-1-mnhu@prevas.dk>
References: <20180201080805.8076-1-mnhu@prevas.dk>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Thu, 1 Feb 2018 09:08:05 +0100, Martin Hundebøll wrote:
> dmi_init() rightfully checks if dmi is available at all, and errors out
> if not. This leads to harmless errors being printed during boot on
> non-efi systems, even when these are booted quietly.
> 
> Avoid this error-print by returning directly from dmi_init() if dmi
> isn't available, instead of jumping to the err-label.
> 
> Signed-off-by: Martin Hundebøll <mnhu@prevas.dk>
> ---
>  drivers/firmware/dmi_scan.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index 783041964439..86c5e0625a08 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -715,10 +715,8 @@ static int __init dmi_init(void)
>  	u8 *dmi_table;
>  	int ret = -ENOMEM;
>  
> -	if (!dmi_available) {
> -		ret = -ENODATA;
> -		goto err;
> -	}
> +	if (!dmi_available)
> +		return -ENODATA;
>  
>  	/*
>  	 * Set up dmi directory at /sys/firmware/dmi. This entry should stay

I already have a similar patch by Ard Biesheuvel in my dmi tree:

http://jdelvare.nerim.net/devel/linux/jdelvare-dmi/firmware-dmi-handle-missing-dmi-data-gracefully.patch

Does it work for you?

I'll send a pull request to Linus later today.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
