Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB5CC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AA2217C6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AA2217C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387657AbeHDLHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:07:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49436 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeHDLHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:07:45 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BE3F689C;
        Sat,  4 Aug 2018 09:07:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 000/124] 4.4.146-stable review
Date:   Sat,  4 Aug 2018 10:59:49 +0200
Message-Id: <20180804082702.434482435@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.146-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.146-rc1
X-KernelTest-Deadline: 2018-08-06T08:27+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.146 release.
There are 124 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon Aug  6 08:26:39 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.146-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.146-rc1

Tony Battersby <tonyb@cybernetics.com>
    scsi: sg: fix minor memory leak in error path

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: padlock-aes - Fix Nano workaround data corruption

Roman Kagan <rkagan@virtuozzo.com>
    kvm: x86: vmx: fix vpid leak

Jiang Biao <jiang.biao2@zte.com.cn>
    virtio_balloon: fix another race between migration and ballooning

Jeremy Cline <jcline@redhat.com>
    net: socket: fix potential spectre v1 gadget in socketcall

Anton Vasilyev <vasilyev@ispras.ru>
    can: ems_usb: Fix memory leak on ems_usb_disconnect()

Linus Torvalds <torvalds@linux-foundation.org>
    squashfs: more metadata hardenings

Linus Torvalds <torvalds@linux-foundation.org>
    squashfs: more metadata hardening

Jeremy Cline <jcline@redhat.com>
    netlink: Fix spectre v1 gadget in netlink_create()

Florian Fainelli <f.fainelli@gmail.com>
    net: dsa: Do not suspend/resume closed slave_dev

Eric Dumazet <edumazet@google.com>
    inet: frag: enforce memory limits earlier

Eric Dumazet <edumazet@google.com>
    tcp: add one more quick ack after after ECN events

Yousuk Seung <ysseung@google.com>
    tcp: refactor tcp_ecn_check_ce to remove sk type cast

Eric Dumazet <edumazet@google.com>
    tcp: do not aggressively quick ack after ECN events

Eric Dumazet <edumazet@google.com>
    tcp: add max_quickacks param to tcp_incr_quickack and tcp_enter_quickack_mode

Eric Dumazet <edumazet@google.com>
    tcp: do not force quickack when receiving out-of-order packets

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    NET: stmmac: align DMA stuff to largest cache line length

Dmitry Safonov <dima@arista.com>
    netlink: Don't shift with UB on nlk->ngroups

Dmitry Safonov <dima@arista.com>
    netlink: Do not subscribe to non-existent groups

Xiao Liang <xiliang@redhat.com>
    xen-netfront: wait xenbus state change when load module manually

Stefan Wahren <stefan.wahren@i2se.com>
    net: lan78xx: fix rx handling before first packet is send

tangpengpeng <tangpengpeng@higon.com>
    net: fix amd-xgbe flow-control issue

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    ipv4: remove BUG_ON() from fib_compute_spec_dst

Andrea Adami <andrea.adami@gmail.com>
    ASoC: pxa: Fix module autoload for platform drivers

Eric Engestrom <eric.engestrom@imgtec.com>
    dmaengine: pxa_dma: remove duplicate const qualifier

Theodore Ts'o <tytso@mit.edu>
    ext4: check for allocation block validity with block group locked

Theodore Ts'o <tytso@mit.edu>
    ext4: fix inline data updates with checksums enabled

Linus Torvalds <torvalds@linux-foundation.org>
    squashfs: be more careful about metadata corruption

Theodore Ts'o <tytso@mit.edu>
    random: mix rdrand with entropy sent in from userspace

José Roberto de Souza <jose.souza@intel.com>
    drm: Add DP PSR2 sink enable bit

Mauro Carvalho Chehab <mchehab@s-opensource.com>
    media: si470x: fix __be16 annotations

Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
    scsi: megaraid_sas: Increase timeout by 1 sec for non-RAID fastpath IOs

Xose Vazquez Perez <xose.vazquez@gmail.com>
    scsi: scsi_dh: replace too broad "TP9" string with the exact models

Suman Anna <s-anna@ti.com>
    media: omap3isp: fix unbalanced dma_iommu_mapping

Tudor-Dan Ambarus <tudor.ambarus@microchip.com>
    crypto: authenc - don't leak pointers to authenc keys

Tudor-Dan Ambarus <tudor.ambarus@microchip.com>
    crypto: authencesn - don't leak pointers to authenc keys

