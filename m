Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D81C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17CE2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbUfXX/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfBHBFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:05:36 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43295 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfBHBFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:05:36 -0500
Received: by mail-qk1-f194.google.com with SMTP id f196so704410qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 17:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=RVzEuPziHy3sW8QyIDZiW/WNzXkecqQInNxZJ5EZxUI=;
        b=WbUfXX/yqxHAgog13+qGny1ASvekyUjTjbEZpryos4d6tS9QQ33drFvd3njBhGSR0Z
         QPI0UQ+Xl3nx4l1VJPBsPEIZcBoOiaRAwM29IFEkQj7Ld4jylKzRUSwnfyFPXuzYLtWg
         1ACbOBcDkUuRhgJr5htxCOWR0cEJrsfj4oE9IzF1hD4bTH8eHC7qxvBQcLmJac3ZK5xf
         O5YErk2eyGMiMhi2HTKTp/j0yijKq9sqdN7pBaUl025eLGqOvCTqneQDBh/IEy5BG2/9
         5eGAG1u8rjBXrhUSghwtUcvd8hFg14OTsE8ARqTicPrP1q2rs8bgKmxqSY2pA5PEP4Go
         rdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=RVzEuPziHy3sW8QyIDZiW/WNzXkecqQInNxZJ5EZxUI=;
        b=aLE6IfEZtgl6MC+wYFWBonvsxVWL6d+ie76xvLGTMw5IHnq9BFnrlrkSq59bFtU6Tg
         65u7FIIpBiUFBhV4wdm5WUaKJiOvGLiOS5BBaDt1P0ux4jQGlkXviefMGooFY3Sb8Qqg
         bihUFLFRi/CQ9vfFsC56ZBOkZRUC0/tMHZRfAVDN6ODM0Q8ASOf4bNmYfpawlKUADd+J
         s6wdH/VQnRpLZJcPOCmGHIpzEsJIGG3KP8Ya8/7UL6qedluioois7BzimkLAGUVw+i94
         opTc9N51N/7OyJNIj4dDTQWXSKu4AOmdYsVSXQsIDf1RVaeuttTWvXCDmyzHDrQ+BHMO
         wzag==
X-Gm-Message-State: AHQUAubDBkvT8qG1k63TpM06TG3YMWjI5hZ9uEgxbzjV1uWv7RUczw09
        gMIYVw9iqWDhK/0jmFQ+HwTOCKK+HiN6ETgq6dWIhHxq
X-Google-Smtp-Source: AHgI3IbDSrrrBmAY9ka+E9GIFQlIsVCF7/EXUq+8kIjj6sE9Kp9Co9I1EfuyImTLnHDnZMPOUUdX8Z9OwFnv/+WZI24=
X-Received: by 2002:a37:dc04:: with SMTP id v4mr14122700qki.101.1549587934958;
 Thu, 07 Feb 2019 17:05:34 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 8 Feb 2019 11:05:22 +1000
Message-ID: <CAPM=9tyDqeLkmSOcru20dnmyRYp_ne7sjeP=4K-kmdc=VvRxdQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.0-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Missed fixes last week as had nothing until amdgpu showed up on
Saturday. Other stuff has since rolled in along with some more amdgpu
fixes, so we have two weeks of those, and some i915, vmwgfx, sun4i,
rockchip and omap fixes.

Dave.

amdgpu/radeon:
- fix crash on passthrough for SI
- fencing fix for shared buffers
- APU hwmon fix
- API powerplay fix
- eDP freesync fix
- PASID mgr locking fix
- KFD warning fix
- DC/powerplay fix
- raven revision ids fix
- vega20 doorbell fix

i915:
- SNB display fix
- SKL srckey mask fix
- ICL DDI clock selection fix

vmwgfx:
- DMA API fix
- IOMMU detection fix
- display fixes

sun4i:
- tcon clock fix

rockchip:
- SPDX identifier fix

- omap:
- DSI fixes

drm-fixes-2019-02-08:
drm amdgpu, vmwgfx, i915, omap, sun4i fixes
The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5=
:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-02-08

