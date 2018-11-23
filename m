Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE10C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 01:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD577206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 01:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NatcNkUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD577206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439319AbeKWMWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 07:22:03 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39137 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733028AbeKWMWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 07:22:03 -0500
Received: by mail-qt1-f194.google.com with SMTP id n21so9091892qtl.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 17:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=mIPyIpaufwYdrICu0BtlzYmRcys2x9OfpnBdakSpL2k=;
        b=NatcNkUNBHAJJ3cPYB4LSWIZJP/3/UISTZvuNRZiEo4AF+ZSVoomzhpPxNLGCF0RsS
         0TwKdE+erSs04dz2A2TbMfQlLI+4zAh4zMWHHcGeD7hqlzZCVz4v1Ov4qkSh7k96foEt
         jPVJAXgnRklnf8NH2G0mLUTDpLyZX2+GY4TXhZOisdcP7cetbD7YEehAPQdnUfpxh0ZF
         gEPKEHWzHriIzY1mKIxTMeovrwgfUc2Cp0Y4DRMJvRESYpc2Pr7AwFTsEHoL3GxneVw6
         UvuGNc0lhXR62Q+96seTh6Ld1pU9JvjpS2uLBcFCP9yTE/zLpmHR01F5U6Kdo6CBpd5x
         DL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=mIPyIpaufwYdrICu0BtlzYmRcys2x9OfpnBdakSpL2k=;
        b=d+adMHATBJF8ODT0MGN760WmxEevbj5zkoVpKpafn86alaUqHkaPUO/04ICKq4QnUw
         +zromDXsOaH2erdBssid7y8Uxm3aKoNGouJHcGYBmCb3UrHt5evIzYqAqUw7B1DHIt/s
         W4tXKn0PcIphph/nLpnUF72PWPukFmFx6dAq1EgDbmcxTaQN1KkxG3zGq35Zs24ROKVr
         jWuYOiN5j/mgraFJorMdeW28jkpKqntWgGnffeoAZ70dTiIDpIzBYjydBL4oyPosu5N7
         sCi9/WOC4PW+3c5rgaAhFKX/P+rMgaZxJvG/x07wW31xhfzVrmfrYy00Bc3kaKWTx3Bm
         7U8A==
X-Gm-Message-State: AGRZ1gJlgqYKEtsPIRBapDGWFu+4hWohaVt5QibLf52TonRfF+m6BuSx
        3YD+W2Iy3fleCAQMoDJnxChUQH/TY1cNVpHRhOVlELFg
X-Google-Smtp-Source: AJdET5exvGlW4lwb1kNlQlNbDv3lg5E2GKD1WLP5f+xJW2c2hhM/qcKJ51zRjqg2njvMvwdauXcezBC2v4PlMkwQb8s=
X-Received: by 2002:ac8:51d4:: with SMTP id d20mr12359744qtn.365.1542937195480;
 Thu, 22 Nov 2018 17:39:55 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 23 Nov 2018 11:39:44 +1000
Message-ID: <CAPM=9tyitqcJ9obyFPuwuNO7oH1KXrVtVgWgw+4S60YjqR8BXA@mail.gmail.com>
Subject: [git pull] drm fixes for 4.20-rc4
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

Regular drm fixes pull for rc4.

amdgpu: Vega20 fixes, firmware loading fix, panel display fix, override fix
i915: Sandybridge lockup fix, fastboot DSI panel fix, GPU hang on
Broxton, GPU reloc fixes on pineview/bearlake
ast: screen blurring fix, cursor appearance fix
udmabuf: mmap fix
vc4: NULL deref fix, async cursor update fix.

All seems pretty normal at this stage,

Thanks,
Dave.

drm-fixes-2018-11-23:
drm i915, amdgpu, ast, vc4, udmabuf fixes
The following changes since commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6=
:

  Linux 4.20-rc3 (2018-11-18 13:33:44 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-11-23

for you to fetch changes up to 98c9cdfd34fbb62886e4c5a07e33661aa3352ef5:

  Merge tag 'drm-intel-fixes-2018-11-22' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2018-11-23
11:03:21 +1000)

----------------------------------------------------------------
drm i915, amdgpu, ast, vc4, udmabuf fixes

----------------------------------------------------------------
Boris Brezillon (2):
      drm/vc4: Fix NULL pointer dereference in the async update path
      drm/vc4: Set ->legacy_cursor_update to false when doing non-async upd=
ates

Chris Wilson (2):
      drm/i915: Prevent machine hang from Broxton's vtd w/a and error captu=
re
      drm/i915: Write GPU relocs harder with gen3

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2018-11-21' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'drm-fixes-4.20' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2018-11-22' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Evan Quan (1):
      drm/amd/powerplay: disable Vega20 DS related features

Felix Kuehling (1):
      drm/amdgpu: Fix oops when pp_funcs->switch_power_profile is unset

Gerd Hoffmann (1):
      udmabuf: set read/write flag when exporting

Greathouse, Joseph (1):
      drm/amd/pp: handle negative values when reading OD

Kenneth Feng (1):
      drm/amdgpu: Enable HDP memory light sleep

Nicholas Kazlauskas (2):
      drm/amdgpu: Add amdgpu "max bpc" connector property (v2)
      drm/amd/display: Support amdgpu "max bpc" connector property (v2)

Paul Kocialkowski (1):
      drm/fb-helper: Blacklist writeback when adding connectors to fbdev

Takashi Iwai (1):
      drm/amdgpu: Add missing firmware entry for HAINAN

Thomas Zimmermann (1):
      drm/ast: Remove existing framebuffers before loading driver

Ville Syrj=C3=A4l=C3=A4 (3):
      drm/i915: Disable LP3 watermarks on all SNB machines
      drm/i915: Force a LUT update in intel_initial_commit()
      drm/i915: Add rotation readout for plane initial config

Y.C. Chen (2):
      drm/ast: change resolution may cause screen blurred
      drm/ast: fixed cursor may disappear sometimes

 drivers/dma-buf/udmabuf.c                          |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  7 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  7 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |  2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15.c                 | 39 ++++++++++++++++--=
--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 16 +++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  1 +
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 20 +++++------
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 25 ++++++-------
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 23 ++++++------
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 30 +++++++++++-----
 drivers/gpu/drm/ast/ast_drv.c                      | 21 +++++++++++
 drivers/gpu/drm/ast/ast_mode.c                     |  3 +-
 drivers/gpu/drm/drm_fb_helper.c                    |  3 ++
 drivers/gpu/drm/i915/i915_gem_execbuffer.c         |  7 +++-
 drivers/gpu/drm/i915/i915_gem_gtt.c                |  5 +++
 drivers/gpu/drm/i915/i915_gpu_error.c              | 15 +++++++-
 drivers/gpu/drm/i915/i915_gpu_error.h              |  8 ++++-
 drivers/gpu/drm/i915/intel_display.c               | 39 ++++++++++++++++++=
++
 drivers/gpu/drm/i915/intel_drv.h                   |  1 +
 drivers/gpu/drm/i915/intel_pm.c                    | 41 ++++++++++++++++++=
+++-
 drivers/gpu/drm/vc4/vc4_kms.c                      |  6 ++++
 drivers/gpu/drm/vc4/vc4_plane.c                    | 15 ++++++--
 24 files changed, 273 insertions(+), 63 deletions(-)
