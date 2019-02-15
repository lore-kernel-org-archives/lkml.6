Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F81C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC622192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkPcftne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387704AbfBODR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 22:17:57 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35231 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfBODR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 22:17:57 -0500
Received: by mail-qt1-f194.google.com with SMTP id p48so9444412qtk.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 19:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=e8ZrgZpCOsIdRxbNfrn12kYp/awSpS6kV3guk6YaBzk=;
        b=WkPcftnexYobN7/qq1A/JpHKMjv/+iLIxORTtjoE0BtSwqLGI/GupuqpdWoyG/d81i
         HGakHS4BKlkbS0WuLgxOtR5zw3NzmyC8Caq27a9RBaq6GDxwhUABIKjqL43jGXZqbMaH
         iUaMF5ePbtlzfiazL379Jt0yPQY/mwx388fQ/AY2TVaqhlfvqELCBh0M0vP7IwIoWvL7
         11sp+W/2MMHVwN1sJ5yGZdW0iUMpECwmN76XA6BqmWmIHOSJqDf8oAvLrb1dwQtAKolX
         kwNrYZhhNrybXPQoObLM6z64sB1kfrrLfZ4fJv9LTWDrDralwMAp75pd/W0F7V+i29Se
         T2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=e8ZrgZpCOsIdRxbNfrn12kYp/awSpS6kV3guk6YaBzk=;
        b=WaR43omCf6RPTqghA3HWNEo9MEpTDaFHMVi0JS95r6bd90ws98HDOkv5LOFXJJaJQR
         Pehq7wam/GCfaLHo6E22hg/f7f9VUeRGwyWjpT1KBJCkAPWsgVb6CuUGnsMotWbrmkfX
         2VV+d6g4OzkZjpXvvc4O+BYSIF/c+/5GQcB04gDqeuVbZnA4f1HcbQqpSwt4jmkpFBtK
         EoL04HUavDlH0i/xpBDAi6Kla+pdq8WYBPlHk0/XnNrdr7mbdmf2DLva+qJMcXBfMwSP
         BvV7zcWA+atJ94LLnyy/uhaFWxNbwOJ7m9q6eCYowK4yvdMlMR9gZfpVvebqbcv5pwZn
         5N5A==
X-Gm-Message-State: AHQUAubLkdmQ41RlPrzx6msVHtFlaQHZmeF8jv19RrGG1tl5oNo3myaG
        0WvLOnd4It9cvyuMNK47JfCeZQje3FG6PiO6ZtI=
X-Google-Smtp-Source: AHgI3IbpW4h+ii15sm9oRQe6aL9WmeuDG1loyjeiDgWocdIt9gkCgSTnUtf2JekTmNBg/Im790hnTkDa9mBq5zOiBJ4=
X-Received: by 2002:ac8:3873:: with SMTP id r48mr5917376qtb.264.1550200675582;
 Thu, 14 Feb 2019 19:17:55 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 15 Feb 2019 13:17:43 +1000
Message-ID: <CAPM=9txPE7gVooSFCyOt0cvGOJnHaq7xF28YydC17vDCemGB4w@mail.gmail.com>
Subject: [git pull] drm fixes for 5.0-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Usual pull request, little larger than I'd like but nothing too
strange in it. Willy found an bug in the lease ioctl calculations, but
it's a drm master only ioctl which makes it harder to mess with.

i915:
- combo phy programming fix
- opregion version check fix for VBT RVDA lookup
- gem mmap ioctl race fix
- fbdev hpd during suspend fix
- array size bounds check fix in pmu

amdgpu:
- Vega20 psp fix
- Add vrr range to debugfs for freesync debugging

sched:
- Scheduler race fix

vkms:
- license header fixups

imx:
- Fix CSI register offsets for i.MX51 and i.MX53.
- Fix delayed page flip completion events on i.MX6QP due to unexpected
  behaviour of the PRE when issuing NOP buffer updates to the same
  buffer address.
- Stop throwing errors for plane updates on disabled CRTCs when a
  userspace process is killed while a plane update is pending.
- Add missing of_node_put cleanup in imx_ldb_bind.

