Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeEOWud (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:50:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56009 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeEOWuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:50:32 -0400
X-Google-Smtp-Source: AB8JxZq00w3VsA5xNwwRB/9Rw3uMm3pN/hDJfZi4a1dXqGiJqTqHbzSqbgMg/S4b1oCMMzUQEssOxA==
Date: Wed, 16 May 2018 01:50:28 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Anvin <h.peter.anvin@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Anvin <hpa@zytor.com>, tipbuild@zytor.com, LKP <lkp@01.org>
Subject: Re: [lkp-robot] [x86/asm] 51bad67ffb: int3:#[##]
Message-ID: <20180515225028.GA21902@avx2>
References: <20180515080033.GA7714@yexl-desktop>
 <20180515210757.GA12225@avx2>
 <C40DC70F50313144AB3AF8625D4F407F90689B42@ORSMSX101.amr.corp.intel.com>
 <20180515214337.GA18021@avx2>
 <CA+55aFy6_fJkmuWDZC=d_WE+_oYHtXXCbb=R31jyC1qDKZ8HJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFy6_fJkmuWDZC=d_WE+_oYHtXXCbb=R31jyC1qDKZ8HJw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 03:27:34PM -0700, Linus Torvalds wrote:
> On Tue, May 15, 2018 at 2:43 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > It crashed into the middle of the padding.
> 
> No, the beginning of the padding. "int3" will push the return address on
> the stack, so when it points to the second 'int3' instruction, it's because
> the first one triggered.

Sending i386 patches should not be done that late...

I checked 32-bit asm as well.
