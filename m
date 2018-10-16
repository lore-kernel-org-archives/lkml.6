Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE315C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927E2205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927E2205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeJPQ7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:59:38 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58884 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeJPQ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:59:38 -0400
Received: from 79.184.253.168.ipv4.supernova.orange.pl (79.184.253.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 0d9efdea69ec43c1; Tue, 16 Oct 2018 11:10:08 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: remove redundant 'default n' from Kconfig
Date:   Tue, 16 Oct 2018 11:06:55 +0200
Message-ID: <3043377.xZJKtzU3Ct@aspire.rjw.lan>
In-Reply-To: <20181010144131eucas1p1974d23e4f09a49ed772575b9cc3770da~cRlJN49vs2486624866eucas1p1i@eucas1p1.samsung.com>
References: <CGME20181010144131eucas1p1974d23e4f09a49ed772575b9cc3770da@eucas1p1.samsung.com> <20181010144131eucas1p1974d23e4f09a49ed772575b9cc3770da~cRlJN49vs2486624866eucas1p1i@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, October 10, 2018 4:41:30 PM CEST Bartlomiej Zolnierkiewicz wrote:
> 'default n' is the default value for any bool or tristate Kconfig
> setting so there is no need to write it explicitly.
> 
> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> is not set' for visible symbols") the Kconfig behavior is the same
> regardless of 'default n' being present or not:
> 
>     ...
>     One side effect of (and the main motivation for) this change is making
>     the following two definitions behave exactly the same:
>     
>         config FOO
>                 bool
>     
>         config FOO
>                 bool
>                 default n
>     
>     With this change, neither of these will generate a
>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
>     That might make it clearer to people that a bare 'default n' is
>     redundant.
>     ...
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/acpi/Kconfig |    6 ------
>  1 file changed, 6 deletions(-)
> 
> Index: b/drivers/acpi/Kconfig
> ===================================================================
> --- a/drivers/acpi/Kconfig	2018-09-26 15:54:31.942819766 +0200
> +++ b/drivers/acpi/Kconfig	2018-10-10 16:38:09.691897907 +0200
> @@ -138,7 +138,6 @@ config ACPI_REV_OVERRIDE_POSSIBLE
>  
>  config ACPI_EC_DEBUGFS
>  	tristate "EC read/write access through /sys/kernel/debug/ec"
> -	default n
>  	help
>  	  Say N to disable Embedded Controller /sys/kernel/debug interface
>  
> @@ -283,7 +282,6 @@ config ACPI_PROCESSOR
>  config ACPI_IPMI
>  	tristate "IPMI"
>  	depends on IPMI_HANDLER
> -	default n
>  	help
>  	  This driver enables the ACPI to access the BMC controller. And it
>  	  uses the IPMI request/response message to communicate with BMC
> @@ -361,7 +359,6 @@ config ACPI_TABLE_UPGRADE
>  
>  config ACPI_DEBUG
>  	bool "Debug Statements"
> -	default n
>  	help
>  	  The ACPI subsystem can produce debug output.  Saying Y enables this
>  	  output and increases the kernel size by around 50K.
> @@ -374,7 +371,6 @@ config ACPI_DEBUG
>  config ACPI_PCI_SLOT
>  	bool "PCI slot detection driver"
>  	depends on SYSFS
> -	default n
>  	help
>  	  This driver creates entries in /sys/bus/pci/slots/ for all PCI
>  	  slots in the system.  This can help correlate PCI bus addresses,
> @@ -436,7 +432,6 @@ config ACPI_HED
>  config ACPI_CUSTOM_METHOD
>  	tristate "Allow ACPI methods to be inserted/replaced at run time"
>  	depends on DEBUG_FS
> -	default n
>  	help
>  	  This debug facility allows ACPI AML methods to be inserted and/or
>  	  replaced without rebooting the system. For details refer to:
> @@ -481,7 +476,6 @@ config ACPI_EXTLOG
>  	tristate "Extended Error Log support"
>  	depends on X86_MCE && X86_LOCAL_APIC && EDAC
>  	select UEFI_CPER
> -	default n
>  	help
>  	  Certain usages such as Predictive Failure Analysis (PFA) require
>  	  more information about the error than what can be described in
> 

Applied, thanks!


