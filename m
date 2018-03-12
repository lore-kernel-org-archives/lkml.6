Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeCLOw1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:52:27 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38699 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeCLOwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:52:25 -0400
X-Google-Smtp-Source: AG47ELtxrCT1mX2ZjDWgKl2K6cTNLJ4qg3f6d/nxtQKaQwB3g5TcXyFpYaBlKqv+l+1/itAz1L6ROw==
Date: Mon, 12 Mar 2018 17:52:22 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>, kirill.shutemov@linux.intel.com,
        luto@amacapital.net, keescook@chromium.org, willy@infradead.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, bp@suse.de,
        andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        ebiederm@xmission.com, jgross@suse.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/mm] x86/boot/compressed/64: Describe the logic behind
 the LA57 check
Message-ID: <20180312145222.GC22761@uranus.lan>
References: <20180226180451.86788-2-kirill.shutemov@linux.intel.com>
 <tip-a403d798182f4f7be5e9bab56cfa37e9828fd92a@git.kernel.org>
 <20180312124027.GG4064@hirez.programming.kicks-ass.net>
 <20180312124337.vw7bchm6brfzghfa@node.shutemov.name>
 <20180312131055.GH4064@hirez.programming.kicks-ass.net>
 <20180312140449.oyngtgqppnjuh3lf@node.shutemov.name>
 <20180312143212.77z2ptyqbsbqdll3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312143212.77z2ptyqbsbqdll3@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 03:32:12PM +0100, Ingo Molnar wrote:
> 
> * Kirill A. Shutemov <kirill@shutemov.name> wrote:
> 
> > > We can of course bike shed / benchmark this once my desktop refresh
> > > sports this feature, but ISTR this being one of the very first things
> > > Ingo mentioned when we started this whole 5L thing.
> > 
> > I would rather not fix the problem that may not actually exist. :)
> 
> That 5 level pagetables involve more overhead is a realy problem.
> 
> By default we should only enable 5-level paging if memory mappings exist in
> the memory map that require the extended physical memory space.

Does it mean that if a machine supports 5lvl but has phisycal memory
installed fitting the 4lvl space, and has memory hotplug supported,
adding more memory won't have effect until next reboot?
