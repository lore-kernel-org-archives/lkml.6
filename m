Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C6DC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A70221A0D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOsO2E5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A70221A0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933967AbeGFRcN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:32:13 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34591 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932718AbeGFRcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:32:11 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so24884397ois.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RnL0ohGuriOtwUuJRr4RSNpcPAOhD3f17ROX4HWtapw=;
        b=cOsO2E5tMNsMCWbe4sFKBQu9BzFY5tb7AwJkZWIE/xgy6ZVNZZsjuTm3TXspnU+XMe
         dd4E6/KqhLnihRvC585X5x3ewflJKmWnSP+X2aiLthMnQcRqsR/1JzrkRXu9Y0d9Yk4N
         l6POtRudlXd/cm1UT1mPLxkr7/iNST+1yXEh4cOcrkJmAbhWs34AaBojzQnkNf8w1o0W
         yfzmWGecT3t0BGC447UBwwXBp+vEW7WeKetfd2a8exNhYYMUxjUgFVpCKdmmYkq5Tqb0
         GD1/V4nyBp2jOO8y1aJgnUnCwOHPPkHPtO74k2K+I86wN3Wm2gFYZYw0EMEjvtqgLmKj
         8yMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RnL0ohGuriOtwUuJRr4RSNpcPAOhD3f17ROX4HWtapw=;
        b=CBmOGBDqdiDN8Ld4S2XBr+Tl1H1Mzre1qsyPP4lpYNil+yO4LyoEN9Ps+fuL5P9v98
         O7l2orlLLWAGrGWlvV6nrnAhe9qcPyxjbfnygsYlaOFHOfPPlvNW9h8xI8ZTn3COr0xU
         6BYv8byK6fmwbVqdRUII2oGgL2qFAMWdPITu6QxgwMllk77E0NBPVhcUCffHCcVbBjZn
         eTyXUikx2aq6dVYV0/BBIfLsXpAS9bkvX/aSNTQ8SPyM+W64/Z7y8oCTJMLn7u2VrLqz
         Cg9oLkIkRsvSVnpwxwtd7mLDldS775wLgA6ivZ4ofqFMpgiGzz8ktr5Xc4glSivqe4Pc
         1siw==
X-Gm-Message-State: APt69E1kniC+pF4EDet56IBezPkXwAHNVn3dqNsx9UZeLK5x3kwpnn/D
        GykfH2L13GSB5GzX6Y3vK6t3vmcLZDldCis6yC257wLi
X-Google-Smtp-Source: AAOMgpfY9QdB43xPOhPGIcDmpjQNFlBda1Pe5tO2Ve/2VMCvnHAMtOE6BiQPBZ1A8w7P4WPFvmmSHgDkXwrQ5EDWp5o=
X-Received: by 2002:aca:c287:: with SMTP id s129-v6mr12771755oif.3.1530898330093;
 Fri, 06 Jul 2018 10:32:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5c0c:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 10:32:09 -0700 (PDT)
In-Reply-To: <153080827470.5496.11719544134805228821.stgit@warthog.procyon.org.uk>
References: <153080826773.5496.7106875523806885716.stgit@warthog.procyon.org.uk>
 <153080827470.5496.11719544134805228821.stgit@warthog.procyon.org.uk>
From:   KiranKumar Modukuri <kiran.modukuri@gmail.com>
Date:   Fri, 6 Jul 2018 10:32:09 -0700
Message-ID: <CAC_dK6gq71LUsiifXRxZp-CZTUZ=m3zzTDtK+RsYNiD4Zxrwig@mail.gmail.com>
Subject: Re: [PATCH 2/4] fscache: Fix reference overput in fscache_attach_object()
 error handling
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, carmark.dlut@gmail.com,
        vegard.nossum@gmail.com, linux-kernel@vger.kernel.org,
        neilb@suse.com, aderobertis@metrics.net,
        Daniel Axtens <dja@axtens.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[NOTE from dhowells] It's unclear as to the circumstances in which (2) can
take place, given that thread (1) is in nfs_kill_super(), however a
conflicting NFS mount with slightly different parameters that creates a
different superblock would do it, but no backtrace was included.