Dominik Bozek <dominikx.bozek@intel.com>
    usb: hub: Don't wait for connect state at resume for powered-off ports

Michal Simek <michal.simek@xilinx.com>
    microblaze: Fix simpleImage format generation

Ondrej Mosnáček <omosnace@redhat.com>
    audit: allow not equal op for audit by executable

Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
    rsi: Fix 'invalid vdd' warning in mmc

Chris Novakovic <chris@chrisn.me.uk>
    ipconfig: Correctly initialise ic_nameservers

Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
    drm/gma500: fix psb_intel_lvds_mode_valid()'s return type

Dmitry Osipenko <digetx@gmail.com>
    memory: tegra: Apply interrupts mask per SoC

Dmitry Osipenko <digetx@gmail.com>
    memory: tegra: Do not handle spurious interrupts

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: hda/ca0132: fix build failure when a local macro is defined

Satendra Singh Thakur <satendra.t@samsung.com>
    drm/atomic: Handling the case when setting old crtc for plane

Mauro Carvalho Chehab <mchehab@s-opensource.com>
    media: siano: get rid of __le32/__le16 cast warnings

Jakub Kicinski <jakub.kicinski@netronome.com>
    bpf: fix references to free_bpf_prog_info() in comments

Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
    thermal: exynos: fix setting rising_threshold for Exynos5433

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: megaraid: silence a static checker bug

Wenwen Wang <wang6495@umn.edu>
    scsi: 3w-xxxx: fix a missing-check bug

Wenwen Wang <wang6495@umn.edu>
    scsi: 3w-9xxx: fix a missing-check bug

Thomas Richter <tmricht@linux.ibm.com>
    perf: fix invalid bit in diagnostic entry

Thomas Richter <tmricht@linux.ibm.com>
    s390/cpum_sf: Add data entry sizes to sampling trailer entry

Sean Lanigan <sean@lano.id.au>
    brcmfmac: Add support for bcm43364 wireless chipset

Jane Wan <Jane.Wan@nokia.com>
    mtd: rawnand: fsl_ifc: fix FSL NAND driver to read all ONFI parameter pages

Brad Love <brad@nextdimension.cc>
    media: saa7164: Fix driver name in debug output

Damien Le Moal <damien.lemoal@wdc.com>
    libata: Fix command retry decision

Wei Yongjun <yongjun_wei@trendmicro.com.cn>
    media: rcar_jpu: Add missing clk_disable_unprepare() on error in jpu_open()

Marc Zyngier <marc.zyngier@arm.com>
    dma-iommu: Fix compilation when !CONFIG_IOMMU_DMA

DaeRyong Jeong <threeearcat@gmail.com>
    tty: Fix data race in tty_insert_flip_string_fixed_flag

Dmitry Torokhov <dtor@chromium.org>
    HID: i2c-hid: check if device is there before really probing

Jonathan Neuschäfer <j.neuschaefer@gmx.net>
    powerpc/embedded6xx/hlwd-pic: Prevent interrupts from being handled by Starlet

Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
    drm/radeon: fix mode_valid's return type

Terry Junge <terry.junge@plantronics.com>
    HID: hid-plantronics: Re-resend Update to map button for PTT products

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Apply rate limit to warning messages in URB complete callback

Colin Ian King <colin.king@canonical.com>
    media: smiapp: fix timeout checking in smiapp_read_nvm

Yufen Yu <yuyufen@huawei.com>
    md: fix NULL dereference of mddev->pers in remove_and_add_spares()

Anson Huang <Anson.Huang@nxp.com>
    regulator: pfuze100: add .is_enable() for pfuze100_swb_regulator_ops

Takashi Iwai <tiwai@suse.de>
    ALSA: emu10k1: Rate-limit error messages about page errors

Maya Erez <merez@codeaurora.org>
    scsi: ufs: fix exception event handling

Xinming Hu <huxm@marvell.com>
    mwifiex: correct histogram data with appropriate index

Mika Westerberg <mika.westerberg@linux.intel.com>
    PCI: pciehp: Request control of native hotplug only if supported

Julia Lawall <Julia.Lawall@lip6.fr>
    pinctrl: at91-pio4: add missing of_node_put

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/8xx: fix invalid register expression in head_8xx.S

Mathieu Malaterre <malat@debian.org>
    powerpc/powermac: Mark variable x as unused

Mathieu Malaterre <malat@debian.org>
    powerpc/powermac: Add missing prototype for note_bootable_part()

