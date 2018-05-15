Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeEOW1r (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:27:47 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:51274 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbeEOW1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:27:46 -0400
X-Google-Smtp-Source: AB8JxZqEvleUv0HJdp4emb2HxCSKOPGCah+MyrUViDu7TpL1Mjb4agZSQxwOYIlGJoU+PaTA9wMU9JUeV2flmh0FE0I=
MIME-Version: 1.0
References: <20180515080033.GA7714@yexl-desktop> <20180515210757.GA12225@avx2>
 <C40DC70F50313144AB3AF8625D4F407F90689B42@ORSMSX101.amr.corp.intel.com> <20180515214337.GA18021@avx2>
In-Reply-To: <20180515214337.GA18021@avx2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 May 2018 15:27:34 -0700
Message-ID: <CA+55aFy6_fJkmuWDZC=d_WE+_oYHtXXCbb=R31jyC1qDKZ8HJw@mail.gmail.com>
Subject: Re: [lkp-robot] [x86/asm] 51bad67ffb: int3:#[##]
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Peter Anvin <h.peter.anvin@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Anvin <hpa@zytor.com>, tipbuild@zytor.com, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 2:43 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:

> It crashed into the middle of the padding.

No, the beginning of the padding. "int3" will push the return address on
the stack, so when it points to the second 'int3' instruction, it's because
the first one triggered.

                Linus
