Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D74C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A4F2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545200;
	bh=EGx7gXm1NDp2aT75KxbVtrNG3fPiiKbo3nYHhDQKgI0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nQ+39iZwvdJ2FpkCeP8QIyAz/6chcgwBbYJnKlG91uBSikvRQReF+gi2E8p5RkH9d
	 90q5O4YGnYOHg/Elzco8qWAgCrR+bHXvvRiSHn0upRs2JeEcuWmzYIQJz80bF82yEO
	 wwYOgKtek1QC5SA65qYSaBR37KeBy96uG6tiC3Bw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A4F2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeLKPpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:45:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:33804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbeLKPpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:45:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 621182087F;
        Tue, 11 Dec 2018 15:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543121;
        bh=EGx7gXm1NDp2aT75KxbVtrNG3fPiiKbo3nYHhDQKgI0=;
        h=From:To:Cc:Subject:Date:From;
        b=L00R1WVaERmQimbrFYvBklVoexDy/j7xJiAr5/kZtBZvYAvdjPBFxjOaaJduogipz
         GlSlIL0Z02p+RcI9Dei6SLmm75WCsemOTdrh6Q71YUbV0EgHWBgftKYYKa7WwSJ16U
         XlNPXy7xmXT0Gt13muUpYlqoxV5myMZnxei6WTZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/91] 4.4.167-stable review
Date:   Tue, 11 Dec 2018 16:40:19 +0100
Message-Id: <20181211151606.026852373@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.167-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.167-rc1
X-KernelTest-Deadline: 2018-12-13T15:16+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.167 release.
There are 91 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Dec 13 15:15:44 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.167-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.167-rc1

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    mac80211: ignore NullFunc frames in the duplicate detection

Felix Fietkau <nbd@nbd.name>
    mac80211: fix reordering of buffered broadcast packets

Felix Fietkau <nbd@nbd.name>
    mac80211: ignore tx status for PS stations in ieee80211_tx_status_ext

Ben Greear <greearb@candelatech.com>
    mac80211: Clear beacon_int in ieee80211_do_stop

Vasyl Vavrychuk <vasyl.vavrychuk@globallogic.com>
    mac80211_hwsim: Timer should be initialized before device registered

Macpaul Lin <macpaul@gmail.com>
    kgdboc: fix KASAN global-out-of-bounds bug in param_set_kgdboc_var()

Peter Shih <pihsun@chromium.org>
    tty: serial: 8250_mtk: always resume the device in probe.

Paulo Alcantara <palcantara@suse.com>
    cifs: Fix separator when building path from dentry

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Staging: lustre: remove two build warnings

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Prevent U1/U2 link pm states if exit latency is too long

Bin Liu <b-liu@ti.com>
    dmaengine: cppi41: delete channel from pending list when stop channel

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Fix leak of krb5p encode pages

Halil Pasic <pasic@linux.ibm.com>
    virtio/s390: fix race in ccw_io_helper()

Halil Pasic <pasic@linux.ibm.com>
    virtio/s390: avoid race on vcdev->config

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix interval evaluation with openmin/max

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Call snd_pcm_unlink() conditionally at closing

Chanho Min <chanho.min@lge.com>
    ALSA: pcm: Fix starvation on down_write_nonblock()

Kai-Heng Feng <kai.heng.feng@canonical.com>
    ALSA: hda: Add support for AMD Stoney Ridge

Hui Peng <benquike@gmail.com>
    ALSA: usb-audio: Fix UAF decrement if card has no live interfaces in card.c

Mathias Payer <mathias.payer@nebelwelt.net>
    USB: check usb_get_extra_descriptor for proper size

Alexander Theissen <alex.theissen@me.com>
    usb: appledisplay: Add 27" Apple Cinema Display

Harry Pan <harry.pan@intel.com>
    usb: quirk: add no-LPM quirk on SanDisk Ultra Flair device

Yangtao Li <tiny.windzz@gmail.com>
    net: amd: add missing of_node_put()

Pan Bian <bianpan2016@163.com>
    iommu/vt-d: Use memunmap to free memremap

Vincent Chen <vincentc@andestech.com>
    net: faraday: ftmac100: remove netif_running(netdev) check before disabling interrupts

Aya Levin <ayal@mellanox.com>
    net/mlx4: Fix UBSAN warning of signed integer overflow

Tariq Toukan <tariqt@mellanox.com>
    net/mlx4_core: Fix uninitialized variable compilation warning

Jack Morgenstein <jackm@dev.mellanox.co.il>
    net/mlx4_core: Zero out lkey field in SW2HW_MPT fw command

