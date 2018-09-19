Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F166ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C75F2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C75F2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbeISHmL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:42:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:38259 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbeISHmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:42:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 19:06:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,392,1531810800"; 
   d="scan'208";a="89991428"
Received: from xuting-mobl.ccr.corp.intel.com (HELO [192.168.4.139]) ([10.255.29.10])
  by fmsmga004.fm.intel.com with ESMTP; 18 Sep 2018 19:06:11 -0700
Subject: Re: [LKP] [ipc] 61224adcd2: general_protection_fault:#[##]
To:     David Howells <dhowells@redhat.com>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>
References: <3905bb1b-c691-0c8b-490f-599e7a0d561b@intel.com>
 <9df6256f-dcf3-ee6f-dd9d-b7efe2f539e6@intel.com>
 <1dac87f5-fa47-eaf2-ef34-945365e0b2c3@intel.com>
 <7c403b7d-0f60-68ea-d058-cb56d3fece75@intel.com>
 <20180913010517.GB7632@shao2-debian>
 <23069.1536838121@warthog.procyon.org.uk>
 <7969.1537252241@warthog.procyon.org.uk>
 <9189.1537255398@warthog.procyon.org.uk>
 <9499.1537266023@warthog.procyon.org.uk>
 <22268.1537284200@warthog.procyon.org.uk>
From:   Li Zhijian <zhijianx.li@intel.com>
Message-ID: <0bebe825-7f1a-47c1-9e8b-52d47d6a1722@intel.com>
Date:   Wed, 19 Sep 2018 10:06:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <22268.1537284200@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/2018 11:23 PM, David Howells wrote:
>> 1. please type following command to verify the lkp-src
>> $ gzip -dc/home/dhowells/.lkp/cache/lkp-x86_64-ad88cb1a437a_.cgz | cpio -t
>>
>> it should have something like
>> lizhijian@ivb44:~$ gzip -dc .lkp/cache/lkp-x86_64-ebf5822e1818_.cgz | cpio -t | head
> It has a lot more than the listed files, but it does have all the ones you
> listed.  Note that my cpio -t sorts things in a different order to yours
>
>> 2. remove this file and try again with following changes
> The cgz file listed in (1)?

Yes


>
> I turned on "set -x".  I presumed you wanted the output sending to you.
>
> Anyway, note that it seems I need to do mkdir ~/.lkp/cache before running the
> qemu command,

LKP tools would help to create this directory, and your host already had this according to the listed file you post previously

> final_initrd  initrd-concatenated  lkp/  lkp-x86_64-ad88cb1a437a_.cgz  osimage/
>
> Note that ~/.lkp is a symlink to somewhere that I don't mind clobbering.
>


not clear why you cannot create cpio under ~/.lkp/cache dir


> + local tmp_src=/tmp/lkp_initrd-root/lkp/lkp/src
> + local archive=/home/dhowells/.lkp/cache/lkp-x86_64
> + local 'cpio_cmd=cpio --quiet -o --owner root:lkp -H newc -F/home/dhowells/.lkp/cache/lkp-x86_64.cpio'
> + rm -f/home/dhowells/.lkp/cache/lkp-x86_64.cpio
> + cd /tmp/lkp_initrd-root/rootfs
> + find lkp
> + cpio --quiet -o --owner root:lkp -H newc -F/home/dhowells/.lkp/cache/lkp-x86_64.cpio
> cpio: Cannot open/home/dhowells/.lkp/cache/lkp-x86_64.cpio: No such file or directory


> otherwise cpio commands fail.  With that, trinity appears to be
> running.

According  to the log you attached, trinity didn't run due to the lkp-src.cgz(lkp-x86_64-ad88cb1a437a_xxx.cgz) haven't be merged into the runtime rootfs.


below is the full log on my env
---
lizhijian@haswell-OptiPlex-9020:~/lkp/lkp-qemu$ pwd
/home/lizhijian/lkp/lkp-qemu
lizhijian@haswell-OptiPlex-9020:~/lkp/lkp-qemu$ ls
job.sh  vmlinuz-4.19.0-rc2-00211-g61224ad
lizhijian@haswell-OptiPlex-9020:~/lkp/lkp-qemu$ ls ~/.lkp -ld
ls: cannot access '/home/lizhijian/.lkp': No such file or directory
lizhijian@haswell-OptiPlex-9020:~/lkp/lkp-qemu$ sudo ~/lkp-tests/bin/lkp qemu -k vmlinuz-4.19.0-rc2-00211-g61224ad job.sh
The approx. disk space requirements are

