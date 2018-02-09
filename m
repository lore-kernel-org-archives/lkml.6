Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751142AbeBIKs6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 05:48:58 -0500
Received: from tartarus.angband.pl ([89.206.35.136]:60662 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbeBIKsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 05:48:52 -0500
Date: Fri, 9 Feb 2018 11:48:06 +0100
From: Adam Borowski <kilobyte@angband.pl>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 0/4] ARM/arm64: exynos: Fix missing missing reg
 warning for syscon restart nodes
Message-ID: <20180209104806.vcrrtpq6izcnwvy2@angband.pl>
References: <CGME20180130211855epcas1p25cce42a195d8b407f4267309f9b5ccb9@epcas1p2.samsung.com>
 <20180130211819.17139-1-krzk@kernel.org>
 <4642d2d0-61c9-33b6-0289-76f487aa45ab@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="s6ppryxxukinibnu"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4642d2d0-61c9-33b6-0289-76f487aa45ab@samsung.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s6ppryxxukinibnu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Feb 08, 2018 at 02:46:32PM +0100, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 2018-01-30 22:18, Krzysztof Kozlowski wrote:
> > Hi,
> > 
> > Changes since v1:
> > 1. New patch (1/4) calling devm_of_platform_populate() in PMU driver,
> >     following Rob's advice.
> > 2. The DTS patches moving reboot/poweroff nodes (3/4 and 4/4) now depend
> >     on this.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Tested following boards and reboot works fine:
> Exynos3250 (artik5-eval)
> Exynos4412 (trats2)
> Exynos5410 (odroid xu)
> Exynos5422 (odroid xu3/xu4)
> Exynos5433 (tm2)

Doesn't seem to work on mine:
Exynos4412 (odroid u2)

Rebooting worked correctly with 3.8 + gazillion non-mainlined patches (as
shipped with providen images), never did with mainline.

Tested on current mid-of-the-merge-window, plus these four patches.


It's possible that I'm doing something wrong; might need an updated u-boot,
etc.  Log of a boot-till-reboot+hang session attached.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢰⠒⠀⣿⡁ Imagine there are bandits in your house, your kid is bleeding out,
⢿⡄⠘⠷⠚⠋⠀ the house is on fire, and seven big-ass trumpets are playing in the
⠈⠳⣄⠀⠀⠀⠀ sky.  Your cat demands food.  The priority should be obvious...

--s6ppryxxukinibnu
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="kholdan.log"
Content-Transfer-Encoding: 8bit

U-Boot 2016.11+dfsg1-3 (Dec 22 2016 - 04:44:44 +0000)

CPU:   Exynos4412 @ 1 GHz
Model: Odroid based on Exynos4412
Board: Odroid based on Exynos4412
Type:  u3
DRAM:  2 GiB
LDO20@VDDQ_EMMC_1.8V: set 1800000 uV; enabling
LDO22@VDDQ_EMMC_2.8V: set 2800000 uV; enabling
LDO21@TFLASH_2.8V: set 2800000 uV; enabling
MMC:   EXYNOS DWMMC: 0
*** Warning - bad CRC, using default environment

