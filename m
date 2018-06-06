Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZfSucTwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 74F3A607B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeFFNQi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:16:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeFFNQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:16:37 -0400
Date: Wed, 6 Jun 2018 15:16:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH V4 3/3] x86: Add entry trampolines to kcore
Message-ID: <20180606131631.GD12180@hirez.programming.kicks-ass.net>
References: <1528289651-4113-1-git-send-email-adrian.hunter@intel.com>
 <1528289651-4113-4-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528289651-4113-4-git-send-email-adrian.hunter@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 03:54:11PM +0300, Adrian Hunter wrote:
> Without program headers for PTI entry trampoline pages, the trampoline
> virtual addresses do not map to anything.
> 

> 
> In addition, entry trampolines all map to the same page.  Represent that by
> giving the corresponding program headers in kcore the same offset.
> 
> This has the benefit that, when perf tools uses /proc/kcore as a source for
> kernel object code, samples from different CPU trampolines are aggregated
> together.  Note, such aggregation is normal for profiling i.e. people want
> to profile the object code, not every different virtual address the object
> code might be mapped to (across different processes for example).
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/mm/cpu_entry_area.c | 10 ++++++++++
>  fs/proc/kcore.c              |  7 +++++--
>  include/linux/kcore.h        | 13 +++++++++++++
>  3 files changed, 28 insertions(+), 2 deletions(-)

This also adds the KCORE_REMAP functionality, but isn't mentioned at all
in the Changelog.

Still, looks OK I suppose,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
