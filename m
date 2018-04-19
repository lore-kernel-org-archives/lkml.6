Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753138AbeDSBw0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 21:52:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46570 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752786AbeDSBwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 21:52:25 -0400
X-Google-Smtp-Source: AIpwx49djxoAcM4OjPdXDCqLh/y/53MsRDPORNozWXUVTcpomNVEKH1vRa/7X0NGVX7K8AyoRbQb3gJoIUdOe2rPw3Q=
MIME-Version: 1.0
In-Reply-To: <20180419013128.iurzouiqxvcnpbvz@wfg-t540p.sh.intel.com>
References: <20180418233825.GA33106@big-sky.local> <20180419013128.iurzouiqxvcnpbvz@wfg-t540p.sh.intel.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 18 Apr 2018 21:51:42 -0400
X-Gmail-Original-Message-ID: <CAGM2reZvZZy6b+SEtpz_a_JTGBEB2nhBdfZJSZ89F99szv9peA@mail.gmail.com>
Message-ID: <CAGM2reZvZZy6b+SEtpz_a_JTGBEB2nhBdfZJSZ89F99szv9peA@mail.gmail.com>
Subject: Re: c9e97a1997 BUG: kernel reboot-without-warning in early-boot
 stage, last printk: early console in setup code
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Dennis Zhou <dennisszhou@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <jbacik@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8867 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=6 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804190017
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3J1qXQK018476

Thank you, I am studying the problem.

Pavel

