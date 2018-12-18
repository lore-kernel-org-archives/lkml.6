Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51378C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A02F218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151202;
	bh=yq5dM4PKSJUx5K1yOpom0dVluzbChK0ID6t7G7Io4IU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2t+L02NjYE+/KuSJhYjacCXiAf2VqM+8oxJQ4TQRAGyHn9NZS4MFfCVJdlPjB/NMd
	 VE+fD5HNM5Bap9aCUVd7hYNPR9JQNYgiPZMPHndxqFIAxF5cNnaM+tM2muIT9NfStM
	 z0mPe/084V2AFT43waKyt0gMs5faRFZ5KTw/XOMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeLRQkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:40:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:36902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbeLRQkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:40:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80CDE21873;
        Tue, 18 Dec 2018 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151199;
        bh=yq5dM4PKSJUx5K1yOpom0dVluzbChK0ID6t7G7Io4IU=;
        h=From:To:Cc:Subject:Date:From;
        b=eXqOP043I0tjS9HCkQWM+eK4tBh5m6F8Oo9vqz3BtooIbc/P6vYzFhD/zCCg0OGNx
         OK9zrB8L1TCk2ou46RSI75uihhAJbpYprxgsRzRqo6VL8t9rhM6hU5m+oHoq6m5FX8
         YudG319ik0BH5r9IZkNoVd2f/7XvPetnkKaV0mf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 00/44] 4.19.11-stable review
Date:   Tue, 18 Dec 2018 17:39:12 +0100
Message-Id: <20181218163927.119623235@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.11-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.11-rc1
X-KernelTest-Deadline: 2018-12-20T16:39+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.11 release.
There are 44 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Dec 20 16:39:02 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.11-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.11-rc1

Masahiro Yamada <yamada.masahiro@socionext.com>
    x86/build: Fix compiler support check for CONFIG_RETPOLINE

Damien Le Moal <damien.lemoal@wdc.com>
    dm zoned: Fix target BIO completion handling

Junwei Zhang <Jerry.Zhang@amd.com>
    drm/amdgpu: update SMC firmware image for polaris10 variants

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: update smu firmware images for VI variants (v2)

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: add some additional vega10 pci ids

Alex Deucher <alexander.deucher@amd.com>
    drm/amdkfd: add new vega10 pci ids

Kenneth Feng <kenneth.feng@amd.com>
    drm/amdgpu/powerplay: Apply avfs cks-off voltages on VI

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915/execlists: Apply a full mb before execution for Braswell

Tina Zhang <tina.zhang@intel.com>
    drm/i915/gvt: Fix tiled memory decoding bug on BDW

Brian Norris <briannorris@chromium.org>
    Revert "drm/rockchip: Allow driver to be shutdown on reboot/kexec"

Ben Skeggs <bskeggs@redhat.com>
    drm/nouveau/kms/nv50-: also flush fb writes when rewinding push buffer

Lyude Paul <lyude@redhat.com>
    drm/nouveau/kms: Fix memory leak in nv50_mstm_del()

Benjamin Herrenschmidt <benh@kernel.crashing.org>
    powerpc: Look for "stdout-path" when setting up legacy consoles

Radu Rendec <radu.rendec@gmail.com>
    powerpc/msi: Fix NULL pointer access in teardown code

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: vb2: don't call __vb2_queue_cancel if vb2_start_streaming failed

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix memory leak of instance function hash filters

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix memory leak in set_trigger_filter()

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix memory leak in create_filter()

Mike Snitzer <snitzer@redhat.com>
    dm: call blk_queue_split() to impose device limits on bios

Mike Snitzer <snitzer@redhat.com>
    dm cache metadata: verify cache has blocks in blocks_are_clean_separate_dirty()

Mike Snitzer <snitzer@redhat.com>
    dm thin: send event about thin-pool state change _after_ making it

Stefan Wahren <stefan.wahren@i2se.com>
    ARM: dts: bcm2837: Fix polarity of wifi reset GPIOs

Lubomir Rintel <lkundrak@v3.sk>
    ARM: mmp/mmp2: fix cpu_is_mmp2() on mmp2-dt

Chad Austin <chadaustin@fb.com>
    fuse: continue to send FUSE_RELEASEDIR when FUSE_OPEN returns ENOSYS

Alek Du <alek.du@intel.com>
    mmc: sdhci: fix the timeout check window for clock and reset

Faiz Abbas <faiz_abbas@ti.com>
    mmc: sdhci-omap: Fix DCRC error handling during tuning

Wolfram Sang <wsa+renesas@sang-engineering.com>
    mmc: core: use mrq->sbc when sending CMD23 for RPMB

Aaro Koskinen <aaro.koskinen@iki.fi>
    MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5910/OMAP310

