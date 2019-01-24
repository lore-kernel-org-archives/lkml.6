Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCAEC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C75120856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpRSvgaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfAXVyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:54:50 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:44761 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAXVyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:54:50 -0500
Received: by mail-qk1-f175.google.com with SMTP id o8so4275663qkk.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 13:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FyeYA2J6MSlQaqPr2ihpIQSderLwHn+EKe49T3JoCTo=;
        b=ZpRSvgaLSYX+2fVRwmjSZ4S2g1Lqm9gw6LrKMKjcWDoC4toslz96JjgH1VDw5d0CPJ
         EI5Uspr4h3XzJXEMf+l19BYtj+nf4fJ4P8VLpRRHxOVLvp8Ywp0ioiHoTp9jvSGLSYdS
         BgAeohnOIAho0GKsRgvVrox7dmm9ASMBrDoDD9M36/bd872KM4iH1yLLT4+Jkdtbwgaa
         No7AFnSaf9iOx7I9pnB0q1Vz2u2MOhbGrtXFnDGLlWxPVOuTzHvzoMlpSEKiSg/uL3+F
         9NiNHb8KsVVXDfM+b6t9m08CuZe1+uYFTw3ECyAPKRVPjPhMARKFUu7no8GyWb6EyeJr
         B+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FyeYA2J6MSlQaqPr2ihpIQSderLwHn+EKe49T3JoCTo=;
        b=Rlnoh03sjvDs66GF6IDkmmNAFfZVrKZrIvIZX3DquidQvXS//YetXCP+yqHd/SMtCg
         xNjPZ74RSj9n6SviP5Vk1RBo1Kx2XRwO1eyiXD/SrVVa59igGMy6Mp+x0POv+gvHI9Os
         FYCvfRVlhFXmsQ6rFLjQujqKGShM5PC9/FFT/vMDQMs46lZaxqInCkIVboXzWUw2Gajt
         vhbWBfb8XXxNNfWy6DoAXBa80j54rtM1q/i9lfpF3i7HQbLTac152ZqkgvMScdLEqw+u
         pbFMJB1m0QIAlT8IxgOsFg6Ibr5DD4ibj6qa8ivsMUxZzXDIRNKhxRct75kpThNp7r/6
         cGFg==
X-Gm-Message-State: AJcUukfE3so9rYc6r6dW1o4goLuGYGaGSCzM417dLLF5UUR4Cok50Z+d
        MibJUTrks58IRbcjFy2P+3rU0YolJA0EX6JmPSo=
X-Google-Smtp-Source: ALg8bN6wE97tpK3bMmKYcxROiweuIO+f6ujqgtdnG5zLRZ4b9WI6x9LW5cjeMZAkUr4FSnuX5MbQ4YtgQ7pbzcvVFaI=
X-Received: by 2002:a05:620a:136e:: with SMTP id d14mr7104258qkl.344.1548366888436;
 Thu, 24 Jan 2019 13:54:48 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 25 Jan 2019 07:54:37 +1000
Message-ID: <CAPM=9tzmQ+y1tN5FgM=wzutCt37nNKD4kf7P-RWGF6f+skGCOQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.0-rc4
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

Live from LCA pull, some fixes all over the place,

i915:
- GVT workload destruction fix

msm:
- A6XX opp-level fix, build fixes, hard-coded irq removal

amdgpu:
- overclocking fix
- hybrid gfx fix

sun4i:
- fix TMDS clock usage

Dave.

drm-fixes-2019-01-25-1:
drm fixes. msm, sun4i, amdgpu, i915 gvt
The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-01-25-1

for you to fetch changes up to f0e7ce1eef5854584dfb59b3824a67edee37580f:

  Merge tag 'drm-msm-fixes-2019-01-24' of
git://people.freedesktop.org/~robclark/linux into drm-fixes
(2019-01-25 07:45:00 +1000)

----------------------------------------------------------------
drm fixes. msm, sun4i, amdgpu, i915 gvt

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu: Add APTX quirk for Lenovo laptop

Arnd Bergmann (2):
      drm/msm/gpu: fix building without debugfs
      drm/msm: avoid unused function warning

Chris Wilson (1):
      drm/i915/execlists: Mark up priority boost on preemption

Dave Airlie (4):
      Merge tag 'drm-misc-fixes-2019-01-24' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'drm-fixes-5.0' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2019-01-24' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-msm-fixes-2019-01-24' of
git://people.freedesktop.org/~robclark/linux into drm-fixes

Douglas Anderson (1):
      drm/msm: Fix A6XX support for opp-level

Jani Nikula (1):
      Merge tag 'gvt-fixes-2019-01-24' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Joe Perches (1):
      drm/msm: Add __printf verification

Jordan Crouse (2):
      drm/msm/gpu: Remove hardcoded interrupt name
      drm/msm: drop interrupt-names

Kenneth Feng (1):
      drm/amd/powerplay: OD setting fix on Vega10

Kristian H. Kristensen (1):
      drm/msm: Unblock writer if reader closes file

Priit Laes (1):
      drm/sun4i: hdmi: Fix usage of TMDS clock

Rob Clark (1):
      drm/msm: honor GPU_READONLY flag

Weinan Li (1):
      drm/i915/gvt: release shadow batch buffer and wa_ctx before
destroy one workload

 .../devicetree/bindings/display/msm/gpu.txt        |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |  1 +
 .../amd/powerplay/hwmgr/vega10_processpptables.c   | 22 +++++++++++++++++-
 drivers/gpu/drm/i915/gvt/scheduler.c               | 11 ++++-----
 drivers/gpu/drm/i915/intel_lrc.c                   |  4 ++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |  1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          | 26 +++++++++++-----------
 drivers/gpu/drm/msm/msm_drv.h                      |  6 ++++-
 drivers/gpu/drm/msm/msm_gem.c                      |  8 +++++--
 drivers/gpu/drm/msm/msm_gem_vma.c                  |  5 +++--
 drivers/gpu/drm/msm/msm_gpu.c                      |  2 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |  3 +--
 drivers/gpu/drm/msm/msm_rd.c                       |  7 +++++-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |  4 ++++
 15 files changed, 72 insertions(+), 31 deletions(-)