Denis Bolotin <denis.bolotin@cavium.com>
    qed: Fix reading wrong value in loop condition

Denis Bolotin <denis.bolotin@cavium.com>
    qed: Fix PTT leak in qed_drain()

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    bnx2x: Assign unique DMAE channel number for FW DMAE transactions.

Sven Eckelmann <sven@narfation.org>
    batman-adv: Expand merged fragment buffer for full packet

Fabrizio Castro <fabrizio.castro@bp.renesas.com>
    can: rcar_can: Fix erroneous registration

Geert Uytterhoeven <geert+renesas@glider.be>
    iommu/ipmmu-vmsa: Fix crash on early domain free

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Fix NULL pointer dereference in prq_event_thread()

Arnd Bergmann <arnd@arndb.de>
    usb: gadget: dummy: fix nonsensical comparisons

Simon Guo <wei.guo.simon@gmail.com>
    mm: mlock: avoid increase mm->locked_vm on mlock() when already mlock2(,MLOCK_ONFAULT)

Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
    mm: cleancache: fix corruption on missed inode invalidation

Alexey Brodkin <abrodkin@synopsys.com>
    arc: [devboards] Add support of NFSv3 ACL

Kevin Hilman <khilman@baylibre.com>
    ARC: change defconfig defaults to ARCv2

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix use-after-free when dumping free space

Nikolay Borisov <nborisov@suse.com>
    btrfs: Always try all copies when reading extent buffers

Adam Wong <adam@adamwong.me>
    Input: elan_i2c - add support for ELAN0621 touchpad

Noah Westervelt <nwestervelt@outlook.com>
    Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15ARR

Patrick Gaskin <patrick@pgaskin.net>
    Input: elan_i2c - add ELAN0620 to the ACPI table

Christian Hoff <christian_hoff@gmx.net>
    Input: matrix_keypad - check for errors from of_get_named_gpio()

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - quirk all PDP Xbox One gamepads

Wei Yongjun <yongjun_wei@trendmicro.com.cn>
    leds: leds-gpio: Fix return value check in create_gpio_led()

Milo Kim <milo.kim@ti.com>
    leds: turn off the LED and wait for completion on unregistering LED class device

Markus Hofstaetter <markus.hofstaetter@ait.ac.at>
    leds: call led_pwm_set() in leds-pwm to enforce default LED_OFF

Laura Abbott <labbott@redhat.com>
    kgdboc: Fix warning with module build

Laura Abbott <labbott@redhat.com>
    kgdboc: Fix restrict error

Kees Cook <keescook@chromium.org>
    scsi: csiostor: Avoid content leaks and casts

Takashi Iwai <tiwai@suse.de>
    ALSA: trident: Suppress gcc string warning

Martin Wilck <mwilck@suse.com>
    scsi: scsi_devinfo: cleanly zero-pad devinfo strings

Sam Bobroff <sbobroff@linux.ibm.com>
    drm/ast: Fix incorrect free on ioregs

Dmitry V. Levin <ldv@altlinux.org>
    mips: fix mips_get_syscall_arg o32 check

Mathias Kresin <dev@kresin.me>
    MIPS: ralink: Fix mt7620 nd_sd pinmux

Andrea Parri <andrea.parri@amarulasolutions.com>
    uprobes: Fix handle_swbp() vs. unregister() + register() race once more

Sagi Grimberg <sagi@grimberg.me>
    iser: set sector for ambiguous mr status errors

Arnd Bergmann <arnd@arndb.de>
    kdb: use memmove instead of overlapping memcpy

Arnd Bergmann <arnd@arndb.de>
    staging: rts5208: fix gcc-8 logic error warning

Arnd Bergmann <arnd@arndb.de>
    scsi: bfa: convert to strlcpy/strlcat

Arnd Bergmann <arnd@arndb.de>
    drm: gma500: fix logic error

Sultan Alsawaf <sultanxda@gmail.com>
    ip_tunnel: Fix name string concatenate in __ip_tunnel_create()

Guenter Roeck <linux@roeck-us.net>
    kernfs: Replace strncpy with memcpy

Linus Torvalds <torvalds@linux-foundation.org>
    unifdef: use memcpy instead of strncpy

Guenter Roeck <linux@roeck-us.net>
    kobject: Replace strncpy with memcpy

Stephen Rothwell <sfr@canb.auug.org.au>
    disable stringop truncation warnings for now

Arnd Bergmann <arnd@arndb.de>
    exec: avoid gcc-8 warning for get_task_comm

