Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A01CC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A75D2081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9wRpNWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A75D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeK3OTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:19:42 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39515 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeK3OTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:19:41 -0500
Received: by mail-qt1-f195.google.com with SMTP id n21so4484708qtl.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 19:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Hx/5BVh+Kv8eI/niVNxhR70228zby8Qe7T79DopuRC0=;
        b=M9wRpNWQjriLCGhmIjTjmvHi/UzjGoSuWZ71dACeFY+cOXnZ7Q7lbjW1RcQW82aa9v
         qDmyumC7DTk0gtrM9r9AUyQ4BX84es+LvOXmWR18zRZNhYdFDv4obTUYWJylsWyCiobx
         Eir9XJYnUiWjvWuVn+zxxRU5iSny0CDcyi4RPBg80te16pbFg0UNxeVwlhyHbWAEZLbr
         AzsevajAKwuITI6Gh2InnaTdqezFg/zjnD7+/WvBfAvkwYHj3ucM9QWPhN60wyVnKc7s
         eJqSyfKyTs6z3Z+FPAHjeG8DyR9+3r9ypWFPbUhOluU/XnBgWloQKKiAJ+WleptN9A6z
         QS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Hx/5BVh+Kv8eI/niVNxhR70228zby8Qe7T79DopuRC0=;
        b=pBVUESmlJFKwWDx0M8cYXyAh+L2jlIb4wT1dMvPG7vVygmFlTDfuTZp8R/ZfMJMqEo
         FBaOU2LUnpsYWb0NdGvjFk3J4aSVKG6ryAcvF2J5W+sGXMHz2YYGSn5Hn4URt8pM3n+I
         j/cDzPPW9EwjZn9aVUEIgd0rAQZ5/hNxaDcDHjhC34zvgFAefOzT8PMX9WHjHUy1y89f
         /e4jPiOE7G6QZ4FfeV09PWSwD5YhnwbaNaDWDNTLdxVzgePXpjMhOIgsqUATWAEQW5Sr
         DiWrX3UmELGnKmtTQPz/sBMwT/xANT9BUsCkEgwvHpXoP7j7Apdk0GEMN3WX6RZpGgq+
         rA7w==
X-Gm-Message-State: AA+aEWYVheigeiGUbfHZEcZ6oFsi5FTsEgMAd0ZWLLf+qRWDsYVfe5OR
        HJCnu94DaN6CWEQQ3xDEbaOJ/nRv169FyoBR9ONJqUs4
X-Google-Smtp-Source: AFSGD/XXROG9dnwQnrFXqY4fwGsWW2NS2p0DAokY7LpzRbN6h7mY/QmnMSOxsyoD+ooEeN+1pKoaHA7PkcEn9V+Guu0=
X-Received: by 2002:ac8:296a:: with SMTP id z39mr4053555qtz.264.1543547513987;
 Thu, 29 Nov 2018 19:11:53 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 30 Nov 2018 13:11:42 +1000
Message-ID: <CAPM=9tzwOctXgaxvfjhd-xAvrBsAxo09axqQQLTcQPsq1g4TmQ@mail.gmail.com>
Subject: [git pull] drm fixes for 4.20-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This weeks instalment of fixes. Looks fairly like business as usual
and everything seems to rolling along. There was one MST fix applied
and reverted in the misc tree, but otherwise nothing too strange in
here.

core: incorrect master setting on error fix
i915: only GVT fixes this week, one MOCS register load, rpm lock fix,
and a use after free.
rcar-du: regression fix for group start
amdgpu: DP MST fix, GPUVM fix for huge pages, RLC fix for vega20
ast: fix EDID reading stability, ioreg free fix
meson: sleep in irq fix, vblank fixes, array boundary fix

Thanks,
Dave.

drm-fixes-2018-11-30:
drm: i915 gvt, amdgpu, ast, rcar-du, meson + core fixes.
The following changes since commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436:

  Linux 4.20-rc4 (2018-11-25 14:19:31 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-11-30

for you to fetch changes up to ebcdcef30333660d3314158bac362425ade3d28c:

  Merge tag 'drm-misc-fixes-2018-11-28-1' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2018-11-29
10:11:15 +1000)

----------------------------------------------------------------
drm: i915 gvt, amdgpu, ast, rcar-du, meson + core fixes.

----------------------------------------------------------------
Chris Wilson (1):
      drm/i915/gvt: Avoid use-after-free iterating the gtt list

Christian Hewitt (1):
      drm/meson: add support for 1080p25 mode

Dave Airlie (4):
      Merge tag 'du-fixes-20181126' of
git://linuxtv.org/pinchartl/media into drm-fixes
      Merge tag 'drm-intel-fixes-2018-11-28' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge branch 'drm-fixes-4.20' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2018-11-28-1' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Felix Kuehling (2):
      drm/amdgpu: Cast to uint64_t before left shift
      drm/amdgpu: Avoid endless loop in GPUVM fragment processing

Hang Yuan (1):
      drm/i915/gvt: ensure gpu is powered before do i915_gem_gtt_insert

Joonas Lahtinen (1):
      Merge tag 'gvt-fixes-2018-11-26' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Laurent Pinchart (1):
      drm: rcar-du: Fix DU3 start/stop on M3-N

Lyude Paul (6):
      drm/amd/dm: Don't forget to attach MST encoders
      drm/amd/dm: Understand why attaching path/tile properties are needed
      drm/dp_mst: Skip validating ports during destruction, just ref
      drm/meson: Enable fast_io in meson_dw_hdmi_regmap_config
      drm/meson: Fix OOB memory accesses in meson_viu_set_osd_lut()
      Revert "drm/dp_mst: Skip validating ports during destruction, just ref"

Neil Armstrong (1):
      drm/meson: Fixes for drm_crtc_vblank_on/off support

Sam Bobroff (1):
      drm/ast: Fix incorrect free on ioregs

Sergio Correia (1):
      drm: set is_master to 0 upon drm_new_set_master() failure

Xinyun Liu (1):
      drm/i915/gvt: not to touch undefined MOCS registers

Y.C. Chen (1):
      drm/ast: fixed reading monitor EDID not stable issue

shaoyunl (1):
      drm/amdgpu: Add delay after enable RLC ucode

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             | 14 +++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  7 +++--
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  5 ++-
 drivers/gpu/drm/ast/ast_main.c                     |  3 +-
 drivers/gpu/drm/ast/ast_mode.c                     | 36 ++++++++++++++++++----
 drivers/gpu/drm/drm_auth.c                         |  2 ++
 drivers/gpu/drm/i915/gvt/aperture_gm.c             |  2 ++
 drivers/gpu/drm/i915/gvt/gtt.c                     |  7 +++--
 drivers/gpu/drm/i915/gvt/mmio_context.c            |  2 ++
 drivers/gpu/drm/meson/meson_crtc.c                 | 27 ++++++++++++++--
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |  1 +
 drivers/gpu/drm/meson/meson_venc.c                 |  4 +++
 drivers/gpu/drm/meson/meson_viu.c                  | 12 ++++----
 drivers/gpu/drm/rcar-du/rcar_du_group.c            | 21 +++++++++++--
 14 files changed, 110 insertions(+), 33 deletions(-)
