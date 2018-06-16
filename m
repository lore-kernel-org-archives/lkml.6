Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC216C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 15:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8868D208AF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 15:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8868D208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932654AbeFPPjV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 11:39:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:42495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754239AbeFPPjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 11:39:19 -0400
Received: from homer.simpson.net ([185.221.151.60]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3zG2-1gLlUB36BO-00rWk2; Sat, 16
 Jun 2018 17:39:13 +0200
Message-ID: <1529163551.16103.16.camel@gmx.de>
Subject: v4.14.21+: ATOMIC_SLEEP splat bisected  to 9428088c90b6 ("drm/qxl:
 reapply cursor after resetting primary")
From:   Mike Galbraith <efault@gmx.de>
To:     Ray Strode <rstrode@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Date:   Sat, 16 Jun 2018 17:39:11 +0200
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FK8qUD8xOvL9xsahz+Xa2cqi2HPtnTmerPTiNA8lEvZRF4b3U2b
 9ZOGJYSpalezyV7NTmv3dcX/uHQcUsl68Hqhg8eBjLWKeEuJ5jxXwiSnh2gDsZgZDdjLjPn
 Fme7eWfy8XkYN2MIkL2Uq8Ftv/O0pYI+iI0tTLh0OEx0hxIL0n8tLmmohr+IEapNKXBkcBz
 zftKrS+XXWkspmDtxMZbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z8Q3rFlrg4A=:FE+jzo5ZQXz8pz3njJlP1T
 Nx7c/rScgLdj8CTPgotwzldxocFDXdvcE1EMOHvuRF5fQeIzjCcELIDkvFRMINFkQ0rszOlll
 QZ3Zms/hhy2bhhVwT7oh9SRlJSC7WycbU/zHD0dm1UBw1jjQhzFK1vSl1TQ5oDZ8XZEfIFZQ/
 x19XwBSHniohe24/T931Q2qQMvBSi4v/+Q/jlqJGxC7z5RW7W9nMN9vws6CHQAoO8OtiFsYxh
 pY/Zl33gcWcc4UggdQEexx9pE7X5AVPkRdtYwf+sq5IP9lNMj9rqVVU7lR4X7WIOhaH2LdrOP
 R9NoLma5QL+vLgKAKBsCwTq2FneqNiFhsaq8mcVbjfrlSDOAHroBT0WSbLr3+MtmYfMvUDXNN
 JFMKscGeQ6Uu0ChXscnpKRdZPaOK/0Y3PacG7lCrrOvppOHv2rA6Boxf84lkj4MljpRJgEids
 ehV2y/x/XGtdTZ5k7Wf6j65jPJaHwdxpnQm7h4BuAmVaB4nfTSQBk8UevzApobqdVfISXvym6
 fp181F0qQUGPkWDL/V/dOpivzvXI1DrDXPIJICH0VfGyIP/7No76nIjLYGCASVo9afPDt8vR6
 qNcNyfNmuubK4sgy7HXofADu9sCv5akEfCwOnFW0TAso7zTYe2fGw2t531gw1OphYkX+M2G4G
 3xsNyqNex4NDKkb9f+lZhJ/lWB0SQduMpT3Q1s23kIJeuyDBLdZ7Q8WDOGi8ghJMfGtMUE1Yo
 e8bhMXFBldCuMmd0g0cd9bxJowvYy/jBSlv7ieTm85ipYYwqWiEgDO9dVoTvQl0bJUV6ynGyN
 bRltzNs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Running a kernel with ATOMIC_SLEEP enabled in one of my VMs, I met the
splat below.  I tracked it back to 4.14-stable, and bisected it there.

[   35.748479] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:239
[   37.302172] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:239
[   43.719223] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:239
[   45.284748] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:239
[   47.544198] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:239
[   49.024251] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:239
[   50.222626] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:239
[   67.521590] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:239
[  864.956846] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:239
[  866.478807] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:239
[ 2245.113210] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:239
[ 2308.323698] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:239
[ 2325.967740] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:239
[ 3355.291413] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:239
[ 3367.545378] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:239
[ 3395.581055] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:239
[ 3405.144002] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:239

[   35.748479] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:239
[   35.750518] in_atomic(): 1, irqs_disabled(): 0, pid: 2482, name: X
[   35.752119] CPU: 0 PID: 2482 Comm: X Kdump: loaded Tainted: G            E     4.17.0.g4c5e8fc-default #846
[   35.754276] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
[   35.756381] Call Trace:
[   35.756921]  dump_stack+0x85/0xcb
[   35.757415]  ___might_sleep+0xd8/0x130
[   35.757818]  mutex_lock+0x1c/0x40
[   35.758202]  qxl_surface_evict+0x23/0x60 [qxl]
[   35.758756]  qxl_gem_object_free+0x27/0x40 [qxl]
[   35.759247]  qxl_bo_unref+0x1d/0x30 [qxl]
[   35.759721]  qxl_cursor_atomic_update+0x251/0x2a0 [qxl]
[   35.760314]  drm_atomic_helper_commit_planes+0xdf/0x220 [drm_kms_helper]
[   35.761065]  drm_atomic_helper_commit_tail+0x26/0x60 [drm_kms_helper]
[   35.761722]  commit_tail+0x5f/0x70 [drm_kms_helper]
[   35.762160]  drm_atomic_helper_commit+0xfc/0x110 [drm_kms_helper]
[   35.762712]  drm_atomic_helper_update_plane+0xf0/0x110 [drm_kms_helper]
[   35.763277]  __setplane_internal+0x196/0x240 [drm]
[   35.763698]  drm_mode_cursor_universal+0xec/0x1d0 [drm]
[   35.764143]  drm_mode_cursor_common+0x16a/0x1d0 [drm]
[   35.764570]  ? drm_mode_cursor_ioctl+0x50/0x50 [drm]
[   35.765011]  drm_ioctl_kernel+0x81/0xd0 [drm]
[   35.765425]  drm_ioctl+0x2a8/0x350 [drm]
[   35.765795]  ? drm_mode_cursor_ioctl+0x50/0x50 [drm]
[   35.766256]  do_vfs_ioctl+0x91/0x6a0
[   35.766770]  ? __do_page_fault+0x27e/0x4f0
[   35.767116]  ksys_ioctl+0x70/0x80
[   35.767397]  __x64_sys_ioctl+0x16/0x20
[   35.767732]  do_syscall_64+0x60/0x180
[   35.768042]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   35.768470] RIP: 0033:0x7fe99fc0a477
[   35.768783] Code: b3 66 90 48 8b 05 21 4a 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f1 49 2c 00 f7 d8 64 89 01 48 
[   35.770453] RSP: 002b:00007fff8dcc3ca8 EFLAGS: 00003246 ORIG_RAX: 0000000000000010
[   35.771092] RAX: ffffffffffffffda RBX: 00005594217685e0 RCX: 00007fe99fc0a477
[   35.771690] RDX: 00007fff8dcc3ce0 RSI: 00000000c02464bb RDI: 0000000000000018
[   35.772298] RBP: 00007fff8dcc3ce0 R08: 0000000000000040 R09: 0000000000000004
[   35.773105] R10: 0000000000000040 R11: 0000000000003246 R12: 00000000c02464bb
[   35.773758] R13: 0000000000000018 R14: 0000000000000040 R15: 00007fff8dcc3db4

git bisect start
# good: [569dbb88e80deb68974ef6fdd6a13edb9d686261] Linux 4.13
git bisect good 569dbb88e80deb68974ef6fdd6a13edb9d686261
# bad: [cda6fd4d9382205bb792255cd56a91062d404bc0] Linux 4.14.50
git bisect bad cda6fd4d9382205bb792255cd56a91062d404bc0
# good: [fbd01410e89a66f346ba1b3c0161e1198449b746] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
git bisect good fbd01410e89a66f346ba1b3c0161e1198449b746
# good: [e4b57c4bc11bfaa2588557b52ad5abd65fb9390e] sparc64: mmu_context: Add missing include files
git bisect good e4b57c4bc11bfaa2588557b52ad5abd65fb9390e
# bad: [703fca31ac31ed81455a8642a6988cbca47f0f07] tpm: st33zp24: fix potential buffer overruns caused by bit glitches on the bus
git bisect bad 703fca31ac31ed81455a8642a6988cbca47f0f07
# good: [b043ea189d0fbd2f7a0b8d177109f60f5cd767f2] can: vxcan: improve handling of missing peer name attribute
git bisect good b043ea189d0fbd2f7a0b8d177109f60f5cd767f2
# good: [e47273d086236d06c3c2851fa8599971086b2a73] arm64: KVM: Report SMCCC_ARCH_WORKAROUND_1 BP hardening support
git bisect good e47273d086236d06c3c2851fa8599971086b2a73
# bad: [392e03283a3ddddf7c48dcc002b8668e1612a578] crypto: x86/twofish-3way - Fix %rbp usage
git bisect bad 392e03283a3ddddf7c48dcc002b8668e1612a578
# good: [b3d33c5f296b36a05e24828f96c8ea5e02a15b06] crypto: sun4i_ss_prng - fix return value of sun4i_ss_prng_generate
git bisect good b3d33c5f296b36a05e24828f96c8ea5e02a15b06
# good: [0f0fd00739118302568ff8b57ddfc5898c1a3796] xenbus: track caller request id
git bisect good 0f0fd00739118302568ff8b57ddfc5898c1a3796
# bad: [7367af9cf0e4e1502151d42535cae779046d77e4] ARM: dts: s5pv210: add interrupt-parent for ohci
git bisect bad 7367af9cf0e4e1502151d42535cae779046d77e4
# bad: [61c07810bf2e53f348dbdba751ddf7ba31aba4aa] Btrfs: fix unexpected -EEXIST when creating new inode
git bisect bad 61c07810bf2e53f348dbdba751ddf7ba31aba4aa
# bad: [67154fb8012152aed14dbd70e5b7fc79dcfd53f4] xprtrdma: Fix BUG after a device removal
git bisect bad 67154fb8012152aed14dbd70e5b7fc79dcfd53f4
# good: [ff59e379234bb4b479deca97e29f685eabe22954] rtlwifi: rtl8821ae: Fix connection lost problem correctly
git bisect good ff59e379234bb4b479deca97e29f685eabe22954
# good: [dc0b764a7c1a3a03b56c5582bf9a9c4554bf5e96] qxl: alloc & use shadow for dumb buffers
git bisect good dc0b764a7c1a3a03b56c5582bf9a9c4554bf5e96
# bad: [84b41e3708ac9869190dd09d47b548392b7a656a] xprtrdma: Fix calculation of ri_max_send_sges
git bisect bad 84b41e3708ac9869190dd09d47b548392b7a656a
# bad: [848dd9bf51544c8e5436960124f3d1f9c51cdb99] drm/qxl: reapply cursor after resetting primary
git bisect bad 848dd9bf51544c8e5436960124f3d1f9c51cdb99
# first bad commit: [848dd9bf51544c8e5436960124f3d1f9c51cdb99] drm/qxl: reapply cursor after resetting primary
