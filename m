Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2749ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4773E20833
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4773E20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbeIRU42 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:56:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbeIRU42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:56:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F48F3082A2F;
        Tue, 18 Sep 2018 15:23:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B609618EC1;
        Tue, 18 Sep 2018 15:23:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <3905bb1b-c691-0c8b-490f-599e7a0d561b@intel.com>
References: <3905bb1b-c691-0c8b-490f-599e7a0d561b@intel.com> <9df6256f-dcf3-ee6f-dd9d-b7efe2f539e6@intel.com> <1dac87f5-fa47-eaf2-ef34-945365e0b2c3@intel.com> <7c403b7d-0f60-68ea-d058-cb56d3fece75@intel.com> <20180913010517.GB7632@shao2-debian> <23069.1536838121@warthog.procyon.org.uk> <7969.1537252241@warthog.procyon.org.uk> <9189.1537255398@warthog.procyon.org.uk> <9499.1537266023@warthog.procyon.org.uk>
To:     Li Zhijian <zhijianx.li@intel.com>
Cc:     dhowells@redhat.com, Rong Chen <rong.a.chen@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [ipc] 61224adcd2: general_protection_fault:#[##]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22267.1537284200.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 18 Sep 2018 16:23:20 +0100
Message-ID: <22268.1537284200@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 18 Sep 2018 15:23:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li Zhijian <zhijianx.li@intel.com> wrote:

> 1. please type following command to verify the lkp-src
> $ gzip -dc /home/dhowells/.lkp/cache/lkp-x86_64-ad88cb1a437a_.cgz | cpio -t
> 
> it should have something like
> lizhijian@ivb44:~$ gzip -dc .lkp/cache/lkp-x86_64-ebf5822e1818_.cgz | cpio -t | head

It has a lot more than the listed files, but it does have all the ones you
listed.  Note that my cpio -t sorts things in a different order to yours

> 2. remove this file and try again with following changes

The cgz file listed in (1)?

I turned on "set -x".  I presumed you wanted the output sending to you.

Anyway, note that it seems I need to do mkdir ~/.lkp/cache before running the
qemu command, otherwise cpio commands fail.  With that, trinity appears to be
running.

