Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A9FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 03:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EC520837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 03:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qs4ld8PF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EC520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeHaHxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 03:53:24 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:37434 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeHaHxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 03:53:23 -0400
Received: by mail-qt0-f172.google.com with SMTP id n6-v6so13166419qtl.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 20:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=rbO3xUZdmb28g4Bhw1CgfEqi48liRjp+Yj6Kboh5QNM=;
        b=Qs4ld8PFJrAsnFiYATVyV7egkvSCe9Tra4unbGST9Holooa06BnVY6dm6Eb86jX3eo
         KDoOp2B+s1wd/B108aO4mQUZCk5vufhC8/VV4hSvzfeJKJx9HTgGUPF/W+KRC90dHvRV
         zT/WPpjKfNhAtSI75DqPlK/zXb98Lz6uMyNWvB3438cvuvp/IfyCJ108nwiICMqF+mba
         sDNXgETnCe2hlqriNUxcBsqAp4taOiY1dUcOIC7Ruqhil1nFmRosryPAjme986lFKfLw
         +3Fqnj666hxO2+Ag5eFXN4dwn5+kblNWOeLUy3IHHr5VhkIlQey5It84Hvh70HHrOa17
         bzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=rbO3xUZdmb28g4Bhw1CgfEqi48liRjp+Yj6Kboh5QNM=;
        b=mZL0MIB8qh+zIVTBJmeby35coEidTTDTPYew63E3f06PgSMgifKEVNpv6fK+a7ipqF
         F0A4M8pcR/UzDIUBoRLNfAfcGrGXQ3Wd49umOsoAUMz9UffcznPDKTPAIBLV+w87cCZd
         0Wl4re+xvVXTQadCryNmGdIXTm0XyNaEEnNiQXh0Wnt74vuV+ER8sSIN5y549ElV94H5
         885mE7ubr9gBzL6GFUuoK9whEH/il1iUNJ4L9Zz10btV7Sq372o0Ed7qFkx9s/I1W6yR
         S8Y6jqIi5eStLxfd2YNYx6X8nyJqJLQnIOdS7s/+dkmBm5T+65udkdVw9xT37vRaxM75
         4JDA==
X-Gm-Message-State: APzg51BUd4ffdJfryupZX8pf86ysIAKifF2+E30vp2sUCGobamw8zxax
        vkkWXQZHt/s2xCRCWWxAoLYT3gUmnzS7UiLCz16Iu0Cy
X-Google-Smtp-Source: ANB0Vdap/JPrwmGIl+4sc+XZCdVvtbFlBMfqh9hRPkUcigHh6nZ23cJ0QVD9/5StkA9PpqjWyUfqjm0AXgc3faDVui8=
X-Received: by 2002:ac8:754a:: with SMTP id b10-v6mr14778217qtr.260.1535687281338;
 Thu, 30 Aug 2018 20:48:01 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 31 Aug 2018 13:47:49 +1000
Message-ID: <CAPM=9txzSjP-Asajk5m5jR5z-wqUVCWtJDrjWjac6x7GOunkUg@mail.gmail.com>
Subject: [git pull] drm fixes for 4.19-rc2
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

Regular fixes pull,

Mediatek is a bunch of fixes to their RDMA and Overlay engines.
i915 has some Cannonlake/Geminilake watermark workarounds, LSPCON fix,
HDCP free fix, audio fix and a ppgtt reference counting fix.
amdgpu has some SRIOV, Kasan, memory leaks and other misc fixes.

Thanks,
Dave.

drm-fixes-2018-08-31:
drm fixes for mediatek, amdgpu and i915.
The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3=
:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-08-31

for you to fetch changes up to 49a51c4b4064c8a89ffd166434696138edef6b85:

  Merge tag 'drm-intel-fixes-2018-08-29' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2018-08-30
11:35:03 +1000)

----------------------------------------------------------------
drm fixes for mediatek, amdgpu and i915.

----------------------------------------------------------------
Andrey Grodzovsky (1):
      drm/amdgpu: Fix page fault and kasan warning on pci device remove.

Chris Wilson (2):
      drm/i915: Stop holding a ref to the ppgtt from each vma
      drm/i915/audio: Hook up component bindings even if displays are disab=
led

Christian K=C3=B6nig (3):
      drm/amdgpu: fix VM clearing for the root PD
      drm/amdgpu: fix preamble handling
      drm/amdgpu: fix holding mn_lock while allocating memory

Dave Airlie (3):
      Merge branch 'mediatek-drm-fixes-4.19' of
https://github.com/ckhu-mediatek/linux.git-tags into drm-fixes
      Merge branch 'drm-fixes-4.19' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2018-08-29' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Emily Deng (2):
      amdgpu: fix multi-process hang issue
      drm/amdgpu: Need to set moved to true when evict bo

Felix Kuehling (1):
      drm/amdgpu: Adjust the VM size based on system memory size v2

Fredrik Sch=C3=B6n (1):
      drm/i915: Increase LSPCON timeout

Rex Zhu (6):
      drm/amd/display: Fix bug use wrong pp interface
      drm/amdgpu: Enable/disable gfx PG feature in rlc safe mode
      drm/amdgpu: Fix vce initialize failed on Kaveri/Mullins
      drm/amdgpu: Update power state at the end of smu hw_init.
      drm/amdgpu: Power on uvd block when hw_fini
      drm/amdgpu: Remove duplicated power source update

Rodrigo Vivi (1):
      drm/i915: Free write_buf that we allocated with kzalloc.

SivapiriyanKumarasamy (1):
      drm/amd/display: Fix memory leak caused by missed dc_sink_release

Souptick Joarder (1):
      drm/mediatek: Convert drm_atomic_helper_suspend/resume()

Stu Hsieh (14):
      drm/mediatek: add connection from RDMA0 to DPI1
      drm/mediatek: add connection from RDMA0 to DSI1
      drm/mediatek: add connection from RDMA1 to DSI0
      drm/mediatek: add connection from RDMA2 to DSI0
      drm/mediatek: add memory mode and layer_config for RDMA
      drm/mediatek: add RGB color format support for RDMA
      drm/mediatek: add the comment about color format setting for OVL
      drm/mediatek: add YUYV/UYVY color format support for RDMA
      drm/mediatek: add function to get layer number for component
      drm/mediatek: add function to return OVL layer number
      drm/mediatek: add function to return RDMA layer number
      drm/mediatek: use layer_nr function to get layer number to init plane
      drm/mediatek: update some variable name from ovl to comp
      drm/mediatek: fix connection from RDMA2 to DSI1

Thomas Zimmermann (1):
      drm/mediatek: Replace drm_dev_unref with drm_dev_put

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix glk/cnl display w/a #1175

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             | 47 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |  8 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             | 35 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              | 11 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |  9 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              | 16 +---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              | 16 +---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              | 16 +---
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c                | 49 +++++++-----
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |  3 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   | 12 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  6 +-
 drivers/gpu/drm/i915/i915_vma.c                    |  4 -
 drivers/gpu/drm/i915/intel_audio.c                 |  3 -
 drivers/gpu/drm/i915/intel_display.c               |  7 +-
 drivers/gpu/drm/i915/intel_hdmi.c                  |  8 +-
 drivers/gpu/drm/i915/intel_lspcon.c                |  2 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            | 11 +++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c           | 92 ++++++++++++++++++=
++++
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            | 47 ++++++-----
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h            |  3 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 18 ++++-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  9 +++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             | 27 +++----
 26 files changed, 303 insertions(+), 161 deletions(-)
