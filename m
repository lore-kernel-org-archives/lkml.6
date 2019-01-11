Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02341C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B249E2184A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="U7nVVNKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfAKXG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:06:57 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42267 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfAKXG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:06:57 -0500
Received: by mail-ed1-f68.google.com with SMTP id y20so14320042edw.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 15:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=d3wFBiZQGaptddMW2YDhafQpe03j9Kwe7r0gU1Qveo8=;
        b=U7nVVNKSLbv90P34iqye+0tqsFBd4VZ9C3l6Hc4xXC7qPpWAoUZPkZ/qAIWohvb9RG
         +60T+zNQ386PFZi0+B4Qytk8rT31elM2g49aHoxAQ7EeHQskSo8swSkxuAez78q3BKZ6
         0SyRuOPTYYv05OQDr+5E66ns8ZeRYTnVH3xgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=d3wFBiZQGaptddMW2YDhafQpe03j9Kwe7r0gU1Qveo8=;
        b=UIVyZMnMyoYFGmgMQFWXMr3qwah1AVJOK0h/5Oes+budmshEgnl0kazvemOw5tm56o
         LLXZlfg8wa1gnoPw9bc4yV4fvyR1Xytz6nCWzj+Sv4gvt949PyFzPnvTZbLBmp+TQgMF
         kInD32QizAaA+mCTHMBkjFv4Lc6MBcWv6ZVATM9yctw1Jxsp5PvFZTYArQTx5k87KDkb
         WiKxYSCoW3REi84oyO9jcAl76FBE8m9NOD7lNeOz249jNMheV9flMlWZmKfiiP8qsuGT
         UPGigFTZADCeKOiyVZooA+Jye2ld8/doFgLABCmTzrIy2Px460On9QqJ0ErRPfVZkyoA
         7IJA==
X-Gm-Message-State: AJcUukf0c9P+aFMYRSK5c9+Sp1JOkbku+YEeSSHvNRAahYvYjl8/OTIX
        HOFktVAvHUAD7BmRP7X8h0d1BA==
X-Google-Smtp-Source: ALg8bN7ehxK6oED9qZqAX1Vh42HFZki61Ks7hjjLssPi96iWywWQ3aWTawEUiPg70TCtUX2aE0J13w==
X-Received: by 2002:a17:906:a35a:: with SMTP id bz26-v6mr9493787ejb.98.1547248014735;
        Fri, 11 Jan 2019 15:06:54 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id r18-v6sm1675211eja.19.2019.01.11.15.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 15:06:54 -0800 (PST)
Date:   Sat, 12 Jan 2019 00:06:48 +0100
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PULL] drm-fixes
Message-ID: <20190111230648.GA18543@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Dave sends out his pull, everybody remembers holidays are over :-)

Since Dave's already in w/e mode and it was quite a few patches I figured
better to apply all the pulls and forward them to you. Hence here 2nd part
of bugfixes for -rc2.

nouveau:
one backlight, falcon register access, and a fan fix.

i915:
- Disable PSR for Apple panels
- Broxton ERR_PTR error state fix
- Kabylake VECS workaround fix
- Unwind failure on pinning the gen7 ppgtt
- GVT workload request allocation fix

core:
- Fix fb-helper to work correctly with SDL 1.2 bugs.
- Fix lockdep warning in the atomic ioctl and setproperty.

Cheers, Daniel

The following changes since commit f34c48e06ddcc197f2cf7cbc006ceb74e28e1ccf:

  Merge branch 'drm-fixes-5.0' of git://people.freedesktop.org/~agd5f/linux into drm-fixes (2019-01-11 07:38:56 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-01-11-1

for you to fetch changes up to e2d3c414ec0f9d1557c8c5ff2c32166e68bbc4ad:

  Merge tag 'drm-intel-fixes-2019-01-11' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2019-01-11 10:26:21 +0100)

----------------------------------------------------------------
drm-fixes for 5.0-rc2, part 2

nouveau:
one backlight, falcon register access, and a fan fix.

i915:
- Disable PSR for Apple panels
- Broxton ERR_PTR error state fix
- Kabylake VECS workaround fix
- Unwind failure on pinning the gen7 ppgtt
- GVT workload request allocation fix

core:
- Fix fb-helper to work correctly with SDL 1.2 bugs.
- Fix lockdep warning in the atomic ioctl and setproperty.

----------------------------------------------------------------
Ben Skeggs (1):
      drm/nouveau: register backlight on pascal and newer

Chris Wilson (2):
      drm/i915: Skip the ERR_PTR error state
      drm/i915: Unwind failure on pinning the gen7 ppgtt

Daniel Vetter (2):
      Merge tag 'drm-misc-fixes-2019-01-10-1' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2019-01-11' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Daniele Ceraolo Spurio (1):
      drm/i915: init per-engine WAs for all engines

Dave Airlie (1):
      Merge branch 'linux-4.21' of git://github.com/skeggsb/linux into drm-fixes

Ilia Mirkin (1):
      drm/nouveau/falcon: avoid touching registers if engine is off

Ivan Mironov (2):
      drm/fb-helper: Partially bring back workaround for bugs of SDL 1.2
      drm/fb-helper: Ignore the value of fb_var_screeninfo.pixclock

Jani Nikula (1):
      Merge tag 'gvt-fixes-2019-01-09' of https://github.com/intel/gvt-linux into drm-intel-fixes

José Roberto de Souza (2):
      drm/i915: Disable PSR in Apple panels
      drm: Fix documentation generation for DP_DPCD_QUIRK_NO_PSR

Takashi Iwai (1):
      drm/nouveau: Don't disable polling in fallback mode

Tetsuo Handa (1):
      gpu/drm: Fix lock held when returning to user space.

Zhenyu Wang (1):
      drm/i915/gvt: Fix workload request allocation before request add

 drivers/gpu/drm/drm_atomic_uapi.c                |   3 +-
 drivers/gpu/drm/drm_dp_helper.c                  |   2 +
 drivers/gpu/drm/drm_fb_helper.c                  | 133 ++++++++++++++---------
 drivers/gpu/drm/drm_mode_object.c                |   4 +-
 drivers/gpu/drm/i915/gvt/scheduler.c             |  64 +++++++----
 drivers/gpu/drm/i915/gvt/scheduler.h             |   1 +
 drivers/gpu/drm/i915/i915_debugfs.c              |  12 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c              |  15 ++-
 drivers/gpu/drm/i915/i915_gpu_error.c            |  23 ++--
 drivers/gpu/drm/i915/i915_sysfs.c                |   4 +-
 drivers/gpu/drm/i915/intel_lrc.c                 |   3 +-
 drivers/gpu/drm/i915/intel_psr.c                 |   6 +
 drivers/gpu/drm/nouveau/nouveau_backlight.c      |   3 +
 drivers/gpu/drm/nouveau/nvkm/engine/falcon.c     |   7 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c |   7 +-
 include/drm/drm_dp_helper.h                      |   7 ++
 16 files changed, 192 insertions(+), 102 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
