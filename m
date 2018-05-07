Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeEGNLF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:11:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:37969 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751949AbeEGNLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:11:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,374,1520924400";
   d="scan'208";a="226476542"
Date: Mon, 7 May 2018 16:10:59 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Proof-of-concept: better(?) page-table manipulation API
Message-ID: <20180507131059.3cdpfd4dcnwznhyw@black.fi.intel.com>
References: <20180424154355.mfjgkf47kdp2by4e@black.fi.intel.com>
 <CALCETrVzD8oPv=h2q91AMdCHn3S782GmvsY-+mwoaPUw=5N7HQ@mail.gmail.com>
 <20180507113124.ewpbrfd3anyg7pli@kshutemo-mobl1>
 <20180507122346.GE18116@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507122346.GE18116@bombadil.infradead.org>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 12:23:46PM +0000, Matthew Wilcox wrote:
> On Mon, May 07, 2018 at 02:31:25PM +0300, Kirill A. Shutemov wrote:
> > > Also, what does lvl == 0 mean?  Is it the top or the bottom?  I think a
> > > comment would be helpful.
> > 
> > It is bottom. But it should be up to architecture to decide.
> 
> That's not true because ...
> 
> > > > +static inline void ptp_walk(ptp_t *ptp, unsigned long addr)
> > > > +{
> > > > +       ptp->ptr = (unsigned long *)ptp_page_vaddr(ptp);
> > > > +       ptp->ptr += __pt_index(addr, --ptp->lvl);
> > > > +}
> > > 
> > > Can you add a comment that says what this function does?
> > 
> > Okay, I will.
> > 
> > > Why does it not change the level?
> > 
> > It does. --ptp->lvl.
> 
> ... you've hardcoded that walking down decrements the level by 1.
> 
> I don't see that as a defect; it's just part of the API that needs
> documenting.

You assume that the function is a generic one. This may or may not be
true.

This is subject for refinement anyway.

-- 
 Kirill A. Shutemov
