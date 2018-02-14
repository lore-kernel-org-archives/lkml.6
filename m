Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967629AbeBNMT1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 07:19:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:40281 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967577AbeBNMTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 07:19:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,512,1511856000";
   d="scan'208";a="18041301"
Date: Wed, 14 Feb 2018 15:19:10 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] x86/mm: Adjust virtual address space layout in early
 boot
Message-ID: <20180214121910.yvnm7wcejpjux6eo@black.fi.intel.com>
References: <20180214111656.88514-1-kirill.shutemov@linux.intel.com>
 <20180214111656.88514-10-kirill.shutemov@linux.intel.com>
 <20180214121049.z4cjsdwxaaq5gpv5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214121049.z4cjsdwxaaq5gpv5@gmail.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 12:10:49PM +0000, Ingo Molnar wrote:
> 
> * Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:
> 
> > We need to adjust virtual address space to support switching between
> > paging modes.
> > 
> > The adjustment happens in __startup_64().
> > 
> > We also have to change KASLR code that doesn't expect variable
> > VMALLOC_SIZE_TB.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/boot/compressed/kaslr.c        | 14 ++++++++--
> >  arch/x86/include/asm/page_64_types.h    |  9 ++----
> >  arch/x86/include/asm/pgtable_64_types.h | 25 +++++++++--------
> >  arch/x86/kernel/head64.c                | 49 +++++++++++++++++++++++++++------
> >  arch/x86/kernel/head_64.S               |  2 +-
> >  arch/x86/mm/dump_pagetables.c           |  3 ++
> >  arch/x86/mm/kaslr.c                     | 11 ++++----
> >  7 files changed, 77 insertions(+), 36 deletions(-)
> 
> This is too large and risky - would it be possible to split this up into multiple, 
> smaller patches?

Let me check what I can do here.

If you are fine with previous patches please apply. I will send split up
of this patch separately.

-- 
 Kirill A. Shutemov
