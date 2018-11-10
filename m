Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FFCC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E815F20858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0Rlwj28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E815F20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeKKEaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 23:30:08 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46115 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeKKEaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 23:30:07 -0500
Received: by mail-qk1-f193.google.com with SMTP id q1so7230701qkf.13
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 10:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6aaLuXeskcKUGwJpUCQdS6L58xxl9JJsyro7nWkWVpQ=;
        b=Q0Rlwj28BWvsLIpVDLqBaTd3wWZun1jX+4WQssWK1LZIMkBytarDLXygfF9z3KXeCa
         Mgi0vTw/lDcJUC2kdyY5P3IiWHZoAZAVEXLGixlgkz6dnEE5PCbwsrW2mql1+Tfg/Rfy
         dPorTLQ3Cb5mNIjNZaXsToGDtv5lWCXrSfQj0rL4NkSIPsjyTAF+SGfCCWn53i6fBtkw
         hzfITjlY+zcFSN75ejdzpUT4ZxJpA+HYgTyJFsTQZlpmnj2Vj6TIyupB42RiRe5xRFd1
         H8Bty5cJbhXDPQhXjyj4ox4h6zQ6LTOPih1udAfE/1RuPlbK/vJkKGEy07S7aGf4xVeP
         SCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6aaLuXeskcKUGwJpUCQdS6L58xxl9JJsyro7nWkWVpQ=;
        b=ILEKwxA7XKcD7R32mltVCPjkS4UIFtD7q1omCInQIWxFVLxPkn57P/VW5X4evy82oC
         kjV7AyyLsKKCZL+1AljoTZdMZ/fvXGfjFHCjn0FflmmJPVQ4V2pKg/QOHF9AwgRprY4V
         S2lO1eQX9DYm8Bmz+FxvUP5vJzzJOf300bqPVS78IcyjkFheThije+fTFcok9vtqHMJV
         H3BRy+Lze61XvEKpNuAC7kog7M6stbFlLpORGV7Wdg/UEj/hgnBBpMHj/89/BhLl93PQ
         VGdNE72DyNQ1euQZ/n3/J45SR0i2Tdfj1h4QvsU+S9Ws8Gu9nug37Ot06xveq6BBuPL/
         5GfQ==
X-Gm-Message-State: AGRZ1gJ0O/gKr7BF+ErHIzoGIiw1OaXEysUDY85kmi2r4RqOag4rvShW
        NIuEhQ8qhYgeidN9Hb4ZO6KlJYxlZ9zt5l2H1SeH0yZG
X-Google-Smtp-Source: AJdET5fFdL18MGkgHhvBIn7OS/qm2WGXt/YhGyTkUD/9d/ZFgUAwzVVkKpemQdrQIPMcu2pGtyEIZrFdmZ+Idf3wuSw=
X-Received: by 2002:ac8:51d4:: with SMTP id d20mr13374765qtn.365.1541875449556;
 Sat, 10 Nov 2018 10:44:09 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sun, 11 Nov 2018 04:43:57 +1000
Message-ID: <CAPM=9tzQBpaa7HcNvCHNxrPUDmF4o4orGy_kTJBA-8KBQO65Mw@mail.gmail.com>
Subject: [git pull] drm fixes for 4.20-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Nothing too urgent in here, in case you want to leave until post
holidays. I'm in Vancouver for the next week, but should get most
stuff line up, though rc3 fixes might be late if I'm flying and
sleeping.

amdgpu has some display fixes, KFD ioctl fixes and a Vega20 bios
interaction fix.
sun4i has some NULL checks added
i915 has a 32-bit system fix, LPE audio oops, and HDMI2.0 clock fixes.
Exynos has a 3 regression fixes (one frame counter, fbdev missing,
dsi->panel check)
Etnaviv has a single fencing fix for GPU recovery.

Thanks,
Dave.

drm-fixes-2018-11-11:
drm: i915, amdgpu, sun4i, exynos and etnaviv fixes
The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a=
:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-11-11

for you to fetch changes up to 73b6f96cbc0162787bcbdac5f538167084c8d605:

  Merge branch 'drm-fixes-4.20' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2018-11-11
04:23:02 +1000)

----------------------------------------------------------------
drm: i915, amdgpu, sun4i, exynos and etnaviv fixes

----------------------------------------------------------------
Alex Deucher (7):
      Revert "drm/amd/display: set backlight level limit to 1"
      drm/amdgpu/vega20: add CLK base offset
      drm/amdgpu/display: check if fbc is available in
set_static_screen_control (v2)
      drm/amdgpu: add DC feature mask module parameter
      drm/amdgpu/display/dc: add FBC to dc_config
      drm/amdgpu/display/dm: handle FBC dc feature parameter
      drm/amdgpu/display/dce11: only enable FBC when selected

Andrzej Hajda (2):
      drm/exynos/dsi: register connector if it is created after drm bind
      drm/exynos/fbdev: do not skip fbdev init if there are no connectors

Chris Wilson (3):
      drm/i915: Mark up GTT sizes as u64
      drm/i915: Compare user's 64b GTT offset even on 32b
      drm/i915: Mark pin flags as u64

