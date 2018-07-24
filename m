Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FD1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3ACF20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2G8Zezs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3ACF20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388300AbeGXCHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 22:07:39 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34191 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388188AbeGXCHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 22:07:39 -0400
Received: by mail-pl0-f67.google.com with SMTP id f6-v6so963670plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 18:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P9AAx3nRNXji98I1i7QgXsQtUip40cjcnvDhkg2JekQ=;
        b=F2G8ZezsLhHPDLsQHmMe+eTQ2zqS1F0XIKsWqpXltRPdI9MmOEQx7/4iM6a5LQBurF
         ira80QY26Zg0yYCaSBzoSwvnzFFKN+d+xmkqJSdU/0qFoINUAz/TvDCwXxVRKggpPSWd
         c2zeN2XJV399U9cutiLNGhg1OKKGm9eJaLpNrghRwZN5N1TrbsGw/nam3KynXbhv6xkn
         40zTkQlM3njz2NOSrSqLRPQXFUG8gLkp09/xs8JSm483aw5Us0z9jRSqWijRhA1GPcdU
         elIF+bYKRiUnJzMwKwvegKSpAksRxo+kVItBEKJdTTifZAIfyU4E+6FbuI/1d3NzKVQP
         V9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=P9AAx3nRNXji98I1i7QgXsQtUip40cjcnvDhkg2JekQ=;
        b=iVPcxm526YLGYFd6plfo2cSae5g/zg3UpRJJR9ea2eSpSlqe3NWLfMNNhPcOcFZ9ed
         W0o3vm9oKjwV2VrPKQHg4IKruAxnm7bS7aq2szNQQ/niNNBfTn715GySkqqEhWTUfrY7
         Gm3bVIXCfgdVEndpqqqcDvWAdScUtcftF99mIJswzsnEVn1VAN5JYVfWJ58KTNdnbrOg
         gTi4BJSdzvxehbH9+sHEe3Psj1RvfSNCZoBl7HJKChFk4pHJ5Owj4n+uDrOH8v8G/a+w
         IRdprf6W8HC8IZpvBHEtVQkP/4VJ/Lru7XPe6aeW3deTDA8/PheSEE5ZRNK8BqOFg1bm
         +EIw==
X-Gm-Message-State: AOUpUlEpgZphc2cSsDwkfGMnb1WQtD9WHkI54XdBf+LjM1ApHHfnGRq0
        qcARt78jBrKK7wd+BYKRm/bdHQWG
X-Google-Smtp-Source: AAOMgpctPTpSCVB8rviw16HYkDwJxvg4mdap9CFCDfrcB8qO4MopsvFL76Hf+q/zH0C23z7LlWJ91A==
X-Received: by 2002:a17:902:42c3:: with SMTP id h61-v6mr14847240pld.319.1532394228397;
        Mon, 23 Jul 2018 18:03:48 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id z184-v6sm18868308pgd.83.2018.07.23.18.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 18:03:46 -0700 (PDT)
Date:   Tue, 24 Jul 2018 10:03:42 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Tino Lehnig <tino.lehnig@contabo.de>
Cc:     ngupta@vflare.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
Message-ID: <20180724010342.GA195675@rodete-desktop-imager.corp.google.com>
References: <0516ae2d-b0fd-92c5-aa92-112ba7bd32fc@contabo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0516ae2d-b0fd-92c5-aa92-112ba7bd32fc@contabo.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tino,

Thanks for the report.

