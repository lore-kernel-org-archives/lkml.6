Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C46FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462B92133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbeLSNGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:06:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:28501 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbeLSNGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:06:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 05:06:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,372,1539673200"; 
   d="scan'208";a="131254901"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 19 Dec 2018 05:06:20 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/7] drm: KMS cleanup remove drm_mode_object dependency
In-Reply-To: <20181218133749.h4bnf5n5ljsmr2kz@smtp.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20181218133749.h4bnf5n5ljsmr2kz@smtp.gmail.com>
Date:   Wed, 19 Dec 2018 15:07:48 +0200
Message-ID: <87woo5vf4r.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018, Shayenne Moura <shayenneluzmoura@gmail.com> wrote:
> This patch serie removes drm_mode_object dependency from 
> drm_display_mode struct. This is part of KMS cleanup.  

For future reference:

Please use git-send-email or fix the mail threading otherwise. Patches
1-7 should be in reply to the cover letter.

Please justify the changes in the commit messages. Your current commit
messages focus on *what* is being done, which is fairly obvious from the
changes themselves. Please try to describe *why* this is being
done. That's more important for posterity. (In this case, it's basically
explained in the FIXME comment being removed in patch 7, as well as
Documentation/gpu/todo.rst.)

BR,
Jani.


>
> Shayenne Moura (7):
>   drm: msm: Delete base.id prints
>   drm: Remove use of drm_mode_object
>   drm: omapdrm: Delete base.id prints
>   drm: i915: Delete base.id prints 
>   drm: sti: Delete base.id prints
>   drm: meson: Delete base.id prints
>   drm: Complete remove drm_mode_object dependency
>
>  drivers/gpu/drm/drm_crtc_helper.c                 |  5 ++---
>  drivers/gpu/drm/drm_modes.c                       |  9 ---------
>  drivers/gpu/drm/i915/i915_debugfs.c               |  4 ++--
>  drivers/gpu/drm/meson/meson_dw_hdmi.c             |  9 ++++-----
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c         |  4 ++--
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c  |  4 ++--
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c  |  4 ++--
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c |  4 ++--
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c  |  4 ++--
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c         |  4 ++--
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c      |  4 ++--
>  drivers/gpu/drm/msm/dsi/dsi_manager.c             |  4 ++--
>  drivers/gpu/drm/msm/edp/edp_bridge.c              |  4 ++--
>  drivers/gpu/drm/omapdrm/omap_connector.c          |  4 ++--
>  drivers/gpu/drm/omapdrm/omap_crtc.c               |  4 ++--
>  drivers/gpu/drm/sti/sti_crtc.c                    |  4 ++--
>  include/drm/drm_modes.h                           | 10 ++++------
>  17 files changed, 36 insertions(+), 49 deletions(-)

-- 
Jani Nikula, Intel Open Source Graphics Center
