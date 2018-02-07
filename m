Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754704AbeBGURY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:17:24 -0500
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:9651 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754281AbeBGURW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:17:22 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EqAQAKXXtah8qZ6ERdGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQngQAoCpwlggKJFZBVCoU7AoJpWBQBAgEBAQEBAQIBAhABAQE?=
 =?us-ascii?q?KCwkIKC+COCKCSgEBAQR5DAQCAQgRBAEBAScHISUJCAIEDgUIihUDFbN5hzoNg?=
 =?us-ascii?q?TGCCgEBAQEBAQEDAQEBAQEBAQEBH4R1ghWDP4MugmtEBIF2RYUwBZMZkFs1CZA?=
 =?us-ascii?q?fVYR+gkqRfY5CiUiBPDaBc3CDGIJlJYFteIx1gRcBAQE?=
X-IPAS-Result: =?us-ascii?q?A2EqAQAKXXtah8qZ6ERdGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?ngQAoCpwlggKJFZBVCoU7AoJpWBQBAgEBAQEBAQIBAhABAQEKCwkIKC+COCKCS?=
 =?us-ascii?q?gEBAQR5DAQCAQgRBAEBAScHISUJCAIEDgUIihUDFbN5hzoNgTGCCgEBAQEBAQE?=
 =?us-ascii?q?DAQEBAQEBAQEBH4R1ghWDP4MugmtEBIF2RYUwBZMZkFs1CZAfVYR+gkqRfY5Ci?=
 =?us-ascii?q?UiBPDaBc3CDGIJlJYFteIx1gRcBAQE?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.172
X-IronPort-AV: E=Sophos;i="5.46,473,1511848800";
   d="scan'208";a="211061080"
X-DLP: DLP_GlobalPCIDSS
To: <dvhart@infradead.org>
CC: <andy.shevchenko@gmail.com>, <pali.rohar@gmail.com>,
        <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v2] platform/x86: dell-laptop: Allocate buffer on heap
 rather than globally
Thread-Topic: [PATCH v2] platform/x86: dell-laptop: Allocate buffer on heap
 rather than globally
Thread-Index: AQHTnbEBZ5a/3jHsuUK3gXwyW5b5oKOUseSAgAFVFtCAAO0qgIACcZow
Date: Wed, 7 Feb 2018 20:17:19 +0000
Message-ID: <4c711099e46e4bbd828d35bd9fbd612a@ausx13mpc120.AMER.DELL.COM>
References: <1517420855-19374-1-git-send-email-mario.limonciello@dell.com>
 <20180204120922.fds52i22griw2h6e@pali>
 <CAHp75VcnDKP=kNPh7pU1v_f0+oP64ByKAOmkZzXNUVaXg=wDSg@mail.gmail.com>
 <9b01161fb81043b79cf9ade8ec348fff@ausx13mpc120.AMER.DELL.COM>
 <20180206005733.GA11119@fury>
In-Reply-To: <20180206005733.GA11119@fury>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w17KHUPg003309

> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Monday, February 5, 2018 6:58 PM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: andy.shevchenko@gmail.com; pali.rohar@gmail.com; linux-
> kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org
> Subject: Re: [PATCH v2] platform/x86: dell-laptop: Allocate buffer on heap rather
> than globally
> 
> On Mon, Feb 05, 2018 at 04:49:35PM +0000, Mario.Limonciello@dell.com wrote:
> > > -----Original Message-----
> > > From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
> > > Sent: Sunday, February 4, 2018 8:28 AM
> > > To: Pali Rohár <pali.rohar@gmail.com>
> > > Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; Darren Hart
> > > <dvhart@infradead.org>; LKML <linux-kernel@vger.kernel.org>; Platform
> Driver
> > > <platform-driver-x86@vger.kernel.org>
> > > Subject: Re: [PATCH v2] platform/x86: dell-laptop: Allocate buffer on heap
> rather
> > > than globally
> > >
> > > On Sun, Feb 4, 2018 at 2:09 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> > > > On Wednesday 31 January 2018 11:47:35 Mario Limonciello wrote:
> > > >> There is no longer a need for the buffer to be defined in
> > > >> first 4GB physical address space.
> > > >>
> > > >> Furthermore there may be race conditions with multiple different functions
> > > >> working on a module wide buffer causing incorrect results.
> > > >>
> > > >> Fixes: 549b4930f057658dc50d8010e66219233119a4d8
> > >
> > > He-h, I had to notice this earlier...
> > >
> > > > Ok, you can add my:
> > > > Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
> > >
> > > Thanks and sorry, Pali, it's in for-next already, can't rebase.
> >
> > Andy,
> > Since it's already in for-next it's probably too late to add the stable CC too right?
> >
> > So what's the proper time now to send this to @stable?  And should I just forward
> existing
> > patch?
> 
> As a general rule, Andy and I should be adding Cc stable to most anything that
> includes a Fixes tag that isn't from this review cycle. I've forgotten in the
> past as well - sorry about that. Something we should add some tooling around I
> think, so we don't miss it when checking things in to our review branches.
> 
> As to timing. As soon as this is merged to Linus' master, it can go to stable.
> Instructions for doing this are in Documentation/process/stable-kernel-rules.rst
> 
> --

Thanks, I see it's in Linuses' tree today so I sent something to stable for it.
