Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965076AbeEXH42 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:56:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54788 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935682AbeEXH40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:56:26 -0400
Date: Thu, 24 May 2018 15:56:15 +0800
From: Dave Young <dyoung@redhat.com>
To: Petr Tesarik <ptesarik@suse.cz>
Cc: dzickus@redhat.com, Neil Horman <nhorman@redhat.com>,
        Tony Luck <tony.luck@intel.com>, bhe@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kdump: add default crashkernel reserve kernel config
 options
Message-ID: <20180524075615.GC1940@dhcp-128-65.nay.redhat.com>
References: <20180521025337.GA4627@dhcp-128-65.nay.redhat.com>
 <20180521120215.117d963a7619eb0d1f54bced@linux-foundation.org>
 <20180523070641.GA1689@dhcp-128-65.nay.redhat.com>
 <877enucqr0.fsf@xmission.com>
 <20180523222236.5a96732e@ezekiel.suse.cz>
 <20180524014905.GB2031@dhcp-128-65.nay.redhat.com>
 <20180524085708.31aa311d@ezekiel.suse.cz>
 <20180524072627.GA1940@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524072627.GA1940@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Instead of setting aside a significant chunk of memory nobody can use,
> > > [...] reserve a significant chunk of memory that the kernel is prevented
> > > from using [...], but applications are free to use it.
> > 
> > That works great, because user space pages are filtered out in the
> > common case, so they can be used freely by the panic kernel.
> 
> Good suggestion. I have been reading that posts already at the same time before I saw
> this reply from you :)
> 
> That could be a good idea and worth to discuss more.  I cced Hari
> already in the thread. Hari, is it possible for you to extend your
> idea to general use, ie. shared by both kdump and fadump?  Anyway I
> think that is another topic we can discuss separately.

BTW, I remember we had some Red hat internal discussion about CMA previously
there is a problem, that is we have crashkernel=,high for reserving high
memory and ,low for low memory, we were not sure if CMA can handle this
case.

Thanks
Dave
Thanks
Dave
