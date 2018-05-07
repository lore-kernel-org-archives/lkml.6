Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeEGUSz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:18:55 -0400
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:23557 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752158AbeEGUSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:18:53 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2E1AgCAtPBamD+a6ERdHAEBAQQBAQoBA?=
 =?us-ascii?q?YQXgQgyg2WUdoF5gQ+TOoFkC4RsAhqCOiE4FAECAQEBAQEBAgEBAhABAQEBAQg?=
 =?us-ascii?q?LCwYoL4I1IoJTAQEBAQIBIxFFEAIBCBoCJgICAkUQAgQODYURCKd9ghyIRoJIg?=
 =?us-ascii?q?QmHHIIThBqEVwRkgjSCNCACh0eQYwiORYxqhW2KX4ElM4F0cIMUghwRCY4XkBu?=
 =?us-ascii?q?BGAEB?=
X-IPAS-Result: =?us-ascii?q?A2E1AgCAtPBamD+a6ERdHAEBAQQBAQoBAYQXgQgyg2WUdoF?=
 =?us-ascii?q?5gQ+TOoFkC4RsAhqCOiE4FAECAQEBAQEBAgEBAhABAQEBAQgLCwYoL4I1IoJTA?=
 =?us-ascii?q?QEBAQIBIxFFEAIBCBoCJgICAkUQAgQODYURCKd9ghyIRoJIgQmHHIIThBqEVwR?=
 =?us-ascii?q?kgjSCNCACh0eQYwiORYxqhW2KX4ElM4F0cIMUghwRCY4XkBuBGAEB?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.189
X-IronPort-AV: E=Sophos;i="5.49,375,1520917200";
   d="scan'208";a="1084669096"
X-DLP: DLP_GlobalPCIDSS
To: <pali.rohar@gmail.com>
CC: <dmitry.torokhov@gmail.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: Dell docking station & Dell Embedded Controller & PS/2 devices
Thread-Topic: Dell docking station & Dell Embedded Controller & PS/2 devices
Thread-Index: AQHT5UDMWM1nc4K7y0Sd6Py+b6Y5jaQkSIuAgAC1NgD//7D3wIAAWKmA//+sgqA=
Date: Mon, 7 May 2018 20:18:30 +0000
Message-ID: <6825f48ea6da41799979d83ed37adf73@ausx13mpc124.AMER.DELL.COM>
References: <20180124104121.7g3zfay5smc5v2tc@pali>
 <20180201192945.wrsqjq7f5ejhqj6m@dtor-ws>
 <20180506134733.zttaitnf6ej4tith@pali> <20180507084431.r2dipv32wt3vbx3k@pali>
 <20180507193306.GA31301@dtor-ws>
 <147aa25ad2d14bad975731a6c9cf9281@ausx13mpc124.AMER.DELL.COM>
 <20180507200733.s43zd2hfzw4f4wr2@pali>
In-Reply-To: <20180507200733.s43zd2hfzw4f4wr2@pali>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w47KJ1nW017252

> > > So I guess you could write a platform driver that would install i8042
> > > filter on Dell laptops/portables, monitor keyboard data stream and kick
> > > of rescans on serio ports. The problem is filter gets "serio" so you do
> > > not really know whether ACK is spurious or not. And I would really
> > > prefer keeping this crap out of atkbd proper... And all of this is racy
> > > as hell. What happens if we get keyboard reconnected as we reinitialize
> > > it?
> >
> > If it's done as a platform driver I would suspect it's possible to tell whether
> > a dock is connected to at least give you some heuristic here to have a better
> > guess whether it's spurious.
> 
> Apparently checking for docking station is not enough. There are also
> Dell Legacy Extenders (or how it is called) which exports internal PS/2,
> Parallel and Serial Ports. It is also connecting to bottom of laptop.
> But currently I do not have them for testing.
> 
> > Pali on your system that supports this dock, check and see how many
> > System Enclosure SMBIOS tables (structure type 03) are present.
> 
> Do you mean DMI type 3 structure? Here is something from dmidecode:
> 
> Handle 0x0003, DMI type 3, 22 bytes
> Chassis Information
>         Manufacturer: Dell Inc.
>         Type: Laptop
>         Lock: Not Present
>         Version: Not Specified
>         Serial Number: --REMOVED--
>         Asset Tag: Not Specified
>         Boot-up State: Safe
>         Power Supply State: Safe
>         Thermal State: Safe
>         Security Status: None
>         OEM Information: 0x00000000
>         Height: Unspecified
>         Number Of Power Cords: 1
>         Contained Elements: 0
>         SKU Number: To be filled by O.E.M.
> 
> But probably you mean something different?

Plug in your dock before you boot up and see if you have a second structure like
that type produced.

If not, then I guess this isn't a reliable way to find the dock
on that system and I'll have to see if there is another.
