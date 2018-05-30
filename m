Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932591AbeE3Wg4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:36:56 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36262 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753691AbeE3Wgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 18:36:52 -0400
X-Google-Smtp-Source: ADUXVKKL8KfewnOAAaPiSaT9j8mPkM1Sf02VY3aYpFYjh1dPKTxxwV5/dXfK4M96twS9wQWUsreK8w==
Subject: Re: [PATCH] kbuild: add machine size to CHEKCFLAGS
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20180530204838.22079-1-luc.vanoostenryck@gmail.com>
 <d47b72cc-9209-a190-38b3-969870e1bf26@suse.de>
From: Rob Landley <rob@landley.net>
Message-ID: <0dd9d6dc-6cb3-157c-33ac-8c3e449a3859@landley.net>
Date: Wed, 30 May 2018 17:36:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d47b72cc-9209-a190-38b3-969870e1bf26@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30/2018 05:00 PM, Andreas Färber wrote:
> What about the architectures not touched by your patch that previously
> had no -m32/-m64? (arc, c6x, h8300, hexagon, m68k, microblaze, nds32,
> nios2, openrisc, powerpc, riscv, s390, sh, unicore32, xtensa)
> 
> You forgot to CC them on this patch.

A) He cc'd arch/sh on the previous patch earlier today, to which I replied:

https://marc.info/?l=linux-sh&m=152769132515226&w=2

B) Every change to common infrastructure should cc: every arch? Really? So like
filesystem changes and stuff to?

> Have you really checked that all their toolchains support the -m32/-m64
> flags you newly introduce for them? Apart from non-biarch architectures,
> I'm thinking of 31-bit s390 as a corner case where !64 != 32.

1) Last I heard Linux implements lp64:
   http://www.unix.org/whitepapers/64bit.html

2) it's unlikely to be worse than it was before the patch,

3) last I checked https://github.com/landley/mkroot boots to an s390 shell
prompt under qemu, although I haven't tried building with this patch. (And you
may still need to add HOST_EXTRA='lex yacc bison flex' to the command line
unless they've re-added the _shipped versions like the old kconfig had...) Point
is, shouldn't be too hard to test it. Presumably that's why we have an -rc1 and
then 6 more -rc versions each release...

Rob
