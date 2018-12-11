Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679A0C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19172208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544542969;
	bh=ZE4z6OOxXMbPTAerC+qcvNgkITYnj3XkEv8UcZGOAms=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=igGToXtl4WorludlCYslBm+hjUITsoSeOurng+3RpCxP6mr5BUdQl4xx3+ncHDAyX
	 P3iiSqfhrYMBjGI/9mpH/MY4h+PTYeDDm7Gmy9NQoPgJckzSoRB8JmQNH2UD4/PDEv
	 RnJtO/PU1seZ/PPaa5cHLDhMTxLeFMqz3CvMpM4Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19172208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeLKPms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:42:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727319AbeLKPmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:42:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 395A520672;
        Tue, 11 Dec 2018 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544542963;
        bh=ZE4z6OOxXMbPTAerC+qcvNgkITYnj3XkEv8UcZGOAms=;
        h=From:To:Cc:Subject:Date:From;
        b=TeddCszgGIVnZ9Av5WOBcVK+074OfxV5BqFw+DK/t5ODH6SElku/UVHzrSvWfv5qw
         AQOkI1LVrsoD08w20ikzZnxr8SgvA95XNFVCYYZnJhLV/Pmys2St1Ol75YwQXyDtL8
         IMm+vVeARo635Rcpun12hrUpftWd8/sn/X4UiNRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/54] 3.18.129-stable review
Date:   Tue, 11 Dec 2018 16:40:48 +0100
Message-Id: <20181211151546.010073210@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.129-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.129-rc1
X-KernelTest-Deadline: 2018-12-13T15:15+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.129 release.
There are 54 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Dec 13 15:15:33 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.129-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.129-rc1

Felix Fietkau <nbd@nbd.name>
    mac80211: fix reordering of buffered broadcast packets

Ben Greear <greearb@candelatech.com>
    mac80211: Clear beacon_int in ieee80211_do_stop

Macpaul Lin <macpaul@gmail.com>
    kgdboc: fix KASAN global-out-of-bounds bug in param_set_kgdboc_var()

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Staging: lustre: remove two build warnings

Bjørn Mork <bjorn@mork.no>
    USB: serial: option: add device ID for HP lt2523 (Novatel E371)

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Prevent U1/U2 link pm states if exit latency is too long

Bin Liu <b-liu@ti.com>
    dmaengine: cppi41: delete channel from pending list when stop channel

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Fix leak of krb5p encode pages

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix interval evaluation with openmin/max

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Call snd_pcm_unlink() conditionally at closing

Kai-Heng Feng <kai.heng.feng@canonical.com>
    ALSA: hda: Add support for AMD Stoney Ridge

Mathias Payer <mathias.payer@nebelwelt.net>
    USB: check usb_get_extra_descriptor for proper size

Alexander Theissen <alex.theissen@me.com>
    usb: appledisplay: Add 27" Apple Cinema Display

Harry Pan <harry.pan@intel.com>
    usb: quirk: add no-LPM quirk on SanDisk Ultra Flair device

Anton Blanchard <anton@samba.org>
    powerpc/vdso64: Use double word compare on pointers

Yangtao Li <tiny.windzz@gmail.com>
    net: amd: add missing of_node_put()

Vincent Chen <vincentc@andestech.com>
    net: faraday: ftmac100: remove netif_running(netdev) check before disabling interrupts

Aya Levin <ayal@mellanox.com>
    net/mlx4: Fix UBSAN warning of signed integer overflow

Jack Morgenstein <jackm@dev.mellanox.co.il>
    net/mlx4_core: Zero out lkey field in SW2HW_MPT fw command

Fabrizio Castro <fabrizio.castro@bp.renesas.com>
    can: rcar_can: Fix erroneous registration

Geert Uytterhoeven <geert+renesas@glider.be>
    iommu/ipmmu-vmsa: Fix crash on early domain free

Arnd Bergmann <arnd@arndb.de>
    usb: gadget: dummy: fix nonsensical comparisons

Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
    mm: cleancache: fix corruption on missed inode invalidation

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - quirk all PDP Xbox One gamepads

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

Andrea Parri <andrea.parri@amarulasolutions.com>
    uprobes: Fix handle_swbp() vs. unregister() + register() race once more

Sagi Grimberg <sagi@grimberg.me>
    iser: set sector for ambiguous mr status errors

Arnd Bergmann <arnd@arndb.de>
    kdb: use memmove instead of overlapping memcpy

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

Xiongfeng Wang <xiongfeng.wang@linaro.org>
    Kbuild: suppress packed-not-aligned warning for default setting only

Michael Niewöhner <linux@mniewoehner.de>
    usb: core: quirks: add RESET_RESUME quirk for Cherry G230 Stream series

Kai-Heng Feng <kai.heng.feng@canonical.com>
    USB: usb-storage: Add new IDs to ums-realtek

Richard Genoud <richard.genoud@gmail.com>
    dmaengine: at_hdmac: fix module unloading

Richard Genoud <richard.genoud@gmail.com>
    dmaengine: at_hdmac: fix memory leak in at_dma_xlate()

