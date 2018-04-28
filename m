Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759908AbeD1M3e (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 08:29:34 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33018 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759699AbeD1M3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 08:29:30 -0400
X-Google-Smtp-Source: AB8JxZqnOG/YjmViytp4Gf7z+EQr6YDAVh8uytHCjgW/FTBFD3LTu2ok3+bU/QEAblGY11dj1i5nE+FfZR/WtzvD1w4=
MIME-Version: 1.0
In-Reply-To: <CAHP4M8WDfviRofK3cz4tW-i7iuFZv+mfyADqL770cxzR0QjtWA@mail.gmail.com>
References: <CAHP4M8WDfviRofK3cz4tW-i7iuFZv+mfyADqL770cxzR0QjtWA@mail.gmail.com>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Sat, 28 Apr 2018 17:59:27 +0530
Message-ID: <CAHP4M8UrDM3HotrEkemXTxX7xJ8oORVizj8ruq+i2yEP1rus-Q@mail.gmail.com>
Subject: Re: [Cubieboard-2] Booting up stuck at runlevel-2
To: u-boot@lists.denx.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All.

Seems all is fine actually :P

I connected a ethernet-cable, and saw that 192.168.1.3 is assigned to
cubieboard-2 (but still no login-prompt on the serial-console).
However, when I sshed using debian/debian, I got into the board !!

Extremely sorry for the noise.


Thanks and Regards,
Ajay

On Sat, Apr 28, 2018 at 9:35 AM, Ajay Garg <ajaygargnsit@gmail.com> wrote:
> Hi All.
>
> After a lot of hit-and-trials, I have managed to get some bootup.
> Unfortunately, not able to get a login-prompt.
>
> Following have been done :
>
>
> == u-boot ==
>
> u-boot has been compiled using bleeding-edge mainline
> (ec5c4a8fd64a178a4d159917cda0aa176e5a9be5), via :
>
> * make Cubieboard2_defconfig
> * make ARCH=arm CROSS_COMPILE=/home/ajay/arm-toolchain-6.2/arm-linux-gnueabihf-
>
> This gives us u-boot-sunxi-with-spl.bin
>
>
> == kernel ==
>
> kernel also has been compiled using bleeding-edge mainline
> (6d08b06e67cd117f6992c46611dfb4ce267cd71e) via :
>
> * make clean
> * make ARCH=arm sunxi_defconfig
> * make -j$(nproc) ARCH=arm
> CROSS_COMPILE=arm-toolchain-6.2/arm-linux-gnueabihf- zImage
> * make -j$(nproc) ARCH=arm
> CROSS_COMPILE=arm-toolchain-6.2/arm-linux-gnueabihf-
> sun7i-a20-cubieboard2.dtb
>
> This gives us zImage and sun7i-a20-cubieboard2.dtb.
>
>
> == integration, and starting up ==
>
> Followed the steps as per
> https://github.com/maronai/cubieboard/wiki/3.1.-Compiling-mainline-kernel-for-CubieBoard2-and-CubieTruck,
> but with following differences :
>
> a)
> Used u-boot-sunxi-with-spl.bin, zImage, sun7i-a20-cubieboard2.dtb from
> above steps.
>
> b)
> Used (and compiled to boot.scr) the following boot.cmd :
>
> fatload mmc 0 0x46000000 zImage
> fatload mmc 0 0x49000000 sun7i-a20-cubieboard2.dtb
> setenv bootargs console=ttyS0,115200 rw root=/dev/mmcblk0p2
> bootz 0x46000000 - 0x49000000
>
> c)
> Extracted debian-wheezy-7.5-armhf.com-20140603.tar to the rootfs
> partition on the sd-card.
>
> d)
> Finally, inserted the sdcard in cubieboard2, and upon bootup,
> following is seen :
>
> ########################################################################
> U-Boot SPL 2018.05-rc2-00118-gec5c4a8 (Apr 28 2018 - 08:40:48 +0530)
> DRAM: 1024 MiB
> CPU: 912000000Hz, AXI/AHB/APB: 3/2/2
> Trying to boot from MMC1
>
>
> U-Boot 2018.05-rc2-00118-gec5c4a8 (Apr 28 2018 - 08:40:48 +0530)
> Allwinner Technology
>
> CPU:   Allwinner A20 (SUN7I)
> Model: Cubietech Cubieboard2
> I2C:   ready
> DRAM:  1 GiB
> MMC:   SUNXI SD/MMC: 0
> Loading Environment from FAT... *** Warning - bad CRC, using default environment
>
> Failed (-5)
> In:    serial
> Out:   serial
> Err:   serial
> SCSI:  SATA link 0 timeout.
> AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
> flags: ncq stag pm led clo only pmp pio slum part ccc apst
> Net:   eth0: ethernet@01c50000
> starting USB...
> USB0:   USB EHCI 1.00
> USB1:   USB OHCI 1.0
> USB2:   USB EHCI 1.00
> USB3:   USB OHCI 1.0
> scanning bus 0 for devices... 1 USB Device(s) found
> scanning bus 2 for devices... 1 USB Device(s) found
>        scanning usb for storage devices... 0 Storage Device(s) found
> Hit any key to stop autoboot:  0
> switch to partitions #0, OK
> mmc0 is current device
> Scanning mmc 0:1...
> Found U-Boot script /boot.scr
> 245 bytes read in 13 ms (17.6 KiB/s)
> ## Executing script at 43100000
> 3961944 bytes read in 241 ms (15.7 MiB/s)
> 26147 bytes read in 23 ms (1.1 MiB/s)
> ## Flattened Device Tree blob at 49000000
>    Booting using the fdt blob at 0x49000000
>    Loading Device Tree to 49ff6000, end 49fff622 ... OK
>
> Starting kernel ...
>
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.17.0-rc2 (ajay@latitude-3480) (gcc
> version 6.2.1 20161016 (Linaro GCC 6.2-2016.11)) #6 SMP Sat Apr 28
> 08:36:46 8
> [    0.000000] CPU: ARMv7 Processor [410fc074] revision 4 (ARMv7), cr=10c5387d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> instruction cache
> [    0.000000] OF: fdt: Machine model: Cubietech Cubieboard2
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] cma: Reserved 16 MiB at 0x7f000000
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: Using PSCI v0.1 Function IDs from DT
> [    0.000000] random: get_random_bytes called from
> start_kernel+0xa0/0x3fc with crng_init=0
> [    0.000000] percpu: Embedded 16 pages/cpu @(ptrval) s33804 r8192
> d23540 u65536
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 260608
> [    0.000000] Kernel command line: console=ttyS0,115200 rw root=/dev/mmcblk0p2
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    0.000000] Memory: 1013080K/1048576K available (6144K kernel code,
> 420K rwdata, 1492K rodata, 1024K init, 241K bss, 19112K reserved,
> 16384)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> [    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> [    0.000000]       .text : 0x(ptrval) - 0x(ptrval)   (7136 kB)
> [    0.000000]       .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
> [    0.000000]       .data : 0x(ptrval) - 0x(ptrval)   ( 421 kB)
> [    0.000000]        .bss : 0x(ptrval) - 0x(ptrval)   ( 242 kB)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
> [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> [    0.000000] GIC: Using split EOI/Deactivate mode
> [    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
> max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
> [    0.000008] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps
> every 4398046511097ns
> [    0.000022] Switching to timer-based delay loop, resolution 41ns
> [    0.000324] clocksource: timer: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 79635851949 ns
> [    0.000554] clocksource: hstimer: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 6370868154 ns
> [    0.000795] Console: colour dummy device 80x30
> [    0.000841] Calibrating delay loop (skipped), value calculated
> using timer frequency.. 48.00 BogoMIPS (lpj=240000)
> [    0.000857] pid_max: default: 32768 minimum: 301
> [    0.001024] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.001041] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.001671] CPU: Testing write buffer coherency: ok
> [    0.002053] /cpus/cpu@0 missing clock-frequency property
> [    0.002074] /cpus/cpu@1 missing clock-frequency property
> [    0.002088] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.002564] Setting up static identity map for 0x40100000 - 0x40100060
> [    0.002722] Hierarchical SRCU implementation.
> [    0.003499] smp: Bringing up secondary CPUs ...
> [    0.014215] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.014349] smp: Brought up 1 node, 2 CPUs
> [    0.014369] SMP: Total of 2 processors activated (96.00 BogoMIPS).
> [    0.014376] CPU: All CPU(s) started in HYP mode.
> [    0.014382] CPU: Virtualization extensions available.
> [    0.015317] devtmpfs: initialized
> [    0.021344] Built 1 zonelists, mobility grouping on.  Total pages: 257366
> [    0.021978] VFP support v0.3: implementor 41 architecture 2 part 30
> variant 7 rev 4
> [    0.022270] clocksource: jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 19112604462750000 ns
> [    0.022295] futex hash table entries: 512 (order: 3, 32768 bytes)
> [    0.022532] pinctrl core: initialized pinctrl subsystem
> [    0.023442] NET: Registered protocol family 16
> [    0.024483] DMA: preallocated 256 KiB pool for atomic coherent allocations
> [    0.025539] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4
> watchpoint registers.
> [    0.025554] hw-breakpoint: maximum watchpoint size is 8 bytes.
> [    0.040622] SCSI subsystem initialized
> [    0.041126] usbcore: registered new interface driver usbfs
> [    0.041185] usbcore: registered new interface driver hub
> [    0.041248] usbcore: registered new device driver usb
> [    0.041486] pps_core: LinuxPPS API ver. 1 registered
> [    0.041496] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
> Rodolfo Giometti <giometti@linux.it>
> [    0.041518] PTP clock support registered
> [    0.041768] Advanced Linux Sound Architecture Driver Initialized.
> [    0.042604] clocksource: Switched to clocksource arch_sys_counter
> [    0.050738] NET: Registered protocol family 2
> [    0.051296] tcp_listen_portaddr_hash hash table entries: 512
> (order: 0, 6144 bytes)
> [    0.051330] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
> [    0.051426] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
> [    0.051554] TCP: Hash tables configured (established 8192 bind 8192)
> [    0.051681] UDP hash table entries: 512 (order: 2, 16384 bytes)
> [    0.051746] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
> [    0.051976] NET: Registered protocol family 1
> [    0.052700] RPC: Registered named UNIX socket transport module.
> [    0.052720] RPC: Registered udp transport module.
> [    0.052728] RPC: Registered tcp transport module.
> [    0.052734] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.053288] hw perfevents: no interrupt-affinity property for /pmu, guessing.
> [    0.053555] hw perfevents: enabled with armv7_cortex_a7 PMU driver,
> 5 counters available
> [    0.055102] workingset: timestamp_bits=30 max_order=18 bucket_order=0
> [    0.061853] NFS: Registering the id_resolver key type
> [    0.061899] Key type id_resolver registered
> [    0.061907] Key type id_legacy registered
> [    0.063047] bounce: pool size: 64 pages
> [    0.063160] Block layer SCSI generic (bsg) driver version 0.4
> loaded (major 248)
> [    0.063174] io scheduler noop registered
> [    0.063181] io scheduler deadline registered
> [    0.063458] io scheduler cfq registered (default)
> [    0.063471] io scheduler mq-deadline registered
> [    0.063479] io scheduler kyber registered
> [    0.064221] sun4i-usb-phy 1c13400.phy: could not find pctldev for
> node /soc@1c00000/pinctrl@1c20800/usb0_id_detect_pin@0, deferring
> probe
> [    0.067511] sun4i-pinctrl 1c20800.pinctrl: initialized sunXi PIO driver
> [    0.122575] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
> [    0.125140] console [ttyS0] disabled
> [    0.145316] 1c28000.serial: ttyS0 at MMIO 0x1c28000 (irq = 47,
> base_baud = 1500000) is a U6_16550A
> [    0.795509] console [ttyS0] enabled
> [    0.802488] sun4i-backend 1e60000.display-backend: Couldn't find
> matching frontend, frontend features disabled
> [    0.812916] sun4i-drm display-engine: bound 1e60000.display-backend
> (ops 0xc0748254)
> [    0.820673] sun4i-backend 1e40000.display-backend: Couldn't find
> matching frontend, frontend features disabled
> [    0.830936] sun4i-drm display-engine: bound 1e40000.display-backend
> (ops 0xc0748254)
> [    0.839075] sun4i-drm display-engine: No panel or bridge found...
> RGB output disabled
> [    0.846971] sun4i-drm display-engine: bound 1c0c000.lcd-controller
> (ops 0xc07471e4)
> [    0.854980] sun4i-drm display-engine: No panel or bridge found...
> RGB output disabled
> [    0.862849] sun4i-drm display-engine: bound 1c0d000.lcd-controller
> (ops 0xc07471e4)
> [    0.870880] sun4i-drm display-engine: bound 1c16000.hdmi (ops 0xc0748c58)
> [    0.877704] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    0.884326] [drm] No driver support for vblank timestamp query.
> [    1.390292] [drm] Cannot find any crtc or sizes
> [    1.395595] [drm] Initialized sun4i-drm 1.0.0 20150629 for
> display-engine on minor 0
> [    1.405129] libphy: Fixed MDIO Bus: probed
> [    1.409237] CAN device driver interface
> [    1.413747] sun7i-dwmac 1c50000.ethernet: PTP uses main clock
> [    1.419497] sun7i-dwmac 1c50000.ethernet: no reset control found
> [    1.425552] sun7i-dwmac 1c50000.ethernet: no regulator found
> [    1.431485] sun7i-dwmac 1c50000.ethernet: Ring mode enabled
> [    1.437091] sun7i-dwmac 1c50000.ethernet: DMA HW capability
> register supported
> [    1.444327] sun7i-dwmac 1c50000.ethernet: Normal descriptors
> [    1.457654] libphy: stmmac: probed
> [    1.461071] mdio_bus stmmac-0:01: attached PHY driver [unbound]
> (mii_bus:phy_addr=stmmac-0:01, irq=POLL)
> [    1.471589] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    1.478156] ehci-platform: EHCI generic platform driver
> [    1.483841] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    1.490052] ohci-platform: OHCI generic platform driver
> [    1.497244] sunxi-rtc 1c20d00.rtc: rtc core: registered rtc-sunxi as rtc0
> [    1.504095] sunxi-rtc 1c20d00.rtc: RTC enabled
> [    1.508664] i2c /dev entries driver
> [    1.513274] axp20x-i2c 1-0034: AXP20x variant AXP209 found
> [    1.533697] input: axp20x-pek as
> /devices/platform/soc@1c00000/1c2ac00.i2c/i2c-1/1-0034/axp20x-pek/input/input0
> [    1.544767] ldo1: supplied by regulator-dummy
> [    1.549413] ldo2: supplied by regulator-dummy
> [    1.554885] ldo3: supplied by regulator-dummy
> [    1.559910] ldo4: supplied by regulator-dummy
> [    1.564482] ldo5: supplied by regulator-dummy
> [    1.569888] dcdc2: supplied by regulator-dummy
> [    1.575030] dcdc3: supplied by regulator-dummy
> [    1.580973] axp20x-i2c 1-0034: AXP20X driver loaded
> [    1.587267] Registered IR keymap rc-empty
> [    1.591373] rc rc0: sunxi-ir as
> /devices/platform/soc@1c00000/1c21800.ir/rc/rc0
> [    1.598869] input: sunxi-ir as
> /devices/platform/soc@1c00000/1c21800.ir/rc/rc0/input1
> [    1.607130] sunxi-ir 1c21800.ir: initialized sunXi IR driver
> [    1.614018] sunxi-wdt 1c20c90.watchdog: Watchdog enabled
> (timeout=16 sec, nowayout=0)
> [    1.625599] sunxi-mmc 1c0f000.mmc: Got CD GPIO
> [    1.655420] sunxi-mmc 1c0f000.mmc: base:0x(ptrval) irq:29
> [    1.661940] sun4i-ss 1c15000.crypto-engine: Die ID 0
> [    1.668712] usbcore: registered new interface driver usbhid
> [    1.674381] usbhid: USB HID core driver
> [    1.682163] sun4i-codec 1c22c00.codec: ASoC: Failed to create
> component debugfs directory
> [    1.691722] sun4i-codec 1c22c00.codec: Codec <-> 1c22c00.codec mapping ok
> [    1.699891] NET: Registered protocol family 17
> [    1.704479] can: controller area network core (rev 20170425 abi 9)
> [    1.710750] NET: Registered protocol family 29
> [    1.715224] can: raw protocol (rev 20170425)
> [    1.719491] can: broadcast manager protocol (rev 20170425 t)
> [    1.725170] can: netlink gateway (rev 20170425) max_hops=1
> [    1.730883] Key type dns_resolver registered
> [    1.735258] Registering SWP/SWPB emulation handler
> [    1.742667] random: fast init done
> [    1.787163] mmc0: host does not support reading read-only switch,
> assuming write-enable
> [    1.801363] mmc0: new high speed SDHC card at address aaaa
> [    1.807932] mmcblk0: mmc0:aaaa SS16G 14.8 GiB
> [    1.818342]  mmcblk0: p1 p2
> [    1.842670] ahci-sunxi 1c18000.sata: controller can't do PMP,
> turning off CAP_PMP
> [    1.850191] ahci-sunxi 1c18000.sata: SSS flag set, parallel bus scan disabled
> [    1.857372] ahci-sunxi 1c18000.sata: AHCI 0001.0100 32 slots 1
> ports 3 Gbps 0x1 impl platform mode
> [    1.866339] ahci-sunxi 1c18000.sata: flags: ncq sntf stag pm led
> clo only pio slum part ccc
> [    1.875763] scsi host0: ahci-sunxi
> [    1.879516] ata1: SATA max UDMA/133 mmio [mem
> 0x01c18000-0x01c18fff] port 0x100 irq 35
> [    1.888028] ehci-platform 1c14000.usb: EHCI Host Controller
> [    1.893695] ehci-platform 1c14000.usb: new USB bus registered,
> assigned bus number 1
> [    1.901732] ehci-platform 1c14000.usb: irq 31, io mem 0x01c14000
> [    1.932626] ehci-platform 1c14000.usb: USB 2.0 started, EHCI 1.00
> [    1.939526] hub 1-0:1.0: USB hub found
> [    1.943392] hub 1-0:1.0: 1 port detected
> [    1.948109] ehci-platform 1c1c000.usb: EHCI Host Controller
> [    1.953769] ehci-platform 1c1c000.usb: new USB bus registered,
> assigned bus number 2
> [    1.961773] ehci-platform 1c1c000.usb: irq 36, io mem 0x01c1c000
> [    1.992607] ehci-platform 1c1c000.usb: USB 2.0 started, EHCI 1.00
> [    1.999466] hub 2-0:1.0: USB hub found
> [    2.003320] hub 2-0:1.0: 1 port detected
> [    2.008032] ohci-platform 1c14400.usb: Generic Platform OHCI controller
> [    2.014736] ohci-platform 1c14400.usb: new USB bus registered,
> assigned bus number 3
> [    2.022734] ohci-platform 1c14400.usb: irq 32, io mem 0x01c14400
> [    2.097376] hub 3-0:1.0: USB hub found
> [    2.101171] hub 3-0:1.0: 1 port detected
> [    2.105923] ohci-platform 1c1c400.usb: Generic Platform OHCI controller
> [    2.112562] ohci-platform 1c1c400.usb: new USB bus registered,
> assigned bus number 4
> [    2.120574] ohci-platform 1c1c400.usb: irq 37, io mem 0x01c1c400
> [    2.197364] hub 4-0:1.0: USB hub found
> [    2.201175] hub 4-0:1.0: 1 port detected
> [    2.205997] usb_phy_generic usb_phy_generic.0.auto:
> usb_phy_generic.0.auto supply vcc not found, using dummy regulator
> [    2.214160] ata1: SATA link down (SStatus 0 SControl 300)
> [    2.217246] musb-hdrc musb-hdrc.1.auto: MUSB HDRC host driver
> [    2.227882] musb-hdrc musb-hdrc.1.auto: new USB bus registered,
> assigned bus number 5
> [    2.236567] hub 5-0:1.0: USB hub found
> [    2.240366] hub 5-0:1.0: 1 port detected
> [    2.254183] vcc3v0: disabling
> [    2.257167] vcc5v0: disabling
> [    2.260149] ALSA device list:
> [    2.263178]   #0: sun4i-codec
> [    2.412833] EXT4-fs (mmcblk0p2): recovery complete
> [    3.412764] [drm] Cannot find any crtc or sizes
> [    3.417412] EXT4-fs (mmcblk0p2): mounted filesystem with ordered
> data mode. Opts: (null)
> [    3.425585] VFS: Mounted root (ext4 filesystem) on device 179:2.
> [    3.437152] devtmpfs: mounted
> [    3.441283] Freeing unused kernel memory: 1024K
> INIT: version 2.88 booting
> [info] Using makefile-style concurrent boot in runlevel S.
> [....] Starting the hotplug events dispatcher: udevd[    4.249237]
> udevd[182]: starting version 175
> . ok
> [....] Synthesizing the initial hotplug events...done.
> [....] Waiting for /dev to be fully populated...done.
> [....] Setting preliminary keymap...done.
> [....] Activating swap...done.
> [    6.741080] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
> [....] Cleaning up temporary files... /tmp. ok
> [....] Activating lvm and md swap...done.
> [....] Checking file systems...fsck from util-linux 2.20.1
> done.
> [....] Mounting local filesystems...done.
> [....] Activating swapfile swap...done.
> [....] Cleaning up temporary files.... ok
> [....] Setting kernel variables ...done.
> [....] Setting up resolvconf.../etc/resolvconf/update.d/libc: Warning:
> /etc/resolv.conf is not a symbolic link to
> /etc/resolvconf/run/resolv.cf
> done.
> [   10.051248] random: dd: uninitialized urandom read (512 bytes read)
> [....] Configuring network interfaces...Internet Systems Consortium
> DHCP Client 4.2.2
> Copyright 2004-2011 Internet Systems Consortium.
> All rights reserved.
> For info, please visit https://www.isc.org/software/dhcp/
>
> [   10.497147] Generic PHY stmmac-0:01: attached PHY driver [Generic
> PHY] (mii_bus:phy_addr=stmmac-0:01, irq=POLL)
> [   10.520577] sun7i-dwmac 1c50000.ethernet eth0: RX IPC Checksum
> Offload disabled
> [   10.527939] sun7i-dwmac 1c50000.ethernet eth0: No MAC Management
> Counters available
> [   10.535613] sun7i-dwmac 1c50000.ethernet eth0: PTP not supported by HW
> Listening on LPF/eth0/02:0f:06:c3:45:7c
> Sending on   LPF/eth0/02:0f:06:c3:45:7c
> Sending on   Socket/fallback
> DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 4
> DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 8
> DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 12
> [   26.229107] random: crng init done
> DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 15
> DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 11
> DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 11
> No DHCPOFFERS received.
> No working leases in persistent database - sleeping.
> done.
> [....] Cleaning up temporary files.... ok
> [info] Setting console screen modes.
> setterm: cannot (un)set powersave mode: Inappropriate ioctl for device
> [info] Skipping font and keymap setup (handled by console-setup).
> [....] Setting up console font and keymap...done.
> INIT: Entering runlevel: 2
> [info] Using makefile-style concurrent boot in runlevel 2.
> [....] Starting enhanced syslogd: rsyslogd. ok
> [....] Starting periodic command scheduler: cron. ok
> [....] Starting system message bus: dbus. ok
> [....] Starting OpenBSD Secure Shell server: sshd. ok
> ########################################################################
>
>
>
> The above bootup process is same/deterministic (no random behaviours).
> Please note that there is no ethernet/hdmi cables attached.
>
>
> So, at which layer (uboot/kernel/rootfs) is the issue? (I believe
> uboot is fine here, still would be grateful for a confirmation).
>
>
> Thanks and Regards,
> Ajay