Yes in this environment. multiple NFS mounts to same share constantly
happen using fscache.
Also in the production VM environment, panic_on_oops is disabled by
default, so that we can capture the backtraces before the
VM is destroyed.

Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.562782] ------------[
cut here ]------------
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.562944] kernel BUG at
/build/linux-Y09MKI/linux-4.4.0/fs/fscache/cookie.c:639!
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.563178] invalid opcode:
0000 [#1] SMP
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.563316] Modules linked
in: rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace ipt_MASQUERADE
nf_nat_masquerade_ipv4 nf_conntrack_netlink nfnetlink xfrm_user
xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4
xt_addrtype xt_conntrack nf_nat xt_multiport nf_conntrack br_netfilter
bridge iptable_filter ip_tables stp llc x_tables overlay cachefiles
fscache nv_peer_mem(OE) rdma_ucm(OE) ib_ucm(OE) rdma_cm(OE) iw_cm(OE)
configfs ib_ipoib(OE) ib_cm(OE) ib_uverbs(OE) ib_umad(OE) mlx5_ib(OE)
mlx4_ib(OE) ib_core(OE) mlx4_en(OE) mlx4_core(OE) ipmi_ssif kvm_intel
kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd
joydev input_leds nvidia_uvm(POE) ipmi_si sunrpc ipmi_devintf
ipmi_msghandler knem(OE) autofs4 nvidia_drm(POE) nvidia_modeset(POE)
hid_generic ixgbe usbhid dca hid nvidia(POE) i2c_algo_bit
drm_kms_helper mdio syscopyarea vxlan sysfillrect ahci ip6_udp_tunnel
sysimgblt mlx5_core(OE) udp_tunnel megaraid_sas mlx_compat(OE) libahci
ttm fb_sys_fops ptp drm pps_core
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.566625] CPU: 77 PID:
52576 Comm: umount.nfs4 Tainted: P           OE   4.4.0-119-generic
#143+hf177263v20180413b1-Ubuntu
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.566980] Hardware name:
NVIDIA DGX-1 with V100-32/DGX-1 with V100-32, BIOS S2W_3A05 03/05/2018
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.567262] task:
ffff887f54de2a00 ti: ffff887f5fe7c000 task.ti: ffff887f5fe7c000
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.567510] RIP:
0010:[<ffffffffc04d632a>]  [<ffffffffc04d632a>]
__fscache_cookie_put+0x3a/0x40 [fscache]
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.567811] RSP:
0018:ffff887f5fe7fdf0  EFLAGS: 00010282
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.567976] RAX:
0000000000000001 RBX: ffff883f225ec000 RCX: 0000000000000034
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.568196] RDX:
0000000000000002 RSI: ffff883f2cb3abb0 RDI: ffff883f2cb3abb0
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.568417] RBP:
ffff887f5fe7fdf8 R08: ffff887f7f5572c0 R09: 0000000000000001
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.568638] R10:
0000000000000008 R11: 0000000000000000 R12: 000000000000002e
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.568858] R13:
ffff883f2a9c7000 R14: 0000000000000000 R15: ffff887f54de30a8
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.569079] FS:
00007f2a29e89880(0000) GS:ffff887f7f540000(0000)
knlGS:0000000000000000
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.569330] CS:  0010 DS:
0000 ES: 0000 CR0: 0000000080050033
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.569506] CR2:
00007ffd69aefd28 CR3: 0000007f4c53c000 CR4: 0000000000360670
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.569728] DR0:
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.569948] DR3:
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.570168] Stack:
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.570230]
ffff883f2cb3abb0 ffff887f5fe7fe10 ffffffffc04d6517 ffff883f2a9c7000
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.570476]
ffff887f5fe7fe28 ffffffffc05e317d ffff883f2a9c6800 ffff887f5fe7fe50
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.570741]
ffffffffc05d38e9 ffff883f2a9c6800 ffffffffc05ed5a0 ffff883f2e3dc338
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.571005] Call Trace:
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.571089]
[<ffffffffc04d6517>] __fscache_relinquish_cookie+0x87/0x120 [fscache]
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.571353]
[<ffffffffc05e317d>] nfs_fscache_release_super_cookie+0x2d/0xb0 [nfs]
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.571586]
[<ffffffffc05d38e9>] nfs_kill_super+0x29/0x40 [nfs]
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.571771]
[<ffffffff81216bf8>] deactivate_locked_super+0x48/0x80
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.571961]
[<ffffffff812170dc>] deactivate_super+0x5c/0x60
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.572137]
[<ffffffff812352cf>] cleanup_mnt+0x3f/0x90
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.572297]
[<ffffffff81235362>] __cleanup_mnt+0x12/0x20
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.572466]
[<ffffffff810a14c6>] task_work_run+0x86/0xb0
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.572631]
[<ffffffff81003242>] exit_to_usermode_loop+0xc2/0xd0
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.572818]
[<ffffffff81003c7e>] syscall_return_slowpath+0x4e/0x60
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.573012]
[<ffffffff8184f8b0>] int_ret_from_sys_call+0x25/0x9f
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.573199] Code: 7e 18 00
48 8b 5e 28 75 22 48 8b 3d 71 83 00 00 e8 5c d2 d1 c0 48 85 db 74 0e
8b 03 85 c0 7e 0d 48 89 de f0 ff 0b 74 d6 5b 5d c3 <0f> 0b 0f 0b 66 90
0f 1f 44 00 00 55 48 85 f6 48 89 e5 41 57 41
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.583441] RIP
[<ffffffffc04d632a>] __fscache_cookie_put+0x3a/0x40 [fscache]
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.593139]  RSP <ffff887f5fe7fdf0>
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.619738] ------------[
cut here ]------------
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.619744] ---[ end trace
863b5b94d49a511a ]---
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.708627] kernel BUG at
/build/linux-Y09MKI/linux-4.4.0/fs/fscache/internal.h:321!
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.718326] invalid opcode:
0000 [#2] SMP
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.727818] Modules linked
in: rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace ipt_MASQUERADE
nf_nat_masquerade_ipv4 nf_conntrack_netlink nfnetlink xfrm_user
xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4
xt_addrtype xt_conntrack nf_nat xt_multiport nf_conntrack br_netfilter
bridge iptable_filter ip_tables stp llc x_tables overlay cachefiles
fscache nv_peer_mem(OE) rdma_ucm(OE) ib_ucm(OE) rdma_cm(OE) iw_cm(OE)
configfs ib_ipoib(OE) ib_cm(OE) ib_uverbs(OE) ib_umad(OE) mlx5_ib(OE)
mlx4_ib(OE) ib_core(OE) mlx4_en(OE) mlx4_core(OE) ipmi_ssif kvm_intel
kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd
joydev input_leds nvidia_uvm(POE) ipmi_si sunrpc ipmi_devintf
ipmi_msghandler knem(OE) autofs4 nvidia_drm(POE) nvidia_modeset(POE)
hid_generic ixgbe usbhid dca hid nvidia(POE) i2c_algo_bit
drm_kms_helper mdio syscopyarea vxlan sysfillrect ahci ip6_udp_tunnel
sysimgblt mlx5_core(OE) udp_tunnel megaraid_sas mlx_compat(OE) libahci
ttm fb_sys_fops ptp drm pps_core
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.815490] CPU: 32 PID:
50915 Comm: kworker/u162:3 Tainted: P      D    OE   4.4.0-119-generic
#143+hf177263v20180413b1-Ubuntu
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.834554] Hardware name:
NVIDIA DGX-1 with V100-32/DGX-1 with V100-32, BIOS S2W_3A05 03/05/2018
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.844268] Workqueue:
fscache_object fscache_object_work_func [fscache]
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.853876] task:
ffff887f4c578000 ti: ffff887f1bdf0000 task.ti: ffff887f1bdf0000
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.863570] RIP:
0010:[<ffffffffc04d6c93>]  [<ffffffffc04d6c93>]
fscache_object_destroy+0x43/0x50 [fscache]
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.873469] RSP:
0018:ffff887f1bdf3dc0  EFLAGS: 00010246
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.883356] RAX:
ffff883f2cb3abb0 RBX: ffff883f29d37900 RCX: 0000005500000000
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.893333] RDX:
0000000000000000 RSI: ffff883f29d37a10 RDI: ffff883f29d37900
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.903348] RBP:
ffff887f1bdf3dd8 R08: 0000000000000000 R09: 0000000000000000
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.913283] R10:
0000000000000020 R11: 0000000000000000 R12: ffff887f2f203200
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.923151] R13:
ffff883f29d37990 R14: ffffffffc04db6a0 R15: ffff883f29d37990
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.932994] FS:
0000000000000000(0000) GS:ffff887f7ef00000(0000)
knlGS:0000000000000000
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.942995] CS:  0010 DS:
0000 ES: 0000 CR0: 0000000080050033
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.953041] CR2:
00007ffffb21ae08 CR3: 0000000002e0a000 CR4: 0000000000360670
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.963133] DR0:
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.973081] DR3:
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.982980] Stack:
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36870.992787]
ffffffffc028bea2 ffff883f29d37900 000000000000006d ffff887f1bdf3de8
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36871.002770]
ffffffffc04d6a00 ffff887f1bdf3e18 ffffffffc04d7521 ffff887f4cc99e00
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36871.012779]
ffff887f65008000 ffff887f4db4b600 0000000000001440 ffff887f1bdf3e58
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36871.022706] Call Trace:
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36871.032480]
[<ffffffffc028bea2>] ? cachefiles_put_object+0xd2/0x270 [cachefiles]
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36871.042428]
[<ffffffffc04d6a00>] fscache_put_object+0x20/0x30 [fscache]
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36871.052516]
[<ffffffffc04d7521>] fscache_object_work_func+0x181/0x200 [fscache]
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36871.062612]
[<ffffffff8109c9db>] process_one_work+0x16b/0x490
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36871.072767]
[<ffffffff8109cd4b>] worker_thread+0x4b/0x4d0
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36871.082903]
[<ffffffff8109cd00>] ? process_one_work+0x490/0x490
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36871.093037]
[<ffffffff810a30d7>] kthread+0xe7/0x100
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36871.103148]
[<ffffffff810a2ff0>] ? kthread_create_on_node+0x1e0/0x1e0
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36871.113300]
[<ffffffff8184fb75>] ret_from_fork+0x55/0x80
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36871.123298]
[<ffffffff810a2ff0>] ? kthread_create_on_node+0x1e0/0x1e0
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36871.133147] Code: 89 fb f0
ff 08 74 0e 48 c7 83 80 00 00 00 00 00 00 00 5b 5d c3 48 89 c7 e8 6b
f6 ff ff 48 c7 83 80 00 00 00 00 00 00 00 5b 5d c3 <0f> 0b 90 66 2e 0f
1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36871.153783] RIP
[<ffffffffc04d6c93>] fscache_object_destroy+0x43/0x50 [fscache]
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36871.163935]  RSP <ffff887f1bdf3dc0>
Apr 20 13:54:31 dgx-server-1V-1 kernel: [36871.174065] ---[ end trace
863b5b94d49a511b ]---
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.248936] BUG: unable to
handle kernel paging request at ffffffffffffffd8
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.259088] IP:
[<ffffffff810a3790>] kthread_data+0x10/0x20
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.268982] PGD 2e0f067 PUD
2e11067 PMD 0
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.278712] Oops: 0000 [#3] SMP
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.288095] Modules linked
in: rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace ipt_MASQUERADE
nf_nat_masquerade_ipv4 nf_conntrack_netlink nfnetlink xfrm_user
xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4
xt_addrtype xt_conntrack nf_nat xt_multiport nf_conntrack br_netfilter
bridge iptable_filter ip_tables stp llc x_tables overlay cachefiles
fscache nv_peer_mem(OE) rdma_ucm(OE) ib_ucm(OE) rdma_cm(OE) iw_cm(OE)
configfs ib_ipoib(OE) ib_cm(OE) ib_uverbs(OE) ib_umad(OE) mlx5_ib(OE)
mlx4_ib(OE) ib_core(OE) mlx4_en(OE) mlx4_core(OE) ipmi_ssif kvm_intel
kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd
joydev input_leds nvidia_uvm(POE) ipmi_si sunrpc ipmi_devintf
ipmi_msghandler knem(OE) autofs4 nvidia_drm(POE) nvidia_modeset(POE)
hid_generic ixgbe usbhid dca hid nvidia(POE) i2c_algo_bit
drm_kms_helper mdio syscopyarea vxlan sysfillrect ahci ip6_udp_tunnel
sysimgblt mlx5_core(OE) udp_tunnel megaraid_sas mlx_compat(OE) libahci
ttm fb_sys_fops ptp drm pps_core
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.375194] CPU: 72 PID:
50915 Comm: kworker/u162:3 Tainted: P      D    OE   4.4.0-119-generic
#143+hf177263v20180413b1-Ubuntu
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.394487] Hardware name:
NVIDIA DGX-1 with V100-32/DGX-1 with V100-32, BIOS S2W_3A05 03/05/2018
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.404378] task:
ffff887f4c578000 ti: ffff887f1bdf0000 task.ti: ffff887f1bdf0000
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.414146] RIP:
0010:[<ffffffff810a3790>]  [<ffffffff810a3790>] kthread_data+0x10/0x20
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.424159] RSP:
0018:ffff887f1bdf3a98  EFLAGS: 00010002
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.433985] RAX:
0000000000000000 RBX: 0000000000000048 RCX: ffffffff82113ec0
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.443998] RDX:
0000000000000048 RSI: 0000000000000048 RDI: ffff887f4c578000
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.453799] RBP:
ffff887f1bdf3a98 R08: 00000000ffffffff R09: 0000000000000000
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.463651] R10:
ffff887f4c578060 R11: 0000000000003400 R12: 0000000000000000
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.473327] R13:
00000000000172c0 R14: ffff887f4c578000 R15: ffff887f7f4172c0
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.482977] FS:
0000000000000000(0000) GS:ffff887f7f400000(0000)
knlGS:0000000000000000
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.492743] CS:  0010 DS:
0000 ES: 0000 CR0: 0000000080050033
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.502453] CR2:
0000000000000028 CR3: 0000000002e0a000 CR4: 0000000000360670
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.512331] DR0:
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.522069] DR3:
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.531682] Stack:
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.541175]
ffff887f1bdf3ab0 ffffffff8109dde1 ffff887f7f4172c0 ffff887f1bdf3b00
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.550938]
ffffffff8184b2b9 ffff887f5e636280 ffff887f00000048 ffff887f4c578000
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.560619]
ffff887f1bdf4000 ffff887f4c5786d8 ffff887f1bdf36a8 0000000000000000
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.570218] Call Trace:
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.579747]
[<ffffffff8109dde1>] wq_worker_sleeping+0x11/0x90
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.589332]
[<ffffffff8184b2b9>] __schedule+0x579/0x7f0
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.598901]
[<ffffffff8184b565>] schedule+0x35/0x80
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.608453]
[<ffffffff81086188>] do_exit+0x778/0xb00
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.617943]
[<ffffffff81031ce1>] oops_end+0xa1/0xd0
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.627465]
[<ffffffff8103219b>] die+0x4b/0x70
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.636872]
[<ffffffff8102f131>] do_trap+0xb1/0x140
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.646210]
[<ffffffff8102f4b9>] do_error_trap+0x89/0x110
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.655534]
[<ffffffffc04d6c93>] ? fscache_object_destroy+0x43/0x50 [fscache]
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.664773]
[<ffffffff81229093>] ? pollwake+0x73/0x90
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.673843]
[<ffffffff810aec20>] ? wake_up_q+0x70/0x70
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.682784]
[<ffffffff810c6448>] ? __wake_up_common+0x58/0x90
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.691673]
[<ffffffff810b79a3>] ? update_curr+0xe3/0x170
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.700520]
[<ffffffff8102fa20>] do_invalid_op+0x20/0x30
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.709258]
[<ffffffff81851a2e>] invalid_op+0x1e/0x30
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.717935]
[<ffffffffc04d6c93>] ? fscache_object_destroy+0x43/0x50 [fscache]
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.726666]
[<ffffffffc028bea2>] ? cachefiles_put_object+0xd2/0x270 [cachefiles]
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.735461]
[<ffffffffc04d6a00>] fscache_put_object+0x20/0x30 [fscache]
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.744059]
[<ffffffffc04d7521>] fscache_object_work_func+0x181/0x200 [fscache]
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.752468]
[<ffffffff8109c9db>] process_one_work+0x16b/0x490
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.760656]
[<ffffffff8109cd4b>] worker_thread+0x4b/0x4d0
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.768592]
[<ffffffff8109cd00>] ? process_one_work+0x490/0x490
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.776317]
[<ffffffff810a30d7>] kthread+0xe7/0x100
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.783783]
[<ffffffff810a2ff0>] ? kthread_create_on_node+0x1e0/0x1e0
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.791086]
[<ffffffff8184fb75>] ret_from_fork+0x55/0x80
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.798119]
[<ffffffff810a2ff0>] ? kthread_create_on_node+0x1e0/0x1e0
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.805026] Code: c7 18 de
cb 81 e8 f1 f9 fd ff e9 a0 fe ff ff 66 90 66 2e 0f 1f 84 00 00 00 00
00 0f 1f 44 00 00 48 8b 87 20 05 00 00 55 48 89 e5 <48> 8b 40 d8 5d c3
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.819466] RIP
[<ffffffff810a3790>] kthread_data+0x10/0x20
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.826258]  RSP <ffff887f1bdf3a98>
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.832880] CR2: ffffffffffffffd8
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.839354] ---[ end trace
863b5b94d49a511c ]---
Apr 20 13:55:10 dgx-server-1V-1 kernel: [36871.916345] Fixing
recursive fault but reboot is needed!





