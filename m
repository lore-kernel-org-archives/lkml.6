Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965248AbeEJOLp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:11:45 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:50190 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbeEJOLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:11:42 -0400
Date: Thu, 10 May 2018 10:13:34 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Oliver Yang <yangoliver@me.com>, Shakeel Butt <shakeelb@google.com>,
        xxx xxx <x.qendo@gmail.com>, Taras Kondratiuk <takondra@cisco.com>,
        Daniel Walker <danielwa@cisco.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ruslan Ruslichenko <rruslich@cisco.com>, kernel-team@fb.com
Subject: Re: [PATCH 6/7] psi: pressure stall information for CPU, memory, and
 IO
Message-ID: <20180510141334.GE19348@cmpxchg.org>
References: <20180507210135.1823-1-hannes@cmpxchg.org>
 <20180507210135.1823-7-hannes@cmpxchg.org>
 <20180509100551.GL12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509100551.GL12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 12:05:51PM +0200, Peter Zijlstra wrote:
> On Mon, May 07, 2018 at 05:01:34PM -0400, Johannes Weiner wrote:
> > +	u64 some[NR_PSI_RESOURCES] = { 0, };
> > +	u64 full[NR_PSI_RESOURCES] = { 0, };
> 
> > +		some[r] /= max(nonidle_total, 1UL);
> > +		full[r] /= max(nonidle_total, 1UL);
> 
> That's a bare 64bit divide.. that typically failed to build on 32bit
> archs.

Ah yes, I'll switch that to do_div(). Thanks
