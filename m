Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754301AbeBGSNi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 13:13:38 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:53097 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753859AbeBGSNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 13:13:36 -0500
X-Google-Smtp-Source: AH8x226UWq3h3t6E+eFvtMKnts52Yr1jD5TZP9NUjx21itS5UO+Mi+NMzxUunp+zj1lXEf8mv0Bnq9K3ywluZecbri0=
MIME-Version: 1.0
In-Reply-To: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
References: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Feb 2018 10:13:35 -0800
X-Google-Sender-Auth: DvtJxkXI6tUJjqXx4INCuA7SquU
Message-ID: <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com>
Subject: Re: [linus:master] BUILD REGRESSION a2e5790d841658485d642196dbb0927303d6c22f
To: kbuild test robot <fengguang.wu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding more people for this funky warning from the kbuild robot.

Something is confused. UD0 is 0f ff, the bytes after that shouldn't
matter. But I guess they can be interpreted as modrm bytes, and
somebody started doing that.

That said, intel only _documents_ UD2 (0f 0b).

Maybe we should avoid using UD0/UD1 entirely.

              Linus

On Wed, Feb 7, 2018 at 3:44 AM, kbuild test robot
<fengguang.wu@intel.com> wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> branch HEAD: a2e5790d841658485d642196dbb0927303d6c22f  Merge branch 'akpm' (patches from Andrew)
>
> Regressions in current branch:
>
> arch/x86/tools/insn_decoder_test: warning: ffffffff810010d7:    0f ff eb                ud0    %ebx,%ebp
> arch/x86/tools/insn_decoder_test: warning: ffffffff81001152:    0f ff bf 09 00 00 00    ud0    0x9(%rdi),%edi
> arch/x86/tools/insn_decoder_test: warning: ffffffff81001275:    0f ff eb                ud0    %ebx,%ebp
> arch/x86/tools/insn_decoder_test: warning: ffffffff810013fd:    0f ff bf 09 00 00 00    ud0    0x9(%rdi),%edi
> arch/x86/tools/insn_decoder_test: warning: ffffffff81001499:    0f ff bf 09 00 00 00    ud0    0x9(%rdi),%edi
> arch/x86/tools/insn_decoder_test: warning: ffffffff812296eb:    0f ff e8                ud0    %eax,%ebp