for you to fetch changes up to dada163c5eab43adf2c7595bc6d562748e1eb69e:

  Merge tag 'drm-misc-fixes-2019-02-07' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2019-02-08
10:32:49 +1000)

----------------------------------------------------------------
drm amdgpu, vmwgfx, i915, omap, sun4i fixes

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu: Add missing power attribute to APU check
      drm/radeon: check if device is root before getting pci speed caps

Chris Wilson (1):
      drm/amdgpu: Transfer fences to dmabuf importer

Christoph Hellwig (4):
      drm/vmwgfx: remove CONFIG_X86 ifdefs
      drm/vmwgfx: remove CONFIG_INTEL_IOMMU ifdefs v2
      drm/vmwgfx: fix the check when to use dma_alloc_coherent
      drm/vmwgfx: unwind spaghetti code in vmw_dma_select_mode

Dave Airlie (5):
      Merge branch 'drm-fixes-5.0' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge branch 'drm-fixes-5.0' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge branch 'vmwgfx-fixes-5.0-2' of
git://people.freedesktop.org/~thomash/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2019-02-07-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2019-02-07' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Deepak Rawat (1):
      drm/vmwgfx: Also check for crtc status while checking for DU active

Gustavo A. R. Silva (1):
      drm/amd/powerplay: Fix missing break in switch

Huang Rui (1):
      drm/amdgpu: fix the incorrect external id for raven series

Jay Cornwall (1):
      drm/amdgpu: Implement doorbell self-ring for NBIO 7.4

Lucas De Marchi (1):
      drm/i915: always return something on DDI clock selection

Nathan Chancellor (1):
      drm/amdkfd: Fix if preprocessor statement above
kfd_fill_iolink_info_for_cpu

Nicholas Kazlauskas (1):
      drm/amd/display: Attach VRR properties for eDP connectors

Paul Kocialkowski (1):
      drm/sun4i: tcon: Prepare and enable TCON channel 0 clock at init

Philip Yang (1):
      drm/amdgpu: use spin_lock_irqsave to protect vm_manager.pasid_idr

Roman Li (1):
      drm/amd/display: Fix fclk idle state

Sandy Huang (1):
      drm/rockchip: rgb: update SPDX license identifier

Thomas Hellstrom (4):
      drm/vmwgfx: Return error code from vmw_execbuf_copy_fence_user
      drm/vmwgfx: Fix an uninitialized fence handle value
      drm/vmwgfx: Fix setting of dma masks
      drm/vmwgfx: Improve on IOMMU detection

Tina Zhang (1):
      drm/modes: Prevent division by zero htotal

Tomi Valkeinen (3):
      drm/omap: dsi: Fix crash in DSI debug dumps
      drm/omap: dsi: Fix OF platform depopulate
      drm/omap: dsi: Hack-fix DSI bus flags

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Fix skl srckey mask bits
      drm/i915: Try to sanitize bogus DPLL state left over by broken SNB BI=
OSen

 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c            |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c         | 59 ++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c            |  5 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c            | 13 ++++
 drivers/gpu/drm/amd/amdgpu/soc15.c                |  6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c             |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c  | 10 ++-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c |  1 +
 drivers/gpu/drm/drm_modes.c                       |  2 +-
 drivers/gpu/drm/i915/intel_ddi.c                  |  2 +-
 drivers/gpu/drm/i915/intel_display.c              | 50 ++++++++++++--
 drivers/gpu/drm/i915/intel_sprite.c               |  2 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c                 | 27 +++++---
 drivers/gpu/drm/radeon/ci_dpm.c                   |  5 +-
 drivers/gpu/drm/radeon/si_dpm.c                   |  5 +-
 drivers/gpu/drm/rockchip/rockchip_rgb.c           | 11 +--
 drivers/gpu/drm/rockchip/rockchip_rgb.h           | 11 +--
 drivers/gpu/drm/sun4i/sun4i_tcon.c                |  2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c               | 81 +++++++++----------=
----
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c           |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c               |  6 +-
 22 files changed, 198 insertions(+), 110 deletions(-)
