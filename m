Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17E7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BC120700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHKos4mp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfBVAOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:14:02 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:46384 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfBVANz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:13:55 -0500
Received: by mail-qt1-f171.google.com with SMTP id z25so594128qti.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 16:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6iPA+u1WB9kfoDkXk3VQDEvqaEJEHtNmtUC0WdKzLpE=;
        b=UHKos4mpiWQ8hTZkH5YfSNpQ8P8CsNnHm7CSNVxm80aHHMaxtXg+NYWqIdos0WOGP1
         b/py9V3ZJTBrNFeZR3YgHV+IYOR3anC8o6cBOQ4IpmIa56pJNlpbtRhsw+VpvolYrDB6
         6oKaZs3hLlSZPyVteCcALUFJBI5t0UbgHON22nb31ybSXJyF353jwR8iInRxKZC/FgcQ
         Y2cSHroEm7pHsuYIUrX7Ps75gBDTTf2WJf37KZglVoxxPOcEqzvJyVkMDy21uMy2rabE
         Mpl2Fwc0JpcBaFMUBhoB2X9BDqGQ5TYd4Qw70DzkNIcp4Pes8YiD/7b/g406Ji8PvX/3
         3vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6iPA+u1WB9kfoDkXk3VQDEvqaEJEHtNmtUC0WdKzLpE=;
        b=NSQTsh3BiC08KM5X8/nW+uU+wAqrTAW0fAcSXpXbSQtxlXPJPm2v+FGsbH3t5zeJzv
         oO0PMapPMYdQQo6eU9B8nDbULtge5mJywS2EQBojibsikDKBjG3bxaQg1prLu6fcaqPH
         hKeNXPAKkpqj5YZiBx1gF1VaX6yVnyS/z6Y1rdqutbgL60630aOGDOYENs2qlD7rPpJK
         p7I2UihFPhj/919HINBAug/5Ja4vGnA1wtnkzy+SFygrkrZ4PhVPd7kEkRYhA74OipYM
         2GZ2SHJ2jpPlh8Sz0luCHhemssnPnKXa8eEpvK6pr8w9heEEeYFwgoihID5gdq5PXPg7
         /L3A==
X-Gm-Message-State: AHQUAubTz5rySkt1QEvmCiHkYXp50LrkGdSFYQGPGfYPRuPkYI5aLGvu
        KQzcUzeiaoBXgnmiuV7NNn16jkctc5HbwymO8rM=
X-Google-Smtp-Source: AHgI3IbwTW4Y5PEub1DcVHZgJgo+djvuoX1M4ewqmkyJ5IiFcoYo+pGrEcY67SyMJoRSK4XHCVPCjzeYVSHWz4JL/QY=
X-Received: by 2002:ac8:2f4e:: with SMTP id k14mr962773qta.76.1550794433936;
 Thu, 21 Feb 2019 16:13:53 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 22 Feb 2019 10:13:42 +1000
Message-ID: <CAPM=9tz=yygXZqjnR=VwOmZ+BPjohjsHSv+i-LU+rX7zDkK90A@mail.gmail.com>
Subject: [git pull] drm fixes for 5.0-rc8 (or final)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This contains a single i915 tiled display fix, and a set of amdgpu/radeon f=
ixes.

amdgpu/radeon:
runtime PM fix
bulk moves disable (fix is too large for 5.0)
and a set of display fixes that are all cc'ed stable so we didn't want
to leave them until -next.

Dave.

drm-fixes-2019-02-22:
drm amdgpu + one i915 fix
The following changes since commit a3b22b9f11d9fbc48b0291ea92259a5a810e9438=
:

  Linux 5.0-rc7 (2019-02-17 18:46:40 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-02-22

for you to fetch changes up to 019276ed65f364de27b929da4e083bb86ce7d1ef:

  Merge branch 'drm-fixes-5.0' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2019-02-22
09:35:25 +1000)

----------------------------------------------------------------
drm amdgpu + one i915 fix

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime

Bhawanpreet Lakha (2):
      drm/amd/display: fix optimize_bandwidth func pointer for dce80
      drm/amd/display: set clocks to 0 on suspend on dce80

Chris Wilson (1):
      drm/i915/fbdev: Actually configure untiled displays

Christian K=C3=B6nig (1):
      drm/amdgpu: disable bulk moves for now

Dave Airlie (2):
      Merge tag 'drm-intel-fixes-2019-02-20' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge branch 'drm-fixes-5.0' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Leo (Hanghong) Ma (1):
      drm/amd/display: Fix MST reboot/poweroff sequence

Nicholas Kazlauskas (1):
      drm/amd/display: Fix negative cursor pos programming

Rafael J. Wysocki (1):
      gpu: drm: radeon: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime

Roman Li (1):
      drm/amd/display: Raise dispclk value for dce11

shaoyunl (1):
      drm/amdgpu: Update sdma golden setting for vega20

 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c               |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                |  2 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                |  4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     |  5 +++--
 drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c      | 11 ++++++++---
 .../drm/amd/display/dc/dce100/dce100_hw_sequencer.h   |  4 ++++
 .../gpu/drm/amd/display/dc/dce80/dce80_hw_sequencer.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c | 19 +++++++++++++++=
+---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c |  4 ++--
 drivers/gpu/drm/i915/intel_fbdev.c                    | 12 +++++++-----
 drivers/gpu/drm/radeon/radeon_kms.c                   |  1 +
 11 files changed, 47 insertions(+), 18 deletions(-)
