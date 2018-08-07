Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF490C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBB42151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBB42151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390722AbeHGVNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:13:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34622 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388829AbeHGVNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:13:21 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D3EC974;
        Tue,  7 Aug 2018 18:57:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/85] 3.18.118-stable review
Date:   Tue,  7 Aug 2018 20:51:02 +0200
Message-Id: <20180807172357.357252052@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.118-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.118-rc1
X-KernelTest-Deadline: 2018-08-09T17:24+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.118 release.
There are 85 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Aug  9 17:23:43 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.118-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.118-rc1

Shankara Pailoor <shankarapailoor@gmail.com>
    jfs: Fix inconsistency between memory allocation and ea_buf->max_size

Masami Hiramatsu <mhiramat@kernel.org>
    ring_buffer: tracing: Inherit the tracing setting to next ring buffer

Anil Gurumurthy <anil.gurumurthy@cavium.com>
    scsi: qla2xxx: Return error when TMF returns

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix ISP recovery on unload

Tony Battersby <tonyb@cybernetics.com>
    scsi: sg: fix minor memory leak in error path

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: padlock-aes - Fix Nano workaround data corruption

Jiang Biao <jiang.biao2@zte.com.cn>
    virtio_balloon: fix another race between migration and ballooning

Anton Vasilyev <vasilyev@ispras.ru>
    can: ems_usb: Fix memory leak on ems_usb_disconnect()

Linus Torvalds <torvalds@linux-foundation.org>
    squashfs: more metadata hardenings

Linus Torvalds <torvalds@linux-foundation.org>
    squashfs: more metadata hardening

Florian Fainelli <f.fainelli@gmail.com>
    net: dsa: Do not suspend/resume closed slave_dev

Eric Dumazet <edumazet@google.com>
    inet: frag: enforce memory limits earlier

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    ipv4: remove BUG_ON() from fib_compute_spec_dst

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

Xiao Liang <xiliang@redhat.com>
    xen-netfront: wait xenbus state change when load module manually

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    NET: stmmac: align DMA stuff to largest cache line length

Linus Torvalds <torvalds@linux-foundation.org>
    squashfs: be more careful about metadata corruption

Theodore Ts'o <tytso@mit.edu>
    random: mix rdrand with entropy sent in from userspace

Mauro Carvalho Chehab <mchehab@s-opensource.com>
    media: si470x: fix __be16 annotations

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

Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
    rsi: Fix 'invalid vdd' warning in mmc

Chris Novakovic <chris@chrisn.me.uk>
    ipconfig: Correctly initialise ic_nameservers

Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
    drm/gma500: fix psb_intel_lvds_mode_valid()'s return type

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: hda/ca0132: fix build failure when a local macro is defined

Mauro Carvalho Chehab <mchehab@s-opensource.com>
    media: siano: get rid of __le32/__le16 cast warnings

Jakub Kicinski <jakub.kicinski@netronome.com>
    bpf: fix references to free_bpf_prog_info() in comments

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

Brad Love <brad@nextdimension.cc>
    media: saa7164: Fix driver name in debug output

Damien Le Moal <damien.lemoal@wdc.com>
    libata: Fix command retry decision

DaeRyong Jeong <threeearcat@gmail.com>
    tty: Fix data race in tty_insert_flip_string_fixed_flag

Dmitry Torokhov <dtor@chromium.org>
    HID: i2c-hid: check if device is there before really probing

Jonathan Neuschäfer <j.neuschaefer@gmx.net>
    powerpc/embedded6xx/hlwd-pic: Prevent interrupts from being handled by Starlet

Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
    drm/radeon: fix mode_valid's return type

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

Mika Westerberg <mika.westerberg@linux.intel.com>
    PCI: pciehp: Request control of native hotplug only if supported

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

Eyal Reizer <eyalreizer@gmail.com>
    wlcore: sdio: check for valid platform device data before suspend

Ganapathi Bhat <gbhat@marvell.com>
    mwifiex: handle race during mwifiex_usb_disconnect

Kai Chieh Chuang <kaichieh.chuang@mediatek.com>
    ASoC: dpcm: fix BE dai not hw_free and shutdown

Kan Liang <kan.liang@intel.com>
    perf/x86/intel/uncore: Correct fixed counter index check for NHM

Kan Liang <kan.liang@intel.com>
    perf/x86/intel/uncore: Correct fixed counter index check in generic code

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    usbip: usbip_detach: Fix memory, udev context and udev leak

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mad: Convert BUG_ONs to error flows

Stewart Smith <stewart@linux.ibm.com>
    hvc_opal: don't set tb_ticks_per_usec in udbg_init_opal_common()

Cong Wang <xiyou.wangcong@gmail.com>
    infiniband: fix a possible use-after-free bug

Alexandre Belloni <alexandre.belloni@bootlin.com>
    rtc: ensure rtc_set_alarm fails when alarms are not supported

Mathieu Malaterre <malat@debian.org>
    mm/slub.c: add __printf verification to slab_err()

Chintan Pandya <cpandya@codeaurora.org>
    mm: vmalloc: avoid racy handling of debugobjects in vunmap

