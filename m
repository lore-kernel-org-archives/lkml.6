Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbeE3LTy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:19:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37340 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752572AbeE3LQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:16:47 -0400
Date: Wed, 30 May 2018 04:16:02 -0700
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
Subject: Re: [PATCH] mm: Change return type to vm_fault_t
Message-ID: <20180530111602.GB17450@bombadil.infradead.org>
References: <20180529143126.GA19698@jordon-HP-15-Notebook-PC>
 <20180529145055.GA15148@bombadil.infradead.org>
 <CAFqt6zaxt=wXjvKV0qA+OwU1iUyoBdW2cJSLFqXupVWRpKdqEA@mail.gmail.com>
 <20180529173445.GD15148@bombadil.infradead.org>
 <CAFqt6zZCX7Ai2w9dV3OvUn=V4Z02H=+FBirjHT3QSU1Fuz+uLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zZCX7Ai2w9dV3OvUn=V4Z02H=+FBirjHT3QSU1Fuz+uLQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 09:10:47AM +0530, Souptick Joarder wrote:
> On Tue, May 29, 2018 at 11:04 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > I see:
> >
> > mm/gup.c:817:15: warning: invalid assignment: |=
> > mm/gup.c:817:15:    left side has type int
> > mm/gup.c:817:15:    right side has type restricted vm_fault_t
> >
> > are you building with 'c=2' or 'C=2'?
> 
> Building with C=2.
> Do I need to enable any separate FLAG ?

Nope.  Here's what I have:

willy@bobo:~/kernel/souptick$ make C=2 mm/gup.o
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CHECK   arch/x86/purgatory/purgatory.c
  CHECK   arch/x86/purgatory/sha256.c
  CHECK   arch/x86/purgatory/string.c
arch/x86/purgatory/../boot/string.c:134:6: warning: symbol 'simple_strtol' was not declared. Should it be static?
  CHK     include/generated/bounds.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  CHECK   scripts/mod/empty.c
  CHK     scripts/mod/devicetable-offsets.h
  CHECK   mm/gup.c
mm/gup.c:817:15: warning: invalid assignment: |=
mm/gup.c:817:15:    left side has type int
mm/gup.c:817:15:    right side has type restricted vm_fault_t
  CC      mm/gup.o
