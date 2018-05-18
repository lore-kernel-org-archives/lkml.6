Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751971AbeERHQE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:16:04 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40367 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbeERHQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:16:03 -0400
X-Google-Smtp-Source: AB8JxZq72ICvEc+7PavKeIJgeyxtTFID02frOwd3Q7Fbto55AA9wS7aBC6LUM/CySO74CLShum90hQ==
Date: Fri, 18 May 2018 09:15:59 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Anvin <h.peter.anvin@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Anvin <hpa@zytor.com>, tipbuild@zytor.com, LKP <lkp@01.org>
Subject: Re: [lkp-robot] [x86/asm] 51bad67ffb: int3:#[##]
Message-ID: <20180518071559.GA26358@gmail.com>
References: <20180515080033.GA7714@yexl-desktop>
 <20180515210757.GA12225@avx2>
 <C40DC70F50313144AB3AF8625D4F407F90689B42@ORSMSX101.amr.corp.intel.com>
 <20180515214337.GA18021@avx2>
 <20180515222211.ods5hzne46hozojq@treble>
 <CA+55aFw1MxjUKtrt-KyiNxmpuKUY273L5uy8ggzOFjBSYMwwog@mail.gmail.com>
 <20180515224354.zmygmsnlqj5lrdbo@treble>
 <CA+55aFzTpkn_fokmm+ddi+cgk5K3EOftRmPad+NkUb5W2z0Fqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzTpkn_fokmm+ddi+cgk5K3EOftRmPad+NkUb5W2z0Fqg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, May 15, 2018 at 3:43 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > Glancing through the 32-bit and 64-bit entry code, I didn't see any more
> > cases.  At least it will fail loudly if any such cases do still exist.
> 
> \Will it? Do we have objtool checks for it now?
> 
> Because without static checks, there could be things hiding that just don't
> happen normally (think compat code etc that for most people is just dead
> code).

And it's not just about infrequent uses, it's also about hard to debug crashes 
like in suspend/resume code, where people can only report "machine is dead".

So I'm not sure this side effect of turning padding into crashes is good for 
overall robustness, without static analysis finding such bugs.

Thanks,

	Ingo
