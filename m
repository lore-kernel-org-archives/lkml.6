Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965081AbeCCBso (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 20:48:44 -0500
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:64462 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965064AbeCCBsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 20:48:42 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EyAAA3/plamD+a6ERcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQmgQAoCo1tjXqCAoEWhyGNDIIVCoUwAoJhITQYAQIBAQEBAQE?=
 =?us-ascii?q?CAQIQAQEBAQEICwsGKC6COCKCSgEBAQEDOj8MBAIBCBEEAQEBHgkHISUJCAIED?=
 =?us-ascii?q?gUIhHsDFaxWhyoNgTCCK4UsgimDPYMtgmqCPkWFIQSIH5IOMQmNQYMyjwKKNYc?=
 =?us-ascii?q?ggS4eggtwgxKCQSKBZXeLCYEYAQEB?=
X-IPAS-Result: =?us-ascii?q?A2EyAAA3/plamD+a6ERcGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?mgQAoCo1tjXqCAoEWhyGNDIIVCoUwAoJhITQYAQIBAQEBAQECAQIQAQEBAQEIC?=
 =?us-ascii?q?wsGKC6COCKCSgEBAQEDOj8MBAIBCBEEAQEBHgkHISUJCAIEDgUIhHsDFaxWhyo?=
 =?us-ascii?q?NgTCCK4UsgimDPYMtgmqCPkWFIQSIH5IOMQmNQYMyjwKKNYcggS4eggtwgxKCQ?=
 =?us-ascii?q?SKBZXeLCYEYAQEB?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.189
X-IronPort-AV: E=Sophos;i="5.47,414,1515477600";
   d="scan'208";a="1110133376"
X-DLP: DLP_GlobalPCIDSS
To: <dvhart@infradead.org>
CC: <andy.shevchenko@gmail.com>, <pali.rohar@gmail.com>,
        <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] platform/x86: dell-smbios: Link all dell-smbios-*
 modules together
Thread-Topic: [PATCH v3 3/3] platform/x86: dell-smbios: Link all dell-smbios-*
 modules together
Thread-Index: AQHTsoWWlsja2+R4vkC/toflQeQBp6O9vmHA
Date: Sat, 3 Mar 2018 01:48:40 +0000
Message-ID: <28c6c11b71774cd8921d188194d86344@ausx13mpc124.AMER.DELL.COM>
References: <1519755784-2155-1-git-send-email-mario.limonciello@dell.com>
 <1519755784-2155-3-git-send-email-mario.limonciello@dell.com>
 <20180303002135.GD25613@fury>
In-Reply-To: <20180303002135.GD25613@fury>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w231mq8d013288



> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Friday, March 2, 2018 6:22 PM
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
> 
> Would you be happy with using "backend" here and for SMM?
> 
> 	bool "Dell SMBIOS driver WMI backend"
> 
> It makes it obvious what the help text is referring to by "select at
> least one backend".
> 
> Happy to just make this change locally, no need to resubmit.
> 

Yeah, fine by me.

Thanks,
