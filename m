Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbeCLXRT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:17:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:20941 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751442AbeCLXRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:17:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,463,1515484800";
   d="scan'208";a="33275822"
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: James Hogan <jhogan@kernel.org>
CC: "Michael, Alice" <alice.michael@intel.com>,
        Guenter Roeck <linux@roeck-us.net>, Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        Shannon Nelson <shannon.nelson@oracle.com>
Subject: RE: [RFC PATCH] MIPS: Provide cmpxchg64 for 32-bit builds
Thread-Topic: [RFC PATCH] MIPS: Provide cmpxchg64 for 32-bit builds
Thread-Index: AQHTpFslw+crNM24eUSynxqRPTqrYKOh97eAgAJsOTCAAArEUIApbQeA//+LAfA=
Date: Mon, 12 Mar 2018 23:17:16 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5882CF60E8@ORSMSX115.amr.corp.intel.com>
References: <1518475021-3337-1-git-send-email-linux@roeck-us.net>
 <20180212234201.GB4290@saruman> <20180212235655.GC5199@roeck-us.net>
 <CD14C679C9B9B1409B02829D9B523C297C4D61@ORSMSX101.amr.corp.intel.com>
 <02874ECE860811409154E81DA85FBB5882CDAA1C@ORSMSX115.amr.corp.intel.com>
 <20180312231211.GF21642@saruman>
In-Reply-To: <20180312231211.GF21642@saruman>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2QwNTcyNmYtMGViNC00NmIwLTkxMGMtNzAwMWYyZjljZDY5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6ImdodlRVWThORk4rcXBYaUhEMHIrYzYzaUJvTWdsV0ZyT2ZNMmxiU0FYSkE9In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2CNIs2I012653



