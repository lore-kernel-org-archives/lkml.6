Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeEOW2d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:28:33 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:55851 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeEOW2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:28:31 -0400
X-Google-Smtp-Source: AB8JxZr83MRvCX0iZYZTwc9zm8ltoRuLs6tRKuWy1ZKImxUsHmQDIbXGXmIMQIsYthv/GcpYzZrYg8lgeAV16mhufcQ=
MIME-Version: 1.0
References: <20180515080033.GA7714@yexl-desktop> <20180515210757.GA12225@avx2>
 <C40DC70F50313144AB3AF8625D4F407F90689B42@ORSMSX101.amr.corp.intel.com>
 <20180515214337.GA18021@avx2> <20180515222211.ods5hzne46hozojq@treble>
In-Reply-To: <20180515222211.ods5hzne46hozojq@treble>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 May 2018 15:28:19 -0700
Message-ID: <CA+55aFw1MxjUKtrt-KyiNxmpuKUY273L5uy8ggzOFjBSYMwwog@mail.gmail.com>
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

On Tue, May 15, 2018 at 3:22 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> The padding isn't needed there, and the resume_userspace symbol is never
> used, so wouldn't this fix it?

This looks like the correct fix for this case, but are we sure there aren't
other cases where we have this same "fall through to an ENTRY" case?

Because we've definitely had that kind of code before too - sometimes
simply because we want profiles and oopses to show which "part" of the asm
we're faulting in (that could be the case here too).

              Linus
