Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeDFTxM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 15:53:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:54691 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751842AbeDFTxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 15:53:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="30126757"
Date: Fri, 6 Apr 2018 12:53:10 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1]: perf/x86: store user space frame-pointer value on a
 sample
Message-ID: <20180406195310.GB9010@tassilo.jf.intel.com>
References: <086d45fb-a099-4ae9-2854-943447e86010@linux.intel.com>
 <20180406153144.GA9010@tassilo.jf.intel.com>
 <df5f38d8-9b35-0309-527a-c7b7b35c635b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df5f38d8-9b35-0309-527a-c7b7b35c635b@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 10:06:26PM +0300, Alexey Budankov wrote:
> On 06.04.2018 18:31, Andi Kleen wrote:
> >> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
> >> index e47b2dbbdef3..9284048cf5b0 100644
> >> --- a/arch/x86/kernel/perf_regs.c
> >> +++ b/arch/x86/kernel/perf_regs.c
> >> @@ -157,6 +157,15 @@ void perf_get_regs_user(struct perf_regs *regs_user,
> >>  	 */
> >>  	regs_user_copy->bx = -1;
> >>  	regs_user_copy->bp = -1;
> >> +	if (user_64bit_mode(user_regs)) {
> > 
> > Why is it 64bit only? Should work on 32bit too.
> 
> bp register is a part of i386 syscall ABI 
> (http://man7.org/linux/man-pages/man2/syscall.2.html) 
> so not sure if it will make any sense for 32bit processes. 

Both 32bit and 64bit use the same frame pointer, if they
use frame pointer.

-Andi