On Wed, Apr 18, 2018 at 9:31 PM, Fengguang Wu <fengguang.wu@intel.com> wrote:
> On Wed, Apr 18, 2018 at 06:38:25PM -0500, Dennis Zhou wrote:
>>Hi,
>>
>>On Wed, Apr 18, 2018 at 09:55:53PM +0800, Fengguang Wu wrote:
>>>
>>> Hello,
>>>
>>> FYI here is a slightly different boot error in mainline kernel 4.17.0-rc1.
>>> It also dates back to v4.16 .
>>>
>>> It occurs in 4 out of 4 boots.
>>>
>>> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 128873
>>> [    0.000000] Kernel command line: root=/dev/ram0 hung_task_panic=1 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw link=/kbuild-tests/run-queue/kvm/x86_64-randconfig-a0-04172313/linux-devel:devel-hourly-2018041714:60cc43fc888428bb2f18f08997432d426a243338/.vmlinuz-60cc43fc888428bb2f18f08997432d426a243338-20180418000325-19:yocto-lkp-nhm-dp2-4 branch=linux-devel/devel-hourly-2018041714 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a0-04172313/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/vmlinuz-4.17.0-rc1 drbd.minor_count=8 rcuperf.shutdown=0
>>> [    0.000000] sysrq: sysrq always enabled.
>>> [    0.000000] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
>>> [    0.000000] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
>>> PANIC: early exception 0x0d IP 10:ffffffffa892f15f error 0 cr2 0xffff88001fbff000
>>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G                T 4.17.0-rc1 #238
>>> [    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>>> [    0.000000] RIP: 0010:per_cpu_ptr_to_phys+0x16a/0x298:
>>>                                              __section_mem_map_addr at include/linux/mmzone.h:1188
>>>                                               (inlined by) per_cpu_ptr_to_phys at mm/percpu.c:1849
>>> [    0.000000] RSP: 0000:ffffffffab407e50 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
>>> [    0.000000] RAX: dffffc0000000000 RBX: ffff88001f17c340 RCX: 000000000000000f
>>> [    0.000000] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffacfbf580
>>> [    0.000000] RBP: ffffffffab40d000 R08: fffffbfff57c4eca R09: 0000000000000000
>>> [    0.000000] R10: ffff880015421000 R11: fffffbfff57c4ec9 R12: 0000000000000000
>>> [    0.000000] R13: ffff88001fb03ff8 R14: ffff88001fc051c0 R15: 0000000000000000
>>> [    0.000000] FS:  0000000000000000(0000) GS:ffffffffab4c5000(0000) knlGS:0000000000000000
>>> [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [    0.000000] CR2: ffff88001fbff000 CR3: 000000001a06c000 CR4: 00000000000006b0
>>> [    0.000000] Call Trace:
>>> [    0.000000]  setup_cpu_entry_areas+0x7b/0x27b:
>>>                                              setup_cpu_entry_area at arch/x86/mm/cpu_entry_area.c:104
>>>                                               (inlined by) setup_cpu_entry_areas at arch/x86/mm/cpu_entry_area.c:177
>>> [    0.000000]  trap_init+0xb/0x13d:
>>>                                              trap_init at arch/x86/kernel/traps.c:949
>>> [    0.000000]  start_kernel+0x2a5/0x91d:
>>>                                              mm_init at init/main.c:519
>>>                                               (inlined by) start_kernel at init/main.c:589
>>> [    0.000000]  ? thread_stack_cache_init+0x6/0x6
>>> [    0.000000]  ? memcpy_orig+0x16/0x110:
>>>                                              memcpy_orig at arch/x86/lib/memcpy_64.S:77
>>> [    0.000000]  ? x86_family+0x5/0x1d:
>>>                                              x86_family at arch/x86/lib/cpu.c:8
>>> [    0.000000]  ? load_ucode_bsp+0x42/0x13e:
>>>                                              load_ucode_bsp at arch/x86/kernel/cpu/microcode/core.c:183
>>> [    0.000000]  secondary_startup_64+0xa5/0xb0:
>>>                                              secondary_startup_64 at arch/x86/kernel/head_64.S:242
>>> [    0.000000] Code: 78 06 00 49 8b 45 00 48 85 c0 74 a5 49 c1 ec 28 41 81 e4 e0 0f 00 00 49 01 c4 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 74 08 4c 89 e7 e8 63 78 06 00 49 8b 04 24 81 e5 ff
>>> BUG: kernel hang in boot stage
>>>
>>
>>I spent some time bisecting this one and it seemse to be an intermittent
>>issue starting with this commit for me:
>>c9e97a1997, mm: initialize pages on demand during boot. The prior
>>commit, 3a2d7fa8a3, did not run into this issue after 10+ boots.
>
> Dennis, thanks for bisecting it down!
>
> Pavel, here is an early boot error bisected to c9e97a1997 ("mm:
> initialize pages on demand during boot"). Reproduce script attached.
>
> 3a2d7fa8a3  mm: disable interrupts while initializing deferred pages
> c9e97a1997  mm: initialize pages on demand during boot
> 48023102b7  Merge branch 'overlayfs-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs
> 238879f45b  Add linux-next specific files for 20180413
> +-------------------------------------------------------+------------+------------+------------+---------------+
> |                                                       | 3a2d7fa8a3 | c9e97a1997 | 48023102b7 | next-20180413 |
> +-------------------------------------------------------+------------+------------+------------+---------------+
> | boot_successes                                        | 51         | 9          | 10         | 3             |
> | boot_failures                                         | 1          | 12         | 11         | 9             |
> | Mem-Info                                              | 1          |            |            |               |
> | BUG:kernel_reboot-without-warning_in_early-boot_stage | 0          | 12         | 11         | 9             |
> +-------------------------------------------------------+------------+------------+------------+---------------+
>
> early console in setup code
> BUG: kernel reboot-without-warning in early-boot stage, last printk: early console in setup code
> Linux version 4.16.0-07313-gc9e97a1 #2
> Command line: root=/dev/ram0 hung_task_panic=1 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw link=/kbuild-tests/run-queue/yocto-ivb41/x86_64-randconfig-r0-04141244/linux-devel:devel-spot-201804141202:c9e97a1997fbf3a1d18d4065c2ca381f0704d7e5:bisect-linux-20/.vmlinuz-c9e97a1997fbf3a1d18d4065c2ca381f0704d7e5-20180414175501-14:yocto-ivb41-130 branch=linux-devel/devel-spot-201804141202 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-r0-04141244/gcc-6/c9e97a1997fbf3a1d18d4065c2ca381f0704d7e5/vmlinuz-4.16.0-07313-gc9e97a1 drbd.minor_count=8 rcuperf.shutdown=0
>
>
>                                                            # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
> git bisect start f6604fa7518c1cda05b95590a7965fd7ab502d16 0adb32858b0bddf4ada5f364a84ed60b196dbcda --
> git bisect  bad 036ea404fd8d46c7b2b6290f820212df3be70553  # 13:45  B      1     5    0   0  Merge 'linux-review/Daniel-Mack/wcn36xx-pass-correct-BSS-index-when-deleting-BSS-keys/20180413-220635' into devel-spot-201804141202
> git bisect  bad 0f85c8e00aecc556114d75a182a26bfe1ccadef0  # 14:00  B      0     8   22   0  Merge 'nfsd/nfsd-next' into devel-spot-201804141202
> git bisect  bad 7342865df7cb1e1f2120493de329665744fa8946  # 14:11  B      0    10   24   0  Merge 'linux-review/Hern-n-Gonzalez/Move-ad7746-driver-out-of-staging/20180414-090557' into devel-spot-201804141202
> git bisect good 895a25a4c71353fa48cf389d8003f5b30ecc30cc  # 14:22  G     17     0    1   1  Merge 'thermal/thermal-soc-v2' into devel-spot-201804141202
> git bisect  bad d5111e404f5518298cf50ba910ac3a3362572d0d  # 14:35  B      2     7    1   3  Merge 'linux-review/Hans-de-Goede/ACPI-LPSS-Only-call-pwm_add_table-for-Bay-Trail-PWM-if-PMIC-HRV-is-2/20180414-092906' into devel-spot-201804141202
> git bisect  bad 1fb7bf52382687618e345cc587abdf301c3d485a  # 14:59  B      0     3   17   0  Merge 'linux-review/Christian-Brauner/statfs-handle-mount-propagation/20180414-104639' into devel-spot-201804141202
> git bisect good f9ca6a561d40115696a54f16085c4edb17effc74  # 15:19  G     17     0    0   0  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
> git bisect good b240b419db5d624ce7a5a397d6f62a1a686009ec  # 15:30  G     17     0    2   2  Merge tag 'armsoc-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
> git bisect  bad 49a695ba723224875df50e327bd7b0b65dd9a56b  # 15:41  B      0     3   17   0  Merge tag 'powerpc-4.17-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> git bisect  bad 28da7be5ebc096ada5e6bc526c623bdd8c47800a  # 15:50  B      0     6   20   0  Merge tag 'mailbox-v4.17' of git://git.linaro.org/landing-teams/working/fujitsu/integration
> git bisect good 38c23685b273cfb4ccf31a199feccce3bdcb5d83  # 16:03  G     17     0    1   1  Merge tag 'armsoc-drivers' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
> git bisect good 3fd14cdcc05a682b03743683ce3a726898b20555  # 16:18  G     17     0    3   3  Merge tag 'mtd/for-4.17' of git://git.infradead.org/linux-mtd
> git bisect  bad e92bb4dd9673945179b1fc738c9817dd91bfb629  # 16:30  B      1    10    0   3  mm: fix races between address_space dereference and free in page_evicatable
> git bisect good d5f866550df237861f9d59ca0206434b0dea9701  # 16:46  G     17     0    2   2  slab: make size_index[] array u8
> git bisect good 613a5eb5677923fdaecfa582738c7bcf80abe186  # 16:56  G     17     0    1   1  slab, slub: remove size disparity on debug kernel
> git bisect  bad ba325585230ed17079fd5b4065c359ebba117bbe  # 17:11  B      0     9   23   0  mm/memory_hotplug: enforce block size aligned range check
> git bisect good 310253514bbf179c5f82e20a7a4bbf07abc7f5ad  # 17:22  G     17     0    1   1  mm/migrate: rename migration reason MR_CMA to MR_CONTIG_RANGE
> git bisect good 3a2d7fa8a3d5ae740bd0c21d933acc6220857ed0  # 17:35  G     17     0    3   3  mm: disable interrupts while initializing deferred pages
> git bisect  bad f0849ac0b8e072073ec5fcc7fadd05a77434364e  # 17:44  B      0     9   23   0  mm: thp: fix potential clearing to referenced flag in page_idle_clear_pte_refs_one()
> git bisect  bad c9e97a1997fbf3a1d18d4065c2ca381f0704d7e5  # 17:55  B      0     1   15   0  mm: initialize pages on demand during boot
> # first bad commit: [c9e97a1997fbf3a1d18d4065c2ca381f0704d7e5] mm: initialize pages on demand during boot
> git bisect good 3a2d7fa8a3d5ae740bd0c21d933acc6220857ed0  # 18:00  G     51     0    2   5  mm: disable interrupts while initializing deferred pages
> # extra tests with debug options
> git bisect  bad c9e97a1997fbf3a1d18d4065c2ca381f0704d7e5  # 18:09  B      2     5    0   0  mm: initialize pages on demand during boot
> # extra tests on HEAD of linux-devel/devel-spot-201804141202
> git bisect  bad f6604fa7518c1cda05b95590a7965fd7ab502d16  # 18:09  B      3    10    0   0  0day head guard for 'devel-spot-201804141202'
> # extra tests on tree/branch linus/master
> git bisect  bad 48023102b7078a6674516b1fe0d639669336049d  # 18:21  B      1     9    1   2  Merge branch 'overlayfs-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs
> # extra tests with first bad commit reverted
> git bisect good 4fed2454050629cde24d5b66649a136d07c89f1b  # 18:41  G     17     0    2   2  Revert "mm: initialize pages on demand during boot"
> # extra tests on tree/branch linux-next/master
> git bisect  bad 238879f45b80794d457ca553ff26986a833f1d2c  # 19:08  B      2     9    1   1  Add linux-next specific files for 20180413
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/lkp                          Intel Corporation
