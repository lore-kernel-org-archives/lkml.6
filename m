Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753259AbeDSTxZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 15:53:25 -0400
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:42366 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751876AbeDSTxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 15:53:24 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GzAABD89hahz+a6ERbGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYQVDnooCoNelHmBdIEPknMUgSk7CyUGhD4CGoIoITYWAQIBAQEBAQE?=
 =?us-ascii?q?CAQECEAEBAQoLCQgoIwyCNSINBEssLwEBAQEBAQEBAQEBAQEBARoCDV0BAQEBA?=
 =?us-ascii?q?gEjEVEEAgEGAhEEAQEBAgIjAwICAkQBCAgCBAESCIR9CA+LIptAghyIQ4IgBYE?=
 =?us-ascii?q?Jhn2CE4EPgwuDEQKBLQESAQMzgmmCVAKMEYtcCIVZiFyBPIsZhzeBfYZzgSUiA?=
 =?us-ascii?q?YETcXCDE4IgDgmDRYpSbwqNcw8XA4EFgRgBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GzAABD89hahz+a6ERbGgEBAQEBAgEBAQEIAQEBAYQVDno?=
 =?us-ascii?q?oCoNelHmBdIEPknMUgSk7CyUGhD4CGoIoITYWAQIBAQEBAQECAQECEAEBAQoLC?=
 =?us-ascii?q?QgoIwyCNSINBEssLwEBAQEBAQEBAQEBAQEBARoCDV0BAQEBAgEjEVEEAgEGAhE?=
 =?us-ascii?q?EAQEBAgIjAwICAkQBCAgCBAESCIR9CA+LIptAghyIQ4IgBYEJhn2CE4EPgwuDE?=
 =?us-ascii?q?QKBLQESAQMzgmmCVAKMEYtcCIVZiFyBPIsZhzeBfYZzgSUiAYETcXCDE4IgDgm?=
 =?us-ascii?q?DRYpSbwqNcw8XA4EFgRgBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.169
X-IronPort-AV: E=Sophos;i="5.49,297,1520917200";
   d="scan'208";a="1136102414"
X-DLP: DLP_GlobalPCIDSS
To: <srinivas.pandruvada@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dgilmore@redhat.com>
Subject: RE: issues with suspend on Dell XPS 13 2-in-1
Thread-Topic: issues with suspend on Dell XPS 13 2-in-1
Thread-Index: AQHT05S3l/OM2r/yv0C0KBEFc37YQqQDkQZAgAJ8rYCAAPZB8IAA+lMAgABhL8CAAJyigP//jKBA
Date: Thu, 19 Apr 2018 19:53:18 +0000
Message-ID: <3c730d38c3b345289ec27434d79349cb@ausx13mpc120.AMER.DELL.COM>
References: <6ce634cb82617c2a9a060ba6e2accef2a15dcc15.camel@redhat.com>
         <b7c4434319bf4ff8877f882d219a60ba@ausx13mpc120.AMER.DELL.COM>
         <1524005977.31134.15.camel@intel.com>
         <6ebf99dedde4446d84333c2cf25cc9fa@ausx13mpc120.AMER.DELL.COM>
         <1524112616.31134.43.camel@intel.com>
         <d37a1c5a6505416bbc77a2dc5f76a714@ausx13mpc120.AMER.DELL.COM>
 <1524167123.8392.7.camel@intel.com>
In-Reply-To: <1524167123.8392.7.camel@intel.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3JJrVcN027083

> -----Original Message-----
> From: Pandruvada, Srinivas [mailto:srinivas.pandruvada@intel.com]
> Sent: Thursday, April 19, 2018 2:46 PM
> To: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> dgilmore@redhat.com; Limonciello, Mario
> Subject: Re: issues with suspend on Dell XPS 13 2-in-1
> 
> On Thu, 2018-04-19 at 17:30 +0000, Mario.Limonciello@dell.com wrote:
> 
> [...]
> 
> > >
> Those should impact opportunistic idle since for S2I regular
> > > suspend
> > > callbacks are called. In my 9365, I can get PC10 during S2I path
> > > without adjusting them. Only problematic is systems with SATA,
> > > where we
> > > need to enable devsleep.
> >
> > Hmm, Dennis did mention that he had an NVME disk, so it can't be a
> > devsleep
> > problem.
> >
> > Perhaps can you also share your kernel config used with 9365 so
> > Dennis
> > can compare?
> I am using ubuntu kernel config as is. Nothing special.
> We need to look at the turbostat data and see what PkgC states the
> system can reach. May be the issues is with loading DMC firmware or
> some LTR issues.

