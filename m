Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeECPf1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 11:35:27 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:63080 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbeECPfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 11:35:23 -0400
Subject: Re: [PATCH v9 07/27] ARM: davinci: dm355: add new clock init using
 common clock framework
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20180427001745.4116-1-david@lechnology.com>
 <20180427001745.4116-8-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <d9633747-0c50-2934-d3b2-ba745f021077@ti.com>
Date: Thu, 3 May 2018 21:04:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427001745.4116-8-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 April 2018 05:47 AM, David Lechner wrote:
> This adds the new board-specific clock init in mach-davinci/dm355.c
> using the new common clock framework drivers.
> 
> The #ifdefs are needed to prevent compile errors until the entire
> ARCH_DAVINCI is converted.
> 
> Also clean up the #includes since we are adding some here.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

I am having trouble booting DM355 EVM with the series applied.
Still to debug what is going wrong.

Thanks,
Sekhar

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 4.17.0-rc2-08642-g4dee494ef1ee (a0875516@psplinux063) (gcc version 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #202 PREEM8
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=0005317f
CPU: VIVT data cache, VIVT instruction cache
Machine: DaVinci DM355 EVM
Memory policy: Data cache writethrough
cma: Reserved 16 MiB at 0x86c00000
DaVinci dm355 variant 0x0
random: get_random_bytes called from start_kernel+0x88/0x3f4 with crng_init=0
Built 1 zonelists, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttyS0,115200n8 root=/dev/nfs rw nfsroot=172.24.210.141:/datalocal/Sekhar/new/debian/armel ip=dhcp
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 107044K/131072K available (4684K kernel code, 283K rwdata, 1068K rodata, 240K init, 134K bss, 7644K reserved, 16384K cma-res)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xc8800000 - 0xff800000   ( 880 MB)
    lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0x(ptrval) - 0x(ptrval)   (4686 kB)
      .init : 0x(ptrval) - 0x(ptrval)   ( 240 kB)
      .data : 0x(ptrval) - 0x(ptrval)   ( 284 kB)
       .bss : 0x(ptrval) - 0x(ptrval)   ( 135 kB)
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Preemptible hierarchical RCU implementation.
        Tasks RCU enabled.
NR_IRQS: 245
clocksource: timer0_1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
Console: colour dummy device 80x30
Calibrating delay loop... 106.90 BogoMIPS (lpj=534528)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x80008400 - 0x80008458
Hierarchical SRCU implementation.
devtmpfs: initialized
Built 1 zonelists, mobility grouping on.  Total pages: 30857
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
futex hash table entries: 256 (order: -1, 3072 bytes)
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
mux: initialized INT_EDMA_CC
mux: Setting register INT_EDMA_CC
mux:    INTMUX (0x00000018) = 0x00000000 -> 0x00000004
cpuidle: using governor menu
edma edma.0: Legacy memcpy is enabled, things might not work
edma edma.0: TI EDMA DMA engine driver
dm355evm_msp 1-0025: firmware v.A5, TVP5146 as video-in
clocksource: Switched to clocksource timer0_1
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
workingset: timestamp_bits=30 max_order=15 bucket_order=0
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
io scheduler noop registered (default)
io scheduler mq-deadline registered
io scheduler kyber registered
Serial: 8250/16550 driver, 3 ports, IRQ sharing disabled
console [ttyS0] disabled
serial8250.0: ttyS0 at MMIO 0x1c20000 (irq = 40, base_baud = 1500000) is a 16550A
console [ttyS0] enabled
serial8250.1: ttyS1 at MMIO 0x1c20400 (irq = 41, base_baud = 1500000) is a 16550A
serial8250 serial8250.2: unable to register port at index 0 (IO0 MEM1e06000 IRQ14): -22
brd: module loaded
libphy: Fixed MDIO Bus: probed
dm9000 dm9000: incomplete constraints, dummy supplies not allowed
eth0: dm9000a at (ptrval),(ptrval) IRQ 65 MAC: 00:0e:99:02:cb:91 (eeprom)
i2c /dev entries driver
davinci-wdt davinci-wdt: heartbeat 60 sec
Division by zero in kernel.
CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc2-08642-g4dee494ef1ee #202
Hardware name: DaVinci DM355 EVM
Backtrace: 
[<c000dfa4>] (dump_backtrace) from [<c000e274>] (show_stack+0x18/0x1c)
 r7:00000000 r6:00000000 r5:fee11000 r4:c6acd400
[<c000e25c>] (show_stack) from [<c047eedc>] (dump_stack+0x20/0x28)
[<c047eebc>] (dump_stack) from [<c000e104>] (__div0+0x18/0x20)
[<c000e0ec>] (__div0) from [<c047d510>] (Ldiv0+0x8/0x10)
[<c0343e48>] (calculate_clk_divider) from [<c0344014>] (mmc_davinci_set_ios+0x58/0x168)
 r9:c6ac6b80 r8:c05ed140 r7:0000001a r6:00000001 r5:c6acd5e8 r4:c6acd400
[<c0343fbc>] (mmc_davinci_set_ios) from [<c0330480>] (mmc_set_initial_state+0x9c/0xa0)
 r5:c6acd5e8 r4:c6acd400
[<c03303e4>] (mmc_set_initial_state) from [<c03304bc>] (mmc_power_up.part.8+0x38/0x110)
 r5:00000015 r4:c6acd400
[<c0330484>] (mmc_power_up.part.8) from [<c033198c>] (mmc_start_host+0x94/0xa8)
 r7:0000001a r6:c05ed130 r5:00000000 r4:c6acd400
[<c03318f8>] (mmc_start_host) from [<c0332c5c>] (mmc_add_host+0x60/0x88)
 r5:00000000 r4:c6acd400
[<c0332bfc>] (mmc_add_host) from [<c0344630>] (davinci_mmcsd_probe+0x3f8/0x5dc)
 r5:c6acd754 r4:c6acd400
[<c0344238>] (davinci_mmcsd_probe) from [<c02d1f70>] (platform_drv_probe+0x58/0xb4)
 r10:c05a61d4 r9:00000000 r8:00000000 r7:fffffdfb r6:c061f3e4 r5:ffffffed
 r4:c05ed140
[<c02d1f18>] (platform_drv_probe) from [<c02d0380>] (driver_probe_device+0x258/0x33c)
 r7:c061f3e4 r6:00000000 r5:c06458d0 r4:c05ed140
[<c02d0128>] (driver_probe_device) from [<c02d0510>] (__driver_attach+0xac/0xb0)
 r9:00000000 r8:ffffe000 r7:c05e7008 r6:c05ed174 r5:c061f3e4 r4:c05ed140
[<c02d0464>] (__driver_attach) from [<c02ce384>] (bus_for_each_dev+0x78/0xbc)
 r7:c05e7008 r6:c02d0464 r5:c061f3e4 r4:00000000
[<c02ce30c>] (bus_for_each_dev) from [<c02cfcc4>] (driver_attach+0x20/0x28)
 r7:00000000 r6:c061b670 r5:c6ad7960 r4:c061f3e4
[<c02cfca4>] (driver_attach) from [<c02cf704>] (bus_add_driver+0x178/0x20c)
[<c02cf58c>] (bus_add_driver) from [<c02d0f00>] (driver_register+0x80/0xfc)
 r7:00000000 r6:c05c4a30 r5:c05e7008 r4:c061f3e4
[<c02d0e80>] (driver_register) from [<c02d1ebc>] (__platform_driver_register+0x34/0x48)
 r5:c05e7008 r4:c062ae60
[<c02d1e88>] (__platform_driver_register) from [<c05c4a48>] (davinci_mmcsd_driver_init+0x18/0x20)
[<c05c4a30>] (davinci_mmcsd_driver_init) from [<c000a56c>] (do_one_initcall+0x50/0x1a4)
[<c000a51c>] (do_one_initcall) from [<c05a8eb4>] (kernel_init_freeable+0x120/0x1e4)
 r8:c05a8614 r7:c05d4830 r6:00000007 r5:c062ae60 r4:c05e2ae8
[<c05a8d94>] (kernel_init_freeable) from [<c04940f4>] (kernel_init+0x10/0xfc)
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c04940e4
 r4:00000000
[<c04940e4>] (kernel_init) from [<c00090e0>] (ret_from_fork+0x14/0x34)
Exception stack(0xc6839fb0 to 0xc6839ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r5:c04940e4 r4:00000000
Division by zero in kernel.
CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc2-08642-g4dee494ef1ee #202
Hardware name: DaVinci DM355 EVM
Backtrace: 
[<c000dfa4>] (dump_backtrace) from [<c000e274>] (show_stack+0x18/0x1c)
 r7:00000000 r6:00000000 r5:fee11000 r4:c6acd400
[<c000e25c>] (show_stack) from [<c047eedc>] (dump_stack+0x20/0x28)
[<c047eebc>] (dump_stack) from [<c000e104>] (__div0+0x18/0x20)
[<c000e0ec>] (__div0) from [<c047d510>] (Ldiv0+0x8/0x10)
[<c0343e48>] (calculate_clk_divider) from [<c0344014>] (mmc_davinci_set_ios+0x58/0x168)
 r9:c6ac6b80 r8:c05ed140 r7:00000000 r6:00000001 r5:c6acd5e8 r4:c6acd400
[<c0343fbc>] (mmc_davinci_set_ios) from [<c033057c>] (mmc_power_up.part.8+0xf8/0x110)
 r5:c6acd5e8 r4:c6acd400
[<c0330484>] (mmc_power_up.part.8) from [<c033198c>] (mmc_start_host+0x94/0xa8)
 r7:0000001a r6:c05ed130 r5:00000000 r4:c6acd400
[<c03318f8>] (mmc_start_host) from [<c0332c5c>] (mmc_add_host+0x60/0x88)
 r5:00000000 r4:c6acd400
[<c0332bfc>] (mmc_add_host) from [<c0344630>] (davinci_mmcsd_probe+0x3f8/0x5dc)
 r5:c6acd754 r4:c6acd400
[<c0344238>] (davinci_mmcsd_probe) from [<c02d1f70>] (platform_drv_probe+0x58/0xb4)
 r10:c05a61d4 r9:00000000 r8:00000000 r7:fffffdfb r6:c061f3e4 r5:ffffffed
 r4:c05ed140
[<c02d1f18>] (platform_drv_probe) from [<c02d0380>] (driver_probe_device+0x258/0x33c)
 r7:c061f3e4 r6:00000000 r5:c06458d0 r4:c05ed140
[<c02d0128>] (driver_probe_device) from [<c02d0510>] (__driver_attach+0xac/0xb0)
 r9:00000000 r8:ffffe000 r7:c05e7008 r6:c05ed174 r5:c061f3e4 r4:c05ed140
[<c02d0464>] (__driver_attach) from [<c02ce384>] (bus_for_each_dev+0x78/0xbc)
 r7:c05e7008 r6:c02d0464 r5:c061f3e4 r4:00000000
[<c02ce30c>] (bus_for_each_dev) from [<c02cfcc4>] (driver_attach+0x20/0x28)
 r7:00000000 r6:c061b670 r5:c6ad7960 r4:c061f3e4
[<c02cfca4>] (driver_attach) from [<c02cf704>] (bus_add_driver+0x178/0x20c)
[<c02cf58c>] (bus_add_driver) from [<c02d0f00>] (driver_register+0x80/0xfc)
 r7:00000000 r6:c05c4a30 r5:c05e7008 r4:c061f3e4
[<c02d0e80>] (driver_register) from [<c02d1ebc>] (__platform_driver_register+0x34/0x48)
 r5:c05e7008 r4:c062ae60
[<c02d1e88>] (__platform_driver_register) from [<c05c4a48>] (davinci_mmcsd_driver_init+0x18/0x20)
[<c05c4a30>] (davinci_mmcsd_driver_init) from [<c000a56c>] (do_one_initcall+0x50/0x1a4)
[<c000a51c>] (do_one_initcall) from [<c05a8eb4>] (kernel_init_freeable+0x120/0x1e4)
 r8:c05a8614 r7:c05d4830 r6:00000007 r5:c062ae60 r4:c05e2ae8
[<c05a8d94>] (kernel_init_freeable) from [<c04940f4>] (kernel_init+0x10/0xfc)
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c04940e4
 r4:00000000
[<c04940e4>] (kernel_init) from [<c00090e0>] (ret_from_fork+0x14/0x34)
Exception stack(0xc6839fb0 to 0xc6839ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r5:c04940e4 r4:00000000
Division by zero in kernel.
CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 4.17.0-rc2-08642-g4dee494ef1ee #202
davinci_mmc dm6441-mmc.0: Using DMA, 4-bit mode
Division by zero in kernel.
Hardware name: DaVinci DM355 EVM
Workqueue: events_freezable mmc_rescan
Backtrace: 
[<c000dfa4>] (dump_backtrace) from [<c000e274>] (show_stack+0x18/0x1c)
CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc2-08642-g4dee494ef1ee #202
Hardware name: DaVinci DM355 EVM
Backtrace: 
[<c000dfa4>] (dump_backtrace) from [<c000e274>] (show_stack+0x18/0x1c)
 r7:00000000 r6:00000000 r5:fee11000 r4:c6acd400
[<c000e25c>] (show_stack) from [<c047eedc>] (dump_stack+0x20/0x28)
 r7:00000000 r6:00000000 r5:fee00000 r4:c6acd800
[<c000e25c>] (show_stack) from [<c047eedc>] (dump_stack+0x20/0x28)
[<c047eebc>] (dump_stack) from [<c000e104>] (__div0+0x18/0x20)
[<c047eebc>] (dump_stack) from [<c000e104>] (__div0+0x18/0x20)
[<c000e0ec>] (__div0) from [<c047d510>] (Ldiv0+0x8/0x10)
[<c000e0ec>] (__div0) from [<c047d510>] (Ldiv0+0x8/0x10)
[<c0343e48>] (calculate_clk_divider) from [<c0344014>] (mmc_davinci_set_ios+0x58/0x168)
[<c0343e48>] (calculate_clk_divider) from [<c0344014>] (mmc_davinci_set_ios+0x58/0x168)
 r9:00000000 r8:c05ff7b0 r7:60000013 r6:c6acd400 r5:c6acd5e8 r4:c6acd400
 r9:c6ac6d00 r8:c05ed2e0 r7:0000001b r6:00000001 r5:c6acd9e8 r4:c6acd800
[<c0343fbc>] (mmc_davinci_set_ios) from [<c0330480>] (mmc_set_initial_state+0x9c/0xa0)
[<c0343fbc>] (mmc_davinci_set_ios) from [<c0330480>] (mmc_set_initial_state+0x9c/0xa0)
 r5:c6acd5e8 r4:c6acd400
[<c03303e4>] (mmc_set_initial_state) from [<c03307ac>] (mmc_power_off.part.9+0x30/0x44)
 r5:c6acd9e8 r4:c6acd800
[<c03303e4>] (mmc_set_initial_state) from [<c03304bc>] (mmc_power_up.part.8+0x38/0x110)
 r5:00000000 r4:c6acd400
[<c033077c>] (mmc_power_off.part.9) from [<c03317b0>] (mmc_rescan+0x3b8/0x500)
 r5:00000015 r4:c6acd800
[<c0330484>] (mmc_power_up.part.8) from [<c033198c>] (mmc_start_host+0x94/0xa8)
 r5:00000000 r4:c6acd640
[<c03313f8>] (mmc_rescan) from [<c0031de0>] (process_one_work+0x1d8/0x41c)
 r7:0000001b r6:c05ed2d0 r5:00000000 r4:c6acd800
[<c03318f8>] (mmc_start_host) from [<c0332c5c>] (mmc_add_host+0x60/0x88)
 r9:00000000 r8:c05ff7b0 r7:00000000 r6:c7ee9500 r5:c68156c0 r4:c6acd640
[<c0031c08>] (process_one_work) from [<c0032060>] (worker_thread+0x3c/0x670)
 r10:00000008 r9:c05ff7c4 r8:c060f080 r7:c68156d8 r6:ffffe000 r5:c05ff7b0
 r5:00000000 r4:c6acd800
[<c0332bfc>] (mmc_add_host) from [<c0344630>] (davinci_mmcsd_probe+0x3f8/0x5dc)
 r5:c6acdb54 r4:c6acd800
[<c0344238>] (davinci_mmcsd_probe) from [<c02d1f70>] (platform_drv_probe+0x58/0xb4)
 r4:c68156c0
[<c0032024>] (worker_thread) from [<c0038280>] (kthread+0x134/0x14c)
 r10:c05a61d4 r9:00000000 r8:00000000 r7:fffffdfb r6:c061f3e4 r5:ffffffed
 r4:c05ed2e0
 r10:c6847e90 r9:c0032024 r8:c68156c0 r7:c6878000 r6:00000000 r5:c680dee0
 r4:c6868300
[<c003814c>] (kthread) from [<c00090e0>] (ret_from_fork+0x14/0x34)
[<c02d1f18>] (platform_drv_probe) from [<c02d0380>] (driver_probe_device+0x258/0x33c)
Exception stack(0xc6879fb0 to 0xc6879ff8)
9fa0:                                     00000000 00000000 00000000 00000000
 r7:c061f3e4 r6:00000000 r5:c06458d0 r4:c05ed2e0
[<c02d0128>] (driver_probe_device) from [<c02d0510>] (__driver_attach+0xac/0xb0)
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
 r9:00000000 r8:ffffe000 r7:c05e7008 r6:c05ed314 r5:c061f3e4 r4:c05ed2e0
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c003814c
[<c02d0464>] (__driver_attach) from [<c02ce384>] (bus_for_each_dev+0x78/0xbc)
 r7:c05e7008 r6:c02d0464 r5:c061f3e4 r4:00000000
 r4:c680dee0
[<c02ce30c>] (bus_for_each_dev) from [<c02cfcc4>] (driver_attach+0x20/0x28)
 r7:00000000 r6:c061b670 r5:c6ad7960 r4:c061f3e4
[<c02cfca4>] (driver_attach) from [<c02cf704>] (bus_add_driver+0x178/0x20c)
[<c02cf58c>] (bus_add_driver) from [<c02d0f00>] (driver_register+0x80/0xfc)
 r7:00000000 r6:c05c4a30 r5:c05e7008 r4:c061f3e4
[<c02d0e80>] (driver_register) from [<c02d1ebc>] (__platform_driver_register+0x34/0x48)
 r5:c05e7008 r4:c062ae60
[<c02d1e88>] (__platform_driver_register) from [<c05c4a48>] (davinci_mmcsd_driver_init+0x18/0x20)
[<c05c4a30>] (davinci_mmcsd_driver_init) from [<c000a56c>] (do_one_initcall+0x50/0x1a4)
[<c000a51c>] (do_one_initcall) from [<c05a8eb4>] (kernel_init_freeable+0x120/0x1e4)
 r8:c05a8614 r7:c05d4830 r6:00000007 r5:c062ae60 r4:c05e2ae8
[<c05a8d94>] (kernel_init_freeable) from [<c04940f4>] (kernel_init+0x10/0xfc)
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c04940e4
random: fast init done
 r4:00000000
[<c04940e4>] (kernel_init) from [<c00090e0>] (ret_from_fork+0x14/0x34)
Exception stack(0xc6839fb0 to 0xc6839ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r5:c04940e4 r4:00000000
Division by zero in kernel.
CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc2-08642-g4dee494ef1ee #202
Hardware name: DaVinci DM355 EVM
Backtrace: 
[<c000dfa4>] (dump_backtrace) from [<c000e274>] (show_stack+0x18/0x1c)
 r7:00000000 r6:00000000 r5:fee00000 r4:c6acd800
[<c000e25c>] (show_stack) from [<c047eedc>] (dump_stack+0x20/0x28)
[<c047eebc>] (dump_stack) from [<c000e104>] (__div0+0x18/0x20)
[<c000e0ec>] (__div0) from [<c047d510>] (Ldiv0+0x8/0x10)
[<c0343e48>] (calculate_clk_divider) from [<c0344014>] (mmc_davinci_set_ios+0x58/0x168)
 r9:c6ac6d00 r8:c05ed2e0 r7:00000000 r6:00000001 r5:c6acd9e8 r4:c6acd800
[<c0343fbc>] (mmc_davinci_set_ios) from [<c033057c>] (mmc_power_up.part.8+0xf8/0x110)
 r5:c6acd9e8 r4:c6acd800
[<c0330484>] (mmc_power_up.part.8) from [<c033198c>] (mmc_start_host+0x94/0xa8)
 r7:0000001b r6:c05ed2d0 r5:00000000 r4:c6acd800
[<c03318f8>] (mmc_start_host) from [<c0332c5c>] (mmc_add_host+0x60/0x88)
 r5:00000000 r4:c6acd800
[<c0332bfc>] (mmc_add_host) from [<c0344630>] (davinci_mmcsd_probe+0x3f8/0x5dc)
 r5:c6acdb54 r4:c6acd800
[<c0344238>] (davinci_mmcsd_probe) from [<c02d1f70>] (platform_drv_probe+0x58/0xb4)
 r10:c05a61d4 r9:00000000 r8:00000000 r7:fffffdfb r6:c061f3e4 r5:ffffffed
 r4:c05ed2e0
[<c02d1f18>] (platform_drv_probe) from [<c02d0380>] (driver_probe_device+0x258/0x33c)
 r7:c061f3e4 r6:00000000 r5:c06458d0 r4:c05ed2e0
[<c02d0128>] (driver_probe_device) from [<c02d0510>] (__driver_attach+0xac/0xb0)
 r9:00000000 r8:ffffe000 r7:c05e7008 r6:c05ed314 r5:c061f3e4 r4:c05ed2e0
[<c02d0464>] (__driver_attach) from [<c02ce384>] (bus_for_each_dev+0x78/0xbc)
 r7:c05e7008 r6:c02d0464 r5:c061f3e4 r4:00000000
[<c02ce30c>] (bus_for_each_dev) from [<c02cfcc4>] (driver_attach+0x20/0x28)
 r7:00000000 r6:c061b670 r5:c6ad7960 r4:c061f3e4
[<c02cfca4>] (driver_attach) from [<c02cf704>] (bus_add_driver+0x178/0x20c)
[<c02cf58c>] (bus_add_driver) from [<c02d0f00>] (driver_register+0x80/0xfc)
 r7:00000000 r6:c05c4a30 r5:c05e7008 r4:c061f3e4
[<c02d0e80>] (driver_register) from [<c02d1ebc>] (__platform_driver_register+0x34/0x48)
 r5:c05e7008 r4:c062ae60
[<c02d1e88>] (__platform_driver_register) from [<c05c4a48>] (davinci_mmcsd_driver_init+0x18/0x20)
[<c05c4a30>] (davinci_mmcsd_driver_init) from [<c000a56c>] (do_one_initcall+0x50/0x1a4)
[<c000a51c>] (do_one_initcall) from [<c05a8eb4>] (kernel_init_freeable+0x120/0x1e4)
 r8:c05a8614 r7:c05d4830 r6:00000007 r5:c062ae60 r4:c05e2ae8
[<c05a8d94>] (kernel_init_freeable) from [<c04940f4>] (kernel_init+0x10/0xfc)
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c04940e4
 r4:00000000
[<c04940e4>] (kernel_init) from [<c00090e0>] (ret_from_fork+0x14/0x34)
Exception stack(0xc6839fb0 to 0xc6839ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r5:c04940e4 r4:00000000
Division by zero in kernel.
CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 4.17.0-rc2-08642-g4dee494ef1ee #202
davinci_mmc dm6441-mmc.1: Using DMA, 4-bit mode
NET: Registered protocol family 10
Hardware name: DaVinci DM355 EVM
Workqueue: events_freezable mmc_rescan
Backtrace: 
[<c000dfa4>] (dump_backtrace) from [<c000e274>] (show_stack+0x18/0x1c)
 r7:00000000 r6:00000000 r5:fee00000 r4:c6acd800
[<c000e25c>] (show_stack) from [<c047eedc>] (dump_stack+0x20/0x28)
Segment Routing with IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
NET: Registered protocol family 17
[<c047eebc>] (dump_stack) from [<c000e104>] (__div0+0x18/0x20)
[<c000e0ec>] (__div0) from [<c047d510>] (Ldiv0+0x8/0x10)
[<c0343e48>] (calculate_clk_divider) from [<c0344014>] (mmc_davinci_set_ios+0x58/0x168)
 r9:00000000 r8:c05ff7b0 r7:60000013 r6:c6acd800 r5:c6acd9e8 r4:c6acd800
[<c0343fbc>] (mmc_davinci_set_ios) from [<c0330480>] (mmc_set_initial_state+0x9c/0xa0)
 r5:c6acd9e8 r4:c6acd800
[<c03303e4>] (mmc_set_initial_state) from [<c03307ac>] (mmc_power_off.part.9+0x30/0x44)
 r5:00000000 r4:c6acd800
[<c033077c>] (mmc_power_off.part.9) from [<c03317b0>] (mmc_rescan+0x3b8/0x500)
 r5:00000000 r4:c6acda40
[<c03313f8>] (mmc_rescan) from [<c0031de0>] (process_one_work+0x1d8/0x41c)
 r9:00000000 r8:c05ff7b0 r7:00000000 r6:c7ee9500 r5:c68156c0 r4:c6acda40
[<c0031c08>] (process_one_work) from [<c0032060>] (worker_thread+0x3c/0x670)
 r10:00000008 r9:c05ff7c4 r8:c060f080 r7:c68156d8 r6:ffffe000 r5:c05ff7b0
 r4:c68156c0
[<c0032024>] (worker_thread) from [<c0038280>] (kthread+0x134/0x14c)
 r10:c6847e90 r9:c0032024 r8:c68156c0 r7:c6878000 r6:00000000 r5:c680dee0
 r4:c6868300
[<c003814c>] (kthread) from [<c00090e0>] (ret_from_fork+0x14/0x34)
Exception stack(0xc6879fb0 to 0xc6879ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c003814c
 r4:c680dee0
console [netcon0] enabled
netconsole: network logging started
hctosys: unable to open rtc device (rtc0)
dm9000 dm9000 eth0: link down
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Sending DHCP requests .
dm9000 dm9000 eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
, OK
IP-Config: Got DHCP answer from 172.24.188.3, my address is 172.24.190.9
IP-Config: Complete:
     device=eth0, hwaddr=00:0e:99:02:cb:91, ipaddr=172.24.190.9, mask=255.255.252.0, gw=172.24.188.1
     host=172.24.190.9, domain=india.ti.com, nis-domain=(none)
     bootserver=0.0.0.0, rootserver=172.24.210.141, rootpath=     nameserver0=192.0.2.2, nameserver1=192.0.2.3
 this is MT29F16G08FAA device 
