Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569F1ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE309208FE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE309208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388113AbeGPIGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:06:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47274 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbeGPIGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:06:07 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B7459C03;
        Mon, 16 Jul 2018 07:40:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/54] 4.14.56-stable review
Date:   Mon, 16 Jul 2018 09:34:57 +0200
Message-Id: <20180716073450.534886211@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.56-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.56-rc1
X-KernelTest-Deadline: 2018-07-18T07:35+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.56 release.
There are 54 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Jul 18 07:34:24 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.56-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.56-rc1

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: give message and set need_fsck given broken node id

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    loop: remember whether sysfs_create_group() was done

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucm: Mark UCM interface as BROKEN

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    PM / hibernate: Fix oops at snapshot_write()

Theodore Ts'o <tytso@mit.edu>
    loop: add recursion validation to LOOP_CHANGE_FD

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: initialise match/target check parameter struct

Eric Dumazet <edumazet@google.com>
    netfilter: nf_queue: augment nfqa_cfg_policy

Oleg Nesterov <oleg@redhat.com>
    uprobes/x86: Remove incorrect WARN_ON() in uprobe_init_insn()

Eric Biggers <ebiggers@google.com>
    crypto: x86/salsa20 - remove x86 salsa20 implementations

Keith Busch <keith.busch@intel.com>
    nvme-pci: Remap CMB SQ entries on every controller reset

Juergen Gross <jgross@suse.com>
    xen: setup pv irq ops vector earlier

Steve Wise <swise@opengridcomputing.com>
    iw_cxgb4: correctly enforce the max reg_mr depth

Jon Hunter <jonathanh@nvidia.com>
    i2c: tegra: Fix NACK error handling

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Fix incorrect mixing of ERR_PTR and NULL return values

Paul Menzel <pmenzel@molgen.mpg.de>
    tools build: fix # escaping in .cmd files for future Make

Yandong Zhao <yandong77520@gmail.com>
    arm64: neon: Fix function may_use_simd() return error status

Randy Dunlap <rdunlap@infradead.org>
    kbuild: delete INSTALL_FW_PATH from kbuild documentation

Joel Fernandes (Google) <joel@joelfernandes.org>
    tracing: Reorder display of TGID to be after PID

Michal Hocko <mhocko@suse.com>
    mm: do not bug_on on incorrect length in __mm_populate()

Oscar Salvador <osalvador@suse.de>
    fs, elf: make sure to page align bss in load_elf_library

Vlastimil Babka <vbabka@suse.cz>
    fs/proc/task_mmu.c: fix Locked field in /proc/pid/smaps*

Christian Borntraeger <borntraeger@de.ibm.com>
    mm: do not drop unused pages when userfaultd is running

Chris Wilson <chris@chris-wilson.co.uk>
    ALSA: hda - Handle pm failure during hotplug

Hui Wang <hui.wang@canonical.com>
    ALSA: hda/realtek - two more lenovo models need fixup of MIC_LOCATION

Ming Lei <ming.lei@redhat.com>
    scsi: megaraid_sas: fix selection of reply queue

Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
    scsi: megaraid_sas: Create separate functions to allocate ctrl memory

Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
    scsi: megaraid_sas: replace is_ventura with adapter_type checks

Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
    scsi: megaraid_sas: replace instance->ctrl_context checks with instance->adapter_type

Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
    scsi: megaraid_sas: use adapter_type for all gen controllers

Christoph Hellwig <hch@lst.de>
    genirq/affinity: assign vectors to all possible CPUs

Linus Torvalds <torvalds@linux-foundation.org>
    Fix up non-directory creation in SGID directories

Christian Brauner <christian.brauner@ubuntu.com>
    devpts: resolve devpts bind-mounts

Christian Brauner <christian.brauner@ubuntu.com>
    devpts: hoist out check for DEVPTS_SUPER_MAGIC

Dan Carpenter <dan.carpenter@oracle.com>
    xhci: xhci-mem: off by one in xhci_stream_id_to_ring()

Nico Sneck <snecknico@gmail.com>
    usb: quirks: add delay quirks for Corsair Strafe

Johan Hovold <johan@kernel.org>
    USB: serial: mos7840: fix status-register error handling

Jann Horn <jannh@google.com>
    USB: yurex: fix out-of-bounds uaccess in read handler

Johan Hovold <johan@kernel.org>
    USB: serial: keyspan_pda: fix modem-status error handling

Olli Salonen <olli.salonen@iki.fi>
    USB: serial: cp210x: add another USB ID for Qivicon ZigBee stick

Dan Carpenter <dan.carpenter@oracle.com>
    USB: serial: ch341: fix type promotion bug in ch341_control_in()

Hans de Goede <hdegoede@redhat.com>
    ahci: Disable LPM on Lenovo 50 series laptops with a too old BIOS

Nadav Amit <namit@vmware.com>
    vmw_balloon: fix inflation with batching

Damien Le Moal <damien.lemoal@wdc.com>
    ata: Fix ZBC_OUT all bit handling

Damien Le Moal <damien.lemoal@wdc.com>
    ata: Fix ZBC_OUT command block check

Ping-Ke Shih <pkshih@realtek.com>
    staging: r8822be: Fix RTL8822be can't find any wireless AP

Murray McAllister <murray.mcallister@insomniasec.com>
    staging: rtl8723bs: Prevent an underflow in rtw_check_beacon_data().

Jann Horn <jannh@google.com>
    ibmasm: don't write out of bounds in read handler

