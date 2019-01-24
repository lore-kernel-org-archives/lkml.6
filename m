Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CB4C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21D721855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfAXKx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:53:59 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56191 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfAXKx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:53:59 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 21f0854ecca4404c; Thu, 24 Jan 2019 11:53:56 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sinan Kaya <okaya@kernel.org>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     linux-next@vger.kernel.org, linux-acpi@vger.kernel.org,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [for next][PATCH 1/2] platform/x86: Fix unmet dependency warning for ACPI_CMPC
Date:   Thu, 24 Jan 2019 11:52:57 +0100
Message-ID: <3681650.SPxszaOeRQ@aspire.rjw.lan>
In-Reply-To: <20190121224644.26903-1-okaya@kernel.org>
References: <20190121224644.26903-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 21, 2019 11:46:43 PM CET Sinan Kaya wrote:
> Add BACKLIGHT_LCD_SUPPORT for ACPI_CMPC to fix the
> warning: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE.
> 
> ACPI_CMPC selects BACKLIGHT_LCD_SUPPORT but BACKLIGHT_LCD_SUPPORT
> depends on BACKLIGHT_LCD_SUPPORT.
> 
> Copy this dependency into ACPI_CMPC.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/platform/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 5e2109c54c7c..b84c2c5b6684 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -904,7 +904,7 @@ config TOSHIBA_WMI
>  
>  config ACPI_CMPC
>  	tristate "CMPC Laptop Extras"
> -	depends on ACPI && INPUT
> +	depends on ACPI && INPUT && BACKLIGHT_LCD_SUPPORT
>  	depends on RFKILL || RFKILL=n
>  	select BACKLIGHT_CLASS_DEVICE
>  	help
> 

Andy/Darren, these two seem to be for you, but I can take them too as
related to ACPI tagentially, so please let me know.

