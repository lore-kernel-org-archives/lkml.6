Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFC5ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF3021473
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF3021473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbeIRMyj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:54:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbeIRMyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:54:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6738888302;
        Tue, 18 Sep 2018 07:23:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6A1627C36;
        Tue, 18 Sep 2018 07:23:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1dac87f5-fa47-eaf2-ef34-945365e0b2c3@intel.com>
References: <1dac87f5-fa47-eaf2-ef34-945365e0b2c3@intel.com> <7c403b7d-0f60-68ea-d058-cb56d3fece75@intel.com> <20180913010517.GB7632@shao2-debian> <23069.1536838121@warthog.procyon.org.uk> <7969.1537252241@warthog.procyon.org.uk>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     dhowells@redhat.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        lkp@01.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [ipc] 61224adcd2: general_protection_fault:#[##]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9188.1537255398.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 18 Sep 2018 08:23:18 +0100
Message-ID: <9189.1537255398@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 18 Sep 2018 07:23:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rong Chen <rong.a.chen@intel.com> wrote:

> It's my fault, I'm awfully sorry, please clone the latest code from
> https://github.com/intel/lkp-tests.git

Still not sure what I'm meant to be seeing.  Note that there are a number of
"Not found" and "No such file or directory" errors appearing.

I've attached the console log for you.

David
---
warthog>sudo bin/lkp qemu -k /data/fs/linux-next/build2/arch/x86/boot/bzImage job-script
make: Entering directory '/data/lkp-tests/bin/event'
gcc    -c -o wakeup.o wakeup.c
gcc  -static -o wakeup wakeup.o
rm -f wakeup.o
strip wakeup
make: Leaving directory '/data/lkp-tests/bin/event'
cpio: Cannot open /home/dhowells/.lkp/cache/lkp-x86_64.cpio: No such file or directory
cpio: Cannot open /home/dhowells/.lkp/cache/lkp-x86_64.cpio: No such file or directory
cpio: Cannot open /home/dhowells/.lkp/cache/lkp-x86_64.cpio: No such file or directory
gzip: /home/dhowells/.lkp/cache/lkp-x86_64.cpio: No such file or directory
mv: cannot stat '/home/dhowells/.lkp/cache/lkp-x86_64.cpio.gz': No such file or directory
mv: cannot stat '/home/dhowells/.lkp/cache/lkp-x86_64.cgz': No such file or directory
cpio: File lkp/jobs/scheduled/vm-lkp-hsw01-yocto-x86_64-34/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-61224adcd25b0abd01f02459e82b30735161e723-20180913-12085-dsw9kr-3-4fc02.cpio grew, 512 new bytes not copied
12 blocks
result_root: /home/dhowells/.lkp//result/trinity/300s/vm-lkp-hsw01-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-randconfig-ne0-09121830/gcc-6/61224adcd25b0abd01f02459e82b30735161e723/0
downloading initrds ...
/usr/bin/wget -q --local-encoding=UTF-8 --retry-connrefused --waitretry 1000 --tries 1000 https://download.01.org/0day-ci/lkp-qemu/osimage/yocto/yocto-minimal-x86_64-2016-04-22.cgz -N -P /home/dhowells/.lkp/cache/osimage/yocto
13925 blocks
/usr/bin/wget -q --local-encoding=UTF-8 --retry-connrefused --waitretry 1000 --tries 1000 https://download.01.org/0day-ci/lkp-qemu/osimage/pkg/debian-x86_64-2016-08-31.cgz/trinity-static-x86_64-x86_64-6ddabfd2_2017-11-10.cgz -N -P /home/dhowells/.lkp/cache/osimage/pkg/debian-x86_64-2016-08-31.cgz
26031 blocks
cat: /home/dhowells/.lkp/cache/lkp-x86_64-ad88cb1a437a_.cgz: No such file or directory
Formatting '/tmp/vdisk-root/disk-vm-lkp-hsw01-yocto-x86_64-34-0', fmt=qcow2 size=274877906944 cluster_size=65536 lazy_refcounts=off refcount_bits=16
Formatting '/tmp/vdisk-root/disk-vm-lkp-hsw01-yocto-x86_64-34-1', fmt=qcow2 size=274877906944 cluster_size=65536 lazy_refcounts=off refcount_bits=16
exec command: qemu-system-x86_64 -enable-kvm -fsdev local,id=test_dev,path=/home/dhowells/.lkp//result/trinity/300s/vm-lkp-hsw01-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-randconfig-ne0-09121830/gcc-6/61224adcd25b0abd01f02459e82b30735161e723/0,security_model=none -device virtio-9p-pci,fsdev=test_dev,mount_tag=9p/virtfs_mount -kernel /data/fs/linux-next/build2/arch/x86/boot/bzImage -append root=/dev/ram0 user=lkp job=/lkp/jobs/scheduled/vm-lkp-hsw01-yocto-x86_64-34/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-61224adcd25b0abd01f02459e82b30735161e723-20180913-12085-dsw9kr-3.yaml ARCH=x86_64 kconfig=x86_64-randconfig-ne0-09121830 branch=linux-next/master commit=61224adcd25b0abd01f02459e82b30735161e723 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-ne0-09121830/gcc-6/61224adcd25b0abd01f02459e82b30735161e723/vmlinuz-4.19.0-rc2-00211-g61224ad max_uptime=1500 RESULT_ROOT=/result/trinity/300s/vm-lkp-hsw01-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-randconfig-ne0-09121
 830/gcc-6/61224adcd25b0abd01f02459e82b30735161e723/3 LKP_LOCAL_RUN=1 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw  ip=dhcp result_service=9p/virtfs_mount -initrd /home/dhowells/.lkp/cache/final_initrd -smp 1 -m 256M -no-reboot -watchdog i6300esb -rtc base=localtime -device e1000,netdev=net0 -netdev user,id=net0 -display none -monitor null -serial stdio -drive file=/tmp/vdisk-root/disk-vm-lkp-hsw01-yocto-x86_64-34-0,media=disk,if=virtio -drive file=/tmp/vdisk-root/disk-vm-lkp-hsw01-yocto-x86_64-34-1,media=disk,if=virtio
