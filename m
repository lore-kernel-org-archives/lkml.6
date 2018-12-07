Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0442C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6D420989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMPOToPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6D420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbeLGBhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:37:22 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40685 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGBhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:37:21 -0500
Received: by mail-qt1-f193.google.com with SMTP id k12so2845402qtf.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 17:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=whCQIV3jy/Pu/FFHqu91gtGYgPIhyMz9WifZv5Kq0mY=;
        b=AMPOToPilATDVo1V1Bd6kGTmI8Xi8Q/9bOrrEsB723TU4mmqs2vkmFL1qU1HBvrNAG
         1Dc3kdDqwDMj/x3qqa2TwHi9eLaggwS5ilC6tl6EkEDxA+4CRBdyy959oli5WPY+mn00
         agpPjVCHbYfi3rIFfpIh0fr3aj/v17KsafB6WrtnRU/0CMqKYP4dcy2TD9a5WFaNHyp4
         vPsoAQBoBcEi97JMZBvCG9hJAImKP9XIIBmNp0nze3HEXUxwVjmRWV6popyWkWAKb+6S
         LzpQ77qA7u1zaZnZjYta6SF9bVxKRMUXKG1Hrcq+KU/B4a4DZV6qr6In7sTdt1IG/iTE
         RVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=whCQIV3jy/Pu/FFHqu91gtGYgPIhyMz9WifZv5Kq0mY=;
        b=SqwrTgwLgbVs7oK6/UQkDeIsMgaLWTnlN+mBoAfgobjKdBMj/KeGNsiYZFpAWSR2xl
         4F0GcFHsD+SxHKW41zH2elvlffI6wclCutV0nCQ/1PyegcFKQaTzsu3R/5k6oc7D0l6Q
         /g1FedQfZNFSojisENmvEQ3RM27vETjsKX9HDkpG0RGbcYSAg9uA25B2Bcqx/HVdxB2L
         NfF0+fBIc/xy5VX1PSGLg7fqUz/iXQafMynDuHSmYfQQniEBI/EduE57EVi8bT2e3jX4
         UcPjU8Y/zhYPLXL+0onG7IUk5lzcbk3+ozHOJabWZCpvj/CuWPXUK36JhCznX+nsk0VA
         LPUQ==
X-Gm-Message-State: AA+aEWZDPsUt0/khSegcLLmXqY8/oet+BcBZ28Oc56+eDzmZu0ZuRSag
        y3fkivyaO4A1xf6DPMTUCoxqts3s9lDCgEiVx80=
X-Google-Smtp-Source: AFSGD/XhtS4INqaS5RCZJYYOuB5XO4989oipZ4AX2Fq/bO+3nli/YBbqHd0e7exJCGIjbFhrqxJ7Ivqy9NZCPv34v/0=
X-Received: by 2002:ac8:296a:: with SMTP id z39mr267008qtz.264.1544146640284;
 Thu, 06 Dec 2018 17:37:20 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 7 Dec 2018 11:37:08 +1000
Message-ID: <CAPM=9txWWa2v25-XOU88w99EOS1VdSyLT834HaG0izSX6RQJ_g@mail.gmail.com>
Subject: [git pull] drm fixes for 4.20-rc6
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

This is the regular fixes pull. I'm off on holidays for a few days but
will likely still have access to stuff, just not doing much else, I
should be back for 2 days at the end of next week to line up more
fixes, and likely send you the -next pull request before going on
holidays until after boxing day.

There's a bit more in here than I'd like, and I'm hoping things calm
down when I'm out.

msm: a bunch of display fixes for the new DPU, and a couple of command
submission fixes
omap: some DSI fixes
ast: driver unload crash fix
core: fix the lease uevent so userspace can distinguish it
amd: fix a bpc regression, lru handling regression, fixed firmware
support for new GPUs, power management fixes for vega20.

Thanks,
Dave.

drm-fixes-2018-12-07:
ast, msm display fixes, amdgpu fixes, lease fix, omap fixes
The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7=
:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-12-07

for you to fetch changes up to e594a5e349ddbfdaca1951bb3f8d72f3f1660d73:

  drm/ast: Fix connector leak during driver unload (2018-12-06 14:12:02 +10=
00)

----------------------------------------------------------------
ast, msm display fixes, amdgpu fixes, lease fix, omap fixes

----------------------------------------------------------------
Abhinav Kumar (1):
      drm/msm/dsi: configure VCO rate for 10nm PLL driver

Alex Deucher (3):
      drm/amdgpu: add VCN JPEG support amdgpu_ctx_num_entities
      drm/amdgpu/gmc8: update MC firmware for polaris
      drm/amdgpu/gmc8: always load MC firmware in the driver

Christian K=C3=B6nig (2):
      drm/ttm: fix LRU handling in ttm_buffer_object_transfer
      drm/amdgpu: wait for IB test on first device open

