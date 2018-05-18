Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeERHST (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:18:19 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35794 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeERHSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:18:18 -0400
X-Google-Smtp-Source: AB8JxZrd4Gz5OhRd3Z+MJUoWNApKMKyJvf2X3evrpXTdu2qkTTD1LyhNg2V661wATGhXCRmQK5ilFA==
Date: Fri, 18 May 2018 09:18:14 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Anvin <h.peter.anvin@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Anvin <hpa@zytor.com>, tipbuild@zytor.com, LKP <lkp@01.org>
Subject: Re: [PATCH] objtool: Detect assembly code falling through to INT3
 padding
Message-ID: <20180518071814.GB26358@gmail.com>
References: <20180515210757.GA12225@avx2>
 <C40DC70F50313144AB3AF8625D4F407F90689B42@ORSMSX101.amr.corp.intel.com>
 <20180515214337.GA18021@avx2>
 <20180515222211.ods5hzne46hozojq@treble>
 <CA+55aFw1MxjUKtrt-KyiNxmpuKUY273L5uy8ggzOFjBSYMwwog@mail.gmail.com>
 <20180515224354.zmygmsnlqj5lrdbo@treble>
 <CA+55aFzTpkn_fokmm+ddi+cgk5K3EOftRmPad+NkUb5W2z0Fqg@mail.gmail.com>
 <CA+55aFwrT-BAvdujUonX5MvB=8GFopQJT4x6xMhtjNN2G0AxSw@mail.gmail.com>
 <20180516033044.odb74pdgcn5nacwb@treble>
 <20180517134934.eog2fgoby5azq5a7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517134934.eog2fgoby5azq5a7@treble>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> With the following commit:
> 
>   51bad67ffbce ("x86/asm: Pad assembly functions with INT3 instructions")
> 
> ... asm function alignments are padded with INT3, so it's no longer safe
> to fall through to an aligned function.  Make sure we catch any such
> cases with objtool.
> 
> Note this only adds checking for 64-bit, since objtool doesn't support
> x86-32.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/kernel/head_64.S       |  2 --
>  tools/objtool/arch.h            |  3 ++-
>  tools/objtool/arch/x86/decode.c |  2 +-
>  tools/objtool/check.c           | 11 ++++++++++-
>  4 files changed, 13 insertions(+), 5 deletions(-)

Ok, this is cool, it addresses the robustness problem that INT3 padding introduced 
very nicely.

The concept of built-in kernel tooling working at the machine code level is just 
so powerful - we should have added our own KCC compiler 20 years ago.

Thanks,

	Ingo