David
---
>sudo bin/lkp qemu -k /data/fs/linux-next/build2/arch/x86/boot/bzImage job-script
++ LKP_SRC=/data/lkp-tests
++ export ARCH=x86_64
++ ARCH=x86_64
++ LKP_USER=lkp
++ [[ -n '' ]]
++ OWNER=root:lkp
++ OWNER_OPT='--owner root:lkp'
+ [[ lkp-src != \l\k\p\-\s\r\c ]]
++ get_build_dir lkp-src
++ echo /tmp/build-lkp-src
+ BUILD_DIR=/tmp/build-lkp-src
+ [[ -f /data/lkp-tests/pack/lkp-src.patch ]]
+ mkdir -p /tmp/build-lkp-src
+ cd /tmp/build-lkp-src
+ download
+ tmp_dir=/tmp/lkp_initrd-root
+ cd ''
+ [[ -n '' ]]
+ build
+ make -C /data/lkp-tests/bin/event
make: Entering directory '/data/lkp-tests/bin/event'
gcc    -c -o wakeup.o wakeup.c
gcc  -static -o wakeup wakeup.o
rm -f wakeup.o
strip wakeup
make: Leaving directory '/data/lkp-tests/bin/event'
+ install
+ umask 002
+ rm -fr /tmp/lkp_initrd-root
+ mkdir -p /tmp/lkp_initrd-root/rootfs/lkp/lkp/src
+ mkdir -p /tmp/lkp_initrd-root/lkp/lkp
+ ln -sfT /data/lkp-tests /tmp/lkp_initrd-root/lkp/lkp/src
+ strip_object_files
+ [[ -d /lkp/benchmarks/lkp-src ]]
+ [[ 1 != \1 ]]
+ pack_pkg
+ local distro=
+ local pkg_name=lkp-src-LKP
+ rm -fr /tmp/lkp-src-LKP
+ rm -fr /tmp/build-lkp-src/lkp-src-LKP
+ [[ lkp-src != \l\k\p\-\s\r\c ]]
+ case $distro in
+ pack
+ local tmp_src=/tmp/lkp_initrd-root/lkp/lkp/src
+ local archive=/home/dhowells/.lkp/cache/lkp-x86_64
+ local 'cpio_cmd=cpio --quiet -o --owner root:lkp -H newc -F /home/dhowells/.lkp/cache/lkp-x86_64.cpio'
+ rm -f /home/dhowells/.lkp/cache/lkp-x86_64.cpio
+ cd /tmp/lkp_initrd-root/rootfs
+ find lkp
+ cpio --quiet -o --owner root:lkp -H newc -F /home/dhowells/.lkp/cache/lkp-x86_64.cpio
cpio: Cannot open /home/dhowells/.lkp/cache/lkp-x86_64.cpio: No such file or directory
+ cd /tmp/lkp_initrd-root
+ cpio --quiet -o --owner root:lkp -H newc -F /home/dhowells/.lkp/cache/lkp-x86_64.cpio --append
+ find lkp/lkp/src/allot lkp/lkp/src/bin lkp/lkp/src/cluster lkp/lkp/src/_config.yml lkp/lkp/src/COPYING lkp/lkp/src/daemon lkp/lkp/src/distro lkp/lkp/src/doc lkp/lkp/src/etc lkp/lkp/src/filters lkp/lkp/src/Gemfile lkp/lkp/src/hosts lkp/lkp/src/include lkp/lkp/src/jobs lkp/lkp/src/job-script lkp/lkp/src/lib lkp/lkp/src/lkp-exec lkp/lkp/src/mailing-list lkp/lkp/src/Makefile lkp/lkp/src/monitors lkp/lkp/src/pack lkp/lkp/src/params lkp/lkp/src/pkg lkp/lkp/src/plot lkp/lkp/src/Rakefile lkp/lkp/src/README.md lkp/lkp/src/repo lkp/lkp/src/rootfs lkp/lkp/src/sbin lkp/lkp/src/setup lkp/lkp/src/spec lkp/lkp/src/stats lkp/lkp/src/tests lkp/lkp/src/tools
cpio: Cannot open /home/dhowells/.lkp/cache/lkp-x86_64.cpio: No such file or directory
+ cd /tmp/lkp_initrd-root/lkp/lkp/src/rootfs/addon
+ '[' -d etc/ssh ']'
+ chmod g-ws root
+ '[' -d root/.ssh ']'
+ find etc lib root usr
+ grep -v -e '^lib$' -e '^/lib$'
+ cpio --quiet -o --owner root:lkp -H newc -F /home/dhowells/.lkp/cache/lkp-x86_64.cpio --append
cpio: Cannot open /home/dhowells/.lkp/cache/lkp-x86_64.cpio: No such file or directory
+ cd /tmp/lkp_initrd-root/lkp/lkp/src/rootfs/addon
+ find . -type d -exec chmod g+rwx '{}' ';'
+ chmod -R g+rw etc lib root usr
+ '[' -d /osimage/addon-x86_64 ']'
+ gzip -n -9 /home/dhowells/.lkp/cache/lkp-x86_64.cpio
gzip: /home/dhowells/.lkp/cache/lkp-x86_64.cpio: No such file or directory
+ mv -f /home/dhowells/.lkp/cache/lkp-x86_64.cpio.gz /home/dhowells/.lkp/cache/lkp-x86_64.cgz
mv: cannot stat '/home/dhowells/.lkp/cache/lkp-x86_64.cpio.gz': No such file or directory
+ exit
mv: cannot stat '/home/dhowells/.lkp/cache/lkp-x86_64.cgz': No such file or directory
cpio: File lkp/jobs/scheduled/vm-lkp-hsw01-yocto-x86_64-34/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-61224adcd25b0abd01f02459e82b30735161e723-20180913-12085-dsw9kr-3-4fc02.cpio grew, 512 new bytes not copied
12 blocks
result_root: /home/dhowells/.lkp//result/trinity/300s/vm-lkp-hsw01-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-randconfig-ne0-09121830/gcc-6/61224adcd25b0abd01f02459e82b30735161e723/0
downloading initrds ...
/usr/bin/wget -q --local-encoding=UTF-8 --retry-connrefused --waitretry 1000 --tries 1000 https://download.01.org/0day-ci/lkp-qemu/osimage/yocto/yocto-minimal-x86_64-2016-04-22.cgz -N -P /home/dhowells/.lkp/cache/osimage/yocto
13925 blocks
/usr/bin/wget -q --local-encoding=UTF-8 --retry-connrefused --waitretry 1000 --tries 1000 https://download.01.org/0day-ci/lkp-qemu/osimage/pkg/debian-x86_64-2016-08-31.cgz/trinity-static-x86_64-x86_64-6ddabfd2_2017-11-10.cgz -N -P /home/dhowells/.lkp/cache/osimage/pkg/debian-x86_64-2016-08-31.cgz
26031 blocks
cat: /home/dhowells/.lkp/cache/lkp-x86_64-ad88cb1a437a_58b86d0b7434.cgz: No such file or directory
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
[    0.000001] kvm-clock: using sched offset of 200979007 cycles
[    0.000524] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.002092] tsc: Detected 3408.000 MHz processor
[    0.003095] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.003718] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.004255] last_pfn = 0xffdc max_arch_pfn = 0x400000000
[    0.004795] MTRR default type: write-back
[    0.005190] MTRR fixed ranges enabled:
[    0.005546]   00000-9FFFF write-back
[    0.005929]   A0000-BFFFF uncachable
[    0.006262]   C0000-FFFFF write-protect
[    0.006618] MTRR variable ranges enabled:
[    0.006994]   0 base 0080000000 mask FF80000000 uncachable
[    0.007500]   1 disabled
[    0.007734]   2 disabled
[    0.007972]   3 disabled
[    0.008207]   4 disabled
[    0.008442]   5 disabled
[    0.008677]   6 disabled
[    0.008944]   7 disabled
[    0.009185] x86/PAT: PAT not supported by CPU.
[    0.009600] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
[    0.010269] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.010784] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.011299] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.016119] found SMP MP-table at [mem 0x000f5d00-0x000f5d0f] mapped at [(____ptrval____)]
[    0.016918]   mpc: f5d10-f5df8
[    0.017273] Base memory trampoline at [(____ptrval____)] 99000 size 24576
[    0.018067] BRK [0x0435a000, 0x0435afff] PGTABLE
[    0.018462] BRK [0x0435b000, 0x0435bfff] PGTABLE
[    0.018889] BRK [0x0435c000, 0x0435cfff] PGTABLE
[    0.019512] BRK [0x0435d000, 0x0435dfff] PGTABLE
[    0.019998] RAMDISK: [mem 0x0fb70000-0x0ffcffff]
[    0.020448] ACPI: Early table checksum verification disabled
[    0.021099] ACPI: RSDP 0x00000000000F5B00 000014 (v00 BOCHS )
[    0.021652] ACPI: RSDT 0x000000000FFE15FC 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.022502] ACPI: FACP 0x000000000FFE1458 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.023407] ACPI: DSDT 0x000000000FFE0040 001418 (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.024221] ACPI: FACS 0x000000000FFE0000 000040
[    0.024655] ACPI: APIC 0x000000000FFE154C 000078 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.025458] ACPI: HPET 0x000000000FFE15C4 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.026325] ACPI: Local APIC address 0xfee00000
[    0.026753] mapped APIC to ffffffffff5fd000 (        fee00000)
[    0.027357] Zone ranges:
[    0.027595]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.028174]   DMA32    [mem 0x0000000001000000-0x000000000ffdbfff]
[    0.028748]   Normal   empty
[    0.029048] Movable zone start for each node
[    0.029444] Early memory node ranges
[    0.029794]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.030388]   node   0: [mem 0x0000000000100000-0x000000000ffdbfff]
[    0.031199] Reserved but unavailable: 134 pages
[    0.031202] Initmem setup node 0 [mem 0x0000000000001000-0x000000000ffdbfff]
[    0.032281] On node 0 totalpages: 65402
[    0.032637]   DMA zone: 64 pages used for memmap
[    0.033070]   DMA zone: 21 pages reserved
[    0.033442]   DMA zone: 3998 pages, LIFO batch:0
[    0.033972]   DMA32 zone: 960 pages used for memmap
[    0.034428]   DMA32 zone: 61404 pages, LIFO batch:15
[    0.036291] ACPI: PM-Timer IO Port: 0x608
[    0.036667] ACPI: Local APIC address 0xfee00000
[    0.037129] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.037691] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.038364] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.038987] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC INT 02
[    0.039686] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.040303] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC INT 05
[    0.040976] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.041590] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC INT 09
[    0.042289] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.042969] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC INT 0a
[    0.043650] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.044296] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC INT 0b
[    0.045013] ACPI: IRQ0 used by override.
[    0.045387] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC INT 01
[    0.046106] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC INT 03
[    0.046822] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC INT 04
[    0.047505] ACPI: IRQ5 used by override.
[    0.047914] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC INT 06
[    0.048600] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC INT 07
[    0.049288] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC INT 08
[    0.049976] ACPI: IRQ9 used by override.
[    0.050348] ACPI: IRQ10 used by override.
[    0.050729] ACPI: IRQ11 used by override.
[    0.051144] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC INT 0c
[    0.051831] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC INT 0d
[    0.052512] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC INT 0e
[    0.053183] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC INT 0f
[    0.053856] Using ACPI (MADT) for SMP configuration information
[    0.054405] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.054999] mapped IOAPIC to ffffffffff5fc000 (fec00000)
[    0.055455] KVM setup async PF for cpu 0
[    0.055794] kvm-stealtime: cpu 0, msr 2c41880
[    0.056206] [mem 0x10000000-0xfeffbfff] available for PCI devices
[    0.056766] Booting paravirtualized kernel on KVM
[    0.057232] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.224446] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.225156] pcpu-alloc: [0] 0 
[    0.225456] Built 1 zonelists, mobility grouping on.  Total pages: 64357
[    0.226081] Kernel command line: root=/dev/ram0 user=lkp job=/lkp/jobs/scheduled/vm-lkp-hsw01-yocto-x86_64-34/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-61224adcd25b0abd01f02459e82b30735161e723-20180913-12085-dsw9kr-3.yaml ARCH=x86_64 kconfig=x86_64-randconfig-ne0-09121830 branch=linux-next/master commit=61224adcd25b0abd01f02459e82b30735161e723 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-ne0-09121830/gcc-6/61224adcd25b0abd01f02459e82b30735161e723/vmlinuz-4.19.0-rc2-00211-g61224ad max_uptime=1500 RESULT_ROOT=/result/trinity/300s/vm-lkp-hsw01-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-randconfig-ne0-09121830/gcc-6/61224adcd25b0abd01f02459e82b30735161e723/3 LKP_LOCAL_RUN=1 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=tty
 S0,115