Mathieu Malaterre <malat@debian.org>
    powerpc/chrp/time: Make some functions static, add missing header include

Mathieu Malaterre <malat@debian.org>
    powerpc/32: Add a missing include header

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath: Add regulatory mapping for Bahamas

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath: Add regulatory mapping for Bermuda

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath: Add regulatory mapping for Serbia

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath: Add regulatory mapping for Tanzania

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath: Add regulatory mapping for Uganda

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath: Add regulatory mapping for APL2_FCCA

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath: Add regulatory mapping for APL13_WORLD

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath: Add regulatory mapping for ETSI8_WORLD

Sven Eckelmann <sven.eckelmann@openmesh.com>
    ath: Add regulatory mapping for FCC3_ETSIC

Christoph Hellwig <hch@lst.de>
    PCI: Prevent sysfs disable of device while driver is attached

Qu Wenruo <wqu@suse.com>
    btrfs: qgroup: Finish rescan when hit the last leaf of extent tree

David Sterba <dsterba@suse.com>
    btrfs: add barriers to btrfs_sync_log before log_commit_wait wakeups

Hans Verkuil <hans.verkuil@cisco.com>
    media: videobuf2-core: don't call memop 'finish' when queueing

Eyal Reizer <eyalreizer@gmail.com>
    wlcore: sdio: check for valid platform device data before suspend

Ganapathi Bhat <gbhat@marvell.com>
    mwifiex: handle race during mwifiex_usb_disconnect

Vincent Palatin <vpalatin@chromium.org>
    mfd: cros_ec: Fail early if we cannot identify the EC

Kai Chieh Chuang <kaichieh.chuang@mediatek.com>
    ASoC: dpcm: fix BE dai not hw_free and shutdown

Jian-Hong Pan <jian-hong@endlessm.com>
    Bluetooth: btusb: Add a new Realtek 8723DE ID 2ff8:b011

Thierry Escande <thierry.escande@linaro.org>
    Bluetooth: hci_qca: Fix "Sleep inside atomic section" warning

Shaul Triebitz <shaul.triebitz@intel.com>
    iwlwifi: pcie: fix race in Rx buffer allocator

Kan Liang <kan.liang@intel.com>
    perf/x86/intel/uncore: Correct fixed counter index check for NHM

Kan Liang <kan.liang@intel.com>
    perf/x86/intel/uncore: Correct fixed counter index check in generic code

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    usbip: usbip_detach: Fix memory, udev context and udev leak

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to don't trigger writeback during recovery

Anatoly Pugachev <matorola@gmail.com>
    disable loading f2fs module on PAGE_SIZE > 4KB

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mad: Convert BUG_ONs to error flows

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Fix compiler store ordering to SLB shadow area

Stewart Smith <stewart@linux.ibm.com>
    hvc_opal: don't set tb_ticks_per_usec in udbg_init_opal_common()

Cong Wang <xiyou.wangcong@gmail.com>
    infiniband: fix a possible use-after-free bug

Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
    netfilter: ipset: List timing out entries with "timeout 1" instead of zero

Alexandre Belloni <alexandre.belloni@bootlin.com>
    rtc: ensure rtc_set_alarm fails when alarms are not supported

Mathieu Malaterre <malat@debian.org>
    mm/slub.c: add __printf verification to slab_err()

Chintan Pandya <cpandya@codeaurora.org>
    mm: vmalloc: avoid racy handling of debugobjects in vunmap

Scott Mayhew <smayhew@redhat.com>
    nfsd: fix potential use-after-free in nfsd4_decode_getdeviceinfo

Zhouyang Jia <jiazhouyang09@gmail.com>
    ALSA: fm801: add error handling for snd_ctl_add

Zhouyang Jia <jiazhouyang09@gmail.com>
    ALSA: emu10k1: add error handling for snd_ctl_add

Juergen Gross <jgross@suse.com>
    xen/netfront: raise max number of slots in xennet_get_responses()

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Quiet gcc warning about maybe unused link variable

Artem Savkov <asavkov@redhat.com>
    tracing/kprobes: Fix trace_probe flags on enable_trace_kprobe() failure

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix possible double free in event_enable_trigger_func()

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix double free of event_trigger_data

KT Liao <kt.liao@emc.com.tw>
    Input: elan_i2c - add another ACPI ID for Lenovo Ideapad 330-15AST

