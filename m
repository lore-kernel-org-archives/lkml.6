Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbeFDNth (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:49:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753063AbeFDNte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:49:34 -0400
Date: Mon, 4 Jun 2018 06:49:03 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>, zi.yan@cs.rutgers.edu,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, riel@redhat.com,
        pasha.tatashin@oracle.com, jschoenh@amazon.de,
        Kate Stewart <kstewart@linuxfoundation.org>,
        David Rientjes <rientjes@google.com>, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>,
        yang.s@alibaba-inc.com, Minchan Kim <minchan@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm: Change return type int to vm_fault_t for fault
 handlers
Message-ID: <20180604134903.GA2526@bombadil.infradead.org>
References: <20180602200407.GA15200@jordon-HP-15-Notebook-PC>
 <20180602220136.GA14810@bombadil.infradead.org>
 <CAFqt6zaf1k1SvYXLrCXAvsAPC+jGQoKxR_LtUwNybdJosptQTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zaf1k1SvYXLrCXAvsAPC+jGQoKxR_LtUwNybdJosptQTQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 10:07:16AM +0530, Souptick Joarder wrote:
> On Sun, Jun 3, 2018 at 3:31 AM, Matthew Wilcox <willy@infradead.org> wrote:
> > On Sun, Jun 03, 2018 at 01:34:07AM +0530, Souptick Joarder wrote:
> >> @@ -3570,9 +3571,8 @@ static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
> >>                       return 0;
> >>               }
> >>
> >> -             ret = (PTR_ERR(new_page) == -ENOMEM) ?
> >> -                     VM_FAULT_OOM : VM_FAULT_SIGBUS;
> >> -             goto out_release_old;
> >> +             ret = vmf_error(PTR_ERR(new_page));
> >> +                     goto out_release_old;
> >>       }
> >>
> >>       /*
> >
> > Something weird happened to the goto here
> 
> Didn't get it ? Do you refer to wrong indent in goto ?

Yes.
