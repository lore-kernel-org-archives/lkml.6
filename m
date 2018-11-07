Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237F2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57A720883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57A720883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeKHHq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:46:27 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45649 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbeKHHq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:46:27 -0500
Received: by mail-yw1-f66.google.com with SMTP id p18-v6so5027611ywg.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 14:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=b4/GG9xyffEJ3ZhVAfLL6/JFaDQMACXbURxU8SDqkXw=;
        b=tx4gAwl8x2ZcgBbW46hTfJtykGP6okHM8Wi0n4EAYmev4pHPzqEcBkgw99nUFGKVii
         zxFQ6wilx+uuWIqdmipd5IoXSWOZW2Izf4W7P5YZYwHHvt2+fuEEiIbajrauBiM9gr6c
         +ChlzYWZzULfwpfk1OYcKCUeVOdw+pY8gi9RC3rJLgoy3/aCBv3SQOGbC8dlSWT0Tc6g
         3KqvrPJbVH4Oykr2h71PE61upOBvCi2jVE59S6hvO248bVXOHdYgs+xa/cSbiMI+471u
         UHZL/HHmVgfYbk/wBmFh/vqAItdbzVeh1nlkc11B86S9TameAkKopOrh20RMZ8sXzjUt
         CBHg==
X-Gm-Message-State: AGRZ1gL60rxL40EJhsBweBpJDLSH07w0XeGjaQmUxcQK6GprIcg6qyeH
        kkrLsITmtU3oeL5WuM87WaHdrA==
X-Google-Smtp-Source: AJdET5fdW9YVMB3QkZ3kcTZZfhSs9Naj5IebfCgcZWf9K7jsUpVGEIAHdOpnR3gKT7G16ZxJlMLFpA==
X-Received: by 2002:a81:39d5:: with SMTP id g204-v6mr2092636ywa.408.1541628843093;
        Wed, 07 Nov 2018 14:14:03 -0800 (PST)
Received: from ceres.poochiereds.net (cpe-2606-A000-1100-DB-0-0-0-1B1.dyn6.twc.com. [2606:a000:1100:db::1b1])
        by smtp.gmail.com with ESMTPSA id m16-v6sm1746346ywh.18.2018.11.07.14.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 14:14:02 -0800 (PST)
Message-ID: <c65863175cf3ef0969caa3bf46ea3454a063546b.camel@redhat.com>
Subject: Re: [LKP] [locks] dee160df82: BUG:KASAN:null-ptr-deref_in_l
From:   Jeff Layton <jlayton@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        NeilBrown <neilb@suse.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@01.org
Date:   Wed, 07 Nov 2018 17:14:00 -0500
In-Reply-To: <20181107155441.GA21987@ulmo>
References: <20181107084306.GE24195@shao2-debian>
         <9160bff187a41ba46d2cba25bf0e78205082e516.camel@redhat.com>
         <20181107155441.GA21987@ulmo>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-07 at 16:54 +0100, Thierry Reding wrote:
