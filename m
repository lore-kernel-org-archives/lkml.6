Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67437C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140EE2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107347;
	bh=BkkBLnQfElwVy3z9zPZRNHKT2/avtDQeb1h0wP7WnVQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lDjWVblRaU3yxmMa9GkoFI4FSadJ7sraGTJWihQZ+mV7mYT56/MOHq9vmEHzDGpIk
	 2ErFUsi+RSDqPWUQ5JSLv+0KSl5x5ZduRxg4bcUmdOi9rJbOPP6UMx1zSjhHPFgokO
	 Ki0MtS7kFBtxsEp2HQdGLN8aD8yv2/NALFs31Aeo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140EE2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbeLFOmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:42:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729802AbeLFOmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:42:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4901120892;
        Thu,  6 Dec 2018 14:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107340;
        bh=BkkBLnQfElwVy3z9zPZRNHKT2/avtDQeb1h0wP7WnVQ=;
        h=From:To:Cc:Subject:Date:From;
        b=PqxdzT60uhIABNzFX2A+L8I3MMQQoIleHTi3oK+o7NTz8tZenxVbPYUbn8AAyeDXN
         Kx6sIBOT7GF+BXdxbXVA1qtsBXMDPq+y+bqs+QVqRvAMXj07hXfxAn48DHk2XmD83L
         5SDSbAheXlD35P/itEw4uuHXUzzfdKLAVr5Rd0rc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/55] 4.14.87-stable review
Date:   Thu,  6 Dec 2018 15:38:34 +0100
Message-Id: <20181206143001.749982936@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.87-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.87-rc1
X-KernelTest-Deadline: 2018-12-08T14:30+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.87 release.
There are 55 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Dec  8 14:29:38 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.87-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.87-rc1

Guoqing Jiang <gqjiang@suse.com>
    tipc: use destination length for copy string

Arnd Bergmann <arnd@arndb.de>
    net: qed: use correct strncpy() size

Roman Gushchin <guro@fb.com>
    mm: hide incomplete nr_indirectly_reclaimable in /proc/zoneinfo

Daniel Lezcano <daniel.lezcano@linaro.org>
    thermal/drivers/hisi: Remove costly sensor inspection

Daniel Lezcano <daniel.lezcano@linaro.org>
    thermal/drivers/hisi: Fix configuration register setting

Daniel Lezcano <daniel.lezcano@linaro.org>
    thermal/drivers/hisi: Encapsulate register writes into helpers

Daniel Lezcano <daniel.lezcano@linaro.org>
    thermal/drivers/hisi: Remove pointless lock

Daniel Lezcano <daniel.lezcano@linaro.org>
    thermal/drivers/hisi: Remove the multiple sensors support

Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
    mm: cleancache: fix corruption on missed inode invalidation

Masahiro Yamada <yamada.masahiro@socionext.com>
    reset: remove remaining WARN_ON() in <linux/reset.h>

Masahiro Yamada <yamada.masahiro@socionext.com>
    reset: make device_reset_optional() really optional

Jan Kara <jack@suse.cz>
    udf: Allow mounting volumes with incorrect identification strings

Alexey Brodkin <abrodkin@synopsys.com>
    arc: [devboards] Add support of NFSv3 ACL

Kevin Hilman <khilman@baylibre.com>
    ARC: change defconfig defaults to ARCv2

Nikolay Borisov <nborisov@suse.com>
    btrfs: Always try all copies when reading extent buffers

Qu Wenruo <wqu@suse.com>
    btrfs: tree-checker: Don't check max block group size as current max chunk size limit is unreliable

Adam Wong <adam@adamwong.me>
    Input: elan_i2c - add support for ELAN0621 touchpad

Noah Westervelt <nwestervelt@outlook.com>
    Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15ARR

Patrick Gaskin <patrick@pgaskin.net>
    Input: elan_i2c - add ELAN0620 to the ACPI table

Brian Norris <briannorris@chromium.org>
    Input: cros_ec_keyb - fix button/switch capability reports

Christian Hoff <christian_hoff@gmx.net>
    Input: matrix_keypad - check for errors from of_get_named_gpio()

Lyude Paul <lyude@redhat.com>
    Input: synaptics - add PNP ID for ThinkPad P50 to SMBus

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - quirk all PDP Xbox One gamepads

Johan Hovold <johan@kernel.org>
    drm/msm: fix OF child-node lookup

Wei Wang <wawei@amazon.de>
    svm: Add mutex_lock to protect apic_access_page_done on AMD systems

Laura Abbott <labbott@redhat.com>
    kgdboc: Fix warning with module build

Laura Abbott <labbott@redhat.com>
    kgdboc: Fix restrict error

Takashi Iwai <tiwai@suse.de>
    ALSA: trident: Suppress gcc string warning

Andrea Arcangeli <aarcange@redhat.com>
    userfaultfd: shmem/hugetlbfs: only allow to register VM_MAYWRITE vmas

Martin Wilck <mwilck@suse.com>
    scsi: scsi_devinfo: cleanly zero-pad devinfo strings

Andrea Arcangeli <aarcange@redhat.com>
    userfaultfd: shmem: UFFDIO_COPY: set the page dirty if VM_WRITE is not set

Andrea Arcangeli <aarcange@redhat.com>
    userfaultfd: shmem: add i_size checks

Andrea Arcangeli <aarcange@redhat.com>
    userfaultfd: shmem: allocate anonymous memory for MAP_PRIVATE shmem

Andrea Arcangeli <aarcange@redhat.com>
    userfaultfd: use ENOENT instead of EFAULT if the atomic copy user fails

