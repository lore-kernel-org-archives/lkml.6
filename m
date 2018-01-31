Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751717AbeAaFm3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 00:42:29 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43314 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbeAaFm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 00:42:27 -0500
X-Google-Smtp-Source: AH8x226rcW/p4GppVZFDUpYXiJBJDe+XrDLZWEu6hRdrnHs+RmrSTowBdaeDTKdw9WbyX8KkyY5Yhg==
Date: Tue, 30 Jan 2018 21:42:24 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot <syzbot+1d7d9ce4ce4a23cb7d3b@syzkaller.appspotmail.com>
Cc: bp@suse.de, dsafonov@virtuozzo.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, me@kylehuey.com,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: WARNING in __switch_to (2)
Message-ID: <20180131054224.GB2736@zzz.localdomain>
References: <001a11449820f6ea890562004a17@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a11449820f6ea890562004a17@google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2018 at 08:58:00PM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 37759fa6d0fa9e4d6036d19ac12f555bfc0aeafd
> git://git.cmpxchg.org/linux-mmots.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+1d7d9ce4ce4a23cb7d3b@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> WARNING: CPU: 0 PID: 3192 at ./arch/x86/include/asm/fpu/internal.h:340
> paravirt_write_msr arch/x86/include/asm/paravirt.h:21 [inline]
> WARNING: CPU: 0 PID: 3192 at ./arch/x86/include/asm/fpu/internal.h:340
> wrmsrl arch/x86/include/asm/paravirt.h:149 [inline]
> WARNING: CPU: 0 PID: 3192 at ./arch/x86/include/asm/fpu/internal.h:340
> load_seg_legacy arch/x86/kernel/process_64.c:255 [inline]
> WARNING: CPU: 0 PID: 3192 at ./arch/x86/include/asm/fpu/internal.h:340
> __switch_to+0x10bd/0x13c0 arch/x86/kernel/process_64.c:455
> Kernel panic - not syncing: panic_on_warn set ...
> 
> CPU: 0 PID: 3192 Comm: syzkaller835319 Not tainted 4.15.0-rc4-mm1+ #49
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
> Shutting down cpus with NMI
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user [me m  or41y
> .3ac65ce0s98s
> ]
> Rebooting in 86400 seconds..
> ---[ end trace 2d2aa5997809e25d ]---

For some reason I'm not able to reproduce this crash with the reproducer and
commit given -- even after making sure I had set kvm_intel.nested=1 on the host
since the reproducer uses KVM.  And syzbot only hit this from Jan 1 through
Jan 3.  So I'll assume it was introduced and fixed by the x86 changes around
that time, and I'll invalidate the bug for syzbot; it will send a new report if
this crash happens again...

#syz invalid

- Eric
