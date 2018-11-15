Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDECC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA2B2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koblLxjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA2B2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388986AbeKPJNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:13:55 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40359 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeKPJNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 04:13:54 -0500
Received: by mail-qk1-f196.google.com with SMTP id y16so34600038qki.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 15:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=E4bTCOaBukLLwTGLqnLQyHxgimfJr5f6wqhB1DQXMk0=;
        b=koblLxjvsOszEx4CCrrvR4tdZJ3K8nAYP5ZL2MQUpOUGKL9IpiQYJwMihdgp/mHrZc
         PgXUH022rQNfZlOCkVuvGR6rcAZUJEHG555yjEwujEWBNESZOtHJHJponwbAq4w/jyMe
         TP6wUNOke3eY/SPpmMXNsVsVp9QT2m+Tn4CJ7ih17xq4ycrFoa/rHI12glYrYOsJUlmA
         eNoVBWTZ4EK2S57GhyFfHKhN26Rj0HWvLD8DAYMvQOAooX23MeOdhuWq74XWYFCFbx4G
         uFwSout0ErmymFqXxO+m1peNcQ7LmaYovJOASN5iXV2zYsXVJ5j2zJcv9wbNlRiZIKpS
         OeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=E4bTCOaBukLLwTGLqnLQyHxgimfJr5f6wqhB1DQXMk0=;
        b=DjwjYIUnu+UIQZZx9cRpTWyxD6LIAwirF/4Nn1ShV2++KtmQrQAdXrsKUqfF3dbyKa
         EIET+NR3aZv0PmHS66DobIisUH1kP/WEs01AVsC0WP+d7QANKN2huulAOVwnCKoTGkIu
         U0F0qaxWQ+S4ZdD9UOVjaqIlwK3a14W7p3uB66qbaiUDhV+BDODgfLrOYnuXjV3DKLoj
         DLrpUdw04Ag5Ay72UmKFJZMMe2JZdiLC0cnaoo0A1Akm3lWWLA8mq2vdJpDeM27hX7IS
         8aLD5d47AvJ7zh8ZR9k/THGIJxhgtbCfP7XHmqWIAOz+Do9yO6lhQNQ/sKUt1+DMKN/u
         AstA==
X-Gm-Message-State: AGRZ1gJvpWGLDA4FZwCwzQJViTjahQE3GieHByZMxP+rs+WYJwvqQ5zY
        7SO5nOTMWABPAGxkZnlMWFQSOT2taM0WEVcKhwo=
X-Google-Smtp-Source: AJdET5c8KHWPIVyvLJlRGnuEEI5oSJO88amTZ90kSeILV+KqXsxVloQ63CZ8BJQw3mUV7qOvpoXwgV2UwnPZDclDwz0=
X-Received: by 2002:a37:a4cf:: with SMTP id n198mr8069844qke.101.1542323043129;
 Thu, 15 Nov 2018 15:04:03 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 16 Nov 2018 09:03:51 +1000
Message-ID: <CAPM=9twAV6JSXn=NuJuZqc0wYq7VpmixM-MM2CVYZ=7VtOOqbA@mail.gmail.com>
Subject: [git pull] drm fixes for 4.20-rc3
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

Live from Vancouver, SoC maintainer talk, this weeks drm fixes pull for rc3=
.

omapdrm: regression fixes for the reordering bridge stuff that went into rc=
1,
i915: incorrect EU count fix, HPD storm fix, MST fix, relocation fix for ge=
n4/5
amdgpu: huge page handling fix, IH ring setup, XGMI aperture setup,
watermark setup fix
misc: docs and MST fix.

Thanks,
Dave.

drm-fixes-2018-11-16:
i915, amdgpu, omapdrm, docs and mst fix
The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad=
:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-11-16

for you to fetch changes up to 20325e8a614377967644cf63050095c9f2ea8ab9:

  Merge tag 'drm-intel-fixes-2018-11-15' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2018-11-16