Dave.

drm-fixes-2019-02-15-1:
drm core, i915, amd, imx, vkms fixes
The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-02-15-1

for you to fetch changes up to 69ef943dbc14b21987c79f8399ffea08f9a1b446:

  drm: Use array_size() when creating lease (2019-02-15 13:08:08 +1000)

----------------------------------------------------------------
drm core, i915, amd, imx, vkms fixes

----------------------------------------------------------------
Aditya Swarup (1):
      drm/i915/cnl: Fix CNL macros for Voltage Swing programming

Alex Deucher (1):
      drm/amdgpu/psp11: TA firmware is optional (v3)

Alexander Shiyan (1):
      gpu: ipu-v3: Fix i.MX51 CSI control registers offset

Clint Taylor (1):
      drm/i915/icl: combo port vswing programming changes per BSPEC

Dave Airlie (4):
      Merge tag 'imx-drm-fixes-2019-02-12' of
git://git.pengutronix.de/pza/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2019-02-13' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2019-02-13' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge branch 'drm-fixes-5.0' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Eric Anholt (1):
      drm/sched: Always trace the dependencies we wait on, to fix a race.

Jani Nikula (2):
      drm/i915/opregion: fix version check
      drm/i915/opregion: rvda is relative from opregion base in opregion 2.1+

Joonas Lahtinen (1):
      drm/i915: Prevent a race during I915_GEM_MMAP ioctl with WC set

Julia Lawall (1):
      drm/imx: imx-ldb: add missing of_node_puts

Lucas Stach (1):
      gpu: ipu-v3: pre: don't trigger update if buffer address doesn't change

Lyude Paul (1):
      drm/i915: Block fbdev HPD processing during suspend

Matthew Wilcox (1):
      drm: Use array_size() when creating lease

Nicholas Kazlauskas (1):
      drm/amd/display: Expose connector VRR range via debugfs

Philipp Zabel (1):
      drm/imx: ignore plane updates on disabled crtcs

Rodrigo Siqueira (1):
      drm/vkms: Fix license inconsistent

Steve Longerbeam (1):
      gpu: ipu-v3: Fix CSI offsets for imx53

Tvrtko Ursulin (1):
      drm/i915/pmu: Fix enable count array size and bounds checking

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   9 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |  28 +--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |  22 +-
 drivers/gpu/drm/drm_lease.c                        |   3 +-
 drivers/gpu/drm/i915/i915_gem.c                    |  12 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |  22 +-
 drivers/gpu/drm/i915/i915_pmu.h                    |   2 +
 drivers/gpu/drm/i915/i915_reg.h                    |  18 +-
 drivers/gpu/drm/i915/intel_ddi.c                   | 238 ++++++++-------------
 drivers/gpu/drm/i915/intel_dp.c                    |   4 +-
 drivers/gpu/drm/i915/intel_drv.h                   |  10 +
 drivers/gpu/drm/i915/intel_fbdev.c                 |  33 ++-
 drivers/gpu/drm/i915/intel_opregion.c              |  38 +++-
 drivers/gpu/drm/i915/intel_ringbuffer.h            |   9 +-
 drivers/gpu/drm/imx/imx-ldb.c                      |  25 ++-
 drivers/gpu/drm/imx/ipuv3-plane.c                  |   4 +-
 drivers/gpu/drm/scheduler/sched_entity.c           |   7 +-
 drivers/gpu/drm/vkms/vkms_crc.c                    |   3 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                   |   8 +-
 drivers/gpu/drm/vkms/vkms_drv.c                    |   7 +-
 drivers/gpu/drm/vkms/vkms_drv.h                    |   2 +
 drivers/gpu/drm/vkms/vkms_gem.c                    |   8 +-
 drivers/gpu/drm/vkms/vkms_output.c                 |   8 +-
 drivers/gpu/drm/vkms/vkms_plane.c                  |   8 +-
 drivers/gpu/ipu-v3/ipu-common.c                    |   8 +-
 drivers/gpu/ipu-v3/ipu-pre.c                       |   6 +
 26 files changed, 294 insertions(+), 248 deletions(-)