Dan Carpenter (1):
      drm/msm/gpu: Fix a couple memory leaks in debugfs

Daniel Vetter (1):
      drm/lease: Send a distinct uevent

Dave Airlie (3):
      Merge tag 'msm-fixes-2018-12-04' of
https://gitlab.freedesktop.org/seanpaul/dpu-staging into drm-fixes
      Merge branch 'drm-fixes-4.20' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2018-12-05' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Evan Quan (3):
      drm/amd/powerplay: support new pptable upload on Vega20
      drm/amd/powerplay: issue pre-display settings for display change even=
t
      drm/amd/powerplay: support SoftMin/Max setting for some specific DPM

James Zhu (1):
      drm/amdgpu/vcn: Update vcn.cur_state during suspend

Jayant Shekhar (1):
      drm/msm/dpu: Ignore alpha for XBGR8888 format

Jeykumar Sankaran (1):
      drm/msm: validate display and event threads

Jordan Crouse (1):
      drm/msm/gpu: Don't map command buffers with nr_relocs equal to 0

Junwei Zhang (1):
      drm/amdgpu: update mc firmware image for polaris12 variants

Nicholas Kazlauskas (2):
      drm/amd/display: Fix unintialized max_bpc state values
      drm/amd/display: Fix overflow/truncation from strncpy.

Rob Clark (1):
      drm/msm: fix handling of cmdstream offset

Robert Foss (1):
      drm/msm: Move fence put to where failure occurs

Roman Li (1):
      drm/amd/display: Fix 6x4K displays light-up on Vega20 (v2)

Sam Bobroff (1):
      drm/ast: Fix connector leak during driver unload

Sandeep Panda (1):
      drm/bridge: fix AUX_CMD_SEND bit value for ti, sn65dsi86 bridge

Sean Paul (2):
      drm/msm: Grab a vblank reference when waiting for commit_done
      drm/msm: dpu: Don't set legacy plane->crtc pointer

Sebastian Reichel (2):
      drm/omap: populate DSI platform bus earlier
      drm/omap: fix incorrect union usage

Sharat Masetty (2):
      drm/msm: Check if target supports crash dump capture
      drm/msm: Fix task dump in gpu recovery

Todor Tomov (1):
      drm/msm/hdmi: Enable HPD after HDMI IRQ is set up

Tomi Valkeinen (1):
      drm/omap: fix bus_flags for panel-dpi

Wei Yongjun (1):
      drm/fb-helper: Fix typo in parameter description

Wen Yang (1):
      drm/msm: Fix error return checking

YueHaibing (2):
      drm/msm/hdmi: Drop pointless static qualifier in msm_hdmi_bind()
      drm/msm: dpu: Fix "WARNING: invalid free of devm_ allocated data"

tianci yin (1):
      drm/amd/powerplay: improve OD code robustness

wentalou (1):
      drm/amdgpu: enlarge maximum waiting time of KIQ

 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  6 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              | 44 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |  3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  8 +--
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  2 +
 .../gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c  |  4 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        |  3 ++
 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c       |  2 -
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 12 +++--
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 12 +++--
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 54 ++++++++++++------=
--
 drivers/gpu/drm/ast/ast_fb.c                       |  1 +
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |  2 +-
 drivers/gpu/drm/drm_fb_helper.c                    |  2 +-
 drivers/gpu/drm/drm_internal.h                     |  2 +
 drivers/gpu/drm/drm_lease.c                        |  2 +-
 drivers/gpu/drm/drm_sysfs.c                        | 10 ++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |  1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  2 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c        |  2 +-
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c         |  4 +-
 drivers/gpu/drm/msm/hdmi/hdmi.c                    |  8 ++-
 drivers/gpu/drm/msm/hdmi/hdmi.h                    |  1 +
 drivers/gpu/drm/msm/hdmi/hdmi_connector.c          | 10 +---
 drivers/gpu/drm/msm/msm_atomic.c                   |  5 ++
 drivers/gpu/drm/msm/msm_debugfs.c                  | 15 ++++--
 drivers/gpu/drm/msm/msm_drv.c                      | 49 ++++++------------
 drivers/gpu/drm/msm/msm_gem_submit.c               | 18 ++++---
 drivers/gpu/drm/msm/msm_gpu.c                      | 13 +++--
 drivers/gpu/drm/msm/msm_iommu.c                    |  2 +-
 drivers/gpu/drm/msm/msm_rd.c                       |  5 +-
 drivers/gpu/drm/omapdrm/displays/panel-dpi.c       |  1 +
 drivers/gpu/drm/omapdrm/dss/dsi.c                  | 20 ++++----
 drivers/gpu/drm/omapdrm/dss/omapdss.h              |  2 +-
 drivers/gpu/drm/omapdrm/omap_encoder.c             | 58 ++++++++++++------=
----
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |  4 +-
 38 files changed, 235 insertions(+), 157 deletions(-)