08:52:14 +1000)

----------------------------------------------------------------
i915, amdgpu, omapdrm, docs and mst fix

----------------------------------------------------------------
Chris Wilson (2):
      drm/i915/ringbuffer: Delay after EMIT_INVALIDATE for gen4/gen5
      drm/i915/execlists: Force write serialisation into context image
vs execution

Christian K=C3=B6nig (1):
      drm/amdgpu: fix huge page handling on Vega10

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2018-11-14' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'drm-fixes-4.20' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2018-11-15' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Imre Deak (1):
      drm/i915/icl: Fix power well 2 wrt. DC-off toggling order

Jorge Ramirez-Ortiz (1):
      drm/meson: venc: dmt mode must use encp

Laurent Pinchart (4):
      drm/omap: Populate DSS children in omapdss driver
      drm/omap: hdmi4: Ensure the device is active during bind
      drm/omap: dsi: Ensure the device is active during probe
      drm/omap: Move DISPC runtime PM handling to omapdrm

Lionel Landwerlin (1):
      drm/i915: fix broadwell EU computation

Lyude Paul (2):
      drm/i915: Fix possible race in intel_dp_add_mst_connector()
      drm/i915: Fix NULL deref when re-enabling HPD IRQs on systems with MS=
T

Maarten Lankhorst (1):
      drm/i915: Move programming plane scaler to its own function.

Mika Kuoppala (1):
      drm/i915/icl: Drop spurious register read from icl_dbuf_slices_update

Philip Yang (1):
      drm/amdgpu: fix bug with IH ring setup

Rex Zhu (1):
      drm/amd/pp: Fix truncated clock value when set watermark

Sean Paul (1):
      drm: Fix htmldocs warnings in drm_fourcc.c

Stanislav Lisovskiy (1):
      drm/dp_mst: Check if primary mstb is null

Tony Lindgren (1):
      drm/omap: dsi: Fix missing of_platform_depopulate()

Ville Syrj=C3=A4l=C3=A4 (3):
      drm/i915: Fix hpd handling for pins with two encoders
      drm/i915: Clean up skl_program_scaler()
      drm/i915: Account for scale factor when calculating initial phase

shaoyunl (1):
      drm/amdgpu: set system aperture to cover whole FB region

 arch/arm/mach-omap2/display.c                    | 111 +++++++++++--------=
----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           |  18 ++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c          |   6 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c           |   2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c |  32 +++----
 drivers/gpu/drm/drm_dp_mst_topology.c            |   3 +
 drivers/gpu/drm/drm_fourcc.c                     |   2 +-
 drivers/gpu/drm/i915/intel_device_info.c         |   2 +-
 drivers/gpu/drm/i915/intel_display.c             |  45 ++++++++-
 drivers/gpu/drm/i915/intel_dp_mst.c              |   8 +-
 drivers/gpu/drm/i915/intel_drv.h                 |   2 +-
 drivers/gpu/drm/i915/intel_hotplug.c             |  70 ++++++++++----
 drivers/gpu/drm/i915/intel_lrc.c                 |  14 ++-
 drivers/gpu/drm/i915/intel_ringbuffer.c          |  38 +++++++-
 drivers/gpu/drm/i915/intel_runtime_pm.c          |  16 ++--
 drivers/gpu/drm/i915/intel_sprite.c              |  93 +++++++++++--------
 drivers/gpu/drm/meson/meson_venc.c               |  15 +--
 drivers/gpu/drm/omapdrm/dss/dsi.c                |  22 ++---
 drivers/gpu/drm/omapdrm/dss/dss.c                |  11 ++-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c              |  37 ++------
 drivers/gpu/drm/omapdrm/dss/hdmi5.c              |  27 ------
 drivers/gpu/drm/omapdrm/dss/venc.c               |   7 --
 drivers/gpu/drm/omapdrm/omap_crtc.c              |   6 ++
 24 files changed, 342 insertions(+), 251 deletions(-)