early console in setup code
early console in extract_kernel
input_data: 0x000000000375e2e9
input_len: 0x0000000000bfde80
output: 0x0000000001000000
output_len: 0x0000000002bf31d8
kernel_total_size: 0x000000000337f000
trampoline_32bit: 0x000000000009d000

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
[    0.000000] Linux version 4.19.0-rc3-next-20180913 (dhowells@warthog.procyon.org.uk) (gcc version 8.1.1 20180626 (Red Hat Cross 8.1.1-3) (GCC)) #1 Tue Sep 18 07:53:12 BST 2018
[    0.000000] Command line: root=/dev/ram0 user=lkp job=/lkp/jobs/scheduled/vm-lkp-hsw01-yocto-x86_64-34/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-61224adcd25b0abd01f02459e82b30735161e723-20180913-12085-dsw9kr-3.yaml ARCH=x86_64 kconfig=x86_64-randconfig-ne0-09121830 branch=linux-next/master commit=61224adcd25b0abd01f02459e82b30735161e723 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-ne0-09121830/gcc-6/61224adcd25b0abd01f02459e82b30735161e723/vmlinuz-4.19.0-rc2-00211-g61224ad max_uptime=1500 RESULT_ROOT=/result/trinity/300s/vm-lkp-hsw01-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-randconfig-ne0-09121830/gcc-6/61224adcd25b0abd01f02459e82b30735161e723/3 LKP_LOCAL_RUN=1 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,1152
 00 vga
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000000ffdbfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000ffdc000-0x000000000fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180531_142017-buildhw-08.phx2.fedoraproject.org-1.fc28 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000001] kvm-clock: cpu 0, msr 3a09001, primary cpu clock
[    0.000001] kvm-clock: using sched offset of 210749895 cycles
[    0.000532] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.001953] tsc: Detected 3408.000 MHz processor
[    0.002943] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.003622] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.004165] last_pfn = 0xffdc max_arch_pfn = 0x400000000
[    0.004642] MTRR default type: write-back
[    0.004992] MTRR fixed ranges enabled:
[    0.005318]   00000-9FFFF write-back
[    0.005629]   A0000-BFFFF uncachable
[    0.005954]   C0000-FFFFF write-protect
[    0.006305] MTRR variable ranges enabled:
[    0.006645]   0 base 0080000000 mask FF80000000 uncachable
[    0.007138]   1 disabled
[    0.007351]   2 disabled
[    0.007581]   3 disabled
[    0.007812]   4 disabled
[    0.008026]   5 disabled
[    0.008241]   6 disabled
[    0.008455]   7 disabled
[    0.008693] x86/PAT: PAT not supported by CPU.
[    0.009086] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
[    0.009752] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.010308] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.010825] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.015872] found SMP MP-table at [mem 0x000f5d00-0x000f5d0f] mapped at [(____ptrval____)]
[    0.016686]   mpc: f5d10-f5df8
[    0.016971] Base memory trampoline at [(____ptrval____)] 99000 size 24576
[    0.017574] BRK [0x0435a000, 0x0435afff] PGTABLE
[    0.018044] BRK [0x0435b000, 0x0435bfff] PGTABLE
[    0.018438] BRK [0x0435c000, 0x0435cfff] PGTABLE
[    0.019078] BRK [0x0435d000, 0x0435dfff] PGTABLE
[    0.019515] RAMDISK: [mem 0x0fb70000-0x0ffcffff]
[    0.019950] ACPI: Early table checksum verification disabled
[    0.020514] ACPI: RSDP 0x00000000000F5B00 000014 (v00 BOCHS )
[    0.021036] ACPI: RSDT 0x000000000FFE15FC 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.021805] ACPI: FACP 0x000000000FFE1458 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.022516] ACPI: DSDT 0x000000000FFE0040 001418 (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.023258] ACPI: FACS 0x000000000FFE0000 000040
[    0.023643] ACPI: APIC 0x000000000FFE154C 000078 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.024446] ACPI: HPET 0x000000000FFE15C4 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.025192] ACPI: Local APIC address 0xfee00000
[    0.025614] mapped APIC to ffffffffff5fd000 (        fee00000)
[    0.026167] Zone ranges:
[    0.026379]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.026970]   DMA32    [mem 0x0000000001000000-0x000000000ffdbfff]
[    0.027510]   Normal   empty
[    0.027790] Movable zone start for each node
[    0.028154] Early memory node ranges
[    0.028460]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.029028]   node   0: [mem 0x0000000000100000-0x000000000ffdbfff]
[    0.029794] Reserved but unavailable: 134 pages
[    0.029797] Initmem setup node 0 [mem 0x0000000000001000-0x000000000ffdbfff]
[    0.030844] On node 0 totalpages: 65402
[    0.031192]   DMA zone: 64 pages used for memmap
[    0.031600]   DMA zone: 21 pages reserved
[    0.031954]   DMA zone: 3998 pages, LIFO batch:0
[    0.032430]   DMA32 zone: 960 pages used for memmap
[    0.032859]   DMA32 zone: 61404 pages, LIFO batch:15
[    0.034701] ACPI: PM-Timer IO Port: 0x608
[    0.035092] ACPI: Local APIC address 0xfee00000
[    0.035487] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.036011] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.036599] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.037144] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC INT 02
[    0.037791] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.038354] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC INT 05
[    0.038972] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.039535] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC INT 09
[    0.040153] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.040787] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC INT 0a
[    0.041502] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.042101] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC INT 0b
[    0.042750] ACPI: IRQ0 used by override.
[    0.043200] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC INT 01
[    0.043878] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC INT 03
[    0.044504] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC INT 04
[    0.045136] ACPI: IRQ5 used by override.
[    0.045469] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC INT 06
[    0.046113] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC INT 07
[    0.046756] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC INT 08
[    0.047369] ACPI: IRQ9 used by override.
[    0.047736] ACPI: IRQ10 used by override.
[    0.048079] ACPI: IRQ11 used by override.
[    0.048422] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC INT 0c
[    0.049066] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC INT 0d
[    0.049710] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC INT 0e
[    0.050324] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC INT 0f
[    0.050969] Using ACPI (MADT) for SMP configuration information
[    0.051527] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.052102] mapped IOAPIC to ffffffffff5fc000 (fec00000)
[    0.052576] KVM setup async PF for cpu 0
[    0.052925] kvm-stealtime: cpu 0, msr 2c41880
[    0.053346] [mem 0x10000000-0xfeffbfff] available for PCI devices
[    0.053929] Booting paravirtualized kernel on KVM
[    0.054360] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.231516] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.232203] pcpu-alloc: [0] 0 
[    0.232510] Built 1 zonelists, mobility grouping on.  Total pages: 64357
[    0.233153] Kernel command line: root=/dev/ram0 user=lkp job=/lkp/jobs/scheduled/vm-lkp-hsw01-yocto-x86_64-34/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-61224adcd25b0abd01f02459e82b30735161e723-20180913-12085-dsw9kr-3.yaml ARCH=x86_64 kconfig=x86_64-randconfig-ne0-09121830 branch=linux-next/master commit=61224adcd25b0abd01f02459e82b30735161e723 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-ne0-09121830/gcc-6/61224adcd25b0abd01f02459e82b30735161e723/vmlinuz-4.19.0-rc2-00211-g61224ad max_uptime=1500 RESULT_ROOT=/result/trinity/300s/vm-lkp-hsw01-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-randconfig-ne0-09121830/gcc-6/61224adcd25b0abd01f02459e82b30735161e723/3 LKP_LOCAL_RUN=1 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=tty
 S0,115
