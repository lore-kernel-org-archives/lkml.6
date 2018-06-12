Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A206FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FEE208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9z0ZOzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FEE208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934199AbeFLVff (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:35:35 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:33038 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933518AbeFLVfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:35:32 -0400
Received: by mail-qt0-f169.google.com with SMTP id l10-v6so521411qtj.0;
        Tue, 12 Jun 2018 14:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=I7mHCmvNDL99cyOqHo+lLVOfc+mvPpgreTv8Ay4gND4=;
        b=H9z0ZOzcsgHKEC0D1X2u2OqIQylm8wSDs5hFxQC1YT6XcOCg4Z+nQSi99bbi0beNo3
         6STWYIyelKcTCXC43blHZP580kZ8xrcYtih/T+4ijfFeGBXjN+z5w7mqkBSXVtPOrBee
         CuBvSq/vJucHpdeR5ow18EwD6lmyh1tr0877lhqOMKIE0Y2ALJ1H/yHpbJuWeKGmszk0
         Do9weBWFMbAfSQC4w7pVLf9662RplgYLGmYs7GMqZnMJdQ2+SnzYfg0NoZX6O4Vx85UP
         7tCKz51vrHSqLdUvhPSmNuaPyPlAbC6fHoiro8irB8JObTnpaZ7F8Qto4lmcJRbXw1q8
         tm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=I7mHCmvNDL99cyOqHo+lLVOfc+mvPpgreTv8Ay4gND4=;
        b=bbkqKdsSE8mKZN2r604dOX8p6OrQieq+EbitCu2kO3/r96IicemnOjhQLlZL2KEiZX
         XBHhQZw8sbJrAlg8GFv9ZCPwkAQIU5B2Whl/73yj4TmGWxotTKMgC3LI5Rgu64D7TjIX
         QEi/eFT2fdbMFBHm4AscMCeuc6SgdFgAtP1/Kq4GXL9iw4ZbjXStRaExk06yr26Xk2lI
         g/OOCfg1NQnjaeVvnQR0lxRHNFqxn0fbaiI6QM7JDv7zYg0OyyATD2OCS9EJw+IMm1Ta
         8PycGAJ4pAjJMxF+m6KdaGyms/0BIie6cA1eNMJFPzDclrD/U+PK46izwnzec5bIl9Lh
         EVIA==
X-Gm-Message-State: APt69E39jRatb41LMxiW3pcwu8WoolTWw09l3y7An23fMWT/vv+OKPUj
        K1eg5CgDNZaKiNZCfhmnsrdWdA==
X-Google-Smtp-Source: ADUXVKKrTDbIdV80i/XAQ1fiLNBMiBI1O3+QKzMxUHOIMo/Zzpebpyac1FXnPiksnvp9qtQqjYrLBQ==
X-Received: by 2002:a0c:b98a:: with SMTP id v10-v6mr2185353qvf.175.1528839331687;
        Tue, 12 Jun 2018 14:35:31 -0700 (PDT)
Received: from eaf ([181.47.179.0])
        by smtp.gmail.com with ESMTPSA id o68-v6sm877946qkc.19.2018.06.12.14.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 14:35:31 -0700 (PDT)
Date:   Tue, 12 Jun 2018 18:35:25 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc:     pavel@ucw.cz, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
Subject: Re: Mounting corrupted HFS+ causes kernel NULL pointer dereference
Message-ID: <20180612213521.2ona4vtnuu64hs6t@eaf>
References: <CAE5jQCfP1Z0oTBz_V0QkFwFqtJgekUMD2HZR=qA2oWxPvZrzsQ@mail.gmail.com>
 <20180603184955.zrowxp4y3ij66y5n@eaf>
 <20180608152557.GB11958@amd>
 <CAE5jQCeCOK5zoH4KbyP+hiMKp4MpkjJN1efzquoXCfPPXoj9Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE5jQCeCOK5zoH4KbyP+hiMKp4MpkjJN1efzquoXCfPPXoj9Nw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

On Tue, Jun 12, 2018 at 09:43:26PM +0300, Anatoly Trosinenko wrote:
> Hello,
> 
> > [1] https://www.spinics.net/lists/linux-fsdevel/msg125241.html
> > [2] https://www.spinics.net/lists/linux-fsdevel/msg126499.html
> 
> If I get it right, the first patch is already upstreamed in some
> modified form and cannot be applied on top of vanilla v4.17.

The first part of the patchset was already picked up, but your report
is related to the second part, which is the link at [1]. It should
still apply.

> When I
> apply the second one I get
> 
> $ patch -p1 < ../hfsplus-2.patch
> patching file fs/hfsplus/dir.c
> patching file fs/hfsplus/hfsplus_fs.h
> patching file fs/hfsplus/inode.c
> patching file fs/hfsplus/super.c
> Hunk #3 FAILED at 567.
> Hunk #4 succeeded at 586 (offset 1 line).
> 1 out of 4 hunks FAILED -- saving rejects to file fs/hfsplus/super.c.rej
> $ cat fs/hfsplus/super.c.rej
> --- fs/hfsplus/super.c
> +++ fs/hfsplus/super.c
> @@ -567,11 +547,6 @@ static int hfsplus_fill_super(struct super_block
> *sb, void *data, int silent)
>         sbi->nls = nls;
>         return 0;
> 
> -out_put_hidden_dir:
> -       iput(sbi->hidden_dir);
> -out_put_root:
> -       dput(sb->s_root);
> -       sb->s_root = NULL;
>  out_put_alloc_file:
>         iput(sbi->alloc_file);
>  out_close_attr_tree:

That's because a patch by Tetsuo Handa added a call to
cancel_delayed_work_sync() after the out_put_hidden_dir tag. Just remove
that line before applying the patch.

> 
> Looks, like manually removing this hunk cannot change anything
> (because of previous return), so just left as is.

Ok, that should be enough for testing. The rest of your mail seems like a
separate bug report, though. I'll take a look at it, but was the original
issue solved?

> 
> Now, when mounting the attached hfsplus_16mb_segv to /mnt and
> performing `dd if=/dev/zero of=/mnt/xyz bs=567879 count=1` I get
> 
> [    1.646451] BUG: unable to handle kernel NULL pointer dereference
> at 0000000000000043
> [    1.646666] PGD 1d4d2067 P4D 1d4d2067 PUD 1d4bc067 PMD 0
> [    1.646870] Oops: 0000 [#1] SMP NOPTI
> [    1.647002] Modules linked in:
> [    1.647209] CPU: 0 PID: 991 Comm: init Not tainted 4.17.0+ #1
> [    1.647291] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.10.2-1ubuntu1 04/01/2014
> [    1.647456] RIP: 0010:hfsplus_bnode_put+0x9/0xc0
> [    1.647522] RSP: 0018:ffffb750409b7a58 EFLAGS: 00000282
> [    1.647607] RAX: ffffa3b31e713000 RBX: 000000000a000000 RCX: 0000000011000000
> [    1.647696] RDX: 0000000000000000 RSI: ffffffff85ca56d0 RDI: fffffffffffffffb
> [    1.647787] RBP: ffffa3b31d473288 R08: 0000000000000000 R09: ffffb750409b7960
> [    1.647877] R10: 0000000000000000 R11: ffffa3b31df0e618 R12: ffffb750409b7ad0
> [    1.647967] R13: ffffa3b31d473180 R14: ffffa3b31d432a00 R15: 000000000000000a
> [    1.648089] FS:  0000000001dd48c0(0000) GS:ffffa3b31f800000(0000)
> knlGS:0000000000000000
> [    1.648192] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.648268] CR2: 0000000000000043 CR3: 000000001d4c4000 CR4: 00000000000006f0
> [    1.648406] Call Trace:
> [    1.648883]  hfsplus_brec_find+0x3c/0x150
> [    1.648970]  ? hfsplus_brec_remove+0x160/0x160
> [    1.649037]  hfsplus_ext_read_extent.part.6+0xba/0x190
> [    1.649118]  ? clean_bdev_aliases+0x81/0x1d0
> [    1.649178]  hfsplus_file_extend+0x16b/0x3a0
> [    1.649238]  hfsplus_get_block+0x60/0x250
> [    1.649293]  ? hfsplus_file_extend+0x3a0/0x3a0
> [    1.649352]  __block_write_begin_int+0x134/0x550
> [    1.649414]  ? hfsplus_file_extend+0x3a0/0x3a0
> [    1.649476]  ? percpu_counter_add_batch+0x48/0x60
> [    1.649537]  ? hfsplus_file_extend+0x3a0/0x3a0
> [    1.649596]  block_write_begin+0x3f/0xa0
> [    1.649652]  cont_write_begin+0x232/0x330
> [    1.649713]  ? hfsplus_file_extend+0x3a0/0x3a0
> [    1.649776]  hfsplus_write_begin+0x2f/0x70
> [    1.649834]  ? hfsplus_file_extend+0x3a0/0x3a0
> [    1.649902]  generic_perform_write+0xb1/0x1b0
> [    1.649965]  __generic_file_write_iter+0xfd/0x190
> [    1.650031]  generic_file_write_iter+0xe1/0x1e0
> [    1.650095]  __vfs_write+0xfc/0x160
> [    1.650148]  vfs_write+0xa8/0x190
> [    1.650196]  ksys_write+0x4d/0xb0
> [    1.650245]  do_syscall_64+0x43/0xf0
> [    1.650301]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [    1.650465] RIP: 0033:0x486804
> [    1.650510] RSP: 002b:00007ffd156ba4e8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> [    1.650611] RAX: ffffffffffffffda RBX: 0000000001dd48a0 RCX: 0000000000486804
> [    1.650695] RDX: 000000000008aa47 RSI: 00007ff996f60010 RDI: 0000000000000001
> [    1.650779] RBP: 0000000000000001 R08: 0000000000000000 R09: 000000000000000a
> [    1.650863] R10: 00000000000001b6 R11: 0000000000000246 R12: 00007ff996f60010
> [    1.650946] R13: 000000000008aa47 R14: 00007ff996f60010 R15: 0000000000000000
> [    1.651058] Code: 39 5a 68 77 ce 48 89 ef 5b 5d e9 03 c7 ef ff 0f
> 1f 00 48 85 ff 74 04 3e ff 47 48 f3 c3 0f 1f 44 00 00 48 85 ff 74 5b
> 41 54 55 53 <8b> 47 48 48 8b 2f 85 c0 0f 84 89 00 00 00 49 89 fc 48 8d
> 75 6c
> [    1.651492] RIP: hfsplus_bnode_put+0x9/0xc0 RSP: ffffb750409b7a58
> [    1.651583] CR2: 0000000000000043
> [    1.651851] ---[ end trace d164982d45c0eb53 ]---
> 
> (full log attached)
> 
> And when I mount hfsplus_16mb_hang and perform `echo > /mnt/xyz`, it hangs.
>
> PS: Please excuse me, if these patches just became slightly outdated
> and I didn't managed to apply them properly.
> пт, 8 июн. 2018 г. в 18:25, Pavel Machek <pavel@ucw.cz>:
> >
> > On Sun 2018-06-03 15:49:56, Ernesto A. Fernández wrote:
> > 1;2802;0c> Hi, thank you for your report.
> > >
> > > On Sun, Jun 03, 2018 at 06:52:19PM +0300, Anatoly Trosinenko wrote:
> > > > How to reproduce:
> > > > 1. Take kernel source v4.17-rc7
> > > > 2. Compile it with the config attached
> > > > 3. Unpack and mount the attached FS image as hfsplus.
> > >
> > > We are aware of this issue and I've sent some patches [1][2]. It's hard
> > > to get reviewers interested in hfsplus, so I don't know when it will be
> > > fixed.
> >
> > I guess Anatoly can still test the patches, and add Tested-by tags if
> > they help. No guarantees, but that may make it easier to get the patches
> > merged.
> >
> > Thanks,
> >                                                                 Pavel
> >
> > > [1] https://www.spinics.net/lists/linux-fsdevel/msg125241.html
> > > [2] https://www.spinics.net/lists/linux-fsdevel/msg126499.html
> >
> > --
> > (english) http://www.livejournal.com/~pavelmachek
> > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> 
> 
> 
> -- 
> С уважением,
> Анатолий Тросиненко
> e-mail: anatoly.trosinenko@gmail.com

> q[    0.000000] Linux version 4.17.0+ (trosinenko@trosinenko-pc) (gcc version 7.3.0 (Ubuntu 7.3.0-16ubuntu3)) #1 SMP Tue Jun 12 21:03:04 MSK 2018
> [    0.000000] Command line: console=ttyS0
> [    0.000000] x86/fpu: x87 FPU will use FXSAVE
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001ffdffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000001ffe0000-0x000000001fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.8 present.
> [    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> [    0.000000] e820: last_pfn = 0x1ffe0 max_arch_pfn = 0x400000000
> [    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.000000] found SMP MP-table at [mem 0x000f6aa0-0x000f6aaf] mapped at [        (ptrval)]
> [    0.000000] Scanning 1 areas for low memory corruption
> [    0.000000] RAMDISK: [mem 0x1fa5f000-0x1ffdffff]
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x00000000000F68C0 000014 (v00 BOCHS )
> [    0.000000] ACPI: RSDT 0x000000001FFE15FC 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
> [    0.000000] ACPI: FACP 0x000000001FFE1458 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
> [    0.000000] ACPI: DSDT 0x000000001FFE0040 001418 (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
> [    0.000000] ACPI: FACS 0x000000001FFE0000 000040
> [    0.000000] ACPI: APIC 0x000000001FFE154C 000078 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
> [    0.000000] ACPI: HPET 0x000000001FFE15C4 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
> [    0.000000] No NUMA configuration found
> [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000001ffdffff]
> [    0.000000] NODE_DATA(0) allocated [mem 0x1fa5b000-0x1fa5efff]
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.000000]   DMA32    [mem 0x0000000001000000-0x000000001ffdffff]
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> [    0.000000]   node   0: [mem 0x0000000000100000-0x000000001ffdffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000001ffdffff]
> [    0.000000] Reserved but unavailable: 98 pages
> [    0.000000] ACPI: PM-Timer IO Port: 0x608
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
> [    0.000000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> [    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
> [    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
> [    0.000000] e820: [mem 0x20000000-0xfffbffff] available for PCI devices
> [    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [    0.000000] random: get_random_bytes called from start_kernel+0x8b/0x49f with crng_init=0
> [    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:1 nr_node_ids:1
> [    0.000000] percpu: Embedded 43 pages/cpu @        (ptrval) s137304 r8192 d30632 u2097152
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 128873
> [    0.000000] Policy zone: DMA32
> [    0.000000] Kernel command line: console=ttyS0
> [    0.000000] Memory: 481668K/523768K available (14348K kernel code, 1363K rwdata, 3092K rodata, 1260K init, 592K bss, 42100K reserved, 0K cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] 	RCU event tracing is enabled.
> [    0.000000] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=1.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
> [    0.000000] NR_IRQS: 4352, nr_irqs: 256, preallocated irqs: 16
> [    0.000000] Console: colour VGA+ 80x25
> [    0.000000] console [ttyS0] enabled
> [    0.000000] ACPI: Core revision 20180313
> [    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
> [    0.000000] APIC: Switch to symmetric I/O mode setup
> [    0.004000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.009000] tsc: Fast TSC calibration using PIT
> [    0.010000] tsc: Detected 2808.151 MHz processor
> [    0.011075] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x287a54bc888, max_idle_ns: 440795323113 ns
> [    0.011420] Calibrating delay loop (skipped), value calculated using timer frequency.. 5616.30 BogoMIPS (lpj=2808151)
> [    0.011628] pid_max: default: 32768 minimum: 301
> [    0.012207] Security Framework initialized
> [    0.012355] SELinux:  Initializing.
> [    0.013353] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
> [    0.013606] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
> [    0.013801] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
> [    0.013910] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 bytes)
> [    0.022989] mce: CPU supports 10 MCE banks
> [    0.023723] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> [    0.023800] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> [    0.023922] Spectre V2 : Spectre mitigation: LFENCE not serializing, switching to generic retpoline
> [    0.024027] Spectre V2 : Mitigation: Full generic retpoline
> [    0.024115] Spectre V2 : Spectre v2 mitigation: Filling RSB on context switch
> [    0.024225] Speculative Store Bypass: Vulnerable
> [    0.256181] random: fast init done
> [    0.305200] Freeing SMP alternatives memory: 40K
> [    0.313000] smpboot: CPU0: AMD QEMU Virtual CPU version 2.5+ (family: 0x6, model: 0x6, stepping: 0x3)
> [    0.315904] Performance Events: PMU not available due to virtualization, using software events only.
> [    0.317400] Hierarchical SRCU implementation.
> [    0.320150] Huh? What family is it: 0x6?!
> [    0.320475] smp: Bringing up secondary CPUs ...
> [    0.320588] smp: Brought up 1 node, 1 CPU
> [    0.320663] smpboot: Max logical packages: 1
> [    0.320761] smpboot: Total of 1 processors activated (5616.30 BogoMIPS)
> [    0.327560] devtmpfs: initialized
> [    0.332394] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.332624] futex hash table entries: 256 (order: 2, 16384 bytes)
> [    0.334789] RTC time: 18:33:20, date: 06/12/18
> [    0.337908] NET: Registered protocol family 16
> [    0.344636] kworker/u2:0 (16) used greatest stack depth: 14640 bytes left
> [    0.345222] audit: initializing netlink subsys (disabled)
> [    0.350588] cpuidle: using governor menu
> [    0.351311] ACPI: bus type PCI registered
> [    0.351923] audit: type=2000 audit(1528828400.345:1): state=initialized audit_enabled=0 res=1
> [    0.353057] kworker/u2:1 (32) used greatest stack depth: 14160 bytes left
> [    0.355987] PCI: Using configuration type 1 for base access
> [    0.456912] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.459470] ACPI: Added _OSI(Module Device)
> [    0.459558] ACPI: Added _OSI(Processor Device)
> [    0.459616] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.459672] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.459797] ACPI: Added _OSI(Linux-Dell-Video)
> [    0.470278] ACPI: 1 ACPI AML tables successfully acquired and loaded
> [    0.480891] ACPI: Interpreter enabled
> [    0.481547] ACPI: (supports S0 S3 S4 S5)
> [    0.481641] ACPI: Using IOAPIC for interrupt routing
> [    0.482239] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.483288] ACPI: Enabled 2 GPEs in block 00 to 0F
> [    0.528607] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.528965] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
> [    0.529250] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
> [    0.530612] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
> [    0.532483] PCI host bridge to bus 0000:00
> [    0.532635] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.532729] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.532817] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    0.532905] pci_bus 0000:00: root bus resource [mem 0x20000000-0xfebfffff window]
> [    0.533082] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
> [    0.533261] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.539745] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
> [    0.540051] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
> [    0.540154] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
> [    0.540248] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
> [    0.541932] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
> [    0.542075] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
> [    0.556696] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
> [    0.559162] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
> [    0.559701] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
> [    0.560435] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
> [    0.560737] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
> [    0.565763] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    0.565917] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    0.566050] pci 0000:00:02.0: vgaarb: bridge control possible
> [    0.566184] vgaarb: loaded
> [    0.568041] SCSI subsystem initialized
> [    0.570234] ACPI: bus type USB registered
> [    0.570852] usbcore: registered new interface driver usbfs
> [    0.571353] usbcore: registered new interface driver hub
> [    0.571629] usbcore: registered new device driver usb
> [    0.572603] pps_core: LinuxPPS API ver. 1 registered
> [    0.572678] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.572945] PTP clock support registered
> [    0.576084] EDAC MC: Ver: 3.0.0
> [    0.578835] Advanced Linux Sound Architecture Driver Initialized.
> [    0.579444] PCI: Using ACPI for IRQ routing
> [    0.585949] NetLabel: Initializing
> [    0.586044] NetLabel:  domain hash size = 128
> [    0.586107] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    0.587445] NetLabel:  unlabeled traffic allowed by default
> [    0.588522] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
> [    0.588764] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [    0.588891] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
> [    0.593241] clocksource: Switched to clocksource tsc-early
> [    0.696614] VFS: Disk quotas dquot_6.6.0
> [    0.696825] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.699060] pnp: PnP ACPI init
> [    0.705552] pnp: PnP ACPI: found 6 devices
> [    0.744972] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    0.746549] NET: Registered protocol family 2
> [    0.750211] tcp_listen_portaddr_hash hash table entries: 256 (order: 0, 4096 bytes)
> [    0.750400] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.750605] TCP bind hash table entries: 4096 (order: 4, 65536 bytes)
> [    0.750774] TCP: Hash tables configured (established 4096 bind 4096)
> [    0.751564] UDP hash table entries: 256 (order: 1, 8192 bytes)
> [    0.751765] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
> [    0.752779] NET: Registered protocol family 1
> [    0.754106] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
> [    0.754233] pci 0000:00:01.0: PIIX3: Enabling Passive Release
> [    0.754381] pci 0000:00:01.0: Activating ISA DMA hang workarounds
> [    0.754609] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    0.757227] Unpacking initramfs...
> [    0.796453] Freeing initrd memory: 5636K
> [    0.799358] Scanning for low memory corruption every 60 seconds
> [    0.807186] Initialise system trusted keyrings
> [    0.809200] workingset: timestamp_bits=56 max_order=17 bucket_order=0
> [    0.843166] SGI XFS with ACLs, security attributes, no debug enabled
> [    0.863302] Key type asymmetric registered
> [    0.863416] Asymmetric key parser 'x509' registered
> [    0.863683] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
> [    0.863949] io scheduler noop registered
> [    0.864033] io scheduler deadline registered
> [    0.864433] io scheduler cfq registered (default)
> [    0.864524] io scheduler mq-deadline registered
> [    0.864585] io scheduler kyber registered
> [    0.867876] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> [    0.869385] ACPI: Power Button [PWRF]
> [    0.875511] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    0.897131] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    0.905566] Non-volatile memory driver v1.3
> [    0.906225] Linux agpgart interface v0.103
> [    0.927374] loop: module loaded
> [    0.937972] scsi host0: ata_piix
> [    0.940405] scsi host1: ata_piix
> [    0.940818] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 14
> [    0.941020] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 15
> [    0.941815] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
> [    0.941946] e100: Copyright(c) 1999-2006 Intel Corporation
> [    0.944753] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
> [    0.944855] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [    1.075657] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
> [    1.075760] ata1.00: 32768 sectors, multi 16: LBA48 
> [    1.076797] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
> [    1.077520] ata2.00: configured for MWDMA2
> [    1.078327] ata1.00: configured for MWDMA2
> [    1.089010] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> [    1.091094] PCI Interrupt Link [LNKC] enabled at IRQ 11
> [    1.094742] sd 0:0:0:0: [sda] 32768 512-byte logical blocks: (16.8 MB/16.0 MiB)
> [    1.095315] sd 0:0:0:0: [sda] Write Protect is off
> [    1.095810] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.097652] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [    1.100689] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
> [    1.118204] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> [    1.118415] cdrom: Uniform CD-ROM driver Revision: 3.20
> [    1.121356] sr 1:0:0:0: Attached scsi generic sg1 type 5
> [    1.128653] sd 0:0:0:0: [sda] Attached SCSI disk
> [    1.378451] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
> [    1.378682] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
> [    1.379270] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [    1.379355] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    1.379633] sky2: driver version 1.30
> [    1.381577] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    1.381695] ehci-pci: EHCI PCI platform driver
> [    1.381920] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    1.382544] ohci-pci: OHCI PCI platform driver
> [    1.382787] uhci_hcd: USB Universal Host Controller Interface driver
> [    1.384957] usbcore: registered new interface driver usblp
> [    1.385490] usbcore: registered new interface driver usb-storage
> [    1.386634] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
> [    1.389157] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    1.390436] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    1.394395] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
> [    1.397722] rtc_cmos 00:00: RTC can wake from S4
> [    1.402670] rtc_cmos 00:00: registered as rtc0
> [    1.403477] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes nvram, hpet irqs
> [    1.405580] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
> [    1.406344] hidraw: raw HID events driver (C) Jiri Kosina
> [    1.413025] usbcore: registered new interface driver usbhid
> [    1.413180] usbhid: USB HID core driver
> [    1.424629] Initializing XFRM netlink socket
> [    1.426692] NET: Registered protocol family 10
> [    1.431926] Segment Routing with IPv6
> [    1.434195] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> [    1.436399] NET: Registered protocol family 17
> [    1.436611] Key type dns_resolver registered
> [    1.438404] sched_clock: Marking stable (1438066778, 0)->(1533220173, -95153395)
> [    1.441512] registered taskstats version 1
> [    1.441593] Loading compiled-in X.509 certificates
> [    1.444655]   Magic number: 6:839:594
> [    1.445147] console [netcon0] enabled
> [    1.445218] netconsole: network logging started
> [    1.446829] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [    1.456000] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [    1.457039] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
> [    1.457330] cfg80211: failed to load regulatory.db
> [    1.458024] ALSA device list:
> [    1.458151]   No soundcards found.
> [    1.484775] Freeing unused kernel memory: 1260K
> [    1.487204] Write protecting the kernel read-only data: 20480k
> [    1.489287] Freeing unused kernel memory: 2004K
> [    1.496132] Freeing unused kernel memory: 1004K
> [    1.636536] exe (989) used greatest stack depth: 12872 bytes left
> [    1.646451] BUG: unable to handle kernel NULL pointer dereference at 0000000000000043
> [    1.646666] PGD 1d4d2067 P4D 1d4d2067 PUD 1d4bc067 PMD 0 
> [    1.646870] Oops: 0000 [#1] SMP NOPTI
> [    1.647002] Modules linked in:
> [    1.647209] CPU: 0 PID: 991 Comm: init Not tainted 4.17.0+ #1
> [    1.647291] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> [    1.647456] RIP: 0010:hfsplus_bnode_put+0x9/0xc0
> [    1.647522] RSP: 0018:ffffb750409b7a58 EFLAGS: 00000282
> [    1.647607] RAX: ffffa3b31e713000 RBX: 000000000a000000 RCX: 0000000011000000
> [    1.647696] RDX: 0000000000000000 RSI: ffffffff85ca56d0 RDI: fffffffffffffffb
> [    1.647787] RBP: ffffa3b31d473288 R08: 0000000000000000 R09: ffffb750409b7960
> [    1.647877] R10: 0000000000000000 R11: ffffa3b31df0e618 R12: ffffb750409b7ad0
> [    1.647967] R13: ffffa3b31d473180 R14: ffffa3b31d432a00 R15: 000000000000000a
> [    1.648089] FS:  0000000001dd48c0(0000) GS:ffffa3b31f800000(0000) knlGS:0000000000000000
> [    1.648192] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.648268] CR2: 0000000000000043 CR3: 000000001d4c4000 CR4: 00000000000006f0
> [    1.648406] Call Trace:
> [    1.648883]  hfsplus_brec_find+0x3c/0x150
> [    1.648970]  ? hfsplus_brec_remove+0x160/0x160
> [    1.649037]  hfsplus_ext_read_extent.part.6+0xba/0x190
> [    1.649118]  ? clean_bdev_aliases+0x81/0x1d0
> [    1.649178]  hfsplus_file_extend+0x16b/0x3a0
> [    1.649238]  hfsplus_get_block+0x60/0x250
> [    1.649293]  ? hfsplus_file_extend+0x3a0/0x3a0
> [    1.649352]  __block_write_begin_int+0x134/0x550
> [    1.649414]  ? hfsplus_file_extend+0x3a0/0x3a0
> [    1.649476]  ? percpu_counter_add_batch+0x48/0x60
> [    1.649537]  ? hfsplus_file_extend+0x3a0/0x3a0
> [    1.649596]  block_write_begin+0x3f/0xa0
> [    1.649652]  cont_write_begin+0x232/0x330
> [    1.649713]  ? hfsplus_file_extend+0x3a0/0x3a0
> [    1.649776]  hfsplus_write_begin+0x2f/0x70
> [    1.649834]  ? hfsplus_file_extend+0x3a0/0x3a0
> [    1.649902]  generic_perform_write+0xb1/0x1b0
> [    1.649965]  __generic_file_write_iter+0xfd/0x190
> [    1.650031]  generic_file_write_iter+0xe1/0x1e0
> [    1.650095]  __vfs_write+0xfc/0x160
> [    1.650148]  vfs_write+0xa8/0x190
> [    1.650196]  ksys_write+0x4d/0xb0
> [    1.650245]  do_syscall_64+0x43/0xf0
> [    1.650301]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [    1.650465] RIP: 0033:0x486804
> [    1.650510] RSP: 002b:00007ffd156ba4e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [    1.650611] RAX: ffffffffffffffda RBX: 0000000001dd48a0 RCX: 0000000000486804
> [    1.650695] RDX: 000000000008aa47 RSI: 00007ff996f60010 RDI: 0000000000000001
> [    1.650779] RBP: 0000000000000001 R08: 0000000000000000 R09: 000000000000000a
> [    1.650863] R10: 00000000000001b6 R11: 0000000000000246 R12: 00007ff996f60010
> [    1.650946] R13: 000000000008aa47 R14: 00007ff996f60010 R15: 0000000000000000
> [    1.651058] Code: 39 5a 68 77 ce 48 89 ef 5b 5d e9 03 c7 ef ff 0f 1f 00 48 85 ff 74 04 3e ff 47 48 f3 c3 0f 1f 44 00 00 48 85 ff 74 5b 41 54 55 53 <8b> 47 48 48 8b 2f 85 c0 0f 84 89 00 00 00 49 89 fc 48 8d 75 6c 
> [    1.651492] RIP: hfsplus_bnode_put+0x9/0xc0 RSP: ffffb750409b7a58
> [    1.651583] CR2: 0000000000000043
> [    1.651851] ---[ end trace d164982d45c0eb53 ]---
> [    1.824302] tsc: Refined TSC clocksource calibration: 2808.022 MHz
> [    1.824473] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2879db23480, max_idle_ns: 440795344018 ns
> [    1.824665] clocksource: Switched to clocksource tsc
> [    2.025396] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3



