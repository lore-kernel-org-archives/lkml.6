Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753723AbeFDPGl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:06:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44604 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751473AbeFDPGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:06:40 -0400
Date: Mon, 4 Jun 2018 16:07:10 +0100
From: Will Deacon <will.deacon@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, toshi.kani@hpe.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 4/5] arm64: Implement page table free interfaces
Message-ID: <20180604150709.GA8593@arm.com>
References: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
 <1527856758-27169-5-git-send-email-cpandya@codeaurora.org>
 <20180604121328.GG9482@arm.com>
 <98ef3cd0-a9a1-d5b5-f1a6-c0ab8b15ec6a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98ef3cd0-a9a1-d5b5-f1a6-c0ab8b15ec6a@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 07:13:18PM +0530, Chintan Pandya wrote:
> On 6/4/2018 5:43 PM, Will Deacon wrote:
> >On Fri, Jun 01, 2018 at 06:09:17PM +0530, Chintan Pandya wrote:
> >>+		next = addr;
> >>+		end = addr + PUD_SIZE;
> >>+		do {
> >>+			pmd_free_pte_page(entry, next);
> >>+		} while (entry++, next += PMD_SIZE, next != end);
> >>+
> >>+		pud_clear(pudp);
> >>+		__flush_tlb_kernel_pgtable(addr);
> >>+		pmd_free(NULL, table);
> >>+	}
> >>+	return 1;
> >
> >So with these patches, we only ever return 1 from these helpers. It looks
> >like the same is true for x86, so how about we make them void and move the
> >calls inside the conditionals in lib/ioremap.c? Obviously, this would be a
> >separate patch on the end.
> 
> That sounds valid code churn to me. But since x86 discussion is not
> concluded yet, I would wait to share until that gets resolved. May be
> not in v13 but separate effort. Would that be okay to you ?

Yes, fine by me.

Will
