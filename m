Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CA5C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F5A20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfA3X6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:58:00 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50372 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfA3X6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:58:00 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id a39f7bed348ad6b3; Thu, 31 Jan 2019 00:57:57 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI / DPTF: remove header search path to the parent directory
Date:   Thu, 31 Jan 2019 00:56:49 +0100
Message-ID: <4055377.EWIQaDhOEO@aspire.rjw.lan>
In-Reply-To: <1548332163-17869-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548332163-17869-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 24, 2019 1:16:03 PM CET Masahiro Yamada wrote:
> It is too much to add extra header search path for all files in
> drivers/acpi/dptf/.
> 
> Fix up one C file, and remove the header search path.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> My main motivation is to get rid of crappy header search path manipulation
> from Kbuild core.
> 
> Before that, I want to clean up as many useless paths as possible.
> 
> The full work of this is available at:
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git build-test
> 
> 
>  drivers/acpi/dptf/Makefile          | 2 --
>  drivers/acpi/dptf/int340x_thermal.c | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/dptf/Makefile b/drivers/acpi/dptf/Makefile
> index 06ea880..e6032e4 100644
> --- a/drivers/acpi/dptf/Makefile
> +++ b/drivers/acpi/dptf/Makefile
> @@ -1,4 +1,2 @@
>  obj-$(CONFIG_ACPI)             += int340x_thermal.o
>  obj-$(CONFIG_DPTF_POWER)	+= dptf_power.o
> -
> -ccflags-y += -Idrivers/acpi
> diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
> index 8636409..0aa7c2e 100644
> --- a/drivers/acpi/dptf/int340x_thermal.c
> +++ b/drivers/acpi/dptf/int340x_thermal.c
> @@ -12,7 +12,7 @@
>  #include <linux/acpi.h>
>  #include <linux/module.h>
>  
> -#include "internal.h"
> +#include "../internal.h"
>  
>  #define INT3401_DEVICE 0X01
>  static const struct acpi_device_id int340x_thermal_device_ids[] = {
> 

Applied, thanks!


