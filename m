Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D0BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E6F217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTcipUtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbeLTMYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:24:36 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:37180 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbeLTMYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:24:35 -0500
Received: by mail-qk1-f169.google.com with SMTP id g125so831899qke.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=v3QVwSA/qYL2Rod5ZWa7RXV0BTH3kZP4WL0VtKVcVTA=;
        b=eTcipUtDy/HAh8X1j0+4N0sUqKo/X8cwSFFTQosdNC0UlbnC+QmJZMxTmkh2zIEH1t
         Zl/w2hof44yw/Ns+jKyzz9l05mkb1vcN0QHQ5FYeN7sQJWbM3W0Lm302Emcrjwo8SPdj
         H14RKvecmFOd/5PKjS7Qlj8E0qsZkYtr0gatB7epMZkbQ3PCxXrr1z3pD5kXAIt7/R2R
         ylPybtuMMmIZVxyvkLGeCqnO9nN8vPp32fU+WWQe5Z4mqP/sfzruQ0uFoz3ZkQf1jrLD
         2FeN5NflhIJZoLqWQO884UnBkpXa5oCka6b8WUfbGXj3qD9vJQf7Aq64Q4h60yJi7oRT
         c78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=v3QVwSA/qYL2Rod5ZWa7RXV0BTH3kZP4WL0VtKVcVTA=;
        b=Q2zCA/aWOqUsYUZSa34GMlb7RHNK7Aoo4rbGDTkBhrw5emvJzB6jnDKmmHGtmhhRyJ
         mvE/uDfiRVltv/2SeNVWZ3Otqr7SWxHIvcJvc5gRD4I0RdCTHcE9EAlPiLex9TR+Yj8X
         8eRy4tCV26aQk6ZKrZwYdH2I/gvT3Wxc89l/aT0CVrXSo/OMrqPqxwhmH2lVx/usal8y
         Aw6oGH0PjQjRU47yAe6L2mrQXrenkS7kpz/hEZnM/kAJcyhIi2a9W5JyWiofYlVF25ue
         agMKN3loyAnpwhIrcimdf2WIJyDiXGbZ3M//tFreOEvERuVvP1V+zcBGhrJaerjR/Vd1
         C6Lg==
X-Gm-Message-State: AA+aEWYpVr6moqUkI6QVh4OLpnPJjwvLKd75PYQ+O2bHoC1CXB0tPa86
        YJtySiARHL2q1jHqV0BP6G4=
X-Google-Smtp-Source: AFSGD/V/V9UMzDJyjD+xSgbHP06T8qeWzWHhrdw3yP+YiUlKXWXbtEWe8VOQH9fhh0VPXPGMfumZPA==
X-Received: by 2002:a37:182a:: with SMTP id j42mr23184859qkh.83.1545308674007;
        Thu, 20 Dec 2018 04:24:34 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id b134sm2706635qkg.78.2018.12.20.04.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 04:24:33 -0800 (PST)
Date:   Thu, 20 Dec 2018 10:24:27 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] drm: Remove drm_mode_object dependency from
 drm_display_mode
Message-ID: <cover.1545308167.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serie removes drm_mode_object dependency from
drm_display_mode struct. This is part of KMS cleanup.

Shayenne Moura (7):
  drm: msm: Cleanup drm_display_mode print str
  drm: omapdrm: Cleanup drm_display_mode print str
  drm: meson: Cleanup on drm_display_mode print str
  drm: sti: Cleanup drm_display_mode print str
  drm: i915: Cleanup drm_display_mode print str
  drm: Remove use of drm_mode_object
  drm: Complete remove drm_mode_object dependency

 drivers/gpu/drm/drm_crtc_helper.c             |  5 ++---
 drivers/gpu/drm/drm_modes.c                   |  9 --------
 drivers/gpu/drm/i915/i915_debugfs.c           |  9 +-------
 drivers/gpu/drm/meson/meson_dw_hdmi.c         | 12 +++--------
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c     | 10 ++-------
 .../gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c  |  9 +-------
 .../gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c  |  9 +-------
 .../gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c |  9 +-------
 .../gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c  |  9 +-------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c     |  9 +-------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c  |  9 +-------
 drivers/gpu/drm/msm/dsi/dsi_manager.c         |  9 +-------
 drivers/gpu/drm/msm/edp/edp_bridge.c          |  9 +-------
 drivers/gpu/drm/omapdrm/omap_connector.c      |  9 ++------
 drivers/gpu/drm/omapdrm/omap_crtc.c           |  8 ++-----
 drivers/gpu/drm/sti/sti_crtc.c                | 16 ++++----------
 include/drm/drm_modes.h                       | 21 +++----------------
 17 files changed, 27 insertions(+), 144 deletions(-)

-- 
2.17.1

