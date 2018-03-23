Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbeCWWUP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 18:20:15 -0400
Received: from orthanc.universe-factory.net ([104.238.176.138]:52930 "EHLO
        orthanc.universe-factory.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751847AbeCWWUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 18:20:13 -0400
From: Matthias Schiffer <mschiffer@universe-factory.net>
Subject: ftrace on MIPS/ath79
To: rostedt@goodmis.org, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <d0f29d7e-2c4f-c8e4-4179-406c55eaca1c@universe-factory.net>
Date: Fri, 23 Mar 2018 23:20:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="jxFULIEj41mqSMRQYV7eU5MOrbtdZfj5I"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jxFULIEj41mqSMRQYV7eU5MOrbtdZfj5I
Content-Type: multipart/mixed; boundary="ALJivMSomDHYDBuGI2h8PDyjpCXMtGM5e";
 protected-headers="v1"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: rostedt@goodmis.org, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <d0f29d7e-2c4f-c8e4-4179-406c55eaca1c@universe-factory.net>
Subject: ftrace on MIPS/ath79

--ALJivMSomDHYDBuGI2h8PDyjpCXMtGM5e
Content-Type: multipart/mixed;
 boundary="------------BD29AB5286C6C854E8A7FF0C"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------BD29AB5286C6C854E8A7FF0C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,
I'm currently trying to debug a performance bottleneck on low-end ath79
hardware running OpenWrt/LEDE, but it seems that ftrace is not working
correctly on these systems. I have tried this with recent 4.4.y and 4.9.y=

with similar results; unfortunately, switching to a newer kernel is not
easily possible on this hardware at the moment. Please let me know if the=
re
are any known issues or patches that I should backport.

There seem to be two separate issues:

1) Building with CONFIG_DYNAMIC_FTRACE leads to a kernel panic as soon as=

kernel modules are loaded (logs attached).

2) function_graph tracer does not show anything useful: the trace output
looks like what was reported in [1]. Building with
CONFIG_FUNCTION_GRAPH_TRACER leads to a completely empty
trace_stat/function0 (except for the header); profiling is working as
expected when CONFIG_FUNCTION_GRAPH_TRACER is disabled.

I would be thankful for any pointers that might help me to make this work=
=2E

Kind regards,
Matthias


[1] https://www.linux-mips.org/archives/linux-mips/2014-11/msg00295.html


--------------BD29AB5286C6C854E8A7FF0C
Content-Type: text/x-log;
 name="panic-4.4.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="panic-4.4.log"

[    0.000000] Linux version 4.4.120 (neoraider@avalon) (gcc version 5.4.=
0 (LEDE GCC 5.4.0 r3826+66-2e26bdfeca2f) ) #0 Sun Mar 4 09:26:34 2018
[    0.000000] bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 0001974c (MIPS 74Kc)
[    0.000000] SoC: Atheros AR9344 rev 2
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 08000000 @ 00000000 (usable)
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] No valid device tree found, continuing without
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x0000000007ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000007f=
fffff]
[    0.000000] Primary instruction cache 64kB, VIPT, 4-way, linesize 32 b=
ytes.
[    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases, lines=
ize 32 bytes
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  To=
tal pages: 32512
[    0.000000] Kernel command line:  board=3DTL-WDR4300  console=3DttyS0,=
115200 rootfstype=3Dsquashfs,jffs2 noinitrd
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 by=
tes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 byte=
s)
[    0.000000] Writing ErrCtl register=3D00000000
[    0.000000] Readback ErrCtl register=3D00000000
[    0.000000] Memory: 122112K/131072K available (3536K kernel code, 236K=
 rwdata, 876K rodata, 2512K init, 222K bss, 8960K reserved, 0K cma-reserv=
ed)
[    0.000000] SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1,=
 Nodes=3D1
