Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D934FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC7520883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRL0Qzlf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC7520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbeKHBZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:25:42 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36871 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbeKHBZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:25:42 -0500
Received: by mail-ed1-f67.google.com with SMTP id y10-v6so7313209edr.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 07:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5V6mxmTM5SS4XOenlai8zYDjGSKsN4NWZRwiSWuL5xo=;
        b=qRL0QzlfG9M72pJ96KD+AFewQYBKSH+Dj57NXv+6pVzkQXPOJhfSOOmTvhnMVQej5n
         eZhXa0Tc0bo7UpVIpENS0ayX+iqcU1DqzWlSWwBbdmBHl6h7CijdzCNJ+Z8S41t5ZnMh
         ywg4bKXZjNmIswL4VvBKeQtEHu0rDU+Rn1L7a9BkqDZVaECkIUz+OOkt3oY7ntMl+pHv
         7JQkENZvA19w6B1rJPFNvW7m5h3fynrZLqEqWXuj/vz8saZzMqQbA8atSz6eKANerp27
         g7wyV7hC+kioZ/NpRPFHXxPQiZeafxEmlfiWA/1GVUdTl/QqkXhp6TNPiIE3rAY0UvhF
         2BXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5V6mxmTM5SS4XOenlai8zYDjGSKsN4NWZRwiSWuL5xo=;
        b=aaUr12HWeKVL8fV123VGgnIhQtc0QEQxVvgbNstzA/JBXRJGuEblIqeQe3k+T2olZO
         1dYBQdmR6FT4alpjfLY3Yg9XbrlnWwYIODpup7U9kA/CeRsp2GhchRV/hkcF9q4+Rc35
         ngIIiRXKx/0zTIO/FG1nszudPOuADp9hGbGzsLEG7673AqsBfPs0qNdf6Qrx0ri7RiUf
         4R/CdefOqsDNI6sJeYF+jqFAKeAyoRHd7/PW4yLtMNywWYllw+Eqf6HBoOFY8ufjefqM
         ISRyT5JYmAG4vsgpQ5VM7DpJGYdvqYzbhQJ9DbLrozDHBb/NiW4yarq4/Kfy9NgfOOxx
         Qqwg==
X-Gm-Message-State: AGRZ1gKZyQCypRbZWj4whUh2QbcrU/LZWF9wvTRJ+DCghzzDVr/Vg+k1
        cNGMO1kQZssyAY5+royZ6+w=
X-Google-Smtp-Source: AJdET5edLUMEPb6Bn5kgaV0zVHvA6YKMRvXtRtJE/BMCpLx9R8YZqbZwKYsn6nQCKC83ypsF/Juy4g==
X-Received: by 2002:a50:be4c:: with SMTP id b12-v6mr644604edi.46.1541606083444;
        Wed, 07 Nov 2018 07:54:43 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id o26-v6sm188962eju.72.2018.11.07.07.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 07:54:42 -0800 (PST)
Date:   Wed, 7 Nov 2018 16:54:41 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        NeilBrown <neilb@suse.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@01.org
Subject: Re: [LKP] [locks] dee160df82: BUG:KASAN:null-ptr-deref_in_l
Message-ID: <20181107155441.GA21987@ulmo>
References: <20181107084306.GE24195@shao2-debian>
 <9160bff187a41ba46d2cba25bf0e78205082e516.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <9160bff187a41ba46d2cba25bf0e78205082e516.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 07:01:29AM -0500, Jeff Layton wrote:
