Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC35BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27AB2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="GZ1DtDa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfBYEDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 23:03:00 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:24667 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfBYEDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 23:03:00 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4477Xw38fPz2w;
        Mon, 25 Feb 2019 05:01:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1551067284; bh=d3+otzaSkqNdPG8Af8DAyxHNMZkMKeutEKvztM0fwLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GZ1DtDa+fJXFKou5VbEOgT6XxXnD05t9Lj8o1npS1ugCuhvPHqQLfwjOrF5PnAvbr
         YejU5zrMSfqlUqnx8DC2418EyGmEAl73iLctgIi0JxvMffsf9qayuLQtOiHLneVvsr
         wrDJv/KygEQM8A9b/+RcaWqodvSXmE7Hyn7X+Vhz5avymTJ1G2nQVJbV9lxg9aDSjm
         D1x/klw4rMs93HXXWDtWQ1Ym5dj8BM+6t/avc1ZyKtFME3vApkAoT7JsuQJefx7TMK
         I1hN4Rlf8ukp0Nbb+qbp3USbPpNrbgOZaXI3annZfohStLXAymVBeVwRJFozQwCRKM
         qUFEQ5CWtGE8w==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date:   Mon, 25 Feb 2019 05:02:33 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Support Trusted Foundations firmware on Tegra30
Message-ID: <20190225040232.GA2242@qmqm.qmqm.pl>
References: <20190222193426.10747-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190222193426.10747-1-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Feb 22, 2019 at 10:34:19PM +0300, Dmitry Osipenko wrote:
> Hello,
> 
> This patchset adds support for the Trusted Foundations firmware on
> NVIDIA Tegra30. Pretty much all of Tegra30 consumer devices have that
> firmware and upstream kernel can't boot on those devices without the
> firmware support.

Hi Dmitry

I've applied and tested this patchset on my TF300T. Boots and suspends/wakes
using 'rtcwake -m mem -s 1 -d /dev/rtc1' as the test. dmesg attached.

The exact tree used:
	git://rere.qmqm.pl/linux tf300t

Feel free to add my Tested-by and Signed-off-by on the patches where
apropriate, and thanks for your work!

