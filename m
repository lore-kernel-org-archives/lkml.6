Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F38C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB31C20874
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hwsi6ngZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfAJRPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:15:19 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:39056 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbfAJRPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:15:18 -0500
Received: by mail-qt1-f181.google.com with SMTP id u47so14062216qtj.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vptgO8luquUdrl132GMBjMAnkNeZcOlBF0ROPIwjqak=;
        b=Hwsi6ngZof+Z0IjyEDDi1S0iLqbOIkuSH846XB8wzFQBaw0uL8WukjRCaB1P6t/Y2S
         PQGx4wu0zsJQKNu8RGvDlGmOYEX0TW46qJfwIl8eus1qqdxpm1yzDO1FHT/1TmqnPTt2
         cLxvNNbN0EExf3XmfSMIjdt2ZuSTF6w9xkyQO1YwOt8TG4nyrmxW6yLSwtDmGYE7VWf+
         8uU2DtGbOAmtkqgs3jvOkI+YwP1FPsk0Y6AOvjziN/Xw7fekXVDtT7nHPCa927kfypyi
         HB7Dv06WsZ8UWyEH9kkI4xvDeRjks4c66WUumCchubK2qt6rCybmLirt1g7wSTXJVfLO
         DXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vptgO8luquUdrl132GMBjMAnkNeZcOlBF0ROPIwjqak=;
        b=CPAPij8hQZASaNgwfFUCnz8jJf7lbJbubMRqA2M3dlKDYqMErid/F7oiAPHPYyM5O9
         dmf0ASZvJ4qqge/KHPcTB6js6/9+1RlIHysA5TJiIWRkGe1s8Azd4BQuOV9Z/Qp1OJ4g
         64Y+JG79lYnzkoFIpvuK+m//0SVx7aWBXX/pEdJ230yIoYqyiKMI7xfM0uYHCZJESHNp
         jqqN0JWFrLfWMKIan4cEiw6RDIilC2PMo+b+exzLWGxIPaP4jk/pCdjiZd87kMbVw0aA
         R39xyg9e3l/okayydQ0dqX3mh9x0tSz0BYKo0OjS7s7g2vfZP88VL0ElXJ9Ish70nSd/
         VO9g==
X-Gm-Message-State: AJcUukdRrezaLohhhnBeBUYp53xUJKeRBweKOIWJ3MBV5EpqtKEb3tQl
        UgfFjO40vvPok07MkiqUhbX10d0/YJY=
X-Google-Smtp-Source: ALg8bN7/PuHT2Ij7P8PVtmTjiWylXgmlthz+dEvDnLhRfKWn2aedrycuEsK4RXweSM62xr8eCUa+Xg==
X-Received: by 2002:a0c:8322:: with SMTP id j31mr10639509qva.56.1547140517110;
        Thu, 10 Jan 2019 09:15:17 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e89sm35789152qtb.78.2019.01.10.09.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 09:15:16 -0800 (PST)
Date:   Thu, 10 Jan 2019 15:15:10 -0200
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
Subject: [PATCH v3 0/7] drm: Remove drm_mode_object dependency from
 drm_display_mode
Message-ID: <cover.1547137815.git.shayenneluzmoura@gmail.com>
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
Changes in v3:
  - Solve typo in first patch in v2

Changes in v2:
  - Make alterations suggested by Daniel and commit
    messages clear

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

