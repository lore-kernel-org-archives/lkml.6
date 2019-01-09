Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C904C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765BC21848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfAIKsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:48:42 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63384 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfAIKsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:48:42 -0500
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 5f78d8957010fbd6; Wed, 9 Jan 2019 11:48:39 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sinan Kaya <okaya@kernel.org>, Andy Shevchenko <andy@infradead.org>
Cc:     linux-next@vger.kernel.org, linux-acpi@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/11] platform/x86: intel_pmc: Make PCI dependency explicit
Date:   Wed, 09 Jan 2019 11:47:54 +0100
Message-ID: <3184241.VH7flF4h5P@aspire.rjw.lan>
In-Reply-To: <20190105100606.6673-6-okaya@kernel.org>
References: <20190105100606.6673-1-okaya@kernel.org> <20190105100606.6673-6-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, January 5, 2019 11:06:00 AM CET Sinan Kaya wrote:
> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly. Code relies on PCI for execution. Specify this
> in the Kconfig.
> 
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/platform/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index b36ea14b41ad..7afb96cb1cd6 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1174,7 +1174,7 @@ config INTEL_SMARTCONNECT
>  
>  config INTEL_PMC_IPC
>  	tristate "Intel PMC IPC Driver"
> -	depends on ACPI
> +	depends on ACPI && PCI
>  	---help---
>  	This driver provides support for PMC control on some Intel platforms.
>  	The PMC is an ARC processor which defines IPC commands for communication

Andy, you had some reservations regarding this patch IIRC.

Should I apply it?

