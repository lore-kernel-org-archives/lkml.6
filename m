Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbeCZJld (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 05:41:33 -0400
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:4538 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750923AbeCZJla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 05:41:30 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FMAAACv7hamGKa6EReGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYQUfigKg1KIAI0NgXSBEWCGAItxggYLhQUCGoNiITQYAQIBAQEBAQE?=
 =?us-ascii?q?CAQIQAQEBAQEICwsGKC+COCKCTAEBAQMBIxE6CwUHBAIBCBEEAQEBAgIjAwICA?=
 =?us-ascii?q?h8lAQgIAgQOBQiEbgMNCKptgiCHBA2BLIIagQiGUIIUgQyDB4JRggYjECMSgjW?=
 =?us-ascii?q?CVAOXES4IizWCdIxBiU6GKIElHIILcE+CQ4IvjiFvjxKBFwEB?=
X-IPAS-Result: =?us-ascii?q?A2FMAAACv7hamGKa6EReGgEBAQEBAgEBAQEIAQEBAYQUfig?=
 =?us-ascii?q?Kg1KIAI0NgXSBEWCGAItxggYLhQUCGoNiITQYAQIBAQEBAQECAQIQAQEBAQEIC?=
 =?us-ascii?q?wsGKC+COCKCTAEBAQMBIxE6CwUHBAIBCBEEAQEBAgIjAwICAh8lAQgIAgQOBQi?=
 =?us-ascii?q?EbgMNCKptgiCHBA2BLIIagQiGUIIUgQyDB4JRggYjECMSgjWCVAOXES4IizWCd?=
 =?us-ascii?q?IxBiU6GKIElHIILcE+CQ4IvjiFvjxKBFwEB?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.172
X-IronPort-AV: E=Sophos;i="5.48,364,1517896800";
   d="scan'208";a="1233485735"
X-DLP: DLP_GlobalPCIDSS
To: <rafael@kernel.org>
CC: <rjw@rjwysocki.net>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] power/hibernate: Make passing hibernate offsets more
 friendly
Thread-Topic: [PATCH] power/hibernate: Make passing hibernate offsets more
 friendly
Thread-Index: AQHTtTlzOfQoTpcIxEKofswkwTKJn6PXvo+AgAp6BpCAAH0CAP//rPTQ
Date: Mon, 26 Mar 2018 09:41:27 +0000
Message-ID: <72e8709fe8824411a713ef36cd2463ad@ausx13mpc120.AMER.DELL.COM>
References: <1520333620-22342-1-git-send-email-mario.limonciello@dell.com>
 <1854392.I8WPNng6r5@aspire.rjw.lan>
 <b3e9a7ad5dfc4348a8b017110e8ba032@ausx13mpc120.AMER.DELL.COM>
 <CAJZ5v0iwpp5oPGYhrL3X=bMOueByup=UF_ChOTkhjTU5PJc3Cg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iwpp5oPGYhrL3X=bMOueByup=UF_ChOTkhjTU5PJc3Cg@mail.gmail.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2Q9fciA018794

> -----Original Message-----
> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of Rafael J.
> Wysocki
> Sent: Monday, March 26, 2018 4:38 AM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; ACPI Devel Maling List <linux-
> acpi@vger.kernel.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] power/hibernate: Make passing hibernate offsets more friendly
> 
> On Mon, Mar 26, 2018 at 9:17 AM,  <Mario.Limonciello@dell.com> wrote:
> >> -----Original Message-----
> >> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> >> Sent: Monday, March 19, 2018 5:11 AM
> >> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> >> Cc: linux-acpi@vger.kernel.org; LKML <linux-kernel@vger.kernel.org>
> >> Subject: Re: [PATCH] power/hibernate: Make passing hibernate offsets more
> friendly
> >>
> >> On Tuesday, March 6, 2018 11:53:40 AM CET Mario Limonciello wrote:
> >> > Currently the only way to specify a hibernate offset for a
> >> > swap file is on the kernel command line.
> >> >
> >> > Add a new /sys/power/disk_offset that lets userspace
> >> > specify the offset and disk to use when initiating a hibernate
> >> > cycle.
> >> >
> >> > Also split up the parsing routine to re-use the same code
> >> > for the /sys/power/resume and /sys/power/disk_offset parsing.
> >> >
> >> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> >>
> >> Well, IMO /sys/power/resume and /sys/power/disk_offset would be confusingly
> >> similar after this patch.
> >
> > Yeah they do function pretty similarly.
> >
> >>
> >> I wonder if adding a resume_offset sysfs attr to simply allow the value of
> >> resume offset alone to be passed to the kernel at run time (in addition to
> >> the command line) would work?
> >>
> >> Thanks!
> >
> > I guess what's your expected flow for how the disk gets selected though?  Should
> > the kernel be "guessing" which disk to use?
> >
> > Or should userspace be setting offset via /sys/power/resume_offset followed by
> > disk in /sys/power/resume (which will show an error in syslog about no partition
> > found)
> >
> > If the latter,
> 
> Yes, the latter.
> 
> > then I'd like to also modify the behavior to downgrade that missing
> > hibernate partition to debug instead too.
> 
> That's OK.

OK thanks, I'll adjust per your recommendations.
