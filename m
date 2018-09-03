Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38500C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC5320779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC5320779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbeICV0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:26:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39412 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbeICV0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:26:06 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AC554D00;
        Mon,  3 Sep 2018 17:05:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 000/107] 4.9.125-stable review
Date:   Mon,  3 Sep 2018 18:55:24 +0200
Message-Id: <20180903165637.293735109@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.125-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.125-rc1
X-KernelTest-Deadline: 2018-09-05T16:56+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.125 release.
There are 107 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Sep  5 16:56:13 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.125-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.125-rc1

Daniel Rosenberg <drosen@google.com>
    staging: android: ion: check for kref overflow

Scott Bauer <scott.bauer@intel.com>
    cdrom: Fix info leak/OOB read in cdrom_ioctl_drive_status

H. Nikolaus Schaller <hns@goldelico.com>
    power: generic-adc-battery: check for duplicate properties copied from iio channels

H. Nikolaus Schaller <hns@goldelico.com>
    power: generic-adc-battery: fix out-of-bounds write when copying channel properties

Dan Carpenter <dan.carpenter@oracle.com>
    PM / clk: signedness bug in of_pm_clk_add_clks()

Alberto Panizzo <alberto@amarulasolutions.com>
    clk: rockchip: fix clk_i2sout parent selection bits on rk3399

Mike Christie <mchristi@redhat.com>
    iscsi target: fix session creation failure handling

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: core: Avoid that SCSI device removal through sysfs triggers a deadlock

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: sysfs: Introduce sysfs_{un,}break_active_protection()

Paul Burton <paul.burton@mips.com>
    MIPS: lib: Provide MIPS64r6 __multi3() for GCC < 7

Maciej W. Rozycki <macro@mips.com>
    MIPS: Correct the 64-bit DSP accumulator register size

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes: Make list and blacklist root user read only

Sebastian Ott <sebott@linux.ibm.com>
    s390/pci: fix out of bounds access during irq setup

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/numa: move initial setup of node_to_cpumask_map

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qdio: reset old sbal_state flags

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: fix br_r1_trampoline for machines without exrl

Jann Horn <jannh@google.com>
    x86/entry/64: Wipe KASAN stack shadow before rewind_stack_do_exit()

Andi Kleen <ak@linux.intel.com>
    x86/speculation/l1tf: Increase l1tf memory limit for Nehalem+

Andi Kleen <ak@linux.intel.com>
    x86/spectre: Add missing family 6 check to microcode check

Nick Desaulniers <ndesaulniers@google.com>
    x86/irqflags: Mark native_restore_fl extern inline

Dan Carpenter <dan.carpenter@oracle.com>
    pinctrl: freescale: off by one in imx1_pinconf_group_dbg_show()

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ASoC: sirf: Fix potential NULL pointer dereference

Jerome Brunet <jbrunet@baylibre.com>
    ASoC: dpcm: don't merge format from invalid codec dai

Michael Buesch <m@bues.ch>
    b43/leds: Ensure NUL-termination of LED name string

Michael Buesch <m@bues.ch>
    b43legacy/leds: Ensure NUL-termination of LED name string

Mikulas Patocka <mpatocka@redhat.com>
    udl-kms: fix crash due to uninitialized memory

Mikulas Patocka <mpatocka@redhat.com>
    udl-kms: handle allocation failure

Mikulas Patocka <mpatocka@redhat.com>
    udl-kms: change down_interruptible to down

Kirill Tkhai <ktkhai@virtuozzo.com>
    fuse: Add missed unlock_page() to fuse_readpages_fill()

Miklos Szeredi <mszeredi@redhat.com>
    fuse: Fix oops at process_init_reply()

Miklos Szeredi <mszeredi@redhat.com>
    fuse: umount should wait for all requests

Miklos Szeredi <mszeredi@redhat.com>
    fuse: fix unlocked access to processing queue

Miklos Szeredi <mszeredi@redhat.com>
    fuse: fix double request_end()

