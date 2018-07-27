Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F33C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5A8208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5A8208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbeG0Pme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:42:34 -0400
Received: from hermes.aosc.io ([199.195.250.187]:36657 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730631AbeG0Pme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:42:34 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 744FC9FBB1;
        Fri, 27 Jul 2018 14:20:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 27 Jul 2018 22:20:20 +0800
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3.1 10/10] arm64: dts: allwinner: a64: Enable HDMI output
 on A64 boards w/ HDMI
In-Reply-To: <CAMty3ZDZfhCjekd2eSHNFS9aagpwdG0rwL1jamuwoA=vWcd86w@mail.gmail.com>
References: <20180726171257.6688-1-icenowy@aosc.io>
 <20180726171257.6688-11-icenowy@aosc.io>
 <20180727125615.ju23ecgm6y4rz7p5@flea>
 <8DF4600E-DFE4-47CD-B541-FFDD903A65FB@aosc.io>
 <CAMty3ZDZfhCjekd2eSHNFS9aagpwdG0rwL1jamuwoA=vWcd86w@mail.gmail.com>
Message-ID: <a09cd7072c231e5ee64979ddf7256bdf@aosc.io>
X-Sender: icenowy@aosc.io
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-07-27 21:57，Jagan Teki 写道：
> On Fri, Jul 27, 2018 at 6:56 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> 
>> 
>> 于 2018年7月27日 GMT+08:00 下午8:56:15, Maxime Ripard 
>> <maxime.ripard@bootlin.com> 写到:
>>> On Fri, Jul 27, 2018 at 01:12:57AM +0800, Icenowy Zheng wrote:
>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>>>> index 1b9b92e541d2..1b972bade9f6 100644
>>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>>>> @@ -62,6 +62,21 @@
>>>>      chosen {
>>>>              stdout-path = "serial0:115200n8";
>>>>      };
>>>> +
>>>> +    connector {
>>>> +            compatible = "hdmi-connector";
>>>> +            type = "a";
>>>> +
>>>> +            port {
>>>> +                    hdmi_con_in: endpoint {
>>>> +                            remote-endpoint = <&hdmi_out_con>;
>>>> +                    };
>>>> +            };
>>>> +    };
>>>> +};
>>>> +
>>>> +&de {
>>>> +    status = "okay";
>>>>  };
>>>> 
>>>>  &ehci0 {
>>>> @@ -82,6 +97,17 @@
>>>> 
>>>>  };
>>>> 
>>>> +&hdmi {
>>>> +    hdmi-supply = <&reg_dldo1>;
>>>> +    status = "okay";
>>>> +};
>>>> +
>>>> +&hdmi_out {
>>>> +    hdmi_out_con: endpoint {
>>>> +            remote-endpoint = <&hdmi_con_in>;
>>>> +    };
>>>> +};
>>>> +
>>>>  &i2c1 {
>>>>      pinctrl-names = "default";
>>>>      pinctrl-0 = <&i2c1_pins>;
>>>> @@ -99,6 +125,10 @@
>>>>      };
>>>>  };
>>>> 
>>>> +&mixer1 {
>>>> +    status = "okay";
>>>> +};
>>>> +
>>>>  &mmc0 {
>>>>      pinctrl-names = "default";
>>>>      pinctrl-0 = <&mmc0_pins>;
>>>> @@ -238,6 +268,10 @@
>>>>      status = "disabled";
>>>>  };
>>>> 
>>>> +&tcon1 {
>>>> +    status = "okay";
>>>> +};
>>> 
>>> Is it working or not on the pine64?
>> 
>> Not tested yet, as my main A64 device is Pine A64-LTS now.
> 
> I have seen BPI-M64 seems failing.

Or could you try to use a slightly older version of linux-next?

I doubt the newest one have some severe regression that needs
to be figured.

