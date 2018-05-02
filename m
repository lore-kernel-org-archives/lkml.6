Return-Path: <jsimmons@infradead.org>
X-Google-Smtp-Source: AB8JxZqDKsNDjQQhsww/tvu7aCvP4SnF7ENDc35pG6C8mrO0CT+t7LwnKax7NwiPfs5qkSOnP/lf
ARC-Seal: i=1; a=rsa-sha256; t=1525284621; cv=none;
        d=google.com; s=arc-20160816;
        b=rkk1+tLJu8xE8eASpUYtrwqQNrq9KiNWZ3DqSxuQ+jIg7M+J2RNxqWepC/wl0oxAnH
         Zc9ANbcQli4heS5+RCfDCkKk1DVPULlmrJ8NZ0HPater+/lEl8orvktI2KACbGI3oYdg
         WcHlPTh4CQJcQfojyHdJ4mriZUthuEiabhDZYsTT+AWcG9QYhHeP2WrAw9nQkWfXpvnS
         dd5A9boqCnzct6GOdacXcvacAavPrZZiNGDJ/raH3g878K8Fs+UVggqbb2hYiJ9Nqtau
         8C82GmHeJ1SoKEUweA05gJQi7CibtvTKphMS5Tm5h8P/NgrURo3Dp/0V+3mc4yFEyXyP
         AVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=D5eIdhP9Fk9j4q9bqh019KYyN/C2fmOVGBqZ6ZJW+4Y=;
        b=NeV0WLmgIu8Ba2qOtNb3H9amdXA3x+Aj0IN9KscPKscLX/xAdBYww7Z/RQskcKn/Q4
         BWrxEzNg4p7udpuUUHiZ8tj5Pu7YF6LPi50GWvBazCyLE+T4ukuut1u3Zi0ztwFDUeu1
         5kjwaqLAWDWLpQnvK1mguiOKfM2UolzhItyE+gBeFtRxQzd1k2QdS5W9gBG1SVftjONU
         VuKTYVki8tkPhUS6rZzLKlBAiAMkvAgJQFKS5BgaNP10cERTxaUXecMGQRQtyR+EseKD
         H1uetdcHLizFxM8xw4+qNRCjfIniC+o0C1ZE9hqkAilPQ38EHbaLmbTkVXqfnqZjvPpI
         LOkA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=P7aXt6YH;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=P7aXt6YH;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Date: Wed, 2 May 2018 19:10:15 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Fengguang Wu <fengguang.wu@intel.com>
cc: lustre-devel@lists.lustre.org, Oleg Drokin <oleg.drokin@intel.com>,
    Andreas Dilger <andreas.dilger@intel.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Linus Torvalds <torvalds@linux-foundation.org>, devel@driverdev.osuosl.org,
    linux-kernel@vger.kernel.org, lkp@01.org
Subject: Re: [lustre_init] BUG: unable to handle kernel NULL pointer dereference
 at 0000000000000004
