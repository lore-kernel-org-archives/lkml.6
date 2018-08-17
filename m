Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7999C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 00:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4017D20898
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 00:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWBplW8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4017D20898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbeHQEAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 00:00:17 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37491 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeHQEAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 00:00:17 -0400
Received: by mail-qt0-f195.google.com with SMTP id n6-v6so7034776qtl.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 17:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=g1bVL9WTbGceeafQaB2n3m0UaYdUuDXpdeA+N/6qA1E=;
        b=OWBplW8GacSdi4y19xKWuQHX3sY5FX+fSmxK5uwCA5s4hkTnlr0X/S7djMjqYGzxoD
         DFfFdqI9rpHJkwiRGI8WBAfemxhEFsCe7OYxOrxhMwT56rWytOy6iOoX5Fw8OQFro+Ka
         gw4TiJ7vvEMU6/0+j5fcad3Wbv+CmDuloH9Xt/1wl2eh/tCJmOf8CQy9Spu1gr1ciS1Q
         luBehXpdQ47gg6vyaTB2laCjngpYU855Y14/lGyDVXQq26dGSd71pr7wj6Z4VbVu1i1j
         49yt3hcfGhILSho4BYruRZ9S8VMDgKVSK33LEU6MytlBXtg5KgwOZ0xiIGsySqGJo7Oe
         Mazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=g1bVL9WTbGceeafQaB2n3m0UaYdUuDXpdeA+N/6qA1E=;
        b=hZbVru50uCapG+ptHAqAeBvPjF9Tc019wSWjhm+stXehv8V7wfA58Bk183oQ1ANIxB
         X4UVhxYCg0FviOoqq/blyAWj5+ZurpM+oBlrfSUiQD1woSAbpSwgpYlUsLB6UQwp+SiO
         SEDvB2sM3V3+WVEPKuLtDSD+0AP8uPmbdzaruJ3LAwiG3NH6MOrKD+LpQtpq+fzEUUfh
         G3SoE4WK0JhfmT5zxsFtC+j6kcBy52DLKIbspCuSX5t9OwQMUVK5aoSNwZWQCFiG9s57
         D4uMoNJLhA/LR5m07ocZJobBnuvpYPWmr3G0wxYDNvY/En6B+V5leZxIA52o7LbWsNrW
         jr5g==
X-Gm-Message-State: AOUpUlG6s6kLhNXavHZVT+jI8WDoAckjbcz53GKTsbUiS11OPjcJGfkQ
        gg5UmsIQqybTghQK2aqRzfnDohtPv87b2GXVlHbx1w==
X-Google-Smtp-Source: AA+uWPw66SHprtiycrLI3He+VFWQ46olsUcok+yR9bK2oFJpwbw0dhMraGURJnMkS0452gL+PdE2Q8LEt2Vk3np3i8o=
X-Received: by 2002:a0c:b888:: with SMTP id y8-v6mr29230264qvf.203.1534467541503;
 Thu, 16 Aug 2018 17:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tz8qrm7vSsynat_L6YKZjvY8FtOoZt5QjrVKcsO-2wJeg@mail.gmail.com>
In-Reply-To: <CAPM=9tz8qrm7vSsynat_L6YKZjvY8FtOoZt5QjrVKcsO-2wJeg@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 17 Aug 2018 10:58:49 +1000
Message-ID: <CAPM=9tymhXaNAzQE+g7u3A7NS0Lq6b3bg1+ZD7NxNxan3Jrn6A@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 4.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oops just forgot to cc lists.

