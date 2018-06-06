Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4F0F6087E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeFFPow (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:44:52 -0400
Received: from foss.arm.com ([217.140.101.70]:42334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752927AbeFFPot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:44:49 -0400
Date: Wed, 6 Jun 2018 16:45:21 +0100
From: Will Deacon <will.deacon@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, toshi.kani@hpe.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 0/3] Fix issues with huge mapping in ioremap for ARM64
Message-ID: <20180606154520.GM6631@arm.com>
References: <1528268481-19299-1-git-send-email-cpandya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528268481-19299-1-git-send-email-cpandya@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chintan,

Thanks for sticking with this. I've reviewed the series now and I'm keen
for it to land in mainline. Just a couple of things below.

On Wed, Jun 06, 2018 at 12:31:18PM +0530, Chintan Pandya wrote:
> This series of patches re-bring huge vmap back for arm64.
> 
> Patch 1/3 has been taken by Toshi in his series of patches
> by name "[PATCH v3 0/3] fix free pmd/pte page handlings on x86"
> to avoid merge conflict with this series.
> 
> These patches are tested on 4.16 kernel with Cortex-A75 based SoC.
> 
> The test used for verifying these patches is a stress test on
> ioremap/unmap which tries to re-use same io-address but changes
> size of mapping randomly i.e. 4K to 2M to 1G etc. The same test
> used to reproduce 3rd level translation fault without these fixes
> (and also of course with Revert "arm64: Enforce BBM for huge IO/VMAP
> mappings" being part of the tree).

[...]

> These patches can also go into '-stable' branch (if accepted)
> for 4.6 onwards.

Not sure we need to target -stable, since we solved the crash by disabling
the use of huge io mappings.

>  arch/arm64/include/asm/tlbflush.h |  7 ++++++
>  arch/arm64/mm/mmu.c               | 48 +++++++++++++++++++++++++++++++++++----
>  arch/x86/mm/pgtable.c             |  8 ++++---
>  include/asm-generic/pgtable.h     |  8 +++----
>  lib/ioremap.c                     |  4 ++--

If you get an ack from the x86 folks, then I could take all of this via
arm64. Alternatively, now that I've reviewed the series this could happily
go via another tree (e.g. akpm).

Thanks,

Will
