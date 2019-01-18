Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95BCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655B620873
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu8etfU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfARAn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 19:43:26 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41197 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfARAnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 19:43:25 -0500
Received: by mail-qk1-f193.google.com with SMTP id 189so7150795qkj.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 16:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=t9SEvDbs3UC/Jl3BWvzKmJHvwoadCsMUe+Hw3rEdFS4=;
        b=cu8etfU4rPp6kSZT7CJ34gBHlZ4bO3l4z+8Ln9NkO6XAm46Q+GlHtav0ypSX6xWrqH
         yYNtR6n/uVp6yyFrLFFArd5J9CPGEtGOJHFz7cHyihhRZyOfTgMdjDjmO+gGKYOKqjfv
         a+OiL1U/39p0hbr7gzFjqEvB7s9i/mOirpugd6CjAGJzzQr2ITXIZpLICePlnuHDnAxC
         cUi6f0kY5S6j6Ebr/ylOGH8ER1k8AYFN78MtWG8znTuA+k0L4yxvr77rRDJX+Gmj2LcK
         O8wINUJuBlPU1O7z1g5K3quJDSp6Zj0hY7gl+q2VSsfb0AtlaWZkmHDB42u8ZonhYvfD
         dpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=t9SEvDbs3UC/Jl3BWvzKmJHvwoadCsMUe+Hw3rEdFS4=;
        b=uNEsKf/TAbkHe33ApkyKtHgUf6jVyQNRgjSIAcoDFo3BTDKDV3HrjzZW/qdSppBvlC
         P6iqs57y7PJB0E9ucm1hUlFuPm18gguHtcl9+qJ+RNohTq/BsTaVD4jcb6TsFt8PRZDZ
         fmdmyHuCSldjllZprmQ2LzML8j8+FNEWKD4fyiiCghm235urj4aZJ6921FPGy4gw31eE
         D5Bx+MrRn94sgmqbBjkqb2YgXOHJRUTkPLuzGhBgTwZw8Jydl5a4ignXFy7RC7kYk76q
         SWgYmHujIEHRj3Cq0BX2zGditD3g5ZFvm7s7GV2XbTQy8jyIqDJUIfngTnnZ2FklcmT9
         WntA==
X-Gm-Message-State: AJcUukeOCt3dGPf7u2ng6Jxn1kcoOfAhXDkeIw0c/8xY+xqsBf6hlRwi
        U2SOCPGML0cBsrIGHKK3i0zfnS86EkdHCn0II+lc1w==
X-Google-Smtp-Source: ALg8bN5CRKmr2zec1cRUTJTd/cJMqJcM0aM5EeuqL4pfBACl/BCvQ06JgxcwfA7dey79OMLKGYPog0bFk6qhCJPxIeo=
X-Received: by 2002:a37:dc04:: with SMTP id v4mr13195578qki.101.1547772204464;
 Thu, 17 Jan 2019 16:43:24 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 18 Jan 2019 10:43:13 +1000
Message-ID: <CAPM=9twXwFGmN8fK-iNyFR6T_k64qB5OdNFP3fzKSSWKou1BcA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.0-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Going to be at LCA next week in Christchurch, but should be fine for
normal pulls.

The rc3 fixes are a bit scattered:

meson, sun4i and rockchip all had missing of_node_put
qxl and virtio both were advertising dma-buf to userspace when they
really shouldn't have.

Otherwise:
meson:
- modesetting regression fix
i915 GVT:
- one cmd parser failure fix
- region cleanup fix in vGPU destroy

amdgpu:
- KFD fixes for arm64 mixed APU/DGPU
- vega12 powerplay fix
- raven DC fixes
- freesync fix.

Thanks,
Dave.


drm-fixes-2019-01-18:
drm amdgpu, i915 gvt, sun4i, meson, rockchip, qxl, virtio fixes
The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8=
:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-01-18

for you to fetch changes up to df0219b4f9576c72b618db5edf7bb75c14829dbd:

  Merge tag 'drm-misc-fixes-2019-01-17' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2019-01-18
09:14:45 +1000)

----------------------------------------------------------------
drm amdgpu, i915 gvt, sun4i, meson, rockchip, qxl, virtio fixes

----------------------------------------------------------------
Alex Deucher (1):
      Revert "drm/amdgpu: validate user GEM object size"

Charlene Liu (1):
      drm/amd/display: fix PME notification not working in RV desktop

Colin Xu (1):
      drm/i915/gvt: Allow F_CMD_ACCESS on mmio 0x21f0

Dave Airlie (3):
      Merge branch 'drm-fixes-5.0' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2019-01-17' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2019-01-17' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

David Francis (1):
      drm/amd/display: Detach backlight from stream

Felix Kuehling (2):
      drm/amdkfd: Allow building KFD on ARM64 (v2)
      drm/amdkfd: Don't assign dGPUs to APU topology devices

Gerd Hoffmann (2):
      drm/qxl: drop prime import/export callbacks
      drm/virtio: drop prime import/export callbacks

Hang Yuan (1):
      drm/i915/gvt: free VFIO region space in vgpu detach

Jani Nikula (1):
      Merge tag 'gvt-fixes-2018-01-17' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Josip Pavic (1):
      drm/amd/display: Pack DMCU iRAM alignment

Julia Lawall (3):
      drm/rockchip: add missing of_node_put
      drm/meson: add missing of_node_put
      drm/sun4i: backend: add missing of_node_puts

Kenneth Feng (1):
      drm/amd/powerplay: run acg btc for Vega12

Michel D=C3=A4nzer (1):
      Revert "drm/amdgpu: validate user pitch alignment"

Neil Armstrong (1):
      drm/meson: Fix atomic mode switching regression

Nicholas Kazlauskas (2):
      drm/amd/display: Only get the connector state for VRR when toggled
      drm/amd/display: Fix disabled cursor on top screen edge

Roman Li (1):
      drm/amd/display: fix warning on raven hotplug

Zhenyu Wang (1):
      drm/i915/gvt: Fix mmap range check

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        | 18 -------------
 drivers/gpu/drm/amd/amdkfd/Kconfig                 |  4 +--
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |  8 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          | 21 ++++++++++-----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  4 +--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      | 12 +--------
 drivers/gpu/drm/amd/display/dc/dc_link.h           |  3 +--
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |  1 -
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  7 ++++-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c   |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |  2 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 19 +++++---------
 .../drm/amd/display/modules/power/power_helpers.c  |  2 ++
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 21 +++++++++++++++
 drivers/gpu/drm/i915/gvt/handlers.c                |  1 +
 drivers/gpu/drm/i915/gvt/hypercall.h               |  2 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                   | 30 ++++++++++++++++++=
+---
 drivers/gpu/drm/i915/gvt/mpt.h                     |  2 +-
 drivers/gpu/drm/meson/meson_crtc.c                 | 23 ++---------------
 drivers/gpu/drm/meson/meson_drv.c                  | 14 ++++++++--
 drivers/gpu/drm/qxl/qxl_drv.c                      |  4 ---
 drivers/gpu/drm/qxl/qxl_prime.c                    | 14 ----------
 drivers/gpu/drm/rockchip/rockchip_rgb.c            |  4 ++-
 drivers/gpu/drm/sun4i/sun4i_backend.c              |  5 ++--
 drivers/gpu/drm/virtio/virtgpu_drv.c               |  4 ---
 drivers/gpu/drm/virtio/virtgpu_drv.h               |  4 ---
 drivers/gpu/drm/virtio/virtgpu_prime.c             | 14 ----------
 27 files changed, 114 insertions(+), 131 deletions(-)
