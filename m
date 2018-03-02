Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428231AbeCBNlR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:41:17 -0500
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:58266 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1424222AbeCBNlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:41:15 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FsAACoU5lah2Ka6ERcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYUmKAqDSoojjXmCAoEWhyGNDIIVCoUwAhqCRyE0GAECAQEBAQE?=
 =?us-ascii?q?BAgECEAEBAQoLCQgoLoI4IoJKAQEBAQMjEToLDAQCAQgRBAEBAQICIwMCAgIfJ?=
 =?us-ascii?q?QEICAIEDgUIhHsDFakjgieHJg2BMIIrgQ+EF4Ipgz2DLYJqghsjECMSgj+CYgS?=
 =?us-ascii?q?aLTEJjUGDMoFxh1OFPoo1hyCBLh6CC3BPgkOCQYIHd4s0gRgBAQE?=
X-IPAS-Result: =?us-ascii?q?A2FsAACoU5lah2Ka6ERcGQEBAQEBAQEBAQEBAQcBAQEBAYU?=
 =?us-ascii?q?mKAqDSoojjXmCAoEWhyGNDIIVCoUwAhqCRyE0GAECAQEBAQEBAgECEAEBAQoLC?=
 =?us-ascii?q?QgoLoI4IoJKAQEBAQMjEToLDAQCAQgRBAEBAQICIwMCAgIfJQEICAIEDgUIhHs?=
 =?us-ascii?q?DFakjgieHJg2BMIIrgQ+EF4Ipgz2DLYJqghsjECMSgj+CYgSaLTEJjUGDMoFxh?=
 =?us-ascii?q?1OFPoo1hyCBLh6CC3BPgkOCQYIHd4s0gRgBAQE?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.172
X-IronPort-AV: E=Sophos;i="5.47,412,1515477600";
   d="scan'208";a="1058886243"
X-DLP: DLP_GlobalPCIDSS
To: <rafael@kernel.org>
CC: <andy.shevchenko@gmail.com>, <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] power/hibernate: Make passing hibernate offsets more
 friendly
Thread-Topic: [RFC] power/hibernate: Make passing hibernate offsets more
 friendly
Thread-Index: AQHTsLvZsEmrPWpV1EW9TBL1ic3Lf6O6giwAgAIyAIyAAEJ4UA==
Date: Fri, 2 Mar 2018 13:41:12 +0000
Message-ID: <836fd1d7923d4432b17607351b302a56@ausx13mpc124.AMER.DELL.COM>
References: <1519839829-2191-1-git-send-email-mario.limonciello@dell.com>
 <CAHp75VcdsALCUBNoO4BoOj0rHuxurhr6B3GL2i7D79BxRL77kQ@mail.gmail.com>
 <ad15f3beb9f44c77b79f3038cb75b69c@ausx13mpc124.AMER.DELL.COM>
 <CAJZ5v0jGr0VP9bNXprvyHfLvvvEgva6S9rAZM8EZEpGw=0PG+g@mail.gmail.com>
In-Reply-To: <CAJZ5v0jGr0VP9bNXprvyHfLvvvEgva6S9rAZM8EZEpGw=0PG+g@mail.gmail.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w22DfOwV002187

> -----Original Message-----
> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of Rafael J.
> Wysocki
> Sent: Friday, March 2, 2018 3:43 AM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>; Rafael J. Wysocki
> <rjw@rjwysocki.net>; ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Linux
> Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: [RFC] power/hibernate: Make passing hibernate offsets more friendly
> 
> On Wed, Feb 28, 2018 at 9:05 PM,  <Mario.Limonciello@dell.com> wrote:
> >
> >
> >> -----Original Message-----
> >> From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
> >> Sent: Wednesday, February 28, 2018 12:11 PM
> >> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> >> Cc: Rafael J . Wysocki <rjw@rjwysocki.net>; ACPI Devel Maling List <linux-
> >> acpi@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>
> >> Subject: Re: [RFC] power/hibernate: Make passing hibernate offsets more friendly
> >>
> >> On Wed, Feb 28, 2018 at 7:43 PM, Mario Limonciello
> >> <mario.limonciello@dell.com> wrote:
> >> > Currently the only way to specify a hibernate offset for a swap
> >> > file is on the kernel command line.
> >> >
> >> > This makes some changes to improve:
> >> > 1) Add a new /sys/power/disk_offset that lets userspace specify
> >> > the offset and disk to use when initiating a hibernate cycle.
> >> >
> >> > 2) Adjust /sys/power/resume interpretation to also read in an
> >> > offset.
> >>
> >> Read is okay per se (not consistent though), showing is not.
> >> It might break an ABI.
> >
> > Right this is part of why I was proposing making a new attribute.
> >
> > The current RFC implementation I sent keeps the read output the
> > same for /sys/power/resume.
> 
> You also need to retain the write behavior of it.
> 
> A new attribute is fine if it helps, but the behavior of the existing
> one cannot change (both sides).

Thanks for your feedback, I'll adjust it as such.
