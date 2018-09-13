Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98827C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCF420882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRsm9vxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCF420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeIMFLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 01:11:30 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:40806 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeIMFL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 01:11:29 -0400
Received: by mail-qt0-f182.google.com with SMTP id h4-v6so3754393qtj.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 17:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CsmgCikYEYJXaisfBUGRy2seQVF6E9Y3mCCliq4JDb8=;
        b=qRsm9vxW3TKoBAYny/x4AQpnW8ntT/1wX98mK/bU7F5UlQTtYeLtWoU7AD8tcxoWZz
         kAkik4uZWz7wiuB5CA4tWQdokXuiUMPyKL7i6MoOpTQpfpbQxKJo53myhMHhz6aQMb5j
         H7dQCjew74kzyBhQf7PTMHDW264YQ7qOi1UWzfg9e59YdYF9bEe7vsJR6n7zehMV17fh
         q4+mFacyiBDckl5z60a6fy0z4823dBlEVbnnwoKoAkmWyWIvZ46uOhm8+L+94yAAvqoC
         04VaRk20H1IanFwvwEY6TgnByUPvFo/DnO5PvBNwkFAFaPY3EBC0+mrWYaPPBq2kOJSQ
         7HuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CsmgCikYEYJXaisfBUGRy2seQVF6E9Y3mCCliq4JDb8=;
        b=rCJZ8cUUJwRdcgpq5olNVwRcNLNNNwSnI2fF+2HrNr+zFD4CkClFIStY3zhToU4tJf
         JgzGMotCGZnqMzdDIAuUo/n/KX99kkj/vTAvnymwwaUlZLHqXZG7ldMxBlbDUt3+wZRl
         dSKyl3oOWvteil+BDo50FEYZ3n+F8Qc2yGJYZdvjwC1Z4ehEL3nlu3d8qvddw0CIt5tC
         yU4su749ggI8tgi2QZerFDD8lQHhOZvSNABkoqlyM8wQULWu017ROjIL1JTsMvT0kAgK
         emRU9m44thjRjK2ubveCKeBA8oeHV0W++6CcLicjQJO2Q9LSBFQFLevSvN8lwX+UrS+h
         xo6A==
X-Gm-Message-State: APzg51Bkxr88GYqOQGYKsgq/d66/8HcxQ0SYTxM+sY7NHUHlHjW+ws0M
        CD86UPhN6YV0Zlh4xt8xPO0KMyoPJvLSrgA5BpJN8+CH
X-Google-Smtp-Source: ANB0VdZh/m0g5wCjUFL3bVYpHU0GL62mw8b6z1Jz6/vGHDR4ixpZUuFZOfNJTbKR5RWOFMW2qI/x/DvK30Be6xl1W0g=
X-Received: by 2002:aed:2023:: with SMTP id 32-v6mr3364666qta.166.1536797076229;
 Wed, 12 Sep 2018 17:04:36 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 13 Sep 2018 10:04:24 +1000
Message-ID: <CAPM=9twk+MqRtKrNKx+VL6u5vhUBF7m9NvWxStcE=4acgoJ_GA@mail.gmail.com>
Subject: [git pull] drm nouveau runpm and mst fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I'm sending this separately as it's a bit larger than I generally like
for one driver, but it does contain a bunch of make my nvidia laptop
not die (runpm) and a bunch of make my docking station and monitor
display stuff (mst) fixes.

Lyude has spent a lot of time on these, and we are putting the fixes
into distro kernels as well asap, as it helps a bunch of standard
Lenovo laptops, so I'm fairly happy things are better than they were
before these patches, but I decided to split them out just for
clarification.

I'll have a normal -fixes pull tomorrow most likely.

Dave.

drm-fixes-2018-09-12:
nouveau runpm and MST race fixes.
The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:

  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-09-12

for you to fetch changes up to 2887e5ce15ddaa2f9a19e66f7462bbf0fe6867e0:

  Merge branch 'linux-4.19' of git://github.com/skeggsb/linux into
drm-fixes (2018-09-11 16:54:46 +1000)

----------------------------------------------------------------
nouveau runpm and MST race fixes.

----------------------------------------------------------------
Ben Skeggs (7):
      drm/nouveau: fix oops in client init failure path
      drm/nouveau/mmu: don't attempt to dereference vmm without valid
instance pointer
      drm/nouveau/TBDdevinit: don't fail when PMU/PRE_OS is missing from VBIOS
      drm/nouveau/disp: remove unused struct member
      drm/nouveau/disp: move eDP panel power handling
      drm/nouveau/disp: fix DP disable race
      drm/nouveau/disp/gm200-: enforce identity-mapped SOR assignment
for LVDS/eDP panels

Dave Airlie (1):
      Merge branch 'linux-4.19' of git://github.com/skeggsb/linux into drm-fixes

Lyude Paul (13):
      drm/nouveau/drm/nouveau: Fix bogus drm_kms_helper_poll_enable() placement
      drm/nouveau: Remove duplicate poll_enable() in pmops_runtime_suspend()
      drm/nouveau/drm/nouveau: Fix deadlock with fb_helper with async
RPM requests
      drm/nouveau/drm/nouveau: Use pm_runtime_get_noresume() in
connector_detect()
      drm/nouveau: Fix deadlocks in nouveau_connector_detect()
      drm/nouveau: Remove useless poll_enable() call in switcheroo_set_state()
      drm/nouveau: Remove useless poll_disable() call in switcheroo_set_state()
      drm/nouveau: Remove useless poll_enable() call in drm_load()
      drm/nouveau: Only write DP_MSTM_CTRL when needed
      drm/nouveau: Reset MST branching unit before enabling
      drm/nouveau/drm/nouveau: Prevent handling ACPI HPD events too early
      drm/nouveau/drm/nouveau: Don't forget to cancel hpd_work on suspend/unload
      drm/nouveau: Fix nouveau_connector_ddc_detect()

 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  67 +++++++++----
 drivers/gpu/drm/nouveau/nouveau_connector.c        | 110 +++++++++++----------
 drivers/gpu/drm/nouveau/nouveau_display.c          |  44 ++++++---
 drivers/gpu/drm/nouveau/nouveau_display.h          |   2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |  21 ++--
 drivers/gpu/drm/nouveau/nouveau_fbcon.c            |  57 +++++++++++
 drivers/gpu/drm/nouveau/nouveau_fbcon.h            |   5 +
 drivers/gpu/drm/nouveau/nouveau_vga.c              |   2 -
 drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c    |  14 +++
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c      |  54 ++++++++--
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h     |   1 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c    |   6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c    |  18 +++-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h    |   5 +-
 .../gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c    |   3 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c      |   2 +-
 16 files changed, 297 insertions(+), 114 deletions(-)