It could be potentially needing to update to new DMC firmware than
Fedora installs by default too then.

Eg due to:
https://github.com/torvalds/linux/commit/39ccc9852e2b46964c9c44eba52db57413ba6d27
https://github.com/torvalds/linux/commit/4f0aa1fa3e3849caee450ee5d14fcc289cf16703

> 
> Thanks,
> Srinivas
> 
> >
> > I believe we'll need to see some more information from Dennis you
> > asked
> > in previous email before we can make more progress here though.
> >
> > > >
> > > > > I suggest run
> > > > > #turbostat
> > > > > then suspend and wake
> > > > > when wake up let the turbostat collect data for next sampling
> > > > > interval.
> > > > > We have to see what are PkgC% residencies are?
> > > >
> > > > Assuming you mean for Dan to run this after he adjusts all the PM
> > > > settings
> > > > for those options power top called out, right?
> > >
> > > It is better.
> > > May be some device is not behaving correctly. So he can try with
> > > powertop --auto-tune and check turbostat and see status of PkgC
> > > states.
> > >
> > > Thanks,
> > > Srinivas
> > >
> > > >
> > > > >
> > > > > Thanks,
> > > > > Srinivas
> > > > >
> > > > > >
> > > > > >
> > > > > > >    Good          Bluetooth device interface status
> > > > > > >    Good          Enable Audio codec power management
> > > > > > >    Good          Runtime PM for I2C Adapter i2c-8 (Synopsys
> > > > > > > DesignWare
> > > > > > > I2C adapter)
> > > > > > >    Good          Autosuspend for USB device
> > > > > > > Integrated_Webcam_HD
> > > > > > > [CNFGE16N092020028362]
> > > > > > >    Good          Autosuspend for USB device xHCI Host
> > > > > > > Controller
> > > > > > > [usb1]
> > > > > > >    Good          Autosuspend for USB device xHCI Host
> > > > > > > Controller
> > > > > > > [usb2]
> > > > > > >    Good          Runtime PM for I2C Adapter i2c-7 (SMBus
> > > > > > > I801
> > > > > > > adapter
> > > > > > > at efa0)
> > > > > > >    Good          Autosuspend for unknown USB device 1-2
> > > > > > > (8087:0a2b)
> > > > > > >    Good          Runtime PM for I2C Adapter i2c-6 (Synopsys
> > > > > > > DesignWare
> > > > > > > I2C adapter)
> > > > > > >    Good          I2C Device i2c-DLL077A:01 has no runtime
> > > > > > > power
> > > > > > > management
> > > > > > >    Good          I2C Device i2c-WCOM482F:00 has no runtime
> > > > > > > power
> > > > > > > management
> > > > > > >    Good          Runtime PM for PCI Device Intel
> > > > > > > Corporation
> > > > > > > Sunrise
> > > > > > > Point-LP PCI Express Root Port #10
> > > > > > >    Good          Runtime PM for PCI Device Intel
> > > > > > > Corporation
> > > > > > > Sunrise
> > > > > > > Point-LP CSME HECI #1
> > > > > > >    Good          Runtime PM for PCI Device Intel
> > > > > > > Corporation
> > > > > > > Sunrise
> > > > > > > Point-LP Serial IO I2C Controller #1
> > > > > > >    Good          Runtime PM for PCI Device Intel
> > > > > > > Corporation
> > > > > > > Sunrise
> > > > > > > Point-LP SMBus
> > > > > > >    Good          Runtime PM for PCI Device Intel
> > > > > > > Corporation
> > > > > > > Sunrise
> > > > > > > Point-LP PCI Express Root Port #5
> > > > > > >    Good          Runtime PM for PCI Device Intel
> > > > > > > Corporation
> > > > > > > Sunrise
> > > > > > > Point-LP Serial IO I2C Controller #0
> > > > > > >    Good          Wake-on-lan status for device virbr0-nic
> > > > > > >    Good          Wake-on-lan status for device virbr0
> > > > > > >    Good          Wake-on-lan status for device wlp60s0
> > > > > > >
> > > > > > > Regards
> > > > > > >
> > > > > > > Dennis
