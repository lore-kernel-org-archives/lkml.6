Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeCLJsp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:48:45 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34989 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeCLJsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:48:43 -0400
X-Google-Smtp-Source: AG47ELsxviIHNAtQHnA8ELe32395imCsyCWreOeLWqtmhGM3ZruluAlB1FFkQ4lxQ+VucmMZaRygvw==
Date: Mon, 12 Mar 2018 10:48:38 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>, linux-efi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: Re: [PATCH 2/5] x86/efi: Replace efi_pgd with efi_mm.pgd
Message-ID: <20180312094838.h7vm3lmssijag7la@gmail.com>
References: <20180312084500.10764-1-ard.biesheuvel@linaro.org>
 <20180312084500.10764-3-ard.biesheuvel@linaro.org>
 <20180312090220.lmohpvj62v7l2qsc@gmail.com>
 <20180312092650.nbvidgia5s5r5t7b@gmail.com>
 <CAKv+Gu8QOo67fg2Hgxz3C4bgm3Oeunf1hpdW=rrtNGUJLK4a9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8QOo67fg2Hgxz3C4bgm3Oeunf1hpdW=rrtNGUJLK4a9w@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On 12 March 2018 at 09:26, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * Ingo Molnar <mingo@kernel.org> wrote:
> >
> >> > -static pgd_t *efi_pgd;
> >> > -
> >>
> >> Hm, so there's some interaction here with:
> >>
> >>   116fef640859: x86/mm/dump_pagetables: Add the EFI pagetable to the debugfs 'page_tables' directory
> >>
> >> which is in tip:x86/mm.
> >>
> >> Could you please resolve that conflict? I'll sort out the topic branches
> >> afterwards.
> >
> > So I've resolved it the following way, I merged the conflicting commit into
> > tip:efi/core and applied the 3 unrelated patches from your series:
> >
> >  36b649760e94: efi: Use string literals for efi_char16_t variable initializers
> >  136d5d57e35c: efi/esrt: Fix handling of early ESRT table mapping
> >  7e904a91bf60: efi: Use efi_mm in x86 as well as ARM
> >  b0599e2801df: Merge branch 'x86/mm' into efi/core
> >
> > and pushed it out.
> >
> > So if you could resolve the two conflicting patches on top of 36b649760e94 then we
> > should be good going forward.
> >
> 
> By 'resolve' you mean rebase and resend, right?

Yeah.

I expected it to probably be a bit more work than a regular rebase, because we 
grew a new efi_pgd user and I didn't want to trivialize the conflict resolution 
effort - hence the 'resolve the conflict' formulation! :-)

Thanks,

	Ingo