On Mon, Jul 23, 2018 at 02:29:32PM +0200, Tino Lehnig wrote:
> Hello,
> 
> after enabling the writeback feature in zram, I encountered the kernel bug
> below with heavy swap utilization. There is one specific workload that
> triggers the bug reliably and that is running Windows in KVM while
> overcommitting memory. The Windows VMs would fill all allocated memory with
> zero pages while booting. A few seconds after the host hits zram swap, the
> console on the host is flooded with the bug message. A few more seconds
> later I also encountered filesystem errors on the host causing the root
> filesystem to be mounted read-only. The filesystem errors do not occur when
> leaving RAM available for the host OS by limiting physical memory of the
> QEMU processes via cgroups.
> 
> I started three KVM instances with the following commands in my tests. Any
> Windows ISO or disk image can be used. Less instances and smaller allocated
> memory will also trigger the bug as long as swapping occurs. The type of
> writeback device does not seem to matter. I have tried a SATA SSD and an
> NVMe Optane drive so far. My test machine has 256 GB of RAM and one CPU. I
> saw the same behavior on another machine with two CPUs and 128 GB of RAM.
> 
> The bug does not occur when using zram as swap without "backing_dev" being
> set, but I had even more severe problems when running the same test on
> Ubuntu Kernels 4.15 and 4.17. Regardless of the writeback feature being used
> or not, the host would eventually lock up entirely when swap is in use on
> zram. The lockups may not be related directly to zram though and were
> apparently fixed in 4.18. I had absolutely no problems on Ubuntu Kernel 4.13
> either, before the writeback feature was introduced.

We didn't release v4.18 yet. Could you say what kernel tree/what version
you used?

Now I don't have enough time to dig in.

Sergey, I really appreciate if you could have availabe time to look into.
Anyway, I could try to see it asap if Sergey is not available.
No worry.

Thanks.