Amir Goldstein <amir73il@gmail.com>
    ovl: fix missing override creds in link of a metacopy upper

Amir Goldstein <amir73il@gmail.com>
    ovl: fix decode of dir file handle with multi lower layers

Keith Busch <keith.busch@intel.com>
    block/bio: Do not zero user pages

Robin Murphy <robin.murphy@arm.com>
    arm64: dma-mapping: Fix FORCE_CONTIGUOUS buffer clearing

Andrea Arcangeli <aarcange@redhat.com>
    userfaultfd: check VM_MAYWRITE was set after verifying the uffd is registered

Piotr Jaroszynski <pjaroszynski@nvidia.com>
    fs/iomap.c: get/put the page in iomap_page_create/release()

Thierry Reding <treding@nvidia.com>
    scripts/spdxcheck.py: always open files in binary mode

Jeff Moyer <jmoyer@redhat.com>
    aio: fix spectre gadget in lookup_ioctx

Chen-Yu Tsai <wens@csie.org>
    pinctrl: sunxi: a83t: Fix IRQ offset typo for PH11

Arnd Bergmann <arnd@arndb.de>
    drm/msm: fix address space warning

Arnd Bergmann <arnd@arndb.de>
    ARM: dts: qcom-apq8064-arrow-sd-600eval fix graph_endpoint warning

Arnd Bergmann <arnd@arndb.de>
    i2c: aspeed: fix build warning

Arnd Bergmann <arnd@arndb.de>
    slimbus: ngd: mark PM functions as __maybe_unused

Lubomir Rintel <lkundrak@v3.sk>
    staging: olpc_dcon: add a missing dependency

Arnd Bergmann <arnd@arndb.de>
    scsi: raid_attrs: fix unused variable warning

Vincent Guittot <vincent.guittot@linaro.org>
    sched/pelt: Fix warning and clean up IRQ PELT config


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts         |   2 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |   2 +-
 .../arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts |   5 +
 arch/arm/mach-mmp/cputype.h                        |   6 +-
 arch/arm64/mm/dma-mapping.c                        |   2 +-
 arch/powerpc/kernel/legacy_serial.c                |   6 +-
 arch/powerpc/kernel/msi.c                          |   7 +-
 arch/x86/Makefile                                  |  10 +-
 block/bio.c                                        |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c            |  36 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   6 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   6 +
 drivers/gpu/drm/amd/powerplay/inc/smu7_ppsmc.h     |   2 +
 .../drm/amd/powerplay/smumgr/polaris10_smumgr.c    |   6 +
 drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c      |   3 +
 drivers/gpu/drm/i915/gvt/fb_decoder.c              |   2 +-
 drivers/gpu/drm/i915/intel_lrc.c                   |   7 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_dbg.c            |   8 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  30 +++--
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   6 -
 drivers/i2c/busses/i2c-aspeed.c                    |   4 +-
 drivers/md/dm-cache-metadata.c                     |   4 +
 drivers/md/dm-thin.c                               |  68 ++++++------
 drivers/md/dm-zoned-target.c                       | 122 +++++++--------------
 drivers/md/dm.c                                    |   2 +
 drivers/media/common/videobuf2/videobuf2-core.c    |   4 +-
 drivers/mmc/core/block.c                           |  15 ++-
 drivers/mmc/host/omap.c                            |  11 +-
 drivers/mmc/host/sdhci-omap.c                      |  12 +-
 drivers/mmc/host/sdhci.c                           |  18 ++-
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c         |   2 +-
 drivers/scsi/raid_class.c                          |   4 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    |   6 +-
 drivers/staging/olpc_dcon/Kconfig                  |   1 +
 fs/aio.c                                           |   2 +
 fs/fuse/dir.c                                      |   2 +-
 fs/fuse/file.c                                     |  21 ++--
 fs/fuse/fuse_i.h                                   |   2 +-
 fs/iomap.c                                         |   7 ++
 fs/overlayfs/dir.c                                 |  14 ++-
 fs/overlayfs/export.c                              |   6 +-
 fs/userfaultfd.c                                   |   3 +-
 init/Kconfig                                       |   5 +
 kernel/sched/core.c                                |   7 +-
 kernel/sched/fair.c                                |   2 +-
 kernel/sched/pelt.c                                |   2 +-
 kernel/sched/pelt.h                                |   2 +-
 kernel/sched/sched.h                               |   5 +-
 kernel/trace/ftrace.c                              |   1 +
 kernel/trace/trace_events_filter.c                 |   5 +-
 kernel/trace/trace_events_trigger.c                |   6 +-
 scripts/spdxcheck.py                               |   6 +-
 53 files changed, 311 insertions(+), 219 deletions(-)