In-Reply-To: <20180502122749.vwak4yuerrzzbme6@wfg-t540p.sh.intel.com>
Message-ID: <alpine.LFD.2.21.1805021907400.24633@casper.infradead.org>
References: <20180502122749.vwak4yuerrzzbme6@wfg-t540p.sh.intel.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180502_191015_212769_CE909D3F 
X-CRM114-Status: GOOD (  12.87  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: SpamAssassin version 3.4.1 on casper.infradead.org summary:
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599355318480008040?=
X-GMAIL-MSGID: =?utf-8?q?1599376847379389853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> Hello,
> 
> FYI this happens in mainline kernel 4.17.0-rc3.
> It looks like a new regression since v4.17-rc1.
> 
> It occurs in 2 out of 2 boots.
> 
> [   54.222599]   Magic number: 14:276:994
> [   54.223261] tty ttyd7: hash matches
> [   54.223841] tty ttyaa: hash matches
> [   54.227288] Lustre: Lustre: Build Version: 2.6.99
> [   54.232977] LustreError: 1:0:(class_obd.c:465:obdclass_init()) cannot register 241 err -16

This looks like the misc register bug that is now fixed in the 
staging-test branch. Can you try 

git commit ba833f145745c5ca4d1d45b1de2541fe34b8f100 (staging: lustre: 
libcfs: use  dynamic minors for /dev/{lnet, obd})

from the staging-test branch to see if it resolves your problems?

> [   54.236561] BUG: unable to handle kernel NULL pointer dereference at 0000000000000004
> [   54.237836] PGD 0 P4D 0
> [   54.238266] Oops: 0000 [#1] SMP
> [   54.238780] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc3 #1
> [   54.239775] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   54.241214] RIP: 0010:kmem_cache_alloc+0x27/0x2ce:
> 						slob_alloc_node at mm/slob.c:546
> 						 (inlined by) kmem_cache_alloc at mm/slob.c:567
> [   54.241956] RSP: 0000:ffff88001d21bde8 EFLAGS: 00010246
> [   54.242791] RAX: 0000000000000000 RBX: 0000000001408040 RCX: 0000000000000000
> [   54.243933] RDX: ffff88001d216000 RSI: 0000000000000000 RDI: ffffffff83752918
> [   54.245072] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [   54.246213] R10: 0000000000000000 R11: 0000000000000020 R12: 00000000a0000000
> [   54.247337] R13: 0000000000000000 R14: 00000000a0000000 R15: ffffffff8407cb7e
> [   54.248613] FS:  0000000000000000(0000) GS:ffff88001e400000(0000) knlGS:0000000000000000
> [   54.249887] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   54.250803] CR2: 0000000000000004 CR3: 0000000003269000 CR4: 00000000000006a0
> [   54.251939] Call Trace:
> [   54.252358]  ? native_patch+0x195/0x195:
> 						__raw_callee_save___native_queued_spin_unlock at ??:?
> [   54.252976]  ? lustre_init+0x189/0x247:
> 						IS_ERR at include/linux/err.h:36
> 						 (inlined by) lustre_init at drivers/staging/lustre/lustre/llite/super25.c:133
> [   54.253590]  cl_env_new+0x2b/0xb9:
> 						cl_env_new at drivers/staging/lustre/lustre/obdclass/cl_object.c:597
> [   54.254126]  cl_env_alloc+0x11/0xae:
> 						IS_ERR at include/linux/err.h:36
> 						 (inlined by) cl_env_alloc at drivers/staging/lustre/lustre/obdclass/cl_object.c:718
> [   54.254713]  ? lmv_init+0x2d/0x2d:
> 						cfs_cdebug_show at drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h:111
> 						 (inlined by) lustre_init at drivers/staging/lustre/lustre/llite/super25.c:97
> [   54.255259]  lustre_init+0x189/0x247:
> 						IS_ERR at include/linux/err.h:36
> 						 (inlined by) lustre_init at drivers/staging/lustre/lustre/llite/super25.c:133
> [   54.255839]  do_one_initcall+0x13d/0x36c:
> 						__read_once_size at include/linux/compiler.h:188
> 						 (inlined by) arch_atomic_read at arch/x86/include/asm/atomic.h:31
> 						 (inlined by) atomic_read at include/asm-generic/atomic-instrumented.h:22
> 						 (inlined by) static_key_count at include/linux/jump_label.h:194
> 						 (inlined by) static_key_false at include/linux/jump_label.h:206
> 						 (inlined by) trace_initcall_finish at include/trace/events/initcall.h:44
> 						 (inlined by) do_one_initcall at init/main.c:884
> [   54.256597]  ? parse_args+0x81/0x273:
> 						arch_local_save_flags at arch/x86/include/asm/paravirt.h:778
> 						 (inlined by) parse_args at kernel/params.c:190
> [   54.257177]  ? do_early_param+0x88/0x88:
> 						repair_env_string at init/main.c:251
> [   54.257791]  kernel_init_freeable+0x338/0x3d3:
> 						do_initcall_level at init/main.c:950
> 						 (inlined by) do_initcalls at init/main.c:959
> 						 (inlined by) do_basic_setup at init/main.c:977
> 						 (inlined by) kernel_init_freeable at init/main.c:1127
> [   54.258492]  ? rest_init+0x13c/0x13c:
> 						kernel_init at init/main.c:1053
> [   54.259068]  kernel_init+0x5/0xe6:
> 						kernel_init at init/main.c:1055
> [   54.259609]  ret_from_fork+0x1f/0x30:
> 						ret_from_fork at arch/x86/entry/entry_64.S:418
> [   54.260189] Code: 0c 31 c0 c3 41 57 41 56 41 55 41 54 55 53 48 89 fd 48 83 ec 18 8b 1d 52 2e 6b 02 21 f3 89 df e8 90 0c fb ff 89 df e8 b9 0c fb ff <8b> 7d 04 81 ff ff 0f 00 00 0f 87 f3 00 00 00 8b 55 08 89 de e8
> [   54.263237] RIP: kmem_cache_alloc+0x27/0x2ce:
> 						slob_alloc_node at mm/slob.c:546
> 						 (inlined by) kmem_cache_alloc at mm/slob.c:567 RSP: ffff88001d21bde8
> [   54.264322] CR2: 0000000000000004
> [   54.264865] ---[ end trace 612192cbc2d7395d ]---
> [   54.265604] Kernel panic - not syncing: Fatal exception
> 
> Attached the full dmesg, kconfig and reproduce scripts.
> 
> Thanks,
> Fengguang
> 