[    0.234782] sysrq: sysrq always enabled.
[    0.235463] Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.236134] Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.242496] Memory: 199280K/261608K available (20484K kernel code, 7761K rwdata, 4668K rodata, 1616K init, 9624K bss, 62328K reserved, 0K cma-reserved)
[    0.243793] random: get_random_u64 called from kmem_cache_open+0x32/0x530 with crng_init=0
[    0.244845] random: get_random_u64 called from cache_random_seq_create+0x9d/0x170 with crng_init=0
[    0.245667] random: get_random_u64 called from kmem_cache_open+0x32/0x530 with crng_init=0
[    0.246642] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.247325] Kernel/User page tables isolation: enabled
[    0.248178] 
[    0.248342] **********************************************************
[    0.248990] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.249562] **                                                      **
[    0.250138] ** trace_printk() being used. Allocating extra memory.  **
[    0.250710] **                                                      **
[    0.251285] ** This means that this is a DEBUG kernel and it is     **
[    0.251888] ** unsafe for production use.                           **
[    0.252461] **                                                      **
[    0.253063] ** If you see this message and you are not debugging    **
[    0.253636] ** the kernel, report this immediately to your vendor!  **
[    0.254208] **                                                      **
[    0.254780] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.255397] **********************************************************
[    0.258256] NR_IRQS: 4352, nr_irqs: 48, preallocated irqs: 16
[    0.264838] Console: colour VGA+ 80x25
[    0.309386] console [tty0] enabled
[    0.310122] console [ttyS0] enabled
[    0.310122] console [ttyS0] enabled
[    0.310990] bootconsole [earlyser0] disabled
[    0.310990] bootconsole [earlyser0] disabled
[    0.312019] ACPI: Core revision 20180810
[    0.312952] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.314297] hpet clockevent registered
[    0.314902] APIC: Switch to symmetric I/O mode setup
[    0.315785] x2apic enabled
[    0.316434] Switched APIC routing to physical x2apic.
[    0.317155] enabled ExtINT on CPU#0
[    0.318453] ENABLING IO-APIC IRQs
[    0.318989] init IO_APIC IRQs
[    0.319466]  apic 0 pin 0 not connected
[    0.320057] IOAPIC[0]: Set routing entry (0-1 -> 0xef -> IRQ 1 Mode:0 Active:0 Dest:0)
[    0.321179] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Active:0 Dest:0)
[    0.322296] IOAPIC[0]: Set routing entry (0-3 -> 0xef -> IRQ 3 Mode:0 Active:0 Dest:0)
[    0.323434] IOAPIC[0]: Set routing entry (0-4 -> 0xef -> IRQ 4 Mode:0 Active:0 Dest:0)
[    0.324560] IOAPIC[0]: Set routing entry (0-5 -> 0xef -> IRQ 5 Mode:1 Active:0 Dest:0)
[    0.325676] IOAPIC[0]: Set routing entry (0-6 -> 0xef -> IRQ 6 Mode:0 Active:0 Dest:0)
[    0.326980] IOAPIC[0]: Set routing entry (0-7 -> 0xef -> IRQ 7 Mode:0 Active:0 Dest:0)
[    0.328111] IOAPIC[0]: Set routing entry (0-8 -> 0xef -> IRQ 8 Mode:0 Active:0 Dest:0)
[    0.329310] IOAPIC[0]: Set routing entry (0-9 -> 0xef -> IRQ 9 Mode:1 Active:0 Dest:0)
[    0.330495] IOAPIC[0]: Set routing entry (0-10 -> 0xef -> IRQ 10 Mode:1 Active:0 Dest:0)
[    0.331634] IOAPIC[0]: Set routing entry (0-11 -> 0xef -> IRQ 11 Mode:1 Active:0 Dest:0)
[    0.332871] IOAPIC[0]: Set routing entry (0-12 -> 0xef -> IRQ 12 Mode:0 Active:0 Dest:0)
[    0.333981] IOAPIC[0]: Set routing entry (0-13 -> 0xef -> IRQ 13 Mode:0 Active:0 Dest:0)
[    0.335115] IOAPIC[0]: Set routing entry (0-14 -> 0xef -> IRQ 14 Mode:0 Active:0 Dest:0)
[    0.336263] IOAPIC[0]: Set routing entry (0-15 -> 0xef -> IRQ 15 Mode:0 Active:0 Dest:0)
[    0.337392]  apic 0 pin 16 not connected
[    0.337978]  apic 0 pin 17 not connected
[    0.338578]  apic 0 pin 18 not connected
[    0.339161]  apic 0 pin 19 not connected
[    0.339881]  apic 0 pin 20 not connected
[    0.340478]  apic 0 pin 21 not connected
[    0.341085]  apic 0 pin 22 not connected
[    0.341692]  apic 0 pin 23 not connected
[    0.342428] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.343257] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x311fd3cd494, max_idle_ns: 440795223879 ns
[    0.344663] Calibrating delay loop (skipped) preset value.. 6816.00 BogoMIPS (lpj=13632000)
[    0.345778] pid_max: default: 32768 minimum: 301
[    0.348784] Security Framework initialized
[    0.349428] Yama: becoming mindful.
[    0.349989] AppArmor: AppArmor disabled by boot time parameter
[    0.350914] Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
[    0.351813] Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes)
[    0.353054] *** VALIDATE proc ***
[    0.353672] *** VALIDATE cgroup1 ***
[    0.354219] *** VALIDATE cgroup2 ***
[    0.354780] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.355577] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.356374] CPU: Intel QEMU Virtual CPU version 2.5+ (family: 0x6, model: 0x6, stepping: 0x3)
[    0.356683] Spectre V2 : Spectre mitigation: kernel not compiled with retpoline; no mitigation available!
[    0.356685] Speculative Store Bypass: Vulnerable
[    0.362270] Performance Events: PMU not available due to virtualization, using software events only.
[    0.363613] Using local APIC timer interrupts.
[    0.363613] calibrating APIC timer ...
[    0.368662] ... lapic delta = 6248774
[    0.368662] ... PM-Timer delta = 357873
[    0.368662] ... PM-Timer result ok
[    0.368662] ..... delta 6248774
[    0.368662] ..... mult: 268382799
[    0.368662] ..... calibration result: 3999215
[    0.368662] ..... CPU clock speed is 3407.0787 MHz.
[    0.368662] ..... host bus clock speed is 999.3215 MHz.
[    0.368950] devtmpfs: initialized
[    0.369763] x86/mm: Memory block size: 128MB
[    0.371430] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.372670] futex hash table entries: 256 (order: 0, 6144 bytes)
[    0.373589] prandom: seed boundary self test passed
[    0.374858] prandom: 100 self tests passed
[    0.375511] pinctrl core: initialized pinctrl subsystem
[    0.376562] regulator-dummy: no parameters
[    0.377115] NET: Registered protocol family 16
[    0.378626] audit: initializing netlink subsys (disabled)
[    0.380014] cpuidle: using governor menu
[    0.381041] ACPI: bus type PCI registered
[    0.381770] PCI: Using configuration type 1 for base access
[    0.384678] audit: type=2000 audit(1537283718.026:1): state=initialized audit_enabled=0 res=1
[    0.396012] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.396766] cryptd: max_cpu_qlen set to 1000
[    0.398103] ACPI: Added _OSI(Module Device)
[    0.398724] ACPI: Added _OSI(Processor Device)
[    0.399390] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.400060] ACPI: Added _OSI(Processor Aggregator Device)
[    0.400677] ACPI: Added _OSI(Linux-Dell-Video)
[    0.401421] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.418122] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.422559] ACPI: Interpreter enabled
[    0.423321] ACPI: (supports S0 S3 S5)
[    0.423872] ACPI: Using IOAPIC for interrupt routing
[    0.424730] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.426949] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.456245] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.456679] acpi PNP0A03:00: _OSC: OS supports [Segments]
[    0.457484] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.458399] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.460852] PCI host bridge to bus 0000:00
[    0.461466] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.462420] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.463414] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.464444] pci_bus 0000:00: root bus resource [mem 0x10000000-0xfebfffff window]
[    0.464670] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
[    0.465754] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.466536] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.469222] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.471179] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.473656] pci 0000:00:01.1: reg 0x20: [io  0xc100-0xc10f]
[    0.475273] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.476308] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.476667] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.477685] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.479357] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.481026] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.482288] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.484098] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    0.485394] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    0.487465] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    0.492003] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.493599] pci 0000:00:03.0: [1af4:1009] type 00 class 0x000200
[    0.495359] pci 0000:00:03.0: reg 0x10: [io  0xc000-0xc03f]
[    0.497413] pci 0000:00:03.0: reg 0x14: [mem 0xfebf1000-0xfebf1fff]
[    0.500670] pci 0000:00:03.0: reg 0x20: [mem 0xfe000000-0xfe003fff 64bit pref]
[    0.505204] pci 0000:00:04.0: [8086:100e] type 00 class 0x020000
[    0.506660] pci 0000:00:04.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    0.508023] pci 0000:00:04.0: reg 0x14: [io  0xc040-0xc07f]
[    0.511166] pci 0000:00:04.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    0.513239] pci 0000:00:05.0: [1af4:1001] type 00 class 0x010000
[    0.515611] pci 0000:00:05.0: reg 0x10: [io  0xc080-0xc0bf]
[    0.517036] pci 0000:00:05.0: reg 0x14: [mem 0xfebf2000-0xfebf2fff]
[    0.520116] pci 0000:00:05.0: reg 0x20: [mem 0xfe004000-0xfe007fff 64bit pref]
[    0.522666] pci 0000:00:06.0: [1af4:1001] type 00 class 0x010000
[    0.525487] pci 0000:00:06.0: reg 0x10: [io  0xc0c0-0xc0ff]
[    0.527049] pci 0000:00:06.0: reg 0x14: [mem 0xfebf3000-0xfebf3fff]
[    0.530386] pci 0000:00:06.0: reg 0x20: [mem 0xfe008000-0xfe00bfff 64bit pref]
[    0.533249] pci 0000:00:07.0: [8086:25ab] type 00 class 0x088000
[    0.536251] pci 0000:00:07.0: reg 0x10: [mem 0xfebf4000-0xfebf400f]
[    0.539369] pci_bus 0000:00: on NUMA node 0
[    0.543499] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    0.545384] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    0.547488] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    0.549103] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    0.550224] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    0.552415] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.552662] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.552668] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.553462] vgaarb: loaded
[    0.554715] SCSI subsystem initialized
[    0.556867] videodev: Linux video capture interface: v2.00
[    0.557758] pps_core: LinuxPPS API ver. 1 registered
[    0.558469] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.560013] PCI: Using ACPI for IRQ routing
[    0.560666] PCI: pci_cache_line_size set to 64 bytes
[    0.561579] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.562420] e820: reserve RAM buffer [mem 0x0ffdc000-0x0fffffff]
[    0.563671] Bluetooth: Core ver 2.22
[    0.564682] NET: Registered protocol family 31
[    0.565319] Bluetooth: HCI device and connection manager initialized
[    0.566200] Bluetooth: HCI socket layer initialized
[    0.567047] Bluetooth: L2CAP socket layer initialized
[    0.568095] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[    0.569043] clocksource: Switched to clocksource kvm-clock
[    0.622377] Warning: could not register annotated branches stats
[    0.623329] Warning: could not register all branches stats
[    0.624358] VFS: Disk quotas dquot_6.6.0
[    0.624998] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.626050] *** VALIDATE hugetlbfs ***
[    0.626761] pnp: PnP ACPI init
[    0.627503] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.628600] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.629759] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.630700] pnp 00:03: [dma 2]
[    0.631257] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.632494] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (active)
[    0.633730] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.636631] pnp: PnP ACPI: found 6 devices
[    0.649194] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.650565] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.651476] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.652393] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.653306] pci_bus 0000:00: resource 7 [mem 0x10000000-0xfebfffff window]
[    0.654206] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff window]
[    0.655535] NET: Registered protocol family 2
[    0.656715] tcp_listen_portaddr_hash hash table entries: 256 (order: 0, 4096 bytes)
[    0.657893] TCP established hash table entries: 2048 (order: 2, 16384 bytes)
[    0.658919] TCP bind hash table entries: 2048 (order: 2, 16384 bytes)
[    0.659847] TCP: Hash tables configured (established 2048 bind 2048)
[    0.660853] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.661665] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.662655] NET: Registered protocol family 1
[    0.663669] RPC: Registered named UNIX socket transport module.
[    0.664525] RPC: Registered udp transport module.
[    0.665205] RPC: Registered tcp transport module.
[    0.665907] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.666822] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.667656] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.668486] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    0.669442] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.670665] PCI: CLS 0 bytes, default 64
[    0.671450] Unpacking initramfs...
[    0.827197] Freeing initrd memory: 4480K
[    0.828148] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fd3cd494, max_idle_ns: 440795223879 ns
[    0.832445] AVX or AES-NI instructions are not detected.
[    0.833152] AVX2 or AES-NI instructions are not detected.
[    0.835353] workingset: timestamp_bits=61 max_order=16 bucket_order=0
[    0.851306] ntfs: driver 2.1.32 [Flags: R/W DEBUG].
[    0.853037] JFS: nTxBlock = 1591, nTxLock = 12735
[    0.854671] NILFS version 2 loaded
[    0.863467] NET: Registered protocol family 38
[    0.864661] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    0.865643] io scheduler noop registered (default)
[    0.866280] io scheduler kyber registered
[    0.868156] gpio_winbond: chip ID at 2e is ffff
[    0.868772] gpio_winbond: not an our chip
[    0.869344] gpio_winbond: chip ID at 4e is ffff
[    0.869953] gpio_winbond: not an our chip
[    0.870849] IPMI message handler: version 39.2
[    0.871744] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.872780] ACPI: Power Button [PWRF]
[    0.874364] HDLC line discipline maxframe=4096
[    0.875011] N_HDLC line discipline registered.
[    0.875628] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.898513] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.900814] telclk_interrupt = 0xf non-mcpbl0010 hw.
[    0.902508] Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Rodolfo Giometti
[    0.904334] alua: device handler registered
[    0.907168] libphy: Fixed MDIO Bus: probed
[    0.908700] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[    0.909703] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.479159] PCI Interrupt Link [LNKD] enabled at IRQ 11
[    1.817362] e1000 0000:00:04.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    1.818290] e1000 0000:00:04.0 eth0: Intel(R) PRO/1000 Network Connection
[    1.819443] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    1.821202] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.821902] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.823354] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    1.825911] vivid-000: using single planar format API
[    1.829119] vivid-000: V4L2 capture device registered as video0
[    1.830033] vivid-000: V4L2 output device registered as video1
[    1.831020] vivid-000: V4L2 capture device registered as vbi0, supports raw and sliced VBI
[    1.832310] vivid-000: V4L2 output device registered as vbi1, supports raw and sliced VBI
[    1.833567] vivid-000: V4L2 capture device registered as swradio0
[    1.834513] vivid-000: V4L2 receiver device registered as radio0
[    1.835466] vivid-000: V4L2 transmitter device registered as radio1
[    1.836394] Driver for 1-wire Dallas network protocol.
[    1.837251] DS1WM w1 busmaster driver - (c) 2004 Szabolcs Gyurko
[    1.838114] w1_f0d_init()
[    1.838991] _warn_unseeded_randomness: 313 callbacks suppressed
[    1.838996] random: get_random_u64 called from kmem_cache_open+0x32/0x530 with crng_init=0
[    1.840963] random: get_random_u64 called from cache_random_seq_create+0x9d/0x170 with crng_init=0
[    1.842316] random: get_random_u64 called from kmem_cache_open+0x32/0x530 with crng_init=0
[    1.843926] device-mapper: uevent: version 1.0.3
[    1.845005] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[    1.846647] hidraw: raw HID events driver (C) Jiri Kosina
[    1.848153] FPGA DOWNLOAD --->
[    1.848642] FPGA image file name: xlinx_fpga_firmware.bit
[    1.849476] GPIO INIT FAIL!!
[    1.850007] most_core: init()
[    1.850588] most_cdev: init()
[    1.851209] most_core: registered new core component cdev
[    1.851974] most_core: registered new core component net
[    1.852739] most_core: registered new core component video
[    1.853654] axis-fifo driver loaded with parameters read_timeout = 1000, write_timeout = 1000
[    1.854864] dell_smbios: Unable to run on non-Dell system
[    1.855618] hdaps: supported laptop not found!
[    1.856311] hdaps: driver init failed (ret=-19)!
[    1.857351] NET: Registered protocol family 26
[    1.859016] NET: Registered protocol family 10
[    1.860660] Segment Routing with IPv6
[    1.861305] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.862685] NET: Registered protocol family 15
[    1.863578] NET: Registered protocol family 5
[    1.864368] 9pnet: Installing 9P2000 support
[    1.865081] Key type dns_resolver registered
[    1.866732] batman_adv: B.A.T.M.A.N. advanced 2018.2 (compatibility version 15) loaded
[    1.868284] ... APIC ID:      00000000 (0)
[    1.868919] ... APIC VERSION: 00050014
[    1.869025] 0000000000000000000000000000000000000000000000000000000000000000
[    1.869025] 0000000000000000000000000000000000000000000000000000000000000000
[    1.869025] 0000000000000000000000000000000000000000000000000000000000001000
[    1.872417] number of MP IRQ sources: 15.
[    1.873018] number of IO-APIC #0 registers: 24.
[    1.873695] testing the IO APIC.......................
[    1.874414] IO APIC #0......
[    1.874878] .... register #00: 00000000
[    1.875479] .......    : physical APIC id: 00
[    1.876106] .......    : Delivery Type: 0
[    1.876729] .......    : LTS          : 0
[    1.877315] .... register #01: 00170011
[    1.877914] .......     : max redirection entries: 17
[    1.878613] .......     : PRQ implemented: 0
[    1.879225] .......     : IO APIC version: 11
[    1.879881] .... register #02: 00000000
[    1.880456] .......     : arbitration: 00
[    1.881038] .... IRQ redirection table:
[    1.882666] IOAPIC 0:
[    1.883265]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.884366]  pin01, enabled , edge , high, V(22), IRR(0), S(0), physical, D(00), M(0)
[    1.885469]  pin02, enabled , edge , high, V(30), IRR(0), S(0), physical, D(00), M(0)
[    1.886541]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.887721]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.888826]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.889930]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.891060]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.892156]  pin08, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.893236]  pin09, enabled , level, high, V(20), IRR(0), S(0), physical, D(00), M(0)
[    1.894307]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.895385]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.896590]  pin0c, enabled , edge , high, V(21), IRR(0), S(0), physical, D(00), M(0)
[    1.897701]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.898791]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.899970]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.901047]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.902168]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.903260]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.904356]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.905488]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.906643]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.907738]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.908923]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    1.910019] IRQ to pin mappings:
[    1.910552] IRQ0 -> 0:2
[    1.910973] IRQ1 -> 0:1
[    1.911392] IRQ3 -> 0:3
[    1.911839] IRQ4 -> 0:4
[    1.912259] IRQ5 -> 0:5
[    1.912714] IRQ6 -> 0:6
[    1.913122] IRQ7 -> 0:7
[    1.913562] IRQ8 -> 0:8
[    1.913978] IRQ9 -> 0:9
[    1.914397] IRQ10 -> 0:10
[    1.914838] IRQ11 -> 0:11
[    1.915275] IRQ12 -> 0:12
[    1.915714] IRQ13 -> 0:13
[    1.916149] IRQ14 -> 0:14
[    1.916616] IRQ15 -> 0:15
[    1.917060] .................................... done.
[    1.917801] sched_clock: Marking stable (1839559323, 77496455)->(2024373113, -107317335)
[    1.919346] registered taskstats version 1
[    1.920489] Key type encrypted registered
[    1.921102] ima: No TPM chip found, activating TPM-bypass!
[    1.921866] ima: Allocated hash algorithm: sha1
[    1.922588] evm: Initialising EVM extended attributes:
[    1.923375] evm: security.apparmor
[    1.923948] evm: security.capability
[    1.924535] evm: HMAC attrs: 0x1
[    1.929761] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    3.953633] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[    3.958926] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    3.960743] _warn_unseeded_randomness: 56 callbacks suppressed
[    3.960748] random: get_random_bytes called from addrconf_dad_kick+0x91/0x110 with crng_init=0
[    3.976686] Sending DHCP requests .
[    3.976694] random: get_random_bytes called from ip_auto_config+0xc20/0x20ca with crng_init=0
[    3.979032] , OK
[    3.985154] IP-Config: Got DHCP answer from 10.0.2.2, my address is 10.0.2.15
[    3.986722] IP-Config: Complete:
[    3.987539]      device=eth0, hwaddr=52:54:00:12:34:56, ipaddr=10.0.2.15, mask=255.255.255.0, gw=10.0.2.2
[    3.989621]      host=10.0.2.15, domain=, nis-domain=(none)
[    3.990894]      bootserver=10.0.2.2, rootserver=10.0.2.2, rootpath=
[    3.990896]      nameserver0=10.0.2.3
[    3.997561] Freeing unused kernel image memory: 1616K
[    3.998802] Write protecting the kernel read-only data: 28672k
[    4.001510] Freeing unused kernel image memory: 2008K
[    4.003153] Freeing unused kernel image memory: 1476K
[    4.028551] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    4.029624] rodata_test: all tests were successful
[    4.030414] x86/mm: Checking user space page tables
[    4.051376] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    4.052518] Run /init as init process
[    4.053268] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
INIT: version 2.88 booting
/etc/rcS.d/S00fbsetup: line 3: /sbin/modprobe: not found
Starting udev
[    4.099048] udevd[198]: starting version 3.1.5
[    4.100335] random: udevd: uninitialized urandom read (16 bytes read)
[    4.101532] random: udevd: uninitialized urandom read (16 bytes read)
[    4.102586] random: udevd: uninitialized urandom read (16 bytes read)
bootlogd: cannot allocate pseudo tty: No such file or directory
Populating dev cache
hwclock: can't open '/dev/misc/rtc': No such file or directory
INIT: Entering runlevel: 5
Configuring network interfaces... done.
hwclock: can't open '/dev/misc/rtc': No such file or directory
Starting syslogd/klogd: done