Net:   No ethernet found.
Hit any key to stop autoboot:  2 ^H^H^H 1 ^H^H^H 0 
MMC Device 1 not found
no mmc device at slot 1
switch to partitions #0, OK
mmc0(part 0) is current device
Scanning mmc 0:1...
Found /extlinux/extlinux.conf
Retrieving file: /extlinux/extlinux.conf
2303 bytes read in 9 ms (249 KiB/s)
U-Boot menu
1:	Debian GNU/Linux kernel 4.15.0-12182-g6de178c233be
2:	Debian GNU/Linux kernel 4.15.0-12182-g6de178c233be (rescue target)
3:	Debian GNU/Linux kernel 4.15.0-10690-gec9e48cd93be
4:	Debian GNU/Linux kernel 4.15.0-10690-gec9e48cd93be (rescue target)
5:	Debian GNU/Linux kernel 4.15.0-00027-g38a981d152b8
6:	Debian GNU/Linux kernel 4.15.0-00027-g38a981d152b8 (rescue target)
7:	Debian GNU/Linux kernel 4.14.0-00115-g3d7c587c4c1b
8:	Debian GNU/Linux kernel 4.14.0-00115-g3d7c587c4c1b (rescue target)
Enter choice: 1:	Debian GNU/Linux kernel 4.15.0-12182-g6de178c233be
Retrieving file: /initrd.img-4.15.0-12182-g6de178c233be
5766183 bytes read in 237 ms (23.2 MiB/s)
Retrieving file: /vmlinuz-4.15.0-12182-g6de178c233be
5680536 bytes read in 224 ms (24.2 MiB/s)
append: root=LABEL=ereshkigal 
Retrieving file: /dtbs/4.15.0-12182-g6de178c233be/exynos4412-odroidu3.dtb
53406 bytes read in 41 ms (1.2 MiB/s)
Kernel image @ 0x42000000 [ 0x000000 - 0x56ad98 ]
## Flattened Device Tree blob at 43000000
   Booting using the fdt blob at 0x43000000
   Loading Ramdisk to 4fa80000, end 4ffffc27 ... OK
   Loading Device Tree to 4fa6f000, end 4fa7f09d ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0xa00
