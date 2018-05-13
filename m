Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeEMUFq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 16:05:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:40949 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751690AbeEMUFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 16:05:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,397,1520924400";
   d="scan'208";a="55544948"
Date: Sun, 13 May 2018 23:05:41 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/boot/compressed/64: Fix moving page table out of
 trampoline memory
Message-ID: <20180513200541.5lywvjfoppjtivpa@black.fi.intel.com>
References: <20180510173806.4332-1-kirill.shutemov@linux.intel.com>
 <20180510173806.4332-3-kirill.shutemov@linux.intel.com>
 <alpine.DEB.2.21.1805132045150.1582@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1805132045150.1582@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 06:56:14PM +0000, Thomas Gleixner wrote:
> On Thu, 10 May 2018, Kirill A. Shutemov wrote:
> 
> > top_pgtable address has to be calculated relative to where the kernel
> > image will be relocated for decompression, not relative to position of
> > kernel is running at the moment. We do the same for the rest of page
> > table we use the stage. It makes them safe from being overwritten during
> > decompression.
> > 
> > Calculate the address of top_pgtable in assembly and pass down to
> > cleanup_trampoline().
> > 
> > Move the page table to .pgtable section where the rest of page tables
> > are. The section is @nobits so we save 4k in kernel image.
> 
> So this is supposed to be a fix, but the whole changelog talks about WHAT
> the patch does and not WHY. Darn, we need proper description of the failure
> which is about to be fixed.

"It makes them safe from being overwritten during decompression."

> It's not that hard and I'm really tired to tell you that over and over.
> 
> >  	/*
> >  	 * cleanup_trampoline() would restore trampoline memory.
> >  	 *
> > +	 * RDI is address of the page table to use instead of page table
> > +	 * in trampoline memory (if required).
> 
> Do you really believe that you understand that comment 6 month from now?

Yes, I think I will.

-- 
 Kirill A. Shutemov