Poky (Yocto Project Reference Distro) 2.1 qemux86-64 /dev/ttyS0

qemux86-64 login: [    5.298157] _warn_unseeded_randomness: 1013 callbacks suppressed
[    5.298180] random: get_random_bytes called from flow_hash_from_keys+0x3a0/0x3d0 with crng_init=0
[    5.304156] random: get_random_bytes called from addrconf_dad_kick+0x91/0x110 with crng_init=0
[    7.323355] random: get_random_u32 called from bucket_table_alloc+0xf4/0x290 with crng_init=0
root
[    8.850832] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
[    8.854766] random: get_random_u64 called from load_elf_binary+0x1268/0x1c50 with crng_init=0
[    8.856127] random: get_random_u32 called from arch_align_stack+0x42/0x60 with crng_init=0
root@qemux86-64:~# poweroff
[   13.815128] _warn_unseeded_randomness: 11 callbacks suppressed
[   13.815146] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
[   13.817980] random: get_random_u64 called from load_elf_binary+0x1268/0x1c50 with crng_init=0
[   13.819343] random: get_random_u32 called from map_vdso_randomized+0xaf/0xd0 with crng_init=0
INIT: Switching to runlevel: 0
INIT: Sending processes the TERM signal
root@qemux86-64:~# hwclock: can't open '/dev/misc/rtc': No such file or directory
Stopping syslogd/klogd: stopped syslogd (pid 433)
[   13.841746] random: fast init done
stopped klogd (pid 437)
done
Deconfiguring network interfaces... done.
Sending all processes the TERM signal...
Sending all processes the KILL signal...
[   18.874367] _warn_unseeded_randomness: 101 callbacks suppressed
[   18.874372] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=1
[   18.876501] random: get_random_u64 called from load_elf_binary+0x1268/0x1c50 with crng_init=1
[   18.877797] random: get_random_u32 called from map_vdso_randomized+0xaf/0xd0 with crng_init=1
Unmounting remote filesystems...
[   18.896315] urandom_read: 5 callbacks suppressed
[   18.896317] random: dd: uninitialized urandom read (512 bytes read)
Deactivating swap...
Unmounting local filesystems...
[   20.984428] _warn_unseeded_randomness: 73 callbacks suppressed
[   20.984434] random: get_random_u32 called from new_slab+0x272/0x7a0 with crng_init=1
[   21.553290] ACPI: Preparing to enter system sleep state S5
[   21.554145] reboot: Power down
[   21.555693] acpi_power_off called


