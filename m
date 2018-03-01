Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161742AbeCAUyi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 15:54:38 -0500
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:59083 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161577AbeCAUyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 15:54:36 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EyAADoZ5hah2Oa6EReGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQmgQAoCo1tjXiCAoEWhyGNC4IVCoUwAoJeITQYAQIBAQEBAQE?=
 =?us-ascii?q?CAQIQAQEBCgsJCCgugjgigkoBAQEEOj8MBAIBCBEEAQEBHgkHISUJCAIEDgUIh?=
 =?us-ascii?q?HsDFa0VhywNgTCCK4UmgieDPYMtgmqCFwEBJYVmBIgXB4cRinkwCYljg12DMY5?=
 =?us-ascii?q?/ijSHH4EuHoILcIMSgjEQDBaBZXeKN4EigRcBAQE?=
X-IPAS-Result: =?us-ascii?q?A2EyAADoZ5hah2Oa6EReGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?mgQAoCo1tjXiCAoEWhyGNC4IVCoUwAoJeITQYAQIBAQEBAQECAQIQAQEBCgsJC?=
 =?us-ascii?q?CgugjgigkoBAQEEOj8MBAIBCBEEAQEBHgkHISUJCAIEDgUIhHsDFa0VhywNgTC?=
 =?us-ascii?q?CK4UmgieDPYMtgmqCFwEBJYVmBIgXB4cRinkwCYljg12DMY5/ijSHH4EuHoILc?=
 =?us-ascii?q?IMSgjEQDBaBZXeKN4EigRcBAQE?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.187
X-IronPort-AV: E=Sophos;i="5.47,409,1515477600";
   d="scan'208";a="1058519919"
X-DLP: DLP_GlobalPCIDSS
To: <dvhart@infradead.org>
CC: <andy.shevchenko@gmail.com>, <pali.rohar@gmail.com>,
        <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] platform/x86: dell-smbios: Link all dell-smbios-*
 modules together
Thread-Topic: [PATCH v3 3/3] platform/x86: dell-smbios: Link all dell-smbios-*
 modules together
Thread-Index: AQHTsYWRlsja2+R4vkC/toflQeQBp6O72v5g
Date: Thu, 1 Mar 2018 20:54:31 +0000
Message-ID: <44477ede216542d89090494590ad7a2c@ausx13mpc124.AMER.DELL.COM>
References: <1519755784-2155-1-git-send-email-mario.limonciello@dell.com>
 <1519755784-2155-3-git-send-email-mario.limonciello@dell.com>
 <20180301174845.GA25613@fury>
In-Reply-To: <20180301174845.GA25613@fury>
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
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w21KshYU010918

> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Thursday, March 1, 2018 11:49 AM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>; pali.rohar@gmail.com;
> LKML <linux-kernel@vger.kernel.org>; platform-driver-x86@vger.kernel.org
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
> 
> In order to make the default sane, I would suggest making the above a menu
> (default n), nesting the two options below, and making WMI a default=y. This
> satisfies Linus' requirement by defaulting everything to n, but enables a sane
> default IFF the DELL_SMBIOS menu is enabled.
> 
> Alternatively, all of the above can be put under the "Dell Extras" menu I
> proposed, and DELL_SMBIOS can default to m and DELL_SMBIOS_WMI can default
> to y.

I'm on board with moving everything to a Dell extras menu.  There are so many
drivers now, it really seems like the best way to make sure that people get them.

You'll have to actively go out of your way to turn off one of the sub-drivers then
to get into the situation that was described.

Since you did the original patch for dell extras nested in a mail would you mind 
sending that as a follow up second patch on top of my patch?

I think it's probably too much to do it all in this same patch itself.
Alternatively I can re-send my series with it before my 3/3, up to you.

> 
> >
> > +	/* register backends */
> > +	wmi = init_dell_smbios_wmi();
> > +	if (wmi)
> > +		pr_debug("Failed to initialize WMI backend: %d\n", wmi);
> > +	smm = init_dell_smbios_smm();
> > +	if (smm)
> > +		pr_debug("Failed to initialize SMM backend: %d\n", smm);
> > +	if (wmi && smm) {
> > +		pr_err("No SMBIOS backends available (wmi: %d, smm: %d)\n",
> > +			wmi, smm);
> > +		goto fail_sysfs;
> > +	}
> > +
> 
> I like the approach of building a library instead of a bunch of separate
> modules.
> 
> --
> Darren Hart
> VMware Open Source Technology Center