Chen-Yu Tsai <wens@csie.org>
    Input: i8042 - add Lenovo LaVie Z to the i8042 reset list

Donald Shanty III <dshanty@protonmail.com>
    Input: elan_i2c - add ACPI ID for lenovo ideapad 330

Paul Burton <paul.burton@mips.com>
    MIPS: Fix off-by-one in pci_resource_to_user()


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/microblaze/boot/Makefile                      | 10 +++--
 arch/mips/include/asm/pci.h                        |  2 +-
 arch/powerpc/kernel/head_8xx.S                     |  2 +-
 arch/powerpc/kernel/pci_32.c                       |  1 +
 arch/powerpc/mm/slb.c                              |  8 ++--
 arch/powerpc/platforms/chrp/time.c                 |  6 ++-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |  5 +++
 arch/powerpc/platforms/powermac/bootx_init.c       |  4 +-
 arch/powerpc/platforms/powermac/setup.c            |  1 +
 arch/s390/include/asm/cpu_mf.h                     |  6 ++-
 arch/x86/kernel/cpu/perf_event_intel_uncore.c      |  2 +-
 .../x86/kernel/cpu/perf_event_intel_uncore_nhmex.c |  2 +-
 arch/x86/kvm/vmx.c                                 |  7 ++--
 crypto/authenc.c                                   |  1 +
 crypto/authencesn.c                                |  1 +
 drivers/acpi/pci_root.c                            |  4 +-
 drivers/ata/libata-eh.c                            | 12 ++++--
 drivers/bluetooth/btusb.c                          |  3 ++
 drivers/bluetooth/hci_qca.c                        |  2 +-
 drivers/char/random.c                              | 10 ++++-
 drivers/crypto/padlock-aes.c                       |  8 +++-
 drivers/dma/pxa_dma.c                              |  2 +-
 drivers/gpu/drm/drm_atomic.c                       |  4 +-
 drivers/gpu/drm/gma500/psb_intel_drv.h             |  2 +-
 drivers/gpu/drm/gma500/psb_intel_lvds.c            |  2 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         | 10 ++---
 drivers/hid/hid-plantronics.c                      |  6 ++-
 drivers/hid/i2c-hid/i2c-hid.c                      |  8 ++++
 drivers/infiniband/core/mad.c                      | 11 +++--
 drivers/infiniband/core/ucma.c                     |  6 ++-
 drivers/input/mouse/elan_i2c_core.c                |  2 +
 drivers/input/serio/i8042-x86ia64io.h              |  7 ++++
 drivers/md/md.c                                    |  3 ++
 drivers/media/common/siano/smsendian.c             | 14 +++----
 drivers/media/i2c/smiapp/smiapp-core.c             | 11 +++--
 drivers/media/pci/saa7164/saa7164-fw.c             |  3 +-
 drivers/media/platform/omap3isp/isp.c              |  7 ++--
 drivers/media/platform/rcar_jpu.c                  |  4 +-
 drivers/media/radio/si470x/radio-si470x-i2c.c      |  6 +--
 drivers/media/v4l2-core/videobuf2-core.c           |  9 ++--
 drivers/memory/tegra/mc.c                          | 22 +++-------
 drivers/memory/tegra/mc.h                          |  9 ++++
 drivers/memory/tegra/tegra114.c                    |  2 +
 drivers/memory/tegra/tegra124.c                    |  6 +++
 drivers/memory/tegra/tegra210.c                    |  3 ++
 drivers/memory/tegra/tegra30.c                     |  2 +
 drivers/mfd/cros_ec.c                              |  6 ++-
 drivers/mtd/nand/fsl_ifc_nand.c                    | 17 ++++----
 drivers/net/can/usb/ems_usb.c                      |  1 +
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |  4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  2 +-
 drivers/net/usb/lan78xx.c                          |  2 +
 drivers/net/wireless/ath/regd.h                    |  5 +++
 drivers/net/wireless/ath/regd_common.h             | 13 ++++++
 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c   |  1 +
 drivers/net/wireless/iwlwifi/pcie/rx.c             |  2 +
 drivers/net/wireless/mwifiex/usb.c                 |  3 ++
 drivers/net/wireless/mwifiex/util.c                |  8 ++--
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |  2 -
 drivers/net/wireless/ti/wlcore/sdio.c              |  5 +++
 drivers/net/xen-netfront.c                         | 10 ++++-
 drivers/pci/pci-sysfs.c                            | 15 ++++---
 drivers/pinctrl/pinctrl-at91-pio4.c                |  4 +-
 drivers/regulator/pfuze100-regulator.c             |  1 +
 drivers/rtc/interface.c                            |  5 +++
 drivers/scsi/3w-9xxx.c                             |  5 +++
 drivers/scsi/3w-xxxx.c                             |  3 ++
 drivers/scsi/megaraid.c                            |  3 ++
 drivers/scsi/megaraid/megaraid_sas_fusion.c        |  3 ++
 drivers/scsi/scsi_dh.c                             |  5 ++-
 drivers/scsi/sg.c                                  |  1 +
 drivers/scsi/ufs/ufshcd.c                          |  2 +
 drivers/thermal/samsung/exynos_tmu.c               |  1 +
 drivers/tty/hvc/hvc_opal.c                         |  1 -
 drivers/tty/pty.c                                  |  3 ++
 drivers/usb/core/hub.c                             |  4 ++
 drivers/virtio/virtio_balloon.c                    |  2 +
 fs/btrfs/qgroup.c                                  | 19 +++++++++
 fs/btrfs/tree-log.c                                | 10 ++++-
 fs/ext4/balloc.c                                   |  3 ++
 fs/ext4/ialloc.c                                   |  3 ++
 fs/ext4/inline.c                                   | 19 +++++----
 fs/ext4/inode.c                                    | 16 ++++----
 fs/f2fs/segment.c                                  |  3 ++
 fs/f2fs/super.c                                    |  6 +++
 fs/nfsd/nfs4xdr.c                                  |  2 +
 fs/squashfs/block.c                                |  2 +
 fs/squashfs/cache.c                                |  3 ++
 fs/squashfs/file.c                                 |  8 +++-
 fs/squashfs/fragment.c                             | 17 ++++----
 fs/squashfs/squashfs_fs.h                          |  6 +++
 fs/squashfs/squashfs_fs_sb.h                       |  1 +
 fs/squashfs/super.c                                |  5 ++-
 include/drm/drm_dp_helper.h                        |  1 +
 include/linux/dma-iommu.h                          |  1 +
 include/linux/mmc/sdio_ids.h                       |  1 +
 include/linux/netfilter/ipset/ip_set_timeout.h     | 10 ++++-
 include/net/tcp.h                                  |  2 +-
 include/soc/tegra/mc.h                             |  2 +
 kernel/auditfilter.c                               |  2 +-
 kernel/auditsc.c                                   |  2 +
 kernel/bpf/verifier.c                              |  4 +-
 kernel/trace/trace_events_trigger.c                | 18 +++++---
 kernel/trace/trace_kprobe.c                        | 15 ++++++-
 mm/slub.c                                          |  2 +-
 mm/vmalloc.c                                       |  3 +-
 net/dsa/slave.c                                    |  6 +++
 net/ipv4/fib_frontend.c                            |  4 +-
 net/ipv4/inet_fragment.c                           | 10 ++---
 net/ipv4/ipconfig.c                                | 13 ++++++
 net/ipv4/tcp_dctcp.c                               |  4 +-
 net/ipv4/tcp_input.c                               | 48 +++++++++++-----------
 net/netlink/af_netlink.c                           |  7 ++++
 net/socket.c                                       |  2 +
 sound/pci/emu10k1/emupcm.c                         |  4 +-
 sound/pci/emu10k1/memory.c                         |  6 +--
 sound/pci/fm801.c                                  | 16 ++++++--
 sound/pci/hda/patch_ca0132.c                       |  8 +++-
 sound/soc/pxa/brownstone.c                         |  1 +
 sound/soc/pxa/mioa701_wm9713.c                     |  1 +
 sound/soc/pxa/mmp-pcm.c                            |  1 +
 sound/soc/pxa/mmp-sspa.c                           |  1 +
 sound/soc/pxa/palm27x.c                            |  1 +
 sound/soc/pxa/pxa-ssp.c                            |  1 +
 sound/soc/pxa/pxa2xx-ac97.c                        |  1 +
 sound/soc/pxa/pxa2xx-pcm.c                         |  1 +
 sound/soc/soc-pcm.c                                |  6 ++-
 sound/usb/pcm.c                                    |  2 +-
 tools/usb/usbip/src/usbip_detach.c                 |  9 ++--
 130 files changed, 532 insertions(+), 208 deletions(-)