[    0.000000] Linux version 4.15.0-12182-g6de178c233be (kilobyte@kholdan) (gcc version 7.3.0 (Debian 7.3.0-3)) #1 SMP PREEMPT Fri Feb 9 04:03:33 CET 2018
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: Hardkernel ODROID-U3 board based on Exynos4412
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Reserved memory: created DMA memory pool at 0xbf700000, size 8 MiB
[    0.000000] OF: reserved mem: initialized node region_mfc_right, compatible id shared-dma-pool
[    0.000000] Reserved memory: created DMA memory pool at 0xbd300000, size 36 MiB
[    0.000000] OF: reserved mem: initialized node region_mfc_left, compatible id shared-dma-pool
[    0.000000] cma: Reserved 64 MiB at 0xb9000000
[    0.000000] Samsung CPU ID: 0xe4412220
[    0.000000] Running under secure firmware.
[    0.000000] percpu: Embedded 16 pages/cpu @(ptrval) s35800 r8192 d21544 u65536
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 511040
[    0.000000] Kernel command line: root=LABEL=ereshkigal 
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1947660K/2051072K available (8192K kernel code, 321K rwdata, 2536K rodata, 1024K init, 313K bss, 37876K reserved, 65536K cma-reserved, 1199104K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0x(ptrval) - 0x(ptrval)   (9184 kB)
[    0.000000]       .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
[    0.000000]       .data : 0x(ptrval) - 0x(ptrval)   ( 322 kB)
[    0.000000]        .bss : 0x(ptrval) - 0x(ptrval)   ( 314 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] L2C: platform modifies aux control register: 0x02070000 -> 0x3e470001
[    0.000000] L2C: platform provided aux values permit register corruption.
[    0.000000] L2C: DT/platform modifies aux control register: 0x02070000 -> 0x3e470001
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310: enabling full line of zeros but not enabled in Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 8 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x4100c4c8, AUX_CTRL 0x7e470001
[    0.000000] Exynos4x12 clocks: sclk_apll = 1000000000, sclk_mpll = 800000000
[    0.000000] 	sclk_epll = 96000000, sclk_vpll = 350000000, arm_clk = 1000000000
[    0.000000] Switching to timer-based delay loop, resolution 41ns
[    0.000000] clocksource: mct-frc: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
[    0.000004] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
[    0.000232] Console: colour dummy device 80x30
[    0.000726] console [tty0] enabled
[    0.000753] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
[    0.000780] pid_max: default: 32768 minimum: 301
[    0.000913] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000935] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001462] CPU: Testing write buffer coherency: ok
[    0.001774] CPU0: thread -1, cpu 0, socket 10, mpidr 80000a00
[    0.040022] Setting up static identity map for 0x40100000 - 0x40100060
[    0.059994] Hierarchical SRCU implementation.
[    0.099993] smp: Bringing up secondary CPUs ...
[    0.170322] CPU1: thread -1, cpu 1, socket 10, mpidr 80000a01
[    0.240304] CPU2: thread -1, cpu 2, socket 10, mpidr 80000a02
[    0.310298] CPU3: thread -1, cpu 3, socket 10, mpidr 80000a03
[    0.310386] smp: Brought up 1 node, 4 CPUs
[    0.310435] SMP: Total of 4 processors activated (192.00 BogoMIPS).
[    0.310450] CPU: All CPU(s) started in SVC mode.
[    0.311421] devtmpfs: initialized
[    0.320032] random: get_random_u32 called from bucket_table_alloc+0x7c/0x190 with crng_init=0
[    0.320308] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.320602] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.320634] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.322759] xor: measuring software checksum speed
[    0.419979]    arm4regs  :  1546.800 MB/sec
[    0.519979]    8regs     :  1216.000 MB/sec
[    0.619979]    32regs    :  1267.600 MB/sec
[    0.719980]    neon      :  1116.400 MB/sec
[    0.719995] xor: using function: arm4regs (1546.800 MB/sec)
[    0.720015] pinctrl core: initialized pinctrl subsystem
[    0.720685] /lcd0-power-domain@10023c80 has as child subdomain: /tv-power-domain@10023c20.
[    0.721430] NET: Registered protocol family 16
[    0.723075] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.724074] cpuidle: using governor menu
[    0.740423] genirq: irq_chip COMBINER did not update eff. affinity mask of irq 103
[    0.920291] raid6: int32x1  gen()   153 MB/s
[    1.090059] raid6: int32x1  xor()   195 MB/s
[    1.260170] raid6: int32x2  gen()   230 MB/s
[    1.430028] raid6: int32x2  xor()   216 MB/s
[    1.600112] raid6: int32x4  gen()   271 MB/s
[    1.770133] raid6: int32x4  xor()   210 MB/s
[    1.939993] raid6: int32x8  gen()   294 MB/s
[    2.110063] raid6: int32x8  xor()   197 MB/s
[    2.280013] raid6: neonx1   gen()   946 MB/s
[    2.450017] raid6: neonx1   xor()   801 MB/s
[    2.620020] raid6: neonx2   gen()   955 MB/s
[    2.790022] raid6: neonx2   xor()   966 MB/s
[    2.960024] raid6: neonx4   gen()   923 MB/s
[    3.130034] raid6: neonx4   xor()   921 MB/s
[    3.300068] raid6: neonx8   gen()   766 MB/s
[    3.470015] raid6: neonx8   xor()   730 MB/s
[    3.470030] raid6: using algorithm neonx2 gen() 955 MB/s
[    3.470044] raid6: .... xor() 966 MB/s, rmw enabled
[    3.470057] raid6: using neon recovery algorithm
[    3.471428] SCSI subsystem initialized
[    3.471596] usbcore: registered new interface driver usbfs
[    3.471650] usbcore: registered new interface driver hub
[    3.471750] usbcore: registered new device driver usb
[    3.472271] s3c-i2c 13860000.i2c: slave address 0x00
[    3.472296] s3c-i2c 13860000.i2c: bus frequency set to 390 KHz
[    3.472701] s3c-i2c 13860000.i2c: i2c-0: S3C I2C adapter
[    3.472877] s3c-i2c 13870000.i2c: slave address 0x00
[    3.472898] s3c-i2c 13870000.i2c: bus frequency set to 97 KHz
[    3.473179] s3c-i2c 13870000.i2c: i2c-1: S3C I2C adapter
[    3.473327] s3c-i2c 13880000.i2c: slave address 0x00
[    3.473348] s3c-i2c 13880000.i2c: bus frequency set to 97 KHz
[    3.473523] s3c-i2c 13880000.i2c: i2c-2: S3C I2C adapter
[    3.473633] s3c-i2c 138e0000.i2c: slave address 0x00
[    3.473653] s3c-i2c 138e0000.i2c: bus frequency set to 97 KHz
[    3.473920] s3c-i2c 138e0000.i2c: i2c-8: S3C I2C adapter
[    3.474550] Advanced Linux Sound Architecture Driver Initialized.
[    3.475074] clocksource: Switched to clocksource mct-frc
[    3.482501] NET: Registered protocol family 2
[    3.482980] tcp_listen_portaddr_hash hash table entries: 512 (order: 1, 12288 bytes)
[    3.483023] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    3.483102] TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
[    3.483250] TCP: Hash tables configured (established 8192 bind 8192)
[    3.483347] UDP hash table entries: 512 (order: 2, 24576 bytes)
[    3.483394] UDP-Lite hash table entries: 512 (order: 2, 24576 bytes)
[    3.483568] NET: Registered protocol family 1
[    3.483966] RPC: Registered named UNIX socket transport module.
[    3.483986] RPC: Registered udp transport module.
[    3.484000] RPC: Registered tcp transport module.
[    3.484013] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.484510] Unpacking initramfs...
[    3.484530] Decompressing using zstd.
[    3.785912] Freeing initrd memory: 5632K
[    3.786813] Initialise system trusted keyrings
[    3.786992] workingset: timestamp_bits=14 max_order=19 bucket_order=5
[    3.792774] NFS: Registering the id_resolver key type
[    3.792810] Key type id_resolver registered
[    3.792823] Key type id_legacy registered
[    3.794096] random: fast init done
[    3.794453] Key type asymmetric registered
[    3.794472] Asymmetric key parser 'x509' registered
[    3.794520] bounce: pool size: 64 pages
[    3.794569] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    3.794592] io scheduler noop registered
[    3.794605] io scheduler deadline registered
[    3.794726] io scheduler cfq registered (default)
[    3.794743] io scheduler mq-deadline registered
[    3.794758] io scheduler kyber registered
[    3.796217] samsung-usb2-phy 125b0000.exynos-usbphy: 125b0000.exynos-usbphy supply vbus not found, using dummy regulator
[    3.802195] dma-pl330 12680000.pdma: Loaded driver for PL330 DMAC-141330
[    3.802222] dma-pl330 12680000.pdma: 	DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[    3.804204] dma-pl330 12690000.pdma: Loaded driver for PL330 DMAC-141330
[    3.804229] dma-pl330 12690000.pdma: 	DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[    3.804907] dma-pl330 12850000.mdma: Loaded driver for PL330 DMAC-141330
[    3.804930] dma-pl330 12850000.mdma: 	DBUFF-64x8bytes Num_Chans-8 Num_Peri-1 Num_Events-32
[    3.852981] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    3.854707] 13800000.serial: ttySAC0 at MMIO 0x13800000 (irq = 52, base_baud = 0) is a S3C6400/10
[    3.855045] 13810000.serial: ttySAC1 at MMIO 0x13810000 (irq = 53, base_baud = 0) is a S3C6400/10
[    4.780589] console [ttySAC1] enabled
[    4.787777] exynos-hdmi 12d00000.hdmi: Failed to get supply 'vdd': -517
[    4.801007] loop: module loaded
[    4.815753] VDDQ_M1_2_1.8V: Bringing 1200000uV into 1800000-1800000uV
[    4.819694] VDD10_MPLL_1.0V: Bringing 1100000uV into 1000000-1000000uV
[    4.824464] VDD10_XPLL_1.0V: Bringing 1100000uV into 1000000-1000000uV
[    4.832909] VDD33_USB_3.3V: Bringing 3000000uV into 3300000-3300000uV
[    4.843807] VDDQ_LCD_1.8V: Bringing 3000000uV into 1800000-1800000uV
[    4.852022] BUCK8_P3V3: Bringing 2850000uV into 3300000-3300000uV
[    4.855007] s3c64xx-spi 13930000.spi: spi bus clock parent not specified, using clock at index 0 as parent
[    4.862160] s3c64xx-spi 13930000.spi: number of chip select lines not specified, assuming 1 chip select line
[    4.872907] libphy: Fixed MDIO Bus: probed
[    4.876233] usbcore: registered new interface driver r8152
[    4.881500] usbcore: registered new interface driver asix
[    4.886906] usbcore: registered new interface driver ax88179_178a
[    4.892955] usbcore: registered new interface driver cdc_ether
[    4.898797] usbcore: registered new interface driver smsc75xx
[    4.904502] usbcore: registered new interface driver smsc95xx
[    4.910250] usbcore: registered new interface driver net1080
[    4.915885] usbcore: registered new interface driver cdc_subset
[    4.921767] usbcore: registered new interface driver zaurus
[    4.927362] usbcore: registered new interface driver cdc_ncm
[    4.934388] dwc2 12480000.hsotg: dwc2_check_params: Invalid parameter g_np_tx_fifo_size=1024
[    4.941417] dwc2 12480000.hsotg: EPs: 16, dedicated fifos, 7808 entries in SPRAM
[    4.949721] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.955279] ehci-exynos: EHCI EXYNOS driver
[    4.960005] exynos-ehci 12580000.ehci: EHCI Host Controller
[    4.964987] exynos-ehci 12580000.ehci: new USB bus registered, assigned bus number 1
[    4.972898] exynos-ehci 12580000.ehci: irq 50, io mem 0x12580000
[    5.005110] exynos-ehci 12580000.ehci: USB 2.0 started, EHCI 1.00
[    5.005712] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    5.012332] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.019560] usb usb1: Product: EHCI Host Controller
[    5.024395] usb usb1: Manufacturer: Linux 4.15.0-12182-g6de178c233be ehci_hcd
[    5.031532] usb usb1: SerialNumber: 12580000.ehci
[    5.036640] hub 1-0:1.0: USB hub found
[    5.039962] hub 1-0:1.0: 3 ports detected
[    5.044527] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    5.050122] ohci-exynos: OHCI EXYNOS driver
[    5.054945] usbcore: registered new interface driver usb-storage
[    5.081083] usb3503 0-0008: switched to HUB mode
[    5.081151] usb3503 0-0008: usb3503_probe: probed in hub mode
[    5.086167] using random self ethernet address
[    5.090216] using random host ethernet address
[    5.094965] usb0: HOST MAC f6:c3:55:38:db:c4
[    5.098989] usb0: MAC 16:4a:4e:e5:b8:b5
[    5.102726] using random self ethernet address
[    5.107162] using random host ethernet address
[    5.111600] g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
[    5.118193] g_ether gadget: g_ether ready
[    5.122170] dwc2 12480000.hsotg: bound driver g_ether
[    5.255636] max77686-rtc max77686-rtc: rtc core: registered max77686-rtc as rtc0
[    5.258207] s3c-rtc 10070000.rtc: rtc disabled, re-enabling
[    5.262991] s3c-rtc 10070000.rtc: warning: invalid RTC value so initializing it
[    5.270304] rtc rtc1: invalid alarm value: 1900-1-1 0:0:0
[    5.275768] s3c-rtc 10070000.rtc: rtc core: registered s3c as rtc1
[    5.282216] i2c /dev entries driver
[    5.289591] s3c2410-wdt 10060000.watchdog: watchdog inactive, reset disabled, irq disabled
[    5.293918] device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initialised: dm-devel@redhat.com
[    5.304988] sdhci: Secure Digital Host Controller Interface driver
[    5.308102] sdhci: Copyright(c) Pierre Ossman
[    5.312657] s3c-sdhci 12530000.sdhci: clock source 2: mmc_busclk.2 (50000000 Hz)
[    5.319863] s3c-sdhci 12530000.sdhci: Got CD GPIO
[    5.351579] mmc0: SDHCI controller on samsung-hsmmc [12530000.sdhci] using ADMA
[    5.354944] Synopsys Designware Multimedia Card Interface Driver
[    5.363346] dwmmc_exynos 12550000.mmc: IDMAC supports 32-bit address mode.
[    5.366480] dwmmc_exynos 12550000.mmc: Using internal DMA controller.
[    5.372616] dwmmc_exynos 12550000.mmc: Version ID is 240a
[    5.378533] dwmmc_exynos 12550000.mmc: DW MMC controller at irq 110,32 bit host data width,128 deep fifo
[    5.388837] dwmmc_exynos 12550000.mmc: allocated mmc-pwrseq
[    5.392943] mmc_host mmc1: card is polling.
[    5.405126] usb 1-2: new high-speed USB device number 2 using exynos-ehci
[    5.410608] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual 396825HZ div = 63)
[    5.432726] s5p-secss 10830000.sss: s5p-sss driver registered
[    5.433928] usbcore: registered new interface driver usbhid
[    5.438519] usbhid: USB HID core driver
[    5.451054] exynos-ppmu: new PPMU device registered 106a0000.ppmu_dmc0 (ppmu-event3-dmc0)
[    5.453743] exynos-ppmu: new PPMU device registered 106b0000.ppmu_dmc1 (ppmu-event3-dmc1)
[    5.461904] exynos-ppmu: new PPMU device registered 112a0000.ppmu_rightbus (ppmu-event3-rightbus)
[    5.470755] exynos-ppmu: new PPMU device registered 116a0000.ppmu_leftbus0 (ppmu-event3-leftbus)
[    5.482013] NET: Registered protocol family 10
[    5.484367] Segment Routing with IPv6
[    5.487509] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    5.493653] NET: Registered protocol family 17
[    5.497992] NET: Registered protocol family 15
[    5.502255] Key type dns_resolver registered
[    5.506553] Registering SWP/SWPB emulation handler
[    5.511524] registered taskstats version 1
[    5.515337] Loading compiled-in X.509 certificates
[    5.520701] Btrfs loaded, crc32c=crc32c-generic
[    5.521580] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
[    5.535237] mmc1: new DDR MMC card at address 0001
[    5.539442] OF: graph: no port node found in /hdmi@12d00000
[    5.539912] mmcblk1: mmc1:0001 064G93 58.2 GiB 
[    5.545853] [drm] Exynos DRM: using 12c10000.mixer device for DMA mapping operations
[    5.549673] mmcblk1boot0: mmc1:0001 064G93 partition 1 4.00 MiB
[    5.557176] exynos-drm exynos-drm: bound 12c10000.mixer (ops mixer_component_ops)
[    5.563306] mmcblk1boot1: mmc1:0001 064G93 partition 2 4.00 MiB
[    5.570311] exynos-drm exynos-drm: bound 12d00000.hdmi (ops hdmi_component_ops)
[    5.576304] mmcblk1rpmb: mmc1:0001 064G93 partition 3 512 KiB, chardev (247:0)
[    5.583455] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    5.597261] [drm] No driver support for vblank timestamp query.
[    5.601834]  mmcblk1: p1 p2 p3 p4
[    5.603170] [drm] Cannot find any crtc or sizes
[    5.611323] [drm] Initialized exynos 1.0.0 20110530 for exynos-drm on minor 0
[    5.618675] [drm] Cannot find any crtc or sizes
[    5.622711] exynos-bus: new bus device registered: bus_dmc (100000 KHz ~ 400000 KHz)
[    5.625488] usb 1-2: New USB device found, idVendor=0424, idProduct=9730
[    5.630766] exynos-bus: new bus device registered: bus_acp (100000 KHz ~ 267000 KHz)
[    5.637023] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.644997] exynos-bus: new bus device registered: bus_c2c (100000 KHz ~ 400000 KHz)
[    5.654193] smsc95xx v1.0.6
[    5.660227] exynos-bus: new bus device registered: bus_leftbus (100000 KHz ~ 200000 KHz)
[    5.670738] exynos-bus: new bus device registered: bus_rightbus (100000 KHz ~ 200000 KHz)
[    5.679129] exynos-bus: new bus device registered: bus_display (160000 KHz ~ 200000 KHz)
[    5.687205] exynos-bus: new bus device registered: bus_fsys (100000 KHz ~ 134000 KHz)
[    5.694882] exynos-bus: new bus device registered: bus_peri ( 50000 KHz ~ 100000 KHz)
[    5.702671] exynos-bus: new bus device registered: bus_mfc (100000 KHz ~ 200000 KHz)
[    5.711817] input: gpio_keys as /devices/platform/gpio_keys/input/input0
[    5.750697] max77686-rtc max77686-rtc: setting system clock to 2000-01-01 01:00:12 UTC (946688412)
[    5.754599] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    5.768600] smsc95xx 1-2:1.0 eth0: register 'smsc95xx' at usb-12580000.ehci-2, smsc95xx USB 2.0 Ethernet, a6:4a:ab:96:ac:2f
[    5.786643] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    5.787826] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    5.796191] cfg80211: failed to load regulatory.db
[    5.829545] VDD10_HDMI_1.0V: disabling
[    5.831527] vdd_g3d: disabling
[    5.833441] ALSA device list:
[    5.833651]   No soundcards found.
[    5.840518] Freeing unused kernel memory: 1024K
[    5.842638] Checked W+X mappings: passed, no W+X pages found
Loading, please wait...
[    5.915278] usb 1-3: new high-speed USB device number 3 using exynos-ehci
starting version 237
[    6.125500] usb 1-3: New USB device found, idVendor=0424, idProduct=3503
[    6.126572] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    6.134256] hub 1-3:1.0: USB hub found
[    6.137644] hub 1-3:1.0: 3 ports detected
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
Begin: Running /scripts/local-premount ... Scanning for Btrfs filesystems
[    6.798629] BTRFS: device label antaeus devid 1 transid 70338 /dev/mmcblk1p3
[    6.800417] BTRFS: device label ereshkigal devid 1 transid 116018 /dev/mmcblk1p2
done.
Begin: Will now check root file system ... fsck from util-linux 2.30.2
[/bin/fsck.btrfs (1) -- /dev/mmcblk1p2] fsck.btrfs -a /dev/mmcblk1p2 
done.
[    6.926443] BTRFS info (device mmcblk1p2): disk space caching is enabled
[    6.927575] BTRFS info (device mmcblk1p2): has skinny extents
[    6.948194] BTRFS info (device mmcblk1p2): enabling ssd optimizations
done.
Begin: Running /scripts/local-bottom ... done.
Begin: Running /scripts/init-bottom ... done.
^MINIT: version 2.88 booting^M

   OpenRC 0.27 is starting up Linux 4.15.0-12182-g6de178c233be (armv7l)

 * /proc is already mounted
 * /run/openrc: creating directory
 * /run/lock: creating directory
 * /run/lock: correcting owner
 * Caching service dependencies ...
 [ ok ]
 * Clock skew detected with `/etc/init.d'
 * Adjusting mtime of `/run/openrc/deptree' to Wed Jan 31 04:48:16 2018
 * WARNING: clock skew detected!