Xiongfeng Wang <xiongfeng.wang@linaro.org>
    Kbuild: suppress packed-not-aligned warning for default setting only

YueHaibing <yuehaibing@huawei.com>
    misc: mic/scif: fix copy-paste error in scif_create_remote_lookup

Michael Niewöhner <linux@mniewoehner.de>
    usb: core: quirks: add RESET_RESUME quirk for Cherry G230 Stream series

Kai-Heng Feng <kai.heng.feng@canonical.com>
    USB: usb-storage: Add new IDs to ums-realtek

Josef Bacik <josef@toxicpanda.com>
    btrfs: release metadata before running delayed refs

Richard Genoud <richard.genoud@gmail.com>
    dmaengine: at_hdmac: fix module unloading

Richard Genoud <richard.genoud@gmail.com>
    dmaengine: at_hdmac: fix memory leak in at_dma_xlate()

Pan Bian <bianpan2016@163.com>
    ext2: fix potential use after free

Takashi Iwai <tiwai@suse.de>
    ALSA: sparc: Fix invalid snd_free_pages() at error path

Takashi Iwai <tiwai@suse.de>
    ALSA: control: Fix race between adding and removing a user element

Takashi Iwai <tiwai@suse.de>
    ALSA: ac97: Fix incorrect bit shift at AC97-SPSA control write

Takashi Iwai <tiwai@suse.de>
    ALSA: wss: Fix invalid snd_free_pages() at error path

Filipe Manana <fdmanana@suse.com>
    Btrfs: ensure path name is null terminated at btrfs_control_ioctl

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix coprocessor context offset definitions

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: enable coprocessors that are being flushed

Junaid Shahid <junaids@google.com>
    kvm: mmu: Fix race in emulated page table writes

Bernd Eckstein <3erndeckstein@gmail.com>
    usbnet: ipheth: fix potential recvmsg bug and recvmsg bug 2

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: fix length check in SNMP processing

Pan Bian <bianpan2016@163.com>
    rapidio/rionet: do not free skb before reading its length

Sasha Levin <sashal@kernel.org>
    Revert "wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()"

Matthias Schwarzott <zzam@gentoo.org>
    media: em28xx: Fix use-after-free when disconnecting


-------------