Best Regards,
Micha³ Miros³aw

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tf300t.dmesg"

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.0.0-rc8mq-00034-g83dcf8d77845 (mirq@qmqm) (gcc version 8.2.0 (Debian 8.2.0-20)) #16 SMP Mon Feb 25 04:45:43 CET 2019
[    0.000000] CPU: ARMv7 Processor [412fc099] revision 9 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: Asus Transformer Pad TF300T
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 32 MiB at 0xbbc00000
[    0.000000] before early_ioremap_reset()
[    0.000000] after early_ioremap_reset()
[    0.000000] debug_ll_io_init() start
[    0.000000] debug_ll_io_init() done
[    0.000000] On node 0 totalpages: 261632
[    0.000000]   Normal zone: 2300 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 261632 pages, LIFO batch:63
[    0.000000] after paging_init()
[    0.000000] TF: version 2.8, protocol 6.0
[    0.000000] random: get_random_bytes called from start_kernel+0x90/0x478 with crng_init=0
[    0.000000] percpu: Embedded 17 pages/cpu @(ptrval) s37544 r8192 d23896 u69632
[    0.000000] pcpu-alloc: s37544 r8192 d23896 u69632 alloc=17*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 259332
[    0.000000] Kernel command line: clk_ignore_unused=1 console=tty0 console=ttyGS0 tegra_wdt.heartbeat=30 androidboot.serialno=015d15b4da27f206 no_console_suspend=1 gpt zswap.enabled=1
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 973756K/1046528K available (6144K kernel code, 536K rwdata, 2156K rodata, 1024K init, 9165K bss, 40004K reserved, 32768K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff800000   ( 248 MB)
[    0.000000]     lowmem  : 0xb0000000 - 0xefe00000   (1022 MB)
[    0.000000]     modules : 0xaf000000 - 0xb0000000   (  16 MB)
[    0.000000]       .text : 0x(ptrval) - 0x(ptrval)   (7136 kB)
[    0.000000]       .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
[    0.000000]       .data : 0x(ptrval) - 0x(ptrval)   ( 537 kB)
[    0.000000]        .bss : 0x(ptrval) - 0x(ptrval)   (9166 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] ftrace: allocating 21925 entries in 43 pages
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] /interrupt-controller@60004000: 160 interrupts forwarded to /interrupt-controller@50041000
[    0.000000] L2C: DT/platform modifies aux control register: 0x2c080000 -> 0x3c480001
[    0.000000] L2C-310 erratum 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310: enabling full line of zeros but not enabled in Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 1 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 8 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x7e080001
[    0.000008] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 2147483647500ns
[    0.000028] clocksource: timer_us: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
[    0.000058] Switching to timer-based delay loop, resolution 1000ns
[    0.000659] Console: colour dummy device 80x30
[    0.002601] printk: console [tty0] enabled
[    0.002634] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.002686] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.002718] ... MAX_LOCK_DEPTH:          48
[    0.002750] ... MAX_LOCKDEP_KEYS:        8191
[    0.002783] ... CLASSHASH_SIZE:          4096
[    0.002815] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.002847] ... MAX_LOCKDEP_CHAINS:      65536
[    0.002880] ... CHAINHASH_SIZE:          32768
[    0.002912]  memory used by lock dependency info: 4575 kB
[    0.002950]  per task-struct memory footprint: 1536 bytes
[    0.003025] Calibrating delay loop (skipped), value calculated using timer frequency.. 2.00 BogoMIPS (lpj=10000)
[    0.003097] pid_max: default: 32768 minimum: 301
[    0.003360] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.003417] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.004991] CPU: Testing write buffer coherency: ok
[    0.005096] CPU0: Spectre v2: using BPIALL workaround
[    0.005765] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.006868] Setting up static identity map for 0x80100000 - 0x801000ac
[    0.007157] rcu: Hierarchical SRCU implementation.
[    0.008719] Tegra Revision: A03 SKU: 131 CPU Process: 2 SoC Process: 0
[    0.010565] smp: Bringing up secondary CPUs ...
[    0.011837] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.011845] CPU1: Spectre v2: using BPIALL workaround
[    0.013371] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.013379] CPU2: Spectre v2: using BPIALL workaround
[    0.014763] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.014770] CPU3: Spectre v2: using BPIALL workaround
[    0.015066] smp: Brought up 1 node, 4 CPUs
[    0.015106] SMP: Total of 4 processors activated (8.00 BogoMIPS).
[    0.015149] CPU: All CPU(s) started in SVC mode.
[    0.016524] devtmpfs: initialized
[    0.031231] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.031779] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.031864] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.034014] pinctrl core: initialized pinctrl subsystem
[    0.034820] reg-dummy reg-dummy: no of_node; not parsing pinctrl DT
[    0.035022] regulator-dummy: no parameters
[    0.036115] NET: Registered protocol family 16
[    0.040329] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.041050] audit: initializing netlink subsys (disabled)
[    0.041393] audit: type=2000 audit(0.040:1): state=initialized audit_enabled=0 res=1
[    0.042327] cpuidle: using governor ladder
[    0.042448] cpuidle: using governor menu
[    0.062722] No ATAGs?
[    0.062919] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    0.063010] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.063821] tegra30-pinctrl 70000868.pinmux: try to register 260 pins ...
[    0.063878] pinctrl core: registered pin 0 (CLK_32K_OUT PA0) on 70000868.pinmux
[    0.063934] pinctrl core: registered pin 1 (UART3_CTS_N PA1) on 70000868.pinmux
[    0.063988] pinctrl core: registered pin 2 (DAP2_FS PA2) on 70000868.pinmux
[    0.064038] pinctrl core: registered pin 3 (DAP2_SCLK PA3) on 70000868.pinmux
[    0.064087] pinctrl core: registered pin 4 (DAP2_DIN PA4) on 70000868.pinmux
[    0.064137] pinctrl core: registered pin 5 (DAP2_DOUT PA5) on 70000868.pinmux
[    0.064187] pinctrl core: registered pin 6 (SDMMC3_CLK PA6) on 70000868.pinmux
[    0.064239] pinctrl core: registered pin 7 (SDMMC3_CMD PA7) on 70000868.pinmux
[    0.064292] pinctrl core: registered pin 8 (GMI_A17 PB0) on 70000868.pinmux
[    0.064341] pinctrl core: registered pin 9 (GMI_A18 PB1) on 70000868.pinmux
[    0.064390] pinctrl core: registered pin 10 (LCD_PWR0 PB2) on 70000868.pinmux
[    0.064439] pinctrl core: registered pin 11 (LCD_PCLK PB3) on 70000868.pinmux
[    0.064489] pinctrl core: registered pin 12 (SDMMC3_DAT3 PB4) on 70000868.pinmux
[    0.064542] pinctrl core: registered pin 13 (SDMMC3_DAT2 PB5) on 70000868.pinmux
[    0.064595] pinctrl core: registered pin 14 (SDMMC3_DAT1 PB6) on 70000868.pinmux
[    0.064648] pinctrl core: registered pin 15 (SDMMC3_DAT0 PB7) on 70000868.pinmux
[    0.064701] pinctrl core: registered pin 16 (UART3_RTS_N PC0) on 70000868.pinmux
[    0.064755] pinctrl core: registered pin 17 (LCD_PWR1 PC1) on 70000868.pinmux
[    0.064805] pinctrl core: registered pin 18 (UART2_TXD PC2) on 70000868.pinmux
[    0.064857] pinctrl core: registered pin 19 (UART2_RXD PC3) on 70000868.pinmux
[    0.064910] pinctrl core: registered pin 20 (GEN1_I2C_SCL PC4) on 70000868.pinmux
[    0.064964] pinctrl core: registered pin 21 (GEN1_I2C_SDA PC5) on 70000868.pinmux
[    0.065018] pinctrl core: registered pin 22 (LCD_PWR2 PC6) on 70000868.pinmux
[    0.065067] pinctrl core: registered pin 23 (GMI_WP_N PC7) on 70000868.pinmux
[    0.065117] pinctrl core: registered pin 24 (SDMMC3_DAT5 PD0) on 70000868.pinmux
[    0.065170] pinctrl core: registered pin 25 (SDMMC3_DAT4 PD1) on 70000868.pinmux
[    0.065223] pinctrl core: registered pin 26 (LCD_DC1 PD2) on 70000868.pinmux
[    0.065272] pinctrl core: registered pin 27 (SDMMC3_DAT6 PD3) on 70000868.pinmux
[    0.065325] pinctrl core: registered pin 28 (SDMMC3_DAT7 PD4) on 70000868.pinmux
[    0.065379] pinctrl core: registered pin 29 (VI_D1 PD5) on 70000868.pinmux
[    0.065427] pinctrl core: registered pin 30 (VI_VSYNC PD6) on 70000868.pinmux
[    0.065477] pinctrl core: registered pin 31 (VI_HSYNC PD7) on 70000868.pinmux
[    0.065526] pinctrl core: registered pin 32 (LCD_D0 PE0) on 70000868.pinmux
[    0.065575] pinctrl core: registered pin 33 (LCD_D1 PE1) on 70000868.pinmux
[    0.065623] pinctrl core: registered pin 34 (LCD_D2 PE2) on 70000868.pinmux
[    0.065672] pinctrl core: registered pin 35 (LCD_D3 PE3) on 70000868.pinmux
[    0.065720] pinctrl core: registered pin 36 (LCD_D4 PE4) on 70000868.pinmux
[    0.065769] pinctrl core: registered pin 37 (LCD_D5 PE5) on 70000868.pinmux
[    0.065817] pinctrl core: registered pin 38 (LCD_D6 PE6) on 70000868.pinmux
[    0.065866] pinctrl core: registered pin 39 (LCD_D7 PE7) on 70000868.pinmux
[    0.065914] pinctrl core: registered pin 40 (LCD_D8 PF0) on 70000868.pinmux
[    0.065962] pinctrl core: registered pin 41 (LCD_D9 PF1) on 70000868.pinmux
[    0.066011] pinctrl core: registered pin 42 (LCD_D10 PF2) on 70000868.pinmux
[    0.066060] pinctrl core: registered pin 43 (LCD_D11 PF3) on 70000868.pinmux
[    0.066109] pinctrl core: registered pin 44 (LCD_D12 PF4) on 70000868.pinmux
[    0.066158] pinctrl core: registered pin 45 (LCD_D13 PF5) on 70000868.pinmux
[    0.066207] pinctrl core: registered pin 46 (LCD_D14 PF6) on 70000868.pinmux
[    0.066256] pinctrl core: registered pin 47 (LCD_D15 PF7) on 70000868.pinmux
[    0.066305] pinctrl core: registered pin 48 (GMI_AD0 PG0) on 70000868.pinmux
[    0.066354] pinctrl core: registered pin 49 (GMI_AD1 PG1) on 70000868.pinmux
[    0.066403] pinctrl core: registered pin 50 (GMI_AD2 PG2) on 70000868.pinmux
[    0.066452] pinctrl core: registered pin 51 (GMI_AD3 PG3) on 70000868.pinmux
[    0.066515] pinctrl core: registered pin 52 (GMI_AD4 PG4) on 70000868.pinmux
[    0.066566] pinctrl core: registered pin 53 (GMI_AD5 PG5) on 70000868.pinmux
[    0.066615] pinctrl core: registered pin 54 (GMI_AD6 PG6) on 70000868.pinmux
[    0.066664] pinctrl core: registered pin 55 (GMI_AD7 PG7) on 70000868.pinmux
[    0.066712] pinctrl core: registered pin 56 (GMI_AD8 PH0) on 70000868.pinmux
[    0.066761] pinctrl core: registered pin 57 (GMI_AD9 PH1) on 70000868.pinmux
[    0.066810] pinctrl core: registered pin 58 (GMI_AD10 PH2) on 70000868.pinmux
[    0.066860] pinctrl core: registered pin 59 (GMI_AD11 PH3) on 70000868.pinmux
[    0.066909] pinctrl core: registered pin 60 (GMI_AD12 PH4) on 70000868.pinmux
[    0.066959] pinctrl core: registered pin 61 (GMI_AD13 PH5) on 70000868.pinmux
[    0.067008] pinctrl core: registered pin 62 (GMI_AD14 PH6) on 70000868.pinmux
[    0.067058] pinctrl core: registered pin 63 (GMI_AD15 PH7) on 70000868.pinmux
[    0.067110] pinctrl core: registered pin 64 (GMI_WR_N PI0) on 70000868.pinmux
[    0.067159] pinctrl core: registered pin 65 (GMI_OE_N PI1) on 70000868.pinmux
[    0.067209] pinctrl core: registered pin 66 (GMI_DQS PI2) on 70000868.pinmux
[    0.067258] pinctrl core: registered pin 67 (GMI_CS6_N PI3) on 70000868.pinmux
[    0.067310] pinctrl core: registered pin 68 (GMI_RST_N PI4) on 70000868.pinmux
[    0.067363] pinctrl core: registered pin 69 (GMI_IORDY PI5) on 70000868.pinmux
[    0.067415] pinctrl core: registered pin 70 (GMI_CS7_N PI6) on 70000868.pinmux
[    0.067468] pinctrl core: registered pin 71 (GMI_WAIT PI7) on 70000868.pinmux
[    0.067518] pinctrl core: registered pin 72 (GMI_CS0_N PJ0) on 70000868.pinmux
[    0.067570] pinctrl core: registered pin 73 (LCD_DE PJ1) on 70000868.pinmux
[    0.067619] pinctrl core: registered pin 74 (GMI_CS1_N PJ2) on 70000868.pinmux
[    0.067672] pinctrl core: registered pin 75 (LCD_HSYNC PJ3) on 70000868.pinmux
[    0.067724] pinctrl core: registered pin 76 (LCD_VSYNC PJ4) on 70000868.pinmux
[    0.067777] pinctrl core: registered pin 77 (UART2_CTS_N PJ5) on 70000868.pinmux
[    0.067830] pinctrl core: registered pin 78 (UART2_RTS_N PJ6) on 70000868.pinmux
[    0.067883] pinctrl core: registered pin 79 (GMI_A16 PJ7) on 70000868.pinmux
[    0.067933] pinctrl core: registered pin 80 (GMI_ADV_N PK0) on 70000868.pinmux
[    0.067985] pinctrl core: registered pin 81 (GMI_CLK PK1) on 70000868.pinmux
[    0.068034] pinctrl core: registered pin 82 (GMI_CS4_N PK2) on 70000868.pinmux
[    0.068087] pinctrl core: registered pin 83 (GMI_CS2_N PK3) on 70000868.pinmux
[    0.068139] pinctrl core: registered pin 84 (GMI_CS3_N PK4) on 70000868.pinmux
[    0.068192] pinctrl core: registered pin 85 (SPDIF_OUT PK5) on 70000868.pinmux
[    0.068244] pinctrl core: registered pin 86 (SPDIF_IN PK6) on 70000868.pinmux
[    0.068294] pinctrl core: registered pin 87 (GMI_A19 PK7) on 70000868.pinmux
[    0.068343] pinctrl core: registered pin 88 (VI_D2 PL0) on 70000868.pinmux
[    0.068391] pinctrl core: registered pin 89 (VI_D3 PL1) on 70000868.pinmux
[    0.068439] pinctrl core: registered pin 90 (VI_D4 PL2) on 70000868.pinmux
[    0.068488] pinctrl core: registered pin 91 (VI_D5 PL3) on 70000868.pinmux
[    0.068536] pinctrl core: registered pin 92 (VI_D6 PL4) on 70000868.pinmux
[    0.068585] pinctrl core: registered pin 93 (VI_D7 PL5) on 70000868.pinmux
[    0.068633] pinctrl core: registered pin 94 (VI_D8 PL6) on 70000868.pinmux
[    0.068681] pinctrl core: registered pin 95 (VI_D9 PL7) on 70000868.pinmux
[    0.068730] pinctrl core: registered pin 96 (LCD_D16 PM0) on 70000868.pinmux
[    0.068779] pinctrl core: registered pin 97 (LCD_D17 PM1) on 70000868.pinmux
[    0.068828] pinctrl core: registered pin 98 (LCD_D18 PM2) on 70000868.pinmux
[    0.068876] pinctrl core: registered pin 99 (LCD_D19 PM3) on 70000868.pinmux
[    0.068925] pinctrl core: registered pin 100 (LCD_D20 PM4) on 70000868.pinmux
[    0.068975] pinctrl core: registered pin 101 (LCD_D21 PM5) on 70000868.pinmux
[    0.069025] pinctrl core: registered pin 102 (LCD_D22 PM6) on 70000868.pinmux
[    0.069075] pinctrl core: registered pin 103 (LCD_D23 PM7) on 70000868.pinmux
[    0.069124] pinctrl core: registered pin 104 (DAP1_FS PN0) on 70000868.pinmux
[    0.069173] pinctrl core: registered pin 105 (DAP1_DIN PN1) on 70000868.pinmux
[    0.069226] pinctrl core: registered pin 106 (DAP1_DOUT PN2) on 70000868.pinmux
[    0.069279] pinctrl core: registered pin 107 (DAP1_SCLK PN3) on 70000868.pinmux
[    0.069332] pinctrl core: registered pin 108 (LCD_CS0_N PN4) on 70000868.pinmux
[    0.069385] pinctrl core: registered pin 109 (LCD_SDOUT PN5) on 70000868.pinmux
[    0.069437] pinctrl core: registered pin 110 (LCD_DC0 PN6) on 70000868.pinmux
[    0.069487] pinctrl core: registered pin 111 (HDMI_INT PN7) on 70000868.pinmux
[    0.069539] pinctrl core: registered pin 112 (ULPI_DATA7 PO0) on 70000868.pinmux
[    0.069593] pinctrl core: registered pin 113 (ULPI_DATA0 PO1) on 70000868.pinmux
[    0.069646] pinctrl core: registered pin 114 (ULPI_DATA1 PO2) on 70000868.pinmux
[    0.069699] pinctrl core: registered pin 115 (ULPI_DATA2 PO3) on 70000868.pinmux
[    0.069763] pinctrl core: registered pin 116 (ULPI_DATA3 PO4) on 70000868.pinmux
[    0.069817] pinctrl core: registered pin 117 (ULPI_DATA4 PO5) on 70000868.pinmux
[    0.069870] pinctrl core: registered pin 118 (ULPI_DATA5 PO6) on 70000868.pinmux
[    0.069924] pinctrl core: registered pin 119 (ULPI_DATA6 PO7) on 70000868.pinmux
[    0.070032] pinctrl core: registered pin 120 (DAP3_FS PP0) on 70000868.pinmux
[    0.070082] pinctrl core: registered pin 121 (DAP3_DIN PP1) on 70000868.pinmux
[    0.070136] pinctrl core: registered pin 122 (DAP3_DOUT PP2) on 70000868.pinmux
[    0.070190] pinctrl core: registered pin 123 (DAP3_SCLK PP3) on 70000868.pinmux
[    0.070243] pinctrl core: registered pin 124 (DAP4_FS PP4) on 70000868.pinmux
[    0.070293] pinctrl core: registered pin 125 (DAP4_DIN PP5) on 70000868.pinmux
[    0.070346] pinctrl core: registered pin 126 (DAP4_DOUT PP6) on 70000868.pinmux
[    0.070398] pinctrl core: registered pin 127 (DAP4_SCLK PP7) on 70000868.pinmux
[    0.070453] pinctrl core: registered pin 128 (KB_COL0 PQ0) on 70000868.pinmux
[    0.070502] pinctrl core: registered pin 129 (KB_COL1 PQ1) on 70000868.pinmux
[    0.070552] pinctrl core: registered pin 130 (KB_COL2 PQ2) on 70000868.pinmux
[    0.070601] pinctrl core: registered pin 131 (KB_COL3 PQ3) on 70000868.pinmux
[    0.070651] pinctrl core: registered pin 132 (KB_COL4 PQ4) on 70000868.pinmux
[    0.070700] pinctrl core: registered pin 133 (KB_COL5 PQ5) on 70000868.pinmux
[    0.070750] pinctrl core: registered pin 134 (KB_COL6 PQ6) on 70000868.pinmux
[    0.070799] pinctrl core: registered pin 135 (KB_COL7 PQ7) on 70000868.pinmux
[    0.070849] pinctrl core: registered pin 136 (KB_ROW0 PR0) on 70000868.pinmux
[    0.070898] pinctrl core: registered pin 137 (KB_ROW1 PR1) on 70000868.pinmux
[    0.070948] pinctrl core: registered pin 138 (KB_ROW2 PR2) on 70000868.pinmux
[    0.070997] pinctrl core: registered pin 139 (KB_ROW3 PR3) on 70000868.pinmux
[    0.071047] pinctrl core: registered pin 140 (KB_ROW4 PR4) on 70000868.pinmux
[    0.071096] pinctrl core: registered pin 141 (KB_ROW5 PR5) on 70000868.pinmux
[    0.071146] pinctrl core: registered pin 142 (KB_ROW6 PR6) on 70000868.pinmux
[    0.071195] pinctrl core: registered pin 143 (KB_ROW7 PR7) on 70000868.pinmux
[    0.071245] pinctrl core: registered pin 144 (KB_ROW8 PS0) on 70000868.pinmux
[    0.071294] pinctrl core: registered pin 145 (KB_ROW9 PS1) on 70000868.pinmux
[    0.071344] pinctrl core: registered pin 146 (KB_ROW10 PS2) on 70000868.pinmux
[    0.071397] pinctrl core: registered pin 147 (KB_ROW11 PS3) on 70000868.pinmux
[    0.071449] pinctrl core: registered pin 148 (KB_ROW12 PS4) on 70000868.pinmux
[    0.071502] pinctrl core: registered pin 149 (KB_ROW13 PS5) on 70000868.pinmux
[    0.071554] pinctrl core: registered pin 150 (KB_ROW14 PS6) on 70000868.pinmux
[    0.071607] pinctrl core: registered pin 151 (KB_ROW15 PS7) on 70000868.pinmux
[    0.071659] pinctrl core: registered pin 152 (VI_PCLK PT0) on 70000868.pinmux
[    0.071709] pinctrl core: registered pin 153 (VI_MCLK PT1) on 70000868.pinmux
[    0.071758] pinctrl core: registered pin 154 (VI_D10 PT2) on 70000868.pinmux
[    0.071807] pinctrl core: registered pin 155 (VI_D11 PT3) on 70000868.pinmux
[    0.071856] pinctrl core: registered pin 156 (VI_D0 PT4) on 70000868.pinmux
[    0.071905] pinctrl core: registered pin 157 (GEN2_I2C_SCL PT5) on 70000868.pinmux
[    0.071959] pinctrl core: registered pin 158 (GEN2_I2C_SDA PT6) on 70000868.pinmux
[    0.072014] pinctrl core: registered pin 159 (SDMMC4_CMD PT7) on 70000868.pinmux
[    0.072067] pinctrl core: registered pin 160 (PU0) on 70000868.pinmux
[    0.072113] pinctrl core: registered pin 161 (PU1) on 70000868.pinmux
[    0.072159] pinctrl core: registered pin 162 (PU2) on 70000868.pinmux
[    0.072205] pinctrl core: registered pin 163 (PU3) on 70000868.pinmux
[    0.072252] pinctrl core: registered pin 164 (PU4) on 70000868.pinmux
[    0.072298] pinctrl core: registered pin 165 (PU5) on 70000868.pinmux
[    0.072343] pinctrl core: registered pin 166 (PU6) on 70000868.pinmux
[    0.072389] pinctrl core: registered pin 167 (JTAG_RTCK PU7) on 70000868.pinmux
[    0.072442] pinctrl core: registered pin 168 (PV0) on 70000868.pinmux
[    0.072488] pinctrl core: registered pin 169 (PV1) on 70000868.pinmux
[    0.072534] pinctrl core: registered pin 170 (PV2) on 70000868.pinmux
[    0.072580] pinctrl core: registered pin 171 (PV3) on 70000868.pinmux
[    0.072626] pinctrl core: registered pin 172 (DDC_SCL PV4) on 70000868.pinmux
[    0.072676] pinctrl core: registered pin 173 (DDC_SDA PV5) on 70000868.pinmux
[    0.072725] pinctrl core: registered pin 174 (CRT_HSYNC PV6) on 70000868.pinmux
[    0.072778] pinctrl core: registered pin 175 (CRT_VSYNC PV7) on 70000868.pinmux
[    0.072831] pinctrl core: registered pin 176 (LCD_CS1_N PW0) on 70000868.pinmux
[    0.072884] pinctrl core: registered pin 177 (LCD_M1 PW1) on 70000868.pinmux
[    0.072932] pinctrl core: registered pin 178 (SPI2_CS1_N PW2) on 70000868.pinmux
[    0.072986] pinctrl core: registered pin 179 (SPI2_CS2_N PW3) on 70000868.pinmux
[    0.073049] pinctrl core: registered pin 180 (CLK1_OUT PW4) on 70000868.pinmux
[    0.073103] pinctrl core: registered pin 181 (CLK2_OUT PW5) on 70000868.pinmux
[    0.073155] pinctrl core: registered pin 182 (UART3_TXD PW6) on 70000868.pinmux
[    0.073207] pinctrl core: registered pin 183 (UART3_RXD PW7) on 70000868.pinmux
[    0.073259] pinctrl core: registered pin 184 (SPI2_MOSI PX0) on 70000868.pinmux
[    0.073311] pinctrl core: registered pin 185 (SPI2_MISO PX1) on 70000868.pinmux
[    0.073363] pinctrl core: registered pin 186 (SPI2_SCK PX2) on 70000868.pinmux
[    0.073415] pinctrl core: registered pin 187 (SPI2_CS0_N PX3) on 70000868.pinmux
[    0.073468] pinctrl core: registered pin 188 (SPI1_MOSI PX4) on 70000868.pinmux
[    0.073520] pinctrl core: registered pin 189 (SPI1_SCK PX5) on 70000868.pinmux
[    0.073571] pinctrl core: registered pin 190 (SPI1_CS0_N PX6) on 70000868.pinmux
[    0.073623] pinctrl core: registered pin 191 (SPI1_MISO PX7) on 70000868.pinmux
[    0.073676] pinctrl core: registered pin 192 (ULPI_CLK PY0) on 70000868.pinmux
[    0.073728] pinctrl core: registered pin 193 (ULPI_DIR PY1) on 70000868.pinmux
[    0.073780] pinctrl core: registered pin 194 (ULPI_NXT PY2) on 70000868.pinmux
[    0.073831] pinctrl core: registered pin 195 (ULPI_STP PY3) on 70000868.pinmux
[    0.073883] pinctrl core: registered pin 196 (SDMMC1_DAT3 PY4) on 70000868.pinmux
[    0.073936] pinctrl core: registered pin 197 (SDMMC1_DAT2 PY5) on 70000868.pinmux
[    0.073988] pinctrl core: registered pin 198 (SDMMC1_DAT1 PY6) on 70000868.pinmux
[    0.074041] pinctrl core: registered pin 199 (SDMMC1_DAT0 PY7) on 70000868.pinmux
[    0.074094] pinctrl core: registered pin 200 (SDMMC1_CLK PZ0) on 70000868.pinmux
[    0.074146] pinctrl core: registered pin 201 (SDMMC1_CMD PZ1) on 70000868.pinmux
[    0.074198] pinctrl core: registered pin 202 (LCD_SDIN PZ2) on 70000868.pinmux
[    0.074250] pinctrl core: registered pin 203 (LCD_WR_N PZ3) on 70000868.pinmux
[    0.074301] pinctrl core: registered pin 204 (LCD_SCK PZ4) on 70000868.pinmux
[    0.074350] pinctrl core: registered pin 205 (SYS_CLK_REQ PZ5) on 70000868.pinmux
[    0.074403] pinctrl core: registered pin 206 (PWR_I2C_SCL PZ6) on 70000868.pinmux
[    0.074456] pinctrl core: registered pin 207 (PWR_I2C_SDA PZ7) on 70000868.pinmux
[    0.074508] pinctrl core: registered pin 208 (SDMMC4_DAT0 PAA0) on 70000868.pinmux
[    0.074562] pinctrl core: registered pin 209 (SDMMC4_DAT1 PAA1) on 70000868.pinmux
[    0.074615] pinctrl core: registered pin 210 (SDMMC4_DAT2 PAA2) on 70000868.pinmux
[    0.074668] pinctrl core: registered pin 211 (SDMMC4_DAT3 PAA3) on 70000868.pinmux
[    0.074722] pinctrl core: registered pin 212 (SDMMC4_DAT4 PAA4) on 70000868.pinmux
[    0.074775] pinctrl core: registered pin 213 (SDMMC4_DAT5 PAA5) on 70000868.pinmux
[    0.074828] pinctrl core: registered pin 214 (SDMMC4_DAT6 PAA6) on 70000868.pinmux
[    0.074882] pinctrl core: registered pin 215 (SDMMC4_DAT7 PAA7) on 70000868.pinmux
[    0.074935] pinctrl core: registered pin 216 (PBB0) on 70000868.pinmux
[    0.074981] pinctrl core: registered pin 217 (CAM_I2C_SCL PBB1) on 70000868.pinmux
[    0.075034] pinctrl core: registered pin 218 (CAM_I2C_SDA PBB2) on 70000868.pinmux
[    0.075087] pinctrl core: registered pin 219 (PBB3) on 70000868.pinmux
[    0.075133] pinctrl core: registered pin 220 (PBB4) on 70000868.pinmux
[    0.075179] pinctrl core: registered pin 221 (PBB5) on 70000868.pinmux
[    0.075225] pinctrl core: registered pin 222 (PBB6) on 70000868.pinmux
[    0.075271] pinctrl core: registered pin 223 (PBB7) on 70000868.pinmux
[    0.075316] pinctrl core: registered pin 224 (CAM_MCLK PCC0) on 70000868.pinmux
[    0.075368] pinctrl core: registered pin 225 (PCC1) on 70000868.pinmux
[    0.075414] pinctrl core: registered pin 226 (PCC2) on 70000868.pinmux
[    0.075460] pinctrl core: registered pin 227 (SDMMC4_RST_N PCC3) on 70000868.pinmux
[    0.075514] pinctrl core: registered pin 228 (SDMMC4_CLK PCC4) on 70000868.pinmux
[    0.075566] pinctrl core: registered pin 229 (CLK2_REQ PCC5) on 70000868.pinmux
[    0.075618] pinctrl core: registered pin 230 (PEX_L2_RST_N PCC6) on 70000868.pinmux
[    0.075672] pinctrl core: registered pin 231 (PEX_L2_CLKREQ_N PCC7) on 70000868.pinmux
[    0.075727] pinctrl core: registered pin 232 (PEX_L0_PRSNT_N PDD0) on 70000868.pinmux
[    0.075781] pinctrl core: registered pin 233 (PEX_L0_RST_N PDD1) on 70000868.pinmux
[    0.075835] pinctrl core: registered pin 234 (PEX_L0_CLKREQ_N PDD2) on 70000868.pinmux
[    0.075890] pinctrl core: registered pin 235 (PEX_WAKE_N PDD3) on 70000868.pinmux
[    0.075942] pinctrl core: registered pin 236 (PEX_L1_PRSNT_N PDD4) on 70000868.pinmux
[    0.075997] pinctrl core: registered pin 237 (PEX_L1_RST_N PDD5) on 70000868.pinmux
[    0.076050] pinctrl core: registered pin 238 (PEX_L1_CLKREQ_N PDD6) on 70000868.pinmux
[    0.076105] pinctrl core: registered pin 239 (PEX_L2_PRSNT_N PDD7) on 70000868.pinmux
[    0.076160] pinctrl core: registered pin 240 (CLK3_OUT PEE0) on 70000868.pinmux
[    0.076212] pinctrl core: registered pin 241 (CLK3_REQ PEE1) on 70000868.pinmux
[    0.076263] pinctrl core: registered pin 242 (CLK1_REQ PEE2) on 70000868.pinmux
[    0.076315] pinctrl core: registered pin 243 (HDMI_CEC PEE3) on 70000868.pinmux
[    0.076377] pinctrl core: registered pin 244 (PEE4) on 70000868.pinmux
[    0.076423] pinctrl core: registered pin 245 (PEE5) on 70000868.pinmux
[    0.076470] pinctrl core: registered pin 246 (PEE6) on 70000868.pinmux
[    0.076515] pinctrl core: registered pin 247 (PEE7) on 70000868.pinmux
[    0.076561] pinctrl core: registered pin 248 (CLK_32K_IN) on 70000868.pinmux
[    0.076609] pinctrl core: registered pin 249 (CORE_PWR_REQ) on 70000868.pinmux
[    0.076661] pinctrl core: registered pin 250 (CPU_PWR_REQ) on 70000868.pinmux
[    0.076710] pinctrl core: registered pin 251 (JTAG_TCK) on 70000868.pinmux
[    0.076757] pinctrl core: registered pin 252 (JTAG_TDI) on 70000868.pinmux
[    0.076805] pinctrl core: registered pin 253 (JTAG_TDO) on 70000868.pinmux
[    0.076852] pinctrl core: registered pin 254 (JTAG_TMS) on 70000868.pinmux
[    0.076900] pinctrl core: registered pin 255 (JTAG_TRST_N) on 70000868.pinmux
[    0.076949] pinctrl core: registered pin 256 (OWR) on 70000868.pinmux
[    0.076994] pinctrl core: registered pin 257 (PWR_INT_N) on 70000868.pinmux
[    0.077042] pinctrl core: registered pin 258 (SYS_RESET_N) on 70000868.pinmux
[    0.077091] pinctrl core: registered pin 259 (TEST_MODE_EN) on 70000868.pinmux
[    0.077705] pinctrl core: add 113 pinctrl maps
[    0.077795] tegra30-pinctrl 70000868.pinmux: found group selector 228 for sdmmc4_clk_pcc4
[    0.077870] tegra30-pinctrl 70000868.pinmux: found group selector 228 for sdmmc4_clk_pcc4
[    0.077941] tegra30-pinctrl 70000868.pinmux: found group selector 159 for sdmmc4_cmd_pt7
[    0.078008] tegra30-pinctrl 70000868.pinmux: found group selector 159 for sdmmc4_cmd_pt7
[    0.078080] tegra30-pinctrl 70000868.pinmux: found group selector 208 for sdmmc4_dat0_paa0
[    0.078149] tegra30-pinctrl 70000868.pinmux: found group selector 208 for sdmmc4_dat0_paa0
[    0.078220] tegra30-pinctrl 70000868.pinmux: found group selector 209 for sdmmc4_dat1_paa1
[    0.078289] tegra30-pinctrl 70000868.pinmux: found group selector 209 for sdmmc4_dat1_paa1
[    0.078361] tegra30-pinctrl 70000868.pinmux: found group selector 210 for sdmmc4_dat2_paa2
[    0.078429] tegra30-pinctrl 70000868.pinmux: found group selector 210 for sdmmc4_dat2_paa2
[    0.078501] tegra30-pinctrl 70000868.pinmux: found group selector 211 for sdmmc4_dat3_paa3
[    0.078569] tegra30-pinctrl 70000868.pinmux: found group selector 211 for sdmmc4_dat3_paa3
[    0.078641] tegra30-pinctrl 70000868.pinmux: found group selector 212 for sdmmc4_dat4_paa4
[    0.078710] tegra30-pinctrl 70000868.pinmux: found group selector 212 for sdmmc4_dat4_paa4
[    0.078781] tegra30-pinctrl 70000868.pinmux: found group selector 213 for sdmmc4_dat5_paa5
[    0.078849] tegra30-pinctrl 70000868.pinmux: found group selector 213 for sdmmc4_dat5_paa5
[    0.078921] tegra30-pinctrl 70000868.pinmux: found group selector 214 for sdmmc4_dat6_paa6
[    0.078990] tegra30-pinctrl 70000868.pinmux: found group selector 214 for sdmmc4_dat6_paa6
[    0.079062] tegra30-pinctrl 70000868.pinmux: found group selector 215 for sdmmc4_dat7_paa7
[    0.079130] tegra30-pinctrl 70000868.pinmux: found group selector 215 for sdmmc4_dat7_paa7
[    0.079192] tegra30-pinctrl 70000868.pinmux: invalid group "sdmmc4_rst_n_pcc3" for function "rsvd1"
[    0.079266] tegra30-pinctrl 70000868.pinmux: found group selector 227 for sdmmc4_rst_n_pcc3
[    0.079340] tegra30-pinctrl 70000868.pinmux: found group selector 224 for cam_mclk_pcc0
[    0.079407] tegra30-pinctrl 70000868.pinmux: found group selector 224 for cam_mclk_pcc0
[    0.079479] tegra30-pinctrl 70000868.pinmux: found group selector 268 for drive_gma
[    0.079549] tegra30-pinctrl 70000868.pinmux: found group selector 269 for drive_gmb
[    0.079629] tegra30-pinctrl 70000868.pinmux: found group selector 270 for drive_gmc
[    0.079699] tegra30-pinctrl 70000868.pinmux: found group selector 271 for drive_gmd
[    0.079770] tegra30-pinctrl 70000868.pinmux: found group selector 287 for drive_uart3
[    0.079840] tegra30-pinctrl 70000868.pinmux: found group selector 200 for sdmmc1_clk_pz0
[    0.079909] tegra30-pinctrl 70000868.pinmux: found group selector 200 for sdmmc1_clk_pz0
[    0.080013] tegra30-pinctrl 70000868.pinmux: found group selector 201 for sdmmc1_cmd_pz1
[    0.080085] tegra30-pinctrl 70000868.pinmux: found group selector 201 for sdmmc1_cmd_pz1
[    0.080155] tegra30-pinctrl 70000868.pinmux: found group selector 199 for sdmmc1_dat0_py7
[    0.080222] tegra30-pinctrl 70000868.pinmux: found group selector 199 for sdmmc1_dat0_py7
[    0.080293] tegra30-pinctrl 70000868.pinmux: found group selector 198 for sdmmc1_dat1_py6
[    0.080360] tegra30-pinctrl 70000868.pinmux: found group selector 198 for sdmmc1_dat1_py6
[    0.080429] tegra30-pinctrl 70000868.pinmux: found group selector 197 for sdmmc1_dat2_py5
[    0.080496] tegra30-pinctrl 70000868.pinmux: found group selector 197 for sdmmc1_dat2_py5
[    0.080565] tegra30-pinctrl 70000868.pinmux: found group selector 196 for sdmmc1_dat3_py4
[    0.080632] tegra30-pinctrl 70000868.pinmux: found group selector 196 for sdmmc1_dat3_py4
[    0.080704] tegra30-pinctrl 70000868.pinmux: found group selector 280 for drive_sdio1
[    0.080765] tegra30-pinctrl 70000868.pinmux: found group selector 6 for sdmmc3_clk_pa6
[    0.080822] tegra30-pinctrl 70000868.pinmux: found group selector 6 for sdmmc3_clk_pa6
[    0.080883] tegra30-pinctrl 70000868.pinmux: found group selector 7 for sdmmc3_cmd_pa7
[    0.080940] tegra30-pinctrl 70000868.pinmux: found group selector 7 for sdmmc3_cmd_pa7
[    0.081001] tegra30-pinctrl 70000868.pinmux: found group selector 15 for sdmmc3_dat0_pb7
[    0.081060] tegra30-pinctrl 70000868.pinmux: found group selector 15 for sdmmc3_dat0_pb7
[    0.081121] tegra30-pinctrl 70000868.pinmux: found group selector 14 for sdmmc3_dat1_pb6
[    0.081180] tegra30-pinctrl 70000868.pinmux: found group selector 14 for sdmmc3_dat1_pb6
[    0.081242] tegra30-pinctrl 70000868.pinmux: found group selector 13 for sdmmc3_dat2_pb5
[    0.081300] tegra30-pinctrl 70000868.pinmux: found group selector 13 for sdmmc3_dat2_pb5
[    0.081362] tegra30-pinctrl 70000868.pinmux: found group selector 12 for sdmmc3_dat3_pb4
[    0.081420] tegra30-pinctrl 70000868.pinmux: found group selector 12 for sdmmc3_dat3_pb4
[    0.081483] tegra30-pinctrl 70000868.pinmux: found group selector 27 for sdmmc3_dat6_pd3
[    0.081543] tegra30-pinctrl 70000868.pinmux: found group selector 27 for sdmmc3_dat6_pd3
[    0.081605] tegra30-pinctrl 70000868.pinmux: found group selector 28 for sdmmc3_dat7_pd4
[    0.081665] tegra30-pinctrl 70000868.pinmux: found group selector 28 for sdmmc3_dat7_pd4
[    0.081739] tegra30-pinctrl 70000868.pinmux: found group selector 282 for drive_sdio3
[    0.081804] tegra30-pinctrl 70000868.pinmux: found group selector 168 for pv0
[    0.081861] tegra30-pinctrl 70000868.pinmux: found group selector 130 for kb_col2_pq2
[    0.081923] tegra30-pinctrl 70000868.pinmux: found group selector 131 for kb_col3_pq3
[    0.081986] tegra30-pinctrl 70000868.pinmux: found group selector 164 for pu4
[    0.082043] tegra30-pinctrl 70000868.pinmux: found group selector 150 for kb_row14_ps6
[    0.082108] tegra30-pinctrl 70000868.pinmux: found group selector 178 for spi2_cs1_n_pw2
[    0.082169] tegra30-pinctrl 70000868.pinmux: found group selector 69 for gmi_iordy_pi5
[    0.082230] tegra30-pinctrl 70000868.pinmux: found group selector 60 for gmi_ad12_ph4
[    0.082293] tegra30-pinctrl 70000868.pinmux: found group selector 146 for kb_row10_ps2
[    0.082357] tegra30-pinctrl 70000868.pinmux: found group selector 151 for kb_row15_ps7
[    0.082419] tegra30-pinctrl 70000868.pinmux: found group selector 129 for kb_col1_pq1
[    0.082481] tegra30-pinctrl 70000868.pinmux: found group selector 134 for kb_col6_pq6
[    0.082546] tegra30-pinctrl 70000868.pinmux: found group selector 179 for spi2_cs2_n_pw3
[    0.082604] tegra30-pinctrl 70000868.pinmux: found group selector 0 for clk_32k_out_pa0
[    0.082667] tegra30-pinctrl 70000868.pinmux: found group selector 137 for kb_row1_pr1
[    0.082728] tegra30-pinctrl 70000868.pinmux: found group selector 83 for gmi_cs2_n_pk3
[    0.082790] tegra30-pinctrl 70000868.pinmux: found group selector 74 for gmi_cs1_n_pj2
[    0.082851] tegra30-pinctrl 70000868.pinmux: found group selector 72 for gmi_cs0_n_pj0
[    0.082914] tegra30-pinctrl 70000868.pinmux: found group selector 133 for kb_col5_pq5
[    0.082976] tegra30-pinctrl 70000868.pinmux: found group selector 138 for kb_row2_pr2
[    0.083039] tegra30-pinctrl 70000868.pinmux: found group selector 135 for kb_col7_pq7
[    0.083101] tegra30-pinctrl 70000868.pinmux: found group selector 132 for kb_col4_pq4
[    0.083163] tegra30-pinctrl 70000868.pinmux: found group selector 141 for kb_row5_pr5
[    0.083226] tegra30-pinctrl 70000868.pinmux: found group selector 140 for kb_row4_pr4
[    0.083288] tegra30-pinctrl 70000868.pinmux: found group selector 87 for gmi_a19_pk7
[    0.083350] tegra30-pinctrl 70000868.pinmux: found group selector 136 for kb_row0_pr0
[    0.083407] tegra30-pinctrl 70000868.pinmux: found group selector 9 for gmi_a18_pb1
[    0.083464] tegra30-pinctrl 70000868.pinmux: found group selector 52 for gmi_ad4_pg4
[    0.083523] tegra30-pinctrl 70000868.pinmux: found group selector 53 for gmi_ad5_pg5
[    0.083591] tegra30-pinctrl 70000868.pinmux: found group selector 251 for drive_at1
[    0.083659] tegra30-pinctrl 70000868.pinmux: found group selector 252 for drive_at2
[    0.083737] tegra30-pinctrl 70000868.pinmux: found group selector 253 for drive_at3
[    0.083806] tegra30-pinctrl 70000868.pinmux: found group selector 254 for drive_at4
[    0.083872] tegra30-pinctrl 70000868.pinmux: found group selector 249 for drive_ao1
[    0.083939] tegra30-pinctrl 70000868.pinmux: found group selector 250 for drive_ao2
[    0.084001] tegra30-pinctrl 70000868.pinmux: found group selector 139 for kb_row3_pr3
[    0.084063] tegra30-pinctrl 70000868.pinmux: found group selector 128 for kb_col0_pq0
[    0.084125] tegra30-pinctrl 70000868.pinmux: found group selector 136 for kb_row0_pr0
[    0.084188] tegra30-pinctrl 70000868.pinmux: found group selector 155 for vi_d11_pt3
[    0.084250] tegra30-pinctrl 70000868.pinmux: found group selector 144 for kb_row8_ps0
[    0.084308] tegra30-pinctrl 70000868.pinmux: found group selector 24 for sdmmc3_dat5_pd0
[    0.084367] tegra30-pinctrl 70000868.pinmux: found group selector 25 for sdmmc3_dat4_pd1
[    0.084432] tegra30-pinctrl 70000868.pinmux: found group selector 152 for vi_pclk_pt0
[    0.084492] tegra30-pinctrl 70000868.pinmux: found group selector 68 for gmi_rst_n_pi4
[    0.084553] tegra30-pinctrl 70000868.pinmux: found group selector 70 for gmi_cs7_n_pi6
[    0.084616] tegra30-pinctrl 70000868.pinmux: found group selector 143 for kb_row7_pr7
[    0.084676] tegra30-pinctrl 70000868.pinmux: found group selector 2 for dap2_fs_pa2
[    0.084732] tegra30-pinctrl 70000868.pinmux: found group selector 2 for dap2_fs_pa2
[    0.084790] tegra30-pinctrl 70000868.pinmux: found group selector 3 for dap2_sclk_pa3
[    0.084847] tegra30-pinctrl 70000868.pinmux: found group selector 3 for dap2_sclk_pa3
[    0.084906] tegra30-pinctrl 70000868.pinmux: found group selector 4 for dap2_din_pa4
[    0.084962] tegra30-pinctrl 70000868.pinmux: found group selector 4 for dap2_din_pa4
[    0.085021] tegra30-pinctrl 70000868.pinmux: found group selector 5 for dap2_dout_pa5
[    0.085078] tegra30-pinctrl 70000868.pinmux: found group selector 5 for dap2_dout_pa5
[    0.085139] tegra30-pinctrl 70000868.pinmux: request pin 228 (SDMMC4_CLK PCC4) for 70000868.pinmux
[    0.085208] tegra30-pinctrl 70000868.pinmux: request pin 159 (SDMMC4_CMD PT7) for 70000868.pinmux
[    0.085274] tegra30-pinctrl 70000868.pinmux: request pin 208 (SDMMC4_DAT0 PAA0) for 70000868.pinmux
[    0.085341] tegra30-pinctrl 70000868.pinmux: request pin 209 (SDMMC4_DAT1 PAA1) for 70000868.pinmux
[    0.085406] tegra30-pinctrl 70000868.pinmux: request pin 210 (SDMMC4_DAT2 PAA2) for 70000868.pinmux
[    0.085471] tegra30-pinctrl 70000868.pinmux: request pin 211 (SDMMC4_DAT3 PAA3) for 70000868.pinmux
[    0.085537] tegra30-pinctrl 70000868.pinmux: request pin 212 (SDMMC4_DAT4 PAA4) for 70000868.pinmux
[    0.085602] tegra30-pinctrl 70000868.pinmux: request pin 213 (SDMMC4_DAT5 PAA5) for 70000868.pinmux
[    0.085667] tegra30-pinctrl 70000868.pinmux: request pin 214 (SDMMC4_DAT6 PAA6) for 70000868.pinmux
[    0.085733] tegra30-pinctrl 70000868.pinmux: request pin 215 (SDMMC4_DAT7 PAA7) for 70000868.pinmux
[    0.085800] tegra30-pinctrl 70000868.pinmux: request pin 224 (CAM_MCLK PCC0) for 70000868.pinmux
[    0.085882] tegra30-pinctrl 70000868.pinmux: request pin 200 (SDMMC1_CLK PZ0) for 70000868.pinmux
[    0.085947] tegra30-pinctrl 70000868.pinmux: request pin 201 (SDMMC1_CMD PZ1) for 70000868.pinmux
[    0.086011] tegra30-pinctrl 70000868.pinmux: request pin 199 (SDMMC1_DAT0 PY7) for 70000868.pinmux
[    0.086076] tegra30-pinctrl 70000868.pinmux: request pin 198 (SDMMC1_DAT1 PY6) for 70000868.pinmux
[    0.086141] tegra30-pinctrl 70000868.pinmux: request pin 197 (SDMMC1_DAT2 PY5) for 70000868.pinmux
[    0.086206] tegra30-pinctrl 70000868.pinmux: request pin 196 (SDMMC1_DAT3 PY4) for 70000868.pinmux
[    0.086276] tegra30-pinctrl 70000868.pinmux: request pin 6 (SDMMC3_CLK PA6) for 70000868.pinmux
[    0.086339] tegra30-pinctrl 70000868.pinmux: request pin 7 (SDMMC3_CMD PA7) for 70000868.pinmux
[    0.086402] tegra30-pinctrl 70000868.pinmux: request pin 15 (SDMMC3_DAT0 PB7) for 70000868.pinmux
[    0.086465] tegra30-pinctrl 70000868.pinmux: request pin 14 (SDMMC3_DAT1 PB6) for 70000868.pinmux
[    0.086529] tegra30-pinctrl 70000868.pinmux: request pin 13 (SDMMC3_DAT2 PB5) for 70000868.pinmux
[    0.086593] tegra30-pinctrl 70000868.pinmux: request pin 12 (SDMMC3_DAT3 PB4) for 70000868.pinmux
[    0.086657] tegra30-pinctrl 70000868.pinmux: request pin 27 (SDMMC3_DAT6 PD3) for 70000868.pinmux
[    0.086720] tegra30-pinctrl 70000868.pinmux: request pin 28 (SDMMC3_DAT7 PD4) for 70000868.pinmux
[    0.086894] tegra30-pinctrl 70000868.pinmux: request pin 2 (DAP2_FS PA2) for 70000868.pinmux
[    0.086956] tegra30-pinctrl 70000868.pinmux: request pin 3 (DAP2_SCLK PA3) for 70000868.pinmux
[    0.087018] tegra30-pinctrl 70000868.pinmux: request pin 4 (DAP2_DIN PA4) for 70000868.pinmux
[    0.087080] tegra30-pinctrl 70000868.pinmux: request pin 5 (DAP2_DOUT PA5) for 70000868.pinmux
[    0.087143] tegra30-pinctrl 70000868.pinmux: failed to lookup the sleep state
[    0.087373] tegra30-pinctrl 70000868.pinmux: Probed Tegra pinctrl driver
[    0.089369] ramoops: error in header, 6
[    0.824948] printk: console [pstore-1] enabled
[    0.825191] pstore: Registered ramoops as persistent store backend
[    0.825310] ramoops: using 0x100000@0xbeb00000, ecc: 16
[    0.836876] tegra30-pinctrl 70000868.pinmux: request pin 137 (KB_ROW1 PR1) for tegra-gpio:137
[    0.837035] GPIO line 137 (usb_charge_limit) hogged as output/low
[    0.852182] tegra30-pinctrl 70000868.pinmux: request pin 28 (SDMMC3_DAT7 PD4) for tegra-gpio:28
[    0.852418] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.852615] wifi_3v3: unable to resolve supply
[    0.852732] wifi_3v3: 3300 mV 
[    0.853056] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.853252] wifi_3v3: unable to resolve supply
[    0.853389] reg-fixed-voltage regulators:regulator@21: wifi_3v3 supplying 3300000uV
[    0.853735] tegra30-pinctrl 70000868.pinmux: request pin 160 (PU0) for tegra-gpio:160
[    0.853939] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.854073] bt_3v3: unable to resolve supply
[    0.854240] bt_3v3: 3300 mV 
[    0.854539] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.854736] wifi_3v3: unable to resolve supply
[    0.854846] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.855035] bt_3v3: unable to resolve supply
[    0.855142] reg-fixed-voltage regulators:regulator@22: bt_3v3 supplying 3300000uV
[    0.855479] tegra30-pinctrl 70000868.pinmux: request pin 162 (PU2) for tegra-gpio:162
[    0.855683] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.855818] gps_en: unable to resolve supply
[    0.855985] gps_en: 3300 mV 
[    0.856295] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.856492] wifi_3v3: unable to resolve supply
[    0.856601] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.856789] bt_3v3: unable to resolve supply
[    0.856893] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.857082] gps_en: unable to resolve supply
[    0.857247] reg-fixed-voltage regulators:regulator@23: gps_en supplying 3300000uV
[    0.857527] tegra30-pinctrl 70000868.pinmux: request pin 142 (KB_ROW6 PR6) for tegra-gpio:142
[    0.857745] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.857937] vdd_cam1_ldo: unable to resolve supply
[    0.858050] vdd_cam1_ldo: 2800 mV 
[    0.858361] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.858558] wifi_3v3: unable to resolve supply
[    0.858723] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.858855] bt_3v3: unable to resolve supply
[    0.859020] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.859151] gps_en: unable to resolve supply
[    0.859314] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.859502] vdd_cam1_ldo: unable to resolve supply
[    0.859611] reg-fixed-voltage regulators:regulator@18: vdd_cam1_ldo supplying 2800000uV
[    0.860219] tegra30-pinctrl 70000868.pinmux: request pin 59 (GMI_AD11 PH3) for tegra-gpio:59
[    0.860384] vdd_bl: 5000 mV 
[    0.860775] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.860916] wifi_3v3: unable to resolve supply
[    0.861083] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.861274] bt_3v3: unable to resolve supply
[    0.861379] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.861569] gps_en: unable to resolve supply
[    0.861674] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.861869] vdd_cam1_ldo: unable to resolve supply
[    0.861979] reg-fixed-voltage regulators:regulator@4: vdd_bl supplying 5000000uV
[    0.862314] tegra30-pinctrl 70000868.pinmux: request pin 30 (VI_VSYNC PD6) for tegra-gpio:30
[    0.862526] modem_3v3: 3300 mV 
[    0.862840] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.863038] wifi_3v3: unable to resolve supply
[    0.863147] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.863337] bt_3v3: unable to resolve supply
[    0.863465] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.863658] gps_en: unable to resolve supply
[    0.863765] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.863957] vdd_cam1_ldo: unable to resolve supply
[    0.864126] reg-fixed-voltage regulators:regulator@5: modem_3v3 supplying 3300000uV
[    0.864409] tegra30-pinctrl 70000868.pinmux: request pin 177 (LCD_M1 PW1) for tegra-gpio:177
[    0.864617] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.864813] vdd_pnl1: unable to resolve supply
[    0.864926] vdd_pnl1: 3300 mV 
[    0.865268] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.865468] wifi_3v3: unable to resolve supply
[    0.865635] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.865769] bt_3v3: unable to resolve supply
[    0.865931] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.866064] gps_en: unable to resolve supply
[    0.866226] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.866417] vdd_cam1_ldo: unable to resolve supply
[    0.866526] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.866717] vdd_pnl1: unable to resolve supply
[    0.866824] reg-fixed-voltage regulators:regulator@6: vdd_pnl1 supplying 3300000uV
[    0.867157] tegra30-pinctrl 70000868.pinmux: request pin 144 (KB_ROW8 PS0) for tegra-gpio:144
[    0.867366] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.867504] vdd_cam3_ldo: unable to resolve supply
[    0.867675] vdd_cam3_ldo: 3300 mV 
[    0.867978] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.868179] wifi_3v3: unable to resolve supply
[    0.868287] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.868479] bt_3v3: unable to resolve supply
[    0.868585] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.868776] gps_en: unable to resolve supply
[    0.868881] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.869071] vdd_cam1_ldo: unable to resolve supply
[    0.869237] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.869371] vdd_pnl1: unable to resolve supply
[    0.869536] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.869728] vdd_cam3_ldo: unable to resolve supply
[    0.869837] reg-fixed-voltage regulators:regulator@7: vdd_cam3_ldo supplying 3300000uV
[    0.870175] tegra30-pinctrl 70000868.pinmux: request pin 24 (SDMMC3_DAT5 PD0) for tegra-gpio:24
[    0.870327] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.870523] vdd_com: unable to resolve supply
[    0.870690] vdd_com: 3300 mV 
[    0.870996] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.871196] wifi_3v3: unable to resolve supply
[    0.871305] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.871498] bt_3v3: unable to resolve supply
[    0.871604] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.871796] gps_en: unable to resolve supply
[    0.871900] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.872093] vdd_cam1_ldo: unable to resolve supply
[    0.872202] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.872395] vdd_pnl1: unable to resolve supply
[    0.872559] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.872693] vdd_cam3_ldo: unable to resolve supply
[    0.872858] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.872991] vdd_com: unable to resolve supply
[    0.873098] reg-fixed-voltage regulators:regulator@8: vdd_com supplying 3300000uV
[    0.873454] tegra30-pinctrl 70000868.pinmux: request pin 17 (LCD_PWR1 PC1) for tegra-gpio:17
[    0.873604] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    0.873802] vdd_fuse_3v3: unable to resolve supply
[    0.873914] vdd_fuse_3v3: 3300 mV 
[    0.874288] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.874488] wifi_3v3: unable to resolve supply
[    0.874596] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.874792] bt_3v3: unable to resolve supply
[    0.874897] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.875090] gps_en: unable to resolve supply
[    0.875196] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.875389] vdd_cam1_ldo: unable to resolve supply
[    0.875498] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.875692] vdd_pnl1: unable to resolve supply
[    0.875798] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.875932] vdd_cam3_ldo: unable to resolve supply
[    0.876098] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.876233] vdd_com: unable to resolve supply
[    0.876396] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    0.876588] vdd_fuse_3v3: unable to resolve supply
[    0.876698] reg-fixed-voltage regulators:regulator@9: vdd_fuse_3v3 supplying 3300000uV
[    0.877036] tegra30-pinctrl 70000868.pinmux: request pin 223 (PBB7) for tegra-gpio:223
[    0.877195] icatch7002a_vddc: 1200 mV 
[    0.877561] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.877706] wifi_3v3: unable to resolve supply
[    0.877873] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.878068] bt_3v3: unable to resolve supply
[    0.878174] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.878367] gps_en: unable to resolve supply
[    0.878471] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.878664] vdd_cam1_ldo: unable to resolve supply
[    0.878774] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.878967] vdd_pnl1: unable to resolve supply
[    0.879072] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.879264] vdd_cam3_ldo: unable to resolve supply
[    0.879430] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.879565] vdd_com: unable to resolve supply
[    0.879729] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    0.879864] vdd_fuse_3v3: unable to resolve supply
[    0.879973] reg-fixed-voltage regulators:regulator@100: icatch7002a_vddc supplying 1200000uV
[    0.880313] tegra30-pinctrl 70000868.pinmux: request pin 122 (DAP3_DOUT PP2) for tegra-gpio:122
[    0.880464] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    0.880663] hdmi_con_5v: unable to resolve supply
[    0.880832] hdmi_con_5v: 5000 mV 
[    0.881144] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.881347] wifi_3v3: unable to resolve supply
[    0.881455] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.881651] bt_3v3: unable to resolve supply
[    0.881757] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.881955] gps_en: unable to resolve supply
[    0.882060] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.882254] vdd_cam1_ldo: unable to resolve supply
[    0.882422] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.882558] vdd_pnl1: unable to resolve supply
[    0.882721] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.882857] vdd_cam3_ldo: unable to resolve supply
[    0.883021] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.883213] vdd_com: unable to resolve supply
[    0.883319] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    0.883530] vdd_fuse_3v3: unable to resolve supply
[    0.883638] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    0.883828] hdmi_con_5v: unable to resolve supply
[    0.883938] reg-fixed-voltage regulators:regulator@101: hdmi_con_5v supplying 5000000uV
[    0.884342] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    0.884548] avdd_hdmi_pll: unable to resolve supply
[    0.884661] avdd_hdmi_pll: 1800 mV 
[    0.885050] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.885197] wifi_3v3: unable to resolve supply
[    0.885364] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.885502] bt_3v3: unable to resolve supply
[    0.885666] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.885861] gps_en: unable to resolve supply
[    0.885967] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.886162] vdd_cam1_ldo: unable to resolve supply
[    0.886271] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.886466] vdd_pnl1: unable to resolve supply
[    0.886572] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.886766] vdd_cam3_ldo: unable to resolve supply
[    0.886873] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.887067] vdd_com: unable to resolve supply
[    0.887231] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    0.887368] vdd_fuse_3v3: unable to resolve supply
[    0.887533] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    0.887670] hdmi_con_5v: unable to resolve supply
[    0.887835] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    0.888028] avdd_hdmi_pll: unable to resolve supply
[    0.888139] reg-fixed-voltage regulators:regulator@102: avdd_hdmi_pll supplying 1800000uV
[    0.888491] tegra30-pinctrl 70000868.pinmux: request pin 152 (VI_PCLK PT0) for tegra-gpio:152
[    0.888708] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    0.888852] avdd_hdmi: unable to resolve supply
[    0.889022] avdd_hdmi: 3300 mV 
[    0.889357] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.889561] wifi_3v3: unable to resolve supply
[    0.889671] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.889866] bt_3v3: unable to resolve supply
[    0.889972] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.890167] gps_en: unable to resolve supply
[    0.890273] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.890467] vdd_cam1_ldo: unable to resolve supply
[    0.890635] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.890772] vdd_pnl1: unable to resolve supply
[    0.890935] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.891130] vdd_cam3_ldo: unable to resolve supply
[    0.891238] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.891432] vdd_com: unable to resolve supply
[    0.891538] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    0.891732] vdd_fuse_3v3: unable to resolve supply
[    0.891841] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    0.892037] hdmi_con_5v: unable to resolve supply
[    0.892145] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    0.892340] avdd_hdmi_pll: unable to resolve supply
[    0.892506] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    0.892643] avdd_hdmi: unable to resolve supply
[    0.892809] reg-fixed-voltage regulators:regulator@103: avdd_hdmi supplying 3300000uV
[    0.893093] tegra30-pinctrl 70000868.pinmux: request pin 220 (PBB4) for tegra-gpio:220
[    0.893300] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    0.893524] cam_1v8: unable to resolve supply
[    0.893637] cam_1v8: 1800 mV 
[    0.894006] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.894152] wifi_3v3: unable to resolve supply
[    0.894317] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.894457] bt_3v3: unable to resolve supply
[    0.894620] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.894817] gps_en: unable to resolve supply
[    0.894922] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.895118] vdd_cam1_ldo: unable to resolve supply
[    0.895226] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.895422] vdd_pnl1: unable to resolve supply
[    0.895528] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.895724] vdd_cam3_ldo: unable to resolve supply
[    0.895832] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.896028] vdd_com: unable to resolve supply
[    0.896192] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    0.896330] vdd_fuse_3v3: unable to resolve supply
[    0.896495] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    0.896691] hdmi_con_5v: unable to resolve supply
[    0.896798] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    0.896994] avdd_hdmi_pll: unable to resolve supply
[    0.897102] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    0.897298] avdd_hdmi: unable to resolve supply
[    0.897405] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    0.897600] cam_1v8: unable to resolve supply
[    0.897706] reg-fixed-voltage regulators:regulator@104: cam_1v8 supplying 1800000uV
[    0.898045] vdd_ac_bat: 5000 mV 
[    0.898364] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.898571] wifi_3v3: unable to resolve supply
[    0.898737] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.898876] bt_3v3: unable to resolve supply
[    0.899037] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.899176] gps_en: unable to resolve supply
[    0.899338] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.899536] vdd_cam1_ldo: unable to resolve supply
[    0.899646] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.899841] vdd_pnl1: unable to resolve supply
[    0.899948] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.900139] vdd_cam3_ldo: unable to resolve supply
[    0.900244] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.900436] vdd_com: unable to resolve supply
[    0.900541] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    0.900737] vdd_fuse_3v3: unable to resolve supply
[    0.900903] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    0.901042] hdmi_con_5v: unable to resolve supply
[    0.901206] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    0.901403] avdd_hdmi_pll: unable to resolve supply
[    0.901510] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    0.901708] avdd_hdmi: unable to resolve supply
[    0.901814] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    0.902012] cam_1v8: unable to resolve supply
[    0.902119] reg-fixed-voltage regulators:regulator@107: vdd_ac_bat supplying 5000000uV
[    0.902465] tegra30-pinctrl 70000868.pinmux: request pin 123 (DAP3_SCLK PP3) for tegra-gpio:123
[    0.902675] reg-fixed-voltage regulators:regulator@108: Looking up vin-supply from device tree
[    0.902878] dsp_1v8: unable to resolve supply
[    0.902988] dsp_1v8: 1800 mV 
[    0.903290] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.903517] wifi_3v3: unable to resolve supply
[    0.903627] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.903825] bt_3v3: unable to resolve supply
[    0.903930] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.904069] gps_en: unable to resolve supply
[    0.904231] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.904371] vdd_cam1_ldo: unable to resolve supply
[    0.904538] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.904735] vdd_pnl1: unable to resolve supply
[    0.904843] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.905039] vdd_cam3_ldo: unable to resolve supply
[    0.905146] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.905342] vdd_com: unable to resolve supply
[    0.905447] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    0.905644] vdd_fuse_3v3: unable to resolve supply
[    0.905752] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    0.905950] hdmi_con_5v: unable to resolve supply
[    0.906115] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    0.906255] avdd_hdmi_pll: unable to resolve supply
[    0.906420] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    0.906618] avdd_hdmi: unable to resolve supply
[    0.906723] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    0.906921] cam_1v8: unable to resolve supply
[    0.907028] reg-fixed-voltage regulators:regulator@108: Looking up vin-supply from device tree
[    0.907224] dsp_1v8: unable to resolve supply
[    0.907331] reg-fixed-voltage regulators:regulator@108: dsp_1v8 supplying 1800000uV
[    0.907680] tegra30-pinctrl 70000868.pinmux: request pin 221 (PBB5) for tegra-gpio:221
[    0.907887] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    0.908031] isp_power: unable to resolve supply
[    0.908199] isp_power: 1800 mV 
[    0.908508] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.908715] wifi_3v3: unable to resolve supply
[    0.908823] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.909022] bt_3v3: unable to resolve supply
[    0.909127] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.909324] gps_en: unable to resolve supply
[    0.909429] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.909570] vdd_cam1_ldo: unable to resolve supply
[    0.909737] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.909877] vdd_pnl1: unable to resolve supply
[    0.910040] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.910238] vdd_cam3_ldo: unable to resolve supply
[    0.910345] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.910543] vdd_com: unable to resolve supply
[    0.910648] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    0.910846] vdd_fuse_3v3: unable to resolve supply
[    0.910954] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    0.911152] hdmi_con_5v: unable to resolve supply
[    0.911258] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    0.911457] avdd_hdmi_pll: unable to resolve supply
[    0.911622] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    0.911763] avdd_hdmi: unable to resolve supply
[    0.911926] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    0.912125] cam_1v8: unable to resolve supply
[    0.912231] reg-fixed-voltage regulators:regulator@108: Looking up vin-supply from device tree
[    0.912429] dsp_1v8: unable to resolve supply
[    0.912534] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    0.912732] isp_power: unable to resolve supply
[    0.912840] reg-fixed-voltage regulators:regulator@109: isp_power supplying 1800000uV
[    0.913178] tegra30-pinctrl 70000868.pinmux: request pin 222 (PBB6) for tegra-gpio:222
[    0.913404] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    0.913551] dsp_power: unable to resolve supply
[    0.913719] dsp_power: 1800 mV 
[    0.914031] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.914239] wifi_3v3: unable to resolve supply
[    0.914347] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.914547] bt_3v3: unable to resolve supply
[    0.914651] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.914849] gps_en: unable to resolve supply
[    0.915012] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.915153] vdd_cam1_ldo: unable to resolve supply
[    0.915320] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.915460] vdd_pnl1: unable to resolve supply
[    0.915623] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.915821] vdd_cam3_ldo: unable to resolve supply
[    0.915928] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.916126] vdd_com: unable to resolve supply
[    0.916232] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    0.916430] vdd_fuse_3v3: unable to resolve supply
[    0.916538] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    0.916732] hdmi_con_5v: unable to resolve supply
[    0.916892] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    0.917031] avdd_hdmi_pll: unable to resolve supply
[    0.917197] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    0.917337] avdd_hdmi: unable to resolve supply
[    0.917501] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    0.917701] cam_1v8: unable to resolve supply
[    0.917806] reg-fixed-voltage regulators:regulator@108: Looking up vin-supply from device tree
[    0.918005] dsp_1v8: unable to resolve supply
[    0.918110] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    0.918310] isp_power: unable to resolve supply
[    0.918416] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    0.918615] dsp_power: unable to resolve supply
[    0.918780] reg-fixed-voltage regulators:regulator@110: dsp_power supplying 1800000uV
[    0.919897] usbcore: registered new interface driver usbfs
[    0.920170] usbcore: registered new interface driver hub
[    0.920414] usbcore: registered new device driver usb
[    0.928076] tps65910-gpio tps65910-gpio: no of_node; not parsing pinctrl DT
[    0.928906] GPIO line 1017 (sleep_out) hogged as output/high
[    0.929565] tps65910-pmic tps65910-pmic: no of_node; not parsing pinctrl DT
[    0.931157] tps65910 4-002d: Looking up vcc7-supply from device tree
[    0.931361] vrtc: supplied by vdd_ac_bat
[    0.931472] vdd_ac_bat: could not add device link regulator.20 err -2
[    0.931938] vrtc: no parameters
[    0.932473] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.932685] wifi_3v3: unable to resolve supply
[    0.932795] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.932998] bt_3v3: unable to resolve supply
[    0.933106] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.933303] gps_en: unable to resolve supply
[    0.933408] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.933549] vdd_cam1_ldo: unable to resolve supply
[    0.933715] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.933857] vdd_pnl1: unable to resolve supply
[    0.934021] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.934222] vdd_cam3_ldo: unable to resolve supply
[    0.934331] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.934532] vdd_com: unable to resolve supply
[    0.934637] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    0.934839] vdd_fuse_3v3: unable to resolve supply
[    0.934947] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    0.935147] hdmi_con_5v: unable to resolve supply
[    0.935255] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    0.935456] avdd_hdmi_pll: unable to resolve supply
[    0.935622] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    0.935766] avdd_hdmi: unable to resolve supply
[    0.935931] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    0.936133] cam_1v8: unable to resolve supply
[    0.936239] reg-fixed-voltage regulators:regulator@108: Looking up vin-supply from device tree
[    0.936440] dsp_1v8: unable to resolve supply
[    0.936547] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    0.936747] isp_power: unable to resolve supply
[    0.936853] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    0.937054] dsp_power: unable to resolve supply
[    0.937982] tps65910 4-002d: Looking up vccio-supply from device tree
[    0.938176] vio: supplied by vdd_ac_bat
[    0.938284] vdd_ac_bat: could not add device link regulator.21 err -2
[    0.940036] vio: 1800 mV 
[    0.940365] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.940576] wifi_3v3: unable to resolve supply
[    0.940684] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.940885] bt_3v3: unable to resolve supply
[    0.940991] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.941191] gps_en: unable to resolve supply
[    0.941355] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.941498] vdd_cam1_ldo: unable to resolve supply
[    0.941665] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.941865] vdd_pnl1: unable to resolve supply
[    0.941971] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.942172] vdd_cam3_ldo: unable to resolve supply
[    0.942279] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.942480] vdd_com: unable to resolve supply
[    0.942586] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    0.942786] vdd_fuse_3v3: unable to resolve supply
[    0.942894] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    0.943094] hdmi_con_5v: unable to resolve supply
[    0.943259] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    0.943403] avdd_hdmi_pll: unable to resolve supply
[    0.943568] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    0.943769] avdd_hdmi: unable to resolve supply
[    0.943877] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    0.944077] cam_1v8: unable to resolve supply
[    0.944182] reg-fixed-voltage regulators:regulator@108: Looking up vin-supply from device tree
[    0.944383] dsp_1v8: unable to resolve supply
[    0.944489] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    0.944690] isp_power: unable to resolve supply
[    0.944796] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    0.944995] dsp_power: unable to resolve supply
[    0.946514] tps65910 4-002d: Looking up vcc1-supply from device tree
[    0.946649] vdd1: supplied by vdd_ac_bat
[    0.946758] vdd_ac_bat: could not add device link regulator.22 err -2
[    0.949975] vdd1: 600 mV 
[    0.950317] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.950530] wifi_3v3: unable to resolve supply
[    0.950638] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.950842] bt_3v3: unable to resolve supply
[    0.951006] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.951150] gps_en: unable to resolve supply
[    0.951313] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.951457] vdd_cam1_ldo: unable to resolve supply
[    0.951625] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.951826] vdd_pnl1: unable to resolve supply
[    0.951932] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.952131] vdd_cam3_ldo: unable to resolve supply
[    0.952240] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.952441] vdd_com: unable to resolve supply
[    0.952547] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    0.952747] vdd_fuse_3v3: unable to resolve supply
[    0.952855] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    0.953057] hdmi_con_5v: unable to resolve supply
[    0.953221] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    0.953365] avdd_hdmi_pll: unable to resolve supply
[    0.953532] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    0.953735] avdd_hdmi: unable to resolve supply
[    0.953841] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    0.954043] cam_1v8: unable to resolve supply
[    0.954149] reg-fixed-voltage regulators:regulator@108: Looking up vin-supply from device tree
[    0.954350] dsp_1v8: unable to resolve supply
[    0.954455] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    0.954656] isp_power: unable to resolve supply
[    0.954763] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    0.954965] dsp_power: unable to resolve supply
[    0.955942] tps65910 4-002d: Looking up vcc2-supply from device tree
[    0.956079] vdd2: supplied by vdd_ac_bat
[    0.956246] vdd_ac_bat: could not add device link regulator.23 err -2
[    0.959978] vdd2: 1200 mV 
[    0.960308] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.960522] wifi_3v3: unable to resolve supply
[    0.960632] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.960835] bt_3v3: unable to resolve supply
[    0.960998] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.961143] gps_en: unable to resolve supply
[    0.961306] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.961451] vdd_cam1_ldo: unable to resolve supply
[    0.961560] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.961762] vdd_pnl1: unable to resolve supply
[    0.961867] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.962068] vdd_cam3_ldo: unable to resolve supply
[    0.962175] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.962377] vdd_com: unable to resolve supply
[    0.962482] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    0.962683] vdd_fuse_3v3: unable to resolve supply
[    0.962849] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    0.962993] hdmi_con_5v: unable to resolve supply
[    0.963157] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    0.963300] avdd_hdmi_pll: unable to resolve supply
[    0.963465] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    0.963668] avdd_hdmi: unable to resolve supply
[    0.963774] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    0.963977] cam_1v8: unable to resolve supply
[    0.964084] reg-fixed-voltage regulators:regulator@108: Looking up vin-supply from device tree
[    0.964285] dsp_1v8: unable to resolve supply
[    0.964391] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    0.964593] isp_power: unable to resolve supply
[    0.964756] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    0.964900] dsp_power: unable to resolve supply
[    0.969979] vdd_cpu: 600 <--> 1100 mV at 1025 mV 
[    0.970309] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.970523] wifi_3v3: unable to resolve supply
[    0.970631] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.970834] bt_3v3: unable to resolve supply
[    0.970939] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.971141] gps_en: unable to resolve supply
[    0.971305] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.971449] vdd_cam1_ldo: unable to resolve supply
[    0.971616] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.971761] vdd_pnl1: unable to resolve supply
[    0.971925] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.972128] vdd_cam3_ldo: unable to resolve supply
[    0.972235] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.972436] vdd_com: unable to resolve supply
[    0.972542] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    0.972743] vdd_fuse_3v3: unable to resolve supply
[    0.972853] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    0.973057] hdmi_con_5v: unable to resolve supply
[    0.973219] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    0.973362] avdd_hdmi_pll: unable to resolve supply
[    0.973528] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    0.973673] avdd_hdmi: unable to resolve supply
[    0.973837] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    0.974039] cam_1v8: unable to resolve supply
[    0.974145] reg-fixed-voltage regulators:regulator@108: Looking up vin-supply from device tree
[    0.974346] dsp_1v8: unable to resolve supply
[    0.974450] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    0.974654] isp_power: unable to resolve supply
[    0.974760] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    0.974964] dsp_power: unable to resolve supply
[    0.975885] tps65910 4-002d: Looking up vcc6-supply from device tree
[    0.976083] ldo1: supplied by vdd2
[    0.976190] vdd2: could not add device link regulator.25 err -2
[    0.979979] vdd_emmc: 2700 <--> 3300 mV at 3300 mV 
[    0.980346] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.980561] wifi_3v3: unable to resolve supply
[    0.980670] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.980874] bt_3v3: unable to resolve supply
[    0.981037] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.981183] gps_en: unable to resolve supply
[    0.981346] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.981492] vdd_cam1_ldo: unable to resolve supply
[    0.981659] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.981862] vdd_pnl1: unable to resolve supply
[    0.981969] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.982171] vdd_cam3_ldo: unable to resolve supply
[    0.982279] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.982481] vdd_com: unable to resolve supply
[    0.982586] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    0.982789] vdd_fuse_3v3: unable to resolve supply
[    0.982955] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    0.983098] hdmi_con_5v: unable to resolve supply
[    0.983258] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    0.983400] avdd_hdmi_pll: unable to resolve supply
[    0.983567] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    0.983772] avdd_hdmi: unable to resolve supply
[    0.983878] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    0.984080] cam_1v8: unable to resolve supply
[    0.984187] reg-fixed-voltage regulators:regulator@108: Looking up vin-supply from device tree
[    0.984388] dsp_1v8: unable to resolve supply
[    0.984494] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    0.984697] isp_power: unable to resolve supply
[    0.984861] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    0.985006] dsp_power: unable to resolve supply
[    0.985986] tps65910 4-002d: Looking up vcc6-supply from device tree
[    0.986128] ldo2: supplied by vdd2
[    0.986292] vdd2: could not add device link regulator.26 err -2
[    0.986699] vdd_usd: 1050 <--> 3300 mV at 3100 mV 
[    0.987036] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.987249] wifi_3v3: unable to resolve supply
[    0.987417] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.987564] bt_3v3: unable to resolve supply
[    0.987728] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.987931] gps_en: unable to resolve supply
[    0.988036] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.988240] vdd_cam1_ldo: unable to resolve supply
[    0.988350] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.988554] vdd_pnl1: unable to resolve supply
[    0.988661] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.988865] vdd_cam3_ldo: unable to resolve supply
[    0.988973] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.989176] vdd_com: unable to resolve supply
[    0.989338] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    0.989483] vdd_fuse_3v3: unable to resolve supply
[    0.989649] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    0.989796] hdmi_con_5v: unable to resolve supply
[    0.989994] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    0.990199] avdd_hdmi_pll: unable to resolve supply
[    0.990307] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    0.990512] avdd_hdmi: unable to resolve supply
[    0.990619] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    0.990820] cam_1v8: unable to resolve supply
[    0.990927] reg-fixed-voltage regulators:regulator@108: Looking up vin-supply from device tree
[    0.991128] dsp_1v8: unable to resolve supply
[    0.991290] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    0.991437] isp_power: unable to resolve supply
[    0.991600] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    0.991746] dsp_power: unable to resolve supply
[    0.992725] tps65910 4-002d: Looking up vcc5-supply from device tree
[    0.992860] ldo3: supplied by vdd_ac_bat
[    0.993027] vdd_ac_bat: could not add device link regulator.27 err -2
[    0.993432] vddio_usd: 1000 <--> 3300 mV at 2900 mV 
[    0.993825] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    0.994040] wifi_3v3: unable to resolve supply
[    0.994149] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    0.994355] bt_3v3: unable to resolve supply
[    0.994460] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    0.994665] gps_en: unable to resolve supply
[    0.994770] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    0.994975] vdd_cam1_ldo: unable to resolve supply
[    0.995084] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    0.995289] vdd_pnl1: unable to resolve supply
[    0.995452] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    0.995598] vdd_cam3_ldo: unable to resolve supply
[    0.995762] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    0.995908] vdd_com: unable to resolve supply
[    0.996072] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    0.996276] vdd_fuse_3v3: unable to resolve supply
[    0.996384] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    0.996590] hdmi_con_5v: unable to resolve supply
[    0.996697] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    0.996900] avdd_hdmi_pll: unable to resolve supply
[    0.997008] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    0.997214] avdd_hdmi: unable to resolve supply
[    0.997378] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    0.997522] cam_1v8: unable to resolve supply
[    0.997688] reg-fixed-voltage regulators:regulator@108: Looking up vin-supply from device tree
[    0.997831] dsp_1v8: unable to resolve supply
[    0.997995] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    0.998200] isp_power: unable to resolve supply
[    0.998307] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    0.998511] dsp_power: unable to resolve supply
[    0.999433] tps65910 4-002d: Looking up vcc5-supply from device tree
[    0.999624] ldo4: supplied by vdd_ac_bat
[    0.999731] vdd_ac_bat: could not add device link regulator.28 err -2
[    1.009974] vdd_rtc: 1200 mV 
[    1.010331] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    1.010549] wifi_3v3: unable to resolve supply
[    1.010657] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    1.010864] bt_3v3: unable to resolve supply
[    1.010971] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    1.011176] gps_en: unable to resolve supply
[    1.011282] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    1.011487] vdd_cam1_ldo: unable to resolve supply
[    1.011595] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    1.011799] vdd_pnl1: unable to resolve supply
[    1.011963] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    1.012110] vdd_cam3_ldo: unable to resolve supply
[    1.012276] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    1.012481] vdd_com: unable to resolve supply
[    1.012587] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    1.012792] vdd_fuse_3v3: unable to resolve supply
[    1.012901] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    1.013106] hdmi_con_5v: unable to resolve supply
[    1.013213] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    1.013415] avdd_hdmi_pll: unable to resolve supply
[    1.013523] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    1.013730] avdd_hdmi: unable to resolve supply
[    1.013895] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    1.014039] cam_1v8: unable to resolve supply
[    1.014204] reg-fixed-voltage regulators:regulator@108: Looking up vin-supply from device tree
[    1.014405] dsp_1v8: unable to resolve supply
[    1.014512] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    1.014717] isp_power: unable to resolve supply
[    1.014824] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    1.015030] dsp_power: unable to resolve supply
[    1.015956] tps65910 4-002d: Looking up vcc4-supply from device tree
[    1.016157] ldo5: unable to resolve supply
[    1.016473] ldo5: 1000 mV 
[    1.016798] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    1.017014] wifi_3v3: unable to resolve supply
[    1.017180] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    1.017329] bt_3v3: unable to resolve supply
[    1.017493] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    1.017642] gps_en: unable to resolve supply
[    1.017805] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    1.018011] vdd_cam1_ldo: unable to resolve supply
[    1.018121] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    1.018325] vdd_pnl1: unable to resolve supply
[    1.018431] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    1.018636] vdd_cam3_ldo: unable to resolve supply
[    1.018743] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    1.018949] vdd_com: unable to resolve supply
[    1.019056] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    1.019261] vdd_fuse_3v3: unable to resolve supply
[    1.019427] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    1.019575] hdmi_con_5v: unable to resolve supply
[    1.019739] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    1.019974] avdd_hdmi_pll: unable to resolve supply
[    1.020088] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    1.020296] avdd_hdmi: unable to resolve supply
[    1.020404] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    1.020606] cam_1v8: unable to resolve supply
[    1.020713] reg-fixed-voltage regulators:regulator@108: Looking up vin-supply from device tree
[    1.020914] dsp_1v8: unable to resolve supply
[    1.021019] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    1.021225] isp_power: unable to resolve supply
[    1.021390] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    1.021538] dsp_power: unable to resolve supply
[    1.021707] tps65910 4-002d: Looking up vcc4-supply from device tree
[    1.021843] ldo5: unable to resolve supply
[    1.022816] tps65910 4-002d: Looking up vcc3-supply from device tree
[    1.022954] ldo6: supplied by vio
[    1.023118] vio: could not add device link regulator.30 err -2
[    1.023518] avdd_dsi_csi,pwrdet_mipi: 1200 mV 
[    1.023852] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    1.024069] wifi_3v3: unable to resolve supply
[    1.024236] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    1.024386] bt_3v3: unable to resolve supply
[    1.024549] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    1.024757] gps_en: unable to resolve supply
[    1.024862] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    1.025069] vdd_cam1_ldo: unable to resolve supply
[    1.025178] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    1.025386] vdd_pnl1: unable to resolve supply
[    1.025492] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    1.025699] vdd_cam3_ldo: unable to resolve supply
[    1.025806] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    1.026013] vdd_com: unable to resolve supply
[    1.026177] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    1.026325] vdd_fuse_3v3: unable to resolve supply
[    1.026491] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    1.026641] hdmi_con_5v: unable to resolve supply
[    1.026806] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    1.027007] avdd_hdmi_pll: unable to resolve supply
[    1.027116] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    1.027325] avdd_hdmi: unable to resolve supply
[    1.027431] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    1.027634] cam_1v8: unable to resolve supply
[    1.027741] reg-fixed-voltage regulators:regulator@108: Looking up vin-supply from device tree
[    1.027942] dsp_1v8: unable to resolve supply
[    1.028104] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    1.028253] isp_power: unable to resolve supply
[    1.028418] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    1.028568] dsp_power: unable to resolve supply
[    1.028739] tps65910 4-002d: Looking up vcc4-supply from device tree
[    1.028876] ldo5: unable to resolve supply
[    1.029850] tps65910 4-002d: Looking up vcc3-supply from device tree
[    1.030016] ldo7: supplied by vio
[    1.030184] vio: could not add device link regulator.31 err -2
[    1.039974] ldo7: 1200 mV 
[    1.040300] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    1.040517] wifi_3v3: unable to resolve supply
[    1.040685] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    1.040836] bt_3v3: unable to resolve supply
[    1.041000] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    1.041149] gps_en: unable to resolve supply
[    1.041312] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    1.041519] vdd_cam1_ldo: unable to resolve supply
[    1.041629] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    1.041836] vdd_pnl1: unable to resolve supply
[    1.041942] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    1.042150] vdd_cam3_ldo: unable to resolve supply
[    1.042258] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    1.042464] vdd_com: unable to resolve supply
[    1.042569] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    1.042776] vdd_fuse_3v3: unable to resolve supply
[    1.042942] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    1.043091] hdmi_con_5v: unable to resolve supply
[    1.043255] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    1.043457] avdd_hdmi_pll: unable to resolve supply
[    1.043565] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    1.043774] avdd_hdmi: unable to resolve supply
[    1.043881] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    1.044082] cam_1v8: unable to resolve supply
[    1.044190] reg-fixed-voltage regulators:regulator@108: Looking up vin-supply from device tree
[    1.044390] dsp_1v8: unable to resolve supply
[    1.044495] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    1.044704] isp_power: unable to resolve supply
[    1.044868] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    1.045018] dsp_power: unable to resolve supply
[    1.045188] tps65910 4-002d: Looking up vcc4-supply from device tree
[    1.045325] ldo5: unable to resolve supply
[    1.046299] tps65910 4-002d: Looking up vcc3-supply from device tree
[    1.046438] ldo8: supplied by vio
[    1.046610] vio: could not add device link regulator.32 err -2
[    1.049982] vdd_ddr_hs: 1000 mV 
[    1.050316] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    1.050534] wifi_3v3: unable to resolve supply
[    1.050644] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    1.050853] bt_3v3: unable to resolve supply
[    1.051017] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    1.051169] gps_en: unable to resolve supply
[    1.051331] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    1.051481] vdd_cam1_ldo: unable to resolve supply
[    1.051647] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    1.051856] vdd_pnl1: unable to resolve supply
[    1.051962] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    1.052169] vdd_cam3_ldo: unable to resolve supply
[    1.052277] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    1.052485] vdd_com: unable to resolve supply
[    1.052590] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    1.052798] vdd_fuse_3v3: unable to resolve supply
[    1.052964] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    1.053115] hdmi_con_5v: unable to resolve supply
[    1.053280] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    1.053424] avdd_hdmi_pll: unable to resolve supply
[    1.053589] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    1.053798] avdd_hdmi: unable to resolve supply
[    1.053904] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    1.054105] cam_1v8: unable to resolve supply
[    1.054211] reg-fixed-voltage regulators:regulator@108: Looking up vin-supply from device tree
[    1.054411] dsp_1v8: unable to resolve supply
[    1.054517] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    1.054725] isp_power: unable to resolve supply
[    1.054889] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    1.055040] dsp_power: unable to resolve supply
[    1.055211] tps65910 4-002d: Looking up vcc4-supply from device tree
[    1.055349] ldo5: unable to resolve supply
[    1.057138] vdd_core: 1000 <--> 1350 mV at 1300 mV 
[    1.057485] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    1.057706] wifi_3v3: unable to resolve supply
[    1.057815] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    1.058025] bt_3v3: unable to resolve supply
[    1.058130] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    1.058339] gps_en: unable to resolve supply
[    1.058444] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    1.058653] vdd_cam1_ldo: unable to resolve supply
[    1.058819] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    1.058969] vdd_pnl1: unable to resolve supply
[    1.059131] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    1.059341] vdd_cam3_ldo: unable to resolve supply
[    1.059448] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    1.059657] vdd_com: unable to resolve supply
[    1.059762] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    1.060006] vdd_fuse_3v3: unable to resolve supply
[    1.060118] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    1.060329] hdmi_con_5v: unable to resolve supply
[    1.060437] reg-fixed-voltage regulators:regulator@102: Looking up vin-supply from device tree
[    1.060639] avdd_hdmi_pll: supplied by vio
[    1.060894] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    1.061051] avdd_hdmi: unable to resolve supply
[    1.061216] reg-fixed-voltage regulators:regulator@104: Looking up vin-supply from device tree
[    1.061360] cam_1v8: supplied by vio
[    1.061618] reg-fixed-voltage regulators:regulator@108: Looking up vin-supply from device tree
[    1.061827] dsp_1v8: supplied by vio
[    1.062053] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    1.062271] isp_power: unable to resolve supply
[    1.062380] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    1.062590] dsp_power: unable to resolve supply
[    1.062703] tps65910 4-002d: Looking up vcc4-supply from device tree
[    1.062901] ldo5: unable to resolve supply
[    1.065718] clocksource: Switched to clocksource timer_us
[    1.148041] ------------[ cut here ]------------
[    1.148211] WARNING: CPU: 1 PID: 1 at arch/arm/mm/ioremap.c:303 __arm_ioremap_pfn_caller+0xe0/0x1bc
[    1.148396] Modules linked in:
[    1.148500] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc8mq-00034-g83dcf8d77845 #16
[    1.148681] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[    1.148813] [<b0111cb0>] (unwind_backtrace) from [<b010d2f8>] (show_stack+0x18/0x1c)
[    1.149000] [<b010d2f8>] (show_stack) from [<b06d1934>] (dump_stack+0x88/0x9c)
[    1.149191] [<b06d1934>] (dump_stack) from [<b0122c84>] (__warn.part.3+0xc4/0xe0)
[    1.149317] [<b0122c84>] (__warn.part.3) from [<b0122dd0>] (warn_slowpath_null+0x4c/0x54)
[    1.149504] [<b0122dd0>] (warn_slowpath_null) from [<b0118944>] (__arm_ioremap_pfn_caller+0xe0/0x1bc)
[    1.149696] [<b0118944>] (__arm_ioremap_pfn_caller) from [<b0118a70>] (__arm_ioremap_caller+0x50/0x58)
[    1.149892] [<b0118a70>] (__arm_ioremap_caller) from [<b048299c>] (simplefb_probe+0x210/0x8a0)
[    1.150026] [<b048299c>] (simplefb_probe) from [<b04e09c0>] (platform_drv_probe+0x50/0xa0)
[    1.150222] [<b04e09c0>] (platform_drv_probe) from [<b04de4c8>] (really_probe+0x254/0x418)
[    1.150409] [<b04de4c8>] (really_probe) from [<b04de870>] (driver_probe_device+0x80/0x1c8)
[    1.150596] [<b04de870>] (driver_probe_device) from [<b04dc43c>] (bus_for_each_drv+0x78/0x9c)
[    1.150727] [<b04dc43c>] (bus_for_each_drv) from [<b04de1d4>] (__device_attach+0xbc/0x14c)
[    1.150913] [<b04de1d4>] (__device_attach) from [<b04dd3d0>] (bus_probe_device+0x90/0x98)
[    1.151100] [<b04dd3d0>] (bus_probe_device) from [<b04d9e68>] (device_add+0x410/0x654)
[    1.151294] [<b04d9e68>] (device_add) from [<b05bf140>] (of_platform_device_create_pdata+0x9c/0xc4)
[    1.151442] [<b05bf140>] (of_platform_device_create_pdata) from [<b0a2ee88>] (simplefb_init+0x78/0x94)
[    1.151640] [<b0a2ee88>] (simplefb_init) from [<b0102d84>] (do_one_initcall+0x98/0x2f4)
[    1.151838] [<b0102d84>] (do_one_initcall) from [<b0a012e0>] (kernel_init_freeable+0x3fc/0x4a0)
[    1.152028] [<b0a012e0>] (kernel_init_freeable) from [<b06e8758>] (kernel_init+0x10/0x11c)
[    1.152155] [<b06e8758>] (kernel_init) from [<b01010d8>] (ret_from_fork+0x14/0x3c)
[    1.152332] Exception stack(0xeecf7fb0 to 0xeecf7ff8)
[    1.152496] 7fa0:                                     00000000 00000000 00000000 00000000
[    1.152621] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.152802] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    1.152982] ---[ end trace ed29ba7cfca1aeed ]---
[    1.153111] simple-framebuffer: probe of abc01000.framebuffer failed with error -12
[    1.167808] NET: Registered protocol family 2
[    1.169192] tcp_listen_portaddr_hash hash table entries: 512 (order: 2, 20480 bytes)
[    1.169452] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    1.169668] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    1.170618] TCP: Hash tables configured (established 8192 bind 8192)
[    1.171114] UDP hash table entries: 512 (order: 3, 40960 bytes)
[    1.171369] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)
[    1.171922] NET: Registered protocol family 1
[    1.172536] Unpacking initramfs...
[    3.065389] Freeing initrd memory: 4400K
[    3.067198] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available
[    3.073895] alarmtimer alarmtimer: no of_node; not parsing pinctrl DT
[    3.075894] workingset: timestamp_bits=14 max_order=18 bucket_order=4
[    3.184999] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    3.187557] tegra30-pinctrl 70000868.pinmux: request pin 58 (GMI_AD10 PH2) for tegra-gpio:58
[    3.187772] pwm-backlight backlight: Looking up power-supply from device tree
[    3.188081] pwm-backlight backlight: Linked as a consumer to regulator.5
[    3.194596] tegra-apbdma 6000a000.dma: Tegra20 APB DMA driver register 32 channels
[    3.196236] tegra-pmc 7000e400.pmc: emergency thermal reset enabled
[    3.197618] 70006040.serial: ttyTHS1 at MMIO 0x70006040 (irq = 76, base_baud = 0) is a TEGRA_UART
[    3.198189] serial serial0: tty port ttyTHS1 registered
[    3.198555] 70006200.serial: ttyTHS0 at MMIO 0x70006200 (irq = 77, base_baud = 0) is a TEGRA_UART
[    3.198897] serial serial1: tty port ttyTHS0 registered
[    3.199929] tegra30-pinctrl 70000868.pinmux: request pin 129 (KB_COL1 PQ1) for tegra-gpio:129
[    3.487758] random: fast init done
[    3.502776] asus-ec 1-0015: model         : ASUS-TF201-PAD
[    3.508327] asus-ec 1-0015: FW version    : PAD-EC20T-0216
[    3.512939] asus-ec 1-0015: Config format : ECFG-0001
[    3.517741] asus-ec 1-0015: HW version    : TF201-PAD-SKU1
[    3.522543] asus-ec 1-0015: EC FW behaviour: susb on when system wakeup
[    3.531314] tun: Universal TUN/TAP device driver, 1.6
[    3.532088] tegra-phy 7d000000.usb-phy: no vbus regulator
[    3.533500] tegra-phy 7d008000.usb-phy: no vbus regulator
[    3.533997] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.534141] tegra-ehci: Tegra EHCI driver
[    3.538686] tegra-ehci 7d008000.usb: EHCI Host Controller
[    3.538970] tegra-ehci 7d008000.usb: new USB bus registered, assigned bus number 1
[    3.540148] tegra-ehci 7d008000.usb: irq 92, io mem 0x7d008000
[    3.565736] tegra-ehci 7d008000.usb: USB 2.0 started, EHCI 1.00
[    3.566693] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.00
[    3.566888] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.567010] usb usb1: Product: EHCI Host Controller
[    3.567175] usb usb1: Manufacturer: Linux 5.0.0-rc8mq-00034-g83dcf8d77845 ehci_hcd
[    3.567296] usb usb1: SerialNumber: 7d008000.usb
[    3.568460] hub 1-0:1.0: USB hub found
[    3.568652] hub 1-0:1.0: 1 port detected
[    3.572359] ci_hdrc ci_hdrc.0: no of_node; not parsing pinctrl DT
[    3.793647] printk: console [ttyGS0] enabled
[    3.793801] g_serial gadget: Gadget Serial v2.4
[    3.793921] g_serial gadget: g_serial ready
[    3.795061] elants_i2c 1-0010: Looking up vcc33-supply from device tree
[    3.795216] elants_i2c 1-0010: Looking up vcc33-supply property in node /i2c@7000c400/touchscreen@10 failed
[    3.795480] elants_i2c 1-0010: 1-0010 supply vcc33 not found, using dummy regulator
[    3.795793] tegra_rtc 7000e000.rtc: registered as rtc1
[    3.795845] elants_i2c 1-0010: Linked as a consumer to regulator.0
[    3.795993] tegra_rtc 7000e000.rtc: Tegra internal Real Time Clock
[    3.796110] elants_i2c 1-0010: Looking up vccio-supply from device tree
[    3.796413] elants_i2c 1-0010: Looking up vccio-supply property in node /i2c@7000c400/touchscreen@10 failed
[    3.796536] tps65910-rtc tps65910-rtc: no of_node; not parsing pinctrl DT
[    3.796650] elants_i2c 1-0010: 1-0010 supply vccio not found, using dummy regulator
[    3.797070] tegra30-pinctrl 70000868.pinmux: request pin 62 (GMI_AD14 PH6) for tegra-gpio:62
[    3.805983] tps65910-rtc tps65910-rtc: registered as rtc0
[    3.806171] i2c /dev entries driver
[    3.807702] tegra30-pinctrl 70000868.pinmux: request pin 164 (PU4) for tegra-gpio:164
[    3.808376] asusec-battery asusec-battery.0.auto: no of_node; not parsing pinctrl DT
[    3.810317] tegra-wdt 60005000.timer: initialized (heartbeat = 30 sec, nowayout = 0)
[    3.811061] device-mapper: uevent: version 1.0.3
[    3.811663] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[    3.812443] ledtrig-cpu: registered to indicate activity on CPUs
[    3.812818] usbcore: registered new interface driver usbhid
[    3.813003] usbhid: USB HID core driver
[    3.813654] gnss: GNSS driver registered with major 245
[    3.814092] NET: Registered protocol family 17
[    3.814251] NET: Registered protocol family 15
[    3.815264] Registering SWP/SWPB emulation handler
[    3.821624] zswap: default zpool zbud not available
[    3.821904] zswap: pool creation failed
[    3.822753] pstore: Using crash dump compression: deflate
[    3.837321] input input0: DT specifies parameters but the axis 53 is not set up
[    3.837575] input input0: DT specifies parameters but the axis 54 is not set up
[    3.850843] reg-fixed-voltage regulators:regulator@0: Looking up vin-supply from device tree
[    3.851149] cp_5v: supplied by vdd_ac_bat
[    3.851348] vdd_ac_bat: could not add device link regulator.34 err -2
[    3.851834] cp_5v: 5000 mV 
[    3.852216] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    3.852468] wifi_3v3: unable to resolve supply
[    3.852597] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    3.852822] bt_3v3: unable to resolve supply
[    3.853008] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    3.853169] gps_en: unable to resolve supply
[    3.853344] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    3.853578] vdd_cam1_ldo: unable to resolve supply
[    3.853691] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    3.853918] vdd_pnl1: unable to resolve supply
[    3.854033] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    3.854267] vdd_cam3_ldo: unable to resolve supply
[    3.854388] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    3.854617] vdd_com: unable to resolve supply
[    3.854745] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    3.854966] vdd_fuse_3v3: unable to resolve supply
[    3.855155] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    3.855318] hdmi_con_5v: unable to resolve supply
[    3.855495] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    3.855668] avdd_hdmi: unable to resolve supply
[    3.855923] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    3.856181] isp_power: unable to resolve supply
[    3.856300] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    3.856544] dsp_power: unable to resolve supply
[    3.856667] tps65910 4-002d: Looking up vcc4-supply from device tree
[    3.856887] ldo5: unable to resolve supply
[    3.857019] reg-fixed-voltage regulators:regulator@0: cp_5v supplying 5000000uV
[    3.857897] reg-fixed-voltage regulators:regulator@1: Looking up vin-supply from device tree
[    3.858125] 5v0: supplied by vdd_ac_bat
[    3.858241] vdd_ac_bat: could not add device link regulator.35 err -2
[    3.858714] 5v0: 5000 mV 
[    3.859117] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    3.859298] wifi_3v3: unable to resolve supply
[    3.859472] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    3.859706] bt_3v3: unable to resolve supply
[    3.859819] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    3.860043] gps_en: unable to resolve supply
[    3.860168] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    3.860389] vdd_cam1_ldo: unable to resolve supply
[    3.860518] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    3.860738] vdd_pnl1: unable to resolve supply
[    3.860854] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    3.861088] vdd_cam3_ldo: unable to resolve supply
[    3.861264] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    3.861438] vdd_com: unable to resolve supply
[    3.861609] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    3.861781] vdd_fuse_3v3: unable to resolve supply
[    3.861956] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    3.862178] hdmi_con_5v: unable to resolve supply
[    3.862306] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    3.862527] avdd_hdmi: unable to resolve supply
[    3.862654] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    3.862888] isp_power: unable to resolve supply
[    3.863002] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    3.863237] dsp_power: unable to resolve supply
[    3.863419] tps65910 4-002d: Looking up vcc4-supply from device tree
[    3.863582] ldo5: unable to resolve supply
[    3.863699] reg-fixed-voltage regulators:regulator@1: 5v0 supplying 5000000uV
[    3.864717] vdd_ddr: 1500 mV 
[    3.865056] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    3.865292] wifi_3v3: unable to resolve supply
[    3.865471] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    3.865638] bt_3v3: unable to resolve supply
[    3.865875] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    3.866057] gps_en: unable to resolve supply
[    3.866246] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    3.866484] vdd_cam1_ldo: unable to resolve supply
[    3.866604] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    3.866839] vdd_pnl1: unable to resolve supply
[    3.866965] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    3.867189] vdd_cam3_ldo: unable to resolve supply
[    3.867315] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    3.867538] vdd_com: unable to resolve supply
[    3.867653] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    3.867886] vdd_fuse_3v3: unable to resolve supply
[    3.868058] reg-fixed-voltage regulators:regulator@101: Looking up vin-supply from device tree
[    3.868231] hdmi_con_5v: supplied by 5v0
[    3.868507] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    3.868676] avdd_hdmi: unable to resolve supply
[    3.868864] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    3.869089] isp_power: unable to resolve supply
[    3.869215] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    3.869436] dsp_power: unable to resolve supply
[    3.869561] tps65910 4-002d: Looking up vcc4-supply from device tree
[    3.869772] ldo5: supplied by 5v0
[    3.869980] reg-fixed-voltage regulators:regulator@2: vdd_ddr supplying 1500000uV
[    3.871017] sys_3v3: 3300 mV 
[    3.871355] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    3.871593] wifi_3v3: unable to resolve supply
[    3.871713] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    3.871939] bt_3v3: unable to resolve supply
[    3.872056] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    3.872281] gps_en: unable to resolve supply
[    3.872397] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    3.872622] vdd_cam1_ldo: unable to resolve supply
[    3.872799] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    3.872965] vdd_pnl1: unable to resolve supply
[    3.873141] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    3.873307] vdd_cam3_ldo: unable to resolve supply
[    3.873486] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    3.873712] vdd_com: unable to resolve supply
[    3.873829] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    3.874052] vdd_fuse_3v3: unable to resolve supply
[    3.874174] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    3.874399] avdd_hdmi: unable to resolve supply
[    3.874520] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    3.874747] isp_power: unable to resolve supply
[    3.874865] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    3.875088] dsp_power: unable to resolve supply
[    3.875279] reg-fixed-voltage regulators:regulator@3: sys_3v3 supplying 3300000uV
[    3.876296] tegra30-pinctrl 70000868.pinmux: request pin 168 (PV0) for tegra-gpio:168
[    3.876642] tegra30-pinctrl 70000868.pinmux: request pin 131 (KB_COL3 PQ3) for tegra-gpio:131
[    3.876944] tegra30-pinctrl 70000868.pinmux: request pin 130 (KB_COL2 PQ2) for tegra-gpio:130
[    3.877598] input: pad-buttons as /devices/soc0/pad-buttons/input/input1
[    3.878838] tegra30-pinctrl 70000868.pinmux: request pin 150 (KB_ROW14 PS6) for tegra-gpio:150
[    3.879164] tegra30-pinctrl 70000868.pinmux: request pin 61 (GMI_AD13 PH5) for tegra-gpio:61
[    3.879455] tegra30-pinctrl 70000868.pinmux: request pin 187 (SPI2_CS0_N PX3) for tegra-gpio:187
[    3.879885] input: extcon-keys as /devices/soc0/extcon-keys/input/input2
[    3.883618] tps65910-rtc tps65910-rtc: setting system clock to 2019-02-25T03:49:17 UTC (1551066557)
[    3.884062] clk: Not disabling unused clocks
[    3.884196] reg-fixed-voltage regulators:regulator@21: Looking up vin-supply from device tree
[    3.884432] wifi_3v3: supplied by sys_3v3
[    3.884652] reg-fixed-voltage regulators:regulator@22: Looking up vin-supply from device tree
[    3.884884] bt_3v3: supplied by sys_3v3
[    3.885115] reg-fixed-voltage regulators:regulator@23: Looking up vin-supply from device tree
[    3.885350] gps_en: supplied by sys_3v3
[    3.885551] reg-fixed-voltage regulators:regulator@18: Looking up vin-supply from device tree
[    3.885849] vdd_cam1_ldo: supplied by sys_3v3
[    3.886076] reg-fixed-voltage regulators:regulator@6: Looking up vin-supply from device tree
[    3.886251] vdd_pnl1: supplied by sys_3v3
[    3.886527] reg-fixed-voltage regulators:regulator@7: Looking up vin-supply from device tree
[    3.886701] vdd_cam3_ldo: supplied by sys_3v3
[    3.886957] reg-fixed-voltage regulators:regulator@8: Looking up vin-supply from device tree
[    3.887133] vdd_com: supplied by sys_3v3
[    3.887433] reg-fixed-voltage regulators:regulator@9: Looking up vin-supply from device tree
[    3.887663] vdd_fuse_3v3: supplied by sys_3v3
[    3.887879] reg-fixed-voltage regulators:regulator@103: Looking up vin-supply from device tree
[    3.888108] avdd_hdmi: supplied by sys_3v3
[    3.888321] reg-fixed-voltage regulators:regulator@109: Looking up vin-supply from device tree
[    3.888551] isp_power: supplied by sys_3v3
[    3.888767] reg-fixed-voltage regulators:regulator@110: Looking up vin-supply from device tree
[    3.888991] dsp_power: supplied by sys_3v3
[    3.889214] wifi_3v3: disabling
[    3.889390] bt_3v3: disabling
[    3.889499] gps_en: disabling
[    3.889609] vdd_cam1_ldo: disabling
[    3.889725] modem_3v3: disabling
[    3.889895] vdd_cam3_ldo: disabling
[    3.890007] vdd_com: disabling
[    3.890117] vdd_fuse_3v3: disabling
[    3.890286] icatch7002a_vddc: disabling
[    3.890400] hdmi_con_5v: disabling
[    3.890511] avdd_hdmi_pll: disabling
[    3.890680] avdd_hdmi: disabling
[    3.890791] cam_1v8: disabling
[    3.890901] dsp_1v8: disabling
[    3.891010] isp_power: disabling
[    3.891177] dsp_power: disabling
[    3.920281] asus-ec 1-0015: model         : ASUS-TF201-PAD
[    3.925761] asus-ec 1-0015: FW version    : PAD-EC20T-0216
[    3.929618] asus-ec 1-0015: Config format : ECFG-0001
[    3.933714] asus-ec 1-0015: HW version    : TF201-PAD-SKU1
[    3.938553] asus-ec 1-0015: EC FW behaviour: susb on when system wakeup
[    3.971816] input: Elan Touchscreen as /devices/soc0/7000c400.i2c/i2c-1/1-0010/input/input0
[    3.978119] Freeing unused kernel memory: 1024K
[    3.979071] Run /init as init process
[    4.014082] Early linuxrc.
[    4.050599] /bin/mount
[    4.050610] : 
[    4.050768] /mnt
[    4.050877] : 
[    4.051041] mount failed: Operation not permitted
[    4.051146] .
[    4.051265] 
[    4.124834] g_serial gadget: high-speed config #2: CDC ACM config
[    4.156645] udevd[135]: starting version 3.2.5
[    4.157871] random: udevd: uninitialized urandom read (16 bytes read)
[    4.158413] random: udevd: uninitialized urandom read (16 bytes read)
[    4.158645] random: udevd: uninitialized urandom read (16 bytes read)
[    4.168919] udevd[136]: starting eudev-3.2.5
[    4.392305] asus-ec 1-0015: model         : ASUS-TF201-PAD
[    4.397269] asus-ec 1-0015: FW version    : PAD-EC20T-0216
[    4.402063] asus-ec 1-0015: Config format : ECFG-0001
[    4.406483] asus-ec 1-0015: HW version    : TF201-PAD-SKU1
[    4.411372] asus-ec 1-0015: EC FW behaviour: susb on when system wakeup
[  195.498875] PM: suspend entry (deep)
[  195.499025] PM: Syncing filesystems ... done.
[  195.502919] Freezing user space processes ... (elapsed 0.001 seconds) done.
[  195.504646] OOM killer disabled.
[  195.504752] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[  195.540806] Disabling non-boot CPUs ...
[  195.541923] IRQ 17: no longer affine to CPU1
[  195.547497] Entering suspend state LP1
[  195.547783] Enabling non-boot CPUs ...
[  195.549230] CPU1 is up
[  195.550554] CPU2 is up
[  195.551850] CPU3 is up
[  195.606711] OOM killer enabled.
[  195.606845] Restarting tasks ... done.
[  195.699137] asus-ec 1-0015: model         : ASUS-TF201-PAD
[  195.705020] asus-ec 1-0015: FW version    : PAD-EC20T-0216
[  195.710115] asus-ec 1-0015: Config format : ECFG-0001
[  195.714537] asus-ec 1-0015: HW version    : TF201-PAD-SKU1
[  195.719668] asus-ec 1-0015: EC FW behaviour: susb on when system wakeup
[  195.899815] PM: suspend exit
[  195.968537] g_serial gadget: high-speed config #2: CDC ACM config
[  267.551923] random: crng init done
[  267.552079] random: 4 urandom warning(s) missed due to ratelimiting
[  491.765815] PM: suspend entry (deep)
[  491.765961] PM: Syncing filesystems ... done.
[  491.767010] Freezing user space processes ... (elapsed 0.001 seconds) done.
[  491.768425] OOM killer disabled.
[  491.768532] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[  491.800029] Disabling non-boot CPUs ...
[  491.800911] IRQ 17: no longer affine to CPU1
[  491.804777] Entering suspend state LP1
[  491.804826] Enabling non-boot CPUs ...
[  491.806501] CPU1 is up
[  491.807912] CPU2 is up
[  491.809302] CPU3 is up
[  491.867327] OOM killer enabled.
[  491.867462] Restarting tasks ... done.
[  491.961536] asus-ec 1-0015: model         : ASUS-TF201-PAD
[  491.966976] asus-ec 1-0015: FW version    : PAD-EC20T-0216
[  491.971775] asus-ec 1-0015: Config format : ECFG-0001
[  491.976524] asus-ec 1-0015: HW version    : TF201-PAD-SKU1
[  491.981500] asus-ec 1-0015: EC FW behaviour: susb on when system wakeup
[  492.159889] PM: suspend exit
[  492.205197] g_serial gadget: high-speed config #2: CDC ACM config

--7AUc2qLy4jB3hD7Z--
