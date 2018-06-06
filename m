Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtIrf89w"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E4E360263
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbeFFNTu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751714AbeFFNTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:19:49 -0400
Date: Wed, 6 Jun 2018 10:19:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH V4 3/3] x86: Add entry trampolines to kcore
Message-ID: <20180606131946.GF24381@kernel.org>
References: <1528289651-4113-1-git-send-email-adrian.hunter@intel.com>
 <1528289651-4113-4-git-send-email-adrian.hunter@intel.com>
 <20180606131631.GD12180@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606131631.GD12180@hirez.programming.kicks-ass.net>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 06, 2018 at 03:16:31PM +0200, Peter Zijlstra escreveu:
> On Wed, Jun 06, 2018 at 03:54:11PM +0300, Adrian Hunter wrote:
> > Without program headers for PTI entry trampoline pages, the trampoline
> > virtual addresses do not map to anything.
> > 
> 
> > 
> > In addition, entry trampolines all map to the same page.  Represent that by
> > giving the corresponding program headers in kcore the same offset.
> > 
> > This has the benefit that, when perf tools uses /proc/kcore as a source for
> > kernel object code, samples from different CPU trampolines are aggregated
> > together.  Note, such aggregation is normal for profiling i.e. people want
> > to profile the object code, not every different virtual address the object
> > code might be mapped to (across different processes for example).
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > Acked-by: Andi Kleen <ak@linux.intel.com>
> > ---
> >  arch/x86/mm/cpu_entry_area.c | 10 ++++++++++
> >  fs/proc/kcore.c              |  7 +++++--
> >  include/linux/kcore.h        | 13 +++++++++++++
> >  3 files changed, 28 insertions(+), 2 deletions(-)
> 
> This also adds the KCORE_REMAP functionality, but isn't mentioned at all
> in the Changelog.
> 
> Still, looks OK I suppose,

I can add a note about that,
 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks, giving it some more hours and will apply and try to test it.

- Arnaldo