Diffstat:

 Makefile                                       |  7 ++-
 arch/arc/Kconfig                               |  2 +-
 arch/arc/Makefile                              |  2 +-
 arch/arc/configs/axs101_defconfig              |  2 +
 arch/arc/configs/axs103_defconfig              |  1 +
 arch/arc/configs/axs103_smp_defconfig          |  1 +
 arch/arc/configs/nsim_700_defconfig            |  1 +
 arch/arc/configs/nsimosci_defconfig            |  2 +
 arch/arc/configs/nsimosci_hs_defconfig         |  1 +
 arch/arc/configs/nsimosci_hs_smp_defconfig     |  1 +
 arch/arc/configs/tb10x_defconfig               |  1 +
 arch/arc/configs/vdk_hs38_defconfig            |  1 +
 arch/arc/configs/vdk_hs38_smp_defconfig        |  1 +
 arch/mips/include/asm/syscall.h                |  2 +-
 arch/mips/ralink/mt7620.c                      |  2 +-
 arch/x86/kvm/mmu.c                             | 27 +++------
 arch/xtensa/kernel/asm-offsets.c               | 16 +++---
 arch/xtensa/kernel/process.c                   |  5 +-
 drivers/dma/at_hdmac.c                         | 10 +++-
 drivers/dma/cppi41.c                           | 16 +++++-
 drivers/gpu/drm/ast/ast_main.c                 |  3 +-
 drivers/gpu/drm/gma500/mdfld_intel_display.c   |  2 +-
 drivers/infiniband/ulp/iser/iser_verbs.c       |  7 +--
 drivers/input/joystick/xpad.c                  | 16 ++----
 drivers/input/keyboard/matrix_keypad.c         | 23 +++++---
 drivers/input/mouse/elan_i2c_core.c            |  3 +
 drivers/iommu/intel-iommu.c                    |  2 +-
 drivers/iommu/intel-svm.c                      |  2 +-
 drivers/iommu/ipmmu-vmsa.c                     |  3 +
 drivers/leds/led-class.c                       |  5 +-
 drivers/leds/leds-gpio.c                       |  4 +-
 drivers/leds/leds-pwm.c                        |  1 +
 drivers/media/usb/em28xx/em28xx-dvb.c          |  3 +-
 drivers/misc/mic/scif/scif_rma.c               |  2 +-
 drivers/net/can/rcar_can.c                     |  5 +-
 drivers/net/ethernet/amd/sunlance.c            |  4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h    |  7 +++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c |  1 +
 drivers/net/ethernet/faraday/ftmac100.c        |  7 +--
 drivers/net/ethernet/mellanox/mlx4/alloc.c     |  2 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4.h      |  4 +-
 drivers/net/ethernet/mellanox/mlx4/mr.c        |  1 +
 drivers/net/ethernet/qlogic/qed/qed_int.c      |  2 +
 drivers/net/ethernet/qlogic/qed/qed_main.c     |  2 +-
 drivers/net/rionet.c                           |  2 +-
 drivers/net/usb/ipheth.c                       | 10 ++--
 drivers/net/wireless/mac80211_hwsim.c          |  8 +--
 drivers/net/wireless/ti/wlcore/cmd.c           |  6 --
 drivers/s390/net/qeth_core_main.c              | 27 ++++-----
 drivers/s390/virtio/virtio_ccw.c               | 17 +++++-
 drivers/scsi/bfa/bfa_fcbuild.c                 |  8 +--
 drivers/scsi/bfa/bfa_fcs.c                     | 78 ++++++++++++-------------
 drivers/scsi/bfa/bfa_fcs_lport.c               | 62 ++++++++------------
 drivers/scsi/bfa/bfa_ioc.c                     |  2 +-
 drivers/scsi/bfa/bfa_svc.c                     |  4 +-
 drivers/scsi/bfa/bfad.c                        | 20 +++----
 drivers/scsi/bfa/bfad_attr.c                   |  2 +-
 drivers/scsi/bfa/bfad_bsg.c                    |  6 +-
 drivers/scsi/csiostor/csio_lnode.c             | 43 ++++++++------
 drivers/scsi/scsi_devinfo.c                    | 22 +++----
 drivers/staging/lustre/lustre/lmv/lmv_obd.c    |  2 +-
 drivers/staging/rts5208/sd.c                   |  6 --
 drivers/tty/serial/8250/8250_mtk.c             | 16 +++---
 drivers/tty/serial/kgdboc.c                    | 47 ++++++++-------
 drivers/usb/core/hub.c                         |  2 +-
 drivers/usb/core/quirks.c                      |  7 +++
 drivers/usb/core/usb.c                         |  6 +-
 drivers/usb/gadget/udc/dummy_hcd.c             |  9 ++-
 drivers/usb/host/hwa-hc.c                      |  2 +-
 drivers/usb/host/xhci.c                        | 16 ++++++
 drivers/usb/misc/appledisplay.c                |  1 +
 drivers/usb/storage/unusual_realtek.h          | 10 ++++
 fs/btrfs/disk-io.c                             | 10 +---
 fs/btrfs/free-space-cache.c                    |  2 +
 fs/btrfs/super.c                               |  1 +
 fs/btrfs/transaction.c                         |  6 +-
 fs/cifs/dir.c                                  |  2 +-
 fs/exec.c                                      |  7 +--
 fs/ext2/xattr.c                                |  2 +-
 fs/kernfs/symlink.c                            |  2 +-
 include/linux/sched.h                          |  7 ++-
 include/linux/usb.h                            |  4 +-
 include/sound/pcm_params.h                     |  4 +-
 kernel/debug/kdb/kdb_support.c                 |  4 +-
 kernel/events/uprobes.c                        | 12 +++-
 lib/kobject.c                                  |  2 +-
 mm/mlock.c                                     |  3 +
 mm/truncate.c                                  |  8 ++-
 net/batman-adv/fragmentation.c                 |  2 +-
 net/ipv4/ip_tunnel.c                           |  4 +-
 net/mac80211/iface.c                           |  2 +
 net/mac80211/rx.c                              |  1 +
 net/mac80211/status.c                          |  2 +
 net/mac80211/tx.c                              |  4 +-
 net/sunrpc/auth_gss/auth_gss.c                 |  4 ++
 scripts/Makefile.extrawarn                     |  3 +
 scripts/unifdef.c                              |  4 +-
 sound/core/control.c                           | 80 +++++++++++++++-----------
 sound/core/pcm_native.c                        | 14 +++--
 sound/isa/wss/wss_lib.c                        |  2 -
 sound/pci/ac97/ac97_codec.c                    |  2 +-
 sound/pci/hda/hda_intel.c                      |  4 ++
 sound/pci/trident/trident.c                    |  2 +-
 sound/sparc/cs4231.c                           |  8 +--
 sound/usb/card.c                               |  5 +-
 105 files changed, 490 insertions(+), 382 deletions(-)


