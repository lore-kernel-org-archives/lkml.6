Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeEOWwg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:52:36 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:39216 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752506AbeEOWwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:52:33 -0400
X-Google-Smtp-Source: AB8JxZoT4lCPuFjTE0lvRlTN6s4ShEoecytG46ypkXvlJRylpEEoW0tLql0rRSj8fofouu+8PvUunONxwjO9eWe5HVk=
MIME-Version: 1.0
References: <20180515080033.GA7714@yexl-desktop> <20180515210757.GA12225@avx2>
 <C40DC70F50313144AB3AF8625D4F407F90689B42@ORSMSX101.amr.corp.intel.com>
 <20180515214337.GA18021@avx2> <20180515222211.ods5hzne46hozojq@treble>
 <CA+55aFw1MxjUKtrt-KyiNxmpuKUY273L5uy8ggzOFjBSYMwwog@mail.gmail.com> <20180515224354.zmygmsnlqj5lrdbo@treble>
In-Reply-To: <20180515224354.zmygmsnlqj5lrdbo@treble>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 May 2018 15:52:21 -0700
Message-ID: <CA+55aFzTpkn_fokmm+ddi+cgk5K3EOftRmPad+NkUb5W2z0Fqg@mail.gmail.com>
Subject: Re: [lkp-robot] [x86/asm] 51bad67ffb: int3:#[##]
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Anvin <h.peter.anvin@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Anvin <hpa@zytor.com>, tipbuild@zytor.com, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 3:43 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> Glancing through the 32-bit and 64-bit entry code, I didn't see any more
> cases.  At least it will fail loudly if any such cases do still exist.

\Will it? Do we have objtool checks for it now?

Because without static checks, there could be things hiding that just don't
happen normally (think compat code etc that for most people is just dead
code).

              Linus