[....] Starting the hotplug events dispatcher: systemd-udevdstarting version 237
[ ok .
[....] Synthesizing the initial hotplug events...[    9.193396] media: Linux media interface: v0.10
[    9.208713] Linux video capture interface: v2.00
[    9.231290] s5p-jpeg 11840000.jpeg-codec: encoder device registered as /dev/video0
[    9.238343] s5p-jpeg 11840000.jpeg-codec: decoder device registered as /dev/video1
[    9.242163] s5p-jpeg 11840000.jpeg-codec: Samsung S5P JPEG codec
[    9.250779] platform 13400000.codec:left: assigned reserved memory node region_mfc_left
[    9.258485] platform 13400000.codec:right: assigned reserved memory node region_mfc_right
[ ok done.
[    9.292151] s5p-mfc 13400000.codec: decoder registered as /dev/video2
[    9.294817] s5p-mfc 13400000.codec: encoder registered as /dev/video3
[....] Waiting for /dev to be fully populated...[    9.365804] s5p-fimc-md camera: Entity type for entity FIMC.0 was not initialized!
[    9.367924] s5p-fimc-md: Registered fimc.0.m2m as /dev/video4
[    9.374644] s5p-fimc-md: Registered fimc.0.capture as /dev/video5
[    9.380590] s5p-fimc-md camera: Entity type for entity FIMC.1 was not initialized!
[    9.387338] s5p-fimc-md: Registered fimc.1.m2m as /dev/video6
[    9.393197] s5p-fimc-md: Registered fimc.1.capture as /dev/video7
[    9.582434] __fimc_pipeline_open(): No sensor subdev
[    9.582844] __fimc_pipeline_close(): No sensor subdev
[    9.583505] __fimc_pipeline_open(): No sensor subdev
[    9.593962] __fimc_pipeline_close(): No sensor subdev
[ ok done.
[....] Activating swap...[ ok done.
[   10.646727] BTRFS info (device mmcblk1p2): use zstd compression
[   10.647024] BTRFS info (device mmcblk1p2): disk space caching is enabled
[....] Activating lvm and md swap...[ ok done.
[....] Checking file systems...fsck from util-linux 2.30.2
/dev/mmcblk1p1: Superblock last mount time is in the future.
	(by less than a day, probably due to the hardware clock being incorrectly set)
/dev/mmcblk1p1: Superblock last write time (Fri Feb  9 11:00:11 2018,
	now = Wed Dec 27 08:27:23 2017) is in the future.
FIXED.
^A/dev/mmcblk1p1: |==                                              |  4.1%   ^M^A/dev/mmcblk1p1: |================================================| 100.0%   ^M^A                                                                               ^M^B/dev/mmcblk1p1: 81/32912 files (13.6% non-contiguous), 64124/131584 blocks
[ ok done.
[....] Cleaning up temporary files... /tmp[ ok .
[....] Mounting local filesystems...[   11.743636] EXT4-fs (mmcblk1p1): mounted filesystem with ordered data mode. Opts: (null)
[ ok done.
[....] Activating swapfile swap...[ ok done.
[....] Cleaning up temporary files...[ ok .
[....] Setting kernel variables...[ ok done.
[....] Configuring network interfaces...Waiting for DAD... [   13.415996] random: crng init done
Done
[   14.472016] smsc95xx 1-2:1.0 eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1
ifquery: recursion detected for interface eth0 in post-up phase
mount: /srv: can't find LABEL=asmodeus.
[ ok done.
Starting NBD client process: Connecting...Negotiation: ..size = 65536MB
bs=1024, sz=68719476736 bytes
Negotiation: ..size = 4096MB
bs=1024, sz=4294967296 bytes
[   15.227029] BTRFS: device label asmodeus devid 1 transid 345229 /dev/nbd0
[....] Cleaning up temporary files...[ ok .
^MINIT: Entering runlevel: 3^M
 * WARNING: clock skew detected!
[....] Starting enhanced syslogd: rsyslogd[ ok .
[....] Starting periodic command scheduler: cron[ ok .
[....] Starting SMP IRQ Balancer: irqbalance[ ok .
[....] Starting NTP server: ntpd[ ok .
[....] Starting mail-transfer-agent: nullmailer[ ok .
[....] Recovering schroot sessions:[ ok .
[....] Starting OpenBSD Secure Shell server: sshd[ ok .
^M
Debian GNU/Linux 9 kholdan ttySAC1

kholdan login: ^MINIT: Switching to runlevel: 6^MINIT: Sending processes the TERM signal^M
 * WARNING: clock skew detected!
[....] Stopping OpenBSD Secure Shell server: sshd[ ok .
[....] Stopping rsync daemon: rsync[ ok .
[....] Stopping mail-transfer-agent: nullmailer[ ok .
[....] Stopping NTP server: ntpd[ ok .
[....] Stopping SMP IRQ Balancer: irqbalance[ ok .
[....] Stopping periodic command scheduler: cron[ ok .
[....] Stopping enhanced syslogd: rsyslogd[ ok .
 * Clock skew detected!
 * Not saving deptree cache
 * ERROR: savecache failed to start
 * WARNING: clock skew detected!
[....] Action 'stop' is meaningless for this init script ...[warn (warning).
[....] Asking all remaining processes to terminate...[  261.567432] block nbd1: shutting down sockets
[  261.567463] block nbd0: shutting down sockets
[ ok done.
[....] All processes ended within 1 seconds...[ ok done.
Stopping NBD client process: 
disconnect, [  262.250065] block nbd0: NBD_DISCONNECT
sock, done
disconnect, [  262.263395] block nbd1: NBD_DISCONNECT
sock, done
rmmod: ERROR: Module nbd is builtin.
nbd-client.
[....] Deconfiguring network interfaces...[ ok done.
[....] Unmounting temporary filesystems...[ ok done.
[....] Deactivating swap...[ ok done.
[....] Unmounting local filesystems...[ ok done.
[  263.699664] BTRFS info (device mmcblk1p2): disk space caching is enabled
[....] Stopping the hotplug events dispatcher: systemd-udevd[ ok .
[info] Will now restart.
[  2�K!C^@^@^@�

(then nothing until power cycled)

--s6ppryxxukinibnu--
