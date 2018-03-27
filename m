Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753682AbeC0RvQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:51:16 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48665 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752123AbeC0RvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:51:15 -0400
Date: Tue, 27 Mar 2018 19:51:07 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>,
        =?ISO-8859-15?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        the arch/x86 maintainers <x86@kernel.org>, namit@vmware.com
Subject: Re: [PATCH 00/11] Use global pages with PTI
In-Reply-To: <c0e7ca0b-dcb5-66e2-9df6-f53e4eb22781@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1803271949250.1618@nanos.tec.linutronix.de>
References: <20180323174447.55F35636@viggo.jf.intel.com> <CA+55aFwEC1O+6qRc35XwpcuLSgJ+0GP6ciqw_1Oc-msX=efLvQ@mail.gmail.com> <be2e683c-bf0a-e9ce-2f02-4905f6bd56d3@linux.intel.com> <alpine.DEB.2.21.1803271526260.1964@nanos.tec.linutronix.de>
 <c0e7ca0b-dcb5-66e2-9df6-f53e4eb22781@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018, Dave Hansen wrote:

> On 03/27/2018 06:36 AM, Thomas Gleixner wrote:
> >>                         User Time       Kernel Time     Clock Elapsed
> >> Baseline ( 0 GLB PTEs)  803.79          67.77           237.30
> >> w/series (28 GLB PTEs)  807.70 (+0.7%)  68.07 (+0.7%)   238.07 (+0.3%)
> >>
> >> Without PCIDs, it behaves the way I would expect.
> > What's the performance benefit on !PCID systems? And I mean systems which
> > actually do not have PCID, not a PCID system with 'nopcid' on the command
> > line.
> 
> Do you have something in mind for this?  Basically *all* of the servers
> that I have access to have PCID because they are newer than ~7 years old.
> 
> That leaves *some* Ivybridge and earlier desktops, Atoms and AMD

AMD is not interesting as it's not PTI and uses GLOBAL anyway.

> systems.  Atoms are going to be the easiest thing to get my hands on,
> but I tend to shy away from them for performance work.

What I have in mind is that I wonder whether the whole circus is worth it
when there is no performance advantage on PCID systems.

Thanks,

	tglx