> -----Original Message-----
> From: James Hogan [mailto:jhogan@kernel.org]
> Sent: Monday, March 12, 2018 4:12 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Michael, Alice <alice.michael@intel.com>; Guenter Roeck <linux@roeck-
> us.net>; Ralf Baechle <ralf@linux-mips.org>; linux-mips@linux-mips.org; linux-
> kernel@vger.kernel.org; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
> Shannon Nelson <shannon.nelson@oracle.com>
> Subject: Re: [RFC PATCH] MIPS: Provide cmpxchg64 for 32-bit builds
> 
> On Wed, Feb 14, 2018 at 09:36:33PM +0000, Keller, Jacob E wrote:
> > > -----Original Message-----
> > > From: Michael, Alice
> > > Sent: Wednesday, February 14, 2018 1:03 PM
> > > To: Guenter Roeck <linux@roeck-us.net>; James Hogan
> <jhogan@kernel.org>;
> > > Keller, Jacob E <jacob.e.keller@intel.com>
> > > Cc: Ralf Baechle <ralf@linux-mips.org>; linux-mips@linux-mips.org; linux-
> > > kernel@vger.kernel.org; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
> Shannon
> > > Nelson <shannon.nelson@oracle.com>
> > > Subject: RE: [RFC PATCH] MIPS: Provide cmpxchg64 for 32-bit builds
> > >
> > > As has previously been said, we're going to be removing the need for
> cmpxchg64.
> > > But it takes a little bit of time and work to do so.  I'm adding the dev that is
> taking
> > > care of the work back onto this email thread as well so he can see any
> concerns with
> > > it.
> > >
> > > Alice
> > >
> > > -----Original Message-----
> > > From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter
> Roeck
> > > Sent: Monday, February 12, 2018 3:57 PM
> > > To: James Hogan <jhogan@kernel.org>
> > > Cc: Ralf Baechle <ralf@linux-mips.org>; linux-mips@linux-mips.org; linux-
> > > kernel@vger.kernel.org; Michael, Alice <alice.michael@intel.com>; Kirsher,
> Jeffrey T
> > > <jeffrey.t.kirsher@intel.com>; Shannon Nelson
> <shannon.nelson@oracle.com>
> > > Subject: Re: [RFC PATCH] MIPS: Provide cmpxchg64 for 32-bit builds
> > >
> > > On Mon, Feb 12, 2018 at 11:42:02PM +0000, James Hogan wrote:
> > > > Hi Guenter,
> > > >
> > > > On Mon, Feb 12, 2018 at 02:37:01PM -0800, Guenter Roeck wrote:
> > > > > Since commit 60f481b970386 ("i40e: change flags to use 64 bits"),
> > > > > the i40e driver uses cmpxchg64(). This causes mips:allmodconfig
> > > > > builds to fail with
> > > > >
> > > > > drivers/net/ethernet/intel/i40e/i40e_ethtool.c:
> > > > > 	In function 'i40e_set_priv_flags':
> > > > > drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4443:2: error:
> > > > > 	implicit declaration of function 'cmpxchg64'
> > > > >
> > > > > Implement a poor-mans-version of cmpxchg64() to fix the problem for
> > > > > 32-bit mips builds. The code is derived from sparc32, but only uses
> > > > > a single spinlock.
> > > >
> > > > Will this be implemened for all 32-bit architectures which are
> > > > currently missing cmpxchg64()?
> > > >
> > > No idea.
> > >
> > > > If so, any particular reason not to do it in generic code?
> > > >
> > > Again, no idea. When the problem was previously seen on sparc32, it was
> > > implemented there.
> > >
> > > > If not then I think that driver should be fixed to either depend on
> > > > some appropriate Kconfig symbol or to not use this API since it
> > > > clearly isn't portable at the moment.
> > > >
> > > Good point.
> > >
> > > > See also Shannon's comment about that specific driver:
> > > > https://lkml.kernel.org/r/e7c934d7-e5f4-ee1b-0647-c31a98d9e944@oracle.
> > > > com
> > > >
> > >
> > > Well, this was an RFC only. Feel free to ignore it.
> > >
> > > FWIW, this is the second time that the call was introduced in the i40 driver.
> > > After the first time the code was rewritten to avoid the problem, but now it
> came
> > > back. Someone must really like it ;-). For my part, I may just blacklist the
> offending
> > > driver in my builds; that is less than perfect, but much easier than having to
> deal with
> > > the same problem over and over again. Guess I'll wait for a while and do just
> that if
> > > the problem isn't fixed in a later RC.
> > >
> > > Guenter
> >
> > Hi,
> >
> > I've been working on re-writing some of the code so that the need for a
> compare-and-exchange in the i40e_set_priv_flags() is not necessary. This mostly
> involved moving many flags out into an atomic bitops field instead, it should be
> posted to IWL soon.
> 
> Any update on this? Will a fix to the driver make it into 4.16 or is it
> going to be too big a change? 

I am not sure if it can make it into 4.16, it's basically a bunch of patches to migrate things in the pf->flags variable so that the flags is only modified while under rtnl_lock. Thus, any runtime flags which change at any time without the lock will be moved to state bits.

The tricky part is that backporting can be troublesome since flags are accessed in a lot of places. 

The patch series should be published to iwl within this week (Thanks Alice!)

If we just remove the cmpxchg without doing the flag changes we open ourselves back up to the risk of the flags being modified simultaneously and causing difficult to debug "flag silently disabled/enabled" issues. In practice this race window is pretty tiny though.

Thanks,
Jake

> 
> As far as I can tell from grepping around, of the architectures which
> support 32-bit SMP with PCI, these ones implement cmpxchg64 on 32-bit:
> 
> arch/arm
> arch/ia64
> arch/x86
> arch/riscv (blindly implements using 64-bit instructions, broken?)
> arch/parisc (with spinlock)
> arch/sparc (with spinlock)
> 
> And these don't:
> 
> arch/arc
> arch/mips
> arch/powerpc
> arch/sh
> arch/xtensa
> 
> (I've excluded arches which are already being removed)
> 
> Cheers
> James