Pan Bian <bianpan2016@163.com>
    ext2: fix potential use after free

Takashi Iwai <tiwai@suse.de>
    ALSA: sparc: Fix invalid snd_free_pages() at error path

Takashi Iwai <tiwai@suse.de>
    ALSA: ac97: Fix incorrect bit shift at AC97-SPSA control write

Takashi Iwai <tiwai@suse.de>
    ALSA: wss: Fix invalid snd_free_pages() at error path

Bernd Eckstein <3erndeckstein@gmail.com>
    usbnet: ipheth: fix potential recvmsg bug and recvmsg bug 2

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: fix length check in SNMP processing

Pan Bian <bianpan2016@163.com>
    rapidio/rionet: do not free skb before reading its length

Sasha Levin <sashal@kernel.org>
    Revert "wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()"


-------------

Diffstat:

 Makefile                                     |  7 ++-
 arch/mips/include/asm/syscall.h              |  2 +-
 arch/powerpc/kernel/vdso64/datapage.S        |  2 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S    |  2 +-
 drivers/dma/at_hdmac.c                       | 10 +++-
 drivers/dma/cppi41.c                         | 16 +++++-
 drivers/gpu/drm/ast/ast_main.c               |  3 +-
 drivers/gpu/drm/gma500/mdfld_intel_display.c |  2 +-
 drivers/infiniband/ulp/iser/iser_verbs.c     |  7 ++-
 drivers/input/joystick/xpad.c                | 16 +++---
 drivers/iommu/ipmmu-vmsa.c                   |  3 ++
 drivers/net/can/rcar_can.c                   |  5 +-
 drivers/net/ethernet/amd/sunlance.c          |  4 +-
 drivers/net/ethernet/faraday/ftmac100.c      |  7 ++-
 drivers/net/ethernet/mellanox/mlx4/mlx4.h    |  4 +-
 drivers/net/ethernet/mellanox/mlx4/mr.c      |  1 +
 drivers/net/rionet.c                         |  2 +-
 drivers/net/usb/ipheth.c                     | 10 ++--
 drivers/net/wireless/ti/wlcore/cmd.c         |  6 ---
 drivers/s390/net/qeth_core_main.c            | 27 +++++-----
 drivers/scsi/bfa/bfa_fcbuild.c               |  8 +--
 drivers/scsi/bfa/bfa_fcs.c                   | 78 ++++++++++++++--------------
 drivers/scsi/bfa/bfa_fcs_lport.c             | 62 +++++++++-------------
 drivers/scsi/bfa/bfa_ioc.c                   |  2 +-
 drivers/scsi/bfa/bfa_svc.c                   |  4 +-
 drivers/scsi/bfa/bfad.c                      | 20 +++----
 drivers/scsi/bfa/bfad_attr.c                 |  2 +-
 drivers/scsi/bfa/bfad_bsg.c                  |  6 +--
 drivers/scsi/csiostor/csio_lnode.c           | 43 +++++++++------
 drivers/scsi/scsi_devinfo.c                  | 22 +++-----
 drivers/staging/lustre/lustre/lmv/lmv_obd.c  |  2 +-
 drivers/tty/serial/kgdboc.c                  | 47 ++++++++---------
 drivers/usb/core/hub.c                       |  3 +-
 drivers/usb/core/quirks.c                    |  7 +++
 drivers/usb/core/usb.c                       |  6 +--
 drivers/usb/gadget/udc/dummy_hcd.c           |  9 ++--
 drivers/usb/host/hwa-hc.c                    |  2 +-
 drivers/usb/host/xhci.c                      | 16 ++++++
 drivers/usb/misc/appledisplay.c              |  1 +
 drivers/usb/serial/option.c                  |  1 +
 drivers/usb/storage/unusual_realtek.h        | 10 ++++
 fs/ext2/xattr.c                              |  2 +-
 fs/kernfs/symlink.c                          |  2 +-
 include/linux/usb.h                          |  4 +-
 include/sound/pcm_params.h                   |  4 +-
 kernel/debug/kdb/kdb_support.c               |  4 +-
 kernel/events/uprobes.c                      | 12 ++++-
 lib/kobject.c                                |  2 +-
 mm/truncate.c                                |  8 ++-
 net/ipv4/ip_tunnel.c                         |  4 +-
 net/mac80211/iface.c                         |  2 +
 net/mac80211/tx.c                            |  4 +-
 net/sunrpc/auth_gss/auth_gss.c               |  4 ++
 scripts/Makefile.extrawarn                   |  3 ++
 scripts/unifdef.c                            |  4 +-
 sound/core/pcm_native.c                      |  3 +-
 sound/isa/wss/wss_lib.c                      |  2 -
 sound/pci/ac97/ac97_codec.c                  |  2 +-
 sound/pci/hda/hda_intel.c                    |  4 ++
 sound/pci/trident/trident.c                  |  2 +-
 sound/sparc/cs4231.c                         |  8 +--
 61 files changed, 314 insertions(+), 253 deletions(-)