> 
> Thank you for your attention.
> 
> --
> 
> commands used:
> 
> modprobe zram
> echo 1 > /sys/block/zram0/reset
> echo lz4 > /sys/block/zram0/comp_algorithm
> echo /dev/nvme0n1 > /sys/block/zram0/backing_dev
> echo 256G > /sys/block/zram0/disksize
> mkswap /dev/zram0
> swapon /dev/zram0
> 
> kvm -nographic -smp 20 -m 131072 -cdrom winpe.iso
> 
> --
> 
> log message:
> 
> BUG: Bad page state in process qemu-system-x86  pfn:3dfab21
> page:ffffdfb137eac840 count:0 mapcount:0 mapping:0000000000000000 index:0x1
> flags: 0x17fffc000000008(uptodate)
> raw: 017fffc000000008 dead000000000100 dead000000000200 0000000000000000
> raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag set
> bad because of flags: 0x8(uptodate)
> Modules linked in: lz4 lz4_compress zram zsmalloc intel_rapl sb_edac
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel bin
> fmt_misc pcbc aesni_intel aes_x86_64 crypto_simd cryptd iTCO_wdt glue_helper
> iTCO_vendor_support intel_cstate lpc_ich mei_me intel_uncore intel_rapl_perf
> pcspkr joydev sg mfd_core ioatdma mei wmi evdev ipmi_si ipmi_devintf
> ipmi_msghandler
> acpi_power_meter acpi_pad button ip_tables x_tables autofs4 ext4
> crc32c_generic crc16 mbcache jbd2 fscrypto hid_generic usbhid hid sd_mod
> xhci_pci ehci_pci ahci libahci xhci_hcd ehci_hcd libata igb i2c_algo_bit
> crc32c_intel scsi_mod i2c_i8
> 01 dca usbcore
> CPU: 4 PID: 1039 Comm: qemu-system-x86 Tainted: G    B 4.18.0-rc5+ #1
> Hardware name: Supermicro Super Server/X10SRL-F, BIOS 2.0b 05/02/2017
> Call Trace:
>  dump_stack+0x5c/0x7b
>  bad_page+0xba/0x120
>  get_page_from_freelist+0x1016/0x1250
>  __alloc_pages_nodemask+0xfa/0x250
>  alloc_pages_vma+0x7c/0x1c0
>  do_swap_page+0x347/0x920
>  ? __update_load_avg_se.isra.38+0x1eb/0x1f0
>  ? cpumask_next_wrap+0x3d/0x60
>  __handle_mm_fault+0x7b4/0x1110
>  ? update_load_avg+0x5ea/0x720
>  handle_mm_fault+0xfc/0x1f0
>  __get_user_pages+0x12f/0x690
>  get_user_pages_unlocked+0x148/0x1f0
>  __gfn_to_pfn_memslot+0xff/0x3c0 [kvm]
>  try_async_pf+0x87/0x230 [kvm]
>  tdp_page_fault+0x132/0x290 [kvm]
>  ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
>  kvm_mmu_page_fault+0x74/0x570 [kvm]
>  ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
>  ? vmexit_fill_RSB+0x18/0x30 [kvm_intel]
>  ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
>  ? vmexit_fill_RSB+0x18/0x30 [kvm_intel]
>  ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
>  ? vmexit_fill_RSB+0x18/0x30 [kvm_intel]
>  ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
>  ? vmexit_fill_RSB+0x18/0x30 [kvm_intel]
>  ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
>  ? vmexit_fill_RSB+0x18/0x30 [kvm_intel]
>  ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
>  ? vmx_vcpu_run+0x375/0x620 [kvm_intel]
>  kvm_arch_vcpu_ioctl_run+0x9b3/0x1990 [kvm]
>  ? __update_load_avg_se.isra.38+0x1eb/0x1f0
>  ? kvm_vcpu_ioctl+0x388/0x5d0 [kvm]
>  kvm_vcpu_ioctl+0x388/0x5d0 [kvm]
>  ? __switch_to+0x395/0x450
>  ? __switch_to+0x395/0x450
>  do_vfs_ioctl+0xa2/0x630
>  ? __schedule+0x3fd/0x890
>  ksys_ioctl+0x70/0x80
>  ? exit_to_usermode_loop+0xca/0xf0
>  __x64_sys_ioctl+0x16/0x20
>  do_syscall_64+0x55/0x100
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7fb30361add7
> Code: 00 00 00 48 8b 05 c1 80 2b 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff
> ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff
> 73 01 c3 48 8b 0d 91 80 2b 00 f7 d8 64 89 01 48
> RSP: 002b:00007fb2e97f98b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007fb30361add7
> RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000015
> RBP: 00005652b984e0f0 R08: 00005652b7d513d0 R09: 0000000000000001
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fb308c66000 R14: 0000000000000000 R15: 00005652b984e0f0
> 
> --
> 
> ver_linux: Debian 9.5 with Kernel 4.18.0-rc5+
> 
> GNU C               	6.3.0
> GNU Make            	4.1
> Binutils            	2.28
> Util-linux          	2.29.2
> Mount               	2.29.2
> Module-init-tools   	23
> E2fsprogs           	1.43.4
> Linux C Library     	2.24
> Dynamic linker (ldd)	2.24
> Linux C++ Library   	6.0.22
> Procps              	3.3.12
> Kbd                 	2.0.3
> Console-tools       	2.0.3
> Sh-utils            	8.26
> Udev                	232
> 
> --
> 
> cpuinfo:
> 
> processor	: 0
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 79
> model name	: Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz
> stepping	: 1
> microcode	: 0xb000021
> cpu MHz		: 1200.632
> cache size	: 25600 KB
> physical id	: 0
> siblings	: 20
> core id		: 0
> cpu cores	: 10
> apicid		: 0
> initial apicid	: 0
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 20
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
> pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb
> rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
> nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est
> tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt
> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch
> cpuid_fault epb cat_l3 cdp_l3 invpcid_single pti intel_ppin tpr_shadow vnmi
> flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
> invpcid rtm cqm rdt_a rdseed adx smap intel_pt xsaveopt cqm_llc
> cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts
> bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
> bogomips	: 4400.00
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 46 bits physical, 48 bits virtual
> power management:
> 
> --
> Kind regards,
> 
> Tino Lehnig


