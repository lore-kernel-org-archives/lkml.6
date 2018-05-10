Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934881AbeEJKOO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 06:14:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48636 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934263AbeEJKOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 06:14:11 -0400
Date: Thu, 10 May 2018 12:14:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2]: perf/x86: store user space frame-pointer value on a
 sample
Message-ID: <20180510101406.GA12217@hirez.programming.kicks-ass.net>
References: <31205dc8-b756-e12b-0249-2ed06c2db9c9@linux.intel.com>
 <20180509145436.GV12217@hirez.programming.kicks-ass.net>
 <3ecedd91-1c01-6fc5-4648-89eaf5ff0930@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ecedd91-1c01-6fc5-4648-89eaf5ff0930@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 12:42:38PM +0300, Alexey Budankov wrote:
> > The Changelog needs to state that user_regs->bp is in fact valid and
> 
> That actually was tested on binaries compiled without and with BP exposed 
> and in the latter case proved the value of that change.

Mostly works is not the same as 'always initialized', if there are entry
paths that do not store that register, then using the value might leak
values from the kernel stack, which would be bad.

But like said, I think much of the kernel entry code was sanitized with
the PTI effort and I suspect things are in fact fine now, but lets wait
for Andy to confirm.
