Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753754AbeDTRzd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:55:33 -0400
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:57504 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753725AbeDTRzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:55:31 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HJAABOKdpah2Oa6ERbHAEBAQQBAQoBA?=
 =?us-ascii?q?YQVgQgoCoNgiAKMeIF0gQ+SeIF4C4RpAhqCLCE0GAECAQEBAQEBAgEBAhABAQE?=
 =?us-ascii?q?KCwkIKC+CNSKCTQEBAQQjEUUMBAIBCBEEAQEBAgIjAwICAkQBCAgCBAENBQiFB?=
 =?us-ascii?q?aZughyIQYIpgQmGfYITgQ+DC4Q8TgaCY4JUApdxCI43jFaQKYElHIILcIMTgi6?=
 =?us-ascii?q?OIG+NIIEugRgBAQ?=
X-IPAS-Result: =?us-ascii?q?A2HJAABOKdpah2Oa6ERbHAEBAQQBAQoBAYQVgQgoCoNgiAK?=
 =?us-ascii?q?MeIF0gQ+SeIF4C4RpAhqCLCE0GAECAQEBAQEBAgEBAhABAQEKCwkIKC+CNSKCT?=
 =?us-ascii?q?QEBAQQjEUUMBAIBCBEEAQEBAgIjAwICAkQBCAgCBAENBQiFBaZughyIQYIpgQm?=
 =?us-ascii?q?GfYITgQ+DC4Q8TgaCY4JUApdxCI43jFaQKYElHIILcIMTgi6OIG+NIIEugRgBA?=
 =?us-ascii?q?Q?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.152
X-IronPort-AV: E=Sophos;i="5.49,302,1520917200";
   d="scan'208";a="1078929728"
X-DLP: DLP_GlobalPCIDSS
To: <rdunlap@infradead.org>, <dvhart@infradead.org>,
        <andy.shevchenko@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: Kconfig: Fix dell-laptop dependency chain.
Thread-Topic: [PATCH] platform/x86: Kconfig: Fix dell-laptop dependency chain.
Thread-Index: AQHT2M7rxZLP9aMUvkqG+899ovfDKaQKQxIA//+sctA=
Date: Fri, 20 Apr 2018 17:55:28 +0000
Message-ID: <d7ec4d23554a4d92a2ed59354483900a@ausx13mpc120.AMER.DELL.COM>
References: <1524246131-17621-1-git-send-email-mario.limonciello@dell.com>
 <858fbd0a-a387-e9f8-5017-1fff9638dd4d@infradead.org>
In-Reply-To: <858fbd0a-a387-e9f8-5017-1fff9638dd4d@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3KHtenP011600


> -----Original Message-----
> From: platform-driver-x86-owner@vger.kernel.org [mailto:platform-driver-x86-
> owner@vger.kernel.org] On Behalf Of Randy Dunlap
> Sent: Friday, April 20, 2018 12:53 PM
> To: Limonciello, Mario; dvhart@infradead.org; Andy Shevchenko
> Cc: LKML; platform-driver-x86@vger.kernel.org
> Subject: Re: [PATCH] platform/x86: Kconfig: Fix dell-laptop dependency chain.
> 
> On 04/20/18 10:42, Mario Limonciello wrote:
> > As reported by Randy Dunlap:
> >>> WARNING: unmet direct dependencies detected for DELL_SMBIOS
> >>>   Depends on [m]: X86 [=y] && X86_PLATFORM_DEVICES [=y]
> >>> 	&& (DCDBAS [=m] ||
> >>> DCDBAS [=m]=n) && (ACPI_WMI [=n] || ACPI_WMI [=n]=n)
> >>>   Selected by [y]:
> >>>   - DELL_LAPTOP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]
> >>> && DMI [=y]
> >>> && BACKLIGHT_CLASS_DEVICE [=y] && (ACPI_VIDEO [=n] ||
> >>> 	ACPI_VIDEO [=n]=n)
> >>> && (RFKILL [=n] || RFKILL [=n]=n) && SERIO_I8042 [=y]
> >>>
> >
> > Right now it's possible to set dell laptop to compile in but this
> > causes dell-smbios to compile in which breaks if dcdbas is a module.
> >
> > Dell laptop shouldn't select dell-smbios anymore, but depend on it.
> >
> > Fixes: 32d7b19 (platform/x86: dell-smbios: Resolve dependency error on
> DCDBAS)
> 
> meta-comment: the SHA-1 ID should be the first 12 characters of the commit ID
> according to Documentation/process/submitting-patches.rst.

Thanks for letting me, I didn't realize that.

Darren, let me know if you want me to resubmit with this adjustment or if you
can adjust when you queue for testing.

> 
> 
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> 
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.
> 
> > ---
> >  drivers/platform/x86/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > index 39d06dd..bc309c5 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -154,7 +154,7 @@ config DELL_LAPTOP
> >  	depends on ACPI_VIDEO || ACPI_VIDEO = n
> >  	depends on RFKILL || RFKILL = n
> >  	depends on SERIO_I8042
> > -	select DELL_SMBIOS
> > +	depends on DELL_SMBIOS
> >  	select POWER_SUPPLY
> >  	select LEDS_CLASS
> >  	select NEW_LEDS
> >
> 
> 
> --
> ~Randy
