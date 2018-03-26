Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeCZHR1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 03:17:27 -0400
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:6992 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750864AbeCZHRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 03:17:25 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FLAABHnrhamGKa6EReGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYQUfigKi1KNDYF0gRFgkXGCBguFBQKDeCE0GAECAQEBAQEBAgECEAE?=
 =?us-ascii?q?BAQEBCAsLBigvgjgigkwBAQEDATo/DAQCAQgRBAEBAR4JB0YJCAIEDgUIhH4Ir?=
 =?us-ascii?q?VqIPYIah1iCFIEMgweEVyNFhQkDlz8IjimMQY92gSUcggtwgxKCL44hb48SgRc?=
 =?us-ascii?q?BAQ?=
X-IPAS-Result: =?us-ascii?q?A2FLAABHnrhamGKa6EReGgEBAQEBAgEBAQEIAQEBAYQUfig?=
 =?us-ascii?q?Ki1KNDYF0gRFgkXGCBguFBQKDeCE0GAECAQEBAQEBAgECEAEBAQEBCAsLBigvg?=
 =?us-ascii?q?jgigkwBAQEDATo/DAQCAQgRBAEBAR4JB0YJCAIEDgUIhH4IrVqIPYIah1iCFIE?=
 =?us-ascii?q?MgweEVyNFhQkDlz8IjimMQY92gSUcggtwgxKCL44hb48SgRcBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.187
X-IronPort-AV: E=Sophos;i="5.48,364,1517896800";
   d="scan'208";a="157134622"
X-DLP: DLP_GlobalPCIDSS
To: <rjw@rjwysocki.net>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] power/hibernate: Make passing hibernate offsets more
 friendly
Thread-Topic: [PATCH] power/hibernate: Make passing hibernate offsets more
 friendly
Thread-Index: AQHTtTlzOfQoTpcIxEKofswkwTKJn6PXvo+AgAp6BpA=
Date: Mon, 26 Mar 2018 07:17:22 +0000
Message-ID: <b3e9a7ad5dfc4348a8b017110e8ba032@ausx13mpc120.AMER.DELL.COM>
References: <1520333620-22342-1-git-send-email-mario.limonciello@dell.com>
 <1854392.I8WPNng6r5@aspire.rjw.lan>
In-Reply-To: <1854392.I8WPNng6r5@aspire.rjw.lan>
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
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2Q7HWOt008555

> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Sent: Monday, March 19, 2018 5:11 AM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: linux-acpi@vger.kernel.org; LKML <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] power/hibernate: Make passing hibernate offsets more friendly
> 
> On Tuesday, March 6, 2018 11:53:40 AM CET Mario Limonciello wrote:
> > Currently the only way to specify a hibernate offset for a
> > swap file is on the kernel command line.
> >
> > Add a new /sys/power/disk_offset that lets userspace
> > specify the offset and disk to use when initiating a hibernate
> > cycle.
> >
> > Also split up the parsing routine to re-use the same code
> > for the /sys/power/resume and /sys/power/disk_offset parsing.
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> 
> Well, IMO /sys/power/resume and /sys/power/disk_offset would be confusingly
> similar after this patch.

Yeah they do function pretty similarly.

> 
> I wonder if adding a resume_offset sysfs attr to simply allow the value of
> resume offset alone to be passed to the kernel at run time (in addition to
> the command line) would work?
> 
> Thanks!

I guess what's your expected flow for how the disk gets selected though?  Should
the kernel be "guessing" which disk to use?

Or should userspace be setting offset via /sys/power/resume_offset followed by
disk in /sys/power/resume (which will show an error in syslog about no partition
found)

If the latter, then I'd like to also modify the behavior to downgrade that missing
hibernate partition to debug instead too.
