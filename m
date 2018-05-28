Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938989AbeE1MsK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:48:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:52212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937615AbeE1MsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:48:05 -0400
Date: Mon, 28 May 2018 14:34:00 +0200
From: Petr Tesarik <ptesarik@suse.cz>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: dzickus@redhat.com, Neil Horman <nhorman@redhat.com>,
        Tony Luck <tony.luck@intel.com>, bhe@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kdump: add default crashkernel reserve kernel config
 options
Message-ID: <20180528143400.4fc68de4@ezekiel.suse.cz>
In-Reply-To: <87d0xjwlo2.fsf@xmission.com>
References: <20180521025337.GA4627@dhcp-128-65.nay.redhat.com>
        <20180521120215.117d963a7619eb0d1f54bced@linux-foundation.org>
        <20180523070641.GA1689@dhcp-128-65.nay.redhat.com>
        <877enucqr0.fsf@xmission.com>
        <20180523222236.5a96732e@ezekiel.suse.cz>
        <20180524014905.GB2031@dhcp-128-65.nay.redhat.com>
        <20180524085708.31aa311d@ezekiel.suse.cz>
        <87k1rt3tdu.fsf@xmission.com>
        <20180525065943.03bcb911@ezekiel.suse.cz>
        <87d0xjwlo2.fsf@xmission.com>
Organization: SUSE Linux, s.r.o.
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018 15:00:13 -0500
ebiederm@xmission.com (Eric W. Biederman) wrote:

>[...]
> The ultimate point is that the absolute best we can do is to run a
> kernel in memory that we never use for anything else and then we have a
> fighting chance of getting the system working and getting a report of
> the failure out to somewhere.
>
> > Anyway, of course we would still have to keep the current method,
> > because user pages are not always filtered. For example, a major SUSE
> > account runs a database in user space and also inspects its data
> > structures in case of a system crash.  
> 
> And I understand the memory pressures that will encourage people to use
> user pages for extra memory to run the dump capture kernel in.  Short of
> the presence of an IOMMU that all DMA transfers must go through I don't
> see how those user pages could reliably be used.

Absolutely. I fully understand that a system which reuses first
kernel's memory in some way must be less reliable than the current
state. However, some people are willing to trade less reliability for
reduced resource consumption.

Note that we're not talking about reserving a few gigs on a single
machine with some terabytes of memory (i.e. less than 1% of total RAM),
rather a few hundred megs of each 4-gig VM on an s390x machine (i.e.
about 10% of total RAM).

Petr T