> On Wed, 2018-11-07 at 16:43 +0800, kernel test robot wrote:
> > FYI, we noticed the following commit (built with gcc-7):
> >=20
> > commit: dee160df820de41ff2f59a715643680822a0ab06 ("locks: use properly =
initialized file_lock when unlocking.")
> > https://git.kernel.org/cgit/linux/kernel/git/jlayton/linux.git locks-ne=
xt
> >=20
> > in testcase: boot
> >=20
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu host -smp 2 -m 2G
> >=20
> > caused below changes (please refer to attached dmesg/kmsg for entire lo=
g/backtrace):
> >=20
> >=20
> > +------------------------------------------+------------+------------+
> > >                                          | a4399c3b7b | dee160df82 |
> >=20
> > +------------------------------------------+------------+------------+
> > > boot_successes                           | 6          | 2          |
> > > boot_failures                            | 0          | 8          |
> > > BUG:KASAN:null-ptr-deref_in_l            | 0          | 8          |
> > > BUG:unable_to_handle_kernel              | 0          | 8          |
> > > Oops:#[##]                               | 0          | 8          |
> > > RIP:locks_remove_flock                   | 0          | 8          |
> > > Kernel_panic-not_syncing:Fatal_exception | 0          | 8          |
> >=20
> > +------------------------------------------+------------+------------+
> >=20
> >=20
> >=20
> > [   41.286774] BUG: KASAN: null-ptr-deref in locks_remove_flock+0x147/0=
x180
> > [   41.288812] Read of size 8 at addr 000000000000004e by task systemd-=
udevd/348
> > [   41.290790]=20
> > [   41.291485] CPU: 0 PID: 348 Comm: systemd-udevd Not tainted 4.20.0-r=
c1-00006-gdee160d #154
> > [   41.293876] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.10.2-1 04/01/2014
> > [   41.296488] Call Trace:
> > [   41.297339]  kasan_report+0x224/0x254
> > [   41.298538]  locks_remove_flock+0x147/0x180
> > [   41.299936]  ? flock_lock_inode+0x4b7/0x4b7
> > [   41.301333]  ? hlock_class+0x6f/0x8d
> > [   41.302572]  ? check_chain_key+0x102/0x15c
> > [   41.303936]  ? __lock_acquire+0x15ee/0x16bd
> > [   41.305240]  ? debug_show_all_locks+0x2bd/0x2bd
> > [   41.306735]  ? lookup_chain_cache+0xc9/0x14a
> > [   41.308147]  ? fsnotify+0x1c4/0x7ab
> > [   41.309366]  ? lock_downgrade+0x30a/0x30a
> > [   41.310712]  locks_remove_file+0xda/0x280
> > [   41.312052]  ? locks_remove_posix+0x3ba/0x3ba
> > [   41.313397]  ? __fsnotify_parent+0x82/0x1aa
> > [   41.314571]  ? fsnotify_sb_delete+0x373/0x373
> > [   41.315967]  ? ___might_sleep+0x12b/0x290
> > [   41.317315]  ? in_sched_functions+0x30/0x30
> > [   41.318701]  ? __might_sleep+0x2f/0xbf
> > [   41.319976]  __fput+0x1a1/0x2fc
> > [   41.321062]  ? file_free_rcu+0x62/0x62
> > [   41.322132]  ? in_sched_functions+0x30/0x30
> > [   41.323451]  ? mark_held_locks+0x67/0x81
> > [   41.324770]  ? _raw_spin_unlock_irq+0x24/0x2d
> > [   41.326202]  task_work_run+0x122/0x16c
> > [   41.327485]  ? task_work_cancel+0x13d/0x13d
> > [   41.328869]  ? task_work_add+0xc7/0x116
> > [   41.330043]  ? mark_held_locks+0x67/0x81
> > [   41.331368]  ? prepare_exit_to_usermode+0x18a/0x296
> > [   41.332950]  prepare_exit_to_usermode+0x1d4/0x296
> > [   41.334476]  ? enter_from_user_mode+0x2e/0x2e
> > [   41.335893]  ? fput+0x7a/0xae
> > [   41.336961]  ? filp_close+0xf7/0x122
> > [   41.338196]  ? __ia32_sys_creat+0x31/0x31
> > [   41.339543]  syscall_return_slowpath+0x23d/0x268
> > [   41.341049]  ? prepare_exit_to_usermode+0x296/0x296
> > [   41.342625]  ? fd_install+0x32/0x32
> > [   41.343832]  ? ksys_write+0xf1/0x124
> > [   41.345028]  ? mark_held_locks+0x67/0x81
> > [   41.346310]  do_syscall_64+0xf3/0x119
> > [   41.347573]  ? syscall_return_slowpath+0x268/0x268
> > [   41.349075]  ? lockdep_hardirqs_off+0x103/0x129
> > [   41.350458]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> > [   41.351971]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > [   41.353604] RIP: 0033:0x7f31c39fe250
> > [   41.354838] Code: 73 01 c3 48 8b 0d 58 7d 20 00 f7 d8 64 89 01 48 83=
 c8 ff c3 66 0f 1f 44 00 00 83 3d 79 c1 20 00 00 75 10 b8 03 00 00 00 0f 05=
 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ee fb ff ff 48 89 04 24
> > [   41.360261] RSP: 002b:00007fffc28371d8 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000003
> > [   41.362406] RAX: 0000000000000000 RBX: 0000000000000007 RCX: 00007f3=
1c39fe250
> > [   41.364543] RDX: 000000000aba9500 RSI: 0000000000000000 RDI: 0000000=
000000007
> > [   41.366593] RBP: 00007f31c48b6708 R08: 0000000000000045 R09: 0000000=
000000018
> > [   41.368739] R10: 00005569133cb718 R11: 0000000000000246 R12: 0000000=
000000000
> > [   41.370901] R13: 00005569133c26c0 R14: 0000000000000003 R15: 0000000=
00000000e
> > [   41.373009] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   41.375220] Disabling lock debugging due to kernel taint
> > [   41.973175] BUG: unable to handle kernel NULL pointer dereference at=
 000000000000024e