[    0.241506] sysrq: sysrq always enabled.
[    0.242169] Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.242860] Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.249425] Memory: 199280K/261608K available (20484K kernel code, 7761K rwdata, 4668K rodata, 1616K init, 9624K bss, 62328K reserved, 0K cma-reserved)
[    0.250666] random: get_random_u64 called from kmem_cache_open+0x32/0x530 with crng_init=0
[    0.251770] random: get_random_u64 called from cache_random_seq_create+0x9d/0x170 with crng_init=0
[    0.252582] random: get_random_u64 called from kmem_cache_open+0x32/0x530 with crng_init=0
[    0.253511] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.254107] Kernel/User page tables isolation: enabled
[    0.254881] 
[    0.255029] **********************************************************
[    0.255599] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.256203] **                                                      **
[    0.256777] ** trace_printk() being used. Allocating extra memory.  **
[    0.257348] **                                                      **
[    0.257953] ** This means that this is a DEBUG kernel and it is     **
[    0.258522] ** unsafe for production use.                           **
[    0.259124] **                                                      **
[    0.259759] ** If you see this message and you are not debugging    **
[    0.260431] ** the kernel, report this immediately to your vendor!  **
[    0.261047] **                                                      **
[    0.261636] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.262223] **********************************************************
[    0.265173] NR_IRQS: 4352, nr_irqs: 48, preallocated irqs: 16
[    0.271400] Console: colour VGA+ 80x25
[    0.317916] console [tty0] enabled
[    0.318560] console [ttyS0] enabled
[    0.318560] console [ttyS0] enabled
[    0.319523] bootconsole [earlyser0] disabled
[    0.319523] bootconsole [earlyser0] disabled
[    0.320583] ACPI: Core revision 20180810
[    0.321473] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.322779] hpet clockevent registered
[    0.323381] APIC: Switch to symmetric I/O mode setup
[    0.324307] x2apic enabled
[    0.324954] Switched APIC routing to physical x2apic.
[    0.325669] enabled ExtINT on CPU#0
[    0.327112] ENABLING IO-APIC IRQs
[    0.327828] init IO_APIC IRQs
[    0.328358]  apic 0 pin 0 not connected
[    0.328946] IOAPIC[0]: Set routing entry (0-1 -> 0xef -> IRQ 1 Mode:0 Active:0 Dest:0)
[    0.330052] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Active:0 Dest:0)
[    0.331215] IOAPIC[0]: Set routing entry (0-3 -> 0xef -> IRQ 3 Mode:0 Active:0 Dest:0)
[    0.332318] IOAPIC[0]: Set routing entry (0-4 -> 0xef -> IRQ 4 Mode:0 Active:0 Dest:0)
[    0.333421] IOAPIC[0]: Set routing entry (0-5 -> 0xef -> IRQ 5 Mode:1 Active:0 Dest:0)
[    0.334528] IOAPIC[0]: Set routing entry (0-6 -> 0xef -> IRQ 6 Mode:0 Active:0 Dest:0)
[    0.335642] IOAPIC[0]: Set routing entry (0-7 -> 0xef -> IRQ 7 Mode:0 Active:0 Dest:0)
[    0.336782] IOAPIC[0]: Set routing entry (0-8 -> 0xef -> IRQ 8 Mode:0 Active:0 Dest:0)
[    0.337890] IOAPIC[0]: Set routing entry (0-9 -> 0xef -> IRQ 9 Mode:1 Active:0 Dest:0)
[    0.338991] IOAPIC[0]: Set routing entry (0-10 -> 0xef -> IRQ 10 Mode:1 Active:0 Dest:0)
[    0.340124] IOAPIC[0]: Set routing entry (0-11 -> 0xef -> IRQ 11 Mode:1 Active:0 Dest:0)
[    0.341269] IOAPIC[0]: Set routing entry (0-12 -> 0xef -> IRQ 12 Mode:0 Active:0 Dest:0)
[    0.342459] IOAPIC[0]: Set routing entry (0-13 -> 0xef -> IRQ 13 Mode:0 Active:0 Dest:0)
[    0.343704] IOAPIC[0]: Set routing entry (0-14 -> 0xef -> IRQ 14 Mode:0 Active:0 Dest:0)
[    0.344947] IOAPIC[0]: Set routing entry (0-15 -> 0xef -> IRQ 15 Mode:0 Active:0 Dest:0)
[    0.346117]  apic 0 pin 16 not connected
[    0.346736]  apic 0 pin 17 not connected
[    0.347362]  apic 0 pin 18 not connected
[    0.347973]  apic 0 pin 19 not connected
[    0.348594]  apic 0 pin 20 not connected
[    0.349253]  apic 0 pin 21 not connected
[    0.349894]  apic 0 pin 22 not connected
[    0.350491]  apic 0 pin 23 not connected
[    0.351250] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.352153] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x311fd3cd494, max_idle_ns: 440795223879 ns
[    0.353594] Calibrating delay loop (skipped) preset value.. 6816.00 BogoMIPS (lpj=13632000)
[    0.354817] pid_max: default: 32768 minimum: 301
[    0.357719] Security Framework initialized
[    0.358372] Yama: becoming mindful.
[    0.359026] AppArmor: AppArmor disabled by boot time parameter
[    0.359950] Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
[    0.361598] Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes)
[    0.363243] *** VALIDATE proc ***
[    0.363952] *** VALIDATE cgroup1 ***
[    0.364590] *** VALIDATE cgroup2 ***
[    0.365202] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.365597] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.366415] CPU: Intel QEMU Virtual CPU version 2.5+ (family: 0x6, model: 0x6, stepping: 0x3)
[    0.367720] Spectre V2 : Spectre mitigation: kernel not compiled with retpoline; no mitigation available!
[    0.367722] Speculative Store Bypass: Vulnerable
[    0.372080] Performance Events: PMU not available due to virtualization, using software events only.
[    0.373689] Using local APIC timer interrupts.
[    0.373689] calibrating APIC timer ...
[    0.377592] ... lapic delta = 6251338
[    0.377592] ... PM-Timer delta = 358027
[    0.377592] ... PM-Timer result ok
[    0.377592] ..... delta 6251338
[    0.377592] ..... mult: 268492922
[    0.377592] ..... calibration result: 4000856
[    0.377592] ..... CPU clock speed is 3408.2519 MHz.
[    0.377592] ..... host bus clock speed is 1000.0856 MHz.
[    0.377901] devtmpfs: initialized
[    0.378747] x86/mm: Memory block size: 128MB
[    0.380489] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.381600] futex hash table entries: 256 (order: 0, 6144 bytes)
[    0.382520] prandom: seed boundary self test passed
[    0.383755] prandom: 100 self tests passed
[    0.384327] pinctrl core: initialized pinctrl subsystem
[    0.385718] regulator-dummy: no parameters
[    0.386810] NET: Registered protocol family 16
[    0.388399] audit: initializing netlink subsys (disabled)
[    0.389751] cpuidle: using governor menu
[    0.390683] ACPI: bus type PCI registered
[    0.391437] PCI: Using configuration type 1 for base access
[    0.393607] audit: type=2000 audit(1537255013.748:1): state=initialized audit_enabled=0 res=1
[    0.405444] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.405739] cryptd: max_cpu_qlen set to 1000
[    0.406983] ACPI: Added _OSI(Module Device)
[    0.407596] ACPI: Added _OSI(Processor Device)
[    0.408189] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.409597] ACPI: Added _OSI(Processor Aggregator Device)
[    0.410381] ACPI: Added _OSI(Linux-Dell-Video)
[    0.411014] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.427843] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.432584] ACPI: Interpreter enabled
[    0.433189] ACPI: (supports S0 S3 S5)
[    0.433596] ACPI: Using IOAPIC for interrupt routing
[    0.434347] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.436538] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.466675] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.467609] acpi PNP0A03:00: _OSC: OS supports [Segments]
[    0.468386] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.469255] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.469942] PCI host bridge to bus 0000:00
[    0.470585] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.471497] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.473601] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.474690] pci_bus 0000:00: root bus resource [mem 0x10000000-0xfebfffff window]
[    0.475772] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
[    0.477022] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.477633] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.479573] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.482053] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.484483] pci 0000:00:01.1: reg 0x20: [io  0xc100-0xc10f]
[    0.486173] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.487163] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.488241] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.489180] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.490715] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.492084] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.493605] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.495509] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    0.497120] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    0.498833] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    0.503343] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.505799] pci 0000:00:03.0: [1af4:1009] type 00 class 0x000200
[    0.508029] pci 0000:00:03.0: reg 0x10: [io  0xc000-0xc03f]
[    0.510196] pci 0000:00:03.0: reg 0x14: [mem 0xfebf1000-0xfebf1fff]
[    0.514367] pci 0000:00:03.0: reg 0x20: [mem 0xfe000000-0xfe003fff 64bit pref]
[    0.517628] pci 0000:00:04.0: [8086:100e] type 00 class 0x020000
[    0.519206] pci 0000:00:04.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    0.520997] pci 0000:00:04.0: reg 0x14: [io  0xc040-0xc07f]
[    0.525102] pci 0000:00:04.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    0.526575] pci 0000:00:05.0: [1af4:1001] type 00 class 0x010000
[    0.528435] pci 0000:00:05.0: reg 0x10: [io  0xc080-0xc0bf]
[    0.530286] pci 0000:00:05.0: reg 0x14: [mem 0xfebf2000-0xfebf2fff]
[    0.534794] pci 0000:00:05.0: reg 0x20: [mem 0xfe004000-0xfe007fff 64bit pref]
[    0.538913] pci 0000:00:06.0: [1af4:1001] type 00 class 0x010000
[    0.540762] pci 0000:00:06.0: reg 0x10: [io  0xc0c0-0xc0ff]
[    0.542308] pci 0000:00:06.0: reg 0x14: [mem 0xfebf3000-0xfebf3fff]
[    0.546320] pci 0000:00:06.0: reg 0x20: [mem 0xfe008000-0xfe00bfff 64bit pref]
[    0.550530] pci 0000:00:07.0: [8086:25ab] type 00 class 0x088000
[    0.552928] pci 0000:00:07.0: reg 0x10: [mem 0xfebf4000-0xfebf400f]
[    0.557092] pci_bus 0000:00: on NUMA node 0
[    0.560542] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    0.562345] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    0.564063] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    0.566384] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    0.567614] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    0.570045] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.571109] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.572253] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.573030] vgaarb: loaded
[    0.574352] SCSI subsystem initialized
[    0.575132] videodev: Linux video capture interface: v2.00
[    0.575964] pps_core: LinuxPPS API ver. 1 registered
[    0.576665] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.577892] PCI: Using ACPI for IRQ routing
[    0.578502] PCI: pci_cache_line_size set to 64 bytes
[    0.579316] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.580132] e820: reserve RAM buffer [mem 0x0ffdc000-0x0fffffff]
[    0.581742] Bluetooth: Core ver 2.22
[    0.582305] NET: Registered protocol family 31
[    0.582913] Bluetooth: HCI device and connection manager initialized
[    0.583740] Bluetooth: HCI socket layer initialized
[    0.584406] Bluetooth: L2CAP socket layer initialized
[    0.585423] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[    0.585983] clocksource: Switched to clocksource kvm-clock
[    0.641626] Warning: could not register annotated branches stats
[    0.642564] Warning: could not register all branches stats
[    0.643547] VFS: Disk quotas dquot_6.6.0
[    0.644198] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.645290] *** VALIDATE hugetlbfs ***
[    0.646078] pnp: PnP ACPI init
[    0.646875] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.648062] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.649242] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.650348] pnp 00:03: [dma 2]
[    0.650966] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.652219] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (active)
[    0.653630] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.656565] pnp: PnP ACPI: found 6 devices
[    0.669168] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.670598] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.671467] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.672280] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.673264] pci_bus 0000:00: resource 7 [mem 0x10000000-0xfebfffff window]
[    0.674180] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff window]
[    0.675578] NET: Registered protocol family 2
[    0.676676] tcp_listen_portaddr_hash hash table entries: 256 (order: 0, 4096 bytes)
[    0.677807] TCP established hash table entries: 2048 (order: 2, 16384 bytes)
[    0.678830] TCP bind hash table entries: 2048 (order: 2, 16384 bytes)
[    0.679698] TCP: Hash tables configured (established 2048 bind 2048)
[    0.680583] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.681352] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.682295] NET: Registered protocol family 1
[    0.683235] RPC: Registered named UNIX socket transport module.
[    0.684023] RPC: Registered udp transport module.
[    0.684664] RPC: Registered tcp transport module.
[    0.685334] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.686336] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.687145] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.687962] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    0.688853] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.690019] PCI: CLS 0 bytes, default 64
[    0.690795] Unpacking initramfs...
[    0.860619] Freeing initrd memory: 4480K
[    0.861563] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fd3cd494, max_idle_ns: 440795223879 ns
[    0.866034] AVX or AES-NI instructions are not detected.
[    0.866745] AVX2 or AES-NI instructions are not detected.
[    0.869070] workingset: timestamp_bits=61 max_order=16 bucket_order=0
[    0.886638] ntfs: driver 2.1.32 [Flags: R/W DEBUG].
[    0.888785] JFS: nTxBlock = 1591, nTxLock = 12735
[    0.890460] NILFS version 2 loaded
[    0.899582] NET: Registered protocol family 38
[    0.900918] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    0.901942] io scheduler noop registered (default)
[    0.902833] io scheduler kyber registered
[    0.904975] gpio_winbond: chip ID at 2e is ffff
[    0.905738] gpio_winbond: not an our chip
[    0.906528] gpio_winbond: chip ID at 4e is ffff
[    0.907304] gpio_winbond: not an our chip
[    0.908304] IPMI message handler: version 39.2
[    0.909351] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.910581] ACPI: Power Button [PWRF]
[    0.912266] HDLC line discipline maxframe=4096
[    0.913006] N_HDLC line discipline registered.
[    0.913744] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.937027] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.939438] telclk_interrupt = 0xf non-mcpbl0010 hw.
[    0.940995] Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Rodolfo Giometti
[    0.942986] alua: device handler registered
[    0.945868] libphy: Fixed MDIO Bus: probed
[    0.947506] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[    0.948567] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.560242] PCI Interrupt Link [LNKD] enabled at IRQ 11
[    1.906182] e1000 0000:00:04.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    1.907324] e1000 0000:00:04.0 eth0: Intel(R) PRO/1000 Network Connection
[    1.908653] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    1.910769] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.911592] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.913166] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    1.915951] vivid-000: using single planar format API
[    1.919307] vivid-000: V4L2 capture device registered as video0
[    1.920508] vivid-000: V4L2 output device registered as video1
[    1.921608] vivid-000: V4L2 capture device registered as vbi0, supports raw and sliced VBI
[    1.923116] vivid-000: V4L2 output device registered as vbi1, supports raw and sliced VBI
[    1.924548] vivid-000: V4L2 capture device registered as swradio0
[    1.925685] vivid-000: V4L2 receiver device registered as radio0
[    1.926773] vivid-000: V4L2 transmitter device registered as radio1
[    1.927856] Driver for 1-wire Dallas network protocol.
[    1.928809] DS1WM w1 busmaster driver - (c) 2004 Szabolcs Gyurko
[    1.929835] w1_f0d_init()
[    1.930692] _warn_unseeded_randomness: 313 callbacks suppressed
[    1.930697] random: get_random_u64 called from kmem_cache_open+0x32/0x530 with crng_init=0
[    1.933051] random: get_random_u64 called from cache_random_seq_create+0x9d/0x170 with crng_init=0
[    1.934601] random: get_random_u64 called from kmem_cache_open+0x32/0x530 with crng_init=0
[    1.936293] device-mapper: uevent: version 1.0.3
[    1.937670] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[    1.939551] hidraw: raw HID events driver (C) Jiri Kosina
[    1.941192] FPGA DOWNLOAD --->
[    1.941735] FPGA image file name: xlinx_fpga_firmware.bit
[    1.942701] GPIO INIT FAIL!!
[    1.943305] most_core: init()
[    1.943961] most_cdev: init()
[    1.944503] most_core: registered new core component cdev
[    1.945353] most_core: registered new core component net
[    1.946394] most_core: registered new core component video
[    1.947430] axis-fifo driver loaded with parameters read_timeout = 1000, write_timeout = 1000
[    1.948890] dell_smbios: Unable to run on non-Dell system
[    1.949792] hdaps: supported laptop not found!
[    1.950607] hdaps: driver init failed (ret=-19)!
[    1.951815] NET: Registered protocol family 26
[    1.953651] NET: Registered protocol family 10
[    1.955658] Segment Routing with IPv6
[    1.956347] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.957823] NET: Registered protocol family 15
[    1.958688] NET: Registered protocol family 5
[    1.959582] 9pnet: Installing 9P2000 support
[    1.960416] Key type dns_resolver registered
[    1.962160] batman_adv: B.A.T.M.A.N. advanced 2018.2 (compatibility version 15) loaded
[    1.963806] ... APIC ID:      00000000 (0)
[    1.964476] ... APIC VERSION: 00050014
[    1.965129] 0000000000000000000000000000000000000000000000000000000000000000
[    1.965599] 0000000000000000000000000000000000000000000000000000000000000000
[    1.965599] 0000000000000000000000000000000000000000000000000000000000001000
[    1.968413] number of MP IRQ sources: 15.
[    1.969071] number of IO-APIC #0 registers: 24.
[    1.969928] testing the IO APIC.......................
[    1.970829] IO APIC #0......
[    1.971359] .... register #00: 00000000
[    1.972059] .......    : physical APIC id: 00
[    1.972793] .......    : Delivery Type: 0
[    1.973474] .......    : LTS          : 0
[    1.974188] .... register #01: 00170011
[    1.974882] .......     : max redirection entries: 17
[    1.975669] .......     : PRQ implemented: 0
[    1.976387] .......     : IO APIC version: 11
[    1.977111] .... register #02: 00000000
[    1.977747] .......     : arbitration: 00
[    1.978428] .... IRQ redirection table:
[    1.980167] IOAPIC 0:
[    1.980607]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.981897]  pin01, enabled , edge , high, V(22), IRR(0), S(0), physical, D(00), M(0)
[    1.983162]  pin02, enabled , edge , high, V(30), IRR(0), S(0), physical, D(00), M(0)
[    1.984415]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.985540]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.986679]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.987825]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.988924]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.990067]  pin08, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.991175]  pin09, enabled , level, high, V(20), IRR(0), S(0), physical, D(00), M(0)
[    1.992268]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.993364]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.994491]  pin0c, enabled , edge , high, V(21), IRR(0), S(0), physical, D(00), M(0)
[    1.995594]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.996681]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.997766]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.998866]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    2.000033]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    2.001105]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    2.002167]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    2.003243]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    2.004454]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    2.005832]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    2.006924]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    2.008008] IRQ to pin mappings:
[    2.008515] IRQ0 -> 0:2
[    2.008966] IRQ1 -> 0:1
[    2.009403] IRQ3 -> 0:3
[    2.009838] IRQ4 -> 0:4
[    2.010267] IRQ5 -> 0:5
[    2.010699] IRQ6 -> 0:6
[    2.011144] IRQ7 -> 0:7
[    2.011561] IRQ8 -> 0:8
[    2.012007] IRQ9 -> 0:9
[    2.012426] IRQ10 -> 0:10
[    2.012922] IRQ11 -> 0:11
[    2.013414] IRQ12 -> 0:12
[    2.013891] IRQ13 -> 0:13
[    2.014326] IRQ14 -> 0:14
[    2.014777] IRQ15 -> 0:15
[    2.015228] .................................... done.
[    2.016006] sched_clock: Marking stable (1934229594, 79656556)->(2121759817, -107873667)
[    2.017650] registered taskstats version 1
[    2.018854] Key type encrypted registered
[    2.019510] ima: No TPM chip found, activating TPM-bypass!
[    2.020353] ima: Allocated hash algorithm: sha1
[    2.021138] evm: Initialising EVM extended attributes:
[    2.021918] evm: security.apparmor
[    2.022450] evm: security.capability
[    2.023005] evm: HMAC attrs: 0x1
[    2.028148] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    4.058587] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[    4.065888] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    4.074496] _warn_unseeded_randomness: 56 callbacks suppressed
[    4.074517] random: get_random_bytes called from addrconf_dad_kick+0x91/0x110 with crng_init=0
[    4.086153] Sending DHCP requests .
[    4.086182] random: get_random_bytes called from ip_auto_config+0xc20/0x20ca with crng_init=0
[    4.094054] , OK
[    4.095376] IP-Config: Got DHCP answer from 10.0.2.2, my address is 10.0.2.15
[    4.097831] IP-Config: Complete:
[    4.098980]      device=eth0, hwaddr=52:54:00:12:34:56, ipaddr=10.0.2.15, mask=255.255.255.0, gw=10.0.2.2
[    4.101817]      host=10.0.2.15, domain=, nis-domain=(none)
[    4.103217]      bootserver=10.0.2.2, rootserver=10.0.2.2, rootpath=
[    4.103220]      nameserver0=10.0.2.3
[    4.110920] Freeing unused kernel image memory: 1616K
[    4.112031] Write protecting the kernel read-only data: 28672k
[    4.114410] Freeing unused kernel image memory: 2008K
[    4.115804] Freeing unused kernel image memory: 1476K
[    4.137890] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    4.138877] rodata_test: all tests were successful
[    4.139579] x86/mm: Checking user space page tables
[    4.160759] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    4.161832] Run /init as init process
[    4.162491] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
INIT: version 2.88 booting
/etc/rcS.d/S00fbsetup: line 3: /sbin/modprobe: not found
Starting udev
[    4.211226] udevd[198]: starting version 3.1.5
[    4.212377] random: udevd: uninitialized urandom read (16 bytes read)
[    4.213420] random: udevd: uninitialized urandom read (16 bytes read)
[    4.214377] random: udevd: uninitialized urandom read (16 bytes read)
bootlogd: cannot allocate pseudo tty: No such file or directory
Populating dev cache
hwclock: can't open '/dev/misc/rtc': No such file or directory
INIT: Entering runlevel: 5
Configuring network interfaces... done.
hwclock: can't open '/dev/misc/rtc': No such file or directory
Starting syslogd/klogd: done