[    0.000000] NR_IRQS:51
[    0.000000] Clocks: CPU:560.000MHz, DDR:450.000MHz, AHB:225.000MHz, Re=
f:40.000MHz
[    0.000000] clocksource: MIPS: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 6825930166 ns
[    0.000009] sched_clock: 32 bits at 280MHz, resolution 3ns, wraps ever=
y 7669584382ns
[    0.008301] Calibrating delay loop... 278.93 BogoMIPS (lpj=3D1394688)
[    0.081147] pid_max: default: 32768 minimum: 301
[    0.086191] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes=
)
[    0.093235] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 =
bytes)
[    0.101551] ftrace: allocating 13717 entries in 27 pages
[    0.141788] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 19112604462750000 ns
[    0.152314] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.160139] NET: Registered protocol family 16
[    0.166372] MIPS: machine is TP-LINK TL-WDR3600/4300/4310
[    0.175495] registering PCI controller with io_map_base unset
[    0.413427] PCI host bridge to bus 0000:00
[    0.417847] pci_bus 0000:00: root bus resource [mem 0x10000000-0x13fff=
fff]
[    0.425158] pci_bus 0000:00: root bus resource [io  0x0000]
[    0.431102] pci_bus 0000:00: root bus resource [??? 0x00000000 flags 0=
x0]
[    0.438322] pci_bus 0000:00: No busn resource found for root bus, will=
 use [bus 00-ff]
