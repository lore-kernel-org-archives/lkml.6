Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KsKuNxbwHFsjRwAAmS7hNA
	; Sun, 10 Jun 2018 09:32:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EB33E60850; Sun, 10 Jun 2018 09:32:16 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6KzIgvp"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FROM_EXCESS_BASE64,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BCFA86074D;
	Sun, 10 Jun 2018 09:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BCFA86074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753801AbeFJJcM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 05:32:12 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36704 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932119AbeFJJcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 05:32:08 -0400
Received: by mail-qt0-f195.google.com with SMTP id o9-v6so17656973qtp.3;
        Sun, 10 Jun 2018 02:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kx0Pmwg1V1sEJscsbWIR2QakZiZZu+NKiODMrKxnyIs=;
        b=Y6KzIgvpLwu4xN2x0Bbhh3ciwIgggMVHX/8qPc56jTj5xJEfrrW7q9axeYpZH5oIFJ
         FJNPvWwFvY904YNvLJOPSsiBPSy8lqZfcEjHb+mdPsMb7lxyK4hczlnUHrIINHIrA+MW
         pWpbFwrABzPuDqFOodFjN4JHl+G4AobIkk9bgVX8sT7Zy2ip4rEOAYr0xDyedHWPR9fB
         vimAKHSWHkoMJtmjD+nDnIPRt6KkUpZFc0f3Yt6l+MLKa8Ldqa81vwqx/x2K9bS0uKLy
         +cLUFFUs560d7DUJwyOQGqCjV4w5DsqPyNAFLus7QS6IY7v92Wmk7hR3A3h3FV2SipT9
         PhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kx0Pmwg1V1sEJscsbWIR2QakZiZZu+NKiODMrKxnyIs=;
        b=l5XOOEGXecnVAegAq4Ong2qqN/QokAUBeGs/q3q79g5X57nTJC1RZ61NZKluN/IW0U
         SVImss8wxwsbsYFR+XCTmRKDi9MxkPtsRGNXCX7ILFveVQm4kKYC2p1dxvvBSYfUD9jT
         qzedbLnXq7S/kbSirIDzMRGQjkfCZLTfTULZ3E4c7FKnnkH4aI8nSOhvC3C5EZ+0fY5k
         A2gcHq4SCBqejMs1epwpTghvB+1pxRSGO3WFxC4HDkPVQ+XrezmwABOyT0lnFP1irehg
         5YZ7ZehzHIYizoD23p6oWK0W/Ovuv+yw97Yxt5apVFEwY/Anl88AGupAj0HawG8aARd0
         H7cg==
X-Gm-Message-State: APt69E0xAI8jszxGbySEoqM2h97QCk284IpYgIKDTIyx7U2tlzS5kohe
        ycycRrIlzWiafgn9HbVfFNnzItxQQSoMtpRJvgQ=
X-Google-Smtp-Source: ADUXVKJPtE+/DBsQQ7It5tHyeL+ST1QeDoYr2eHx6qiEluzJDGgUr0Eh4jSSuhm76jtga1NAgYp90RsR1+GiuGdEAuA=
X-Received: by 2002:ac8:72d0:: with SMTP id o16-v6mr11839795qtp.7.1528623128003;
 Sun, 10 Jun 2018 02:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000092de58056e3d4b96@google.com> <10d6b170-b820-3077-8737-c9d06e98d0fb@I-love.SAKURA.ne.jp>
In-Reply-To: <10d6b170-b820-3077-8737-c9d06e98d0fb@I-love.SAKURA.ne.jp>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date: Sun, 10 Jun 2018 11:31:55 +0200
Message-ID: <CAJ+HfNhnmvTHsE7cgi8pROjprsYvCZuzZDmYmpiUx4jqtHboUw@mail.gmail.com>
Subject: Re: WARNING: kmalloc bug in xdp_umem_create
To: penguin-kernel@i-love.sakura.ne.jp
Cc: syzbot+4abadc5d69117b346506@syzkaller.appspotmail.com,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den s=C3=B6n 10 juni 2018 kl 04:53 skrev Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp>:
>
> On 2018/06/10 7:47, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    7d3bf613e99a Merge tag 'libnvdimm-for-4.18' of git://gi=
t.k..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1073f68f800=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df04d8d0a2af=
b789a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D4abadc5d69117=
b346506
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=3D13c9756f8=
00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16366f9f800=
000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the comm=
it:
> > Reported-by: syzbot+4abadc5d69117b346506@syzkaller.appspotmail.com
> >
> > random: sshd: uninitialized urandom read (32 bytes read)
> > random: sshd: uninitialized urandom read (32 bytes read)
> > random: sshd: uninitialized urandom read (32 bytes read)
> > random: sshd: uninitialized urandom read (32 bytes read)
> > random: sshd: uninitialized urandom read (32 bytes read)
> > WARNING: CPU: 1 PID: 4537 at mm/slab_common.c:996 kmalloc_slab+0x56/0x7=
0 mm/slab_common.c:996
> > Kernel panic - not syncing: panic_on_warn set ...
>
> syzbot gave up upon kmalloc(), but actually error handling path has
> NULL pointer dereference bug.
>

