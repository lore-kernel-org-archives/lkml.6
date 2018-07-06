Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16BEC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7143D24026
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B94Jn2EP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7143D24026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753640AbeGFBUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 21:20:03 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:44555 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753521AbeGFBUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 21:20:01 -0400
Received: by mail-qk0-f178.google.com with SMTP id v17-v6so3068625qkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 18:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=SGrg3MBdJZXohQez5P+UATYBVAGdnk/iLSDUTzAdPnk=;
        b=B94Jn2EPgjcDfiVt4OJ3PnhnzffjLSrZUt1p45LKYwVMyjSPoTMJL/2jtjJdbEMgPU
         17wc6xDEMUp8rgrpFIkc1kP4BMkz/jhxuKhayz4Pw7QSU+15Jy2VrFjPBcZJL9y54afq
         9cBphza3uI7n6Wrrojv6hxa1ioH3/O8g/tUUFRkS0gcHk7NosS149cHsCtkNWLB5+8yR
         JZc1TBX9UUQUb3s79q4hUEiNDyqnQ8dzUDGKZDKV2QHmO34jSuT6iJTNwEn0SNIQzKHb
         QHw0OWGClo8ELJ0igqa7bnVjiE0LzwdEupQiNmjvbCB6hDn36BujY12nxRZ9VFclZSRa
         bZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=SGrg3MBdJZXohQez5P+UATYBVAGdnk/iLSDUTzAdPnk=;
        b=e+3/V+bKZQG0vPaM/gvhP+SctRaeYB0VNJyxUGe0tXb2DuzyB8RC74UQjm6xvHW5Gf
         I1nr3KZtH6jGf/7ZVrwHjx9S6UDVRW9s3K4RnnuOqJzKZqlCzaB43jM9blbgs9vE4xMV
         BDSFanT6nZqvizcqkSN/CABHH7yUndnKrQJmVcwGaSsSIL+Sh48En9d8AKXmuhrkdKu3
         6ReDZF07RYg4HfBfgQ+qJuln4P+arVmsIACqNR0x0NsMOPoT0TQDOfgmARtl7n3AdKhg
         u9GJJTOh71PG03ZEML1CVdEttzaoaINTJyen1z9uTl2piG2RFcUESmdqZFYd+rW7cjli
         l4Gw==
X-Gm-Message-State: APt69E2c9Tn3b3qUalAbd2XmcJLThUj0rO7Rq49W1XjNH/AoDTwkHQLs
        MMT7JZxBhz9Bf1wug4hoUmTmXlVfwMG/V9z+IvYyFg==
X-Google-Smtp-Source: AAOMgpe9iLhb5glxM7NMu8UiD3T3VcEjokXXdmfPjlnYAvsNwCP6dyGxr5EJ22V0kbvILKO9hXVl2yxstfbzAcOzUFI=
X-Received: by 2002:a37:5e46:: with SMTP id s67-v6mr6943643qkb.202.1530840000796;
 Thu, 05 Jul 2018 18:20:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:1e87:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 18:20:00 -0700 (PDT)
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 6 Jul 2018 11:20:00 +1000
Message-ID: <CAPM=9tw9bG5OK7n42-vjxcGiTaqG6V8XQeB=aso1qDhLnzkLkg@mail.gmail.com>
Subject: [git pull] drm fixes for 4.18-rc4
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


drm-fixes-2018-07-06:
amdgpu, i915, exynos, udl, sii8620 and core fixes
The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063=
:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-07-06

for you to fetch changes up to c78d1f9d95a9f2cd5546c64f5315f54681dd6055:

  Merge tag 'exynos-drm-fixes-for-v4.18-rc4' of
git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into
drm-fixes (2018-07-06 10:47:02 +1000)

----------------------------------------------------------------
amdgpu, i915, exynos, udl, sii8620 and core fixes

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu: fix swapped emit_ib_size in vce3
      drm/amdgpu/pm: fix display count in non-DC path

Andrzej Pietrasiewicz (1):
      drm/exynos: scaler: Reset hardware before starting the operation

Chris Wilson (1):
      drm/i915: Try GGTT mmapping whole object as partial

Dave Airlie (4):
      Merge tag 'drm-misc-fixes-2018-07-05' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2018-07-05' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge branch 'drm-fixes-4.18' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'exynos-drm-fixes-for-v4.18-rc4' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-fixes

