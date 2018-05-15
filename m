Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeEOWn6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:43:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750810AbeEOWn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:43:57 -0400
Date: Tue, 15 May 2018 17:43:54 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Anvin <h.peter.anvin@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Anvin <hpa@zytor.com>, tipbuild@zytor.com, LKP <lkp@01.org>
Subject: Re: [lkp-robot] [x86/asm] 51bad67ffb: int3:#[##]
Message-ID: <20180515224354.zmygmsnlqj5lrdbo@treble>
References: <20180515080033.GA7714@yexl-desktop>
 <20180515210757.GA12225@avx2>
 <C40DC70F50313144AB3AF8625D4F407F90689B42@ORSMSX101.amr.corp.intel.com>
 <20180515214337.GA18021@avx2>
 <20180515222211.ods5hzne46hozojq@treble>
 <CA+55aFw1MxjUKtrt-KyiNxmpuKUY273L5uy8ggzOFjBSYMwwog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFw1MxjUKtrt-KyiNxmpuKUY273L5uy8ggzOFjBSYMwwog@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 03:28:19PM -0700, Linus Torvalds wrote:
> On Tue, May 15, 2018 at 3:22 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > The padding isn't needed there, and the resume_userspace symbol is never
> > used, so wouldn't this fix it?
> 
> This looks like the correct fix for this case, but are we sure there aren't
> other cases where we have this same "fall through to an ENTRY" case?
> 
> Because we've definitely had that kind of code before too - sometimes
> simply because we want profiles and oopses to show which "part" of the asm
> we're faulting in (that could be the case here too).

Glancing through the 32-bit and 64-bit entry code, I didn't see any more
cases.  At least it will fail loudly if any such cases do still exist.

-- 
Josh
