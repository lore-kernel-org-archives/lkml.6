Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbeCVVKZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 17:10:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32908 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbeCVVKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 17:10:24 -0400
Date: Thu, 22 Mar 2018 14:10:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <ast@fb.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH] mm, vmscan, tracing: Use pointer to reclaim_stat struct
 in trace event
Message-Id: <20180322141022.f02476e1f76338ab9cecf62e@linux-foundation.org>
In-Reply-To: <20180322121003.4177af15@gandalf.local.home>
References: <20180322121003.4177af15@gandalf.local.home>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2018 12:10:03 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> The trace event trace_mm_vmscan_lru_shrink_inactive() currently has 12
> parameters! Seven of them are from the reclaim_stat structure. This
> structure is currently local to mm/vmscan.c. By moving it to the global
> vmstat.h header, we can also reference it from the vmscan tracepoints. In
> moving it, it brings down the overhead of passing so many arguments to the
> trace event. In the future, we may limit the number of arguments that a
> trace event may pass (ideally just 6, but more realistically it may be 8).

Unfortunately this is not a good time.  Andrey's "mm/vmscan: replace
mm_vmscan_lru_shrink_inactive with shrink_page_list tracepoint" mucks
with this code quite a lot and that patch's series is undergoing review
at present, with a few issues yet unresolved.

I'll park your patch for now and if Andrey's series doesn't converge
soon I'll merge this and will ask Andrey to redo things.
