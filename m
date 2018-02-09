Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeBIOVc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:21:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47800 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750993AbeBIOVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:21:31 -0500
Date: Fri, 9 Feb 2018 14:21:26 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: mark.rutland@arm.com, ckadabi@codeaurora.org,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: capabilities: Allow flexibility in scope
Message-ID: <20180209142126.GC5862@e103592.cambridge.arm.com>
References: <20180208173229.GA5862@e103592.cambridge.arm.com>
 <20180209121605.14091-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209121605.14091-1-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 12:16:01PM +0000, Suzuki K Poulose wrote:
> >>> I'm not sure we need extra comments or documentation; I just want
> >>> to check that I've understood the patch correctly.
> >>
> >> So, would you prefer this split to the original patch ?
> > 
> > I think splitting out this patch (1/2) makes sense.
> > 
> > 
> > For the second part (2/2) of the split, I still find that hard to
> > review.  The commit message suggests trivially obvious refactoring
> > only, but I think there are three things going on:
> > 
> >   1) moving functions around (with the intention of merging them)
> >   2) merging functions together
> >   3) other miscellaneous bits of refactoring, and cleanups that become
> >      "obvious" after steps (1) and (2).
> > 
> > The refactoring is likely straightfoward, but the resulting diff is
> > not (at least, I struggle to read it).
> > 
> > Could you split the second part along the lines if (1)..(3) above?
> > I think that would make for much easier review.  (Sorry to be a pain!)
> > 
> > Also, the second patch leaves at least one function that does nothing
> > except call a second function that has no other caller.  It may do
> > no harm to remove and inline any such function.  (Falls under (3),
> > I guess.)
> > 
> 
> Here it goes...
> 
> Suzuki K Poulose (4):
>   arm64: capabilities: Prepare for grouping features and errata work
>     arounds
>   arm64: capabilities: Split the processing of errata work arounds
>   arm64: capabilities: Allow features based on local CPU scope
>   arm64: capabilities: Group handling of features and errata workarounds

This is a lot easier to follow now, thanks.

The patches look OK to me, but I'll comment when you repost whole
series in its updated form, so I don't get confused about which
patches are live now...


Cheers
---Dave
