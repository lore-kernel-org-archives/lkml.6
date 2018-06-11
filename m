Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GlUFOK4SHlu3VwAAmS7hNA
	; Mon, 11 Jun 2018 06:11:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CAF9C605A5; Mon, 11 Jun 2018 06:11:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgrlFgiS"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F249860791;
	Mon, 11 Jun 2018 06:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F249860791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754023AbeFKGL4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:11:56 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:39221 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753947AbeFKGLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:11:54 -0400
Received: by mail-qk0-f169.google.com with SMTP id g14-v6so12312351qkm.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 23:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=4JTor9nGtoXZaBlFVFn5TLwKX6QNXzvO1+IYUJzzTAE=;
        b=bgrlFgiS8eMLoRGvIiB6jfl5g9ESZY6XhoYjQUdH02ajKTOuSBlJXnI0dDF7SJdigm
         w6oJ+OWrFTlnv0JFIjwe6zbe5UxlOJ6cqJmKYnaDfxTLJaEurDO8nDEvi9hzAFZGMfXB
         HvzSRHuaGNG7+SblQSwJpojT2vDTQowPQDA2am6MbgvUEaW5APUGJkqSXro3FsjjSPeQ
         9sYK/LvaNiIdbQYTBPkEw464vqx7FikQcxZS/VYjr0nRc32ktgEXiPwqHFlle6J3+YKj
         CTzZwo7LM9870usDEx0un+XqrGlFrg6NMD7iOD8S6FsaJprRj78jFKmRKRHev9WBFRNi
         pLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=4JTor9nGtoXZaBlFVFn5TLwKX6QNXzvO1+IYUJzzTAE=;
        b=mW9Asri63qPvU2hiSraUE/j0gPeR+NpnGSv4b3DUcYqgROLtGumbPq636tWMxs6QvQ
         yn1WqY4tQ6QsPF/UzhbocxForL6roQ6RkBW/OlLjacWRhw2W/HHm7wtOBo6ZgK5exhgl
         upfEFWG+8j6F0l76UdL36c4jN155oxrLTFoWiJb73+8KansMWwq5uGexv14bg99eRTqV
         ik1OyYueIYr/Ib5HRkBf01QXa39AtNO0TjNHSj2I14DE0XLcsfnCXjhF9WF0KjGpsHiJ
         zwuix9S9LFWOPlihSkCrEr5U8al9ZHonNCS3eUhXJRc9Pmx+1hTTYZHPQDCXpHOutu4S
         N/4A==
X-Gm-Message-State: APt69E2S9qT32KwyJkfATMGkheaEw6nSL0uAsgYacJLyQRvOZl5trvtv
        HlMpy+1C1N4mioiPCsHdK4EJhkkXHlMe3ugNtBK+ow==
X-Google-Smtp-Source: ADUXVKIofOzoeNAS/8VIb4ggCLw6zHFRBhv3JoMk6ByLHJDh0cXq2h78yVMhN/5K1xhiBk1C6U9NS12jy5PtPqwaKvU=
X-Received: by 2002:a37:9241:: with SMTP id u62-v6mr13955887qkd.179.1528697513817;
 Sun, 10 Jun 2018 23:11:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:3f3d:0:0:0:0:0 with HTTP; Sun, 10 Jun 2018 23:11:53
 -0700 (PDT)
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 11 Jun 2018 16:11:53 +1000
Message-ID: <CAPM=9twGJmQ8gNt53-qTg5Spb35NSwGR5j4xFduJVsYkuKVERg@mail.gmail.com>
Subject: [git pull] drm next (msm) + fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I looked at Rob's msm tree, he kept it small due to being late, and it
was in -next for a while before he was ill, so I think it should be
fine. Otherwise this contains a set of i915 fixes and a v3d build fix,
and vc4 leak fix.

Thanks,
Dave.

drm-next-2018-06-11:
msm next, i915, vc4, v3d fixes
The following changes since commit 568cf2e6aa0c762f14d2d0d481a006f93c63ab7a=
:

  Merge tag 'drm-amdkfd-next-2018-05-28' of
git://people.freedesktop.org/~gabbayo/linux into drm-next (2018-05-30
11:12:22 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2018-06-11

for you to fetch changes up to 33ce21d6a2491ef9adb8dc395e3f5bbbfcdc95b5:

  Merge tag 'drm-intel-next-fixes-2018-06-08-2' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2018-06-09
06:34:51 +1000)

----------------------------------------------------------------
msm next, i915, vc4, v3d fixes

----------------------------------------------------------------
Abhinav Kumar (3):
      drm/msm/dsi: check return value for video done waits
      drm/msm/dsi: check video mode engine status before waiting
      drm/msm/dsi: implement auto PHY timing calculator for 10nm PHY

