Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeCCMAQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 07:00:16 -0500
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:9700 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751663AbeCCMAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 07:00:14 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FRAADljZpamGOa6ERbGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQmgQAoCo1ujXqCAoEWaoY5jRGCFQqFMAKCYSE0GAECAQEBAQE?=
 =?us-ascii?q?BAgECEAEBAQEBCAsLBigugjgigkoBAQEBAzo/DAQCAQgRAwEBAQEeCQchJQkIA?=
 =?us-ascii?q?gQOBQiEewMVq0SHJw2BMIIrhSyCLoM9gy2CaoI+hWYEiCGSEDEJjUODMo8Cija?=
 =?us-ascii?q?HH4EuHoILcIMSgkEigWV3ixmBGAEBAQ?=
X-IPAS-Result: =?us-ascii?q?A2FRAADljZpamGOa6ERbGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?mgQAoCo1ujXqCAoEWaoY5jRGCFQqFMAKCYSE0GAECAQEBAQEBAgECEAEBAQEBC?=
 =?us-ascii?q?AsLBigugjgigkoBAQEBAzo/DAQCAQgRAwEBAQEeCQchJQkIAgQOBQiEewMVq0S?=
 =?us-ascii?q?HJw2BMIIrhSyCLoM9gy2CaoI+hWYEiCGSEDEJjUODMo8CijaHH4EuHoILcIMSg?=
 =?us-ascii?q?kEigWV3ixmBGAEBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.172
X-IronPort-AV: E=Sophos;i="5.47,417,1515477600";
   d="scan'208";a="1223529408"
X-DLP: DLP_GlobalPCIDSS
To: <dvhart@infradead.org>
CC: <andy.shevchenko@gmail.com>, <pali.rohar@gmail.com>,
        <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] platform/x86: dell-smbios: Link all dell-smbios-*
 modules together
Thread-Topic: [PATCH v3 3/3] platform/x86: dell-smbios: Link all dell-smbios-*
 modules together
Thread-Index: AQHTspTUlsja2+R4vkC/toflQeQBp6O+aF4A
Date: Sat, 3 Mar 2018 11:59:55 +0000
Message-ID: <2226b80b84734592bc8f4073ea12a9b2@ausx13mpc124.AMER.DELL.COM>
References: <1519755784-2155-1-git-send-email-mario.limonciello@dell.com>
 <1519755784-2155-3-git-send-email-mario.limonciello@dell.com>
 <20180303021042.GA11088@fury>
In-Reply-To: <20180303021042.GA11088@fury>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w23C0S7x017637

> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Friday, March 2, 2018 8:11 PM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>; pali.rohar@gmail.com; LKML
> <linux-kernel@vger.kernel.org>; platform-driver-x86@vger.kernel.org
> Subject: Re: [PATCH v3 3/3] platform/x86: dell-smbios: Link all dell-smbios-*
> modules together
> 
> On Tue, Feb 27, 2018 at 12:23:04PM -0600, Mario Limonciello wrote:
> > Some race conditions were raised due to dell-smbios and its backends
> > not being ready by the time that a consumer would call one of the
> > exported methods.
> >
> > To avoid this problem, guarantee that all initialization has been
> > done by linking them all together and running init for them all.
> >
> > As part of this change the Kconfig needs to be adjusted so that
> > CONFIG_DELL_SMBIOS_SMM and CONFIG_DELL_SMBIOS_WMI are boolean
> > rather than modules.
> >
> > CONFIG_DELL_SMBIOS is a visually selectable option again and both
> > CONFIG_DELL_SMBIOS_WMI and CONFIG_DELL_SMBIOS_SMM are optional.
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > ---
> > Changes from v2:
> >  * Move rest of #ifdef out of source files
> >  * Only compile units as necessary
> >
> >  drivers/platform/x86/Kconfig            | 11 ++++++++---
> >  drivers/platform/x86/Makefile           |  4 ++--
> >  drivers/platform/x86/dell-smbios-base.c | 21 ++++++++++++++++++++-
> >  drivers/platform/x86/dell-smbios-smm.c  | 18 ++++--------------
> >  drivers/platform/x86/dell-smbios-wmi.c  | 14 ++++----------
> >  drivers/platform/x86/dell-smbios.h      | 27 ++++++++++++++++++++++++++-
> >  6 files changed, 64 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > index 9a8f964..0c0897e 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -106,10 +106,15 @@ config ASUS_LAPTOP
> >  	  If you have an ACPI-compatible ASUS laptop, say Y or M here.
> >
> >  config DELL_SMBIOS
> > -	tristate
> > +	tristate "Dell SMBIOS driver"
> > +	---help---
> > +	This provides support for the Dell SMBIOS calling interface.
> > +	If you have a Dell computer you should enable this option.
> > +
> > +	Be sure to select at least one backend for it to work properly.
> >
> >  config DELL_SMBIOS_WMI
> > -	tristate "Dell SMBIOS calling interface (WMI implementation)"
> > +	bool "Dell SMBIOS driver WMI support"
> >  	depends on ACPI_WMI
> >  	select DELL_WMI_DESCRIPTOR
> >  	select DELL_SMBIOS
> 
> Blarg, this also violates the kconfig-language guidance for using select
> only for non-visible symbols with no dependencies.
> 
> I have a patch that works, but I don't love it. We can remove the prompt
> from DELL_SMBIOS, and make DELL_SMBIOS_WMI|SMM "depend on"
> DELL_SMBIOS.
> The options just appear sort of randomly when either DELL_LAPTOP or
> DELL_WMI are selected - but they can default to y, which is nice.
> 
> I have a subsequent patch which makes DELL_SMBIOS_WMI|SMM "depend on"
> DELL_LAPTOP, which makes this look a lot nicer. These just appear under
> DELL_LAPTOP as bool options. The problem with this approach is DELL_WMI
> also requires DELL_SMBIOS and DELL_WMI doesn't currently depend on
> DELL_LAPTOP. One option is to make it depend on DELL_LAPTOP as it seems
> unlikely for them to ever be used separately.  I don't love this either.
> Thoughts?
> 
> Perhaps the compromise is leave the DELL_SMBIOS prompt. This doesn't
> have the negative consequences the kconfig-languages is trying to guard
> against, and it makes it obvious what the DELL_SMBIOS_* options are -
> and we can still default them to y. See below.
> 
> This seems like it might be the least bad option at the moment. I'll
> keep thinking on it a bit...
> 
> From: "Darren Hart (VMware)" <dvhart@infradead.org>
> Date: Fri, 2 Mar 2018 17:40:32 -0800
> Subject: [PATCH] platform/x86: Allow for SMBIOS backend defaults
> 
> Avoid accidental configurations by setting default y for DELL_SMBIOS
> backends. Avoid this impacting the default build size, by making them
> dependent on DELL_SMBIOS, so they only appear when DELL_SMBIOS is
> manually selected, or by DELL_LAPTOP or DELL_WMI.
> 
> Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
> ---
>  drivers/platform/x86/Kconfig | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index e3f682c..022c837 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -115,9 +115,10 @@ config DELL_SMBIOS
> 
>  config DELL_SMBIOS_WMI
>  	bool "Dell SMBIOS driver WMI backend"
> +	default y
>  	depends on ACPI_WMI
>  	select DELL_WMI_DESCRIPTOR
> -	select DELL_SMBIOS
> +	depends on DELL_SMBIOS
>  	---help---
>  	This provides an implementation for the Dell SMBIOS calling interface
>  	communicated over ACPI-WMI.
> @@ -128,8 +129,9 @@ config DELL_SMBIOS_WMI
> 
>  config DELL_SMBIOS_SMM
>  	bool "Dell SMBIOS driver SMM backend"
> +	default y
>  	depends on DCDBAS
> -	select DELL_SMBIOS
> +	depends on DELL_SMBIOS
>  	---help---
>  	This provides an implementation for the Dell SMBIOS calling interface
>  	communicated over SMI/SMM.
> --
> 2.9.5
> 
> 

Ooph. I think the compromise of leaving the dell smbios prompt and sane defaults
behind extras is the best.
With it being a library now there shouldn't be a way for someone to break other
modules in unexpected ways.  Init will fail for dell-smbios and then nothing
else will be able to use it.