Zhouyang Jia <jiazhouyang09@gmail.com>
    ALSA: fm801: add error handling for snd_ctl_add

Zhouyang Jia <jiazhouyang09@gmail.com>
    ALSA: emu10k1: add error handling for snd_ctl_add

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Quiet gcc warning about maybe unused link variable

Artem Savkov <asavkov@redhat.com>
    tracing/kprobes: Fix trace_probe flags on enable_trace_kprobe() failure

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix possible double free in event_enable_trigger_func()

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix double free of event_trigger_data


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/microblaze/boot/Makefile                      | 10 +++--
 arch/powerpc/kernel/head_8xx.S                     |  2 +-
 arch/powerpc/kernel/pci_32.c                       |  1 +
 arch/powerpc/platforms/chrp/time.c                 |  6 ++-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |  5 +++
 arch/powerpc/platforms/powermac/bootx_init.c       |  4 +-
 arch/powerpc/platforms/powermac/setup.c            |  1 +
 arch/s390/include/asm/cpu_mf.h                     |  6 ++-
 arch/x86/kernel/cpu/perf_event_intel_uncore.c      |  2 +-
 .../x86/kernel/cpu/perf_event_intel_uncore_nhmex.c |  2 +-
 crypto/authenc.c                                   |  1 +
 crypto/authencesn.c                                |  1 +
 drivers/acpi/pci_root.c                            |  4 +-
 drivers/ata/libata-eh.c                            | 12 ++++--
 drivers/char/random.c                              | 10 ++++-
 drivers/crypto/padlock-aes.c                       |  8 +++-
 drivers/gpu/drm/gma500/psb_intel_drv.h             |  2 +-
 drivers/gpu/drm/gma500/psb_intel_lvds.c            |  2 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         | 10 ++---
 drivers/hid/i2c-hid/i2c-hid.c                      |  8 ++++
 drivers/infiniband/core/mad.c                      | 11 +++--
 drivers/infiniband/core/ucma.c                     |  6 ++-
 drivers/md/md.c                                    |  3 ++
 drivers/media/common/siano/smsendian.c             | 14 +++----
 drivers/media/i2c/smiapp/smiapp-core.c             | 11 +++--
 drivers/media/pci/saa7164/saa7164-fw.c             |  3 +-
 drivers/media/platform/omap3isp/isp.c              |  7 ++--
 drivers/media/radio/si470x/radio-si470x-i2c.c      |  6 +--
 drivers/net/can/usb/ems_usb.c                      |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  2 +-
 drivers/net/wireless/ath/regd.h                    |  5 +++
 drivers/net/wireless/ath/regd_common.h             | 13 ++++++
 drivers/net/wireless/mwifiex/usb.c                 |  3 ++
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |  2 -
 drivers/net/wireless/ti/wlcore/sdio.c              |  5 +++
 drivers/net/xen-netfront.c                         |  6 +++
 drivers/pci/pci-sysfs.c                            | 15 ++++---
 drivers/regulator/pfuze100-regulator.c             |  1 +
 drivers/rtc/interface.c                            |  5 +++
 drivers/scsi/3w-9xxx.c                             |  5 +++
 drivers/scsi/3w-xxxx.c                             |  3 ++
 drivers/scsi/megaraid.c                            |  3 ++
 drivers/scsi/qla2xxx/qla_init.c                    |  7 ++--
 drivers/scsi/qla2xxx/qla_os.c                      |  5 ++-
 drivers/scsi/sg.c                                  |  1 +
 drivers/scsi/ufs/ufshcd.c                          |  2 +
 drivers/tty/hvc/hvc_opal.c                         |  1 -
 drivers/tty/pty.c                                  |  3 ++
 drivers/usb/core/hub.c                             |  4 ++
 drivers/virtio/virtio_balloon.c                    |  2 +
 fs/jfs/xattr.c                                     | 10 +++--
 fs/squashfs/block.c                                |  2 +
 fs/squashfs/cache.c                                |  3 ++
 fs/squashfs/file.c                                 |  8 +++-
 fs/squashfs/fragment.c                             | 17 ++++----
 fs/squashfs/squashfs_fs.h                          |  6 +++
 fs/squashfs/squashfs_fs_sb.h                       |  1 +
 fs/squashfs/super.c                                |  5 ++-
 include/linux/ring_buffer.h                        |  1 +
 include/net/tcp.h                                  |  2 +-
 kernel/bpf/verifier.c                              |  4 +-
 kernel/trace/ring_buffer.c                         | 16 ++++++++
 kernel/trace/trace.c                               |  6 +++
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
 sound/pci/emu10k1/emupcm.c                         |  4 +-
 sound/pci/emu10k1/memory.c                         |  6 +--
 sound/pci/fm801.c                                  | 16 ++++++--
 sound/pci/hda/patch_ca0132.c                       |  8 +++-
 sound/soc/soc-pcm.c                                |  6 ++-
 sound/usb/pcm.c                                    |  2 +-
 tools/usb/usbip/src/usbip_detach.c                 |  9 ++--
 81 files changed, 366 insertions(+), 145 deletions(-)


