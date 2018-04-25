Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754642AbeDYOv6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:51:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:1970 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753327AbeDYOv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:51:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="223317337"
Date: Wed, 25 Apr 2018 17:51:51 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Michal Hocko <mhocko@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>, linux-kernel@vger.kernel.org,
        lkp@01.org
Subject: Re: [dummy_stm_init] swapper/0: page allocation failure: order:9,
 mode:0x14040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null)
Message-ID: <20180425145151.mbwpkpes6u4xy22w@um.fi.intel.com>
References: <20180419023639.cddsueaq47mohfma@wfg-t540p.sh.intel.com>
 <20180419065111.GM17484@dhcp22.suse.cz>
 <20180419102114.irntfpy6i77apfq5@node.shutemov.name>
 <20180422134439.GK17484@dhcp22.suse.cz>
 <20180424112734.qectc5qqnxbuq4wd@kshutemo-mobl1.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424112734.qectc5qqnxbuq4wd@kshutemo-mobl1.Home>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 02:27:35PM +0300, Kirill A. Shutemov wrote:
> On Sun, Apr 22, 2018 at 07:44:39AM -0600, Michal Hocko wrote:
> > On Thu 19-04-18 13:21:14, Kirill A. Shutemov wrote:
> > > On Thu, Apr 19, 2018 at 08:51:11AM +0200, Michal Hocko wrote:
> > > > On Thu 19-04-18 10:36:39, Wu Fengguang wrote:
> > > > > Hi Alexander,
> > > > > 
> > > > > FYI this happens in mainline kernel 4.17.0-rc1.
> > > > > It dates back to at least v4.15.
> > > > > 
> > > > > It occurs in 4 out of 4 boots. Here KVM has 1G memory.
> > > > > 
> > > > > This high order allocation caused lots of noises in our boot testing.
> > > > > We could disable this device in our tests, but it would be great if
> > > > > there are better ways out.
> > > > > 
> > > > > [   75.039408]       Product name: fake-design-for-testing
> > > > > [   75.040995] fmc fake-design-for-testing-f001: Driver has no ID: matches all
> > > > > [   75.042509] fmc_trivial: probe of fake-design-for-testing-f001 failed with error -95
> > > > > [   75.044323] fmc fake-design-for-testing-f001: Driver has no ID: matches all
> > > > > [   75.045644] fmc_chardev fake-design-for-testing-f001: Created misc device "fake-design-for-testing-f001"
> > > > > [   75.061570] swapper/0: page allocation failure: order:9, mode:0x14040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null)
> > > > 
> > > > Is there any reason why
> > > > > [   75.063338]  stm_register_device+0xf3/0x5c0:
> > > > > 						stm_register_device at drivers/hwtracing/stm/core.c:695
> > > > 
> > > > cannot use kvzalloc?
> > > 
> > > Michal, do you understand how allocating ~512kB leads to order-9 failure?
> > > Shouldn't it be order-8 at most? That's not clear to me.
> > 
> > How do you tell it is 512kB? The page allocator consumes order so maybe
> > something miscalculated the order when calling the allocator?
> 
> Alexander, was it 513kB, right?

Yes, 526024 bytes.

Regards,
--
Alex