x00270170 <xiaqing17@hisilicon.com>
    mmc: dw_mmc: fix card threshold control configuration

Stefan Agner <stefan@agner.ch>
    mmc: sdhci-esdhc-imx: allow 1.8V modes without 100/200MHz pinctrl states

Paul Burton <paul.burton@mips.com>
    MIPS: Fix ioremap() RAM check

Paul Burton <paul.burton@mips.com>
    MIPS: Use async IPIs for arch_trigger_cpumask_backtrace()

Paul Burton <paul.burton@mips.com>
    MIPS: Call dump_stack() from show_regs()

Kai Chieh Chuang <kaichieh.chuang@mediatek.com>
    ASoC: mediatek: preallocate pages use platform device

Sean Young <sean@mess.org>
    media: rc: mce_kbd decoder: fix stuck keys


-------------

Diffstat:

 Documentation/kbuild/kbuild.txt                    |    9 -
 Makefile                                           |    4 +-
 arch/arm64/include/asm/simd.h                      |   19 +-
 arch/mips/kernel/process.c                         |   43 +-
 arch/mips/kernel/traps.c                           |    1 +
 arch/mips/mm/ioremap.c                             |   37 +-
 arch/x86/crypto/Makefile                           |    4 -
 arch/x86/crypto/salsa20-i586-asm_32.S              | 1114 --------------------
 arch/x86/crypto/salsa20-x86_64-asm_64.S            |  919 ----------------
 arch/x86/crypto/salsa20_glue.c                     |  116 --
 arch/x86/kernel/uprobes.c                          |    2 +-
 arch/x86/xen/enlighten_pv.c                        |   24 +-
 arch/x86/xen/irq.c                                 |    4 +-
 crypto/Kconfig                                     |   26 -
 drivers/ata/ahci.c                                 |   59 ++
 drivers/ata/libata-core.c                          |    3 +
 drivers/ata/libata-scsi.c                          |   18 +-
 drivers/block/loop.c                               |   79 +-
 drivers/block/loop.h                               |    1 +
 drivers/i2c/busses/i2c-tegra.c                     |   17 +-
 drivers/infiniband/Kconfig                         |   12 +
 drivers/infiniband/core/Makefile                   |    4 +-
 drivers/infiniband/hw/cxgb4/mem.c                  |    2 +-
 drivers/infiniband/hw/hfi1/rc.c                    |    2 +-
 drivers/infiniband/hw/hfi1/uc.c                    |    4 +-
 drivers/infiniband/hw/hfi1/ud.c                    |    4 +-
 drivers/infiniband/hw/hfi1/verbs_txreq.c           |    4 +-
 drivers/infiniband/hw/hfi1/verbs_txreq.h           |    4 +-
 drivers/media/rc/ir-mce_kbd-decoder.c              |    2 +
 drivers/misc/ibmasm/ibmasmfs.c                     |   27 +-
 drivers/misc/vmw_balloon.c                         |    4 +-
 drivers/mmc/host/dw_mmc.c                          |    7 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   21 +-
 drivers/nvme/host/pci.c                            |   27 +-
 drivers/scsi/megaraid/megaraid_sas.h               |   10 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |  296 ++++--
 drivers/scsi/megaraid/megaraid_sas_fp.c            |   20 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c        |   54 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.h        |    7 -
 drivers/staging/rtl8723bs/core/rtw_ap.c            |    2 +-
 drivers/staging/rtlwifi/rtl8822be/hw.c             |    2 +-
 drivers/staging/rtlwifi/wifi.h                     |    1 +
 drivers/usb/core/quirks.c                          |    4 +
 drivers/usb/host/xhci-mem.c                        |    2 +-
 drivers/usb/misc/yurex.c                           |   23 +-
 drivers/usb/serial/ch341.c                         |    2 +-
 drivers/usb/serial/cp210x.c                        |    1 +
 drivers/usb/serial/keyspan_pda.c                   |    4 +-
 drivers/usb/serial/mos7840.c                       |    3 +
 fs/binfmt_elf.c                                    |    5 +-
 fs/devpts/inode.c                                  |   48 +-
 fs/f2fs/f2fs.h                                     |   13 +-
 fs/f2fs/inode.c                                    |   13 +-
 fs/f2fs/node.c                                     |   21 +-
 fs/inode.c                                         |    6 +
 fs/proc/task_mmu.c                                 |    2 +-
 include/linux/libata.h                             |    1 +
 kernel/irq/affinity.c                              |   30 +-
 kernel/power/user.c                                |    5 +
 kernel/trace/trace.c                               |    8 +-
 kernel/trace/trace_output.c                        |    5 +-
 mm/gup.c                                           |    2 -
 mm/mmap.c                                          |   29 +-
 mm/rmap.c                                          |    8 +-
 net/bridge/netfilter/ebtables.c                    |    2 +
 net/ipv4/netfilter/ip_tables.c                     |    1 +
 net/ipv6/netfilter/ip6_tables.c                    |    1 +
 net/netfilter/nfnetlink_queue.c                    |    3 +
 sound/pci/hda/patch_hdmi.c                         |   19 +-
 sound/pci/hda/patch_realtek.c                      |    6 +-
 .../soc/mediatek/common/mtk-afe-platform-driver.c  |    4 +-
 tools/build/Build.include                          |    4 +-
 72 files changed, 665 insertions(+), 2625 deletions(-)