> On Wed, Nov 07, 2018 at 07:01:29AM -0500, Jeff Layton wrote:
> > On Wed, 2018-11-07 at 16:43 +0800, kernel test robot wrote:
> > > FYI, we noticed the following commit (built with gcc-7):
> > > 
> > > commit: dee160df820de41ff2f59a715643680822a0ab06 ("locks: use properly initialized file_lock when unlocking.")
> > > https://git.kernel.org/cgit/linux/kernel/git/jlayton/linux.git locks-next
> > > 
> > > in testcase: boot
> > > 
> > > on test machine: qemu-system-x86_64 -enable-kvm -cpu host -smp 2 -m 2G
> > > 
> > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > 
> > > 
> > > +------------------------------------------+------------+------------+
> > > >                                          | a4399c3b7b | dee160df82 |
> > > 
> > > +------------------------------------------+------------+------------+
> > > > boot_successes                           | 6          | 2          |
> > > > boot_failures                            | 0          | 8          |
> > > > BUG:KASAN:null-ptr-deref_in_l            | 0          | 8          |
> > > > BUG:unable_to_handle_kernel              | 0          | 8          |
> > > > Oops:#[##]                               | 0          | 8          |
> > > > RIP:locks_remove_flock                   | 0          | 8          |
> > > > Kernel_panic-not_syncing:Fatal_exception | 0          | 8          |
> > > 
> > > +------------------------------------------+------------+------------+
> > > 
> > > 
> > > 
> > > [   41.286774] BUG: KASAN: null-ptr-deref in locks_remove_flock+0x147/0x180
> > > [   41.288812] Read of size 8 at addr 000000000000004e by task systemd-udevd/348
> > > [   41.290790] 
> > > [   41.291485] CPU: 0 PID: 348 Comm: systemd-udevd Not tainted 4.20.0-rc1-00006-gdee160d #154
> > > [   41.293876] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> > > [   41.296488] Call Trace:
> > > [   41.297339]  kasan_report+0x224/0x254
> > > [   41.298538]  locks_remove_flock+0x147/0x180
> > > [   41.299936]  ? flock_lock_inode+0x4b7/0x4b7
> > > [   41.301333]  ? hlock_class+0x6f/0x8d
> > > [   41.302572]  ? check_chain_key+0x102/0x15c
> > > [   41.303936]  ? __lock_acquire+0x15ee/0x16bd
> > > [   41.305240]  ? debug_show_all_locks+0x2bd/0x2bd
> > > [   41.306735]  ? lookup_chain_cache+0xc9/0x14a
> > > [   41.308147]  ? fsnotify+0x1c4/0x7ab
> > > [   41.309366]  ? lock_downgrade+0x30a/0x30a
> > > [   41.310712]  locks_remove_file+0xda/0x280
> > > [   41.312052]  ? locks_remove_posix+0x3ba/0x3ba
> > > [   41.313397]  ? __fsnotify_parent+0x82/0x1aa
> > > [   41.314571]  ? fsnotify_sb_delete+0x373/0x373
> > > [   41.315967]  ? ___might_sleep+0x12b/0x290
> > > [   41.317315]  ? in_sched_functions+0x30/0x30
> > > [   41.318701]  ? __might_sleep+0x2f/0xbf
> > > [   41.319976]  __fput+0x1a1/0x2fc
> > > [   41.321062]  ? file_free_rcu+0x62/0x62
> > > [   41.322132]  ? in_sched_functions+0x30/0x30
> > > [   41.323451]  ? mark_held_locks+0x67/0x81
> > > [   41.324770]  ? _raw_spin_unlock_irq+0x24/0x2d
> > > [   41.326202]  task_work_run+0x122/0x16c
> > > [   41.327485]  ? task_work_cancel+0x13d/0x13d
> > > [   41.328869]  ? task_work_add+0xc7/0x116
> > > [   41.330043]  ? mark_held_locks+0x67/0x81
> > > [   41.331368]  ? prepare_exit_to_usermode+0x18a/0x296
> > > [   41.332950]  prepare_exit_to_usermode+0x1d4/0x296
> > > [   41.334476]  ? enter_from_user_mode+0x2e/0x2e
> > > [   41.335893]  ? fput+0x7a/0xae
> > > [   41.336961]  ? filp_close+0xf7/0x122
> > > [   41.338196]  ? __ia32_sys_creat+0x31/0x31
> > > [   41.339543]  syscall_return_slowpath+0x23d/0x268
> > > [   41.341049]  ? prepare_exit_to_usermode+0x296/0x296
> > > [   41.342625]  ? fd_install+0x32/0x32
> > > [   41.343832]  ? ksys_write+0xf1/0x124
> > > [   41.345028]  ? mark_held_locks+0x67/0x81
> > > [   41.346310]  do_syscall_64+0xf3/0x119
> > > [   41.347573]  ? syscall_return_slowpath+0x268/0x268
> > > [   41.349075]  ? lockdep_hardirqs_off+0x103/0x129
> > > [   41.350458]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> > > [   41.351971]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > [   41.353604] RIP: 0033:0x7f31c39fe250
> > > [   41.354838] Code: 73 01 c3 48 8b 0d 58 7d 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 79 c1 20 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ee fb ff ff 48 89 04 24
> > > [   41.360261] RSP: 002b:00007fffc28371d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> > > [   41.362406] RAX: 0000000000000000 RBX: 0000000000000007 RCX: 00007f31c39fe250
> > > [   41.364543] RDX: 000000000aba9500 RSI: 0000000000000000 RDI: 0000000000000007
> > > [   41.366593] RBP: 00007f31c48b6708 R08: 0000000000000045 R09: 0000000000000018
> > > [   41.368739] R10: 00005569133cb718 R11: 0000000000000246 R12: 0000000000000000
> > > [   41.370901] R13: 00005569133c26c0 R14: 0000000000000003 R15: 000000000000000e
> > > [   41.373009] ==================================================================
> > > [   41.375220] Disabling lock debugging due to kernel taint
> > > [   41.973175] BUG: unable to handle kernel NULL pointer dereference at 000000000000024e
> > > [   41.975580] PGD 0 P4D 0 
> > > [   41.976496] Oops: 0000 [#1] KASAN PTI
> > > [   41.977678] CPU: 0 PID: 386 Comm: systemd-udevd Tainted: G    B             4.20.0-rc1-00006-gdee160d #154
> > > [   41.980388] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> > > [   41.982865] RIP: 0010:locks_remove_flock+0x147/0x180
> > > [   41.984361] Code: ff ff 4c 8d 64 24 68 49 8d bc 24 d8 00 00 00 e8 7c d2 f3 ff 48 8b ac 24 40 01 00 00 48 85 ed 74 17 48 8d 7d 08 e8 66 d2 f3 ff <48> 8b 45 08 48 85 c0 74 05 4c 89 e7 ff d0 48 b8 00 00 00 00 00 fc
> > > [   41.989211] RSP: 0018:ffff880050ae7858 EFLAGS: 00010247
> > > [   41.990806] RAX: 0000000000000007 RBX: 1ffff1000a15cf0c RCX: ffffffff8136ab82
> > > [   41.992826] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 000000000000024e
> > > [   41.994856] RBP: 0000000000000246 R08: 0000000000000007 R09: 0000000000000000
> > > [   41.996872] R10: ffff880050ae75d8 R11: ffff880050ae7b0f R12: ffff880050ae78c0
> > > [   41.998897] R13: dffffc0000000000 R14: ffff88004f658150 R15: ffff880057578d58
> > > [   42.000912] FS:  00007f31c48b68c0(0000) GS:ffffffff83ac6000(0000) knlGS:0000000000000000
> > > [   42.003090] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [   42.004780] CR2: 000000000000024e CR3: 0000000051e30004 CR4: 00000000000606b0
> > > [   42.006814] Call Trace:
> > > [   42.007697]  ? flock_lock_inode+0x4b7/0x4b7
> > > [   42.008999]  ? debug_lockdep_rcu_enabled+0x26/0x51
> > > [   42.010343]  ? debug_lockdep_rcu_enabled+0x26/0x51
> > > [   42.011765]  ? __lock_acquire+0xf7/0x16bd
> > > [   42.013024]  ? debug_lockdep_rcu_enabled+0x26/0x51
> > > [   42.014492]  ? lockdep_rcu_suspicious+0xc5/0xc5
> > > [   42.015880]  ? lock_downgrade+0x30a/0x30a
> > > [   42.017143]  ? debug_show_all_locks+0x2bd/0x2bd
> > > [   42.018424]  ? debug_lockdep_rcu_enabled+0x26/0x51
> > > [   42.019701]  ? fsnotify+0x1c4/0x7ab
> > > [   42.020841]  locks_remove_file+0xda/0x280
> > > [   42.022120]  ? locks_remove_posix+0x3ba/0x3ba
> > > [   42.023477]  ? locks_remove_posix+0x11c/0x3ba
> > > [   42.024815]  ? __fsnotify_parent+0x82/0x1aa
> > > [   42.026137]  ? fsnotify_sb_delete+0x373/0x373
> > > [   42.027495]  ? ___might_sleep+0x12b/0x290
> > > [   42.028760]  ? in_sched_functions+0x30/0x30
> > > [   42.030014]  ? __might_sleep+0x2f/0xbf
> > > [   42.031098]  __fput+0x1a1/0x2fc
> > > [   42.032150]  ? file_free_rcu+0x62/0x62
> > > [   42.033344]  ? in_sched_functions+0x30/0x30
> > > [   42.034673]  ? trace_irq_disable_rcuidle+0x1f4/0x1f4
> > > [   42.036165]  ? preempt_schedule_common+0x35/0x35
> > > [   42.037572]  ? __kasan_slab_free+0xd9/0xfa
> > > [   42.038865]  task_work_run+0x122/0x16c
> > > [   42.040067]  ? task_work_cancel+0x13d/0x13d
> > > [   42.041373]  ? task_work_add+0xc7/0x116
> > > [   42.042610]  prepare_exit_to_usermode+0x1d4/0x296
> > > [   42.044044]  ? enter_from_user_mode+0x2e/0x2e
> > > [   42.045402]  ? fput+0x7a/0xae
> > > [   42.046422]  ? filp_close+0xf7/0x122
> > > [   42.047571]  ? __ia32_sys_creat+0x31/0x31
> > > [   42.048831]  ? ptrace_report_syscall+0xad/0xad
> > > [   42.050382]  syscall_return_slowpath+0x23d/0x268
> > > [   42.051784]  ? prepare_exit_to_usermode+0x296/0x296
> > > [   42.053250]  ? fd_install+0x32/0x32
> > > [   42.054341]  ? kmem_cache_free+0xbf/0x101
> > > [   42.055620]  ? do_sys_open+0x13d/0x168
> > > [   42.056812]  do_syscall_64+0xf3/0x119
> > > [   42.057995]  ? syscall_return_slowpath+0x268/0x268
> > > [   42.059460]  ? lockdep_hardirqs_off+0x19/0x129
> > > [   42.060820]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> > > [   42.062196]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > [   42.063639] RIP: 0033:0x7f31c39fe250
> > > [   42.064798] Code: 73 01 c3 48 8b 0d 58 7d 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 79 c1 20 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ee fb ff ff 48 89 04 24
> > > [   42.069903] RSP: 002b:00007fffc28323a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> > > [   42.072126] RAX: 0000000000000000 RBX: 000000000000000f RCX: 00007f31c39fe250
> > > [   42.074153] RDX: 00007f31c39e8b58 RSI: 0000000000000000 RDI: 000000000000000f
> > > [   42.076185] RBP: 00007f31c48b6708 R08: 36b3f544af500741 R09: 0000000000000001
> > > [   42.078211] R10: 0000000000000116 R11: 0000000000000246 R12: 0000000000000002
> > > [   42.080237] R13: 0000000000000000 R14: 00005569133c1b50 R15: 000000000000000f
> > > [   42.082273] CR2: 000000000000024e
> > > [   42.083438] ---[ end trace b25bd2587e58b9b9 ]---
> > > 
> > > 
> > > To reproduce:
> > > 
> > >         git clone https://github.com/intel/lkp-tests.git
> > >         cd lkp-tests
> > >         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> > > 
> > > 
> > > 
> > > Thanks,
> > > lkp
> > 
> > Thanks LKP,
> > 
> > I think I see the problem. locks_remove_flock calls flock_make_lock and
> > passes it a pointer to a file_lock that lives on the stack. That
> > file_lock is not zeroed out beforehand, and fl_ops is not overwritten
> > during the initialization in flock_make_lock.
> > 
> > I went ahead and updated this patch to zero out the file_lock structure
> > in locks_remove_flock.
> 
> Should the zeroing out part perhaps be part of flock_make_lock()? That
> way we can either pass in fl == NULL and get the lock automatically
> allocated, or if we pass in fl != NULL and then get it zeroed out by
> flock_make_lock(), so callers don't have to bother with it.
> 
> That said, the API is not public and there's only one user, so this is
> somewhat moot.
> 

Yeah, I'm inclined to just do the minimum to fix this one up. We can
revisit it later with a cleanup patch though if we feel the need.

> In either case, I can confirm that the new version with zeroed out
> file_lock structure removes this issue that I was seeing on various
> Tegra boards, so:
> 
> Tested-by: Thierry Reding <treding@nvidia.com>

Thanks for testing it! The fix should be in the next linux-next.
-- 
Jeff Layton <jlayton@redhat.com>

