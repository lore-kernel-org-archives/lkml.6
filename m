Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754988AbeBAUW6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 15:22:58 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:37874 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754928AbeBAUWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 15:22:50 -0500
X-Google-Smtp-Source: AH8x224vmaDbOtTThIhMSxbS8avakPi6r8O6j5qSe80AxniWr53TBS1HcfZWXEMknx10NBYAYxGMSQ==
Date: Thu, 1 Feb 2018 12:22:46 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+2c5eaba9c401949a52c043b08488931c0c275aec@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: unexpected kernel reboot
Message-ID: <20180201202246.74wz5eop7yqn7xdq@gmail.com>
References: <94eb2c19e7562ca97a05605d50da@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94eb2c19e7562ca97a05605d50da@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2017 at 01:06:16AM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> d5c52866f560ba43edcb941868e1f884f15234e5
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> Linux version 4.15.0-rc2-next-20171206+ (syzkaller@ci) (gcc version 7.1.1
> 20170620 (GCC)) #60 SMP Wed Dec 6 04:36:07 UTC 2017
> Command line: BOOT_IMAGE=/vmlinuz root=/dev/sda1 console=ttyS0
> earlyprintk=serial vsyscall=native rodata=n ftrace_dump_on_oops=orig_cpu
> oops=panic panic_on_warn=1 nmi_watchdog=panic panic=86400 kvm-intel.nested=1
> x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using
> 'standard' format.
> e820: BIOS-provided physical RAM map:
> BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> BIOS-e820: [mem 0x0000000000100000-0x00000000bfffcfff] usable
> BIOS-e820: [mem 0x00000000bfffd000-0x00000000bfffffff] reserved
> BIOS-e820: [mem 0x00000000fffbc000-0x00000000ffffffff] reserved
> BIOS-e820: [mem 0x0000000100000000-0x000000021fffffff] usable
> bootconsole [earlyser0] enabled
> NX (Execute Disable) protection: active
> random: fast init done
> SMBIOS 2.4 present.
> DMI: Google Google Compute Engine/Google Compute Engine, BIOS Google
> 01/01/2011
> Hypervisor detected: KVM
> e820: last_pfn = 0x220000 max_arch_pfn = 0x400000000
> x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
> e820: last_pfn = 0xbfffd max_arch_pfn = 0x400000000
> found SMP MP-table at [mem 0x000f32a0-0x000f32af] mapped at [
> (ptrval)]
> Scanning 1 areas for low memory corruption
> Using GB pages for direct mapping
> ACPI: Early table checksum verification disabled
> ACPI: RSDP 0x00000000000F3070 000014 (v00 Google)
> ACPI: RSDT 0x00000000BFFFDC70 000034 (v01 Google GOOGRSDT 00000001 GOOG
> 00000001)
> ACPI: FACP 0x00000000BFFFFF00 0000F4 (v02 Google GOOGFACP 00000001 GOOG
> 00000001)
> ACPI: DSDT 0x00000000BFFFDCB0 0017B2 (v01 Google GOOGDSDT 00000001 GOOG
> 00000001)
> ACPI: FACS 0x00000000BFFFFEC0 000040
> ACPI: FACS 0x00000000BFFFFEC0 000040
> ACPI: SSDT 0x00000000BFFFF590 000930 (v01 Google GOOGSSDT 00000001 GOOG
> 00000001)
> ACPI: APIC 0x00000000BFFFF4A0 000076 (v01 Google GOOGAPIC 00000001 GOOG
> 00000001)
> ACPI: WAET 0x00000000BFFFF470 000028 (v01 Google GOOGWAET 00000001 GOOG
> 00000001)
> No NUMA configuration found
> Faking a node at [mem 0x0000000000000000-0x000000021fffffff]
> NODE_DATA(0) allocated [mem 0x21fffa000-0x21fffdfff]
> kvm-clock: cpu 0, msr 2:1fff8001, primary cpu clock
> kvm-clock: Using msrs 4b564d01 and 4b564d00
> kvm-clock: using sched offset of 1978954790 cycles
> clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb,
> max_idle_ns: 881590591483 ns
> Zone ranges:
>   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>   Normal   [mem 0x0000000100000000-0x000000021fffffff]
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000000001000-0x000000000009efff]
>   node   0: [mem 0x0000000000100000-0x00000000bfffcfff]
>   node   0: [mem 0x0000000100000000-0x000000021fffffff]
> Initmem setup node 0 [mem 0x0000000000001000-0x000000021fffffff]
> Reserved but unavailable: 98 pages
> kasan: KernelAddressSanitizer initialized
> ACPI: PM-Timer IO Port: 0xb008
> ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
> IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
> ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
> Using ACPI (MADT) for SMP configuration information
> smpboot: Allowing 2 CPUs, 0 hotplug CPUs
> PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
> PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
> PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
> PM: Registered nosave memory: [mem 0xbfffd000-0xbfffffff]
> PM: Registered nosave memory: [mem 0xc0000000-0xfffbbfff]
> PM: Registered nosave memory: [mem 0xfffbc000-0xffffffff]
> e820: [mem 0xc0000000-0xfffbbfff] available for PCI devices
> Booting paravirtualized kernel on KVM
> clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
> max_idle_ns: 1910969940391419 ns
> setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:2 nr_node_ids:1
> percpu: Embedded 50 pages/cpu @        (ptrval) s167568 r8192 d29040
> u1048576
> Built 1 zonelists, mobility grouping on.  Total pages: 1935238
> Policy zone: Normal
> Kernel command line: BOOT_IMAGE=/vmlinuz root=/dev/sda1 console=ttyS0
> earlyprintk=serial vsyscall=native rodata=n ftrace_dump_on_oops=orig_cpu
> oops=panic panic_on_warn=1 nmi_watchdog=panic panic=86400 kvm-intel.nested=1
> Memory: 6564592K/7863916K available (67164K kernel code, 8174K rwdata,
> 10684K rodata, 2348K init, 21532K bss, 1299324K reserved, 0K cma-reserved)
> Running RCU self tests
> Hierarchical RCU implementation.
> 	RCU lockdep checking is enabled.
> 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=2.
> RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
> NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
> Console: colour VGA+ 80x25
> console [ttyS0] enabled
> console [ttyS0] enabled
> bootconsole [earlyser0] disabled
> bootconsole [earlyser0] disabled
> Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> ... MAX_LOCKDEP_SUBCLASSES:  8
> ... MAX_LOCK_DEPTH:          48
> ... MAX_LOCKDEP_KEYS:        8191
> ... CLASSHASH_SIZE:          4096
> ... MAX_LOCKDEP_ENTRIES:     32768
> ... MAX_LOCKDEP_CHAINS:      65536
> ... CHAINHASH_SIZE:          32768
>  memory used by lock dependency info: 7391 kB
>  per task-struct memory footprint: 2304 bytes
> ACPI: Core revision 20171110
> ACPI: 2 ACPI AML tables successfully acquired and loaded
> APIC: Switch to symmetric I/O mode setup
> x2apic enabled
> Switched APIC routing to physical x2apic.
> ..TIMER: vector=0x30 apic1=0 pin1=0 apic2=-1 pin2=-1
> tsc: Detected 2300.000 MHz processor
> Calibrating delay loop (skipped) preset value.. 4600.00 BogoMIPS
> (lpj=2300000)
> pid_max: default: 32768 minimum: 301
> Security Framework initialized
> SELinux:  Initializing.
> Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
> Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
> Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
> CPU: Physical Processor ID: 0
> CPU: Processor Core ID: 0
> mce: CPU supports 32 MCE banks
> Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
> Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
> Freeing SMP alternatives memory: 40K
> smpboot: CPU0: Intel(R) Xeon(R) CPU @ 2.30GHz (family: 0x6, model: 0x3f,
> stepping: 0x0)
> Performance Events: unsupported p6 CPU model 63 no PMU driver, software
> events only.
> Hierarchical SRCU implementation.
> NMI watchdog: Perf event create on CPU 0 failed with -2
> NMI watchdog: Perf NMI watchdog permanently disabled
> smp: Bringing up secondary CPUs ...
> x86: Booting SMP configuration:
> .... node  #0, CPUs:      #1
> kvm-clock: cpu 1, msr 2:1fff8041, secondary cpu clock
> smp: Brought up 1 node, 2 CPUs
> smpboot: Max logical packages: 1
> smpboot: Total of 2 processors activated (9200.00 BogoMIPS)
> devtmpfs: initialized
> kworker/u4:0 (22) used greatest stack depth: 23664 bytes left
> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:
> 1911260446275000 ns
> futex hash table entries: 512 (order: 4, 65536 bytes)
> RTC time: 19:44:55, date: 12/06/17
> NET: Registered protocol family 16
> audit: initializing netlink subsys (disabled)
> audit: type=2000 audit(1512589495.682:1): state=initialized audit_enabled=0
> res=1
> cpuidle: using governor menu
> ACPI: bus type PCI registered
> PCI: Using configuration type 1 for base access
> kworker/u4:1 (282) used greatest stack depth: 21216 bytes left
> HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> cryptd: max_cpu_qlen set to 1000
> ACPI: Added _OSI(Module Device)
> ACPI: Added _OSI(Processor Device)
> ACPI: Added _OSI(3.0 _SCP Extensions)
> ACPI: Added _OSI(Processor Aggregator Device)
> ACPI: Executed 2 blocks of module-level executable AML code
> ACPI: Interpreter enabled
> ACPI: (supports S0 S3 S4 S5)
> ACPI: Using IOAPIC for interrupt routing
> PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and
> report a bug
> ACPI: Enabled 16 GPEs in block 00 to 0F
> ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
> acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
> acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI
> configuration space under this bridge.
> PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
> pci_bus 0000:00: root bus resource [bus 00-ff]
> pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX4 ACPI
> ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
> ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
> vgaarb: loaded
> SCSI subsystem initialized
> ACPI: bus type USB registered
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> pps_core: LinuxPPS API ver. 1 registered
> pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti
> <giometti@linux.it>
> PTP clock support registered
> EDAC MC: Ver: 3.0.0
> Advanced Linux Sound Architecture Driver Initialized.
> PCI: Using ACPI for IRQ routing
> Bluetooth: Core ver 2.22
> NET: Registered protocol family 31
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> Bluetooth: L2CAP socket layer initialized
> Bluetooth: SCO socket layer initialized
> NET: Registered protocol family 8
> NET: Registered protocol family 20
> NetLabel: Initializing
> NetLabel:  domain hash size = 128
> NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> NetLabel:  unlabeled traffic allowed by default
> nfc: nfc_init: NFC Core ver 0.1
> NET: Registered protocol family 39
> clocksource: Switched to clocksource kvm-clock
> VFS: Disk quotas dquot_6.6.0
> VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> FS-Cache: Loaded
> pnp: PnP ACPI init
> pnp: PnP ACPI: found 7 devices
> clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns:
> 2085701024 ns
> NET: Registered protocol family 2
> tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 327680 bytes)
> TCP established hash table entries: 65536 (order: 7, 524288 bytes)
> TCP bind hash table entries: 65536 (order: 10, 4718592 bytes)
> TCP: Hash tables configured (established 65536 bind 65536)
> UDP hash table entries: 4096 (order: 7, 655360 bytes)
> UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes)
> NET: Registered protocol family 1
> RPC: Registered named UNIX socket transport module.
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> RPC: Registered tcp NFSv4.1 backchannel transport module.
> pci 0000:00:00.0: Limiting direct PCI/PCI transfers
> PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> software IO TLB [mem 0xbbffd000-0xbfffd000] (64MB) mapped at
> [00000000a6fbbd9b-00000000ab54bbfe]
> RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 10737418240 ms ovfl
> timer
> RAPL PMU: hw unit of domain pp0-core 2^-0 Joules
> RAPL PMU: hw unit of domain package 2^-0 Joules
> RAPL PMU: hw unit of domain dram 2^-0 Joules
> RAPL PMU: hw unit of domain pp1-gpu 2^-0 Joules
> kvm: already loaded the other module
> Machine check injector initialized
> Scanning for low memory corruption every 60 seconds
> Initialise system trusted keyrings
> workingset: timestamp_bits=40 max_order=21 bucket_order=0
> NFS: Registering the id_resolver key type
> Key type id_resolver registered
> Key type id_legacy registered
> fuse init (API version 7.26)
> 9p: Installing v9fs 9p2000 file system support
> NET: Registered protocol family 38
> Key type asymmetric registered
> Asymmetric key parser 'x509' registered
> Key type pkcs7_test registered
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
> io scheduler noop registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> io scheduler mq-deadline registered
> io scheduler kyber registered
> io scheduler bfq registered
> input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> ACPI: Power Button [PWRF]
> input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
> ACPI: Sleep Button [SLPF]
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
> virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
> ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
> virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> 00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
> 00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
> Non-volatile memory driver v1.3
> Linux agpgart interface v0.103
> [drm] radeon kernel modesetting enabled.
> [drm] amdgpu kernel modesetting enabled.
> loop: module loaded
> null: module loaded
> nfcsim 0.2 initialized
> scsi host0: Virtio SCSI HBA
> scsi 0:0:1:0: Direct-Access     Google   PersistentDisk   1    PQ: 0 ANSI: 6
> sd 0:0:1:0: Attached scsi generic sg0 type 0
> sd 0:0:1:0: [sda] 4194304 512-byte logical blocks: (2.15 GB/2.00 GiB)
> tun: Universal TUN/TAP device driver, 1.6
> sd 0:0:1:0: [sda] 4096-byte physical blocks
> sd 0:0:1:0: [sda] Write Protect is off
> sd 0:0:1:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
> DPO or FUA
> e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
> e100: Copyright(c) 1999-2006 Intel Corporation
> e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
> e1000: Copyright (c) 1999-2006 Intel Corporation.
> e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> sky2: driver version 1.30
>  sda: sda1
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ehci-pci: EHCI PCI platform driver
> ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> ohci-pci: OHCI PCI platform driver
> uhci_hcd: USB Universal Host Controller Interface driver
> usbcore: registered new interface driver usblp
> usbcore: registered new interface driver usb-storage
> sd 0:0:1:0: [sda] Attached SCSI disk
> i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
> i8042: Warning: Keylock active
> serio: i8042 KBD port at 0x60,0x64 irq 1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> mousedev: PS/2 mouse device common for all mice
> rtc_cmos 00:00: RTC can wake from S4
> rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
> rtc_cmos 00:00: alarms up to one day, 114 bytes nvram
> device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initialised:
> dm-devel@redhat.com
> usbcore: registered new interface driver btusb
> hidraw: raw HID events driver (C) Jiri Kosina
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver
> NET: Registered protocol family 26
> Netfilter messages via NETLINK v0.30.
> nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
> ctnetlink v0.93: registering with nfnetlink.
> ip_tables: (C) 2000-2006 Netfilter Core Team
> Initializing XFRM netlink socket
> NET: Registered protocol family 10
> Segment Routing with IPv6
> ip6_tables: (C) 2000-2006 Netfilter Core Team
> sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> Bluetooth: RFCOMM TTY layer initialized
> Bluetooth: RFCOMM socket layer initialized
> Bluetooth: RFCOMM ver 1.11
> Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> Bluetooth: BNEP filters: protocol multicast
> Bluetooth: BNEP socket layer initialized
> Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> Bluetooth: HIDP socket layer initialized
> NET: Registered protocol family 41
> lec:lane_module_init: lec.c: initialized
> mpoa:atm_mpoa_init: mpc.c: initialized
> l2tp_core: L2TP core driver, V2.0
> 8021q: 802.1Q VLAN Support v1.8
> DCCP: Activated CCID 2 (TCP-like)
> DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
> sctp: Hash tables configured (bind 32/56)
> NET: Registered protocol family 21
> Registered RDS/tcp transport
> tipc: Activated (version 2.0.0)
> NET: Registered protocol family 30
> tipc: Started in single node mode
> 9pnet: Installing 9P2000 support
> Key type dns_resolver registered
> AVX2 version of gcm_enc/dec engaged.
> AES CTR mode by8 optimization enabled
> sched_clock: Marking stable (1181858202, 0)->(2095233647, -913375445)
> registered taskstats version 1
> Loading compiled-in X.509 certificates
> Key type big_key registered
> Key type encrypted registered
>   Magic number: 13:188:748
> console [netcon0] enabled
> netconsole: network logging started
> cfg80211: Loading compiled-in X.509 certificates for regulatory database
> cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> ALSA device list:
>   No soundcards found.
> platform regulatory.0: Direct firmware load for regulatory.db failed with
> error -2
> cfg80211: failed to load regulatory.db
> input: AT Translated Set 2 keyboard as
> /devices/platform/i8042/serio0/input/input2
> md: Waiting for all devices to be available before autodetect
> md: If you don't use raid, use raid=noautodetect
> tsc: Refined TSC clocksource calibration: 2299.802 MHz
> clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x21267a1d6e0,
> max_idle_ns: 440795287755 ns
> input: ImPS/2 Generic Wheel Mouse as
> /devices/platform/i8042/serio1/input/input4
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> EXT4-fs (sda1): couldn't mount as ext3 due to feature incompatibilities
> EXT4-fs (sda1): couldn't mount as ext2 due to feature incompatibilities
> EXT4-fs (sda1): INFO: recovery required on readonly filesystem
> EXT4-fs (sda1): write access will be enabled during recovery
> EXT4-fs (sda1): recovery complete
> EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
> VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
> devtmpfs: mounted
> Freeing unused kernel memory: 2348K
> Kernel memory protection disabled.
> stty (1485) used greatest stack depth: 19240 bytes left
> run-parts (1486) used greatest stack depth: 17680 bytes left
> mount (1531) used greatest stack depth: 16384 bytes left
> udevd[1591]: starting version 175
> EXT4-fs (sda1): re-mounted. Opts: (null)
> rsyslogd (2932) used greatest stack depth: 14992 bytes left
> 

This crash involving KVM only ever happened on next-20171206, and there it
happened a bunch of times.  I'm guessing it was a bug in an early version of the
x86 page table isolation patches which quickly got fixed.  So I'm invalidating
this bug for syzbot.

#syz invalid