Poky (Yocto Project Reference Distro) 2.1 qemux86-64 /dev/ttyS0

qemux86-64 login: [    5.819064] _warn_unseeded_randomness: 998 callbacks suppressed
[    5.819086] random: get_random_bytes called from flow_hash_from_keys+0x3a0/0x3d0 with crng_init=0
[    5.830163] random: get_random_bytes called from addrconf_dad_kick+0x91/0x110 with crng_init=0
[    7.465815] random: get_random_u32 called from bucket_table_alloc+0xf4/0x290 with crng_init=0
[   14.724885] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
[   14.729929] random: get_random_u64 called from load_elf_binary+0x1268/0x1c50 with crng_init=0
[   14.735550] random: get_random_u32 called from arch_align_stack+0x42/0x60 with crng_init=0
[   24.756441] _warn_unseeded_randomness: 7 callbacks suppressed
[   24.756459] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
[   24.765107] random: get_random_u64 called from load_elf_binary+0x1268/0x1c50 with crng_init=0
[   24.771386] random: get_random_u32 called from map_vdso_randomized+0xaf/0xd0 with crng_init=0
[   34.789154] _warn_unseeded_randomness: 5 callbacks suppressed
[   34.789172] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
[   34.798558] random: get_random_u64 called from load_elf_binary+0x1268/0x1c50 with crng_init=0
[   34.805095] random: get_random_u32 called from map_vdso_randomized+0xaf/0xd0 with crng_init=0
[   42.297829] _warn_unseeded_randomness: 5 callbacks suppressed
[   42.301890] random: get_random_bytes called from __prandom_timer+0x18/0x80 with crng_init=0
[   44.823626] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
[   44.828838] random: get_random_u64 called from load_elf_binary+0x1268/0x1c50 with crng_init=0
[   44.835149] random: get_random_u32 called from map_vdso_randomized+0xaf/0xd0 with crng_init=0
[   54.856025] _warn_unseeded_randomness: 6 callbacks suppressed
[   54.856042] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
[   54.864682] random: get_random_u64 called from load_elf_binary+0x1268/0x1c50 with crng_init=0
[   54.871508] random: get_random_u32 called from map_vdso_randomized+0xaf/0xd0 with crng_init=0
[   64.891586] _warn_unseeded_randomness: 5 callbacks suppressed
[   64.891603] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
[   64.900918] random: get_random_u64 called from load_elf_binary+0x1268/0x1c50 with crng_init=0
[   64.907710] random: get_random_u32 called from map_vdso_randomized+0xaf/0xd0 with crng_init=0

