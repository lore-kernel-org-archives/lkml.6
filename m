Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145EDC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA5F240BE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myqWMzGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA5F240BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753852AbeGFBcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 21:32:10 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:41241 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753801AbeGFBcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 21:32:05 -0400
Received: by mail-qt0-f176.google.com with SMTP id y20-v6so8772689qto.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 18:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=hP8gLR+rXQwVLxhW9nJglnnST6SF/XqJGv98dAzuuZ8=;
        b=myqWMzGYUdM/1aedBtJsF5IGPcvByKLB2zHExnnJUlwN0onnRWqB59xgaifb1sOhLx
         QzCSqSs458w9lF9t09WNjRLqmfgImAkDhOUwMn2TPyOWdeoHg7nbqCpSjLXD9GMCOXhC
         49SWwzYeIPDjOgYh6XeYVRvfPUghnSfPVNjz+9QJnHWhicEq7dCSd9JxBjdls1puLkVJ
         cUoTBYd6V82kd+LWqkvqyfnuH3mgXyUXXBOiF8C9DAIhNfubcPrEBXM+mkdmth0nkoR6
         BsSeI2TZyrxzkvwpXRhnwC/ZB+c/nDEw2yYtKFBYPsIcynoAes0BHlYpgXFUoz2dMuDX
         xJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=hP8gLR+rXQwVLxhW9nJglnnST6SF/XqJGv98dAzuuZ8=;
        b=Y2Wq5vbTEvNzksFdqk7ac3NSrdzvjDspqK20QO+JFWo/q0vxR0/yjhEfbUjEDQJQM3
         ZkvODyjeFaNVG6Td0Wjbo3n5iWQhrJFMkpaoTm7/jWrqz3pVY6cbp/h7hXhDb0MG0xwK
         YmfsSTA5w2ylF3QQRAYcf53jy3trNugyTbA5cZ5QkNii7TAAWtrPkU5uEFI3XaN1UHG1
         SPW2mCzkkkPCyWdWVVWUqABYjSoSrD81qu7Sm/73N90Q10DYB03PlKmI9Vg8W/S7yG6z
         xGUvmlV2l2k+YaLXNUeCDnLN38yKG4GMqrGEGueh74LK/osvN/Hqwbx9mS+oETExkrsN
         y/vA==
X-Gm-Message-State: APt69E02Ini2Dypn0GydLaZEGi787RtAEDG+3+AatdjxqxDoapYInB6R
        7rF+SdQ/lR1z7pFzHAdmgCuis2SiNmPrEoKaaNQ=
X-Google-Smtp-Source: AAOMgpcNRyWKQv3k/7qAPQ/GFHFfLw4JW1Vcuu/Wq8xJpyuaktjlce/EuQN8f0YENYzgSk4onuXMns5CFVQaUwZUMz0=
X-Received: by 2002:ac8:6648:: with SMTP id j8-v6mr7583419qtp.254.1530840724784;
 Thu, 05 Jul 2018 18:32:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:1e87:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 18:32:04 -0700 (PDT)
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 6 Jul 2018 11:32:04 +1000
Message-ID: <CAPM=9tw9eCXXbY4V2+G1Mt3MWnGmM6ZnkbKPPA+Bo3Eso6su1g@mail.gmail.com>
Subject: [git pull] drm-fixes for 4.18-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh wow not my day, this one ended up with no subject.

