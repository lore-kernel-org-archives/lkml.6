Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933124AbeBLIxF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 03:53:05 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35024 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933044AbeBLIxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 03:53:02 -0500
X-Google-Smtp-Source: AH8x224yejYfMQVhSWbdzOUy7aXWWiw5jraYLUt8uG/JHIWddsaAgh6xKCLgshhmM1geHEMKdVl6CA==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: daniel.vetter@intel.com, gustavo@padovan.org, airlied@linux.ie,
        seanpaul@chromium.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH 0/4] drm/simple_kms_helper: Add {enable|disable}_vblank callback support
Date: Mon, 12 Feb 2018 10:52:50 +0200
Message-Id: <1518425574-32671-1-git-send-email-andr2000@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

If simple_kms_helper based driver needs to work with vblanks,
then it has to provide drm_driver.{enable|disable}_vblank callbacks,
because drm_simple_kms_helper.drm_crtc_funcs does not provide any.
At the same time drm_driver.{enable|disable}_vblank callbacks
are marked as deprecated and shouldn't be used by new drivers.

Fix this by extending drm_simple_kms_helper.drm_crtc_funcs
to provide the missing callbacks.

Please note, that patch for the DRM core (drm_simple_kms_helper.*)
is checked at run-time (I use this patch for my own driver), but patches
0002-0004 are compile only checked.

Thank you,
Oleksandr Andrushchenko

Oleksandr Andrushchenko (4):
  drm/simple_kms_helper: Add {enable|disable}_vblank callback support
  drm/mxsfb: Do not use deprecated drm_driver.{enable|disable)_vblank
  drm/tve200: Do not use deprecated drm_driver.{enable|disable)_vblank
  drm/pl111: Do not use deprecated drm_driver.{enable|disable)_vblank

 drivers/gpu/drm/drm_simple_kms_helper.c | 24 +++++++++++++++
 drivers/gpu/drm/mxsfb/mxsfb_drv.c       | 54 +++++++++++++++++----------------
 drivers/gpu/drm/pl111/pl111_display.c   | 15 +++++++--
 drivers/gpu/drm/pl111/pl111_drm.h       |  2 --
 drivers/gpu/drm/pl111/pl111_drv.c       |  5 ---
 drivers/gpu/drm/tve200/tve200_display.c | 10 ++++--
 drivers/gpu/drm/tve200/tve200_drm.h     |  2 --
 drivers/gpu/drm/tve200/tve200_drv.c     |  3 --
 include/drm/drm_simple_kms_helper.h     | 18 +++++++++++
 9 files changed, 90 insertions(+), 43 deletions(-)

-- 
2.7.4