Evan Quan (3):
      drm/amd/powerplay: correct vega12 thermal support as true
      drm/amd/powerplay: correct vega12 bootup values settings
      drm/amd/powerplay: smc_dpm_info structure change

Jani Nikula (1):
      Merge tag 'gvt-fixes-2018-07-03' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Lyude Paul (3):
      drm/amdgpu: Make struct amdgpu_atif private to amdgpu_acpi.c
      drm/amdgpu: Add amdgpu_atpx_get_dhandle()
      drm/amdgpu: Dynamically probe for ATIF handle (v2)

Maciej Purski (3):
      drm/bridge/sii8620: Send AVI infoframe in all MHL versions
      drm/bridge/sii8620: Fix display of packed pixel modes
      drm/bridge/sii8620: Fix link mode selection

Marek Szyprowski (10):
      drm/exynos: ipp: Rework checking for the correct buffer formats
      drm/exynos: rotator: Fix DRM_MODE_REFLECT_{X,Y} interpretation
      drm/exynos: scaler: Fix support for YUV420, YUV422 and YUV444 modes
      drm/exynos: gsc: Use real buffer width for configuring the hardware
      drm/exynos: gsc: Increase Exynos5433 buffer width alignment to 16 pix=
els
      drm/exynos: gsc: Fix DRM_MODE_REFLECT_{X,Y} interpretation
      drm/exynos: gsc: Fix support for NV16/61, YUV420/YVU420 and YUV422 mo=
des
      drm/exynos: fimc: Use real buffer width for configuring the hardware
      drm/exynos: decon5433: Fix per-plane global alpha for XRGB modes
      drm/exynos: decon5433: Fix WINCONx reset value

Michel D=C3=A4nzer (1):
      drm: Use kvzalloc for allocating blob property memory

Mikita Lipski (2):
      drm/amd/display: adding ycbcr420 pixel encoding for hdmi
      drm/amd/display: add a check for display depth validity

Mikulas Patocka (1):
      drm/udl: fix display corruption of the last line

Nicolai H=C3=A4hnle (1):
      drm/amdgpu: fix user fence write race condition

Stefan Agner (1):
      drm/exynos: ipp: use correct enum type

Thomas Zimmermann (3):
      drm/exynos: Replace drm_framebuffer_{un/reference} with put,get funct=
ions
      drm/exynos: Replace drm_gem_object_unreference_unlocked with put func=
tion
      drm/exynos: Replace drm_dev_unref with drm_dev_put

Xiaolin Zhang (1):
      drm/i915/gvt: changed DDI mode emulation type

Zhao Yan (1):
      drm/i915/gvt: fix a bug of partially write ggtt enties

 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  46 ++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           | 131 +++++++++++++++++=
----
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |   4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  49 +++++++-
 drivers/gpu/drm/amd/include/atomfirmware.h         |   5 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c |  96 +++++++++++++--
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h |   5 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c |   4 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h |   3 +
 .../amd/powerplay/hwmgr/vega12_processpptables.c   |   2 +
 .../drm/amd/powerplay/inc/vega12/smu9_driver_if.h  |   5 +-
 drivers/gpu/drm/bridge/sil-sii8620.c               |  86 +++++++++-----
 drivers/gpu/drm/drm_property.c                     |   6 +-
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |   6 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_fb.c             |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_fimc.c           |  17 +--
 drivers/gpu/drm/exynos/exynos_drm_gem.c            |  10 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |  51 ++++----
 drivers/gpu/drm/exynos/exynos_drm_ipp.c            | 110 +++++++++--------
 drivers/gpu/drm/exynos/exynos_drm_plane.c          |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_rotator.c        |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_scaler.c         |  44 +++++--
 drivers/gpu/drm/exynos/regs-gsc.h                  |   1 +
 drivers/gpu/drm/i915/gvt/display.c                 |   6 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     |  58 +++++++++
 drivers/gpu/drm/i915/gvt/gtt.h                     |   2 +
 drivers/gpu/drm/i915/i915_gem.c                    |  28 +++--
 drivers/gpu/drm/i915/i915_vma.c                    |   2 +-
 drivers/gpu/drm/udl/udl_fb.c                       |   5 +-
 drivers/gpu/drm/udl/udl_transfer.c                 |  11 +-
 34 files changed, 583 insertions(+), 242 deletions(-)
