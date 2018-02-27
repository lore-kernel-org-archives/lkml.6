Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeB0T7T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 14:59:19 -0500
Received: from foss.arm.com ([217.140.101.70]:40294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeB0T7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 14:59:18 -0500
Date: Tue, 27 Feb 2018 19:59:19 +0000
From: Will Deacon <will.deacon@arm.com>
To: "Kani, Toshi" <toshi.kani@hpe.com>
Cc: "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "Hocko, Michal" <mhocko@suse.com>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUkZDIHBhdGNoXSBp?= =?utf-8?Q?oremap?=
 =?utf-8?Q?=3A?= don't set up huge I/O mappings when p4d/pud/pmd is zero
Message-ID: <20180227195919.GA5348@arm.com>
References: <1514460261-65222-1-git-send-email-guohanjun@huawei.com>
 <861128ce-966f-7006-45ba-6a7298918686@codeaurora.org>
 <1519175992.16384.121.camel@hpe.com>
 <etPan.5a8d2180.1dbfd272.49b8@localhost>
 <20180221115758.GA7614@arm.com>
 <32c9b1c3-086b-ba54-f9e9-aefa50066730@huawei.com>
 <20180226110422.GD8736@arm.com>
 <a80e540f-f3bd-53da-185d-7fffe801f10c@huawei.com>
 <1519763686.2693.2.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519763686.2693.2.camel@hpe.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 07:49:42PM +0000, Kani, Toshi wrote:
> On Mon, 2018-02-26 at 20:53 +0800, Hanjun Guo wrote:
> > On 2018/2/26 19:04, Will Deacon wrote:
> > > On Mon, Feb 26, 2018 at 06:57:20PM +0800, Hanjun Guo wrote:
> > > > Simply do something below at now (before the broken code is fixed)?
> > > > 
> > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > index b2b95f7..a86148c 100644
> > > > --- a/arch/arm64/Kconfig
> > > > +++ b/arch/arm64/Kconfig
> > > > @@ -84,7 +84,6 @@ config ARM64
> > > >         select HAVE_ALIGNED_STRUCT_PAGE if SLUB
> > > >         select HAVE_ARCH_AUDITSYSCALL
> > > >         select HAVE_ARCH_BITREVERSE
> > > > -   select HAVE_ARCH_HUGE_VMAP
> > > >         select HAVE_ARCH_JUMP_LABEL
> > > >         select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
> > > >         select HAVE_ARCH_KGDB
> > > 
> > > No, that actually breaks with the use of block mappings for the kernel
> > > text. Anyway, see:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=15122ee2c515a253b0c66a3e618bc7ebe35105eb
> > 
> > Sorry, just back from holidays and didn't catch up with all the emails,
> > thanks for taking care of this.
> 
> I will work on a fix for the common/x86 code.

Ace, thanks. I'm more than happy to review any changes you make to the core
code from a break-before-make perspective. Just stick me on cc.

Cheers,

Will
