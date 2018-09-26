Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6495BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134F62152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134F62152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeI0Ahd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:37:33 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:25669 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725733AbeI0Ahd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:37:33 -0400
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 33940627DF;
        Wed, 26 Sep 2018 18:23:20 +0000 (UTC)
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 4F2705A;
        Wed, 26 Sep 2018 18:23:19 +0000 (UTC)
Received: from hpe.com (ben.americas.hpqcorp.net [10.33.153.7])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 4D3AC4C;
        Wed, 26 Sep 2018 18:23:18 +0000 (UTC)
Date:   Wed, 26 Sep 2018 13:23:18 -0500
From:   Russ Anderson <rja@hpe.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Justin Ernst <justin.ernst@hpe.com>, russ.anderson@hpe.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: Re: [PATCH] Raise maximum number of memory controllers
Message-ID: <20180926182317.patqjso7nzw2oxiz@hpe.com>
Reply-To: Russ Anderson <rja@hpe.com>
References: <20180925143449.284634-1-justin.ernst@hpe.com>
 <20180925152659.GE23986@zn.tnic>
 <20180925175023.GA16725@agluck-desk>
 <20180925180458.GG23986@zn.tnic>
 <20180926093510.GA5584@zn.tnic>
 <20180926152752.GG5584@zn.tnic>
 <20180926130340.6b22918b@coco.lan>
 <20180926161749.GI5584@zn.tnic>
 <20180926181035.GA1132@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926181035.GA1132@agluck-desk>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 11:10:35AM -0700, Luck, Tony wrote:
> On Wed, Sep 26, 2018 at 06:17:49PM +0200, Borislav Petkov wrote:
> > On Wed, Sep 26, 2018 at 01:03:40PM -0300, Mauro Carvalho Chehab wrote:
> > > I guess this is/was needed to create things like this:
> > > 
> > > 	lrwxrwxrwx 1 root root 0 set 26 05:24 /sys/bus/edac/devices/mc -> ../../../devices/system/edac/mc
> > 
> > They're still there:
> > 
> > $ ls -l /sys/bus/edac/devices/
> > total 0
> > lrwxrwxrwx 1 root root 0 Sep 26 18:15 csrow0 -> ../../../devices/system/edac/mc/mc0/csrow0
> > lrwxrwxrwx 1 root root 0 Sep 26 18:15 dimm0 -> ../../../devices/system/edac/mc/mc0/dimm0
> > lrwxrwxrwx 1 root root 0 Sep 26 18:15 dimm3 -> ../../../devices/system/edac/mc/mc0/dimm3
> > lrwxrwxrwx 1 root root 0 Sep 26 18:15 dimm6 -> ../../../devices/system/edac/mc/mc0/dimm6
> > lrwxrwxrwx 1 root root 0 Sep 26 18:15 dimm9 -> ../../../devices/system/edac/mc/mc0/dimm9
> > lrwxrwxrwx 1 root root 0 Sep 26 18:15 mc -> ../../../devices/system/edac/mc
> > lrwxrwxrwx 1 root root 0 Sep 26 18:15 mc0 -> ../../../devices/system/edac/mc/mc0
> 
> I ran into trouble on my 4 socket broadwell server (so 8 memory controllers,
> a whole pile of DIMMs, running from sb_edac.c)

We are also having trouble on a 32 socket system.

