Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeBEKul (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 05:50:41 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:51479 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbeBEKue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 05:50:34 -0500
X-Google-Smtp-Source: AH8x2266eU/fvL/yeghpdFdllEMaC7VZzqhr1Z2/vYD4wI00q6tm+h1nHZeJp9QPU1kI1DLpPltu/g==
Date: Mon, 5 Feb 2018 11:50:31 +0100
From: Christoffer Dall <christoffer.dall@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jayachandran C <jnair@caviumnetworks.com>,
        Jon Masters <jcm@redhat.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 08/18] arm/arm64: KVM: Add PSCI version selection API
Message-ID: <20180205105031.GV21802@cbox>
References: <20180201114657.7323-1-marc.zyngier@arm.com>
 <20180201114657.7323-9-marc.zyngier@arm.com>
 <20180202201706.dj6jmff7lh7bleze@kamzik.brq.redhat.com>
 <20180203115932.24c4bcfb@why.wild-wind.fr.eu.org>
 <20180204123701.GK21802@cbox>
 <6b0d5f23-950c-b2a6-3cc8-63c3145893b4@arm.com>
 <20180205095823.r5vlfkovrgksykxh@hawk.localdomain>
 <7eb71dd4-c06b-9680-0280-03569925283b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eb71dd4-c06b-9680-0280-03569925283b@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 10:42:44AM +0000, Marc Zyngier wrote:
> On 05/02/18 09:58, Andrew Jones wrote:
> > On Mon, Feb 05, 2018 at 09:24:33AM +0000, Marc Zyngier wrote:
> >> On 04/02/18 12:37, Christoffer Dall wrote:
> 
> [...]
> 
> >>> Given the urgency of adding mitigation towards variant 2 which is the
> >>> driver for this work, I think we should drop the compat functionality in
> >>> this series and work this out later on if needed.  I think we can just
> >>> tweak the previous patch to enable PSCI 1.0 by default and drop this
> >>> patch for the current merge window.
> >>
> >> I'd be fine with that, as long as we have a clear agreement on the
> >> impact of such a move.
> > 
> > Yeah, that's what I was trying to figure out with my fancy tables. I might
> > be coming around more to your approach now, though. Ensuring the new->old
> > migration fails is a nice feature of this series. It would be good if
> > we could preserve that behavior without committing to a new userspace
> > interface, but I'm not sure how. Maybe I should just apologize for the
> > noise, and this patch be left as is...
> 
> How about we don't decide now?
> 
> I can remove this patch from the series so that the core stuff can make
> it into the arm64 tree ASAP (I think Catalin wants to queue something
> early this week so that it can hit Linus' tree before the end of the
> merge window), and then repost this single patch on its own (with fixes
> for the things that Christoffer found in his review) after -rc1.
> 
> It leaves us time to haggle over the userspace ABI (which is
> realistically not going to affect anyone), and we get the core stuff in
> place for SoC vendors to start updating their firmware.
> 
I agree, that's what I tried to suggest in my e-mail as well.  Just
remember to tweak the previous patch to actually enable PSCI 1.0 by
default.

Thanks,
-Christoffer
