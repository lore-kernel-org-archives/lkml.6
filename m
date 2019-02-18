Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8192BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5C1218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1O0vn34J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfBREnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 23:43:43 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:49901 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfBREnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 23:43:43 -0500
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x1I4hMfP005648;
        Mon, 18 Feb 2019 13:43:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x1I4hMfP005648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550465003;
        bh=xsUZFvL5CTUDGQrfaNZH+zG2OPJPifptmxt30v8BUlA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1O0vn34Jpe58f2bWdd2/ru2W91NiMQKYy9CH73VR2Iqh3dFqdlRlYAHZU5Nxbt1Jn
         FtBmudNXx8UwxrkvfkD8reG6eoHLoYlkj5O2tJsvsYFF6Fi+Ny3oPl2hcIak8o+CWJ
         QqSnhvuzp3RzYYeFSOJLM0gncd4G8fU1gN9ISTwLlwX0vkZ5jWo38XYN5xg/FbPIHd
         lILqh5O1qWX0MsezkswoHIcAgNrFjqX497g11SOeIyIgsOe5ZqoedvJLO51IP9/nP+
         10yRm3rHNJnYkoN2nRRB7G3pb3RMr7wZXIRcIIml8b4GbJV1w87yhZ2qFl3jp/yu1q
         YN93X5ByKtTEw==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id s15so5399534uap.6;
        Sun, 17 Feb 2019 20:43:23 -0800 (PST)
X-Gm-Message-State: AHQUAuYTCyHucP51jaq0IyI8HBzm4mD1VvJ2wc5yVnvY6vhF+YYKYn1n
        qmFGri0Im4e4dyutqzCL3r8OpFm9bbwqSAZCq9U=
X-Google-Smtp-Source: AHgI3IY/r1POG5nrvpxPTFLf2AMYCa0zDBbPhR46wUgJIO22wNFAE2rGet/QcCOJh49vjWk7iSJSfCUmZLFW49o+pjs=
X-Received: by 2002:ab0:648c:: with SMTP id p12mr6419793uam.93.1550465002431;
 Sun, 17 Feb 2019 20:43:22 -0800 (PST)
MIME-Version: 1.0
References: <1548906999-22143-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1548906999-22143-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 18 Feb 2019 13:42:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNARkmkQr7Q2rhdB0GVFnvSpspRkoM1f9+=ULJ9y-aXQ3NQ@mail.gmail.com>
Message-ID: <CAK7LNARkmkQr7Q2rhdB0GVFnvSpspRkoM1f9+=ULJ9y-aXQ3NQ@mail.gmail.com>
Subject: Re: [PATCH] drm: prefix header search paths with $(srctree)/
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>
Cc:     freedreno@lists.freedesktop.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Rob Clark <robdclark@gmail.com>, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        intel-gvt-dev@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 1:01 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Currently, the Kbuild core manipulates header search paths in a crazy
> way [1].
>
> To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
> the search paths in the srctree. Some Makefiles are already written in
> that way, but not all. The goal of this work is to make the notation
> consistent, and finally get rid of the gross hacks.
>
> Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
> ("kbuild: do not drop -I without parameter").
>
> [1]: https://patchwork.kernel.org/patch/9632347/
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Could you take a look at this series, please?

Thanks.





> I put all gpu/drm changes into a single patch because
> they are trivial conversion.
>
> Please let me know if I need to split this into per-driver patches.
>
>
>  drivers/gpu/drm/amd/amdgpu/Makefile | 2 +-
>  drivers/gpu/drm/amd/lib/Makefile    | 2 +-
>  drivers/gpu/drm/i915/gvt/Makefile   | 2 +-
>  drivers/gpu/drm/msm/Makefile        | 6 +++---
>  drivers/gpu/drm/nouveau/Kbuild      | 8 ++++----
>  5 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index f76bcb9..b21ebb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -23,7 +23,7 @@
>  # Makefile for the drm device driver.  This driver provides support for the
>  # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
>
> -FULL_AMD_PATH=$(src)/..
> +FULL_AMD_PATH=$(srctree)/$(src)/..
>  DISPLAY_FOLDER_NAME=display
>  FULL_AMD_DISPLAY_PATH = $(FULL_AMD_PATH)/$(DISPLAY_FOLDER_NAME)
>
> diff --git a/drivers/gpu/drm/amd/lib/Makefile b/drivers/gpu/drm/amd/lib/Makefile
> index 6902430..d534992 100644
> --- a/drivers/gpu/drm/amd/lib/Makefile
> +++ b/drivers/gpu/drm/amd/lib/Makefile
> @@ -27,6 +27,6 @@
>  # driver components or later moved to kernel/lib for sharing with
>  # other drivers.
>
> -ccflags-y := -I$(src)/../include
> +ccflags-y := -I $(srctree)/$(src)/../include
>
>  obj-$(CONFIG_CHASH) += chash.o
> diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
> index b016dc7..a4a5a96 100644
> --- a/drivers/gpu/drm/i915/gvt/Makefile
> +++ b/drivers/gpu/drm/i915/gvt/Makefile
> @@ -5,6 +5,6 @@ GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
>         execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debugfs.o \
>         fb_decoder.o dmabuf.o page_track.o
>
> -ccflags-y                              += -I$(src) -I$(src)/$(GVT_DIR)
> +ccflags-y                              += -I $(srctree)/$(src) -I $(srctree)/$(src)/$(GVT_DIR)/
>  i915-y                                 += $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
>  obj-$(CONFIG_DRM_I915_GVT_KVMGT)       += $(GVT_DIR)/kvmgt.o
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index 56a70c7..b7b1ebd 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> -ccflags-y := -Idrivers/gpu/drm/msm
> -ccflags-y += -Idrivers/gpu/drm/msm/disp/dpu1
> -ccflags-$(CONFIG_DRM_MSM_DSI) += -Idrivers/gpu/drm/msm/dsi
> +ccflags-y := -I $(srctree)/$(src)
> +ccflags-y += -I $(srctree)/$(src)/disp/dpu1
> +ccflags-$(CONFIG_DRM_MSM_DSI) += -I $(srctree)/$(src)/dsi
>
>  msm-y := \
>         adreno/adreno_device.o \
> diff --git a/drivers/gpu/drm/nouveau/Kbuild b/drivers/gpu/drm/nouveau/Kbuild
> index b17843d..b4bc88ad 100644
> --- a/drivers/gpu/drm/nouveau/Kbuild
> +++ b/drivers/gpu/drm/nouveau/Kbuild
> @@ -1,7 +1,7 @@
> -ccflags-y += -I$(src)/include
> -ccflags-y += -I$(src)/include/nvkm
> -ccflags-y += -I$(src)/nvkm
> -ccflags-y += -I$(src)
> +ccflags-y += -I $(srctree)/$(src)/include
> +ccflags-y += -I $(srctree)/$(src)/include/nvkm
> +ccflags-y += -I $(srctree)/$(src)/nvkm
> +ccflags-y += -I $(srctree)/$(src)
>
>  # NVKM - HW resource manager
>  #- code also used by various userspace tools/tests
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
