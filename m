Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeDRVB5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 17:01:57 -0400
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:54566 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751256AbeDRVBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 17:01:55 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EOAQDHsNdah8qZ6ERdHgEGDIQVgQgoC?=
 =?us-ascii?q?oNelQuBdIEPknKBeAuEaQIagkohNBgBAgEBAQEBAQIBAQIQAQEBCgsJCCgvgjU?=
 =?us-ascii?q?igkwBAQEBAgEjEUoHBAIBBgIRBAEBAQICIwMCAgJEAQgIAgQBEggRhGwIimibQ?=
 =?us-ascii?q?IIciD+CJYEJhn2CE4EPgwuEMiUIK4JpglQCjBGLWgiONIxVkCaBJRyCC3CDE4I?=
 =?us-ascii?q?ujiBvjQEBJQOBBYEYAQE?=
X-IPAS-Result: =?us-ascii?q?A2EOAQDHsNdah8qZ6ERdHgEGDIQVgQgoCoNelQuBdIEPknK?=
 =?us-ascii?q?BeAuEaQIagkohNBgBAgEBAQEBAQIBAQIQAQEBCgsJCCgvgjUigkwBAQEBAgEjE?=
 =?us-ascii?q?UoHBAIBBgIRBAEBAQICIwMCAgJEAQgIAgQBEggRhGwIimibQIIciD+CJYEJhn2?=
 =?us-ascii?q?CE4EPgwuEMiUIK4JpglQCjBGLWgiONIxVkCaBJRyCC3CDE4IujiBvjQEBJQOBB?=
 =?us-ascii?q?YEYAQE?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.172
X-IronPort-AV: E=Sophos;i="5.48,466,1517896800";
   d="scan'208";a="1242384954"
X-DLP: DLP_GlobalPCIDSS
To: <srinivas.pandruvada@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dgilmore@redhat.com>
Subject: RE: issues with suspend on Dell XPS 13 2-in-1
Thread-Topic: issues with suspend on Dell XPS 13 2-in-1
Thread-Index: AQHT05S3l/OM2r/yv0C0KBEFc37YQqQDkQZAgAJ8rYCAAPZB8A==
Date: Wed, 18 Apr 2018 21:01:52 +0000
Message-ID: <6ebf99dedde4446d84333c2cf25cc9fa@ausx13mpc120.AMER.DELL.COM>
References: <6ce634cb82617c2a9a060ba6e2accef2a15dcc15.camel@redhat.com>
         <b7c4434319bf4ff8877f882d219a60ba@ausx13mpc120.AMER.DELL.COM>
 <1524005977.31134.15.camel@intel.com>
In-Reply-To: <1524005977.31134.15.camel@intel.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3IL235q000491



