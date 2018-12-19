Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5B8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EDA20869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4McKr8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbeLSVV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:21:27 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33894 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbeLSVV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:21:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id q8so10374092qke.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 13:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=EfAp0fY9U6Td9408HAXaoEqT/EOAq/61kzOo7ggrq7I=;
        b=X4McKr8vaJusTfDjX1ehlV86luKJMDBNeIXhr01LpYoEreCNqhk1/ELQ1V+H8gTvNJ
         k6+k6eSmJVmsA0W8tQ3BU2P+g544J74YgCt1VCLzZk2yJWt5l715vFH8nENjt9yxRVaX
         fCk0JiARmsMUB2mchxRJqsU3PN9hzUeSAPcawAKwSDtscMGH39gAB3uKqnbKVUhKHlyU
         h+MqleQS8VvoGk95qV5kjtr3qrhX1r1c7WUfyZMBQK04jjCvCTF/sthanhgD8gpko9Hd
         P1eREw2HGUjkV+VSyrxI8QMm+Cz3OeAV5WHp075SkhqjYsJRCaEWMweVaLQNSpV1/2wV
         E8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EfAp0fY9U6Td9408HAXaoEqT/EOAq/61kzOo7ggrq7I=;
        b=TFGpF2vQSTUgMNsFpFSN9utJoqKlshdsffvm2wIPXLtzWWEg7g2L2czRrKO1OlTPXd
         7QY5dup8zk8tK9mK9qX809tXrpmq8PmHv1Uz5YWYsVJjrA2UNNs8PUTSGI0uePLUr8Pk
         ieX9vSfdQ8y+GKdc9EMm1tx7G97WsJxgaJneR+hqVkwg11DAk27uqVuzdny1FM5/agOa
         4x8o5wkfpxbyZulORLYP1GCE58Yp5+jsrj94R6nlb/dnCFUHoj/0b3QEHkTFWMBE7oR7
         JE7xXvNYZOeiNikhBwDLprwY6kQnrcyEbIs9Kv3kobvaM5m7x82r8WjFzsy0Iu6YECE8
         fOzw==
X-Gm-Message-State: AA+aEWbjDiqF2klM1PGMOc5fdRU+z6kabs4oTjySl2KINGHri2pzqWh/
        YiO3inBwoKvZiSvjlD/1v2oGnRfovFk=
X-Google-Smtp-Source: AFSGD/VWZqXRSFshK4Yy24Aolb56C1eXm41eFrcAWvta6Dr0AxJFil++95b9X+fJswmtHGzQdojqUA==
X-Received: by 2002:a37:9201:: with SMTP id u1mr22540087qkd.258.1545254485442;
        Wed, 19 Dec 2018 13:21:25 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id t33sm2242059qtj.76.2018.12.19.13.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 13:21:24 -0800 (PST)
Date:   Wed, 19 Dec 2018 19:21:20 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] drm: Remove drm_mode_object dependency from
 drm_display_mode
Message-ID: <cover.1545254191.git.shayenneluzmoura@gmail.com>
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

The motivation is that a display mode is a normal modeset object,
possibly including public userspace id.
This can be removed since the entire concept of userspace
managing modes explicitly has never landed in upstream kernel mode
setting support.

Shayenne Moura (7):
  drm: msm: Cleanup drm_display_mode print string
  drm: omapdrm: Cleanup drm_display_mode print str
  drm: meson: Cleanup on drm_display_mode print str
  drm: sti: Cleanup drm_display_mode print str
  drm: i915: Cleanup drm_display_mode print str
  drm: Remove use of drm_mode_object
  drm: Complete remove drm_mode_object dependency

 drivers/gpu/drm/drm_crtc_helper.c             |  5 ++---
 drivers/gpu/drm/drm_modes.c                   |  5 -----
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
 17 files changed, 27 insertions(+), 140 deletions(-)

-- 
2.17.1

