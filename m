Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA96C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B1527B13
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK4p2UYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B1527B13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbeF2ECb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 00:02:31 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:40523 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeF2EC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 00:02:29 -0400
Received: by mail-qt0-f172.google.com with SMTP id s47-v6so6761638qth.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 21:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=2dfsZLd0BpGZhGEfH+Fqc59V0T9LebLhMRGqI6Eh6qI=;
        b=QK4p2UYiDV9ahugKAAN4TSaYYkfWNhGUsZZ+5OY7O1Zj5M8XvTswtSqqy4Ma4CInnK
         PDNDxiMqHCinZ5DL94TnKjsO44M3UlEXHCjFVKjj+XXBx/tLEmLoFIBHb4jSUWbCxc1q
         AQNd9OLcuchmKMDyUWiu1mHdfNA8N0CpWZHcUV5+gO6m+h6mM/XKq+xz6cS/Yua+iAjH
         tNiM0JjQCx35mO+BzqU7gJT7xf9df7xtloZOKMnkDCH39p8B2icjh/nT7QreNm9hyqgd
         eutChIxvrnyIyTw2dnVCfR7BEEcqbP1Zq8QVCezEH2F0gD2l0OYZL6wrqMZ8op0nsLvl
         41IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=2dfsZLd0BpGZhGEfH+Fqc59V0T9LebLhMRGqI6Eh6qI=;
        b=FN1h90uJzG6SEVuN8zuxA+ApnoTNtUblhh05OzaJ4YhngHjST8fsNIIAq5XMRun5yM
         XBRt5jL3J8HcvKt4MSGNXLLcqmpi04hj6JNh9ZKhV0jZN3N5B/AYzVrWf3COWg3xFM/J
         nEmjkZ0Po7fuggDs0ZCwaPwlUincAxZs4e1oUgaLmEboH6mfewn+OHg4WDy00KszLvRf
         PYEI2UG8YMnHjwaJLY6tqCoFIlVtjnL+0+rqceamuMNbPDLEQQQ8smdm2qet4qJULz9d
         CtBfrMVVij9JaV8MpBxL0CZM2A9MA+tJE/6K6O/byhppDq1YS5KNJYZpYNd2qBCx2R+Z
         umYg==
X-Gm-Message-State: APt69E0v1D/H3IE91Pmsvcz2wgryjdSaGi3aPFTnsLKVcHixGiFM77Gi
        f8AhUZvJHmy+pCLjoY9WtthBl/IDyL2lUvFefSWakQ==
X-Google-Smtp-Source: AAOMgpcA/WLxC6QUYo2MuRnXPNRBemFFGetVoR3v8Mm9jhevF2ElzUJyCOW/nZxDqSyEn6FR7aQqSzSrl+ekJu4PIUI=
X-Received: by 2002:ac8:6648:: with SMTP id j8-v6mr5665476qtp.254.1530244948629;
 Thu, 28 Jun 2018 21:02:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:2b86:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 21:02:28
 -0700 (PDT)
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 29 Jun 2018 14:02:28 +1000
Message-ID: <CAPM=9txAgAmQ8y5k5n+kUCpgzeOJ-0ff-wEzerOp8r+thLpt7w@mail.gmail.com>
Subject: [git pull] drm fixes for 4.18-rc3
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

Nothing too major this round, small set of mali-dp fixes, single meson
fix and a bunch of amdgpu fixes (one makes non-4k page sizes not be a
bad experience).

Thanks,
Dave.

drm-fixes-2018-06-29:
amdgpu, mali_dp and meson fixes
The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819=
:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-06-29

for you to fetch changes up to 2d8aa4ef6aac566617052640e9bb07ecb9c45183:

  Merge tag 'drm-misc-fixes-2018-06-28' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2018-06-29
06:25:08 +1000)

----------------------------------------------------------------
amdgpu, mali_dp and meson fixes

----------------------------------------------------------------
Alison Wang (1):
      drm: mali-dp: Enable Global SE interrupts mask for DP500

Ayan Kumar Halder (3):
      drm/arm/malidp: Ensure that the crtcs are shutdown before
removing any encoder/connector
      drm/arm/malidp: Preserve LAYER_FORMAT contents when setting format
      drm/mali-dp: Rectify the width and height passed to rotmem_required()

Christophe JAILLET (1):
      drm/meson: Fix an un-handled error path in 'meson_drv_bind_master()'

Dave Airlie (4):
      Merge branch 'for-upstream/malidp-fixes' of
git://linux-arm.org/linux-ld into drm-fixes
      Merge branch 'drm-fixes-4.18' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge branch 'drm-fixes-4.18' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2018-06-28' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

James Zhu (1):
      drm/amdgpu:Support new VCN FW version naming convention

Leo Liu (1):
      drm/amdgpu: fix UBSAN: Undefined behaviour for amdgpu_fence.c

Lyude Paul (1):
      drm/amdgpu: Count disabled CRTCs in commit tail earlier

Michel D=C3=A4nzer (1):
      drm/amdgpu: GPU vs CPU page size fixes in amdgpu_vm_bo_split_mapping

Shirish S (1):
      drm/amd/display: release spinlock before committing updates to stream

 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c           | 33 ++++++++++++++++++-=
----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c            |  8 +++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 16 +++++------
 drivers/gpu/drm/arm/malidp_drv.c                  |  3 ++-
 drivers/gpu/drm/arm/malidp_hw.c                   |  3 ++-
 drivers/gpu/drm/arm/malidp_planes.c               |  9 ++++---
 drivers/gpu/drm/meson/meson_drv.c                 | 12 ++++++---
 8 files changed, 59 insertions(+), 27 deletions(-)
