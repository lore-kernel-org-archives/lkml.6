Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753658AbeBVLiZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:38:25 -0500
Received: from foss.arm.com ([217.140.101.70]:39482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753531AbeBVLiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:38:24 -0500
Date: Thu, 22 Feb 2018 11:38:19 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: shankerd@codeaurora.org, Philip Elcan <pelcan@codeaurora.org>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] arm64: Add support for new control bits CTR_EL0.DIC
 and CTR_EL0.IDC
Message-ID: <20180222113818.6cknpwfbed2ab2nd@lakrids.cambridge.arm.com>
References: <1519220946-13901-1-git-send-email-shankerd@codeaurora.org>
 <20180221150929.hkvtwu4fgfeis5cy@salmiak>
 <5be4684b-e2d8-1b3b-4c96-03c7dae0b619@codeaurora.org>
 <0eb2d23b-cf96-c7ff-9820-16ed113f4862@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eb2d23b-cf96-c7ff-9820-16ed113f4862@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 04:51:40PM +0000, Robin Murphy wrote:
> On 21/02/18 16:14, Shanker Donthineni wrote:
> [...]
> > > > @@ -1100,6 +1114,20 @@ static int cpu_copy_el2regs(void *__unused)
> > > >   		.enable = cpu_clear_disr,
> > > >   	},
> > > >   #endif /* CONFIG_ARM64_RAS_EXTN */
> > > > +#ifdef CONFIG_ARM64_SKIP_CACHE_POU
> > > > +	{
> > > > +		.desc = "DCache clean to POU",
> > > 
> > > This description is confusing, and sounds like it's describing DC CVAU, rather
> > > than the ability to ellide it. How about:
> > 
> > Sure, I'll take your suggestion.
> 
> Can we at least spell "elision" correctly please? ;)

Argh. Yes.

> Personally I read DIC and IDC as "D-cache to I-cache coherency" and "I-cache
> to D-cache coherency" respectively (just my interpretation, I've not looked
> into the spec work for any hints of rationale), but out loud those do sound
> so poorly-defined that keeping things in terms of the required maintenance
> probably is better.

So long as we have (IDC) and (DIC) in the text to avoid ambiguity, I'm
not that worried either way.

Thanks,
Mark.