> -----Original Message-----
> From: Pandruvada, Srinivas [mailto:srinivas.pandruvada@intel.com]
> Sent: Tuesday, April 17, 2018 6:00 PM
> To: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> dgilmore@redhat.com; Limonciello, Mario
> Subject: Re: issues with suspend on Dell XPS 13 2-in-1
> 
> On Mon, 2018-04-16 at 16:07 +0000, Mario.Limonciello@dell.com wrote:
> > Hi Dennis,
> >
> > > -----Original Message-----
> > > From: Dennis Gilmore [mailto:dgilmore@redhat.com]
> > > Sent: Friday, April 13, 2018 9:03 PM
> > > To: linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org
> > > Cc: Limonciello, Mario
> > > Subject: issues with suspend on Dell XPS 13 2-in-1
> > >
> > > Hi All,
> > >
> > > I have a Dell XPS 13 2-in-1 (9365) that when I supend gets warm and
> > > has
> > > much shorter than expected battery life, it is about the same as if
> > > the
> > > laptop just runs. I am currently running Fedora 28 with 4.16.2
> > > kernel.
> > >
> >
> > Since battery consumption is quite relative I think It would be good
> > if
> > you can make a comparable benchmark as this is further discussed.
> > Eg fully charge your notebook, pull the plug, suspend it at 100% and
> > check the power left after some repeatable amount of time.
> >
> > > My laptop has NVMe for storage and is configured for AHCI mode in
> > > the
> > > bios.
> > >
> > > powertop by default shows
> > > > > Bad           VM writeback timeout
> > >
> > >    Bad           NMI watchdog should be turned off
> > >    Bad           Autosuspend for unknown USB device 1-7 (138a:0091)
> > >    Bad           Runtime PM for I2C Adapter i2c-0 (i915 gmbus dpc)
> > >    Bad           Runtime PM for I2C Adapter i2c-1 (i915 gmbus dpb)
> > >    Bad           Runtime PM for I2C Adapter i2c-2 (i915 gmbus dpd)
> > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > Wireless
> > > 8265 / 8275
> > >    Bad           Runtime PM for PCI Device Intel Corporation Device
> > > 590c
> > >    Bad           Runtime PM for PCI Device Realtek Semiconductor
> > > Co.,
> > > Ltd. RTS525A PCI Express Card Reader
> > >    Bad           Runtime PM for PCI Device Intel Corporation Device
> > > 9d3d
> > >    Bad           Runtime PM for PCI Device Sandisk Corp WD Black
> > > NVMe
> > > SSD
> > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > Sunrise
> > > Point-LP PCI Express Root Port #9
> > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > Sunrise
> > > Point-LP Thermal subsystem
> > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > Sunrise
> > > Point-LP USB 3.0 xHCI Controller
> > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > Sunrise
> > > Point-LP PMC
> > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > Sunrise
> > > Point-LP HD Audio
> > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > Sunrise
> > > Point-LP PCI Express Root Port #1
> > >    Bad           Runtime PM for PCI Device Intel Corporation Device
> > > 9d4b
> > >    Bad           Runtime PM for PCI Device Intel Corporation Xeon
> > > E3-
> > > 1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem
> > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > Sunrise
> > > Point-LP Integrated Sensor Hub
> > >    Bad           Runtime PM for PCI Device Intel Corporation Device
> > > 591e
> >
> > After you've adjusted all of these in powertop, have you compared
> > your performance of the battery over sleep (and actually over runtime
> > usage really too)?
> >
> > They should help to allow the CPU to get into deeper states.
> >
> > After you've made that change you should also see on the "Idle Stats"
> > page that your CPU is spending more time in the lower C states
> > (hopefully
> > more in C9/10).
> >
> > Srinivas,
> >
> > Do you know why Runtime PM is defaulting to disabled for all of these
> > devices?  Is that a default kernel policy problem or a distro policy
> > problem?
> This is default kernel policy.

Why is policy set this way by default in kernel?  Could we discuss to change
Default kernel policy so that users can get better power consumption by default?

I think it will be especially important as more machines continue to adopt
suspend-to-idle.

> I suggest run
> #turbostat
> then suspend and wake
> when wake up let the turbostat collect data for next sampling interval.
> We have to see what are PkgC% residencies are?
Assuming you mean for Dan to run this after he adjusts all the PM settings
for those options power top called out, right?

> 
> Thanks,
> Srinivas
> 
> >
> >
> > >    Good          Bluetooth device interface status
> > >    Good          Enable Audio codec power management
> > >    Good          Runtime PM for I2C Adapter i2c-8 (Synopsys
> > > DesignWare
> > > I2C adapter)
> > >    Good          Autosuspend for USB device Integrated_Webcam_HD
> > > [CNFGE16N092020028362]
> > >    Good          Autosuspend for USB device xHCI Host Controller
> > > [usb1]
> > >    Good          Autosuspend for USB device xHCI Host Controller
> > > [usb2]
> > >    Good          Runtime PM for I2C Adapter i2c-7 (SMBus I801
> > > adapter
> > > at efa0)
> > >    Good          Autosuspend for unknown USB device 1-2 (8087:0a2b)
> > >    Good          Runtime PM for I2C Adapter i2c-6 (Synopsys
> > > DesignWare
> > > I2C adapter)
> > >    Good          I2C Device i2c-DLL077A:01 has no runtime power
> > > management
> > >    Good          I2C Device i2c-WCOM482F:00 has no runtime power
> > > management
> > >    Good          Runtime PM for PCI Device Intel Corporation
> > > Sunrise
> > > Point-LP PCI Express Root Port #10
> > >    Good          Runtime PM for PCI Device Intel Corporation
> > > Sunrise
> > > Point-LP CSME HECI #1
> > >    Good          Runtime PM for PCI Device Intel Corporation
> > > Sunrise
> > > Point-LP Serial IO I2C Controller #1
> > >    Good          Runtime PM for PCI Device Intel Corporation
> > > Sunrise
> > > Point-LP SMBus
> > >    Good          Runtime PM for PCI Device Intel Corporation
> > > Sunrise
> > > Point-LP PCI Express Root Port #5
> > >    Good          Runtime PM for PCI Device Intel Corporation
> > > Sunrise
> > > Point-LP Serial IO I2C Controller #0
> > >    Good          Wake-on-lan status for device virbr0-nic
> > >    Good          Wake-on-lan status for device virbr0
> > >    Good          Wake-on-lan status for device wlp60s0
> > >
> > > Regards
> > >
> > > Dennis
