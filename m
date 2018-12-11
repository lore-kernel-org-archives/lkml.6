Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25312C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92FD2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543391;
	bh=M5ZgaKTvXyP1QsIDc37klNeGOBrNGI9zYFk7PLGjhtk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BysH4vpv6qZt4fQrCtV0qiNP5ZPmWm8H45JF7sz2f2Q/XUncvblF93oBGeMSBaMCC
	 y7SHFxNj3G+1FOcrcqb78mXS7nV+aUjLi7AX4vy5QIRBmsoDXhuDxynYsApsBnvS35
	 sW9v4MXoPUT3T7v9MXL1LoEe8qofcK12fWZx0QME=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92FD2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbeLKPtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:49:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbeLKPtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:49:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57E502145D;
        Tue, 11 Dec 2018 15:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543385;
        bh=M5ZgaKTvXyP1QsIDc37klNeGOBrNGI9zYFk7PLGjhtk=;
        h=From:To:Cc:Subject:Date:From;
        b=0tEfxFdTI6O8RtlebbZV5ei7zsgOeK1bxzKkCj83WeJoLt8bIYkhzqm6dyX5oq2Bi
         m/nuWbtwa3XWth/MInw0AuYswJtWXmusvNvG+RIY+v5r3knxKmIsXUfq/GrHU18S7A
         E6Rc7VM6eT/JbQGpzEfYhpjfHG88G5BE23jMZHiI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/51] 4.9.145-stable review
Date:   Tue, 11 Dec 2018 16:41:08 +0100
Message-Id: <20181211151612.328911565@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.145-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.145-rc1
X-KernelTest-Deadline: 2018-12-13T15:16+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.145 release.
There are 51 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Dec 13 15:15:52 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.145-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.145-rc1

Stefan Agner <stefan@agner.ch>
    kbuild: allow to use GCC toolchain not in Clang search path

Nick Desaulniers <ndesaulniers@google.com>
    kbuild: fix linker feature test macros when cross compiling with Clang

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

Chanho Park <parkch98@gmail.com>
    tty: do not set TTY_IO_ERROR flag if console port

Peter Shih <pihsun@chromium.org>
    tty: serial: 8250_mtk: always resume the device in probe.

Young Xiao <YangX92@hotmail.com>
    staging: rtl8712: Fix possible buffer overrun

Paulo Alcantara <palcantara@suse.com>
    cifs: Fix separator when building path from dentry

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Staging: lustre: remove two build warnings

Stefan Hajnoczi <stefanha@redhat.com>
    vhost/vsock: fix use-after-free in network stack callers

Gao feng <omarapazanadi@gmail.com>
    vsock: lookup and setup guest_cid inside vhost_vsock_lock

Kees Cook <keescook@chromium.org>
    swiotlb: clean up reporting

Jens Axboe <axboe@kernel.dk>
    sr: pass down correctly sized SCSI sense buffer

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
    ALSA: hda/realtek - Fix speaker output regression on Thinkpad T570

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

Alexey Brodkin <alexey.brodkin@synopsys.com>
    ARC: [zebu] Remove CONFIG_INITRAMFS_SOURCE from defconfigs

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    mm: don't warn about allocations which stall for too long

Yangtao Li <tiny.windzz@gmail.com>
    net: amd: add missing of_node_put()

Hangbin Liu <liuhangbin@gmail.com>
    team: no need to do team_notify_peers or team_mcast_rejoin when disabling port

Pan Bian <bianpan2016@163.com>
    iommu/vt-d: Use memunmap to free memremap

Vincent Chen <vincentc@andestech.com>
    net: faraday: ftmac100: remove netif_running(netdev) check before disabling interrupts

Olof Johansson <olof@lixom.net>
    mtd: rawnand: qcom: Namespace prefix some commands

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

Benson Leung <bleung@chromium.org>
    HID: input: Ignore battery reported by Symbol DS4308

Fabrizio Castro <fabrizio.castro@bp.renesas.com>
    can: rcar_can: Fix erroneous registration

