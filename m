Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751188AbeC0UHZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 16:07:25 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35955 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbeC0UHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 16:07:23 -0400
X-Google-Smtp-Source: AIpwx4+g8dS/mHkcVCSic5MVhP+d37Av6Zjv9OVjn2Ysy6fee8d5Jyc6fYgYvM4N+cqzT09N00csCA==
Date: Tue, 27 Mar 2018 22:07:19 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>,
        =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        the arch/x86 maintainers <x86@kernel.org>, namit@vmware.com
Subject: Re: [PATCH 00/11] Use global pages with PTI
Message-ID: <20180327200719.lvdomez6hszpmo4s@gmail.com>
References: <20180323174447.55F35636@viggo.jf.intel.com>
 <CA+55aFwEC1O+6qRc35XwpcuLSgJ+0GP6ciqw_1Oc-msX=efLvQ@mail.gmail.com>
 <be2e683c-bf0a-e9ce-2f02-4905f6bd56d3@linux.intel.com>
 <alpine.DEB.2.21.1803271526260.1964@nanos.tec.linutronix.de>
 <c0e7ca0b-dcb5-66e2-9df6-f53e4eb22781@linux.intel.com>
 <alpine.DEB.2.21.1803271949250.1618@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1803271949250.1618@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > systems.  Atoms are going to be the easiest thing to get my hands on,
> > but I tend to shy away from them for performance work.
> 
> What I have in mind is that I wonder whether the whole circus is worth it
> when there is no performance advantage on PCID systems.

I'd still love to:

 - To see at minimum stddev numbers, to make sure we are not looking at some weird
   statistical artifact. (I also outlined a more robust measurement method.)

 - If the numbers are right, a CPU engineer should have a look if possible, 
   because frankly this effect is not expected and is not intuitive. Where global 
   pages can be used safely they are almost always an unconditional win.
   Maybe we are missing some limitation or some interaction with PCID.

Since we'll be using PCID even on Meltdown-fixed hardware, maybe the same negative 
performance effect already exists on non-PTI kernels as well, we just never 
noticed?

I.e. there are multiple grounds to get to the bottom of this.

Thanks,

	Ingo
