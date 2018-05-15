Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeEOGtM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:49:12 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41474 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbeEOGtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:49:10 -0400
X-Google-Smtp-Source: AB8JxZqQahxgzMG8pQsipPWqYokphVftRNUq3eJeD6z1UbPdsqC+jxVWgjYxNTzohf20IWNn9UlwGA==
Date: Tue, 15 May 2018 08:49:06 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: use memcpy_mcsafe() for copy_to_iter() (was: Re: [PATCH v3 0/9]
 Series short description)
Message-ID: <20180515064906.GA29231@gmail.com>
References: <CAPcyv4g5p72aiXYh8Tf03tvZq8HNYmTFU95PJGG1iQ4JHcr9PA@mail.gmail.com>
 <20180514072603.GA14099@gmail.com>
 <CAPcyv4j2HQH1wdsGGWUAiXEKXeoMUWN_HeUEMmkv8PG7RUTtfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4j2HQH1wdsGGWUAiXEKXeoMUWN_HeUEMmkv8PG7RUTtfw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dan Williams <dan.j.williams@intel.com> wrote:

> On Mon, May 14, 2018 at 12:26 AM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * Dan Williams <dan.j.williams@intel.com> wrote:
> >
> >> Ingo, Thomas, Al, any concerns with this series?
> >
> > Yeah, so:
> >
> >    "[PATCH v3 0/9] Series short description"
> >
> > ... isn't the catchiest of titles to capture my [all too easily distracted]
> > attention! ;-)
> 
> My bad! After that mistake it became a toss-up between more spam and
> hoping the distraction would not throw you off.
> 
> > I have marked it now for -tip processing. Linus was happy with this and acked the
> > approach, right?
> 
> I think "happy" is a strong word when it comes to x86 machine check
> handling. My interpretation is that he and Andy acquiesced that this
> is about the best we can do with dax+mce as things stand today.

So, how would you like to go about this series?

To help move it forward I applied the first 5 commits to tip:x86/dax, on a
vanilla v4.17-rc5 base, did some minor edits to the changelogs, tested it
superficially (I don't have DAX so this essentially means build tests) and
pushed out the result.

Barring some later generic-x86 regression (unlikely) this looks good to me - feel 
free to cross-pull that branch into your DAX/nvdimm tree.

Or we could apply the remaining changes to -tip too - your call.

Thanks,

	Ingo
