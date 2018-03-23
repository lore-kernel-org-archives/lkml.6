Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeCWNw3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 09:52:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:33288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752447AbeCWNw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 09:52:28 -0400
Date: Fri, 23 Mar 2018 14:52:25 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <ast@fb.com>
Subject: Re: [PATCH] mm, vmscan, tracing: Use pointer to reclaim_stat struct
 in trace event
Message-ID: <20180323135225.GV23100@dhcp22.suse.cz>
References: <20180322121003.4177af15@gandalf.local.home>
 <20180323134200.GT23100@dhcp22.suse.cz>
 <20180323094753.760b2c86@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323094753.760b2c86@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-03-18 09:47:53, Steven Rostedt wrote:
> On Fri, 23 Mar 2018 14:42:00 +0100
> Michal Hocko <mhocko@kernel.org> wrote:
> 
> > Yes, the number of parameter is large. struct reclaim_stat is an
> > internal stuff so I didn't want to export it. I do not have strong
> > objections to add it somewhere tracing can find it though.
> 
> The one solution is to pull the tracing file
> include/trace/events/vmscan.h into mm/ and have a local header to store
> the reclaim_stat structure that both vmscan.h and vmscan.c can
> reference.

I guess we can live with the public definition as well.

-- 
Michal Hocko
SUSE Labs