Archit Taneja (3):
      drm/msm/mdp5: Add global state as a private atomic object
      drm/msm/mdp5: Use the new private_obj state
      drm/msm: Don't subclass drm_atomic_state anymore

Arnd Bergmann (1):
      drm/v3d: add CONFIG_MMU dependency

Ben Hutchings (1):
      drm/msm: Fix possible null dereference on failure of get_pages()

Changbin Du (2):
      drm/i915/gvt: Fix the validation on size field of dp aux header
      drm/i915/kvmgt: Check the pfn got from vfio_pin_pages

Chris Wilson (2):
      drm/i915: Nul-terminate legacy debug string
      drm/i915: Remove stale asserts from i915_gem_find_active_request()

Colin Ian King (1):
      drm/i915/gvt: fix memory leak of a cmd_entry struct on error exit pat=
h

Daniel Mack (2):
      drm/msm: remove unbalanced mutex unlock
      drm/msm: use correct aspace pointer in msm_gem_put_iova()

Dave Airlie (3):
      Merge tag 'drm-msm-next-2018-06-04' of
git://people.freedesktop.org/~robclark/linux into drm-next
      Merge tag 'drm-misc-next-fixes-2018-05-31' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-fixes-2018-06-08-2' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next

Emil Velikov (1):
      drm/msm: don't deref error pointer in the msm_fbdev_create error path

Eric Anholt (1):
      drm/vc4: Fix leak of the file_priv that stored the perfmon.

Jani Nikula (2):
      Revert "drm/i915/edp: Allow alternate fixed mode for eDP if available=
."
      Merge tag 'gvt-fixes-2018-04-19' of
https://github.com/intel/gvt-linux into drm-intel-next-fixes

Jeykumar Sankaran (1):
      drm/msm: Add modifier to mdp_get_format arguments

Mahesh Kumar (2):
      drm/i915/icl: fix icl_unmap/map_plls_to_ports
      drm/i915/icl: Don't update enabled dbuf slices struct until updated i=
n hw

Sean Paul (7):
      drm/msm: Mark the crtc->state->event consumed
      drm/msm: Refactor complete_commit() to look more the helpers
      drm/msm: Move implicit sync handling to prepare_fb
      drm/msm: Issue queued events when disabling crtc
      drm/msm: Remove msm_commit/worker, use atomic helper commit
      drm/msm: Switch to atomic_helper_commit()
      drm/msm: Fix NULL deref on bind/probe deferral

Stefan Agner (1):
      drm/msm/dsi: use correct enum in dsi_get_cmd_fmt

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Remove bogus NV12 PLANE_COLOR_CTL setup

Xiong Zhang (1):
      drm/i915/gvt: Dereference msi eventfd_ctx when it isn't used anymore

Zhenyu Wang (1):
      Back merge 'drm-intel-fixes' into gvt-fixes

 drivers/gpu/drm/i915/gvt/cmd_parser.c      |   1 +
 drivers/gpu/drm/i915/gvt/display.h         |   2 +-
 drivers/gpu/drm/i915/gvt/handlers.c        |  13 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c           |  34 +++-
 drivers/gpu/drm/i915/i915_gem.c            |  17 +-
 drivers/gpu/drm/i915/intel_ddi.c           |   6 +-
 drivers/gpu/drm/i915/intel_display.c       |   7 +-
 drivers/gpu/drm/i915/intel_dp.c            |  38 +----
 drivers/gpu/drm/i915/intel_drv.h           |   2 -
 drivers/gpu/drm/i915/intel_dsi.c           |   2 +-
 drivers/gpu/drm/i915/intel_dvo.c           |   2 +-
 drivers/gpu/drm/i915/intel_engine_cs.c     |   2 +-
 drivers/gpu/drm/i915/intel_lvds.c          |   3 +-
 drivers/gpu/drm/i915/intel_panel.c         |   6 -
 drivers/gpu/drm/i915/intel_pm.c            |   1 -
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c |  17 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c  |   9 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c   | 105 ++++++++----
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h   |  27 +--
 drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.c |  12 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c  |  20 ++-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c |  16 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c   |  17 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c         |  14 +-
 drivers/gpu/drm/msm/msm_atomic.c           | 258 +++----------------------=
----
 drivers/gpu/drm/msm/msm_drv.c              |  11 +-
 drivers/gpu/drm/msm/msm_drv.h              |   9 +-
 drivers/gpu/drm/msm/msm_kms.h              |  14 --
 drivers/gpu/drm/v3d/Kconfig                |   1 +
 drivers/gpu/drm/vc4/vc4_drv.c              |   1 +
 30 files changed, 245 insertions(+), 422 deletions(-)
