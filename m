Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0963C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C385216FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="UWlhAY+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C385216FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933649AbeGFQ71 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:59:27 -0400
Received: from mail.efficios.com ([167.114.142.138]:33492 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbeGFQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:59:24 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D33931AB328;
        Fri,  6 Jul 2018 12:59:23 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id fmeOMcw4k5HH; Fri,  6 Jul 2018 12:59:22 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 569C11AB325;
        Fri,  6 Jul 2018 12:59:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 569C11AB325
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530896362;
        bh=pMU5y+UTZNdRFkOw667vOhKs6nsoXYfT5PoasjR4oek=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=UWlhAY+fBFL3tLHSdKQxRBjVBKVeHbkkOBNfpuz9LXV/TC4Du+I7gi2VnNlVNxhlQ
         vKmh+TVuCTCqUkr9BYESjLNc7f+hp0wALUMNIMiOsx3wJbbP5hTC8b+QiBAh/sHBGu
         iqaZWt+mQIJuUPfoS1IZ/MfGw156NF+dcF6TR9kRMqlPbeFWCuXemmM86KlXBoau7f
         M5AxXZWzOWhOeIpkqXEkGP5SZvImElNsYkWBwCVTBEYt4Hoa7p3wQggQ9HDqrSYNH2
         mh6JnVTi7bEUoK/Qvs/HQF8xc5Sx5oWMNgYQADRI0hKZ9Ck+wyEicNoeKydTD5Er6y
         O1UblT+HW8rXA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id XeJrj1dBvb9m; Fri,  6 Jul 2018 12:59:22 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 372B91AB314;
        Fri,  6 Jul 2018 12:59:22 -0400 (EDT)
Date:   Fri, 6 Jul 2018 12:59:22 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@arm.linux.org.uk>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1879608911.1296.1530896362007.JavaMail.zimbra@efficios.com>
Subject: [REGRESSION] arm32 Cubietruck defconfig does not boot anymore since
 4.18-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Index: uo5KlK1JpJ6Erk/MgL1xBNhsBaEObQ==
Thread-Topic: arm32 Cubietruck defconfig does not boot anymore since 4.18-rc1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The 4.18-rc3 arm32 kernel defconfig fails to boot on my Cubietruck.
This issue appeared with 4.18-rc1.

It worked fine on 4.17.

Any ideas ?

Starting kernel ...
55.51  
55.52  [ 0.000000] Booting Linux on physical CPU 0x0
55.53  [ 0.000000] Linux version 4.18.0-rc3-00022-geca15e1-dirty (efficios@compudjdev) (gcc version 4.8.4 (Ubuntu/Linaro 4.8.4-2ubuntu1~14.04.1)) #59 SMP Fri Jul 6 11:46:22 EDT 2018
55.54  [ 0.000000] CPU: ARMv7 Processor [410fc074] revision 4 (ARMv7), cr=10c5387d
55.55  [ 0.000000] CPU: div instructions available: patching division code
55.56  [ 0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
55.57  [ 0.000000] OF: fdt: Machine model: Cubietech Cubietruck
55.58  [ 0.000000] Memory policy: Data cache writealloc
55.59  [ 0.000000] efi: Getting EFI parameters from FDT:
55.60  [ 0.000000] efi: UEFI not found.
55.61  [ 0.000000] cma: Reserved 64 MiB at 0xbb800000
55.62  [ 0.000000] On node 0 totalpages: 523520
55.63  [ 0.000000] DMA zone: 1536 pages used for memmap
55.64  [ 0.000000] DMA zone: 0 pages reserved
55.65  [ 0.000000] DMA zone: 196608 pages, LIFO batch:31
55.66  [ 0.000000] HighMem zone: 326912 pages, LIFO batch:31
55.67  [ 0.000000] psci: probing for conduit method from DT.
55.68  [ 0.000000] psci: Using PSCI v0.1 Function IDs from DT
Section 56
56.0  [ 0.000000] random: get_random_byte2018-07-06 03:51:14 PM DEBUG: expect (120): '[u'Freeing unused kernel memory', 'Freeing init memory', '-+\\[ cut here \\]-+\\s+(.*\\s+-+\\[ end trace (\\w*) \\]-+)', '(Unhandled fault.*)\r\n']'
Section 57
57.0  s called from start_kernel+0x8c/0x460 with crng_init=0
57.1  [ 0.000000] percpu: Embedded 17 pages/cpu @(ptrval) s40000 r8192 d21440 u69632
57.2  [ 0.000000] pcpu-alloc: s40000 r8192 d21440 u69632 alloc=17*4096
57.3  [ 0.000000] pcpu-alloc: [0] 0 [0] 1
57.4  [ 0.000000] Built 1 zonelists, mobility grouping on. Total pages: 521984
57.5  [ 0.000000] Kernel command line: console=ttyS0,115200 debug root=/dev/nfs rw nfsroot=172.18.0.94:/var/lib/lava/dispatcher/tmp/tmpjTsOUR/tmp06AOeO,tcp,hard,intr ip=dhcp
57.6  [ 0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
57.7  [ 0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
57.8  [ 0.000000] Memory: 1990720K/2094080K available (11264K kernel code, 1548K rwdata, 4536K rodata, 2048K init, 393K bss, 37824K reserved, 65536K cma-reserved, 1242112K highmem)
57.9  [ 0.000000] Virtual kernel memory layout:
57.10  [ 0.000000] vector : 0xffff0000 - 0xffff1000 ( 4 kB)
57.11  [ 0.000000] fixmap : 0xffc00000 - 0xfff00000 (3072 kB)
57.12  [ 0.000000] vmalloc : 0xf0800000 - 0xff800000 ( 240 MB)
57.13  [ 0.000000] lowmem : 0xc0000000 - 0xf0000000 ( 768 MB)
57.14  [ 0.000000] pkmap : 0xbfe00000 - 0xc0000000 ( 2 MB)
57.15  [ 0.000000] modules : 0xbf000000 - 0xbfe00000 ( 14 MB)
57.16  [ 0.000000] .text : 0x(ptrval) - 0x(ptrval) (12256 kB)
57.17  [ 0.000000] .init : 0x(ptrval) - 0x(ptrval) (2048 kB)
57.18  [ 0.000000] .data : 0x(ptrval) - 0x(ptrval) (1549 kB)
57.19  [ 0.000000] .bss : 0x(ptrval) - 0x(ptrval) ( 394 kB)
57.20  [ 0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
57.21  [ 0.000000] Hierarchical RCU implementation.
57.22  [ 0.000000] RCU event tracing is enabled.
57.23  [ 0.000000] RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=2.
57.24  [ 0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
57.25  [ 0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
57.26  [ 0.000000] GIC: GICv2 detected, but range too small and irqchip.gicv2_force_probe not set
57.27  [ 0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
57.28  [ 0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
57.29  [ 0.000007] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
57.30  [ 0.000019] Switching to timer-based delay loop, resolution 41ns
57.31  [ 0.002415] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
57.32  [ 0.003219] clocksource: hstimer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 12741736309 ns
57.33  [ 0.003693] Console: colour dummy device 80x30
57.34  [ 0.003740] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
57.35  [ 0.003755] pid_max: default: 32768 minimum: 301
57.36  [ 0.003912] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
57.37  [ 0.003927] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
57.38  [ 0.004584] CPU: Testing write buffer coherency: ok
57.39  [ 0.005009] /cpus/cpu@0 missing clock-frequency property
57.40  [ 0.005032] /cpus/cpu@1 missing clock-frequency property
57.41  [ 0.005045] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
57.42  [ 0.005658] Setting up static identity map for 0x40300000 - 0x403000a0
57.43  [ 0.006990] Hierarchical SRCU implementation.
57.44  [ 0.009722] EFI services will not be available.
57.45  [ 0.010056] smp: Bringing up secondary CPUs ...
57.46  [ 0.010961] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
57.47  [ 0.011115] smp: Brought up 1 node, 2 CPUs
57.48  [ 0.011135] SMP: Total of 2 processors activated (96.00 BogoMIPS).
57.49  [ 0.011143] CPU: All CPU(s) started in HYP mode.
57.50  [ 0.011148] CPU: Virtualization extensions available.
57.51  [ 0.012229] devtmpfs: initialized
57.52  [ 0.019202] VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 4
57.53  [ 0.019721] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
57.54  [ 0.019753] futex hash table entries: 512 (order: 3, 32768 bytes)
57.55  [ 0.022331] pinctrl core: initialized pinctrl subsystem
57.56  [ 0.024085] DMI not present or invalid.
57.57  [ 0.024678] NET: Registered protocol family 16
57.58  [ 0.026690] DMA: preallocated 256 KiB pool for atomic coherent allocations
57.59  [ 0.029503] cpuidle: using governor menu
57.60  [ 0.029862] No ATAGs?
57.61  [ 0.030058] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
57.62  [ 0.030074] hw-breakpoint: maximum watchpoint size is 8 bytes.
57.63  [ 0.032397] Serial: AMBA PL011 UART driver
57.64  [ 0.058842] AT91: Could not find identification node
57.65  [ 0.059040] reg-fixed-voltage ahci-5v: could not find pctldev for node /soc@01c00000/pinctrl@01c20800/ahci_pwr_pin@1, deferring probe
57.66  [ 0.059094] reg-fixed-voltage usb0-vbus: could not find pctldev for node /soc@01c00000/pinctrl@01c20800/usb0_vbus_pin@0, deferring probe
57.67  [ 0.059125] reg-fixed-voltage usb1-vbus: could not find pctldev for node /soc@01c00000/pinctrl@01c20800/usb1_vbus_pin@0, deferring probe
57.68  [ 0.059153] reg-fixed-voltage usb2-vbus: could not find pctldev for node /soc@01c00000/pinctrl@01c20800/usb2_vbus_pin@0, deferring probe
57.69  [ 0.062085] vgaarb: loaded
57.70  [ 0.062876] SCSI subsystem initialized
57.71  [ 0.063213] libata version 3.00 loaded.
57.72  [ 0.063504] usbcore: registered new interface driver usbfs
57.73  [ 0.063556] usbcore: registered new interface driver hub
57.74  [ 0.063628] usbcore: registered new device driver usb
57.75  [ 0.064829] pps_core: LinuxPPS API ver. 1 registered
57.76  [ 0.064839] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti
57.77  [ 0.064863] PTP clock support registered
57.78  [ 0.065024] EDAC MC: Ver: 3.0.0
57.79  [ 0.067783] clocksource: Switched to clocksource arch_sys_counter
57.80  [ 0.115337] simple-framebuffer bfd00000.framebuffer: framebuffer at 0xbfd00000, 0x300000 bytes, mapped to 0x(ptrval)
57.81  [ 0.115366] simple-framebuffer bfd00000.framebuffer: format=x8r8g8b8, mode=1024x768x32, linelength=4096
57.82  [ 0.129799] Console: switching to colour frame buffer device 128x48
57.83  [ 0.143417] simple-framebuffer bfd00000.framebuffer: fb0: simplefb registered!
57.84  [ 0.152129] NET: Registered protocol family 2
57.85  [ 0.152777] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes)
57.86  [ 0.152813] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
57.87  [ 0.152901] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
57.88  [ 0.153028] TCP: Hash tables configured (established 8192 bind 8192)
57.89  [ 0.153166] UDP hash table entries: 512 (order: 2, 16384 bytes)
57.90  [ 0.153241] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
57.91  [ 0.153493] NET: Registered protocol family 1
57.92  [ 0.154217] RPC: Registered named UNIX socket transport module.
57.93  [ 0.154236] RPC: Registered udp transport module.
57.94  [ 0.154242] RPC: Registered tcp transport module.
57.95  [ 0.154248] RPC: Registered tcp NFSv4.1 backchannel transport module.
57.96  [ 0.154263] PCI: CLS 0 bytes, default 64
57.97  [ 0.155218] hw perfevents: no interrupt-affinity property for /pmu, guessing.
57.98  [ 0.155549] hw perfevents: enabled with armv7_cortex_a7 PMU driver, 5 counters available
57.99  [ 0.157163] Initialise system trusted keyrings
57.100  [ 0.157492] workingset: timestamp_bits=30 max_order=19 bucket_order=0
57.101  [ 0.164391] squashfs: version 4.0 (2009/01/31) Phillip Lougher
57.102  [ 0.165265] NFS: Registering the id_resolver key type
57.103  [ 0.165321] Key type id_resolver registered
57.104  [ 0.165329] Key type id_legacy registered
57.105  [ 0.165379] ntfs: driver 2.1.32 [Flags: R/O].
57.106  [ 0.165958] pstore: using deflate compression
57.107  [ 0.167506] Key type asymmetric registered
57.108  [ 0.167527] Asymmetric key parser 'x509' registered
57.109  [ 0.167599] bounce: pool size: 64 pages
57.110  [ 0.167706] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
57.111  [ 0.167720] io scheduler noop registered
57.112  [ 0.167727] io scheduler deadline registered
57.113  [ 0.168131] io scheduler cfq registered (default)
57.114  [ 0.168145] io scheduler mq-deadline registered
57.115  [ 0.168153] io scheduler kyber registered
57.116  [ 0.170320] sun4i-usb-phy 1c13400.phy: could not find pctldev for node /soc@01c00000/pinctrl@01c20800/usb0_id_detect_pin@0, deferring probe
57.117  [ 0.178347] sun4i-pinctrl 1c20800.pinctrl: initialized sunXi PIO driver
57.118  [ 0.248549] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
57.119  [ 0.251993] console [ttyS0] disabled
57.120  [ 0.272229] 1c28000.serial: ttyS0 at MMIO 0x1c28000 (irq = 45, base_baud = 1500000) is a U6_16550A
57.121  [ 1.115595] console [ttyS0] enabled
57.122  [ 1.120700] SuperH (H)SCI(F) driver initialized
57.123  [ 1.126069] msm_serial: driver initialized
57.124  [ 1.130484] STMicroelectronics ASC driver initialized
57.125  [ 1.136326] STM32 USART driver initialized
57.126  [ 1.156389] brd: module loaded
57.127  [ 1.168613] loop: module loaded
57.128  [ 1.180418] libphy: Fixed MDIO Bus: probed
57.129  [ 1.185558] CAN device driver interface
57.130  [ 1.190348] bgmac_bcma: Broadcom 47xx GBit MAC driver loaded
57.131  [ 1.196922] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
57.132  [ 1.202779] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
57.133  [ 1.208795] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
57.134  [ 1.215749] igb: Copyright (c) 2007-2014 Intel Corporation.
57.135  [ 1.223943] sun7i-dwmac 1c50000.ethernet: PTP uses main clock
57.136  [ 1.229746] sun7i-dwmac 1c50000.ethernet: no reset control found
57.137  [ 1.235782] sun7i-dwmac 1c50000.ethernet: no regulator found
57.138  [ 1.241789] sun7i-dwmac 1c50000.ethernet: Version ID not available
57.139  [ 1.248005] sun7i-dwmac 1c50000.ethernet: DWMAC1000
57.140  [ 1.252971] sun7i-dwmac 1c50000.ethernet: DMA HW capability register supported
57.141  [ 1.260203] sun7i-dwmac 1c50000.ethernet: Normal descriptors
57.142  [ 1.265857] sun7i-dwmac 1c50000.ethernet: Ring mode enabled
57.143  [ 1.279900] libphy: stmmac: probed
57.144  [ 1.283324] RTL8211E Gigabit Ethernet stmmac-0:00: attached PHY driver [RTL8211E Gigabit Ethernet] (mii_bus:phy_addr=stmmac-0:00, irq=POLL)
57.145  [ 1.295859] RTL8211E Gigabit Ethernet stmmac-0:01: attached PHY driver [RTL8211E Gigabit Ethernet] (mii_bus:phy_addr=stmmac-0:01, irq=POLL)
57.146  [ 1.310482] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
57.147  [ 1.318025] usbcore: registered new interface driver pegasus
57.148  [ 1.323729] usbcore: registered new interface driver asix
57.149  [ 1.329197] usbcore: registered new interface driver ax88179_178a
57.150  [ 1.335316] usbcore: registered new interface driver cdc_ether
57.151  [ 1.341214] usbcore: registered new interface driver smsc75xx
57.152  [ 1.347002] usbcore: registered new interface driver smsc95xx
57.153  [ 1.352794] usbcore: registered new interface driver net1080
57.154  [ 1.358498] usbcore: registered new interface driver cdc_subset
57.155  [ 1.364442] usbcore: registered new interface driver zaurus
57.156  [ 1.370079] usbcore: registered new interface driver cdc_ncm
57.157  [ 1.377656] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
57.158  [ 1.384231] ehci-pci: EHCI PCI platform driver
57.159  [ 1.388748] ehci-platform: EHCI generic platform driver
57.160  [ 1.394574] ehci-orion: EHCI orion driver
57.161  [ 1.398856] SPEAr-ehci: EHCI SPEAr driver
57.162  [ 1.403009] ehci-st: EHCI STMicroelectronics driver
57.163  [ 1.408075] ehci-exynos: EHCI EXYNOS driver
57.164  [ 1.412402] ehci-atmel: EHCI Atmel driver
57.165  [ 1.416529] tegra-ehci: Tegra EHCI driver
57.166  [ 1.420724] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
57.167  [ 1.426935] ohci-pci: OHCI PCI platform driver
57.168  [ 1.431501] ohci-platform: OHCI generic platform driver
57.169  [ 1.437240] SPEAr-ohci: OHCI SPEAr driver
57.170  [ 1.441494] ohci-st: OHCI STMicroelectronics driver
57.171  [ 1.446529] ohci-atmel: OHCI Atmel driver
57.172  [ 1.451307] usbcore: registered new interface driver usb-storage
57.173  [ 1.462616] sunxi-rtc 1c20d00.rtc: registered as rtc0
57.174  [ 1.467678] sunxi-rtc 1c20d00.rtc: RTC enabled
57.175  [ 1.473055] i2c /dev entries driver
57.176  [ 1.478600] axp20x-i2c 0-0034: AXP20x variant AXP209 found
57.177  [ 1.492685] ldo1: supplied by regulator-dummy
57.178  [ 1.497365] ldo2: supplied by regulator-dummy
57.179  [ 1.502934] ldo3: supplied by regulator-dummy
57.180  [ 1.507986] ldo4: supplied by regulator-dummy
57.181  [ 1.512552] ldo5: supplied by regulator-dummy
57.182  [ 1.518024] dcdc2: supplied by regulator-dummy
57.183  [ 1.523126] dcdc3: supplied by regulator-dummy
57.184  [ 1.531830] axp20x-i2c 0-0034: AXP20X driver loaded
57.185  [ 1.546599] sunxi-wdt 1c20c90.watchdog: Watchdog enabled (timeout=16 sec, nowayout=0)
57.186  [ 1.561809] sdhci: Secure Digital Host Controller Interface driver
57.187  [ 1.568044] sdhci: Copyright(c) Pierre Ossman
57.188  [ 1.573971] Synopsys Designware Multimedia Card Interface Driver
57.189  [ 1.582279] sunxi-mmc 1c0f000.mmc: Got CD GPIO
57.190  [ 1.623460] sunxi-mmc 1c0f000.mmc: base:0x(ptrval) irq:27
57.191  [ 1.630478] sunxi-mmc 1c12000.mmc: allocated mmc-pwrseq
57.192  [ 1.659935] sunxi-mmc 1c12000.mmc: base:0x(ptrval) irq:28
57.193  [ 1.666162] sdhci-pltfm: SDHCI platform and OF driver helper
57.194  [ 1.676216] ledtrig-cpu: registered to indicate activity on CPUs
57.195  [ 1.683429] usbcore: registered new interface driver usbhid
57.196  [ 1.689087] usbhid: USB HID core driver
57.197  [ 1.698024] mmc0: host does not support reading read-only switch, assuming write-enable
57.198  [ 1.699632] NET: Registered protocol family 10
57.199  [ 1.711499] mmc0: new high speed SDHC card at address e624
57.200  [ 1.712111] Segment Routing with IPv6
57.201  [ 1.718568] mmcblk0: mmc0:e624 SE16G 14.8 GiB
57.202  [ 1.720916] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
57.203  [ 1.732064] NET: Registered protocol family 17
57.204  [ 1.736557] can: controller area network core (rev 20170425 abi 9)
57.205  [ 1.742894] NET: Registered protocol family 29
57.206  [ 1.747354] can: raw protocol (rev 20170425)
57.207  [ 1.751660] can: broadcast manager protocol (rev 20170425 t)
57.208  [ 1.757335] can: netlink gateway (rev 20170425) max_hops=1
57.209  [ 1.763646] Key type dns_resolver registered
57.210  [ 1.768001] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
57.211  [ 1.768226] ThumbEE CPU extension supported.
57.212  [ 1.777806] Registering SWP/SWPB emulation handler
57.213  [ 1.793943] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
57.214  [ 1.799558] Loading compiled-in X.509 certificates
57.215  [ 1.819866] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
57.216  [ 1.828118] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
57.217  [ 1.848779] random: fast init done
57.218  [ 1.892119] random: crng init done
57.219  [ 1.917828] ahci-sunxi 1c18000.sata: controller can't do PMP, turning off CAP_PMP
57.220  [ 1.925345] ahci-sunxi 1c18000.sata: SSS flag set, parallel bus scan disabled
57.221  [ 1.932535] ahci-sunxi 1c18000.sata: AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl platform mode
57.222  [ 1.941506] ahci-sunxi 1c18000.sata: flags: ncq sntf stag pm led clo only pio slum part ccc
57.223  [ 2.047845] scsi host0: ahci-sunxi
57.224  [ 2.051627] ata1: SATA max UDMA/133 mmio [mem 0x01c18000-0x01c18fff] port 0x100 irq 33
57.225  [ 2.061868] ehci-platform 1c14000.usb: EHCI Host Controller
57.226  [ 2.067490] ehci-platform 1c14000.usb: new USB bus registered, assigned bus number 1
57.227  [ 2.075796] ehci-platform 1c14000.usb: irq 30, io mem 0x01c14000
57.228  [ 2.107808] ehci-platform 1c14000.usb: USB 2.0 started, EHCI 1.00
57.229  [ 2.114793] hub 1-0:1.0: USB hub found
57.230  [ 2.118630] hub 1-0:1.0: 1 port detected
57.231  [ 2.125140] ehci-platform 1c1c000.usb: EHCI Host Controller
57.232  [ 2.130840] ehci-platform 1c1c000.usb: new USB bus registered, assigned bus number 2
57.233  [ 2.138956] ehci-platform 1c1c000.usb: irq 34, io mem 0x01c1c000
57.234  [ 2.167774] ehci-platform 1c1c000.usb: USB 2.0 started, EHCI 1.00
57.235  [ 2.174719] hub 2-0:1.0: USB hub found
57.236  [ 2.178579] hub 2-0:1.0: 1 port detected
57.237  [ 2.185074] ohci-platform 1c14400.usb: Generic Platform OHCI controller
57.238  [ 2.191793] ohci-platform 1c14400.usb: new USB bus registered, assigned bus number 3
57.239  [ 2.199906] ohci-platform 1c14400.usb: irq 31, io mem 0x01c14400
57.240  [ 2.272646] hub 3-0:1.0: USB hub found
57.241  [ 2.276451] hub 3-0:1.0: 1 port detected
57.242  [ 2.283012] ohci-platform 1c1c400.usb: Generic Platform OHCI controller
57.243  [ 2.289738] ohci-platform 1c1c400.usb: new USB bus registered, assigned bus number 4
57.244  [ 2.297733] ohci-platform 1c1c400.usb: irq 35, io mem 0x01c1c400
57.245  [ 2.372662] hub 4-0:1.0: USB hub found
57.246  [ 2.376468] hub 4-0:1.0: 1 port detected
57.247  [ 2.381691] sunxi-rtc 1c20d00.rtc: setting system clock to 1970-01-01 00:15:50 UTC (950)
57.248  [ 2.391001] RTL8211E Gigabit Ethernet stmmac-0:00: attached PHY driver [RTL8211E Gigabit Ethernet] (mii_bus:phy_addr=stmmac-0:00, irq=POLL)
57.249  [ 2.405346] sun7i-dwmac 1c50000.ethernet eth0: No Safety Features support found
57.250  [ 2.412732] sun7i-dwmac 1c50000.ethernet eth0: RX IPC Checksum Offload disabled
57.251  [ 2.420061] sun7i-dwmac 1c50000.ethernet eth0: No MAC Management Counters available
57.252  [ 2.427709] sun7i-dwmac 1c50000.ethernet eth0: PTP not supported by HW
57.253  [ 2.434710] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
57.254  [ 2.440705] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
57.255  [ 3.448574] sun7i-dwmac 1c50000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
57.256  [ 3.477800] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
57.257  [ 3.507894] Sending DHCP requests ..
57.258  [ 7.447804] ata1.00: qc timeout (cmd 0xec)
57.259  [ 7.455479] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
57.260  [ 7.789128] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
57.261  [ 9.447754] ------------[ cut here ]------------
57.262  [ 9.452386] WARNING: CPU: 1 PID: 0 at ../net/sched/sch_generic.c:461 dev_watchdog+0x26c/0x270
57.263  [ 9.460906] NETDEV WATCHDOG: eth0 (sun7i-dwmac): transmit queue 0 timed out
57.264  [ 9.467862] Modules linked in:
57.265  [ 9.470924] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.18.0-rc3-00022-geca15e1-dirty #59
57.266  [ 9.479087] Hardware name: Allwinner sun7i (A20) Family
57.267  [ 9.484331] [] (unwind_backtrace) from [] (show_stack+0x10/0x14)
57.268  [ 9.492072] [] (show_stack) from [] (dump_stack+0x94/0xa8)
57.269  [ 9.499294] [] (dump_stack) from [] (__warn+0xf8/0x110)
57.270  [ 9.506251] [] (__warn) from [] (warn_slowpath_fmt+0x38/0x48)
57.271  [ 9.513729] [] (warn_slowpath_fmt) from [] (dev_watchdog+0x26c/0x270)
57.272  [ 9.521902] [] (dev_watchdog) from [] (call_timer_fn+0x3c/0x18c)
57.273  [ 9.529639] [] (call_timer_fn) from [] (expire_timers+0xcc/0x12c)
57.274  [ 9.537461] [] (expire_timers) from [] (run_timer_softirq+0x98/0x1a8)
57.275  [ 9.545631] [] (run_timer_softirq) from [] (__do_softirq+0x12c/0x38c)
57.276  [ 9.553805] [] (__do_softirq) from [] (irq_exit+0xd8/0xfc)
57.277  [ 9.561025] [] (irq_exit) from [] (__handle_domain_irq+0x60/0xb0)
57.278  [ 9.568855] [] (__handle_domain_irq) from [] (gic_handle_irq+0x58/0x9c)
57.279  [ 9.577200] [] (gic_handle_irq) from [] (__irq_svc+0x6c/0x90)
57.280  [ 9.584671] Exception stack(0xee0ddf60 to 0xee0ddfa8)
57.281  [ 9.589721] df60: 00000000 00003654 ee0ddfb8 c031cee0 c1504cc0 c1504c74 00000002 00000000
57.282  [ 9.597889] df80: 00000000 c1457428 c1504cf4 00000000 c1537840 ee0ddfb0 c0308cbc c0308cc0
57.283  [ 9.606052] dfa0: 60000013 ffffffff
57.284  [ 9.609544] [] (__irq_svc) from [] (arch_cpu_idle+0x38/0x3c)
57.285  [ 9.616939] [] (arch_cpu_idle) from [] (do_idle+0x170/0x26c)
57.286  [ 9.624332] [] (do_idle) from [] (cpu_startup_entry+0x18/0x1c)
57.287  [ 9.631896] [] (cpu_startup_entry) from [<4030252c>] (0x4030252c)
57.288  [ 9.638860] ---[ end trace 3206bf0e819c8cee ]---
57.289  [ 9.643913] sun7i-dwmac 1c50000.ethernet eth0: Reset adapter.
Section 58
58.0  2018-07-06 03:51:23 PM INFO: Kernel exception detected, logging error
58.1  2018-07-06 03:51:23 PM DEBUG: expect (120): '[u'Freeing unused kernel memory', 'Freeing init memory', '-+\\[ cut here \\]-+\\s+(.*\\s+-+\\[ end trace (\\w*) \\]-+)', '(Unhandled fault.*)\r\n']'
Section 59
59.0  [ 11.487766] .
59.1  [ 18.407860] ata1.00: qc timeout (cmd 0xec)
59.2  [ 18.413539] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
59.3  [ 18.419651] ata1: limiting SATA link speed to 1.5 Gbps
59.4  [ 18.749122] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
59.5  [ 20.367758] .
59.6  [ 22.907747] INFO: rcu_sched self-detected stall on CPU
59.7  [ 22.914463] 0-....: (1 GPs behind) idle=c86/0/3 softirq=53/54 fqs=973
59.8  [ 22.921065] (t=2100 jiffies g=-275 c=-276 q=19)
59.9  [ 22.925771] NMI backtrace for cpu 0
59.10  [ 22.929262] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G W 4.18.0-rc3-00022-geca15e1-dirty #59
59.11  [ 22.938811] Hardware name: Allwinner sun7i (A20) Family
59.12  [ 22.944055] [] (unwind_backtrace) from [] (show_stack+0x10/0x14)
59.13  [ 22.951797] [] (show_stack) from [] (dump_stack+0x94/0xa8)
59.14  [ 22.959017] [] (dump_stack) from [] (nmi_cpu_backtrace+0x11c/0x120)
59.15  [ 22.967014] [] (nmi_cpu_backtrace) from [] (nmi_trigger_cpumask_backtrace+0xe0/0x120)
59.16  [ 22.976575] [] (nmi_trigger_cpumask_backtrace) from [] (rcu_dump_cpu_stacks+0xa8/0xd8)
59.17  [ 22.986222] [] (rcu_dump_cpu_stacks) from [] (rcu_check_callbacks+0x860/0x924)
59.18  [ 22.995174] [] (rcu_check_callbacks) from [] (update_process_times+0x30/0x5c)
59.19  [ 23.004042] [] (update_process_times) from [] (tick_sched_timer+0x4c/0x9c)
59.20  [ 23.012647] [] (tick_sched_timer) from [] (__hrtimer_run_queues+0x15c/0x2fc)
59.21  [ 23.021425] [] (__hrtimer_run_queues) from [] (hrtimer_interrupt+0x118/0x298)
59.22  [ 23.030291] [] (hrtimer_interrupt) from [] (arch_timer_handler_phys+0x28/0x30)
59.23  [ 23.039244] [] (arch_timer_handler_phys) from [] (handle_percpu_devid_irq+0x88/0x228)
59.24  [ 23.048806] [] (handle_percpu_devid_irq) from [] (generic_handle_irq+0x24/0x34)
59.25  [ 23.057846] [] (generic_handle_irq) from [] (__handle_domain_irq+0x5c/0xb0)
59.26  [ 23.066540] [] (__handle_domain_irq) from [] (gic_handle_irq+0x58/0x9c)
59.27  [ 23.074884] [] (gic_handle_irq) from [] (__irq_svc+0x6c/0x90)
59.28  [ 23.082355] Exception stack(0xc1501e38 to 0xc1501e80)
59.29  [ 23.087401] 1e20: c1503080 c144f390
59.30  [ 23.095569] 1e40: 00000000 2db71000 c1457c7c 00000000 00000082 c16779a4 ee024000 f0803000
59.31  [ 23.103738] 1e60: c1504cf4 efffcc80 00000000 c1501e88 c1457d00 c03021b0 60000113 ffffffff
59.32  [ 23.111909] [] (__irq_svc) from [] (__do_softirq+0xb0/0x38c)
59.33  [ 23.119301] [] (__do_softirq) from [] (irq_exit+0xd8/0xfc)
59.34  [ 23.126519] [] (irq_exit) from [] (__handle_domain_irq+0x60/0xb0)
59.35  [ 23.134343] [] (__handle_domain_irq) from [] (gic_handle_irq+0x58/0x9c)
59.36  [ 23.142685] [] (gic_handle_irq) from [] (__irq_svc+0x6c/0x90)
59.37  [ 23.150156] Exception stack(0xc1501f20 to 0xc1501f68)
59.38  [ 23.155203] 1f20: 00000000 00001cb8 c1501f78 c031cee0 c1504cc0 c1504c74 00000001 00000000
59.39  [ 23.163372] 1f40: 00000000 c1457428 c1504cf4 efffcc80 00000000 c1501f70 c0308cbc c0308cc0
59.40  [ 23.171535] 1f60: 60000013 ffffffff
59.41  [ 23.175026] [] (__irq_svc) from [] (arch_cpu_idle+0x38/0x3c)
59.42  [ 23.182420] [] (arch_cpu_idle) from [] (do_idle+0x170/0x26c)
59.43  [ 23.189811] [] (do_idle) from [] (cpu_startup_entry+0x18/0x1c)
59.44  [ 23.197378] [] (cpu_startup_entry) from [] (start_kernel+0x44c/0x460)
59.45  [ 23.205547] [] (start_kernel) from [<00000000>] ( (null))
59.46  [ 35.897760] .
59.47  [ 49.137790] ata1.00: qc timeout (cmd 0xec)
59.48  [ 49.143465] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
59.49  [ 49.479124] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
59.50  [ 63.057759] .
59.51  [ 85.937746] INFO: rcu_sched self-detected stall on CPU
59.52  [ 85.944461] 0-....: (1 GPs behind) idle=c86/0/3 softirq=53/54 fqs=3911
59.53  [ 85.951150] (t=8403 jiffies g=-275 c=-276 q=21)
59.54  [ 85.955851] NMI backtrace for cpu 0
59.55  [ 85.959340] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G W 4.18.0-rc3-00022-geca15e1-dirty #59
59.56  [ 85.968888] Hardware name: Allwinner sun7i (A20) Family
59.57  [ 85.974123] [] (unwind_backtrace) from [] (show_stack+0x10/0x14)
59.58  [ 85.981862] [] (show_stack) from [] (dump_stack+0x94/0xa8)
59.59  [ 85.989081] [] (dump_stack) from [] (nmi_cpu_backtrace+0x11c/0x120)
59.60  [ 85.997077] [] (nmi_cpu_backtrace) from [] (nmi_trigger_cpumask_backtrace+0xe0/0x120)
59.61  [ 86.006636] [] (nmi_trigger_cpumask_backtrace) from [] (rcu_dump_cpu_stacks+0xa8/0xd8)
59.62  [ 86.016282] [] (rcu_dump_cpu_stacks) from [] (rcu_check_callbacks+0x860/0x924)
59.63  [ 86.025233] [] (rcu_check_callbacks) from [] (update_process_times+0x30/0x5c)
59.64  [ 86.034101] [] (update_process_times) from [] (tick_sched_timer+0x4c/0x9c)
59.65  [ 86.042706] [] (tick_sched_timer) from [] (__hrtimer_run_queues+0x15c/0x2fc)
59.66  [ 86.051483] [] (__hrtimer_run_queues) from [] (hrtimer_interrupt+0x118/0x298)
59.67  [ 86.060347] [] (hrtimer_interrupt) from [] (arch_timer_handler_phys+0x28/0x30)
59.68  [ 86.069299] [] (arch_timer_handler_phys) from [] (handle_percpu_devid_irq+0x88/0x228)
59.69  [ 86.078858] [] (handle_percpu_devid_irq) from [] (generic_handle_irq+0x24/0x34)
59.70  [ 86.087898] [] (generic_handle_irq) from [] (__handle_domain_irq+0x5c/0xb0)
59.71  [ 86.096591] [] (__handle_domain_irq) from [] (gic_handle_irq+0x58/0x9c)
59.72  [ 86.104935] [] (gic_handle_irq) from [] (__irq_svc+0x6c/0x90)
59.73  [ 86.112406] Exception stack(0xc1501e38 to 0xc1501e80)
59.74  [ 86.117450] 1e20: c1503080 c144f390
59.75  [ 86.125619] 1e40: 00000000 2db71000 c1457c7c 00000000 00000082 c16779a4 ee024000 f0803000
59.76  [ 86.133786] 1e60: c1504cf4 efffcc80 00000000 c1501e88 c1457d00 c03021b0 60000113 ffffffff
59.77  [ 86.141956] [] (__irq_svc) from [] (__do_softirq+0xb0/0x38c)
59.78  [ 86.149349] [] (__do_softirq) from [] (irq_exit+0xd8/0xfc)
59.79  [ 86.156566] [] (irq_exit) from [] (__handle_domain_irq+0x60/0xb0)
59.80  [ 86.164390] [] (__handle_domain_irq) from [] (gic_handle_irq+0x58/0x9c)
59.81  [ 86.172733] [] (gic_handle_irq) from [] (__irq_svc+0x6c/0x90)
59.82  [ 86.180204] Exception stack(0xc1501f20 to 0xc1501f68)
59.83  [ 86.185253] 1f20: 00000000 00001cb8 c1501f78 c031cee0 c1504cc0 c1504c74 00000001 00000000
59.84  [ 86.193421] 1f40: 00000000 c1457428 c1504cf4 efffcc80 00000000 c1501f70 c0308cbc c0308cc0
59.85  [ 86.201586] 1f60: 60000013 ffffffff
59.86  [ 86.205077] [] (__irq_svc) from [] (arch_cpu_idle+0x38/0x3c)
59.87  [ 86.212470] [] (arch_cpu_idle) from [] (do_idle+0x170/0x26c)
59.88  [ 86.219861] [] (do_idle) from [] (cpu_startup_entry+0x18/0x1c)
59.89  [ 86.227425] [] (cpu_startup_entry) from [] (start_kernel+0x44c/0x460)
59.90  [ 86.235592] [] (start_kernel) from [<00000000>] ( (null))
59.91  [ 93.057762] timed out!

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
