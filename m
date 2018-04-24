Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756626AbeDXL1h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:27:37 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52746 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756053AbeDXL1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:27:35 -0400
X-Google-Smtp-Source: AB8JxZpi4bp3bPaSoFDX+iaPhm+DFhHFPdl1uMv43HOoqQure4dEG5zvD+BlyMKLJdHnccz6jObKOQ==
Date: Tue, 24 Apr 2018 14:27:35 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Michal Hocko <mhocko@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>, linux-kernel@vger.kernel.org,
        lkp@01.org
Subject: Re: [dummy_stm_init] swapper/0: page allocation failure: order:9,
 mode:0x14040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null)
Message-ID: <20180424112734.qectc5qqnxbuq4wd@kshutemo-mobl1.Home>
References: <20180419023639.cddsueaq47mohfma@wfg-t540p.sh.intel.com>
 <20180419065111.GM17484@dhcp22.suse.cz>
 <20180419102114.irntfpy6i77apfq5@node.shutemov.name>
 <20180422134439.GK17484@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422134439.GK17484@dhcp22.suse.cz>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 07:44:39AM -0600, Michal Hocko wrote:
> On Thu 19-04-18 13:21:14, Kirill A. Shutemov wrote:
> > On Thu, Apr 19, 2018 at 08:51:11AM +0200, Michal Hocko wrote:
> > > On Thu 19-04-18 10:36:39, Wu Fengguang wrote:
> > > > Hi Alexander,
> > > > 
> > > > FYI this happens in mainline kernel 4.17.0-rc1.
> > > > It dates back to at least v4.15.
> > > > 
> > > > It occurs in 4 out of 4 boots. Here KVM has 1G memory.
> > > > 
> > > > This high order allocation caused lots of noises in our boot testing.
> > > > We could disable this device in our tests, but it would be great if
> > > > there are better ways out.
> > > > 
> > > > [   75.039408]       Product name: fake-design-for-testing
> > > > [   75.040995] fmc fake-design-for-testing-f001: Driver has no ID: matches all
> > > > [   75.042509] fmc_trivial: probe of fake-design-for-testing-f001 failed with error -95
> > > > [   75.044323] fmc fake-design-for-testing-f001: Driver has no ID: matches all
> > > > [   75.045644] fmc_chardev fake-design-for-testing-f001: Created misc device "fake-design-for-testing-f001"
> > > > [   75.061570] swapper/0: page allocation failure: order:9, mode:0x14040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null)
> > > 
> > > Is there any reason why
> > > > [   75.063338]  stm_register_device+0xf3/0x5c0:
> > > > 						stm_register_device at drivers/hwtracing/stm/core.c:695
> > > 
> > > cannot use kvzalloc?
> > 
> > Michal, do you understand how allocating ~512kB leads to order-9 failure?
> > Shouldn't it be order-8 at most? That's not clear to me.
> 
> How do you tell it is 512kB? The page allocator consumes order so maybe
> something miscalculated the order when calling the allocator?

Alexander, was it 513kB, right?

I just want to make sure that we don't have any bugs in calculation on
allocator side.

-- 
 Kirill A. Shutemov
