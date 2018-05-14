Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932157AbeENNKT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:10:19 -0400
Received: from foss.arm.com ([217.140.101.70]:42110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752722AbeENNKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:10:18 -0400
Date: Mon, 14 May 2018 14:10:13 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        james.morse@arm.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/18] arm64: move SCTLR_EL{1,2} assertions to
 <asm/sysreg.h>
Message-ID: <20180514131012.7y3vmvoxvtjsqdyn@lakrids.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-3-mark.rutland@arm.com>
 <20180514100053.GX7753@e103592.cambridge.arm.com>
 <20180514100858.4xjp5d3axbyy74ap@lakrids.cambridge.arm.com>
 <20180514112036.GI7753@e103592.cambridge.arm.com>
 <8d66d231-d8a2-07c1-6c5b-24c9474c851f@arm.com>
 <20180514120609.3vd2s4l3rknd2b3e@lakrids.cambridge.arm.com>
 <20180514124122.GJ7753@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514124122.GJ7753@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 01:41:23PM +0100, Dave Martin wrote:
> On Mon, May 14, 2018 at 01:06:10PM +0100, Mark Rutland wrote:
> > On Mon, May 14, 2018 at 12:56:09PM +0100, Robin Murphy wrote:
> > > On 14/05/18 12:20, Dave Martin wrote:
> > > > How about the following?
> > > > 
> > > > /* Watch out for #if evaluation rules: ~0 is not ~(int)0! */
> > > 
> > > Or, more formally, perhaps something even less vague like "Note that in
> > > preprocessor arithmetic these constants are effectively of type intmax_t,
> > > which is 64-bit, thus ~0 is not what we want."
> > 
> > I'll drop something in the commit message to that effect, rather than a
> > comment.
> > 
> > A comment will end up terse and vague or large and bloatsome (and
> > redundant as we have this pattern twice).
> > 
> > Anyone attempting to "clean" this up will find things break, and they can
> > look at the git log to find out why it is the way it is...
> 
> Fair enough.  So long as we say something somewhere, that's
> sufficient for me.
> 
> With that,
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> 
> (as previously stated).

Cheers!

Mark.