Clint Taylor (1):
      drm/i915/hdmi: Add HDMI 2.0 audio clock recovery N values

Dan Carpenter (1):
      drm/exynos: checking for NULL instead of IS_ERR()

Dave Airlie (5):
      Merge branch 'etnaviv/fixes' of
https://git.pengutronix.de/git/lst/linux into drm-fixes
      Merge tag 'exynos-drm-fixes-for-v4.20-rc2' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-fixes
      Merge tag 'drm-intel-fixes-2018-11-08' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2018-11-07' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'drm-fixes-4.20' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Dhinakaran Pandiyan (1):
      drm/i915: Fix VIDEO_DIP_CTL bit shifts

Dmitry V. Levin (2):
      uapi: fix linux/kfd_ioctl.h userspace compilation errors
      uapi: fix more linux/kfd_ioctl.h userspace compilation errors

Evan Quan (2):
      drm/amd/powerplay: set a default fclk/gfxclk ratio
      drm/amd/powerplay: always use fast UCLK switching when UCLK DPM enabl=
ed

Giulio Benetti (2):
      drm/sun4i: tcon: fix check of tcon->panel null pointer
      drm/sun4i: tcon: prevent tcon->panel dereference if NULL

Hang Yuan (2):
      drm/i915/gvt: invalidate old ggtt page when update ggtt entry
      drm/i915/gvt: support inconsecutive partial gtt entry write

Harry Wentland (1):
      drm/amd/display: Stop leaking planes

Inki Dae (1):
      Revert "drm/exynos/decon5433: implement frame counter"

Jerry (Fangzhi) Zuo (2):
      drm/amd/display: Cleanup MST non-atomic code workaround
      drm/amd/display: Drop reusing drm connector for MST

Joonas Lahtinen (1):
      Merge tag 'gvt-fixes-2018-11-07' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Leo Li (1):
      drm/amd: Update atom_smu_info_v3_3 structure

Longhe Zheng (1):
      drm/i915/gvt: Handle values of EDP_PSR_IMR and EDP_PSR_IIR

Lucas Stach (1):
      drm/etnaviv: fix bogus fence complete check in timeout handler

Lyude Paul (1):
      drm/amd/amdgpu/dm: Fix dm_dp_create_fake_mst_encoder()

Manasi Navare (1):
      drm/i915/icl: Fix the macros for DFLEXDPMLE register bits

Rodrigo Vivi (1):
      drm/i915/glk: Remove 99% limitation.

Shaokun Zhang (1):
      drm/amd/display: Fix misleading buffer information

Ville Syrj=C3=A4l=C3=A4 (4):
      drm/i915: Don't apply the 16Gb DIMM wm latency w/a to BXT/GLK
      drm/i915: Fix error handling for the NV12 fb dimensions check
      drm/i915: Don't oops during modeset shutdown after lpe audio deinit
      drm/i915: Fix ilk+ watermarks when disabling pipes

Xinyun Liu (1):
      drm/i915/gvt: correct mask setting for CSFE_CHICKEN1

 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  11 ++
 drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c       |   1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  27 ++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   2 -
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  79 ++------------
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |   1 -
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   1 +
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   7 +-
 .../drm/amd/display/dc/dce110/dce110_resource.c    |   3 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |   4 +
 drivers/gpu/drm/amd/include/atomfirmware.h         |   7 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c |  53 ++++++----
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h |   1 +
 drivers/gpu/drm/amd/powerplay/inc/vega20_ppsmc.h   |   3 +-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c            |   2 +-
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |   9 --
 drivers/gpu/drm/exynos/exynos_drm_crtc.c           |  11 --
 drivers/gpu/drm/exynos/exynos_drm_drv.h            |   1 -
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |  14 ++-
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c          |   2 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     | 115 +++++++++++------=
----
 drivers/gpu/drm/i915/gvt/gtt.h                     |  10 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |   8 +-
 drivers/gpu/drm/i915/gvt/mmio_context.c            |   2 +-
 drivers/gpu/drm/i915/i915_drv.c                    |  15 +--
 drivers/gpu/drm/i915/i915_drv.h                    |   1 -
 drivers/gpu/drm/i915/i915_gem_execbuffer.c         |   2 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c                |   2 +-
 drivers/gpu/drm/i915/i915_gem_gtt.h                |  36 ++++---
 drivers/gpu/drm/i915/i915_reg.h                    |  20 ++--
 drivers/gpu/drm/i915/intel_audio.c                 |  17 +++
 drivers/gpu/drm/i915/intel_cdclk.c                 |  18 +---
 drivers/gpu/drm/i915/intel_display.c               |  19 ++--
 drivers/gpu/drm/i915/intel_lpe_audio.c             |   4 +-
 drivers/gpu/drm/i915/intel_pm.c                    |   3 +-
 drivers/gpu/drm/i915/selftests/huge_pages.c        |   2 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |   6 +-
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 |   4 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |   4 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |   5 +-
 include/uapi/linux/kfd_ioctl.h                     |  18 ++--
 43 files changed, 258 insertions(+), 297 deletions(-)