Thanks Tetsuo! This crash has been fixed by Daniel Borkmann in commit
c09290c56376 ("bpf, xdp: fix crash in xdp_umem_unaccount_pages").


Bj=C3=B6rn


> ----------
> #include <sys/socket.h>
> #include <unistd.h>
> #define PF_XDP 44
> #define SOL_XDP 283
> #define XDP_UMEM_REG 4
>
> int main(int argc, char *argv[])
> {
>         int fd =3D socket(PF_XDP, SOCK_RAW, 0);
>         struct xdp_umem_reg {
>                 unsigned long long addr;
>                 unsigned long long len;
>                 unsigned int chunk_size;
>                 unsigned int headroom;
>         } arg =3D {
>                 0x20000000,
>                 0x200002000,
>                 0x800,
>                 2
>         };
>         setsockopt(fd, SOL_XDP, XDP_UMEM_REG, &arg, sizeof(arg));
>         return 0;
> }
> ----------
>
> [   95.172962] WARNING: CPU: 3 PID: 2891 at mm/page_alloc.c:4065 __alloc_=
pages_nodemask+0x283/0xdf0
> [   95.175179] Modules linked in: pcspkr sg vmw_vmci i2c_piix4 sd_mod ata=
_generic pata_acpi ahci libahci vmwgfx drm_kms_helper syscopyarea sysfillre=
ct sysimgblt fb_sys_fops ttm drm ata_piix mptspi scsi_transport_spi i2c_cor=
e mptscsih e1000 mptbase libata serio_raw
> [   95.180614] CPU: 3 PID: 2891 Comm: a.out Kdump: loaded Not tainted 4.1=
7.0+ #421
> [   95.182351] Hardware name: VMware, Inc. VMware Virtual Platform/440BX =
Desktop Reference Platform, BIOS 6.00 05/19/2017
> [   95.184909] RIP: 0010:__alloc_pages_nodemask+0x283/0xdf0
> [   95.186319] Code: 00 00 04 00 41 0f 44 c6 48 3b 5c 24 78 c6 84 24 90 0=
0 00 00 00 0f 85 50 0b 00 00 41 83 fd 0a 76 1d f6 c4 02 0f 85 3b ff ff ff <=
0f> 0b e9 34 ff ff ff 0f 0b 0f 1f 40 00 e9 10 fe ff ff 0f 0b 89 c2
> [   95.190997] RSP: 0018:ffffc900008efd20 EFLAGS: 00010246
> [   95.192257] RAX: 000000000060c0c0 RBX: 0000000000000000 RCX: ffff88013=
f7fe920
> [   95.194005] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 000000000=
0000000
> [   95.195697] RBP: 000000000060c0c0 R08: 0000000000000001 R09: fffffffff=
fffef81
> [   95.197393] R10: 000000000000000d R11: 0000000000000e8c R12: 000000000=
0000001
> [   95.199084] R13: 000000000000000d R14: 000000000060c0c0 R15: 000000000=
0000000
> [   95.200735] FS:  00007f8387e61740(0000) GS:ffff88013f4c0000(0000) knlG=
S:0000000000000000
> [   95.203441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   95.205726] CR2: 0000000020000040 CR3: 0000000133e2c006 CR4: 000000000=
01606e0
> [   95.207743] Call Trace:
> [   95.208427]  ? __lock_acquire+0x22a/0x1830
> [   95.209391]  ? kmalloc_order+0x15/0x60
> [   95.210266]  ? __kmalloc+0x20a/0x210
> [   95.211104]  ? xdp_umem_create+0x16e/0x3c0
> [   95.212095]  ? xsk_setsockopt+0x153/0x1a0
> [   95.213143]  ? __sys_setsockopt+0x67/0xb0
> [   95.214058]  ? __x64_sys_setsockopt+0x1b/0x20
> [   95.215040]  ? do_syscall_64+0x4f/0x1f0
> [   95.215890]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   95.217079] irq event stamp: 5296
> [   95.217785] hardirqs last  enabled at (5295): [<ffffffff810b2a77>] __r=
aw_spin_lock_init+0x17/0x50
> [   95.220381] hardirqs last disabled at (5296): [<ffffffff81800f33>] err=
or_entry+0x73/0xc0
> [   95.222447] softirqs last  enabled at (5284): [<ffffffff81a00183>] __d=
o_softirq+0x183/0x204
> [   95.224328] softirqs last disabled at (5277): [<ffffffff81061bcd>] irq=
_exit+0xcd/0xf0
> [   95.226065] ---[ end trace 75b6f67917663997 ]---
> [   95.227250] BUG: unable to handle kernel NULL pointer dereference at 0=
000000000000060
> [   95.229101] PGD 1342eb067 P4D 1342eb067 PUD 1314a2067 PMD 0
> [   95.230398] Oops: 0002 [#1] SMP DEBUG_PAGEALLOC
> [   95.231418] CPU: 3 PID: 2891 Comm: a.out Kdump: loaded Tainted: G     =
   W         4.17.0+ #421
> [   95.233474] Hardware name: VMware, Inc. VMware Virtual Platform/440BX =
Desktop Reference Platform, BIOS 6.00 05/19/2017
> [   95.236636] RIP: 0010:xdp_umem_create+0x228/0x3c0
> [   95.237867] Code: f4 ff ff ff e8 b9 f9 ff ff 48 8b bb 90 00 00 00 e8 3=
d d9 a7 ff 48 c7 83 90 00 00 00 00 00 00 00 48 8b 43 30 8b 93 98 00 00 00 <=
f0> 48 29 50 60 48 8b 7b 30 49 63 ec e8 57 10 92 ff 48 8b 7b 38 e8
> [   95.241945] RSP: 0018:ffffc900008efe88 EFLAGS: 00010246
> [   95.243236] RAX: 0000000000000000 RBX: ffff880133401288 RCX: 000000000=
060c0c0
> [   95.244789] RDX: 0000000000200002 RSI: 0000000001000010 RDI: 000000000=
0000000
> [   95.247382] RBP: 0000000000200002 R08: 0000000000000001 R09: fffffffff=
fffef81
> [   95.249735] R10: 000000000000000d R11: 0000000000000e8c R12: 00000000f=
ffffff4
> [   95.252391] R13: 0000000000000040 R14: 0000000020000000 R15: 000000000=
00007c0
> [   95.255280] FS:  00007f8387e61740(0000) GS:ffff88013f4c0000(0000) knlG=
S:0000000000000000
> [   95.257918] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   95.260068] CR2: 0000000000000060 CR3: 0000000133e2c006 CR4: 000000000=
01606e0
> [   95.262535] Call Trace:
> [   95.263900]  ? xsk_setsockopt+0x153/0x1a0
> [   95.265495]  ? __sys_setsockopt+0x67/0xb0
> [   95.267108]  ? __x64_sys_setsockopt+0x1b/0x20
> [   95.269532]  ? do_syscall_64+0x4f/0x1f0
> [   95.271474]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   95.273292] Modules linked in: pcspkr sg vmw_vmci i2c_piix4 sd_mod ata=
_generic pata_acpi ahci libahci vmwgfx drm_kms_helper syscopyarea sysfillre=
ct sysimgblt fb_sys_fops ttm drm ata_piix mptspi scsi_transport_spi i2c_cor=
e mptscsih e1000 mptbase libata serio_raw
> [   95.279548] CR2: 0000000000000060
> [   95.281044] ---[ end trace 75b6f67917663998 ]---
> [   95.283132] RIP: 0010:xdp_umem_create+0x228/0x3c0
> [   95.285257] Code: f4 ff ff ff e8 b9 f9 ff ff 48 8b bb 90 00 00 00 e8 3=
d d9 a7 ff 48 c7 83 90 00 00 00 00 00 00 00 48 8b 43 30 8b 93 98 00 00 00 <=
f0> 48 29 50 60 48 8b 7b 30 49 63 ec e8 57 10 92 ff 48 8b 7b 38 e8
> [   95.291487] RSP: 0018:ffffc900008efe88 EFLAGS: 00010246
> [   95.293429] RAX: 0000000000000000 RBX: ffff880133401288 RCX: 000000000=
060c0c0
> [   95.295761] RDX: 0000000000200002 RSI: 0000000001000010 RDI: 000000000=
0000000
> [   95.298072] RBP: 0000000000200002 R08: 0000000000000001 R09: fffffffff=
fffef81
> [   95.300403] R10: 000000000000000d R11: 0000000000000e8c R12: 00000000f=
ffffff4
> [   95.303699] R13: 0000000000000040 R14: 0000000020000000 R15: 000000000=
00007c0
> [   95.306178] FS:  00007f8387e61740(0000) GS:ffff88013f4c0000(0000) knlG=
S:0000000000000000
> [   95.308645] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   95.310782] CR2: 0000000000000060 CR3: 0000000133e2c006 CR4: 000000000=
01606e0
>
> xdp_umem_create+0x228/0x3c0:
> arch_atomic64_sub at arch/x86/include/asm/atomic64_64.h:60
> (inlined by) atomic64_sub at include/asm-generic/atomic-instrumented.h:14=
5
> (inlined by) atomic_long_sub at include/asm-generic/atomic-long.h:199
> (inlined by) xdp_umem_unaccount_pages at net/xdp/xdp_umem.c:135
> (inlined by) xdp_umem_reg at net/xdp/xdp_umem.c:334
> (inlined by) xdp_umem_create at net/xdp/xdp_umem.c:349
