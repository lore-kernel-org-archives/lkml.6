Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751137AbeCIJ7n (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:59:43 -0500
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:47573 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751072AbeCIJ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:59:41 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FjAAC+WaJah2Oa6EReGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYMjgQN/KAqDRooejXeCAoEWhx6NDIIVCoUlAhqCdSE0GAECAQE?=
 =?us-ascii?q?BAQEBAgECEAEBAQgNCQgoLoI4IoJKAQEBAQIBIxFFEAIBCBIIAh8HAgICHyYCA?=
 =?us-ascii?q?Q0CBA4FCBOEZgMNCKxAgiaHKg2BMIIagQ6EKIIugzyDLYJqgiFigj2CYgSIEZI?=
 =?us-ascii?q?TMQmNMoMtjmuKMocVgSweggtwgxKCMRAMFm4BCW13iXWBFwEBAQ?=
X-IPAS-Result: =?us-ascii?q?A2FjAAC+WaJah2Oa6EReGQEBAQEBAQEBAQEBAQcBAQEBAYM?=
 =?us-ascii?q?jgQN/KAqDRooejXeCAoEWhx6NDIIVCoUlAhqCdSE0GAECAQEBAQEBAgECEAEBA?=
 =?us-ascii?q?QgNCQgoLoI4IoJKAQEBAQIBIxFFEAIBCBIIAh8HAgICHyYCAQ0CBA4FCBOEZgM?=
 =?us-ascii?q?NCKxAgiaHKg2BMIIagQ6EKIIugzyDLYJqgiFigj2CYgSIEZITMQmNMoMtjmuKM?=
 =?us-ascii?q?ocVgSweggtwgxKCMRAMFm4BCW13iXWBFwEBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.169
X-IronPort-AV: E=Sophos;i="5.47,444,1515477600";
   d="scan'208";a="147442077"
X-DLP: DLP_GlobalPCIDSS
To: <pali.rohar@gmail.com>
CC: <kai.heng.feng@canonical.com>, <mjg59@srcf.ucam.org>,
        <dvhart@infradead.org>, <andy@infradead.org>, <tiwai@suse.com>,
        <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
Subject: RE: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Thread-Topic: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Thread-Index: AQHTtr1XC+3UjKIddE2I55hGuXPKiaPIAceAgAAHyYD//5ufkIAAaMcA//+dHPA=
Date: Fri, 9 Mar 2018 09:59:39 +0000
Message-ID: <09eadabb264f401a88b427744505adf8@ausx13mpc124.AMER.DELL.COM>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-3-kai.heng.feng@canonical.com>
 <20180309090223.xb55ltac4pfesdrh@pali>
 <723DA929-C9FA-4F69-8D3A-03D8A75D09A6@canonical.com>
 <014795f5a3014cd3bf55de26f76a5af8@ausx13mpc124.AMER.DELL.COM>
 <20180309094600.m24d3zbzdsmls7aw@pali>
In-Reply-To: <20180309094600.m24d3zbzdsmls7aw@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w299xnh2027411

> > Pali is your concern that this code for matching vendor/subsystem is running
> > on non-Dell too?  The only other recommendation I think that can be to restrict
> > to matching Dell OEM strings in SMBIOS table, but I don't think that's any better
> > than the matching for VID/SSVID.
> 
> My concern is about adding a new machine specific code into generic
> driver, which check is done just by PCI vendor and subvendor.
> 
> In future there can be new models or other PCI devices which matches
> above condition even they would not have any switchable graphics, nor
> they would manufactured by Dell.

Uh Dell subsystem ID means it's Dell no?

> 
> Also I can imagine that in future (or maybe already now?) it is possible
> to find PCI device which pass above checks and connect this PCI device
> into desktop /server / any non-laptop device.
> 
> If this switchable graphics solution is specific to dell laptops, then
> rather checking for PCI vendor/subvevendor main check, there should be
> main check via DMI strings.

Right now this is affected to both AIO desktop and laptops.

IIRC you won't end up with switchable graphics in traditional desktop that you
can remove PCI card.  If this code was run on a traditional desktop with a 
AMD PCI card that BIOS query result should be invalid token (which will infer
switchable off to this routine).

> 
> Hardware is changing relatively quickly and there is absolutely no
> guarantee that e.g. NVIDIA would not start providing audio controller in
> similar like AMD and it would be put in those Dell machines.

Kai Heng can explain exactly why NVIDIA isn't affected.
This is probably good information to include in the commit message too.

> 
> > > >
> > > > Interesting question would be, how handle this situation Windows?
> > >
> > > I don't know how this platform handles this on Windows, I guess we need
> > > Mario to shed some lights here.
> >
> > Sorry I don't have this information to share.   I don't think it's too useful here
> > anyway though because Windows driver architecture is much different in this
> > area.
> >
> >
> 
> --
> Pali Rohár
> pali.rohar@gmail.com