10M             simple boot test in rootfs openwrt
50M		simple boot test in rootfs debian
1G              plan to run a number of different tests
100G or more    IO tests

Please enter a dir with enough disk space, or simply press Enter to accept the default.
You may still symlink /home/lizhijian/.lkp to a more suitable place in future.
/home/lizhijian/.lkp =>
cpio: File lkp/jobs/scheduled/vm-lkp-hsw01-yocto-x86_64-43/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-61224adcd25b0abd01f02459e82b30735161e723-20180913-83000-1fq8z3y-0-df108.cpio grew, 512 new bytes not copied
12 blocks
result_root: /home/lizhijian/.lkp//result/trinity/300s/vm-lkp-hsw01-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-randconfig-ne0-09121830/gcc-6/61224adcd25b0abd01f02459e82b30735161e723/0
downloading initrds ...
/usr/bin/wget -q --local-encoding=UTF-8 --retry-connrefused --waitretry 1000 --tries 1000 http://bee.sh.intel.com:80/~lkp/osimage/yocto/yocto-minimal-x86_64-2016-04-22.cgz -N -P /home/lizhijian/.lkp/cache/osimage/yocto
13925 blocks
/usr/bin/wget -q --local-encoding=UTF-8 --retry-connrefused --waitretry 1000 --tries 1000 http://bee.sh.intel.com:80/~lkp/osimage/pkg/debian-x86_64-2016-08-31.cgz/trinity-static-x86_64-x86_64-6ddabfd2_2017-11-10.cgz -N -P /home/lizhijian/.lkp/cache/osimage/pkg/debian-x86_64-2016-08-31.cgz
26031 blocks
Formatting '/tmp/vdisk-root/disk-vm-lkp-hsw01-yocto-x86_64-43-0', fmt=qcow2 size=274877906944 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
Formatting '/tmp/vdisk-root/disk-vm-lkp-hsw01-yocto-x86_64-43-1', fmt=qcow2 size=274877906944 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
exec command: qemu-system-x86_64 -enable-kvm -fsdev local,id=test_dev,path=/home/lizhijian/.lkp//result/trinity/300s/vm-lkp-hsw01-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-randconfig-ne0-09121830/gcc-6/61224adcd25b0abd01f02459e82b30735161e723/0,security_model=none -device virtio-9p-pci,fsdev=test_dev,mount_tag=9p/virtfs_mount -kernel vmlinuz-4.19.0-rc2-00211-g61224ad -append root=/dev/ram0 user=lkp job=/lkp/jobs/scheduled/vm-lkp-hsw01-yocto-x86_64-43/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-61224adcd25b0abd01f02459e82b30735161e723-20180913-83000-1fq8z3y-0.yaml ARCH=x86_64 kconfig=x86_64-randconfig-ne0-09121830 branch=linux-next/master commit=61224adcd25b0abd01f02459e82b30735161e723 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-ne0-09121830/gcc-6/61224adcd25b0abd01f02459e82b30735161e723/vmlinuz-4.19.0-rc2-00211-g61224ad max_uptime=1500 RESULT_ROOT=/result/trinity/300s/vm-lkp-hsw01-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-randconfig-ne0-09121830/gcc-6/612
 24adcd25b0abd01f02459e82b30735161e723/0 LKP_LOCAL_RUN=1 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw  ip=dhcp result_service=9p/virtfs_mount -initrd /home/lizhijian/.lkp/cache/final_initrd -smp 1 -m 256M -no-reboot -watchdog i6300esb -rtc base=localtime -device e1000,netdev=net0 -netdev user,id=net0 -display none -monitor null -serial stdio -drive file=/tmp/vdisk-root/disk-vm-lkp-hsw01-yocto-x86_64-43-0,media=disk,if=virtio -drive file=/tmp/vdisk-root/disk-vm-lkp-hsw01-yocto-x86_64-43-1,media=disk,if=virtio