Poky (Yocto Project Reference Distro) 2.1 qemux86-64 /dev/ttyS0

qemux86-64 login: root
[   69.023230] _warn_unseeded_randomness: 5 callbacks suppressed
[   69.023247] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
[   69.032182] random: get_random_u64 called from load_elf_binary+0x1268/0x1c50 with crng_init=0
[   69.038949] random: get_random_u32 called from map_vdso_randomized+0xaf/0xd0 with crng_init=0
root@qemux86-64:~# gi[   74.927567] _warn_unseeded_randomness: 11 callbacks suppressed
[   74.927585] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
[   74.936377] random: get_random_u64 called from load_elf_binary+0x1268/0x1c50 with crng_init=0
[   74.942676] random: get_random_u32 called from map_vdso_randomized+0xaf/0xd0 with crng_init=0
[   84.962605] _warn_unseeded_randomness: 8 callbacks suppressed
[   84.962623] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
[   84.976734] random: get_random_u64 called from load_elf_binary+0x1268/0x1c50 with crng_init=0
[   84.981860] random: get_random_u32 called from arch_align_stack+0x42/0x60 with crng_init=0
[   95.001211] _warn_unseeded_randomness: 8 callbacks suppressed
[   95.001228] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
[   95.011739] random: get_random_u64 called from load_elf_binary+0x1268/0x1c50 with crng_init=0
[   95.019446] random: get_random_u32 called from map_vdso_randomized+0xaf/0xd0 with crng_init=0
INIT: Id "S1" respawning too fast: disabled for 5 minutes[  105.037199] random: fast init done

[  118.073737] _warn_unseeded_randomness: 7 callbacks suppressed
[  118.077669] random: get_random_bytes called from __prandom_timer+0x18/0x80 with crng_init=1