On Thu, Jul 5, 2018 at 9:31 AM, David Howells <dhowells@redhat.com> wrote:
> From: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
>
> When a cookie is allocated that causes fscache_object structs to be
> allocated, those objects are initialised with the cookie pointer, but
> aren't blessed with a ref on that cookie unless the attachment is
> successfully completed in fscache_attach_object().
>
> If attachment fails because the parent object was dying or there was a
> collision, fscache_attach_object() returns without incrementing the cookie
> counter - but upon failure of this function, the object is released which
> then puts the cookie, whether or not a ref was taken on the cookie.
>
> Fix this by taking a ref on the cookie when it is assigned in
> fscache_object_init(), even when we're creating a root object.
>
>
> Analysis from Kiran Kumar:
>
> This bug has been seen in 4.4.0-124-generic #148-Ubuntu kernel
>
> BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1776277
>
> fscache cookie ref count updated incorrectly during fscache object
> allocation resulting in following Oops.
>
> kernel BUG at /build/linux-Y09MKI/linux-4.4.0/fs/fscache/internal.h:321!
> kernel BUG at /build/linux-Y09MKI/linux-4.4.0/fs/fscache/cookie.c:639!
>
> [Cause]
> Two threads are trying to do operate on a cookie and two objects.
>
> (1) One thread tries to unmount the filesystem and in process goes over a
>     huge list of objects marking them dead and deleting the objects.
>     cookie->usage is also decremented in following path:
>
>       nfs_fscache_release_super_cookie
>        -> __fscache_relinquish_cookie
>         ->__fscache_cookie_put
>         ->BUG_ON(atomic_read(&cookie->usage) <= 0);
>
> (2) A second thread tries to lookup an object for reading data in following
>     path:
>
>     fscache_alloc_object
>     1) cachefiles_alloc_object
>         -> fscache_object_init
>            -> assign cookie, but usage not bumped.
>     2) fscache_attach_object -> fails in cant_attach_object because the
>          cookie's backing object or cookie's->parent object are going away
>     3) fscache_put_object
>         -> cachefiles_put_object
>           ->fscache_object_destroy
>             ->fscache_cookie_put
>                ->BUG_ON(atomic_read(&cookie->usage) <= 0);
>
> [NOTE from dhowells] It's unclear as to the circumstances in which (2) can
> take place, given that thread (1) is in nfs_kill_super(), however a
> conflicting NFS mount with slightly different parameters that creates a
> different superblock would do it, but no backtrace was included.
>
> [Fix] Bump up the cookie usage in fscache_object_init, when it is first
> being assigned a cookie atomically such that the cookie is added and bumped
> up if its refcount is not zero.  Remove the assignment in
> fscache_attach_object().
>
> [Testcase]
> I have run ~100 hours of NFS stress tests and not seen this bug recur.
>
> [Regression Potential]
>  - Limited to fscache/cachefiles.
>
> Signed-off-by: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  fs/cachefiles/bind.c |    3 ++-
>  fs/fscache/cache.c   |    2 +-
>  fs/fscache/cookie.c  |    7 ++++---
>  fs/fscache/object.c  |    1 +
>  4 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
> index d9f001078e08..4a717d400807 100644
> --- a/fs/cachefiles/bind.c
> +++ b/fs/cachefiles/bind.c
> @@ -218,7 +218,8 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
>                            "%s",
>                            fsdef->dentry->d_sb->s_id);
>
> -       fscache_object_init(&fsdef->fscache, NULL, &cache->cache);
> +       fscache_object_init(&fsdef->fscache, &fscache_fsdef_index,
> +                           &cache->cache);
>
>         ret = fscache_add_cache(&cache->cache, &fsdef->fscache, cache->tag);
>         if (ret < 0)
> diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
> index c184c5a356ff..cdcb376ef8df 100644
> --- a/fs/fscache/cache.c
> +++ b/fs/fscache/cache.c
> @@ -220,6 +220,7 @@ int fscache_add_cache(struct fscache_cache *cache,
>  {
>         struct fscache_cache_tag *tag;
>
> +       ASSERTCMP(ifsdef->cookie, ==, &fscache_fsdef_index);
>         BUG_ON(!cache->ops);
>         BUG_ON(!ifsdef);
>
> @@ -248,7 +249,6 @@ int fscache_add_cache(struct fscache_cache *cache,
>         if (!cache->kobj)
>                 goto error;
>
> -       ifsdef->cookie = &fscache_fsdef_index;
>         ifsdef->cache = cache;
>         cache->fsdef = ifsdef;
>
> diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
> index 97137d7ec5ee..83bfe04456b6 100644
> --- a/fs/fscache/cookie.c
> +++ b/fs/fscache/cookie.c
> @@ -516,6 +516,7 @@ static int fscache_alloc_object(struct fscache_cache *cache,
>                 goto error;
>         }
>
> +       ASSERTCMP(object->cookie, ==, cookie);
>         fscache_stat(&fscache_n_object_alloc);
>
>         object->debug_id = atomic_inc_return(&fscache_object_debug_id);
> @@ -571,6 +572,8 @@ static int fscache_attach_object(struct fscache_cookie *cookie,
>
>         _enter("{%s},{OBJ%x}", cookie->def->name, object->debug_id);
>
> +       ASSERTCMP(object->cookie, ==, cookie);
> +
>         spin_lock(&cookie->lock);
>
>         /* there may be multiple initial creations of this object, but we only
> @@ -610,9 +613,7 @@ static int fscache_attach_object(struct fscache_cookie *cookie,
>                 spin_unlock(&cache->object_list_lock);
>         }
>
> -       /* attach to the cookie */
> -       object->cookie = cookie;
> -       fscache_cookie_get(cookie, fscache_cookie_get_attach_object);
> +       /* Attach to the cookie.  The object already has a ref on it. */
>         hlist_add_head(&object->cookie_link, &cookie->backing_objects);
>
>         fscache_objlist_add(object);
> diff --git a/fs/fscache/object.c b/fs/fscache/object.c
> index 20e0d0a4dc8c..9edc920f651f 100644
> --- a/fs/fscache/object.c
> +++ b/fs/fscache/object.c
> @@ -327,6 +327,7 @@ void fscache_object_init(struct fscache_object *object,
>         object->store_limit_l = 0;
>         object->cache = cache;
>         object->cookie = cookie;
> +       fscache_cookie_get(cookie, fscache_cookie_get_attach_object);
>         object->parent = NULL;
>  #ifdef CONFIG_FSCACHE_OBJECT_LIST
>         RB_CLEAR_NODE(&object->objlist_link);
>



-- 
Kiran