early console in setup code
early console in extract_kernel
input_data: 0x000000000379f2e9
input_len: 0x0000000000bfaac9
output: 0x0000000001000000
output_len: 0x0000000002c30258
kernel_total_size: 0x00000000033bd000
trampoline_32bit: 0x000000000009d000

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
[    0.000000] Linux version 4.19.0-rc2-00211-g61224ad (kbuild@sof-kbuild01) (gcc version 6.4.0 20171026 (Debian 6.4.0-9)) #1 Thu Sep 13 00:56:50 CST 2018
[    0.000000] Command line: root=/dev/ram0 user=lkp job=/lkp/jobs/scheduled/vm-lkp-hsw01-yocto-x86_64-43/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-61224adcd25b0abd01f02459e82b30735161e723-20180913-83000-1fq8z3y-0.yaml ARCH=x86_64 kconfig=x86_64-randconfig-ne0-09121830 branch=linux-next/master commit=61224adcd25b0abd01f02459e82b30735161e723 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-ne0-09121830/gcc-6/61224adcd25b0abd01f02459e82b30735161e723/vmlinuz-4.19.0-rc2-00211-g61224ad max_uptime=1500 RESULT_ROOT=/result/trinity/300s/vm-lkp-hsw01-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-randconfig-ne0-09121830/gcc-6/61224adcd25b0abd01f02459e82b30735161e723/0 LKP_LOCAL_RUN=1 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115
 200 vg
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[...snip...]
[    4.165953] random: get_random_bytes called from addrconf_dad_kick+0x92/0x110 with crng_init=0
[    4.184619] Sending DHCP requests .
[    4.184629] random: get_random_bytes called from ic_dynamic+0x296/0xfd0 with crng_init=0
[    4.186656] , OK
[    4.187101] IP-Config: Got DHCP answer from 10.0.2.2, my address is 10.0.2.15
[    4.188162] IP-Config: Complete:
[    4.188726]      device=eth0, hwaddr=52:54:00:12:34:56, ipaddr=10.0.2.15, mask=255.255.255.0, gw=10.0.2.2
[    4.190163]      host=10.0.2.15, domain=, nis-domain=(none)
[    4.191103]      bootserver=10.0.2.2, rootserver=10.0.2.2, rootpath=
[    4.191106]      nameserver0=10.0.2.3
[    4.197574] Freeing unused kernel image memory: 1684K
[    4.198259] Write protecting the kernel read-only data: 28672k
[    4.199968] Freeing unused kernel image memory: 2004K
[    4.200944] Freeing unused kernel image memory: 1440K
[    4.218255] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    4.219068] rodata_test: all tests were successful
[    4.219655] x86/mm: Checking user space page tables
[    4.236740] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    4.237504] Run /init as init process
[    4.238113] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
INIT: version 2.88 booting
/etc/rcS.d/S00fbsetup: line 3: /sbin/modprobe: not found
Starting udev
[    4.283879] udevd[135]: starting version 3.1.5
[    4.284888] random: udevd: uninitialized urandom read (16 bytes read)
[    4.285729] random: udevd: uninitialized urandom read (16 bytes read)
[    4.286518] random: udevd: uninitialized urandom read (16 bytes read)
bootlogd: cannot allocate pseudo tty: No such file or directory
Populating dev cache
hwclock: can't open '/dev/misc/rtc': No such file or directory
INIT: Entering runlevel: 5
Configuring network interfaces... done.
hwclock: can't open '/dev/misc/rtc': No such file or directory
Starting syslogd/klogd: done
PATH=/sbin:/usr/sbin:/bin:/usr/bin:/lkp/lkp/src/bin
LKP: HOSTNAME vm-lkp-hsw01-yocto-x86_64-43, MAC 52:54:00:12:34:56, kernel 4.19.0-rc2-00211-g61224ad 1, serial console /dev/ttyS0

Poky (Yocto Project Reference Distro) 2.1 vm-lkp-hsw01-yocto-x86_64-43 /dev/ttyS0

