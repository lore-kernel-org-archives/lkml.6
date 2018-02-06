Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753396AbeBFUeB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 15:34:01 -0500
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:47300 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752965AbeBFUd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 15:33:58 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GHAQCND3pah8qZ6ERcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQnEHAoCoNbmFaCAnyIF5BNCiOFGAIagkJYFAEBAQEBAQEBAgE?=
 =?us-ascii?q?CEAEBAQoLCQgoL4I4IhFLWQEBAQEBASMCDV0BAQEEIxFFDAQCAQgRBAEBAQICI?=
 =?us-ascii?q?wMCAgIfJQEICAIEAQ0FCIoVAxUQtHmCJ4c9DYExggYBAQEBAQEBAwEBAQEBAQE?=
 =?us-ascii?q?BAQEBGAWBD4NbghWDP4J4NoJrRASBdjOCXYJlBYpiiV6PMD6IGohThH6URY1xS?=
 =?us-ascii?q?IlHgTw2gXNwgxiCVRAMggZ4AY1zgRcBAQE?=
X-IPAS-Result: =?us-ascii?q?A2GHAQCND3pah8qZ6ERcGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?nEHAoCoNbmFaCAnyIF5BNCiOFGAIagkJYFAEBAQEBAQEBAgECEAEBAQoLCQgoL?=
 =?us-ascii?q?4I4IhFLWQEBAQEBASMCDV0BAQEEIxFFDAQCAQgRBAEBAQICIwMCAgIfJQEICAI?=
 =?us-ascii?q?EAQ0FCIoVAxUQtHmCJ4c9DYExggYBAQEBAQEBAwEBAQEBAQEBAQEBGAWBD4Nbg?=
 =?us-ascii?q?hWDP4J4NoJrRASBdjOCXYJlBYpiiV6PMD6IGohThH6URY1xSIlHgTw2gXNwgxi?=
 =?us-ascii?q?CVRAMggZ4AY1zgRcBAQE?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.152
X-IronPort-AV: E=Sophos;i="5.46,470,1511848800";
   d="scan'208";a="1212134057"
X-DLP: DLP_GlobalPCIDSS
To: <andriy.shevchenko@linux.intel.com>, <dvhart@infradead.org>
CC: <platform-driver-x86@vger.kernel.org>, <acelan.kao@canonical.com>,
        <linux-kernel@vger.kernel.org>, <pali.rohar@gmail.com>,
        <rjw@rjwysocki.net>
Subject: RE: [RFC, PATCH v1] platform/x86: intel-vbtn: Convert to pure ACPI
 driver
Thread-Topic: [RFC, PATCH v1] platform/x86: intel-vbtn: Convert to pure ACPI
 driver
Thread-Index: AQHTmsD+s/l7/GkRX0mynZ6Nxv0e5aOO5nIAgAeCdoCAAXSPUA==
Date: Tue, 6 Feb 2018 20:33:54 +0000
Message-ID: <c51e36664a6e4df6b641f3c684b0d189@ausx13mpc120.AMER.DELL.COM>
References: <20180131182614.19524-1-andriy.shevchenko@linux.intel.com>
         <20180131213726.GB21498@fury>
 <1517847491.22495.36.camel@linux.intel.com>
In-Reply-To: <1517847491.22495.36.camel@linux.intel.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w16KY6eL006414

> -----Original Message-----
> From: platform-driver-x86-owner@vger.kernel.org [mailto:platform-driver-x86-
> owner@vger.kernel.org] On Behalf Of Andy Shevchenko
> Sent: Monday, February 5, 2018 10:18 AM
> To: Darren Hart <dvhart@infradead.org>
> Cc: platform-driver-x86@vger.kernel.org; AceLan Kao
> <acelan.kao@canonical.com>; linux-kernel@vger.kernel.org;
> pali.rohar@gmail.com; Limonciello, Mario <Mario_Limonciello@Dell.com>; Rafael
> Wysocki <rjw@rjwysocki.net>
> Subject: Re: [RFC, PATCH v1] platform/x86: intel-vbtn: Convert to pure ACPI driver
> 
> On Wed, 2018-01-31 at 13:37 -0800, Darren Hart wrote:
> > On Wed, Jan 31, 2018 at 08:26:14PM +0200, Andy Shevchenko wrote:
> > > Remove code duplication by converting driver to pure ACPI one.
> >
> 
> I have fixed couple issues, but...
> 
> > +Rafael
> >
> > I don't see any reason *not* to do this, it seems the acpi driver
> > model provides
> > some of the boilerplate stuff we were doing manually before as a
> > platform
> > device. I'm scratching my head wondering why we did this as a
> > platform-driver in
> > the first place now...
> 
> ...I still keep in my review queue in a hope that someone can actually
> test this on real hardware.
> 
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy

Andy,

I'm pretty sure XPS 9365 can test this.  I was going to try but 
https://patchwork.kernel.org/patch/10194503/ was not
able to compile on top of platform-x86/for-next.
That was the only one I saw at patchwork.

drivers/platform/x86/intel-vbtn.c:172:11: error: ‘ACPI_BUTTON_CLASS’ undeclared here (not in a function)
  .class = ACPI_BUTTON_CLASS,
           ^
drivers/platform/x86/intel-vbtn.c:178:2: error: unknown field ‘driver’ specified in initializer
  .driver = {
  ^
scripts/Makefile.build:316: recipe for target 'drivers/platform/x86/intel-vbtn.o' failed
make[5]: *** [drivers/platform/x86/intel-vbtn.o] Error 1

is that different than the one in your review queue?

Thanks,