Miklos Szeredi <mszeredi@redhat.com>
    fuse: fix initial parallel dirops

Andrey Ryabinin <aryabinin@virtuozzo.com>
    fuse: Don't access pipe->buffers without pipe_lock()

Josh Poimboeuf <jpoimboe@redhat.com>
    x86/kvm/vmx: Remove duplicate l1d flush definitions

Thomas Gleixner <tglx@xxxxxxxxxxxxx>
    KVM: x86: SVM: Call x86_spec_ctrl_set_guest/host() with interrupts disabled

Rian Hunter <rian@alum.mit.edu>
    x86/process: Re-export start_thread()

Vlastimil Babka <vbabka@suse.cz>
    x86/speculation/l1tf: Suggest what to do on systems with too much RAM

Vlastimil Babka <vbabka@suse.cz>
    x86/speculation/l1tf: Fix off-by-one error when warning that system has too much RAM

Vlastimil Babka <vbabka@suse.cz>
    x86/speculation/l1tf: Fix overflow in l1tf_pfn_limit() on 32bit

Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
    sparc: kernel/pcic: silence gcc 7.x warning in pcibios_fixup_bus()

Punit Agrawal <punit.agrawal@arm.com>
    KVM: arm/arm64: Skip updating PMD entry if no change

Punit Agrawal <punit.agrawal@arm.com>
    KVM: arm/arm64: Skip updating PTE entry if no change

Greg Hackmann <ghackmann@android.com>
    staging: android: ion: fix ION_IOC_{MAP,SHARE} use-after-free

Eric Sandeen <sandeen@redhat.com>
    ext4: reset error code in ext4_find_entry in fallback

Arnd Bergmann <arnd@arndb.de>
    ext4: sysfs: print ext4_super_block fields as little-endian

Theodore Ts'o <tytso@mit.edu>
    ext4: check for NUL characters in extended attribute's name

Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
    s390/kvm: fix deadlock when killed by oom

Greg Hackmann <ghackmann@android.com>
    arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes/arm64: Fix %p uses in error messages

Steve French <stfrench@microsoft.com>
    smb3: don't request leases in symlink creation and query

Steve French <stfrench@microsoft.com>
    smb3: Do not send SMB3 SET_INFO if nothing changed

Steve French <stfrench@microsoft.com>
    smb3: enumerating snapshots was leaving part of the data off end

Nicholas Mc Guire <hofrat@osadl.org>
    cifs: check kmalloc before use

Steve French <stfrench@microsoft.com>
    cifs: add missing debug entries for kconfig options

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: don't update offset in write

yujuan.qi <yujuan.qi@mediatek.com>
    Cipso: cipso_v4_optptr enter infinite loop

Ethan Zhao <ethan.zhao@oracle.com>
    sched/sysctl: Check user input value of sysctl_sched_time_avg

jie@chenjie6@huwei.com <jie@chenjie6@huwei.com>
    mm/memory.c: check return value of ioremap_prot

Jim Gill <jgill@vmware.com>
    scsi: vmw_pvscsi: Return DID_RESET for status SAM_STAT_COMMAND_TERMINATED

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: fcoe: clear FC_RP_STARTED flags when receiving a LOGO

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: fcoe: drop frames in ELS LOGO error path

Kirill Tkhai <ktkhai@virtuozzo.com>
    memcg: remove memcg_cgroup::id from IDR on mem_cgroup_css_alloc() failure

Colin Ian King <colin.king@canonical.com>
    drivers: net: lmc: fix case value for target abort error

Phillip Lougher <phillip@squashfs.org.uk>
    Squashfs: Compute expected length from inode size rather than block length

Linus Torvalds <torvalds@linux-foundation.org>
    squashfs metadata 2: electric boogaloo

Randy Dunlap <rdunlap@infradead.org>
    arc: fix type warnings in arc/mm/cache.c

