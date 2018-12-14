Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7806C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2C820870
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVDIxD7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2C820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbeLNBy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:54:29 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33345 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbeLNBy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:54:28 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so4643023qtp.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 17:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vnphnwUMUM1c95PKYPagzYatlIXheXfw5CaBG5Ksa8U=;
        b=vVDIxD7/tm2vyI/hM5YxhdTSPI1Zm42tnM3yPEGy1Kij4jAewhXPWUa1yueKugtByx
         IrFWD42HC1kgRFAYZVayn+Moqv058patgSnC/TP+YOpBSb6nujQ0/8bVAmlF0P7LkNrs
         ESc+jiM/1Oqy7PpeaN1vsflhxMDm9LR37oYBSuBsdnJJPV9zvlwwadQVXU4F68Mb/PIf
         mjftBGZSFwV8bz2my3RPalHniQtF4dNedFjZr/FwvQYZ9/RWo/ACgd9IcZuKFfQFoJ40
         5HSJqEdVqy/uhH+q+4CwuJ66VU9g9oYuB8Elr3w76D3VtkZdfLue2rPxHUqDd1fFMrIR
         zODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vnphnwUMUM1c95PKYPagzYatlIXheXfw5CaBG5Ksa8U=;
        b=CF/1sOEy/kLU0guy6QUm6nlcGoNfaFS51yY7cSP+uZqcF9ni9LTOUzHEafoB4G2dLN
         VDQixNJo5gGsvntLMoo7yCdTyjftotCG5JX47gRMQKDLhNBNFhO+l12NA9XnHmkdESXH
         Vn8qTNkpeN+pkhjDK/y/vM4HlVaVnTvsuRua99gPFRx2/ujZWdG/35nrgDqFDBAtES91
         Z+FlBuU8Qrxeb9gF2kw6WoUUQOOFOBR6e2beZCl0sA1s/9xv/xsTSRNdEEJoRsDp8dBO
         8UzbcWsCTX427OZ2YAoHvq7HPjvQVVFJbkmUBJr0kl+Qkzly+oITE3/2ENYYdsnGJ2z1
         uwpQ==
X-Gm-Message-State: AA+aEWa9TkbcdCaqouTorGW/ONTk3ge0Q3y1WvTgCYtvbLgHJsfiINbU
        00bub+JPTntewfEWxXLaaMZodz5PiT/73R+dajE=
X-Google-Smtp-Source: AFSGD/X/WaMV8mXDJgdpKj28tFbAh3ypdiFeq79ADcUF1MlZNOtDes8A07G3WsXbDRqs3b2DZvoa6soAaVhvUSK0MVU=
X-Received: by 2002:aed:2f05:: with SMTP id l5mr1093988qtd.356.1544752466812;
 Thu, 13 Dec 2018 17:54:26 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 14 Dec 2018 11:54:15 +1000
Message-ID: <CAPM=9tx+7roxu+Ws70OWaYjV7V8FgHmqb=HN4LO0S5GgccJgTw@mail.gmail.com>
Subject: [git pull] drm fixes for 4.20-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

While I hoped things would calm down, the world hasn't joined with me,
but it's a few things scattered over a wide area. The i915 workarounds
regression fix is probably the largest, the rest are more usual sized.
We also get some new AMD PCI IDs.

There is also a patch in here to MAINTAINERS to added Daniel as an
official DRM toplevel co-maintainer, he's decided he wants to step up
and share the glory, and he'll likely process next weeks fixes while
I'm away on holidays.

I'm also going to send an early drm-next to you today, it might get
superseded but I'll get it out there in advance of holiday period.

Dave.

summary:

amdgpu:
- some new PCI IDs,
- fixed firmware image updates
- power management fixes
- locking warning fix
nouveau:
- framebuffer flushing fix
- memory leak fix
- tegra device init regression fix
vmwgfx:
 - OOM kernel memory fix
 - excess return in function fix
i915:
 - the biggest fix is a regression fix where workarounds weren't
getting reapplied after a gpu hang causing further crashing, this
fixes the workaround application to make it happen again,
 - GPU hang fixes for Braswell and some GEN3 GPUs.
 - GVT fix for broadwell tiling
rockchip:
- revert to fix a regression causing a WARN on shutdown
mediatek:
- avoid crash attaching to non-existant bridges

drm-fixes-2018-12-14:
drm vmwgfx, mediatek, nouveau, amdgpu, rockchip, intel fixes
The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-12-14

