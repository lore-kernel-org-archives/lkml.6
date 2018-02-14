Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031872AbeBNPwy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:52:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:49635 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031649AbeBNPwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:52:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,513,1511856000";
   d="scan'208";a="204170402"
Date: Wed, 14 Feb 2018 17:52:48 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Radion Mirchevsky <radion.mirchevsky@intel.com>
Subject: Re: [PATCH 18/18] thunderbolt: Add support for Intel Titan Ridge
Message-ID: <20180214155248.GU27191@lahna.fi.intel.com>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
 <20180213170018.9780-19-mika.westerberg@linux.intel.com>
 <CAHp75VcwWDTFnBcLotrABvWhT7a=-Z-vue8nB6hko1BaSqKQPQ@mail.gmail.com>
 <20180214142809.GT27191@lahna.fi.intel.com>
 <CAHp75Vf+2z9-osrsFuuQqbOGsoBYQ9TV=0aN0VP8RS-=xDh1mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf+2z9-osrsFuuQqbOGsoBYQ9TV=0aN0VP8RS-=xDh1mw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 04:29:54PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 14, 2018 at 4:28 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Wed, Feb 14, 2018 at 04:23:44PM +0200, Andy Shevchenko wrote:
> >> On Tue, Feb 13, 2018 at 7:00 PM, Mika Westerberg
> >> <mika.westerberg@linux.intel.com> wrote:
> 
> >> > +static inline u64 get_parent_route(u64 route)
> >> > +{
> >> > +       int depth = tb_route_length(route);
> >> > +       return depth ? route & ~((u64)0xff << (depth - 1) * TB_ROUTE_SHIFT) : 0;
> >>
> >> 0xffULL ?
> 
> Agreed or not?

Agreed :)

> >> >  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_USBONLY_NHI        0x15dc
> >> >  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_USBONLY_NHI   0x15dd
> >> >  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_USBONLY_NHI 0x15de
> >>
> >> > +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI         0x15e8
> >> > +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_BRIDGE      0x15e7
> >> > +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI         0x15eb
> >> > +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_BRIDGE      0x15ea
> >> > +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_BRIDGE      0x15ef
> >>
> >> Can we keep it sorted?
> >
> > It is sorted by the controller type ;-)
> 
> Yes, this is not what I'm talking about. Inside the group you can
> easily keep it sorted.

OK, that works for me.