Geert Uytterhoeven <geert+renesas@glider.be>
    iommu/ipmmu-vmsa: Fix crash on early domain free

Rafał Miłecki <rafal@milecki.pl>
    brcmutil: really fix decoding channel info for 160 MHz bandwidth

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Fix NULL pointer dereference in prq_event_thread()

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: omap3isp: Unregister media device as first


-------------

Diffstat:

 Makefile                                           | 12 +++---
 arch/arc/configs/zebu_hs_defconfig                 |  1 -
 arch/arc/configs/zebu_hs_smp_defconfig             |  1 -
 drivers/dma/cppi41.c                               | 16 ++++++-
 drivers/hid/hid-ids.h                              |  1 +
 drivers/hid/hid-input.c                            |  3 ++
 drivers/iommu/intel-iommu.c                        |  2 +-
 drivers/iommu/intel-svm.c                          |  2 +-
 drivers/iommu/ipmmu-vmsa.c                         |  3 ++
 drivers/media/platform/omap3isp/isp.c              |  3 +-
 drivers/mtd/nand/qcom_nandc.c                      | 32 +++++++-------
 drivers/net/can/rcar/rcar_can.c                    |  5 ++-
 drivers/net/ethernet/amd/sunlance.c                |  4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |  7 +++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c     |  1 +
 drivers/net/ethernet/faraday/ftmac100.c            |  7 ++-
 drivers/net/ethernet/mellanox/mlx4/alloc.c         |  2 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4.h          |  4 +-
 drivers/net/ethernet/mellanox/mlx4/mr.c            |  1 +
 drivers/net/ethernet/qlogic/qed/qed_int.c          |  2 +
 drivers/net/ethernet/qlogic/qed/qed_main.c         |  2 +-
 drivers/net/team/team.c                            |  2 -
 .../net/wireless/broadcom/brcm80211/brcmutil/d11.c |  3 ++
 drivers/net/wireless/mac80211_hwsim.c              |  8 ++--
 drivers/s390/virtio/virtio_ccw.c                   | 17 ++++++--
 drivers/scsi/sr_ioctl.c                            | 21 +++------
 drivers/staging/lustre/lnet/lnet/config.c          |  3 +-
 drivers/staging/lustre/lustre/lmv/lmv_obd.c        |  2 +-
 drivers/staging/rtl8712/mlme_linux.c               |  2 +-
 drivers/staging/rtl8712/rtl871x_mlme.c             |  2 +-
 drivers/tty/serial/8250/8250_mtk.c                 | 16 +++----
 drivers/tty/serial/kgdboc.c                        |  4 +-
 drivers/tty/tty_port.c                             |  3 +-
 drivers/usb/core/hub.c                             |  2 +-
 drivers/usb/core/quirks.c                          |  4 ++
 drivers/usb/core/usb.c                             |  6 +--
 drivers/usb/host/hwa-hc.c                          |  2 +-
 drivers/usb/host/xhci.c                            | 16 +++++++
 drivers/usb/misc/appledisplay.c                    |  1 +
 drivers/vhost/vsock.c                              | 50 +++++++++++++++-------
 fs/cifs/dir.c                                      |  2 +-
 include/linux/usb.h                                |  4 +-
 include/sound/pcm_params.h                         |  4 +-
 lib/swiotlb.c                                      | 20 ++++-----
 mm/page_alloc.c                                    | 10 -----
 net/batman-adv/fragmentation.c                     |  2 +-
 net/mac80211/iface.c                               |  2 +
 net/mac80211/rx.c                                  |  1 +
 net/mac80211/status.c                              |  2 +
 net/mac80211/tx.c                                  |  4 +-
 net/sunrpc/auth_gss/auth_gss.c                     |  4 ++
 scripts/Kbuild.include                             |  5 ++-
 sound/core/pcm_native.c                            | 14 +++---
 sound/pci/hda/hda_intel.c                          |  4 ++
 sound/pci/hda/patch_realtek.c                      |  9 ++++
 sound/usb/card.c                                   |  5 ++-
 56 files changed, 232 insertions(+), 135 deletions(-)


