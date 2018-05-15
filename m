Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbeEOUie (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:38:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:52618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752506AbeEOUid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:38:33 -0400
Date: Tue, 15 May 2018 22:38:30 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        Linux Memory Management List <linux-mm@kvack.org>,
        mgorman@techsingularity.net, mingo@kernel.org, peterz@infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Dennis Zhou <dennisszhou@gmail.com>
Subject: Re: [PATCH v2] mm: allow deferred page init for vmemmap only
Message-ID: <20180515203830.GK12670@dhcp22.suse.cz>
References: <20180510115356.31164-1-pasha.tatashin@oracle.com>
 <20180510123039.GF5325@dhcp22.suse.cz>
 <CAGM2reZbYR96_uv-SB=5eL6tt0OSq9yXhtA-B2TGHbRQtfGU6g@mail.gmail.com>
 <20180515091036.GC12670@dhcp22.suse.cz>
 <CAGM2reaQusBA-nmQ5xqH4u-EVxgJCnaHAZs=1AXFOpNWTh7VbQ@mail.gmail.com>
 <20180515125541.GH12670@dhcp22.suse.cz>
 <CAGM2reYGFjG38FW0nEf1gwRMfDyVQ7QCGZ83VewxXgedeT=Zsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reYGFjG38FW0nEf1gwRMfDyVQ7QCGZ83VewxXgedeT=Zsg@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-05-18 11:59:25, Pavel Tatashin wrote:
> > This will always be a maze as the early boot tends to be. Sad but true.
> > That is why I am not really convinced we should use a large hammer and
> > disallow deferred page initialization just because UP implementation of
> > pcp does something too early. We should instead rule that one odd case.
> > Your patch simply doesn't rule a large class of potential issues. It
> > just rules out a potentially useful feature for an odd case. See my
> > point?
> 
> Hi Michal,
> 
> OK, I will send an updated patch with disabling deferred pages only whe
> NEED_PER_CPU_KM. Hopefully, we won't see similar issues in other places.

If we do we will probably need to think more about a more systematic
solution.
-- 
Michal Hocko
SUSE Labs