> > [   41.975580] PGD 0 P4D 0=20
> > [   41.976496] Oops: 0000 [#1] KASAN PTI
> > [   41.977678] CPU: 0 PID: 386 Comm: systemd-udevd Tainted: G    B     =
        4.20.0-rc1-00006-gdee160d #154
> > [   41.980388] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.10.2-1 04/01/2014
> > [   41.982865] RIP: 0010:locks_remove_flock+0x147/0x180
> > [   41.984361] Code: ff ff 4c 8d 64 24 68 49 8d bc 24 d8 00 00 00 e8 7c=
 d2 f3 ff 48 8b ac 24 40 01 00 00 48 85 ed 74 17 48 8d 7d 08 e8 66 d2 f3 ff=
 <48> 8b 45 08 48 85 c0 74 05 4c 89 e7 ff d0 48 b8 00 00 00 00 00 fc
> > [   41.989211] RSP: 0018:ffff880050ae7858 EFLAGS: 00010247
> > [   41.990806] RAX: 0000000000000007 RBX: 1ffff1000a15cf0c RCX: fffffff=
f8136ab82
> > [   41.992826] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000=
00000024e
> > [   41.994856] RBP: 0000000000000246 R08: 0000000000000007 R09: 0000000=
000000000
> > [   41.996872] R10: ffff880050ae75d8 R11: ffff880050ae7b0f R12: ffff880=
050ae78c0
> > [   41.998897] R13: dffffc0000000000 R14: ffff88004f658150 R15: ffff880=
057578d58
> > [   42.000912] FS:  00007f31c48b68c0(0000) GS:ffffffff83ac6000(0000) kn=
lGS:0000000000000000
> > [   42.003090] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   42.004780] CR2: 000000000000024e CR3: 0000000051e30004 CR4: 0000000=
0000606b0
> > [   42.006814] Call Trace:
> > [   42.007697]  ? flock_lock_inode+0x4b7/0x4b7
> > [   42.008999]  ? debug_lockdep_rcu_enabled+0x26/0x51
> > [   42.010343]  ? debug_lockdep_rcu_enabled+0x26/0x51
> > [   42.011765]  ? __lock_acquire+0xf7/0x16bd
> > [   42.013024]  ? debug_lockdep_rcu_enabled+0x26/0x51
> > [   42.014492]  ? lockdep_rcu_suspicious+0xc5/0xc5
> > [   42.015880]  ? lock_downgrade+0x30a/0x30a
> > [   42.017143]  ? debug_show_all_locks+0x2bd/0x2bd
> > [   42.018424]  ? debug_lockdep_rcu_enabled+0x26/0x51
> > [   42.019701]  ? fsnotify+0x1c4/0x7ab
> > [   42.020841]  locks_remove_file+0xda/0x280
> > [   42.022120]  ? locks_remove_posix+0x3ba/0x3ba
> > [   42.023477]  ? locks_remove_posix+0x11c/0x3ba
> > [   42.024815]  ? __fsnotify_parent+0x82/0x1aa
> > [   42.026137]  ? fsnotify_sb_delete+0x373/0x373
> > [   42.027495]  ? ___might_sleep+0x12b/0x290
> > [   42.028760]  ? in_sched_functions+0x30/0x30
> > [   42.030014]  ? __might_sleep+0x2f/0xbf
> > [   42.031098]  __fput+0x1a1/0x2fc
> > [   42.032150]  ? file_free_rcu+0x62/0x62
> > [   42.033344]  ? in_sched_functions+0x30/0x30
> > [   42.034673]  ? trace_irq_disable_rcuidle+0x1f4/0x1f4
> > [   42.036165]  ? preempt_schedule_common+0x35/0x35
> > [   42.037572]  ? __kasan_slab_free+0xd9/0xfa
> > [   42.038865]  task_work_run+0x122/0x16c
> > [   42.040067]  ? task_work_cancel+0x13d/0x13d
> > [   42.041373]  ? task_work_add+0xc7/0x116
> > [   42.042610]  prepare_exit_to_usermode+0x1d4/0x296
> > [   42.044044]  ? enter_from_user_mode+0x2e/0x2e
> > [   42.045402]  ? fput+0x7a/0xae
> > [   42.046422]  ? filp_close+0xf7/0x122
> > [   42.047571]  ? __ia32_sys_creat+0x31/0x31
> > [   42.048831]  ? ptrace_report_syscall+0xad/0xad
> > [   42.050382]  syscall_return_slowpath+0x23d/0x268
> > [   42.051784]  ? prepare_exit_to_usermode+0x296/0x296
> > [   42.053250]  ? fd_install+0x32/0x32
> > [   42.054341]  ? kmem_cache_free+0xbf/0x101
> > [   42.055620]  ? do_sys_open+0x13d/0x168
> > [   42.056812]  do_syscall_64+0xf3/0x119
> > [   42.057995]  ? syscall_return_slowpath+0x268/0x268
> > [   42.059460]  ? lockdep_hardirqs_off+0x19/0x129
> > [   42.060820]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> > [   42.062196]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > [   42.063639] RIP: 0033:0x7f31c39fe250
> > [   42.064798] Code: 73 01 c3 48 8b 0d 58 7d 20 00 f7 d8 64 89 01 48 83=
 c8 ff c3 66 0f 1f 44 00 00 83 3d 79 c1 20 00 00 75 10 b8 03 00 00 00 0f 05=
 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ee fb ff ff 48 89 04 24