Dave.
On Fri, 17 Aug 2018 at 10:42, Dave Airlie <airlied@gmail.com> wrote:
>
> Hi Linus,
>
> First round of fixes for -rc1. I'll follow this up with the msm new hw
> support PR.
>
> This just has three sets of fixes, some for msm before the new hw, a bunc=
h of
> AMD fixes (includiing some required firmware changes for new hw), and a s=
et
> of i915 (+gvt) fixes.
>
> Thanks,
> Dave.
>
> drm-next-2018-08-17:
> msm, i915 and amdgpu fixes
> The following changes since commit 557ce95051c8eff67af48612ab350d8408aa05=
41:
>
>   Merge branch 'drm-next-4.19' of
> git://people.freedesktop.org/~agd5f/linux into drm-next (2018-08-10
> 11:43:02 +1000)
>
> are available in the Git repository at:
>
>   git://anongit.freedesktop.org/drm/drm tags/drm-next-2018-08-17
>
> for you to fetch changes up to 0258d7a5e261b3ce0d730f6f8f66f833058ce2b6:
>
>   Merge tag 'drm-intel-next-fixes-2018-08-16-1' of
> git://anongit.freedesktop.org/drm/drm-intel into drm-next (2018-08-17
> 10:33:48 +1000)
>
> ----------------------------------------------------------------
> msm, i915 and amdgpu fixes
>
> ----------------------------------------------------------------
> Charlene Liu (1):
>       drm/amd/display: fix single link DVI has no display
>
> Chris Wilson (3):
>       drm/i915: Unmask user interrupts writes into HWSP on snb/ivb/vlv/hs=
w
>       drm/i915: Restore user forcewake domains across suspend
>       drm/i915/selftests: Hold rpm for unparking
>
> Colin Ian King (1):
>       drm/msm/disp/dpu: fix two spelling mistakes
>
> Dan Carpenter (2):
>       drm/i915/kvmgt: fix an error code in gvt_dma_map_page()
>       drm/i915/gvt: Off by one in intel_vgpu_write_fence()
>
> Dave Airlie (3):
>       Merge tag 'drm-msm-fixes-2018-08-10' of
> git://people.freedesktop.org/~robclark/linux into drm-next
>       Merge branch 'drm-next-4.19' of
> git://people.freedesktop.org/~agd5f/linux into drm-next
>       Merge tag 'drm-intel-next-fixes-2018-08-16-1' of
> git://anongit.freedesktop.org/drm/drm-intel into drm-next
>
> Emily Deng (2):
>       drm/amdgpu/uvd: UVD entity initialization relys on ring initializat=
ion
>       drm/amdgpu/vce: VCE entity initialization relies on ring initializt=
ion
>
> Gustavo A. R. Silva (1):
>       drm/i915/kvmgt: Fix potential Spectre v1
>
> Hang Yuan (3):
>       drm/i915/gvt: free workload in vgpu release
>       drm/i915/gvt: fix cleanup sequence in intel_gvt_clean_device
>       drm/i915/gvt: initialize dmabuf mutex in vgpu_create
>
> James Zhu (2):
>       drm/amdgpu:add tmr mc address into amdgpu_firmware_info
>       drm/amdgpu: update tmr mc address
>
> Jani Nikula (1):
>       drm/i915: set DP Main Stream Attribute for color range on DDI platf=
orms
>
> Jerry (Fangzhi) Zuo (1):
>       drm/amd/display: Fix warning observed in mode change on Vega
>
> Jeykumar Sankaran (1):
>       drm/msm/disp/dpu: fix early dereference of physical encoder
>
> Kees Cook (1):
>       drm/msm/adreno: Remove VLA usage
>
> Likun Gao (3):
>       drm/amdgpu:add new firmware id for VCN
>       drm/amdgpu:add VCN support in PSP driver
>       drm/amdgpu:add VCN booting with firmware loaded by PSP
>
> Michel D=C3=A4nzer (1):
>       drm/amdgpu: Use kvmalloc for allocating UVD/VCE/VCN BO backup memor=
y
>
> Mikita Lipski (3):
>       drm/amd/display: Allow clock sharing b/w HDMI and DVI
>       drm/amd/display: Check if clock source in use before disabling
>       drm/amd/display: Pass connector id when executing VBIOS CT
>
> Nicholas Kazlauskas (1):
>       drm/amd/display: Guard against null crtc in CRC IRQ
>
> Rodrigo Vivi (1):
>       Merge tag 'gvt-next-fixes-2018-08-14' of
> https://github.com/intel/gvt-linux into drm-intel-next-fixes
>
> Souptick Joarder (1):
>       gpu: drm: msm: Change return type to vm_fault_t
>
> Yi Wang (1):
>       drm/i915/gvt: fix memory leak in intel_vgpu_ioctl()
>
> Zhao Yan (1):
>       drm/i915/gvt: return error on cmd access
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  5 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |  4 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            | 38 ++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h            |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            | 33 +++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h            |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            | 23 +++++-----
>  drivers/gpu/drm/amd/amdgpu/psp_v10_0.c             |  3 ++
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              |  4 ++
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |  4 ++
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |  2 +
>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |  5 +++
>  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c              |  2 +
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |  2 +
>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c              | 10 ++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              | 40 +++++++++++++---=
-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  | 10 ++++-
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  2 +
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c  | 50 +++++++++++++++-=
------
>  .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |  4 +-
>  .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  4 +-
>  .../display/dc/dce120/dce120_timing_generator.c    |  2 +-
>  drivers/gpu/drm/amd/display/dc/inc/resource.h      |  5 +++
>  drivers/gpu/drm/i915/gvt/aperture_gm.c             |  2 +-
>  drivers/gpu/drm/i915/gvt/cmd_parser.c              |  2 +-
>  drivers/gpu/drm/i915/gvt/gvt.c                     | 15 +++----
>  drivers/gpu/drm/i915/gvt/gvt.h                     |  4 +-
>  drivers/gpu/drm/i915/gvt/kvmgt.c                   | 26 +++++++----
>  drivers/gpu/drm/i915/gvt/scheduler.c               |  7 +--
>  drivers/gpu/drm/i915/gvt/scheduler.h               |  3 ++
>  drivers/gpu/drm/i915/gvt/vgpu.c                    | 23 +++++++++-
>  drivers/gpu/drm/i915/i915_reg.h                    |  1 +
>  drivers/gpu/drm/i915/intel_ddi.c                   |  4 ++
>  drivers/gpu/drm/i915/intel_ringbuffer.c            | 14 +++++-
>  drivers/gpu/drm/i915/intel_uncore.c                | 46 +++++++++++-----=
----
>  drivers/gpu/drm/i915/intel_uncore.h                |  1 +
>  drivers/gpu/drm/i915/selftests/i915_gem_object.c   | 20 ++++++---
>  drivers/gpu/drm/i915/selftests/intel_uncore.c      |  2 +-
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |  7 ++-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c            | 28 ++++++++----
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  6 ++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c   |  2 +-
>  drivers/gpu/drm/msm/msm_drv.h                      |  2 +-
>  drivers/gpu/drm/msm/msm_gem.c                      | 33 +++++---------
>  44 files changed, 346 insertions(+), 156 deletions(-)