Randy Dunlap <rdunlap@infradead.org>
    arc: fix build errors in arc/include/asm/delay.h

Randy Dunlap <rdunlap@infradead.org>
    arc: [plat-eznps] fix data type errors in platform headers

Govindarajulu Varadarajan <gvaradar@cisco.com>
    enic: handle mtu change for vf properly

Rafał Miłecki <rafal@milecki.pl>
    Revert "MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum"

Calvin Walton <calvin.walton@kepstin.ca>
    tools/power turbostat: Read extended processor family from CPUID

Li Wang <liwang@redhat.com>
    zswap: re-check zswap_is_full() after do zswap_shrink()

Masami Hiramatsu <mhiramat@kernel.org>
    selftests/ftrace: Add snapshot and tracing_on test case

Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
    cachefiles: Wait rather than BUG'ing on "Unexpected object collision"

Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
    cachefiles: Fix refcounting bug in backing-file read monitoring

Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
    fscache: Allow cancelled operations to be enqueued

Kees Cook <keescook@chromium.org>
    x86/boot: Fix if_changed build flip/flop bug

Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
    net: axienet: Fix double deregister of mdio

Aleksander Morgado <aleksander@aleksander.es>
    qmi_wwan: fix interface number for DW5821e production firmware

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    bnx2x: Fix invalid memory access in rss hash config path.

Guenter Roeck <linux@roeck-us.net>
    media: staging: omap4iss: Include asm/cacheflush.h after generic includes

Thomas Gleixner <tglx@linutronix.de>
    perf/x86/amd/ibs: Don't access non-started event

Alexander Sverdlin <alexander.sverdlin@nokia.com>
    i2c: davinci: Avoid zero value of CLKH

Nicholas Mc Guire <hofrat@osadl.org>
    can: mpc5xxx_can: check of_iomap return before use

Randy Dunlap <rdunlap@infradead.org>
    net: prevent ISA drivers from building on PPC32

Florian Westphal <fw@strlen.de>
    atl1c: reserve min skb headroom

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    qed: Correct Multicast API to reflect existence of 256 approximate buckets.

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    qed: Fix possible race for the link state value.

YueHaibing <yuehaibing@huawei.com>
    net: caif: Add a missing rcu_read_unlock() in caif_flow_cb

Len Brown <len.brown@intel.com>
    tools/power turbostat: fix -S on UP systems

Daniel Borkmann <daniel@iogearbox.net>
    bpf, ppc64: fix unexpected r0=0 exit path inside bpf_xadd

Eugeniu Rosca <roscaeugeniu@gmail.com>
    usb: gadget: f_uac2: fix endianness of 'struct cntrl_*_lay3'

Peter Senna Tschudin <peter.senna@gmail.com>
    tools: usb: ffs-test: Fix build on big endian systems

Randy Dunlap <rdunlap@infradead.org>
    usb/phy: fix PPC64 build errors in phy-fsl-usb.c

Jia-Ju Bai <baijiaju1990@gmail.com>
    usb: gadget: r8a66597: Fix a possible sleep-in-atomic-context bugs in r8a66597_queue()

Jia-Ju Bai <baijiaju1990@gmail.com>
    usb: gadget: r8a66597: Fix two possible sleep-in-atomic-context bugs in init_controller()

Lucas Stach <l.stach@pengutronix.de>
    drm/imx: imx-ldb: check if channel is enabled before printing warning

Lucas Stach <l.stach@pengutronix.de>
    drm/imx: imx-ldb: disable LDB on driver bind

Varun Prakash <varun@chelsio.com>
    scsi: libiscsi: fix possible NULL pointer dereference in case of TMF

Sean Paul <seanpaul@chromium.org>
    drm/bridge: adv7511: Reset registers on hotplug

Bernd Edlinger <bernd.edlinger@hotmail.de>
    nl80211: Add a missing break in parse_station_flags

mpubbise@codeaurora.org <mpubbise@codeaurora.org>
    mac80211: add stations tied to AP_VLANs during hw reconfig