> 
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> [    0.000000] Linux version
> 4.18.0-rc6-next-20180727-00014-gc7092bc38139 (jagan@jagan-XPS-13-9350)
> (gcc version 6.3.1 20170109 (Linaro GCC 6.3-2
> 017.02)) #1 SMP PREEMPT Fri Jul 27 19:05:15 IST 2018
> [    0.000000] Machine model: BananaPi-M64
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: UEFI not found.
> [    0.000000] cma: Reserved 32 MiB at 0x00000000bc000000
> [    0.000000] NUMA: No NUMA configuration found
> [    0.000000] NUMA: Faking a node at [mem
> 0x0000000000000000-0x00000000bdffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0xbbfd7780-0xbbfd8f3f]
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000040000000-0x00000000bdffffff]
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000040000000-0x00000000bdffffff]
> [    0.000000] Initmem setup node 0 [mem 
> 0x0000000040000000-0x00000000bdffffff]
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv0.2 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: Trusted OS migration not required
> [    0.000000] random: get_random_bytes called from
> start_kernel+0xa4/0x414 with crng_init=0
> [    0.000000] percpu: Embedded 23 pages/cpu @(____ptrval____) s56728
> r8192 d29288 u94208
> [    0.000000] Detected VIPT I-cache on CPU0
> [    0.000000] CPU features: enabling workaround for ARM erratum 843419
> [    0.000000] CPU features: enabling workaround for ARM erratum 845719
> [    0.000000] CPU features: detected: Kernel page table isolation 
> (KPTI)
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 
> 508032
> [    0.000000] Policy zone: DMA32
> [    0.000000] Kernel command line: console=ttyS0,115200 earlyprintk
> root=/dev/mmcblk0p2 rootwait
> [    0.000000] Memory: 1979032K/2064384K available (10812K kernel
> code, 1382K rwdata, 5096K rodata, 1344K init, 382K bss, 52584K
> reserved, 32768K
>  cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, 
> Nodes=1
> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=64 to 
> nr_cpu_ids=4.
> [    0.000000]  Tasks RCU enabled.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, 
> nr_cpu_ids=4
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] GIC: Using split EOI/Deactivate mode
> [    0.000000] Persistent clock returned invalid value
> [    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
> max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
> [    0.000004] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps
> every 4398046511097ns
> [    0.000491] Console: colour dummy device 80x25
> [    0.000575] Calibrating delay loop (skipped), value calculated
> using timer frequency.. 48.00 BogoMIPS (lpj=96000)
> [    0.000589] pid_max: default: 32768 minimum: 301
> [    0.000671] Security Framework initialized
> [    0.001977] Dentry cache hash table entries: 262144 (order: 9, 
> 2097152 bytes)
> [    0.002635] Inode-cache hash table entries: 131072 (order: 8, 
> 1048576 bytes)
> [    0.002684] Mount-cache hash table entries: 4096 (order: 3, 32768 
> bytes)
> [    0.002713] Mountpoint-cache hash table entries: 4096 (order: 3, 
> 32768 bytes)
> [    0.024041] ASID allocator initialised with 32768 entries
> [    0.032035] rcu: Hierarchical SRCU implementation.
> [    0.041639] EFI services will not be available.
> [    0.048073] smp: Bringing up secondary CPUs ...
> [    0.080932] Detected VIPT I-cache on CPU1
> [    0.080992] CPU1: Booted secondary processor 0x0000000001 
> [0x410fd034]
> [    0.112631] Detected VIPT I-cache on CPU2
> [    0.112667] CPU2: Booted secondary processor 0x0000000002 
> [0x410fd034]
> [    0.144707] Detected VIPT I-cache on CPU3
> [    0.144739] CPU3: Booted secondary processor 0x0000000003 
> [0x410fd034]
> [    0.144814] smp: Brought up 1 node, 4 CPUs
> [    0.144840] SMP: Total of 4 processors activated.
> [    0.144849] CPU features: detected: 32-bit EL0 Support
> [    0.154877] CPU: All CPU(s) started at EL2
> [    0.154897] alternatives: patching kernel code
> [    0.156490] devtmpfs: initialized
> [    0.161841] clocksource: jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.161905] futex hash table entries: 1024 (order: 4, 65536 bytes)
> [    0.163334] pinctrl core: initialized pinctrl subsystem
> [    0.164938] DMI not present or invalid.
> [    0.165455] NET: Registered protocol family 16
> [    0.165896] audit: initializing netlink subsys (disabled)
> [    0.166040] audit: type=2000 audit(0.160:1): state=initialized
> audit_enabled=0 res=1
> [    0.167564] cpuidle: using governor menu
> [    0.167960] vdso: 2 pages (1 code @ (____ptrval____), 1 data @
> (____ptrval____))
> [    0.167974] hw-breakpoint: found 6 breakpoint and 4 watchpoint 
> registers.
> [    0.171685] DMA: preallocated 256 KiB pool for atomic allocations
> [    0.172948] Serial: AMBA PL011 UART driver
> [    0.195691] HugeTLB registered 2.00 MiB page size, pre-allocated 0 
> pages
> [    0.196128] cryptd: max_cpu_qlen set to 1000
> [    0.196923] ACPI: Interpreter disabled.
> [    0.198046] vgaarb: loaded
> [    0.198380] SCSI subsystem initialized
> [    0.199024] usbcore: registered new interface driver usbfs
> [    0.199093] usbcore: registered new interface driver hub
> [    0.199167] usbcore: registered new device driver usb
> [    0.200125] pps_core: LinuxPPS API ver. 1 registered
> [    0.200137] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
> Rodolfo Giometti <giometti@linux.it>
> [    0.200166] PTP clock support registered
> [    0.200335] EDAC MC: Ver: 3.0.0
> [    0.201397] Advanced Linux Sound Architecture Driver Initialized.
> [    0.202248] clocksource: Switched to clocksource arch_sys_counter
> [    0.202467] VFS: Disk quotas dquot_6.6.0
> [    0.202538] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 
> bytes)
> [    0.202946] pnp: PnP ACPI: disabled
> [    0.210691] NET: Registered protocol family 2
> [    0.211403] tcp_listen_portaddr_hash hash table entries: 1024
> (order: 2, 16384 bytes)
> [    0.211468] TCP established hash table entries: 16384 (order: 5,
> 131072 bytes)
> [    0.211683] TCP bind hash table entries: 16384 (order: 6, 262144 
> bytes)
> [    0.211987] TCP: Hash tables configured (established 16384 bind 
> 16384)
> [    0.212142] UDP hash table entries: 1024 (order: 3, 32768 bytes)
> [    0.212209] UDP-Lite hash table entries: 1024 (order: 3, 32768 
> bytes)
> [    0.212390] NET: Registered protocol family 1
> [    0.212813] RPC: Registered named UNIX socket transport module.
> [    0.212821] RPC: Registered udp transport module.
> [    0.212827] RPC: Registered tcp transport module.
> [    0.212833] RPC: Registered tcp NFSv4.1 backchannel transport 
> module.
> [    0.213695] kvm [1]: 8-bit VMID
> [    0.215775] kvm [1]: vgic interrupt IRQ1
> [    0.215975] kvm [1]: Hyp mode initialized successfully
> [    0.220557] Initialise system trusted keyrings
> [    0.220710] workingset: timestamp_bits=45 max_order=19 
> bucket_order=0
> [    0.229546] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    0.230522] NFS: Registering the id_resolver key type
> [    0.230557] Key type id_resolver registered
> [    0.230564] Key type id_legacy registered
> [    0.230580] nfs4filelayout_init: NFSv4 File Layout Driver 
> Registering...
> [    0.230785] 9p: Installing v9fs 9p2000 file system support
> [    0.230909] pstore: using deflate compression
> [    0.234029] Key type asymmetric registered
> [    0.234046] Asymmetric key parser 'x509' registered
> [    0.234104] Block layer SCSI generic (bsg) driver version 0.4
> loaded (major 244)
> [    0.234115] io scheduler noop registered
> [    0.234122] io scheduler deadline registered
> [    0.234384] io scheduler cfq registered (default)
> [    0.234394] io scheduler mq-deadline registered
> [    0.234402] io scheduler kyber registered
> [    0.235702] sun50i-de2-bus 1000000.de2: DMA mask not set
> [    0.235744] sun50i-de2-bus 1000000.de2: Error couldn't map SRAM to 
> device
> [    0.236353] sun4i-usb-phy 1c19400.phy: DMA mask not set
> [    0.236428] sun4i-usb-phy 1c19400.phy: Couldn't request ID GPIO
> [    0.239670] sun50i-a64-pinctrl 1c20800.pinctrl: DMA mask not set
> [    0.241173] sun50i-a64-r-pinctrl 1f02c00.pinctrl: DMA mask not set
> [    0.242701] sun50i-a64-r-pinctrl 1f02c00.pinctrl: initialized sunXi
> PIO driver
> [    0.246771] EINJ: ACPI disabled.
> [    0.249349] sun50i-a64-ccu 1c20000.clock: DMA mask not set
> [    0.252866] sunxi-sram 1c00000.syscon: DMA mask not set
> [    0.253218] sram 18000.sram: DMA mask not set
> [    0.259221] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    0.261898] SuperH (H)SCI(F) driver initialized
> [    0.262440] msm_serial: driver initialized
> [    0.263282] sun4i-drm display-engine: DMA mask not set
> [    0.263852] sun4i-tcon 1c0c000.lcd-controller: DMA mask not set
> [    0.263952] sun4i-tcon 1c0d000.lcd-controller: DMA mask not set
> [    0.264879] sun8i-dw-hdmi 1ee0000.hdmi: DMA mask not set
> [    0.265396] cacheinfo: Unable to detect cache hierarchy for CPU 0
> [    0.273880] loop: module loaded
> [    0.279047] libphy: Fixed MDIO Bus: probed
> [    0.279631] tun: Universal TUN/TAP device driver, 1.6
> [    0.280729] thunder_xcv, ver 1.0
> [    0.280798] thunder_bgx, ver 1.0
> [    0.280852] nicpf, ver 1.0
> [    0.281358] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [    0.281367] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    0.281427] igb: Intel(R) Gigabit Ethernet Network Driver - version 
> 5.4.0-k
> [    0.281435] igb: Copyright (c) 2007-2014 Intel Corporation.
> [    0.281490] igbvf: Intel(R) Gigabit Virtual Function Network Driver
> - version 2.4.0-k
> [    0.281498] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
> [    0.281875] sky2: driver version 1.30
> [    0.282744] VFIO - User Level meta-driver version: 0.3
> [    0.284239] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) 
> Driver
> [    0.284252] ehci-pci: EHCI PCI platform driver
> [    0.284303] ehci-platform: EHCI generic platform driver
> [    0.284417] ehci-platform 1c1a000.usb: DMA mask not set
> [    0.284559] ehci-platform 1c1a000.usb: EHCI Host Controller
> [    0.284587] ehci-platform 1c1a000.usb: new USB bus registered,
> assigned bus number 1
> [    0.285256] ehci-platform 1c1a000.usb: irq 14, io mem 0x01c1a000
> [    0.298255] ehci-platform 1c1a000.usb: USB 2.0 started, EHCI 1.00
> [    0.299042] hub 1-0:1.0: USB hub found
> [    0.299079] hub 1-0:1.0: 1 port detected
> [    0.299554] ehci-platform 1c1b000.usb: DMA mask not set
> [    0.299832] ehci-orion: EHCI orion driver
> [    0.300060] ehci-exynos: EHCI EXYNOS driver
> [    0.300186] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    0.300219] ohci-pci: OHCI PCI platform driver
> [    0.300309] ohci-platform: OHCI generic platform driver
> [    0.300404] ohci-platform 1c1a400.usb: DMA mask not set
> [    0.300502] ohci-platform 1c1a400.usb: Generic Platform OHCI 
> controller
> [    0.300528] ohci-platform 1c1a400.usb: new USB bus registered,
> assigned bus number 2
> [    0.300860] ohci-platform 1c1a400.usb: irq 15, io mem 0x01c1a400
> [    0.362977] hub 2-0:1.0: USB hub found
> [    0.363017] hub 2-0:1.0: 1 port detected
> [    0.363420] ohci-platform 1c1b400.usb: DMA mask not set
> [    0.363676] ohci-exynos: OHCI EXYNOS driver
> [    0.364386] usbcore: registered new interface driver usb-storage
> [    0.364713] musb-sunxi 1c19000.usb: DMA mask not set
> [    0.367499] sun6i-rtc 1f00000.rtc: DMA mask not set
> [    0.367858] sun6i-rtc 1f00000.rtc: rtc core: registered rtc-sun6i as 
> rtc0
> [    0.367871] sun6i-rtc 1f00000.rtc: RTC enabled
> [    0.368196] i2c /dev entries driver
> [    0.372718] pwrseq_simple wifi_pwrseq: DMA mask not set
> [    0.373113] sdhci: Secure Digital Host Controller Interface driver
> [    0.373125] sdhci: Copyright(c) Pierre Ossman
> [    0.373456] Synopsys Designware Multimedia Card Interface Driver
> [    0.374617] sdhci-pltfm: SDHCI platform and OF driver helper
> [    0.375695] leds-gpio leds: DMA mask not set
> [    0.376136] ledtrig-cpu: registered to indicate activity on CPUs
> [    0.377457] usbcore: registered new interface driver usbhid
> [    0.377472] usbhid: USB HID core driver
> [    0.380972] NET: Registered protocol family 17
> [    0.381230] 9pnet: Installing 9P2000 support
> [    0.381304] Key type dns_resolver registered
> [    0.381985] registered taskstats version 1
> [    0.381994] Loading compiled-in X.509 certificates
> [    0.390508] sunxi-de2-clks 1000000.clock: DMA mask not set
> [    0.392353] sun8i-mixer 1200000.mixer: DMA mask not set
> [    0.402857] sun4i-drm display-engine: bound 1200000.mixer (ops
> sun8i_mixer_ops)
> [    0.403112] sun4i-drm display-engine: bound 1c0d000.lcd-controller
> (ops sun4i_tcon_ops)
> [    0.403172] sun8i-dw-hdmi 1ee0000.hdmi: Couldn't get regulator
> [    0.403191] sun4i-drm display-engine: failed to bind 1ee0000.hdmi
> (ops sun8i_dw_hdmi_ops): -517
> [    0.403322] sun4i-drm display-engine: Couldn't bind all pipelines 
> components
> [    0.403422] sun4i-drm display-engine: master bind failed: -517
> [    0.404396] sunxi-rsb 1f03400.rsb: DMA mask not set
> [    0.404487] sunxi-rsb 1f03400.rsb: RSB running at 3000000 Hz
> [    0.404925] axp20x-rsb sunxi-rsb-3a3: AXP20x variant AXP803 found
> [    0.407592] dcdc1: supplied by regulator-dummy
> [    0.407904] dcdc2: supplied by regulator-dummy
> [    0.408131] dcdc4: supplied by regulator-dummy
> [    0.408355] dcdc5: supplied by regulator-dummy
> [    0.408608] dcdc6: supplied by regulator-dummy
> [    0.408822] dc1sw: supplied by regulator-dummy
> [    0.409052] aldo1: supplied by regulator-dummy
> [    0.409167] afvcc-csi: Bringing 3300000uV into 2800000-2800000uV
> [    0.409380] aldo2: supplied by regulator-dummy
> [    0.409598] aldo3: supplied by regulator-dummy
> [    0.409836] dldo1: supplied by regulator-dummy
> [    0.410087] dldo2: supplied by regulator-dummy
> [    0.410160] vcc-wifi: Bringing 2900000uV into 3300000-3300000uV
> [    0.410393] dldo3: supplied by regulator-dummy
> [    0.410623] dldo4: supplied by regulator-dummy
> [    0.410884] eldo1: supplied by regulator-dummy
> [    0.411113] eldo2: supplied by regulator-dummy
> [    0.411333] eldo3: supplied by regulator-dummy
> [    0.411596] fldo1: supplied by regulator-dummy
> [    0.411835] fldo2: supplied by regulator-dummy
> [    0.412088] rtc-ldo: supplied by regulator-dummy
> [    0.412300] ldo-io0: supplied by regulator-dummy
> [    0.412561] ldo-io1: supplied by regulator-dummy
> [    0.412846] drivevbus: supplied by regulator-dummy
> [    0.413096] axp20x-rsb sunxi-rsb-3a3: AXP20X driver loaded
> [    0.413597] sun4i-usb-phy 1c19400.phy: Couldn't request ID GPIO
> [    0.419074] sun50i-a64-pinctrl 1c20800.pinctrl: initialized sunXi 
> PIO driver
> [    0.419935] dw-apb-uart 1c28000.serial: DMA mask not set
> [    0.420349] console [ttyS0] disabled
> [    0.440883] 1c28000.serial: ttyS0 at MMIO 0x1c28000 (irq = 21,
> base_baud = 1500000) is a U6_16550A
> [    1.757108] console [ttyS0] enabled
> [    1.761887] dw-apb-uart 1c28400.serial: DMA mask not set
> [    1.788099] 1c28400.serial: ttyS1 at MMIO 0x1c28400 (irq = 22,
> base_baud = 1500000) is a U6_16550A
> [    1.802439] mv64xxx_i2c 1c2b000.i2c: DMA mask not set
> [    1.809485] sunxi-mmc 1c0f000.mmc: DMA mask not set
> [    1.814529] sunxi-mmc 1c0f000.mmc: Linked as a consumer to 
> regulator.1
> [    1.821642] WARNING: CPU: 2 PID: 50 at
> ./include/linux/dma-mapping.h:516 sunxi_mmc_probe+0x1f4/0x508
> [    1.830760] Modules linked in:
> [    1.833818] CPU: 2 PID: 50 Comm: kworker/2:1 Not tainted
> 4.18.0-rc6-next-20180727-00014-gc7092bc38139 #1
> [    1.843281] Hardware name: BananaPi-M64 (DT)
> [    1.847554] Workqueue: events deferred_probe_work_func
> [    1.852689] pstate: 60000005 (nZCv daif -PAN -UAO)
> [    1.857476] pc : sunxi_mmc_probe+0x1f4/0x508
> [    1.861742] lr : sunxi_mmc_probe+0x1d4/0x508
> [    1.866004] sp : ffff00000975bb60
> [    1.869313] x29: ffff00000975bb60 x28: 0000000000000000
> [    1.874621] x27: ffff0000096abce8 x26: ffff00000917de78
> [    1.879929] x25: 0000000000000000 x24: ffff80007897fdd8
> [    1.885237] x23: ffff000009169000 x22: ffff000008b17000
> [    1.890545] x21: ffff80007897fd80 x20: ffff800079063410
> [    1.895852] x19: ffff80007897f800 x18: ffffffffffffffff
> [    1.901160] x17: 0000000000000000 x16: 0000000000000000
> [    1.906468] x15: ffff0000091696c8 x14: ffff00008975ba37
> [    1.911775] x13: ffffff0000000000 x12: 0000000000000008
> [    1.917083] x11: 0101010101010101 x10: ffffff7f7fffffff
> [    1.922390] x9 : 0000000000000000 x8 : ffff800078fe4140
> [    1.927697] x7 : ffff800078fe4140 x6 : ffff800078fe4141
> [    1.933004] x5 : ffff800078879ec0 x4 : ffff8000789b3000
> [    1.938311] x3 : ffff8000789b3100 x2 : 0000000000000000
> [    1.943618] x1 : ffff8000791327c0 x0 : 0000000000000000
> [    1.948926] Call trace:
> [    1.951373]  sunxi_mmc_probe+0x1f4/0x508
> [    1.955293]  platform_drv_probe+0x50/0xa8
> [    1.959299]  really_probe+0x1fc/0x290
> [    1.962959]  driver_probe_device+0x58/0x100
> [    1.967138]  __device_attach_driver+0x9c/0xf8
> [    1.971490]  bus_for_each_drv+0x70/0xc8
> [    1.975322]  __device_attach+0xdc/0x138
> [    1.979153]  device_initial_probe+0x10/0x18
> [    1.983331]  bus_probe_device+0x94/0xa0
> [    1.987162]  deferred_probe_work_func+0x6c/0xa0
> [    1.991690]  process_one_work+0x1c8/0x318
> [    1.995697]  worker_thread+0x234/0x428
> [    1.999443]  kthread+0xf8/0x128
> [    2.002584]  ret_from_fork+0x10/0x18
> [    2.006154] ---[ end trace 7f686a1ed4dfbded ]---
> [    2.011182] sunxi-mmc 1c0f000.mmc: swiotlb: coherent allocation
> failed, size=4096
> [    2.018674] CPU: 2 PID: 50 Comm: kworker/2:1 Tainted: G        W
>      4.18.0-rc6-next-20180727-00014-gc7092bc38139 #1
> [    2.029524] Hardware name: BananaPi-M64 (DT)
> [    2.033793] Workqueue: events deferred_probe_work_func
> [    2.038924] Call trace:
> [    2.041372]  dump_backtrace+0x0/0x150
> [    2.045031]  show_stack+0x14/0x20
> [    2.048346]  dump_stack+0x8c/0xac
> [    2.051660]  swiotlb_alloc+0x130/0x170
> [    2.055406]  __dma_alloc+0xc4/0x1b0
> [    2.058893]  sunxi_mmc_probe+0x34c/0x508
> [    2.062812]  platform_drv_probe+0x50/0xa8
> [    2.066817]  really_probe+0x1fc/0x290
> [    2.070475]  driver_probe_device+0x58/0x100
> [    2.074653]  __device_attach_driver+0x9c/0xf8
> [    2.079004]  bus_for_each_drv+0x70/0xc8
> [    2.082835]  __device_attach+0xdc/0x138
> [    2.086667]  device_initial_probe+0x10/0x18
> [    2.090844]  bus_probe_device+0x94/0xa0
> [    2.094675]  deferred_probe_work_func+0x6c/0xa0
> [    2.099202]  process_one_work+0x1c8/0x318
> [    2.103209]  worker_thread+0x234/0x428
> [    2.106954]  kthread+0xf8/0x128
> [    2.110092]  ret_from_fork+0x10/0x18
> [    2.113685] sunxi-mmc 1c0f000.mmc: Failed to allocate DMA descriptor 
> mem
> [    2.120519] sunxi-mmc 1c0f000.mmc: Dropping the link to regulator.1
> [    2.126845] sunxi-mmc: probe of 1c0f000.mmc failed with error -12
> [    2.134550] sunxi-mmc 1c10000.mmc: DMA mask not set
> [    2.139583] sunxi-mmc 1c10000.mmc: Linked as a consumer to 
> regulator.11
> [    2.146279] sunxi-mmc 1c10000.mmc: Linked as a consumer to 
> regulator.13
> [    2.153403] sunxi-mmc 1c10000.mmc: swiotlb: coherent allocation
> failed, size=4096
> [    2.160898] CPU: 2 PID: 50 Comm: kworker/2:1 Tainted: G        W
>      4.18.0-rc6-next-20180727-00014-gc7092bc38139 #1
> [    2.171749] Hardware name: BananaPi-M64 (DT)
> [    2.176026] Workqueue: events deferred_probe_work_func
> [    2.181159] Call trace:
> [    2.183608]  dump_backtrace+0x0/0x150
> [    2.187269]  show_stack+0x14/0x20
> [    2.190583]  dump_stack+0x8c/0xac
> [    2.193899]  swiotlb_alloc+0x130/0x170
> [    2.197645]  __dma_alloc+0xc4/0x1b0
> [    2.201135]  sunxi_mmc_probe+0x34c/0x508
> [    2.205056]  platform_drv_probe+0x50/0xa8
> [    2.209061]  really_probe+0x1fc/0x290
> [    2.212719]  driver_probe_device+0x58/0x100
> [    2.216897]  __device_attach_driver+0x9c/0xf8
> [    2.221249]  bus_for_each_drv+0x70/0xc8
> [    2.225081]  __device_attach+0xdc/0x138
> [    2.228912]  device_initial_probe+0x10/0x18
> [    2.233090]  bus_probe_device+0x94/0xa0
> [    2.236922]  deferred_probe_work_func+0x6c/0xa0
> [    2.241450]  process_one_work+0x1c8/0x318
> [    2.245456]  worker_thread+0x234/0x428
> [    2.249202]  kthread+0xf8/0x128
> [    2.252341]  ret_from_fork+0x10/0x18
> [    2.255939] sunxi-mmc 1c10000.mmc: Failed to allocate DMA descriptor 
> mem
> [    2.262765] sunxi-mmc 1c10000.mmc: Dropping the link to regulator.13
> [    2.269180] sunxi-mmc 1c10000.mmc: Dropping the link to regulator.11
> [    2.275574] sunxi-mmc: probe of 1c10000.mmc failed with error -12
> [    2.283233] sunxi-mmc 1c11000.mmc: DMA mask not set
> [    2.288259] sunxi-mmc 1c11000.mmc: Linked as a consumer to 
> regulator.1
> [    2.295295] sunxi-mmc 1c11000.mmc: swiotlb: coherent allocation
> failed, size=4096
> [    2.302792] CPU: 2 PID: 50 Comm: kworker/2:1 Tainted: G        W
>      4.18.0-rc6-next-20180727-00014-gc7092bc38139 #1
> [    2.313642] Hardware name: BananaPi-M64 (DT)
> [    2.317920] Workqueue: events deferred_probe_work_func
> [    2.323052] Call trace:
> [    2.325501]  dump_backtrace+0x0/0x150
> [    2.329162]  show_stack+0x14/0x20
> [    2.332476]  dump_stack+0x8c/0xac
> [    2.335790]  swiotlb_alloc+0x130/0x170
> [    2.339537]  __dma_alloc+0xc4/0x1b0
> [    2.343026]  sunxi_mmc_probe+0x34c/0x508
> [    2.346946]  platform_drv_probe+0x50/0xa8
> [    2.350951]  really_probe+0x1fc/0x290
> [    2.354610]  driver_probe_device+0x58/0x100
> [    2.358789]  __device_attach_driver+0x9c/0xf8
> [    2.363141]  bus_for_each_drv+0x70/0xc8
> [    2.366973]  __device_attach+0xdc/0x138
> [    2.370804]  device_initial_probe+0x10/0x18
> [    2.374983]  bus_probe_device+0x94/0xa0
> [    2.378815]  deferred_probe_work_func+0x6c/0xa0
> [    2.383343]  process_one_work+0x1c8/0x318
> [    2.387349]  worker_thread+0x234/0x428
> [    2.391095]  kthread+0xf8/0x128
> [    2.394235]  ret_from_fork+0x10/0x18
> [    2.397830] sunxi-mmc 1c11000.mmc: Failed to allocate DMA descriptor 
> mem
> [    2.404650] sunxi-mmc 1c11000.mmc: Dropping the link to regulator.1
> [    2.410967] sunxi-mmc: probe of 1c11000.mmc failed with error -12
> [    2.430226] sun4i-drm display-engine: bound 1200000.mixer (ops
> sun8i_mixer_ops)
> [    2.437766] sun4i-drm display-engine: bound 1c0d000.lcd-controller
> (ops sun4i_tcon_ops)
> [    2.445889] sun8i-dw-hdmi 1ee0000.hdmi: Linked as a consumer to 
> regulator.10
> [    2.453957] sun8i-dw-hdmi 1ee0000.hdmi: Detected HDMI TX controller
> v1.32a with HDCP (sun8i_dw_hdmi_phy)
> [    2.463964] sun8i-dw-hdmi 1ee0000.hdmi: registered DesignWare HDMI
> I2C bus driver
> [    2.472454] sun4i-drm display-engine: bound 1ee0000.hdmi (ops
> sun8i_dw_hdmi_ops)
> [    2.479866] [drm] Supports vblank timestamp caching Rev 2 
> (21.10.2013).
> [    2.486486] [drm] No driver support for vblank timestamp query.
> [    2.648129] random: fast init done
> [    2.699113] WARNING: CPU: 2 PID: 50 at
> ./include/linux/dma-mapping.h:516 drm_gem_cma_create+0x68/0x128
> [    2.708404] Modules linked in:
> [    2.711464] CPU: 2 PID: 50 Comm: kworker/2:1 Tainted: G        W
>      4.18.0-rc6-next-20180727-00014-gc7092bc38139 #1
> [    2.722314] Hardware name: BananaPi-M64 (DT)
> [    2.726585] Workqueue: events deferred_probe_work_func
> [    2.731720] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [    2.736505] pc : drm_gem_cma_create+0x68/0x128
> [    2.740944] lr : drm_gem_cma_create+0x40/0x128
> [    2.745380] sp : ffff00000975b870
> [    2.748689] x29: ffff00000975b870 x28: ffff800078d34c18
> [    2.753997] x27: ffff800078d34d00 x26: ffff8000789b3f00
> [    2.759304] x25: ffff80007897f800 x24: ffff800078d126f0
> [    2.764613] x23: ffff000008b17000 x22: ffff000009169000
> [    2.769920] x21: ffff800079060810 x20: ffff800078d12600
> [    2.775228] x19: 00000000004f2000 x18: ffffffffffffffff
> [    2.780536] x17: 0000000000000000 x16: 0000000000000000
> [    2.785843] x15: ffff80007897fab0 x14: 00000387000003a6
> [    2.791151] x13: 0000038400000384 x12: 0000000000000028
> [    2.796458] x11: 0101010101010101 x10: 0000000000000000
> [    2.801765] x9 : 00000000010ffff0 x8 : ffff8000789b07c0
> [    2.807073] x7 : 0000000000100000 x6 : 00000000001004f2
> [    2.812380] x5 : 0000000000000000 x4 : 0000000000000010
> [    2.817688] x3 : 0000000000000000 x2 : d1022ccae126e900
> [    2.822996] x1 : ffff8000791327c0 x0 : 0000000000000000
> [    2.828303] Call trace:
> [    2.830750]  drm_gem_cma_create+0x68/0x128
> [    2.834842]  drm_gem_cma_dumb_create+0x40/0xa8
> [    2.839283]  drm_mode_create_dumb+0x94/0xb0
> [    2.843465]  drm_client_framebuffer_create+0x90/0x1f8
> [    2.848511]  drm_fb_helper_generic_probe+0x4c/0x238
> [    2.853385]  __drm_fb_helper_initial_config_and_unlock+0x1e0/0x3a0
> [    2.859557]  drm_fb_helper_fbdev_setup+0xcc/0x1c8
> [    2.864255]  drm_fbdev_cma_init+0x9c/0xc8
> [    2.868260]  drm_fb_cma_fbdev_init+0xc/0x20
> [    2.872441]  sun4i_framebuffer_init+0x48/0x58
> [    2.876793]  sun4i_drv_bind+0x180/0x1d0
> [    2.880627]  try_to_bring_up_master+0x144/0x1a8
> [    2.885153]  component_add+0x98/0x160
> [    2.888811]  sun8i_mixer_probe+0x18/0x20
> [    2.892731]  platform_drv_probe+0x50/0xa8
> [    2.896736]  really_probe+0x1fc/0x290
> [    2.900395]  driver_probe_device+0x58/0x100
> [    2.904573]  __device_attach_driver+0x9c/0xf8
> [    2.908925]  bus_for_each_drv+0x70/0xc8
> [    2.912757]  __device_attach+0xdc/0x138
> [    2.916588]  device_initial_probe+0x10/0x18
> [    2.920766]  bus_probe_device+0x94/0xa0
> [    2.924599]  deferred_probe_work_func+0x6c/0xa0
> [    2.929128]  process_one_work+0x1c8/0x318
> [    2.933134]  worker_thread+0x234/0x428
> [    2.936880]  kthread+0xf8/0x128
> [    2.940020]  ret_from_fork+0x10/0x18
> [    2.943591] ---[ end trace 7f686a1ed4dfbdee ]---
> [    2.949730] sun4i-drm display-engine:
> [drm:drm_fb_helper_fbdev_setup] *ERROR* Failed to set fbdev
> configuration
> [    2.959846] sun4i-drm display-engine: Couldn't create our 
> framebuffer
> [    2.966492] sun4i-drm display-engine: master bind failed: -12
> [    2.972352] sun8i-mixer: probe of 1200000.mixer failed with error 
> -12
> [    2.980094] sun4i-usb-phy 1c19400.phy: Linked as a consumer to 
> regulator.22
> [    2.988807] ehci-platform 1c1b000.usb: EHCI Host Controller
> [    2.994429] ehci-platform 1c1b000.usb: new USB bus registered,
> assigned bus number 3
> [    3.002709] ehci-platform 1c1b000.usb: irq 16, io mem 0x01c1b000
> [    3.022268] ehci-platform 1c1b000.usb: USB 2.0 started, EHCI 1.00
> [    3.029045] hub 3-0:1.0: USB hub found
> [    3.032841] hub 3-0:1.0: 1 port detected
> [    3.038440] ohci-platform 1c1b400.usb: Generic Platform OHCI 
> controller
> [    3.045089] ohci-platform 1c1b400.usb: new USB bus registered,
> assigned bus number 4
> [    3.053135] ohci-platform 1c1b400.usb: irq 17, io mem 0x01c1b400
> [    3.122925] hub 4-0:1.0: USB hub found
> [    3.126713] hub 4-0:1.0: 1 port detected
> [    3.132346] usb_phy_generic usb_phy_generic.2.auto:
> usb_phy_generic.2.auto supply vcc not found, using dummy regulator
> [    3.143150] usb_phy_generic usb_phy_generic.2.auto: Linked as a
> consumer to regulator.0
> [    3.151793] musb-hdrc musb-hdrc.3.auto: MUSB HDRC host driver
> [    3.157559] musb-hdrc musb-hdrc.3.auto: new USB bus registered,
> assigned bus number 5
> [    3.166017] hub 5-0:1.0: USB hub found
> [    3.169808] hub 5-0:1.0: 1 port detected
> [    3.174817] sun6i-rtc 1f00000.rtc: setting system clock to
> 1970-01-01 00:00:09 UTC (9)
> [    3.183177] vcc-wifi-io: disabling
> [    3.186642] cpvdd: disabling
> [    3.189573] ALSA device list:
> [    3.192551]   No soundcards found.
> [    3.196433] Waiting for root device /dev/mmcblk0p2...
> [    3.374265] usb 3-1: new high-speed USB device number 2 using 
> ehci-platform
> [    3.535499] hub 3-1:1.0: USB hub found
> [    3.539377] hub 3-1:1.0: 4 ports detected
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
