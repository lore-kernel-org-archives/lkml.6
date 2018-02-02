Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeBBEbg convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 23:31:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:2780 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751878AbeBBEbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 23:31:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,445,1511856000";
   d="scan'208";a="14441129"
From: "Brown, Aaron F" <aaron.f.brown@intel.com>
To: Benjamin Poirier <bpoirier@suse.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
CC: Netdev <netdev@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [RFC PATCH] e1000e: Remove Other from EIAC.
Thread-Topic: [Intel-wired-lan] [RFC PATCH] e1000e: Remove Other from EIAC.
Thread-Index: AQHTkCjRUoY6zH0tL0mG3OCqMNi3CqONa8EAgADE8YCAAmupAIAAAFzQ
Date: Fri, 2 Feb 2018 04:31:19 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C7D0D15@ORSMSX101.amr.corp.intel.com>
References: <20180118065054.29844-1-bpoirier@suse.com>
 <CAKgT0Uc+sSREnAvF=TTDp2FFxGcro6JmDpE2KdnEYk5rDE3Tpw@mail.gmail.com>
 <20180131073105.7tqyzylc76wjyoav@f1.synalogic.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWEyODUwZDAtYmQzMi00N2EzLTlkNzktNWM4OWJkNWU0M2ZiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6IjdXRnVvVTV4aysxY2NZQnV5Nm1LNlk5ejlUd2tBWG5BOXR0dTd6dGp5Rk09In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Brown, Aaron F
> Sent: Thursday, February 1, 2018 8:30 PM
> To: 'Benjamin Poirier' <bpoirier@suse.com>; Alexander Duyck
> <alexander.duyck@gmail.com>
> Cc: Netdev <netdev@vger.kernel.org>; intel-wired-lan <intel-wired-
> lan@lists.osuosl.org>; linux-kernel@vger.kernel.org
> Subject: RE: [Intel-wired-lan] [RFC PATCH] e1000e: Remove Other from EIAC.
> 
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces@osuosl.org] On
> > Behalf Of Benjamin Poirier
> > Sent: Tuesday, January 30, 2018 11:31 PM
> > To: Alexander Duyck <alexander.duyck@gmail.com>
> > Cc: Netdev <netdev@vger.kernel.org>; intel-wired-lan <intel-wired-
> > lan@lists.osuosl.org>; linux-kernel@vger.kernel.org
> > Subject: Re: [Intel-wired-lan] [RFC PATCH] e1000e: Remove Other from
> EIAC.
> >
> > On 2018/01/30 11:46, Alexander Duyck wrote:
> > > On Wed, Jan 17, 2018 at 10:50 PM, Benjamin Poirier
> <bpoirier@suse.com>
> > wrote:
> > > > It was reported that emulated e1000e devices in vmware esxi 6.5 Build
> > > > 7526125 do not link up after commit 4aea7a5c5e94 ("e1000e: Avoid
> > receiver
> > > > overrun interrupt bursts", v4.15-rc1). Some tracing shows that after
> > > > e1000e_trigger_lsc() is called, ICR reads out as 0x0 in
> e1000_msix_other()
> > > > on emulated e1000e devices. In comparison, on real e1000e 82574
> > hardware,
> > > > icr=0x80000004 (_INT_ASSERTED | _OTHER) in the same situation.
> > > >
> > > > Some experimentation showed that this flaw in vmware e1000e
> > emulation can
> > > > be worked around by not setting Other in EIAC. This is how it was
> before
> > > > 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt", v4.5-rc1).
> > > >
> > > > Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt
> bursts")
> > > > Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> > > > ---
> > >
> > > Hi Benjamin,
> > >
> > > How would you feel about resubmitting this patch for net?
> > >
> > > We have some issues that have come up and it would be useful to have
> > > this fixed in the kernel sooner rather than later. I would be okay
> > > with us applying it for now while we work on coming up with a more
> > > complete solution.
> >
> > Ok, I've resent it in its original form. Once it's in mainline I'll
> > rebase the cleanups.
> 
> Tested-by: Aaron Brown
> <aaron.f.brown@intel.com>
Stupid line wrap ... been that kind of day.

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

> 
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan@osuosl.org
> > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