---------------------------------------------------------------------------------------------
[  OK  ] Started Load kdump kernel early on startup.
[   ***] (2 of 2) A start job is running for...work interfaces (18s / no limit)[  132.638611] BUG: unable to handle kernel paging request at ffff8c7efeebefff
[  132.640895] PGD 5fec3fdd067 P4D 5fec3fdd067 PUD 5fec3fda067 PMD 0 
[  132.640895] Oops: 0002 [#1] SMP PTI
[  132.640895] CPU: 650 PID: 9884 Comm: kworker/650:1 Kdump: loaded Tainted: G            E     4.19.0-rc4-ernstj+ #6
[  132.640895] Hardware name: HPE Superdome Flex/Superdome Flex, BIOS Bundle:3.0.196 SFW:IP147.007.000.071.000.1809242200 09/24/2018
[  132.640895] Workqueue: events cache_reap
[  132.640895] RIP: 0010:free_block+0x11c/0x1e0
[  132.640895] Code: ea 20 45 29 d7 41 d3 ef 0f b6 4f 1d 45 01 fa 41 d3 ea 8b 48 30 44 8d 79 ff 48 8b 48 20 44 89 78 30 48 85 c9 0f 84 a5 00 00 00 <46> 88 14 39 8b 48 30 85 c9 0f 84 32 ff ff ff 49 8b 49 10 4c 8d 50
[  132.640895] RSP: 0018:ffffc9004b0c7d90 EFLAGS: 00010086
[  132.640895] RAX: ffffea11f7fbafc0 RBX: 0000000000000002 RCX: ffff8c7dfeebf000
[  132.640895] RDX: 0000000000000005 RSI: ffff8c7e08da9328 RDI: ffff880147c02000
[  132.640895] RBP: 0000000080000000 R08: ffff8c5047c004a8 R09: ffff8c5047c00480
[  132.640895] R10: 0000000000000001 R11: ffff8c7dfeebf800 R12: ffffea0000000000
[  132.640895] R13: 000077ff80000000 R14: ffff8c5047c00488 R15: 00000000ffffffff
[  132.640895] FS:  0000000000000000(0000) GS:ffff8c7e08d80000(0000) knlGS:0000000000000000
[  132.640895] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  132.640895] CR2: ffff8c7efeebefff CR3: 000000000200a006 CR4: 00000000007606e0
[  132.640895] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  132.640895] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  132.640895] PKRU: 55555554
[  132.640895] Call Trace:
[  132.640895]  drain_array_locked+0x5b/0x80
[  132.640895]  drain_array+0x63/0x90
[  132.640895]  cache_reap+0x68/0x1f0
[  132.640895]  process_one_work+0x165/0x360
[  132.640895]  worker_thread+0x49/0x3e0
[  132.640895]  kthread+0xf8/0x130
[  132.640895]  ? max_active_store+0x60/0x60
[  132.640895]  ? kthread_bind+0x10/0x10
[  132.640895]  ret_from_fork+0x35/0x40
[  132.640895] Modules linked in: acpi_cpufreq(E-) skx_edac(E+) intel_rapl(E) nfit(E) libnvdimm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) kvm(E) irqbypass(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) pcbc(E) aesni_intel(E) aes_x86_64(E) iscsi_ibft(E) crypto_simd(E) iscsi_boot_sysfs(E) cryptd(E) glue_helper(E) pcspkr(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) joydev(E) i40e(E) ipmi_ssif(E) lpc_ich(E) i2c_i801(E) mfd_core(E) wmi(E) ipmi_si(E) ipmi_devintf(E) ipmi_msghandler(E) button(E) xfs(E) libcrc32c(E) hid_generic(E) usbhid(E) sd_mod(E) mgag200(E) i2c_algo_bit(E) drm_kms_helper(E) syscopyarea(E) crc32c_intel(E) sysfillrect(E) xhci_pci(E) sysimgblt(E) fb_sys_fops(E) xhci_hcd(E) ahci(E) libahci(E) ttm(E) drm(E) libata(E) usbcore(E) sg(E) dm_multipath(E)
[  132.916934]  dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) msr(E) efivarfs(E) autofs4(E)
[  132.916934] CR2: ffff8c7efeebefff
[  132.916934] ---[ end trace 9ee1381bf4bae01f ]---
[  *** ] (2 of 2) A start job is running for.[  132.916934] RIP: 0010:free_block+0x11c/0x1e0
[  132.916934] Code: ea 20 45 29 d7 41 d3 ef 0f b6 4f 1d 45 01 fa 41 d3 ea 8b 48 30 44 8d 79 ff 48 8b 48 20 44 89 78 30 48 85 c9 0f 84 a5 00 00 00 <46> 88 14 39 8b 48 30 85 c9 0f 84 32 ff ff ff 49 8b 49 10 4c 8d 50
[  132.916934] RSP: 0018:ffffc9004b0c7d90 EFLAGS: 00010086
..work interface[  132.977236] EDAC MC: Removed device 0 for skx_edac Skylake Socket#0 IMC#0: DEV 0000:80:0a.0
[  132.916934] RAX: ffffea11f7fbafc0 RBX: 0000000000000002 RCX: ffff8c7dfeebf000
[  132.916934] RDX: 0000000000000005 RSI: ffff8c7e08da9328 RDI: ffff880147c02000
s (19s / no limi[  133.004953] RBP: 0000000080000000 R08: ffff8c5047c004a8 R09: ffff8c5047c00480
[  133.004953] R10: 0000000000000001 R11: ffff8c7dfeebf800 R12: ffffea0000000000
[  133.004953] R13: 000077ff80000000 R14: ffff8c5047c00488 R15: 00000000ffffffff
[  133.004953] FS:  0000000000000000(0000) GS:ffff8c7e08d80000(0000) knlGS:0000000000000000
[  133.004953] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  133.004953] CR2: ffff8c7efeebefff CR3: 000000000200a006 CR4: 00000000007606e0
[  133.004953] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  133.004953] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  133.004953] PKRU: 55555554
[  133.004953] Kernel panic - not syncing: Fatal exception
---------------------------------------------------------------------------------------------

