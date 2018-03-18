Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754733AbeCRUQP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 16:16:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:59820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754471AbeCRUQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 16:16:10 -0400
Date: Sun, 18 Mar 2018 20:16:08 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: bskeggs@redhat.com, airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: WARNING: CPU: 5 PID: 74 at
 ../drivers/gpu/drm/nouveau/include/nvkm/subdev/i2c.h:170
 nvkm_dp_enable+0xbe/0x140 [nouveau]
Message-ID: <20180318201608.GC4449@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I have been getting the following splat for  while now, guess its time to
report, this is on 4.15.8-1-default (OpenSUSE Tumbleweed). I could try
a more up to date kernel if we think this can be fixed.

Mar 16 16:48:18 olga kernel: kvm: SMP vm created on host with unstable TSC; guest TSC will not be reliable
Mar 16 18:28:59 olga kernel: WARNING: CPU: 5 PID: 74 at ../drivers/gpu/drm/nouveau/include/nvkm/subdev/i2c.h:170 nvkm_dp_enable+0xbe/0x140 [nouveau]
Mar 16 18:28:59 olga kernel: Modules linked in: ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack libcrc32c iptable_filter ip
Mar 16 18:28:59 olga kernel:  i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops xhci_hcd ehci_hcd sr_mod ttm cdrom usbcore ata_generic drm wmi button sg dm_multipath 
Mar 16 18:28:59 olga kernel: CPU: 5 PID: 74 Comm: kworker/5:1 Not tainted 4.15.8-1-default #1
Mar 16 18:28:59 olga kernel: Hardware name: Dell Inc. Precision T3610/09M8Y8, BIOS A03 09/05/2013
Mar 16 18:28:59 olga kernel: Workqueue: events nvkm_notify_work [nouveau]
Mar 16 18:28:59 olga kernel: RIP: 0010:nvkm_dp_enable+0xbe/0x140 [nouveau]
Mar 16 18:28:59 olga kernel: RSP: 0018:ffffbad4c1c27e30 EFLAGS: 00010287
Mar 16 18:28:59 olga kernel: RAX: 0000000000000000 RBX: ffff92daf85fbc00 RCX: ffffbad4c1c27e37
Mar 16 18:28:59 olga kernel: RDX: ffffbad4c300e4e4 RSI: ffffbad4c300e4e4 RDI: 000000000100900f
Mar 16 18:28:59 olga kernel: RBP: ffff92daf85ae000 R08: ffff92daf85fbd11 R09: ffffbad4c1c27e37
Mar 16 18:28:59 olga kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffff92dc1a594620
Mar 16 18:28:59 olga kernel: R13: ffff92daf8831b40 R14: 0ffff92dc2fd6860 R15: ffff92d94581cc00
Mar 16 18:28:59 olga kernel: FS:  0000000000000000(0000) GS:ffff92dc2fd40000(0000) knlGS:0000000000000000
Mar 16 18:28:59 olga kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 16 18:28:59 olga kernel: CR2: 0000000001895000 CR3: 000000033800a004 CR4: 00000000001626e0
Mar 16 18:28:59 olga kernel: Call Trace:
Mar 16 18:28:59 olga kernel:  nvkm_dp_hpd+0x113/0x120 [nouveau]
Mar 16 18:28:59 olga kernel:  nvkm_notify_work+0x1e/0x70 [nouveau]
Mar 16 18:28:59 olga kernel:  process_one_work+0x1d1/0x400
Mar 16 18:28:59 olga kernel:  worker_thread+0x2b/0x3d0
Mar 16 18:28:59 olga kernel:  ? process_one_work+0x400/0x400
Mar 16 18:28:59 olga kernel:  kthread+0x113/0x130
Mar 16 18:28:59 olga kernel:  ? kthread_create_worker_on_cpu+0x50/0x50
Mar 16 18:28:59 olga kernel:  ret_from_fork+0x3a/0x50
Mar 16 18:28:59 olga kernel: Code: 4c 8d 4c 24 07 4c 8d 83 11 01 00 00 31 c9 ba 09 00 00 00 be 01 00 00 00 48 89 ef e8 cd 31 fd ff 85 c0 75 75 80 7c 24 07 10 74 02 <0f> 0b 48 89 ef e8 c8 2f 
Mar 16 18:28:59 olga kernel: ---[ end trace 86032f0eeeecbd15 ]---

  Luis