> > [   42.069903] RSP: 002b:00007fffc28323a8 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000003
> > [   42.072126] RAX: 0000000000000000 RBX: 000000000000000f RCX: 00007f3=
1c39fe250
> > [   42.074153] RDX: 00007f31c39e8b58 RSI: 0000000000000000 RDI: 0000000=
00000000f
> > [   42.076185] RBP: 00007f31c48b6708 R08: 36b3f544af500741 R09: 0000000=
000000001
> > [   42.078211] R10: 0000000000000116 R11: 0000000000000246 R12: 0000000=
000000002
> > [   42.080237] R13: 0000000000000000 R14: 00005569133c1b50 R15: 0000000=
00000000f
> > [   42.082273] CR2: 000000000000024e
> > [   42.083438] ---[ end trace b25bd2587e58b9b9 ]---
> >=20
> >=20
> > To reproduce:
> >=20
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp qemu -k <bzImage> job-script # job-script is attached i=
n this email
> >=20
> >=20
> >=20
> > Thanks,
> > lkp
>=20
> Thanks LKP,
>=20
> I think I see the problem. locks_remove_flock calls flock_make_lock and
> passes it a pointer to a file_lock that lives on the stack. That
> file_lock is not zeroed out beforehand, and fl_ops is not overwritten
> during the initialization in flock_make_lock.
>=20
> I went ahead and updated this patch to zero out the file_lock structure
> in locks_remove_flock.

Should the zeroing out part perhaps be part of flock_make_lock()? That
way we can either pass in fl =3D=3D NULL and get the lock automatically
allocated, or if we pass in fl !=3D NULL and then get it zeroed out by
flock_make_lock(), so callers don't have to bother with it.

That said, the API is not public and there's only one user, so this is
somewhat moot.

In either case, I can confirm that the new version with zeroed out
file_lock structure removes this issue that I was seeing on various
Tegra boards, so:

Tested-by: Thierry Reding <treding@nvidia.com>

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvjCsEACgkQ3SOs138+
s6FPuA/+PmxRweppUcZcq230Ho6Az8hS2eOjEJ85WXBM1/39q/2yzfAcknO082JU
O/NFY3haZAfJDcjT7X8FGuedq12IFFQodH3YMkSs5hwSatVgdWz3Y/3k0ALLp998
vjakyuMY+h2lh2wl+JJi7VKjtI1qHPZDJL/TkQl1YiQD7JlFddK/RiVQkIxeOg3V
4SP5VZUGE1A5t153BQ+QhUElnNVwosDMaJXAmXYciisAhxsyvczjWra2S1KIHvgL
RqV4L37f8ls88nb2WmPsqtK/Athoy4ZK9RzyM0xDSC06jtGs6kXGrwKJUe9mgk7p
P9DGEMQUPmQPgwa3FUgb1bEnto4EIzG46mWqKjxjz8wh/jTiqr862P1nM5/ZZY1Q
Z/IMRAnH1LGo34d5rgf6PinX6bu43nsLLCnsoLPgSMRINJGyV75lTFMzXeBq52oH
LokxMgEQpXIe3F372zTlnLlQOCi0/kg5OddJjBGd4027GDfQoWFW+hAme4sCuFKX
Z7PU2Rem5GDFgojDgOIH0DegWSdDO0bmX4WhIzkaV5XlAbqbs3Fahm90phe4Vdqo
7/OXxGZ/sfu9gUES32jzpqlPX98/3sGAScBd2y/cF7Y/ynh1BVzNcnZdZB7TQde5
0cbDEyg2wDjEG2N/BZ7Oattuxa08iH80itBvye7IuKsWb0cMs+8=
=Tv4K
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