for you to fetch changes up to 1df07a7f2244947c888dc35bba2b237f714afc56:

  Merge branch 'vmwgfx-fixes-4.20' of
git://people.freedesktop.org/~thomash/linux into drm-fixes (2018-12-14
05:37:44 +1000)

----------------------------------------------------------------
drm vmwgfx, mediatek, nouveau, amdgpu, rockchip, intel fixes

----------------------------------------------------------------
Alex Deucher (5):
      drm/amdgpu: update smu firmware images for VI variants (v2)
      drm/amdgpu: add some additional vega10 pci ids
      drm/amdgpu: add some additional vega20 pci ids
      drm/amdkfd: add new vega10 pci ids
      drm/amdkfd: add new vega20 pci id

Andrey Grodzovsky (1):
      drm/amdgpu: Fix DEBUG_LOCKS_WARN_ON(depth <= 0) in amdgpu_ctx.lock

Ben Skeggs (1):
      drm/nouveau/kms/nv50-: also flush fb writes when rewinding push buffer

Brian Norris (1):
      Revert "drm/rockchip: Allow driver to be shutdown on reboot/kexec"

Chris Wilson (3):
      drm/i915/execlists: Apply a full mb before execution for Braswell
      drm/i915: Allocate a common scratch page
      drm/i915: Flush GPU relocs harder for gen3

Colin Ian King (1):
      drm/vmwgfx: remove redundant return ret statement

Daniel Vetter (1):
      MAINTAINERS: Daniel for drm co-maintainer

Dave Airlie (7):
      Merge tag 'drm-intel-fixes-2018-12-07' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-intel-fixes-2018-12-12-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2018-12-12' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'drm-fixes-4.20' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge branch 'linux-4.20' of git://github.com/skeggsb/linux into drm-fixes
      Merge branch 'mediatek-drm-fixes-4.20' of
https://github.com/ckhu-mediatek/linux.git-tags into drm-fixes
      Merge branch 'vmwgfx-fixes-4.20' of
git://people.freedesktop.org/~thomash/linux into drm-fixes

Evan Quan (1):
      drm/amdgpu: drop fclk/gfxclk ratio setting

Joonas Lahtinen (1):
      Merge tag 'gvt-fixes-2018-12-04' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Junwei Zhang (1):
      drm/amdgpu: update SMC firmware image for polaris10 variants

Kenneth Feng (1):
      drm/amdgpu/powerplay: Apply avfs cks-off voltages on VI

Lyude Paul (1):
      drm/nouveau/kms: Fix memory leak in nv50_mstm_del()

Nicolas Boichat (1):
      drm/mediatek: Only try to attach bridge if there is one

Thierry Reding (1):
      drm/nouveau/drm/nouveau: tegra: Call nouveau_drm_device_init()

Thomas Hellstrom (1):
      drm/vmwgfx: Protect from excessive execbuf kernel memory allocations v3

Tina Zhang (1):
      drm/i915/gvt: Fix tiled memory decoding bug on BDW

Tvrtko Ursulin (2):
      drm/i915: Record GT workarounds in a list
      drm/i915: Introduce per-engine workarounds

 MAINTAINERS                                        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c            |  36 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   7 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   7 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c |   2 +-
 drivers/gpu/drm/amd/powerplay/inc/smu7_ppsmc.h     |   2 +
 .../drm/amd/powerplay/smumgr/polaris10_smumgr.c    |   6 +
 drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c      |   3 +
 drivers/gpu/drm/i915/gvt/fb_decoder.c              |   2 +-
 drivers/gpu/drm/i915/i915_drv.c                    |   1 +
 drivers/gpu/drm/i915/i915_drv.h                    |   9 +
 drivers/gpu/drm/i915/i915_gem.c                    |  54 +-
 drivers/gpu/drm/i915/i915_gem_execbuffer.c         |   7 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              |   2 +-
 drivers/gpu/drm/i915/intel_engine_cs.c             |  44 +-
 drivers/gpu/drm/i915/intel_lrc.c                   |  30 +-
 drivers/gpu/drm/i915/intel_ringbuffer.c            |  52 +-
 drivers/gpu/drm/i915/intel_ringbuffer.h            |   7 +-
 drivers/gpu/drm/i915/intel_workarounds.c           | 591 ++++++++++++++-------
 drivers/gpu/drm/i915/intel_workarounds.h           |  26 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |  11 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  30 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   6 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   6 -
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |   5 +
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c           |  36 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c         |  21 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.h         |  37 ++
 31 files changed, 718 insertions(+), 335 deletions(-)
