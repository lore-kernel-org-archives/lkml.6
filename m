Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeEQRUa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 13:20:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53712 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeEQRU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 13:20:29 -0400
Date: Thu, 17 May 2018 10:19:51 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>, akpm@linux-foundation.org,
        mhocko@kernel.org, peterz@infradead.org, kirill@shutemov.name,
        ak@linux.intel.com, dave@stgolabs.net, jack@suse.cz,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        sergey.senozhatsky.work@gmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        vinayak menon <vinayakm.list@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, haren@linux.vnet.ibm.com, npiggin@gmail.com,
        bsingharora@gmail.com, paulmck@linux.vnet.ibm.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
Subject: Re: [PATCH v11 01/26] mm: introduce CONFIG_SPECULATIVE_PAGE_FAULT
Message-ID: <20180517171951.GB26718@bombadil.infradead.org>
References: <1526555193-7242-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1526555193-7242-2-git-send-email-ldufour@linux.vnet.ibm.com>
 <2cb8256d-5822-d94d-b0e6-c46f21d84852@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cb8256d-5822-d94d-b0e6-c46f21d84852@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 09:36:00AM -0700, Randy Dunlap wrote:
> > +	 If the speculative page fault fails because of a concurrency is
> 
> 	                                     because a concurrency is

While one can use concurrency as a noun, it sounds archaic to me.  I'd
rather:

	If the speculative page fault fails because a concurrent modification
	is detected or because underlying PMD or PTE tables are not yet

> > +	 detected or because underlying PMD or PTE tables are not yet
> > +	 allocating, it is failing its processing and a classic page fault
> 
> 	 allocated, the speculative page fault fails and a classic page fault
> 
> > +	 is then tried.