> Things start going wrong with:
> 
> [   45.216657] sysfs: cannot create duplicate filename '/bus/edac/devices/dimm0'
> [   45.216663] CPU: 37 PID: 2034 Comm: systemd-udevd Not tainted 4.19.0-rc5 #1
> [   45.216665] Hardware name: Intel Corporation BRICKLAND/BRICKLAND, BIOS BRBDXSD1.86B.0338.V01.1603162127 03/16/2016
> [   45.216667] Call Trace:
> [   45.216688]  dump_stack+0x5c/0x7b
> [   45.216697]  sysfs_warn_dup+0x56/0x70
> [   45.216702]  sysfs_do_create_link_sd.isra.2+0x98/0xb0
> [   45.216714]  bus_add_device+0x77/0x160
> [   45.216720]  device_add+0x424/0x660
> [   45.216731]  edac_create_sysfs_mci_device+0xb9/0x2f0
> [   45.216738]  edac_mc_add_mc_with_groups+0x111/0x2b0
> [   45.216747]  sbridge_init+0x13c9/0x2000 [sb_edac]
> [   45.216757]  ? _raw_spin_lock+0x1d/0x20
> [   45.216765]  ? free_pcppages_bulk+0x2ca/0x630
> [   45.216769]  ? 0xffffffffc050f000
> [   45.216779]  do_one_initcall+0x46/0x1c8
> [   45.216784]  ? free_unref_page_commit+0x95/0x120
> [   45.216791]  ? _cond_resched+0x15/0x40
> [   45.216798]  ? kmem_cache_alloc_trace+0x153/0x1c0
> [   45.216805]  do_init_module+0x5b/0x208
> [   45.216826]  load_module+0x1a2d/0x1fb0
> [   45.216835]  ? __do_sys_finit_module+0xe9/0x110
> [   45.216840]  __do_sys_finit_module+0xe9/0x110
> [   45.216847]  do_syscall_64+0x5b/0x180
> [   45.216852]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   45.216856] RIP: 0033:0x7fcdec618bd9
> 
> and fell off a cliff after that.
> 
> Going back to the old code I have a "dimm0" on each of the eight controllers:
> 
> # find /sys -name dimm0
> /sys/devices/system/edac/mc/mc6/dimm0
> /sys/devices/system/edac/mc/mc4/dimm0
> /sys/devices/system/edac/mc/mc2/dimm0
> /sys/devices/system/edac/mc/mc0/dimm0
> /sys/devices/system/edac/mc/mc7/dimm0
> /sys/devices/system/edac/mc/mc5/dimm0
> /sys/devices/system/edac/mc/mc3/dimm0
> /sys/devices/system/edac/mc/mc1/dimm0
> /sys/bus/mc6/devices/dimm0
> /sys/bus/mc4/devices/dimm0
> /sys/bus/mc2/devices/dimm0
> /sys/bus/mc0/devices/dimm0
> /sys/bus/mc7/devices/dimm0
> /sys/bus/mc5/devices/dimm0
> /sys/bus/mc3/devices/dimm0
> /sys/bus/mc1/devices/dimm0
> # ls -l /sys/bus/mc0/devices
> total 0
> lrwxrwxrwx. 1 root root 0 Sep 26 11:08 csrow0 -> ../../../devices/system/edac/mc/mc0/csrow0
> lrwxrwxrwx. 1 root root 0 Sep 26 11:08 dimm0 -> ../../../devices/system/edac/mc/mc0/dimm0
> lrwxrwxrwx. 1 root root 0 Sep 26 11:08 dimm3 -> ../../../devices/system/edac/mc/mc0/dimm3
> lrwxrwxrwx. 1 root root 0 Sep 26 11:08 dimm6 -> ../../../devices/system/edac/mc/mc0/dimm6
> lrwxrwxrwx. 1 root root 0 Sep 26 11:08 dimm9 -> ../../../devices/system/edac/mc/mc0/dimm9
> lrwxrwxrwx. 1 root root 0 Sep 26 11:08 mc0 -> ../../../devices/system/edac/mc/mc0
> 
> It looks like the new code isn't trying to place the dimm symlinks
> in the proper subdirectories.
> 
> -Tony

-- 
Russ Anderson,  SuperDome Flex Linux Kernel Group Manager
HPE - Hewlett Packard Enterprise (formerly SGI)  rja@hpe.com
