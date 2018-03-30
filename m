Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeC3MRb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:17:31 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:56191 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbeC3MR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:17:29 -0400
X-Google-Smtp-Source: AIpwx4/G+q8sBAevqlCENH5NmDVIMTEDIQVqCmh+XW4j4i57Y6dH/Zhw/6i/ZZW4ez/rymvF58K/Ow==
Date: Fri, 30 Mar 2018 14:17:25 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>,
        =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        the arch/x86 maintainers <x86@kernel.org>, namit@vmware.com
Subject: Re: [PATCH 00/11] Use global pages with PTI
Message-ID: <20180330121725.zcklh36ulg7crydw@gmail.com>
References: <20180323174447.55F35636@viggo.jf.intel.com>
 <CA+55aFwEC1O+6qRc35XwpcuLSgJ+0GP6ciqw_1Oc-msX=efLvQ@mail.gmail.com>
 <be2e683c-bf0a-e9ce-2f02-4905f6bd56d3@linux.intel.com>
 <alpine.DEB.2.21.1803271526260.1964@nanos.tec.linutronix.de>
 <c0e7ca0b-dcb5-66e2-9df6-f53e4eb22781@linux.intel.com>
 <alpine.DEB.2.21.1803271949250.1618@nanos.tec.linutronix.de>
 <20180327200719.lvdomez6hszpmo4s@gmail.com>
 <0d6ea030-ec3b-d649-bad7-89ff54094e25@linux.intel.com>
 <20180330120920.btobga44wqytlkoe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330120920.btobga44wqytlkoe@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > No Global pages (baseline): 186.951 seconds time elapsed  ( +-  0.35% )
> > 28 Global pages (this set): 185.756 seconds time elapsed  ( +-  0.09% )
> >                              -1.195 seconds (-0.64%)
> > 
> > Lower is better here, obviously.
> > 
> > I also re-checked everything using will-it-scale's llseek1 test[2] which
> > is basically a microbenchmark of a halfway reasonable syscall.  Higher
> > here is better.
> > 
> > No Global pages (baseline): 15783951 lseeks/sec
> > 28 Global pages (this set): 16054688 lseeks/sec
> > 			     +270737 lseeks/sec (+1.71%)
> > 
> > So, both the kernel compile and the microbenchmark got measurably faster.
> 
> Ok, cool, this is much better!
> 
> Mind re-sending the patch-set against latest -tip so it can be merged?
> 
> At this point !PCID Intel hardware is not a primary concern, if something bad 
> happens on them with global pages we can quirk global pages off on them in some 
> way, or so.

BTW., the expectation on !PCID Intel hardware would be for global pages to help 
even more than the 0.6% and 1.7% you measured on PCID hardware: PCID already 
_reduces_ the cost of TLB flushes - so if there's not even PCID then global pages 
should help even more.

In theory at least. Would still be nice to measure it.

Thanks,

	Ingo