On 6 July 2018 at 11:26, Dave Airlie <airlied@gmail.com> wrote:
> Hi Linus, (apologies for blank body pull earlier)
>
> This is the drm fixes for rc4. It's a bit larger than I'd like but the
> exynos cleanups are pretty mechanical, and I'd rather have them in
> sooner rather than later so we can avoid too much conflicts around
> them. The non-mechanincal exynos changes are mostly fixes for new
> feature recently introduced.
>
> i915:
>     GVT and GGTT mapping fixes
>
> amdgpu:
>     HDMI2.0 4K@60 Hz regression
>     Hotplug fixes for dual-GPU laptops to make power management better
>     Misc vega12 bios fixes, a race fix and some typos.
>
> sii8620 bridge: small fixes around mode setting
>
> core: use kvzalloc to allocate blob property memory.
>
> If the exynos changes are too much, I'm happy to push back, and the
> blank pull was thanks to baby induced sleep deprivation, fat fingers
> and gmail.
>
> Thanks,
> Dave.
>
> drm-fixes-2018-07-06:
> amdgpu, i915, exynos, udl, sii8620 and core fixes
> The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb60=
63:
>
>   Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)
>
> are available in the Git repository at:
>
>   git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-07-06
>
> for you to fetch changes up to c78d1f9d95a9f2cd5546c64f5315f54681dd6055:
>
>   Merge tag 'exynos-drm-fixes-for-v4.18-rc4' of
> git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into
> drm-fixes (2018-07-06 10:47:02 +1000)
>
> ----------------------------------------------------------------
> amdgpu, i915, exynos, udl, sii8620 and core fixes
>
> ----------------------------------------------------------------
> Alex Deucher (2):
>       drm/amdgpu: fix swapped emit_ib_size in vce3
>       drm/amdgpu/pm: fix display count in non-DC path
>
> Andrzej Pietrasiewicz (1):
>       drm/exynos: scaler: Reset hardware before starting the operation
>
> Chris Wilson (1):
>       drm/i915: Try GGTT mmapping whole object as partial
>
> Dave Airlie (4):
>       Merge tag 'drm-misc-fixes-2018-07-05' of
> git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
>       Merge tag 'drm-intel-fixes-2018-07-05' of
> git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
>       Merge branch 'drm-fixes-4.18' of
> git://people.freedesktop.org/~agd5f/linux into drm-fixes
>       Merge tag 'exynos-drm-fixes-for-v4.18-rc4' of
> git://git.kernel.org/.../daeinki/drm-exynos into drm-fixes
>
> Evan Quan (3):
>       drm/amd/powerplay: correct vega12 thermal support as true
>       drm/amd/powerplay: correct vega12 bootup values settings
>       drm/amd/powerplay: smc_dpm_info structure change
>
> Jani Nikula (1):
>       Merge tag 'gvt-fixes-2018-07-03' of
> https://github.com/intel/gvt-linux into drm-intel-fixes
>
> Lyude Paul (3):
>       drm/amdgpu: Make struct amdgpu_atif private to amdgpu_acpi.c
>       drm/amdgpu: Add amdgpu_atpx_get_dhandle()
>       drm/amdgpu: Dynamically probe for ATIF handle (v2)
>
> Maciej Purski (3):
>       drm/bridge/sii8620: Send AVI infoframe in all MHL versions
>       drm/bridge/sii8620: Fix display of packed pixel modes
>       drm/bridge/sii8620: Fix link mode selection
>
> Marek Szyprowski (10):
>       drm/exynos: ipp: Rework checking for the correct buffer formats
>       drm/exynos: rotator: Fix DRM_MODE_REFLECT_{X,Y} interpretation
>       drm/exynos: scaler: Fix support for YUV420, YUV422 and YUV444 modes
>       drm/exynos: gsc: Use real buffer width for configuring the hardware
>       drm/exynos: gsc: Increase Exynos5433 buffer width alignment to 16 p=
ixels
>       drm/exynos: gsc: Fix DRM_MODE_REFLECT_{X,Y} interpretation
>       drm/exynos: gsc: Fix support for NV16/61, YUV420/YVU420 and YUV422 =
modes
>       drm/exynos: fimc: Use real buffer width for configuring the hardwar=
e
>       drm/exynos: decon5433: Fix per-plane global alpha for XRGB modes
>       drm/exynos: decon5433: Fix WINCONx reset value
>
> Michel D=C3=A4nzer (1):
>       drm: Use kvzalloc for allocating blob property memory
>
> Mikita Lipski (2):
>       drm/amd/display: adding ycbcr420 pixel encoding for hdmi
>       drm/amd/display: add a check for display depth validity
>
> Mikulas Patocka (1):
>       drm/udl: fix display corruption of the last line
>
> Nicolai H=C3=A4hnle (1):
>       drm/amdgpu: fix user fence write race condition
>
> Stefan Agner (1):
>       drm/exynos: ipp: use correct enum type
>
> Thomas Zimmermann (3):
>       drm/exynos: Replace drm_framebuffer_{un/reference} with put,get fun=
ctions
>       drm/exynos: Replace drm_gem_object_unreference_unlocked with put fu=
nction
>       drm/exynos: Replace drm_dev_unref with drm_dev_put
>
> Xiaolin Zhang (1):
>       drm/i915/gvt: changed DDI mode emulation type
>
> Zhao Yan (1):
>       drm/i915/gvt: fix a bug of partially write ggtt enties
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  46 ++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           | 131 +++++++++++++++=
++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |  12 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |   2 +-
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |   4 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  49 +++++++-
>  drivers/gpu/drm/amd/include/atomfirmware.h         |   5 +-
>  drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c |  96 +++++++++++++--
>  drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h |   5 +
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c |   4 +
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h |   3 +
>  .../amd/powerplay/hwmgr/vega12_processpptables.c   |   2 +
>  .../drm/amd/powerplay/inc/vega12/smu9_driver_if.h  |   5 +-
>  drivers/gpu/drm/bridge/sil-sii8620.c               |  86 +++++++++-----
>  drivers/gpu/drm/drm_property.c                     |   6 +-
>  drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |   6 +-
>  drivers/gpu/drm/exynos/exynos_drm_drv.c            |   4 +-
>  drivers/gpu/drm/exynos/exynos_drm_fb.c             |   2 +-
>  drivers/gpu/drm/exynos/exynos_drm_fimc.c           |  17 +--
>  drivers/gpu/drm/exynos/exynos_drm_gem.c            |  10 +-
>  drivers/gpu/drm/exynos/exynos_drm_gsc.c            |  51 ++++----
>  drivers/gpu/drm/exynos/exynos_drm_ipp.c            | 110 +++++++++------=
--
>  drivers/gpu/drm/exynos/exynos_drm_plane.c          |   2 +-
>  drivers/gpu/drm/exynos/exynos_drm_rotator.c        |   4 +-
>  drivers/gpu/drm/exynos/exynos_drm_scaler.c         |  44 +++++--
>  drivers/gpu/drm/exynos/regs-gsc.h                  |   1 +
>  drivers/gpu/drm/i915/gvt/display.c                 |   6 +-
>  drivers/gpu/drm/i915/gvt/gtt.c                     |  58 +++++++++
>  drivers/gpu/drm/i915/gvt/gtt.h                     |   2 +
>  drivers/gpu/drm/i915/i915_gem.c                    |  28 +++--
>  drivers/gpu/drm/i915/i915_vma.c                    |   2 +-
>  drivers/gpu/drm/udl/udl_fb.c                       |   5 +-
>  drivers/gpu/drm/udl/udl_transfer.c                 |  11 +-
>  34 files changed, 583 insertions(+), 242 deletions(-)