Lyude Paul <lyude@redhat.com>
    drm/meson: Fix OOB memory accesses in meson_viu_set_osd_lut()

Lyude Paul <lyude@redhat.com>
    drm/meson: Enable fast_io in meson_dw_hdmi_regmap_config

Sergio Correia <sergio@correia.cc>
    drm: set is_master to 0 upon drm_new_set_master() failure

Sam Bobroff <sbobroff@linux.ibm.com>
    drm/ast: Fix incorrect free on ioregs

Michael Guralnik <michaelgur@mellanox.com>
    IB/mlx5: Avoid load failure due to unknown link width

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

Takashi Iwai <tiwai@suse.de>
    ALSA: intel_hdmi: Use strlcpy() instead of strncpy()

Guenter Roeck <linux@roeck-us.net>
    kobject: Replace strncpy with memcpy

Linus Torvalds <torvalds@linux-foundation.org>
    test_hexdump: use memcpy instead of strncpy

Stephen Rothwell <sfr@canb.auug.org.au>
    disable stringop truncation warnings for now

Xiongfeng Wang <xiongfeng.wang@linaro.org>
    Kbuild: suppress packed-not-aligned warning for default setting only


-------------

Diffstat:

 Makefile                                     |   7 +-
 arch/arc/Kconfig                             |   2 +-
 arch/arc/Makefile                            |   2 +-
 arch/arc/configs/axs101_defconfig            |   2 +
 arch/arc/configs/axs103_defconfig            |   1 +
 arch/arc/configs/axs103_smp_defconfig        |   1 +
 arch/arc/configs/hsdk_defconfig              |   1 +
 arch/arc/configs/nps_defconfig               |   2 +
 arch/arc/configs/nsim_700_defconfig          |   1 +
 arch/arc/configs/nsimosci_defconfig          |   2 +
 arch/arc/configs/nsimosci_hs_defconfig       |   1 +
 arch/arc/configs/nsimosci_hs_smp_defconfig   |   1 +
 arch/arc/configs/tb10x_defconfig             |   1 +
 arch/arc/configs/vdk_hs38_defconfig          |   1 +
 arch/arc/configs/vdk_hs38_smp_defconfig      |   1 +
 arch/mips/include/asm/syscall.h              |   2 +-
 arch/mips/ralink/mt7620.c                    |   2 +-
 arch/x86/kvm/svm.c                           |  19 +-
 drivers/gpu/drm/ast/ast_main.c               |   3 +-
 drivers/gpu/drm/drm_auth.c                   |   2 +
 drivers/gpu/drm/gma500/mdfld_intel_display.c |   2 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c        |   1 +
 drivers/gpu/drm/meson/meson_viu.c            |  12 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c   |   5 +-
 drivers/infiniband/hw/mlx5/main.c            |  29 +--
 drivers/infiniband/ulp/iser/iser_verbs.c     |   7 +-
 drivers/input/joystick/xpad.c                |  16 +-
 drivers/input/keyboard/cros_ec_keyb.c        |   3 +-
 drivers/input/keyboard/matrix_keypad.c       |  23 +-
 drivers/input/mouse/elan_i2c_core.c          |   3 +
 drivers/input/mouse/synaptics.c              |   1 +
 drivers/net/ethernet/qlogic/qed/qed_debug.c  |   6 +-
 drivers/reset/core.c                         |   9 +-
 drivers/scsi/bfa/bfa_fcbuild.c               |   8 +-
 drivers/scsi/bfa/bfa_fcs.c                   |  78 +++----
 drivers/scsi/bfa/bfa_fcs_lport.c             |  62 ++----
 drivers/scsi/bfa/bfa_ioc.c                   |   2 +-
 drivers/scsi/bfa/bfa_svc.c                   |   4 +-
 drivers/scsi/bfa/bfad.c                      |  20 +-
 drivers/scsi/bfa/bfad_attr.c                 |   2 +-
 drivers/scsi/bfa/bfad_bsg.c                  |   6 +-
 drivers/scsi/scsi_devinfo.c                  |  22 +-
 drivers/staging/rts5208/sd.c                 |   6 -
 drivers/thermal/hisi_thermal.c               | 318 ++++++++++++++-------------
 drivers/tty/serial/kgdboc.c                  |  43 ++--
 fs/btrfs/disk-io.c                           |  10 +-
 fs/btrfs/tree-checker.c                      |   8 +-
 fs/kernfs/symlink.c                          |   2 +-
 fs/udf/super.c                               |  16 +-
 fs/udf/unicode.c                             |  14 +-
 fs/userfaultfd.c                             |  15 ++
 include/linux/reset.h                        |  34 ++-
 kernel/debug/kdb/kdb_support.c               |   4 +-
 kernel/events/uprobes.c                      |  12 +-
 lib/kobject.c                                |   2 +-
 lib/test_hexdump.c                           |   2 +-
 mm/hugetlb.c                                 |   2 +-
 mm/shmem.c                                   |  31 ++-
 mm/truncate.c                                |   8 +-
 mm/userfaultfd.c                             |  62 ++++--
 mm/vmstat.c                                  |   4 +
 net/ipv4/ip_tunnel.c                         |   4 +-
 net/tipc/subscr.c                            |   2 +-
 scripts/Makefile.extrawarn                   |   3 +
 scripts/unifdef.c                            |   4 +-
 sound/pci/trident/trident.c                  |   2 +-
 sound/x86/intel_hdmi_audio.c                 |   2 +-
 67 files changed, 538 insertions(+), 447 deletions(-)


