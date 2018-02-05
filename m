Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbeBEQtq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 11:49:46 -0500
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:56083 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752986AbeBEQth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 11:49:37 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2F/AAADinhamGOa6ERdGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQngQAoCoNbmFKCAokTkE0KhTsCGoIzWBQBAQEBAQEBAQIBAhA?=
 =?us-ascii?q?BAQEBAQgLCwYoL4I4IoJKAQEBBCMRRQwEAgEIEQQBAQECAiMDAgICHyUBCAgCB?=
 =?us-ascii?q?AENBQiKFQMVvzSCJ4c2DYExgXgBAQEBAQEBAQEBAQEBAQEBAQEBAQEdgQ+DW4I?=
 =?us-ascii?q?Vgz+DLoJrRASBdhAjgl2CZQWjZz6QFVWEfoJKkXaONIlCgTw2gXNwgxiCZSWBb?=
 =?us-ascii?q?XiNX4EXAQEB?=
X-IPAS-Result: =?us-ascii?q?A2F/AAADinhamGOa6ERdGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?ngQAoCoNbmFKCAokTkE0KhTsCGoIzWBQBAQEBAQEBAQIBAhABAQEBAQgLCwYoL?=
 =?us-ascii?q?4I4IoJKAQEBBCMRRQwEAgEIEQQBAQECAiMDAgICHyUBCAgCBAENBQiKFQMVvzS?=
 =?us-ascii?q?CJ4c2DYExgXgBAQEBAQEBAQEBAQEBAQEBAQEBAQEdgQ+DW4IVgz+DLoJrRASBd?=
 =?us-ascii?q?hAjgl2CZQWjZz6QFVWEfoJKkXaONIlCgTw2gXNwgxiCZSWBbXiNX4EXAQEB?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.172
X-IronPort-AV: E=Sophos;i="5.46,465,1511848800";
   d="scan'208";a="125730741"
X-DLP: DLP_GlobalPCIDSS
To: <andy.shevchenko@gmail.com>, <pali.rohar@gmail.com>
CC: <dvhart@infradead.org>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v2] platform/x86: dell-laptop: Allocate buffer on heap
 rather than globally
Thread-Topic: [PATCH v2] platform/x86: dell-laptop: Allocate buffer on heap
 rather than globally
Thread-Index: AQHTnbEBZ5a/3jHsuUK3gXwyW5b5oKOUseSAgAFVFtA=
Date: Mon, 5 Feb 2018 16:49:35 +0000
Message-ID: <9b01161fb81043b79cf9ade8ec348fff@ausx13mpc120.AMER.DELL.COM>
References: <1517420855-19374-1-git-send-email-mario.limonciello@dell.com>
 <20180204120922.fds52i22griw2h6e@pali>
 <CAHp75VcnDKP=kNPh7pU1v_f0+oP64ByKAOmkZzXNUVaXg=wDSg@mail.gmail.com>
In-Reply-To: <CAHp75VcnDKP=kNPh7pU1v_f0+oP64ByKAOmkZzXNUVaXg=wDSg@mail.gmail.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w15GoFTJ022361

> -----Original Message-----
> From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
> Sent: Sunday, February 4, 2018 8:28 AM
> To: Pali Rohár <pali.rohar@gmail.com>
> Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; Darren Hart
> <dvhart@infradead.org>; LKML <linux-kernel@vger.kernel.org>; Platform Driver
> <platform-driver-x86@vger.kernel.org>
> Subject: Re: [PATCH v2] platform/x86: dell-laptop: Allocate buffer on heap rather
> than globally
> 
> On Sun, Feb 4, 2018 at 2:09 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> > On Wednesday 31 January 2018 11:47:35 Mario Limonciello wrote:
> >> There is no longer a need for the buffer to be defined in
> >> first 4GB physical address space.
> >>
> >> Furthermore there may be race conditions with multiple different functions
> >> working on a module wide buffer causing incorrect results.
> >>
> >> Fixes: 549b4930f057658dc50d8010e66219233119a4d8
> 
> He-h, I had to notice this earlier...
> 
> > Ok, you can add my:
> > Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
> 
> Thanks and sorry, Pali, it's in for-next already, can't rebase.

Andy,
Since it's already in for-next it's probably too late to add the stable CC too right?

So what's the proper time now to send this to @stable?  And should I just forward existing
patch?

Thanks,
