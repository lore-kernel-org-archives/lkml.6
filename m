Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CBCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA5A217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6prnzZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeLSQkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:40:21 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46621 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbeLSQkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:40:21 -0500
Received: by mail-qt1-f195.google.com with SMTP id y20so22879272qtm.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 08:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UyIA08uJq0wQTVUlVEcTAiGL0N9tihTC7NfxPiMfc00=;
        b=u6prnzZ61LDpL6vu59A/6Gjbs30by/ELLGRfUT7yccoa8TmZJhqckMzgsuJNd0FArQ
         9k9YX5iUI0RovSuaIbazJFKWMMM6JROZyDoKkleAg00LTCiRMHiP+gpSVxKiidygHRvX
         WOO3aJKp+LL3UMl0VryVhs4KD3LlVA6AxeZVLj1q6XVtKyrs6vbk1DyRcb9/xNJIKtfW
         fQD0Se4RYoCQXYzdQBLUcl2vQ0Ln25hO7G0TRvZCexfMW1xgbW1n+syq8RbjRBeEQheq
         N6XOnpmyU0wE/ELbaeqzVm8byJKAlGSqA3NEAu4V2O1R2T7NoOIl7MxZdrBfkWFuuiKE
         kXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UyIA08uJq0wQTVUlVEcTAiGL0N9tihTC7NfxPiMfc00=;
        b=CpY+BPKs/a2aG9Opbyw10CiBbaN/W+dWucGp07ayirS+mEU+8+K+v5ckpQl327QE9R
         g/sXs4lgL1Z/6SH0lNtz12lOg2csL+SlDKV0nGMb5ayh8jJnz1ZJd2uEAnIdgWDldLnZ
         P4b1JQzFVayOlOQEyH4ttvWTbtG6U9xxfHN/neQ/UaZKC/BKOXQb976OZHR6HqSBxKT/
         N/gLNWgJVgjVsVvOw/ZtmXoIl/yf4XrcAzFATIBMwBnwiIdIP4XHxCS1efYaFfI8m3JT
         36Ztz/6XthLfPI+X7N8ewHPxmEIBhcIm58ISCSBTUgnUsaSObz4SeFDFlX0MpOC7UmES
         lsAA==
X-Gm-Message-State: AA+aEWayRJ6sD5jZvNehhwrZzbkAIAHCbkfC3Q2jWE9KPey1vubIuM+C
        8sGkZeB34E+Xvc7R86O4JVgAu6Py2yg=
X-Google-Smtp-Source: AFSGD/XOYgyrFx/WSvzfNp7P6X53bj6XkUVuMDmk8ad0BLYWmQxtLOe3zz2JPklioYk3GA8ktZmFWg==
X-Received: by 2002:ad4:41d0:: with SMTP id a16mr22223998qvq.55.1545237619560;
        Wed, 19 Dec 2018 08:40:19 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id p31sm2689341qkh.86.2018.12.19.08.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 08:40:18 -0800 (PST)
Date:   Wed, 19 Dec 2018 14:40:13 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/7] drm: KMS cleanup remove drm_mode_object dependency
Message-ID: <20181219164013.dr7vgfbs2w3jtix7@smtp.gmail.com>
References: <20181218133749.h4bnf5n5ljsmr2kz@smtp.gmail.com>
 <87woo5vf4r.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87woo5vf4r.fsf@intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19, Jani Nikula wrote:
> On Tue, 18 Dec 2018, Shayenne Moura <shayenneluzmoura@gmail.com> wrote:
> > This patch serie removes drm_mode_object dependency from 
> > drm_display_mode struct. This is part of KMS cleanup.  
> 
> For future reference:
> 
> Please use git-send-email or fix the mail threading otherwise. Patches
> 1-7 should be in reply to the cover letter.
> 
Sorry about that, 
> Please justify the changes in the commit messages. Your current commit
> messages focus on *what* is being done, which is fairly obvious from the
> changes themselves. Please try to describe *why* this is being
> done. That's more important for posterity. (In this case, it's basically
> explained in the FIXME comment being removed in patch 7, as well as
> Documentation/gpu/todo.rst.)
> 
> BR,
> Jani.
> 
Okay, thank you! But I should write on every patch why I am doing or
just on the cover letter?

Bests,
Shayenne
> 
> >
> > Shayenne Moura (7):
> >   drm: msm: Delete base.id prints
> >   drm: Remove use of drm_mode_object
> >   drm: omapdrm: Delete base.id prints
> >   drm: i915: Delete base.id prints 
> >   drm: sti: Delete base.id prints
> >   drm: meson: Delete base.id prints
> >   drm: Complete remove drm_mode_object dependency
> >
> >  drivers/gpu/drm/drm_crtc_helper.c                 |  5 ++---
> >  drivers/gpu/drm/drm_modes.c                       |  9 ---------
> >  drivers/gpu/drm/i915/i915_debugfs.c               |  4 ++--
> >  drivers/gpu/drm/meson/meson_dw_hdmi.c             |  9 ++++-----
> >  drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c         |  4 ++--
> >  drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c  |  4 ++--
> >  drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c  |  4 ++--
> >  drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c |  4 ++--
> >  drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c  |  4 ++--
> >  drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c         |  4 ++--
> >  drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c      |  4 ++--
> >  drivers/gpu/drm/msm/dsi/dsi_manager.c             |  4 ++--
> >  drivers/gpu/drm/msm/edp/edp_bridge.c              |  4 ++--
> >  drivers/gpu/drm/omapdrm/omap_connector.c          |  4 ++--
> >  drivers/gpu/drm/omapdrm/omap_crtc.c               |  4 ++--
> >  drivers/gpu/drm/sti/sti_crtc.c                    |  4 ++--
> >  include/drm/drm_modes.h                           | 10 ++++------
> >  17 files changed, 36 insertions(+), 49 deletions(-)
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center