vm-lkp-hsw01-yocto-x86_64-43 login: [    5.809653] mount: mounting 9p/virtfs_mount on //result/trinity/300s/vm-lkp-hsw01-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-randconfig-ne0-09121830/gcc-6/61224adcd25b0abd01f02459e82b30735161e723/0 failed: No such device
[    5.809653] /lkp/lkp/src/monitors/heartbeat: line 9: vmstat: not found
[    5.809653] /lkp/lkp/src/monitors/heartbeat: exec: line 23: vmstat: not found
[    5.813778] Kernel tests: Boot OK!
[    5.813778] /lkp/lkp/src/bin/run-lkp
[    5.813778] RESULT_ROOT=/result/trinity/300s/vm-lkp-hsw01-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-randconfig-ne0-09121830/gcc-6/61224adcd25b0abd01f02459e82b30735161e723/0
[    5.813778] job=/lkp/jobs/scheduled/vm-lkp-hsw01-yocto-x86_64-43/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-61224adcd25b0abd01f02459e82b30735161e723-20180913-83000-1fq8z3y-0.yaml
[    5.813778] run-job /lkp/jobs/scheduled/vm-lkp-hsw01-yocto-x86_64-43/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-61224adcd25b0abd01f02459e82b30735161e723-20180913-83000-1fq8z3y-0.yaml
[    5.813778] skip http request: cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/vm-lkp-hsw01-yocto-x86_64-43/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-61224adcd25b0abd01f02459e82b30735161e723-20180913-83000-1fq8z3y-0.yaml&job_state=running -O /dev/null
[    5.813778] target ucode:
[    5.925243] _warn_unseeded_randomness: 1521 callbacks suppressed
[    5.925255] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
[    5.929774] random: get_random_u64 called from load_elf_binary+0x5c1/0x1d80 with crng_init=0
[    5.933200] random: get_random_u32 called from map_vdso_randomized+0x9f/0xd0 with crng_init=0
[    6.823397] BusyBox v1.24.1 (2016-04-15 14:06:13 GMT) multi-call binary.
[    6.823397]
[    6.823397] Usage: time [-v] PROG ARGS
[    7.515148] _warn_unseeded_randomness: 76 callbacks suppressed
[    7.515157] random: get_random_u32 called from bucket_table_alloc+0x104/0x2f0 with crng_init=0
[    7.896417] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
[    7.897153] random: get_random_u64 called from load_elf_binary+0x5c1/0x1d80 with crng_init=0
[    8.825245] cat: write error: Invalid argument
[   14.808842] _warn_unseeded_randomness: 3 callbacks suppressed
[   14.808853] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
[   14.811599] random: get_random_u64 called from load_elf_binary+0x5c1/0x1d80 with crng_init=0
[   14.813791] random: get_random_u32 called from map_vdso_randomized+0x9f/0xd0 with crng_init=0
[   15.954725] _warn_unseeded_randomness: 5 callbacks suppressed
[   15.954741] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
[   15.959934] random: get_random_u64 called from load_elf_binary+0x5c1/0x1d80 with crng_init=0
[   15.962280] random: get_random_u64 called from arch_rnd+0x43/0x70 with crng_init=0
[   16.551517] trinity-main uses obsolete (PF_INET,SOCK_PACKET)
[   16.580197] general protection fault: 0000 [#1] PTI
[   16.580695] CPU: 0 PID: 662 Comm: trinity-c2 Tainted: G                T 4.19.0-rc2-00211-g61224ad #1
[   16.581517] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   16.582373] RIP: 0010:mqueue_get_tree+0x41/0x110
[   16.582846] Code: 29 4d 63 01 48 8b 45 00 4c 8b 20 31 c0 4d 85 e4 0f 95 c0 48 83 c0 02 48 83 04 c5 e8 af 02 83 01 4d 85 e4 74 50 e8 ef 13 be ff <49> 8b 04 24 4c 8b a0 40 04 00 00 31 c0 4d 85 e4 0f 95 c0 48 83 c0
[   16.584573] RSP: 0018:ffffc90000a57d90 EFLAGS: 00010293
[   16.585065] RAX: 0000000000000000 RBX: ffff88000b9f7228 RCX: 0000000000000000
[   16.585637] RDX: ffff8800099c4840 RSI: ffffffff81606341 RDI: ffff88000b9f7228
[   16.586261] RBP: ffff88000a630ac8 R08: ffffffff82f1dee0 R09: ffff88000a630ac8
[   16.586946] R10: ffffc90000a57d00 R11: ffff88000a630410 R12: 6b6b6b6b6b6b6b6b
[   16.587624] R13: ffff88000a4f7a78 R14: 0000000000000000 R15: ffffffff82c1c540
[   16.588319] FS:  000000000104a880(0000) GS:ffffffff82c3c000(0000) knlGS:0000000000000000
[   16.589139] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.589616] CR2: 00000000011ef7e8 CR3: 000000000a4f2000 CR4: 00000000000006b0
[   16.590323] Call Trace:
[   16.590600]  vfs_get_tree+0xe6/0x320
[   16.590973]  mq_init_ns+0xef/0x220
[   16.591310]  copy_ipcs+0x19c/0x250
[   16.592215]  create_new_namespaces+0x18b/0x4f0
[   16.592631]  unshare_nsproxy_namespaces+0xaa/0x140
[   16.593116]  ksys_unshare+0x3e3/0x6a0
[   16.593509]  __x64_sys_unshare+0x17/0x20
[   16.593918]  do_syscall_64+0xbc/0xa10
[   16.594308]  ? trace_hardirqs_off_thunk+0x1a/0x2b
[   16.594792]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   16.595305] RIP: 0033:0x458527
[   16.595639] Code: 00 00 00 b8 63 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 ad 72 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 10 01 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 8d 72 00 00 c3 66 2e 0f 1f 84 00 00 00 00
[   16.597125] RSP: 002b:00007ffc5559d628 EFLAGS: 00000217 ORIG_RAX: 0000000000000110
[   16.597881] RAX: ffffffffffffffda RBX: 00000000011f2e60 RCX: 0000000000458527
[   16.598554] RDX: 0000000001045510 RSI: 00007ffc5559d60c RDI: 0000000008000000
[   16.599178] RBP: 0000000000000296 R08: 00000000010454e4 R09: 0000000001045560
[   16.599759] R10: 0000000000456697 R11: 0000000000000217 R12: 00000000004b7820
[   16.600380] R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000000
[   16.601061] Modules linked in:
[   16.601412] ---[ end trace 9c0f5694bf6c3b03 ]---
[   16.601879] RIP: 0010:mqueue_get_tree+0x41/0x110
[   16.602307] Code: 29 4d 63 01 48 8b 45 00 4c 8b 20 31 c0 4d 85 e4 0f 95 c0 48 83 c0 02 48 83 04 c5 e8 af 02 83 01 4d 85 e4 74 50 e8 ef 13 be ff <49> 8b 04 24 4c 8b a0 40 04 00 00 31 c0 4d 85 e4 0f 95 c0 48 83 c0
[   16.603736] RSP: 0018:ffffc90000a57d90 EFLAGS: 00010293
[   16.604193] RAX: 0000000000000000 RBX: ffff88000b9f7228 RCX: 0000000000000000
[   16.604856] RDX: ffff8800099c4840 RSI: ffffffff81606341 RDI: ffff88000b9f7228
[   16.605492] RBP: ffff88000a630ac8 R08: ffffffff82f1dee0 R09: ffff88000a630ac8
[   16.606202] R10: ffffc90000a57d00 R11: ffff88000a630410 R12: 6b6b6b6b6b6b6b6b
[   16.606894] R13: ffff88000a4f7a78 R14: 0000000000000000 R15: ffffffff82c1c540
[   16.607597] FS:  000000000104a880(0000) GS:ffffffff82c3c000(0000) knlGS:0000000000000000
[   16.608413] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.609017] CR2: 00000000011ef7e8 CR3: 000000000a4f2000 CR4: 00000000000006b0
[   16.609710] Kernel panic - not syncing: Fatal exception
[   16.610226] Kernel Offset: disabled


lizhijian@haswell-OptiPlex-9020:~/lkp/lkp-qemu$ ls -ld ~/.lkp/
drwxr-xr-x 5 root root 4096 9月  19 10:12 /home/lizhijian/.lkp/
lizhijian@haswell-OptiPlex-9020:~/lkp/lkp-qemu$ ls -l ~/.lkp/cache/
total 12800
-rw-r--r-- 1 root root 6548980 9月  19 10:14 final_initrd
-rw-r--r-- 1 root root 4583149 9月  19 10:14 initrd-concatenated
drwxr-xr-x 3 root root    4096 9月  19 10:12 lkp
-rw-rw-r-- 1 root root 1964312 9月  19 10:12 lkp-x86_64-ad88cb1a437a_.cgz
drwxr-xr-x 4 root root    4096 9月  19 10:14 osimage


Thanks


>
> David