Florian Westphal <fw@strlen.de>
    xfrm: free skb if nlsk pointer is NULL

Tommi Rantala <tommi.t.rantala@nokia.com>
    xfrm: fix missing dst_release() after policy blocking lbcast and multicast

Eyal Birger <eyal.birger@gmail.com>
    vti6: fix PMTU caching and reporting on xmit


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arc/include/asm/delay.h                       |  3 +
 arch/arc/mm/cache.c                                |  7 +-
 arch/arc/plat-eznps/include/plat/ctop.h            |  1 +
 arch/arm/kvm/mmu.c                                 | 42 +++++++++---
 arch/arm64/kernel/probes/kprobes.c                 |  2 +-
 arch/arm64/mm/init.c                               |  6 +-
 arch/mips/bcm47xx/setup.c                          |  6 --
 arch/mips/include/asm/mipsregs.h                   |  3 -
 arch/mips/include/asm/processor.h                  |  2 +-
 arch/mips/kernel/ptrace.c                          |  2 +-
 arch/mips/kernel/ptrace32.c                        |  2 +-
 arch/mips/lib/multi3.c                             |  6 +-
 arch/powerpc/net/bpf_jit_comp64.c                  | 29 ++------
 arch/s390/include/asm/qdio.h                       |  1 -
 arch/s390/mm/fault.c                               |  2 +
 arch/s390/net/bpf_jit_comp.c                       |  2 -
 arch/s390/numa/numa.c                              | 16 +----
 arch/s390/pci/pci.c                                |  2 +
 arch/sparc/kernel/pcic.c                           |  2 +-
 arch/x86/boot/compressed/Makefile                  |  8 ++-
 arch/x86/events/amd/ibs.c                          |  6 +-
 arch/x86/include/asm/irqflags.h                    |  3 +-
 arch/x86/include/asm/processor.h                   |  6 +-
 arch/x86/kernel/cpu/bugs.c                         | 50 ++++++++++++--
 arch/x86/kernel/cpu/common.c                       |  1 +
 arch/x86/kernel/cpu/intel.c                        |  3 +
 arch/x86/kernel/dumpstack.c                        |  4 ++
 arch/x86/kernel/process_64.c                       |  1 +
 arch/x86/kvm/svm.c                                 |  8 +--
 arch/x86/kvm/vmx.c                                 |  3 -
 arch/x86/mm/init.c                                 |  4 +-
 arch/x86/mm/mmap.c                                 |  2 +-
 drivers/base/power/clock_ops.c                     |  2 +-
 drivers/cdrom/cdrom.c                              |  2 +-
 drivers/clk/rockchip/clk-rk3399.c                  |  2 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       | 12 ++++
 drivers/gpu/drm/imx/imx-ldb.c                      |  9 ++-
 drivers/gpu/drm/udl/udl_fb.c                       |  2 +-
 drivers/gpu/drm/udl/udl_main.c                     | 35 +++++-----
 drivers/i2c/busses/i2c-davinci.c                   |  8 ++-
 drivers/misc/mei/main.c                            |  1 -
 drivers/net/can/mscan/mpc5xxx_can.c                |  5 ++
 drivers/net/ethernet/3com/Kconfig                  |  2 +-
 drivers/net/ethernet/amd/Kconfig                   |  4 +-
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c    |  1 +
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    | 13 +++-
 drivers/net/ethernet/cirrus/Kconfig                |  1 +
 drivers/net/ethernet/cisco/enic/enic_main.c        | 78 ++++++++--------------
 drivers/net/ethernet/qlogic/qed/qed_l2.c           | 15 ++---
 drivers/net/ethernet/qlogic/qed/qed_l2.h           |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c          |  1 +
 drivers/net/ethernet/qlogic/qed/qed_sriov.c        |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.c           |  4 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.h           |  7 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c  |  1 +
 drivers/net/usb/qmi_wwan.c                         |  2 +-
 drivers/net/wan/lmc/lmc_main.c                     |  2 +-
 drivers/net/wireless/broadcom/b43/leds.c           |  2 +-
 drivers/net/wireless/broadcom/b43legacy/leds.c     |  2 +-
 drivers/pinctrl/freescale/pinctrl-imx1-core.c      |  2 +-
 drivers/power/supply/generic-adc-battery.c         | 25 ++++---
 drivers/s390/cio/qdio_main.c                       |  5 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                      |  4 +-
 drivers/scsi/libfc/fc_rport.c                      |  1 +
 drivers/scsi/libiscsi.c                            | 12 ++--
 drivers/scsi/scsi_sysfs.c                          | 20 +++++-
 drivers/scsi/vmw_pvscsi.c                          | 11 ++-
 drivers/staging/android/ion/ion-ioctl.c            | 12 ++--
 drivers/staging/android/ion/ion.c                  | 65 ++++++++++++------
 drivers/staging/android/ion/ion_priv.h             |  6 +-
 drivers/staging/media/omap4iss/iss_video.c         |  3 +-
 drivers/target/iscsi/iscsi_target_login.c          | 35 ++++++----
 drivers/usb/gadget/function/f_uac2.c               | 20 +++---
 drivers/usb/gadget/udc/r8a66597-udc.c              |  6 +-
 drivers/usb/phy/phy-fsl-usb.c                      |  4 +-
 fs/cachefiles/namei.c                              |  1 -
 fs/cachefiles/rdwr.c                               | 17 +++--
 fs/cifs/cifs_debug.c                               | 30 +++++++--
 fs/cifs/inode.c                                    |  2 +
 fs/cifs/link.c                                     |  4 +-
 fs/cifs/sess.c                                     |  6 ++
 fs/cifs/smb2inode.c                                |  2 +-
 fs/cifs/smb2ops.c                                  | 34 ++++++++--
 fs/ext4/namei.c                                    |  1 +
 fs/ext4/sysfs.c                                    | 13 +++-
 fs/ext4/xattr.c                                    |  2 +
 fs/fscache/operation.c                             |  6 +-
 fs/fuse/dev.c                                      | 39 +++++++++--
 fs/fuse/dir.c                                      | 10 +--
 fs/fuse/file.c                                     |  1 +
 fs/fuse/fuse_i.h                                   |  5 +-
 fs/fuse/inode.c                                    | 37 +++++-----
 fs/squashfs/file.c                                 | 50 ++++++++------
 fs/squashfs/file_cache.c                           |  4 +-
 fs/squashfs/file_direct.c                          | 24 +++----
 fs/squashfs/squashfs.h                             |  3 +-
 fs/sysfs/file.c                                    | 44 ++++++++++++
 include/linux/sysfs.h                              | 14 ++++
 kernel/kprobes.c                                   |  4 +-
 kernel/sysctl.c                                    |  3 +-
 mm/memcontrol.c                                    | 15 +++--
 mm/memory.c                                        |  3 +
 mm/zswap.c                                         |  9 +++
 net/caif/caif_dev.c                                |  4 +-
 net/ipv4/cipso_ipv4.c                              | 12 +++-
 net/ipv6/ip6_vti.c                                 | 11 +--
 net/mac80211/util.c                                |  3 +-
 net/wireless/nl80211.c                             |  1 +
 net/xfrm/xfrm_policy.c                             |  3 +
 net/xfrm/xfrm_user.c                               | 10 +--
 sound/soc/sirf/sirf-usp.c                          |  7 +-
 sound/soc/soc-pcm.c                                |  8 +++
 tools/power/x86/turbostat/turbostat.c              |  8 +--
 .../selftests/ftrace/test.d/00basic/snapshot.tc    | 28 ++++++++
 tools/usb/ffs-test.c                               | 19 +++++-
 116 files changed, 778 insertions(+), 406 deletions(-)


