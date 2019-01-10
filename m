Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37B8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C455F20675
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMruC4Xn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfAJSMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:12:48 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:40525 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbfAJSMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:12:47 -0500
Received: by mail-qt1-f173.google.com with SMTP id k12so14414775qtf.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 10:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=du4cHmvLaNpNMXPqmT7jPItBhyywFgz9Z2Vo8Rf2LeU=;
        b=LMruC4XnTIr6pXpwgY3k0lPRdrNzMBTChgqLdYhNZkIPU6t7Aq4wjDD3hziWIMxBjp
         6naFcibk/9VoP5wfxnMNiJjYdr76I+9znG00Bfot+7gJuI3nl/Je105vbWy/WvQFatHA
         LMPPCnS6Z1JLh0qk7zmxWMjVU646Hc5idScfOZf4Jxf53FpDQNa/kXv9m8J3xas7mlEc
         uO0d3pGRvx1sH1c6lOoM6Lao/6x9Ry6EazJy21awlFht5sIL0UoH2qhZhx99/tNKm+1C
         6p6PGrIrHg2bs5bSqZAkjyO2Ar9WN/f5f0QiSq86UQkSMur/Cnn1kEbPNHr5VJzog0X2
         ugRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=du4cHmvLaNpNMXPqmT7jPItBhyywFgz9Z2Vo8Rf2LeU=;
        b=MlMmqj5uBgHAovTlVru2WgxRZHj2uHntnOPLzln88C8aK+ewR32pwD2YGxnr5nX4aw
         In/DudQRzPrc4B76EGB8GT174gCD8GB/tJNYq7fBUWkjdng6jt9zjoTn5CJkaYOt0qFJ
         aigbM/jY+pfJfbJQ8SFPl6N4pFR3ACO0Ru7/aFczyubGrntwq5RsgVRQOj0NVyBJ041k
         2laF7RCEaHjw420bvcC9sLt0i6k0gcrI/Pre1fu/w/Ff7EX7XkoX0LrouLKHCSFoOWUa
         SCariSmgRhHnRU3v3Juj2Qa4BArcZQWIqKDU4DknmyncwWbltlWFuUBA209b/WgPZP5N
         uIdA==
X-Gm-Message-State: AJcUukek14VRxy0FiuOFhTcrXKDI3DB+hNqrJOKa4EK6fAYhu83OgtFI
        yjZXpwzy7+eDg63+KeN8UxJJJTzwR5k=
X-Google-Smtp-Source: ALg8bN7fECUJ5fk9bVOAZIyrcenvjyFU5DZJwFW2uwXc57xc8/iUS89XYOZroQ0qDLA4d/Bw7+WoQA==
X-Received: by 2002:ac8:fb4:: with SMTP id b49mr10686857qtk.2.1547143966032;
        Thu, 10 Jan 2019 10:12:46 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o48sm43038705qtb.87.2019.01.10.10.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 10:12:45 -0800 (PST)
Date:   Thu, 10 Jan 2019 16:12:39 -0200
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
Subject: [PATCH v4 0/3] drm: Remove drm_mode_object dependency from
 drm_display_mode
Message-ID: <cover.1547143069.git.shayenneluzmoura@gmail.com>
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

---
Changes in v2:
  - Make alterations suggested by Daniel and commit messages clear

Changes in v3:
  - Solve typo in first patch in v2

Changes in v4:
  - Remove patches already merged

Shayenne Moura (3):
  drm: msm: Cleanup drm_display_mode print str
  drm: Remove use of drm_mode_object
  drm: Complete remove drm_mode_object dependency

 drivers/gpu/drm/drm_crtc_helper.c             |  5 ++---
 drivers/gpu/drm/drm_modes.c                   |  9 --------
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c     | 10 ++-------
 .../gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c  |  9 +-------
 .../gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c  |  9 +-------
 .../gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c |  9 +-------
 .../gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c  |  9 +-------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c     |  9 +-------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c  |  9 +-------
 drivers/gpu/drm/msm/dsi/dsi_manager.c         |  9 +-------
 drivers/gpu/drm/msm/edp/edp_bridge.c          |  9 +-------
 include/drm/drm_modes.h                       | 21 +++----------------
 12 files changed, 15 insertions(+), 102 deletions(-)

-- 
2.17.1

