Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bSbfJoWRHFuONQAAmS7hNA
	; Sun, 10 Jun 2018 02:48:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7F642608BF; Sun, 10 Jun 2018 02:48:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0A3F260351;
	Sun, 10 Jun 2018 02:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A3F260351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932137AbeFJCse (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 22:48:34 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:36267 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753615AbeFJCsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 22:48:32 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5A2mIk1073111;
        Sun, 10 Jun 2018 11:48:18 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Sun, 10 Jun 2018 11:48:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5A2mICB073105
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 10 Jun 2018 11:48:18 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: WARNING: kmalloc bug in xdp_umem_create
To: syzbot <syzbot+4abadc5d69117b346506@syzkaller.appspotmail.com>,
        bjorn.topel@intel.com, magnus.karlsson@intel.com
References: <00000000000092de58056e3d4b96@google.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <10d6b170-b820-3077-8737-c9d06e98d0fb@I-love.SAKURA.ne.jp>
Date: Sun, 10 Jun 2018 11:48:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <00000000000092de58056e3d4b96@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/10 7:47, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    7d3bf613e99a Merge tag 'libnvdimm-for-4.18' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1073f68f800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f04d8d0a2afb789a
> dashboard link: https://syzkaller.appspot.com/bug?extid=4abadc5d69117b346506
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=13c9756f800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16366f9f800000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4abadc5d69117b346506@syzkaller.appspotmail.com
> 
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> WARNING: CPU: 1 PID: 4537 at mm/slab_common.c:996 kmalloc_slab+0x56/0x70 mm/slab_common.c:996
> Kernel panic - not syncing: panic_on_warn set ...

syzbot gave up upon kmalloc(), but actually error handling path has
NULL pointer dereference bug.

----------
#include <sys/socket.h>
#include <unistd.h>
#define PF_XDP 44
#define SOL_XDP 283
#define XDP_UMEM_REG 4

int main(int argc, char *argv[])
{
	int fd = socket(PF_XDP, SOCK_RAW, 0);
	struct xdp_umem_reg {
		unsigned long long addr;
		unsigned long long len;
		unsigned int chunk_size;
		unsigned int headroom;
	} arg = {
		0x20000000,
		0x200002000,
		0x800,
		2
	};
	setsockopt(fd, SOL_XDP, XDP_UMEM_REG, &arg, sizeof(arg));
	return 0;
}
----------

[   95.172962] WARNING: CPU: 3 PID: 2891 at mm/page_alloc.c:4065 __alloc_pages_nodemask+0x283/0xdf0
[   95.175179] Modules linked in: pcspkr sg vmw_vmci i2c_piix4 sd_mod ata_generic pata_acpi ahci libahci vmwgfx drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm ata_piix mptspi scsi_transport_spi i2c_core mptscsih e1000 mptbase libata serio_raw
[   95.180614] CPU: 3 PID: 2891 Comm: a.out Kdump: loaded Not tainted 4.17.0+ #421
[   95.182351] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
[   95.184909] RIP: 0010:__alloc_pages_nodemask+0x283/0xdf0
[   95.186319] Code: 00 00 04 00 41 0f 44 c6 48 3b 5c 24 78 c6 84 24 90 00 00 00 00 0f 85 50 0b 00 00 41 83 fd 0a 76 1d f6 c4 02 0f 85 3b ff ff ff <0f> 0b e9 34 ff ff ff 0f 0b 0f 1f 40 00 e9 10 fe ff ff 0f 0b 89 c2
[   95.190997] RSP: 0018:ffffc900008efd20 EFLAGS: 00010246
[   95.192257] RAX: 000000000060c0c0 RBX: 0000000000000000 RCX: ffff88013f7fe920
[   95.194005] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
[   95.195697] RBP: 000000000060c0c0 R08: 0000000000000001 R09: ffffffffffffef81
[   95.197393] R10: 000000000000000d R11: 0000000000000e8c R12: 0000000000000001
[   95.199084] R13: 000000000000000d R14: 000000000060c0c0 R15: 0000000000000000
[   95.200735] FS:  00007f8387e61740(0000) GS:ffff88013f4c0000(0000) knlGS:0000000000000000
[   95.203441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   95.205726] CR2: 0000000020000040 CR3: 0000000133e2c006 CR4: 00000000001606e0
[   95.207743] Call Trace:
[   95.208427]  ? __lock_acquire+0x22a/0x1830
[   95.209391]  ? kmalloc_order+0x15/0x60
[   95.210266]  ? __kmalloc+0x20a/0x210
[   95.211104]  ? xdp_umem_create+0x16e/0x3c0
[   95.212095]  ? xsk_setsockopt+0x153/0x1a0
[   95.213143]  ? __sys_setsockopt+0x67/0xb0
[   95.214058]  ? __x64_sys_setsockopt+0x1b/0x20
[   95.215040]  ? do_syscall_64+0x4f/0x1f0
[   95.215890]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   95.217079] irq event stamp: 5296
[   95.217785] hardirqs last  enabled at (5295): [<ffffffff810b2a77>] __raw_spin_lock_init+0x17/0x50
[   95.220381] hardirqs last disabled at (5296): [<ffffffff81800f33>] error_entry+0x73/0xc0
[   95.222447] softirqs last  enabled at (5284): [<ffffffff81a00183>] __do_softirq+0x183/0x204
[   95.224328] softirqs last disabled at (5277): [<ffffffff81061bcd>] irq_exit+0xcd/0xf0
[   95.226065] ---[ end trace 75b6f67917663997 ]---
[   95.227250] BUG: unable to handle kernel NULL pointer dereference at 0000000000000060
[   95.229101] PGD 1342eb067 P4D 1342eb067 PUD 1314a2067 PMD 0
[   95.230398] Oops: 0002 [#1] SMP DEBUG_PAGEALLOC
[   95.231418] CPU: 3 PID: 2891 Comm: a.out Kdump: loaded Tainted: G        W         4.17.0+ #421
[   95.233474] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
[   95.236636] RIP: 0010:xdp_umem_create+0x228/0x3c0
[   95.237867] Code: f4 ff ff ff e8 b9 f9 ff ff 48 8b bb 90 00 00 00 e8 3d d9 a7 ff 48 c7 83 90 00 00 00 00 00 00 00 48 8b 43 30 8b 93 98 00 00 00 <f0> 48 29 50 60 48 8b 7b 30 49 63 ec e8 57 10 92 ff 48 8b 7b 38 e8
[   95.241945] RSP: 0018:ffffc900008efe88 EFLAGS: 00010246
[   95.243236] RAX: 0000000000000000 RBX: ffff880133401288 RCX: 000000000060c0c0
[   95.244789] RDX: 0000000000200002 RSI: 0000000001000010 RDI: 0000000000000000
[   95.247382] RBP: 0000000000200002 R08: 0000000000000001 R09: ffffffffffffef81
[   95.249735] R10: 000000000000000d R11: 0000000000000e8c R12: 00000000fffffff4
[   95.252391] R13: 0000000000000040 R14: 0000000020000000 R15: 00000000000007c0
[   95.255280] FS:  00007f8387e61740(0000) GS:ffff88013f4c0000(0000) knlGS:0000000000000000
[   95.257918] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   95.260068] CR2: 0000000000000060 CR3: 0000000133e2c006 CR4: 00000000001606e0
[   95.262535] Call Trace:
[   95.263900]  ? xsk_setsockopt+0x153/0x1a0
[   95.265495]  ? __sys_setsockopt+0x67/0xb0
[   95.267108]  ? __x64_sys_setsockopt+0x1b/0x20
[   95.269532]  ? do_syscall_64+0x4f/0x1f0
[   95.271474]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   95.273292] Modules linked in: pcspkr sg vmw_vmci i2c_piix4 sd_mod ata_generic pata_acpi ahci libahci vmwgfx drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm ata_piix mptspi scsi_transport_spi i2c_core mptscsih e1000 mptbase libata serio_raw
[   95.279548] CR2: 0000000000000060
[   95.281044] ---[ end trace 75b6f67917663998 ]---
[   95.283132] RIP: 0010:xdp_umem_create+0x228/0x3c0
[   95.285257] Code: f4 ff ff ff e8 b9 f9 ff ff 48 8b bb 90 00 00 00 e8 3d d9 a7 ff 48 c7 83 90 00 00 00 00 00 00 00 48 8b 43 30 8b 93 98 00 00 00 <f0> 48 29 50 60 48 8b 7b 30 49 63 ec e8 57 10 92 ff 48 8b 7b 38 e8
[   95.291487] RSP: 0018:ffffc900008efe88 EFLAGS: 00010246
[   95.293429] RAX: 0000000000000000 RBX: ffff880133401288 RCX: 000000000060c0c0
[   95.295761] RDX: 0000000000200002 RSI: 0000000001000010 RDI: 0000000000000000
[   95.298072] RBP: 0000000000200002 R08: 0000000000000001 R09: ffffffffffffef81
[   95.300403] R10: 000000000000000d R11: 0000000000000e8c R12: 00000000fffffff4
[   95.303699] R13: 0000000000000040 R14: 0000000020000000 R15: 00000000000007c0
[   95.306178] FS:  00007f8387e61740(0000) GS:ffff88013f4c0000(0000) knlGS:0000000000000000
[   95.308645] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   95.310782] CR2: 0000000000000060 CR3: 0000000133e2c006 CR4: 00000000001606e0

xdp_umem_create+0x228/0x3c0:
arch_atomic64_sub at arch/x86/include/asm/atomic64_64.h:60
(inlined by) atomic64_sub at include/asm-generic/atomic-instrumented.h:145
(inlined by) atomic_long_sub at include/asm-generic/atomic-long.h:199
(inlined by) xdp_umem_unaccount_pages at net/xdp/xdp_umem.c:135
(inlined by) xdp_umem_reg at net/xdp/xdp_umem.c:334
(inlined by) xdp_umem_create at net/xdp/xdp_umem.c:349
