Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DABC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 11:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F7D2098A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 11:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F7D2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936549AbeFQLld (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 07:41:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:42683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934903AbeFQLlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 07:41:31 -0400
Received: from homer.simpson.net ([188.174.240.203]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSMr9-1ffCUj2yy3-00TQSW; Sun, 17
 Jun 2018 13:40:18 +0200
Message-ID: <1529235613.4572.7.camel@gmx.de>
Subject: Re: [tip:x86/pti] x86/asm: Pad assembly functions with INT3
 instructions
From:   Mike Galbraith <efault@gmx.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, jpoimboe@redhat.com, adobriyan@gmail.com,
        luto@kernel.org, peterz@infradead.org, brgerst@gmail.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, dvlasenk@redhat.com,
        h.peter.anvin@intel.com, bp@alien8.de,
        linux-tip-commits <linux-tip-commits@vger.kernel.org>
Date:   Sun, 17 Jun 2018 13:40:13 +0200
In-Reply-To: <tip-51bad67ffbce0aaa44579f84ef5d05597054ec6a@git.kernel.org>
References: <20180507213755.GA32406@avx2>
         <tip-51bad67ffbce0aaa44579f84ef5d05597054ec6a@git.kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ssGE0ikzNRsFGDFeiEEht2T/NB/eE5NqkhjYEG/R6dHCwprULnk
 DK4NmVLM/E8M6l9cGaF6RZqD+hS49W36BYgMLex1BgLA4KwDedZImBqqzb2TmVtOrVBfKSc
 VNY1Q6pM8jj+Q02vwJCSYjVRh4gwhSQEqxwA0LXAVREgRNg8kkFR4TADsIuTxhYA/lttPIi
 Mb/GTuTMMTsfJIx9d6Azw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:El0e4T8BRc4=:tGwS/1ggyBKKx7AJOqqI82
 esH9litj8EUKnNL3Lj26AQGmbkwyBgPwNd2Wrzd9Gim3OAvDAqk1tVTobxYaINrd+pgWYaBto
 gs6RalOS01VgJq72JxbSJg8RjVdPQIAnw3k4kc+g5Pn8Ovv7tXk2+T+SJUs62FPVdfLV0QLwe
 yNwp6XIvyFSVQhkaL2+ADMxSVBOQ+SAaNII30JonOjLQOvcTsTDmOynCGW50FkzV6ehygLOPd
 YCp6uAlkgMhDRstmmZ7Ui1iO6t7i7FWZlAAiymUov551eaZwfLtMJqk4omkFFisqMtDS1KM9Q
 nv0xugS8HrEDlsyggjUiQNDaeu/3LN9PMC2rHxZY/Tm+vEvR0VIsOcHYOsZpqfLBZhyB4T6P9
 pFv1lyB71y8nVSQo9O7DdyAYuckTOocC8m7srni5Sl1tqixILmUiY8bVe2NgXUrwyneQGbSUA
 HnNIKiRfMzEmZsYKdNuKi4GOwGjzosJHwB061g63N0dF5LvZ1/fFjkRj/U0+ONI/zCQVc0SlX
 mHVSsDd+UZlvNeGVnkZ78zD1vMPeCXv8zhWVLEvIRTjYo9QFSq8RFwxCv2TSULbEsaTY3y3rJ
 dhy+RC6yDr82qvpkZOaw1mej5YRn7fDSJNBKEwS+c5gnYCO7wPMR2cY5y8lzIO5YVn9n0p03D
 +XVhmliN3VY6uQQBZ1WmUif7QET6YevJDhQ+Y+uCdeKfornHx2NXLApTSXlfQElAP+BK+qDqK
 vUNo1Pau/RIzOBPMo3VA+USvuX4NBr9v1TuBu/h1XnFiB/Pbv0y5lGWOf4dwI3mUUixyzAlyI
 Hw/uhGO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-14 at 05:53 -0700, tip-bot for Alexey Dobriyan wrote:
> Commit-ID:  51bad67ffbce0aaa44579f84ef5d05597054ec6a
> Gitweb:     https://git.kernel.org/tip/51bad67ffbce0aaa44579f84ef5d05597054ec6a
> Author:     Alexey Dobriyan <adobriyan@gmail.com>
> AuthorDate: Tue, 8 May 2018 00:37:55 +0300
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Mon, 14 May 2018 11:43:03 +0200
> 
> x86/asm: Pad assembly functions with INT3 instructions
> 
> Use INT3 instead of NOP. All that padding between functions is
> an illegal area, no legitimate code should jump into it.

Is dinky patchlet suggesting cryptomgr is being naughty?

(revert silences spew, but..)

...
[   21.041608] int3: 0000 [#1] SMP PTI
[   21.041754] CPU: 3 PID: 935 Comm: cryptomgr_test Tainted: G            E     4.17.0.g075a1d3-tip-default #146
[   21.041888] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[   21.042035] RIP: 0010:crypto_aegis128_aesni_enc_tail+0x74/0x80 [aegis128_aesni]
[   21.042171] Code: 38 dc ca 66 0f 38 dc d3 66 0f 38 dc de 66 0f ef e5 f3 0f 7f 27 f3 0f 7f 47 10 f3 0f 7f 4f 20 f3 0f 7f 57 30 f3 0f 7f 5f 40 cc <cc> cc cc cc cc cc cc cc cc cc cc cc 48 83 fe 10 0f 82 c3 03 00 00 
[   21.042333] RSP: 0018:ffff963f81ee79b8 EFLAGS: 00000246
[   21.042485] RAX: ffffffffc0985950 RBX: 0000000000000001 RCX: ffff8a3ab90d6000
[   21.042640] RDX: ffff8a3ab90d6000 RSI: 0000000000000001 RDI: ffff963f81ee7af0
[   21.042792] RBP: ffff963f81ee7a90 R08: 0000000000000001 R09: ffff8a3ab90d6000
[   21.042953] R10: c1267690ad7d2d9e R11: 00000000ffffffe0 R12: ffff8a3ab90d6000
[   21.043100] R13: ffffffffc0987040 R14: ffff963f81ee7af0 R15: ffff8a3ab90d6000
[   21.043250] FS:  0000000000000000(0000) GS:ffff8a3adecc0000(0000) knlGS:0000000000000000
[   21.043405] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.043554] CR2: 00007f2e169c4010 CR3: 00000001f700a005 CR4: 00000000001606e0
[   21.043704] Call Trace:
[   21.043854]  ? crypto_aegis128_aesni_process_crypt+0x8a/0xc0 [aegis128_aesni]
[   21.044004]  ? crypto_aegis128_aesni_crypt+0x238/0x440 [aegis128_aesni]
[   21.044156]  ? crypto_aegis128_aesni_crypt+0x238/0x440 [aegis128_aesni]
[   21.044311]  ? crypto_aegis128_aesni_encrypt+0x62/0xb0 [aegis128_aesni]
[   21.044454]  ? crypto_aegis128_aesni_encrypt+0x62/0xb0 [aegis128_aesni]
[   21.044597]  ? crypto_aead_setauthsize+0x23/0x40
[   21.044739]  ? __test_aead+0x632/0x15d0
[   21.044884]  ? crypto_aegis128_aesni_crypt+0x440/0x440 [aegis128_aesni]
[   21.045026]  ? __test_aead+0x632/0x15d0
[   21.045167]  ? crypto_alloc_tfm+0x52/0xf0
[   21.045308]  ? crypto_acomp_scomp_free_ctx+0x30/0x30
[   21.045449]  ? crypto_create_tfm+0x32/0xe0
[   21.045594]  ? crypto_acomp_scomp_free_ctx+0x30/0x30
[   21.045734]  ? crypto_acomp_scomp_free_ctx+0x30/0x30
[   21.045877]  ? test_aead+0x21/0xa0
[   21.046015]  ? alg_test_aead+0x3f/0xa0
[   21.046154]  ? alg_test.part.13+0x170/0x370
[   21.046291]  ? pick_next_task_fair+0x134/0x5d0
[   21.046426]  ? __switch_to+0x92/0x4b0
[   21.046565]  ? finish_task_switch+0x7f/0x2d0
[   21.046701]  ? __schedule+0x2b8/0x860
[   21.046833]  ? crypto_acomp_scomp_free_ctx+0x30/0x30
[   21.046963]  ? cryptomgr_test+0x40/0x50
[   21.047092]  ? kthread+0x11e/0x140
[   21.047221]  ? kthread_associate_blkcg+0xb0/0xb0
[   21.047350]  ? ret_from_fork+0x3a/0x50
[   21.047478] Modules linked in: aegis128_aesni(E+) snd_timer(E) crct10dif_pclmul(E) r8169(E) snd(E) crc32_pclmul(E) mii(E) iTCO_wdt(E) ghash_clmulni_intel(E) iTCO_vendor_support(E) pcbc(E) gpio_ich(E) aesni_intel(E) soundcore(E) aes_x86_64(E) lpc_ich(E) crypto_simd(E) mei_me(E) cryptd(E) mfd_core(E) i2c_i801(E) mei(E) glue_helper(E) pcspkr(E) thermal(E) intel_smartconnect(E) fan(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) sunrpc(E) sch_fq_codel(E) sr_mod(E) cdrom(E) hid_logitech_hidpp(E) hid_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) nouveau(E) wmi(E) i2c_algo_bit(E) drm_kms_helper(E) syscopyarea(E) xhci_pci(E) sysfillrect(E) sysimgblt(E) fb_sys_fops(E) ahci(E) ttm(E) ehci_pci(E) libahci(E) xhci_hcd(E) ehci_hcd(E) libata(E) drm(E) usbcore(E) video(E) button(E) sd_mod(E)
[   21.048064]  vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio_pci(E) virtio_ring(E) virtio(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) efivarfs(E)
[   21.048396] Dumping ftrace buffer:
[   21.048556]    (ftrace buffer empty)
[   21.048726] ---[ end trace 8cdd2dd0a107e807 ]---
[   21.048901] RIP: 0010:crypto_aegis128_aesni_enc_tail+0x74/0x80 [aegis128_aesni]
[   21.049051] Code: 38 dc ca 66 0f 38 dc d3 66 0f 38 dc de 66 0f ef e5 f3 0f 7f 27 f3 0f 7f 47 10 f3 0f 7f 4f 20 f3 0f 7f 57 30 f3 0f 7f 5f 40 cc <cc> cc cc cc cc cc cc cc cc cc cc cc 48 83 fe 10 0f 82 c3 03 00 00 
[   21.049224] RSP: 0018:ffff963f81ee79b8 EFLAGS: 00000246
[   21.049390] RAX: ffffffffc0985950 RBX: 0000000000000001 RCX: ffff8a3ab90d6000
[   21.049579] RDX: ffff8a3ab90d6000 RSI: 0000000000000001 RDI: ffff963f81ee7af0
[   21.049782] RBP: ffff963f81ee7a90 R08: 0000000000000001 R09: ffff8a3ab90d6000
[   21.049978] R10: c1267690ad7d2d9e R11: 00000000ffffffe0 R12: ffff8a3ab90d6000
[   21.050179] R13: ffffffffc0987040 R14: ffff963f81ee7af0 R15: ffff8a3ab90d6000
[   21.050377] FS:  0000000000000000(0000) GS:ffff8a3adecc0000(0000) knlGS:0000000000000000
[   21.050579] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.050777] CR2: 00007f2e169c4010 CR3: 00000001f700a005 CR4: 00000000001606e0
[   21.050981] BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:34
[   21.051183] in_atomic(): 1, irqs_disabled(): 0, pid: 935, name: cryptomgr_test
[   21.051390] CPU: 3 PID: 935 Comm: cryptomgr_test Tainted: G      D     E     4.17.0.g075a1d3-tip-default #146
[   21.051592] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[   21.051799] Call Trace:
[   21.052002]  dump_stack+0x85/0xcb
[   21.052207]  ___might_sleep+0xd8/0x130
[   21.052412]  exit_signals+0x21/0x1c0
[   21.052612]  do_exit+0xa0/0xb60
[   21.052808]  ? cryptomgr_test+0x40/0x50
[   21.052999]  ? kthread+0x11e/0x140
[   21.053176]  rewind_stack_do_exit+0x17/0x20
[   21.053354] note: cryptomgr_test[935] exited with preempt_count 2
...
[  200.214958] WARNING: CPU: 7 PID: 601 at crypto/algapi.c:369 crypto_wait_for_test+0x4c/0x60
[  200.214960] Modules linked in: fuse(E) devlink(E) ebtable_filter(E) ebtables(E) xt_comment(E) xt_physdev(E) br_netfilter(E) nfnetlink_cthelper(E) nfnetlink(E) af_packet(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) msr(E) ip6t_REJECT(E) nf_conntrack_ipv6(E) nf_defrag_ipv6(E) ipt_REJECT(E) xt_pkttype(E) xt_tcpudp(E) iptable_filter(E) bpfilter(E) ip6table_mangle(E) nf_conntrack_netbios_ns(E) nf_conntrack_broadcast(E) nf_conntrack_ipv4(E) nf_defrag_ipv4(E) ip_tables(E) xt_conntrack(E) nf_conntrack(E) libcrc32c(E) ip6table_filter(E) ip6_tables(E) x_tables(E) nls_iso8859_1(E) nls_cp437(E) joydev(E) snd_hda_codec_hdmi(E) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) snd_hda_intel(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) aegis128_aesni(E+) snd_timer(E) crct10dif_pclmul(E)
[  200.215086]  r8169(E) snd(E) crc32_pclmul(E) mii(E) iTCO_wdt(E) ghash_clmulni_intel(E) iTCO_vendor_support(E) pcbc(E) gpio_ich(E) aesni_intel(E) soundcore(E) aes_x86_64(E) lpc_ich(E) crypto_simd(E) mei_me(E) cryptd(E) mfd_core(E) i2c_i801(E) mei(E) glue_helper(E) pcspkr(E) thermal(E) intel_smartconnect(E) fan(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) sunrpc(E) sch_fq_codel(E) sr_mod(E) cdrom(E) hid_logitech_hidpp(E) hid_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) nouveau(E) wmi(E) i2c_algo_bit(E) drm_kms_helper(E) syscopyarea(E) xhci_pci(E) sysfillrect(E) sysimgblt(E) fb_sys_fops(E) ahci(E) ttm(E) ehci_pci(E) libahci(E) xhci_hcd(E) ehci_hcd(E) libata(E) drm(E) usbcore(E) video(E) button(E) sd_mod(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio_pci(E) virtio_ring(E)
[  200.215188]  virtio(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) efivarfs(E)
[  200.215216] CPU: 7 PID: 601 Comm: systemd-udevd Kdump: loaded Tainted: G      D W   E     4.17.0.g075a1d3-tip-default #146
[  200.215222] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[  200.215230] RIP: 0010:crypto_wait_for_test+0x4c/0x60
[  200.215234] Code: c0 75 2b 48 8d bb b8 00 00 00 31 f6 e8 2d fe ff ff 48 8d bb a8 01 00 00 e8 61 13 40 00 85 c0 75 09 48 89 df 5b e9 54 e5 ff ff <0f> 0b eb f3 0f 0b eb ef 66 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 
[  200.215303] RSP: 0018:ffff963f826cfc88 EFLAGS: 00010286
[  200.215310] RAX: 00000000fffffe00 RBX: ffff8a3ab18cb400 RCX: 0000000000000002
[  200.215316] RDX: 0000000000000000 RSI: 000000009d980d40 RDI: ffff8a3ab18cb5b0
[  200.215321] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000024f
[  200.215327] R10: 0000000000000355 R11: 00000000003d0900 R12: 0000000000000000
[  200.215333] R13: ffffffffc0988000 R14: 0000000000000002 R15: ffff8a3ab02a7f80
[  200.215340] FS:  00007fe89d980d40(0000) GS:ffff8a3adedc0000(0000) knlGS:0000000000000000
[  200.215346] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  200.215351] CR2: 00007f83fc010e08 CR3: 00000003f1abe006 CR4: 00000000001606e0
[  200.215356] Call Trace:
[  200.215367]  crypto_register_alg+0x52/0x60
[  200.215376]  crypto_register_aeads+0x35/0xa0
[  200.215383]  ? 0xffffffffc0325000
[  200.215391]  do_one_initcall+0x46/0x1e9
[  200.215400]  ? __vunmap+0x76/0xb0
[  200.215408]  do_init_module+0x5b/0x203
[  200.215415]  load_module+0x19d3/0x1f50
[  200.215422]  ? __do_sys_finit_module+0xb7/0xd0
[  200.215427]  __do_sys_finit_module+0xb7/0xd0
[  200.215433]  do_syscall_64+0x60/0x180
[  200.215438]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  200.215442] RIP: 0033:0x7fe89c807139
[  200.215444] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2f 0d 2c 00 f7 d8 64 89 01 48 
[  200.215528] RSP: 002b:00007fff4d130458 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  200.215549] RAX: ffffffffffffffda RBX: 000055b492f18880 RCX: 00007fe89c807139
[  200.215551] RDX: 0000000000000000 RSI: 00007fe89d14383d RDI: 0000000000000016
[  200.215554] RBP: 00007fe89d14383d R08: 0000000000000000 R09: 000055b492ecd480
[  200.215581] R10: 0000000000000016 R11: 0000000000000246 R12: 0000000000020000
[  200.215583] R13: 000055b492fa55e0 R14: 0000000000000000 R15: 0000000000000000
[  200.215587] ---[ end trace 8cdd2dd0a107e808 ]---




