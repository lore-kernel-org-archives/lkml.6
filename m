Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeCLJ05 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:26:57 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:53558 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751911AbeCLJ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:26:55 -0400
X-Google-Smtp-Source: AG47ELtYq0/A/hxxrxgOYPiR+w9aReqMDLnd/O/iMTD6qVGf40tIIQKH/BpZsggmUMDA0ocViBdmXw==
Date: Mon, 12 Mar 2018 10:26:51 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>
Cc: linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: Re: [PATCH 2/5] x86/efi: Replace efi_pgd with efi_mm.pgd
Message-ID: <20180312092650.nbvidgia5s5r5t7b@gmail.com>
References: <20180312084500.10764-1-ard.biesheuvel@linaro.org>
 <20180312084500.10764-3-ard.biesheuvel@linaro.org>
 <20180312090220.lmohpvj62v7l2qsc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312090220.lmohpvj62v7l2qsc@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > -static pgd_t *efi_pgd;
> > -
> 
> Hm, so there's some interaction here with:
> 
>   116fef640859: x86/mm/dump_pagetables: Add the EFI pagetable to the debugfs 'page_tables' directory
> 
> which is in tip:x86/mm.
> 
> Could you please resolve that conflict? I'll sort out the topic branches 
> afterwards.

So I've resolved it the following way, I merged the conflicting commit into 
tip:efi/core and applied the 3 unrelated patches from your series:

 36b649760e94: efi: Use string literals for efi_char16_t variable initializers
 136d5d57e35c: efi/esrt: Fix handling of early ESRT table mapping
 7e904a91bf60: efi: Use efi_mm in x86 as well as ARM
 b0599e2801df: Merge branch 'x86/mm' into efi/core

and pushed it out.

So if you could resolve the two conflicting patches on top of 36b649760e94 then we 
should be good going forward.

Thanks,

	Ingo