[    0.446838] pci 0000:00:00.0: invalid calibration data
[    0.452755] pci 0000:00:00.0: BAR 0: assigned [mem 0x10000000-0x1001ff=
ff 64bit]
[    0.460588] pci 0000:00:00.0: BAR 6: assigned [mem 0x10020000-0x1002ff=
ff pref]
[    0.468283] pci 0000:00:00.0: using irq 40 for pin 1
[    0.474503] clocksource: Switched to clocksource MIPS
[    0.492881] NET: Registered protocol family 2
[    0.498489] TCP established hash table entries: 1024 (order: 0, 4096 b=
ytes)
[    0.505964] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.512730] TCP: Hash tables configured (established 1024 bind 1024)
[    0.519588] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.525849] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.532802] NET: Registered protocol family 1
[    3.491323] Crashlog allocated RAM at address 0x3f00000
[    3.512937] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    3.519209] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME) (CMODE_=
PRIORITY) (c) 2001-2006 Red Hat, Inc.
[    3.532438] io scheduler noop registered
[    3.536672] io scheduler deadline registered (default)
[    3.542475] Serial: 8250/16550 driver, 16 ports, IRQ sharing enabled
[    3.552135] console [ttyS0] disabled
[    3.576029] serial8250.0: ttyS0 at MMIO 0x18020000 (irq =3D 11, base_b=
aud =3D 2500000) is a 16550A
[    3.585215] console [ttyS0] enabled
[    3.585215] console [ttyS0] enabled
[    3.592627] bootconsole [early0] disabled
[    3.592627] bootconsole [early0] disabled
[    3.606728] m25p80 spi0.0: found s25fl064k, expected m25p80
[    3.621987] m25p80 spi0.0: s25fl064k (8192 Kbytes)
[    3.627199] 5 tp-link partitions found on MTD device spi0.0
[    3.632853] Creating 5 MTD partitions on "spi0.0":
[    3.637755] 0x000000000000-0x000000020000 : "u-boot"
[    3.644264] 0x000000020000-0x00000016d1cc : "kernel"
[    3.651059] 0x00000016d1cc-0x0000007f0000 : "rootfs"
[    3.657839] mtd: device 2 (rootfs) set to be root filesystem
[    3.663620] 1 squashfs-split partitions found on MTD device rootfs
[    3.669947] 0x0000003b0000-0x0000007f0000 : "rootfs_data"
[    3.677140] 0x0000007f0000-0x000000800000 : "art"
[    3.683646] 0x000000020000-0x0000007f0000 : "firmware"
[    3.698630] switch0: Atheros AR8327 rev. 2 switch registered on ag71xx=
-mdio.0
[    4.307004] libphy: ag71xx_mdio: probed
[    4.895898] ag71xx ag71xx.0: connected to PHY at ag71xx-mdio.0:00 [uid=
=3D004dd033, driver=3DAtheros AR8216/AR8236/AR8316]
[    4.907372] eth0: Atheros AG71xx at 0xb9000000, irq 4, mode:RGMII
[    4.915955] NET: Registered protocol family 10
[    4.924368] NET: Registered protocol family 17
[    4.929020] bridge: automatic filtering via arp/ip/ip6tables has been =
deprecated. Update your scripts to load br_netfilter if you need this.
[    4.941959] 8021q: 802.1Q VLAN Support v1.8
[    4.960066] Freeing unused kernel memory: 2512K
[    4.978378] init: Console is alive
[    4.982051] init: - watchdog -
[    5.011447] kmodloader: loading kernel modules from /etc/modules-boot.=
d/*
[    5.022075] CPU 0 Unable to handle kernel paging request at virtual ad=
dress 0000005c, epc =3D=3D 800cd330, ra =3D=3D 801c69e4
[    5.032906] Oops[#1]:
[    5.035220] CPU: 0 PID: 338 Comm: kmodloader Not tainted 4.4.120 #0
[    5.041577] task: 87e032f0 ti: 87e36000 task.ti: 87e36000
[    5.047046] $ 0   : 00000000 801c69e4 00000001 00000000
[    5.052378] $ 4   : 0000005c 8046543c 80760000 00000000
[    5.057710] $ 8   : 00000000 00000000 00000001 0000000a
[    5.063044] $12   : 0000000c 001f0040 00000000 61736800
[    5.068376] $16   : 87e39a00 87e39a00 801c69e4 804d0000
[    5.073709] $20   : 00000000 00000000 00000012 024000c0
[    5.079042] $24   : 00000008 800798b4
[    5.084374] $28   : 87e36000 87e37ca0 800cd764 801c69e4
[    5.089709] Hi    : 004ab5e4
[    5.092630] Lo    : 25e74934
[    5.095569] epc   : 800cd330 try_module_get+0x28/0xe4
[    5.100711] ra    : 801c69e4 crypto_mod_get+0x24/0x5c
[    5.105830] Status: 1100d403 KERNEL EXL IE
[    5.110100] Cause : 00800008 (ExcCode 02)
[    5.114164] BadVA : 0000005c
[    5.117086] PrId  : 0001974c (MIPS 74Kc)
[    5.121062] Modules linked in: crc32c_generic(+) crypto_hash
[    5.126824] Process kmodloader (pid: 338, threadinfo=3D87e36000, task=3D=
87e032f0, tls=3D77eabd48)
[    5.135291] Stack : 00000417 87e39a28 00000000 801c6cc8 87e39a00 87e39=
a00 804d619c 801c69e4
          801fe790 ffffffef 87e39a00 804d619c 87e3f000 801c84b4 87e3a000 =
87e39800
          00000100 00000200 87e032f0 87e39a00 804d0000 87e39800 804b0000 =
801c93fc
          87de49b0 87de49b0 00000000 00000001 87e39900 87e39900 87e3a000 =
80060aa8
          87cb5800 800a7060 87e3a000 00001df2 87e3b448 804d0000 00000000 =
87cec00c
          ...
[    5.171618] Call Trace:
[    5.174107] [<800cd330>] try_module_get+0x28/0xe4
[    5.178880] [<801c69e4>] crypto_mod_get+0x24/0x5c
[    5.183662] [<801c84b4>] __crypto_register_alg+0x148/0x1cc
[    5.189232] [<801c93fc>] crypto_register_alg+0x50/0x88
[    5.194446] [<80060aa8>] do_one_initcall+0x1f0/0x228
[    5.199487] [<800fcf18>] do_init_module+0x84/0x1ec
[    5.204358] [<800d05b8>] load_module+0x1834/0x1ce0
[    5.209221] [<800d0b88>] SyS_init_module+0x124/0x174
[    5.214273] [<8007016c>] syscall_common+0x30/0x54
[    5.219044]
[    5.220554]
Code: 00000000  10800029  03e09021 <8c830000> 24020002  14620003  0000000=
0  10000021  00001021
[    5.230711] ---[ end trace 830c7245ad7ebbf1 ]---
[    5.236618] Fatal exception: panic in 5 seconds
[   10.244516] Kernel panic - not syncing: Fatal exception
[   10.251059] Rebooting in 1 seconds..


--------------BD29AB5286C6C854E8A7FF0C
Content-Type: text/x-log;
 name="panic-4.9.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="panic-4.9.log"

[    0.000000] Linux version 4.9.87 (neoraider@avalon) (gcc version 7.3.0=
 (OpenWrt GCC 7.3.0 r6475+7-96288dc13912) ) #0 Sun Mar 4 09:26:34 2018
[    0.000000] bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 0001974c (MIPS 74Kc)
[    0.000000] SoC: Atheros AR9344 rev 2
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 08000000 @ 00000000 (usable)
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] Primary instruction cache 64kB, VIPT, 4-way, linesize 32 b=
ytes.
[    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases, lines=
ize 32 bytes
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x0000000007ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000007f=
fffff]
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  To=
tal pages: 32512
[    0.000000] Kernel command line:  board=3DTL-WDR4300  console=3DttyS0,=
115200 rootfstype=3Dsquashfs noinitrd
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 by=
tes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 byte=
s)
[    0.000000] Writing ErrCtl register=3D00000000
[    0.000000] Readback ErrCtl register=3D00000000
[    0.000000] Memory: 121780K/131072K available (3746K kernel code, 253K=
 rwdata, 912K rodata, 2568K init, 233K bss, 9292K reserved, 0K cma-reserv=
ed)
[    0.000000] SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1,=
 Nodes=3D1
[    0.000000] NR_IRQS:51
[    0.000000] Clocks: CPU:560.000MHz, DDR:450.000MHz, AHB:225.000MHz, Re=
f:40.000MHz
[    0.000000] clocksource: MIPS: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 6825930166 ns
[    0.000009] sched_clock: 32 bits at 280MHz, resolution 3ns, wraps ever=
y 7669584382ns
[    0.008310] Calibrating delay loop... 278.93 BogoMIPS (lpj=3D1394688)
[    0.081156] pid_max: default: 32768 minimum: 301
[    0.086202] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes=
)
[    0.093257] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 =
bytes)
[    0.101653] ftrace: allocating 14258 entries in 28 pages
[    0.143531] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 19112604462750000 ns
[    0.154049] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.161771] NET: Registered protocol family 16
[    0.168060] MIPS: machine is TP-LINK TL-WDR3600/4300/4310
[    0.177177] registering PCI controller with io_map_base unset
[    0.435908] PCI host bridge to bus 0000:00
[    0.440336] pci_bus 0000:00: root bus resource [mem 0x10000000-0x13fff=
fff]
[    0.447653] pci_bus 0000:00: root bus resource [io  0x0000]
[    0.453596] pci_bus 0000:00: root bus resource [??? 0x00000000 flags 0=
x0]
[    0.460816] pci_bus 0000:00: No busn resource found for root bus, will=
 use [bus 00-ff]
[    0.469304] pci 0000:00:00.0: invalid calibration data
[    0.475217] pci 0000:00:00.0: BAR 0: assigned [mem 0x10000000-0x1001ff=
ff 64bit]
[    0.483050] pci 0000:00:00.0: BAR 6: assigned [mem 0x10020000-0x1002ff=
ff pref]
[    0.490748] pci 0000:00:00.0: using irq 40 for pin 1
[    0.499024] clocksource: Switched to clocksource MIPS
[    0.518373] NET: Registered protocol family 2
[    0.524035] TCP established hash table entries: 1024 (order: 0, 4096 b=
ytes)
[    0.531521] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.538295] TCP: Hash tables configured (established 1024 bind 1024)
[    0.545151] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.551412] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.558297] NET: Registered protocol family 1
[    2.589038] random: fast init done
[    3.533190] Crashlog allocated RAM at address 0x3f00000
[    3.539923] workingset: timestamp_bits=3D30 max_order=3D15 bucket_orde=
r=3D0
[    3.554591] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    3.560842] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME) (CMODE_=
PRIORITY) (c) 2001-2006 Red Hat, Inc.
[    3.694475] io scheduler noop registered
[    3.698650] io scheduler deadline registered (default)
[    3.704604] Serial: 8250/16550 driver, 16 ports, IRQ sharing enabled
[    3.714318] console [ttyS0] disabled
[    3.738205] serial8250.0: ttyS0 at MMIO 0x18020000 (irq =3D 11, base_b=
aud =3D 2500000) is a 16550A
[    3.747394] console [ttyS0] enabled
[    3.747394] console [ttyS0] enabled
[    3.754816] bootconsole [early0] disabled
[    3.754816] bootconsole [early0] disabled
[    3.769275] m25p80 spi0.0: found s25fl064k, expected m25p80
[    3.785152] m25p80 spi0.0: s25fl064k (8192 Kbytes)
[    3.790332] 5 tp-link partitions found on MTD device spi0.0
[    3.795989] Creating 5 MTD partitions on "spi0.0":
[    3.800884] 0x000000000000-0x000000020000 : "u-boot"
[    3.807458] 0x000000020000-0x00000016d1cc : "kernel"
[    3.814288] 0x00000016d1cc-0x0000007f0000 : "rootfs"
[    3.821104] mtd: device 2 (rootfs) set to be root filesystem
[    3.826882] 1 squashfs-split partitions found on MTD device rootfs
[    3.833219] 0x0000003b0000-0x0000007f0000 : "rootfs_data"
[    3.840474] 0x0000007f0000-0x000000800000 : "art"
[    3.846991] 0x000000020000-0x0000007f0000 : "firmware"
[    3.855013] libphy: Fixed MDIO Bus: probed
[    3.909077] switch0: Atheros AR8327 rev. 2 switch registered on ag71xx=
-mdio.0
[    5.072751] libphy: ag71xx_mdio: probed
[    5.700417] ag71xx ag71xx.0: connected to PHY at ag71xx-mdio.0:00 [uid=
=3D004dd033, driver=3DAtheros AR8216/AR8236/AR8316]
[    5.711952] eth0: Atheros AG71xx at 0xb9000000, irq 4, mode:RGMII
[    5.720077] NET: Registered protocol family 10
[    5.728146] NET: Registered protocol family 17
[    5.732778] bridge: filtering via arp/ip/ip6tables is no longer availa=
ble by default. Update your scripts to load br_netfilter if you need this=
=2E
[    5.746033] 8021q: 802.1Q VLAN Support v1.8
[    5.763993] Freeing unused kernel memory: 2568K
[    5.768597] This architecture does not have kernel memory protection.
[    5.790338] init: Console is alive
[    5.794031] init: - watchdog -
[    5.836273] kmodloader: loading kernel modules from /etc/modules-boot.=
d/*
[    5.853856] CPU 0 Unable to handle kernel paging request at virtual ad=
dress 27bdfff0, epc =3D=3D 86e906a4, ra =3D=3D 86e90688
[    5.864676] Oops[#1]:
[    5.866989] CPU: 0 PID: 355 Comm: kmodloader Not tainted 4.9.87 #0
[    5.873258] task: 87e3af88 task.stack: 86e70000
[    5.877847] $ 0   : 00000000 86e90688 801b629c 801b62a0
[    5.883179] $ 4   : 801b62b0 00200000 00000000 00000000
[    5.888512] $ 8   : 87e0f240 fffffffc 732d706f 6c6c6564
[    5.893846] $12   : 86e71bdc 001c0040 00000000 6f5f746f
[    5.899178] $16   : 87ce8010 86e90614 27bdffe0 807e0000
[    5.904510] $20   : 807e0000 00000001 00000015 024000c0
[    5.909844] $24   : 00000001 00000000                 =20
[    5.915176] $28   : 86e70000 86e71be0 800d58a0 86e90688
[    5.920509] Hi    : 00000007
[    5.923431] Lo    : 00000010
[    5.926374] epc   : 86e906a4 0x86e906a4
[    5.930269] ra    : 86e90688 0x86e90688
[    5.934158] Status: 1100d403	KERNEL EXL IE=20
[    5.938428] Cause : 00800008 (ExcCode 02)
[    5.942493] BadVA : 27bdfff0
[    5.945414] PrId  : 0001974c (MIPS 74Kc)
[    5.949390] Modules linked in: gpio_button_hotplug(+) crc16 crypto_has=
h
[    5.956130] Process kmodloader (pid: 355, threadinfo=3D86e70000, task=3D=
87e3af88, tls=3D77087dc0)
[    5.964597] Stack : 800d58a0 801b8fec 807e0000 800a031c 8051aca0 801b6=
29c 87ce8010 87ce8010
[    5.973132]         86e91034 86e91034 807e0000 80292054 87c1c4b0 801b8=
cac 80520000 024000c0
[    5.981667]         87ce8010 87ce8010 87ce8044 80290328 00000000 00000=
000 00000015 803fff50
[    5.990203]         00000000 87ce8010 87ce8044 86e91034 8051aca0 00000=
000 00000000 8029047c
[    5.998739]         8051aca0 8028e23c 87dc2180 00000000 00000000 86e91=
034 802903e8 8028e308
[    6.007275]         ...
[    6.009768] Call Trace:
[    6.012259] [<86e906a4>] 0x86e906a4
[    6.015804] Code: ac430020  24430004  ac430024 <8e430010> 10600004  00=
008025  0060f809  8c440034  00008025=20
[    6.025757]=20
[    6.027295] ---[ end trace 11a961593d985b39 ]---
[    6.033289] Kernel panic - not syncing: Fatal exception
[    6.039693] Rebooting in 1 seconds..

--------------BD29AB5286C6C854E8A7FF0C--

--ALJivMSomDHYDBuGI2h8PDyjpCXMtGM5e--

--jxFULIEj41mqSMRQYV7eU5MOrbtdZfj5I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAlq1fZoACgkQFu8/ZMsg
HZxPeA//V3suVhQSIai+jI0MOe8ziVwPAmnnxtUFd7m8u0iR8QTK70NpWYEh7INf
+02J1Fdf3vWbkyeZPDSyPUbllkh2Wml3/puld/WxQ8RSewISaA38Dckb+l1HO9+H
zZOqWU0skAVaXEBYx0gjH6iX2ZqBeQ9AuZIIoM/UhAeyYA+G20otEPcfsX2ne5O9
CS6sV3TTRugn1iqqJoCg5Joo+BqUXCoI57CacdkQFfTcTG91h3g6WZbq/hYXAC1i
RezpdCVuDwBeXO2zVxeKIogRywkPwn8LK7iTSHBkP2K03IzrV8uQJeVekMhqYmXI
qDe2OUBAUgg73kJK+nNOxB0e8+mCRmV2v+jbxznxF737QE+WWroFHASoUL1ItruX
E6ZXPCmUGHJ8fv8UE66jdanGFuPFwMRw/gpdym+0l0EeB12i8BLawv+XbIjL/axl
MX3guB+NuWY53Zpu7tRiKwgVJ5ZqRAEa+RR9crqroSpVDtIJ8Z+hf85v8WVhFzem
0elGaZWLtyBhR/uAQEL+JEo5kBF6adcNrtVQtajNDdHk8edvBGRKlg2Jxb8z9FsX
DILCxQQAHqSDhqYxH1QcaU6JG0O3Q7CTO4wGEiUsspEf9rV1St3tiZr2Qso6bSoy
djAz9kzkatV/Gvv6ebc8yQwjBf+oSaW506RBbAUB0FXzdpuvLPs=
=/rZG
-----END PGP SIGNATURE-----

--jxFULIEj41mqSMRQYV7eU5MOrbtdZfj5I--
