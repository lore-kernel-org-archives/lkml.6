Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7ADC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB2021871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3+O3Vku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeLRNh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:37:57 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]:46925 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeLRNh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:37:57 -0500
Received: by mail-qt1-f169.google.com with SMTP id y20so18104498qtm.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=UyZeDc4VAfBNULErdIQ7Z521OSI+/psfkg7b2uzqrtM=;
        b=s3+O3Vku3DUEj9BewS/ZkzKQ8z77Q1EDc39gRAd+21aBETEFem5yd/y0y9R0QrzrTS
         kcHBebbgcCcz222vnSy+QJDQfdJaD6yh3yfJW9iWTpPTlb+CAh86hOg1VqabRoDP6jfW
         2vEfv0z7iGzlCxaEHMgXCIxtrIFEgk0UWEoQbuhTFwtBtMh4DHzdcoLfwlOpsZOGe5zQ
         6RYezSbacplqsetd/zReV03NFsn4Du9tEkUhTSK48y+L8qrjKNiyrcvMbyfve9rHwJtS
         zrVRrNHAegZjn40UIto6+KKKlhGGDX/oliYiIpyBg+eMmmYMEIM4l3TQ5LXsU2pWlv9S
         9nMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UyZeDc4VAfBNULErdIQ7Z521OSI+/psfkg7b2uzqrtM=;
        b=Et1h1l9o8rRzu+oMk7S2H7uXtrFpGHuWfzrayh3J/q+L9Z5mAR6Xai0KK3m31BBPmn
         fiOi3YHNnWc0pcTovF/3E/ID7/DbIoKpbjaM1LPNW/yvi7E/d7HdxB4Av3ZHXjbyFRrv
         Tw4E3FQFqYiW0acY3uUM/Msy/m68LKBVDG7F2CToM56n37BHtuR9q/fusLz4YbdffjBA
         7fbuzLTYn9zR52KwODo+3NHHqo1Y6Ac8SgrrtLX5RvRuYX8b9jRM4Tz/2uuplMMQuFPg
         Hg+PO6Y0n9FJPbSlWw9ERG7J7gAwnEpFzCT1eWAdrPjGOpbbfnquDsy+RQGFuoM4mqNv
         w4eQ==
X-Gm-Message-State: AA+aEWZ4rF+e266aPFkDIuJuhKh8Ic6c8qQK5fJboolZvGB+JpX3Zf4m
        FoimCdznty7AcO06ZLix8jo=
X-Google-Smtp-Source: AFSGD/XkEo66SnII/eMh4SSd01/6UC6vvFUoH3FsyEWxFepyAGYmt022u8dvnGnBF4y8/rzuNVD2gg==
X-Received: by 2002:a0c:c993:: with SMTP id b19mr16333544qvk.126.1545140274663;
        Tue, 18 Dec 2018 05:37:54 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id y12sm11139762qta.13.2018.12.18.05.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 05:37:54 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:37:49 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] drm: KMS cleanup remove drm_mode_object dependency
Message-ID: <20181218133749.h4bnf5n5ljsmr2kz@smtp.gmail.com>
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
  drm: msm: Delete base.id prints
  drm: Remove use of drm_mode_object
  drm: omapdrm: Delete base.id prints
  drm: i915: Delete base.id prints 
  drm: sti: Delete base.id prints
  drm: meson: Delete base.id prints
  drm: Complete remove drm_mode_object dependency

 drivers/gpu/drm/drm_crtc_helper.c                 |  5 ++---
 drivers/gpu/drm/drm_modes.c                       |  9 ---------
 drivers/gpu/drm/i915/i915_debugfs.c               |  4 ++--
 drivers/gpu/drm/meson/meson_dw_hdmi.c             |  9 ++++-----
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c         |  4 ++--
 drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c  |  4 ++--
 drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c  |  4 ++--
 drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c |  4 ++--
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c  |  4 ++--
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c         |  4 ++--
 drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c      |  4 ++--
 drivers/gpu/drm/msm/dsi/dsi_manager.c             |  4 ++--
 drivers/gpu/drm/msm/edp/edp_bridge.c              |  4 ++--
 drivers/gpu/drm/omapdrm/omap_connector.c          |  4 ++--
 drivers/gpu/drm/omapdrm/omap_crtc.c               |  4 ++--
 drivers/gpu/drm/sti/sti_crtc.c                    |  4 ++--
 include/drm/drm_modes.h                           | 10 ++++------
 17 files changed, 36 insertions(+), 49 deletions(-)

-- 
2.17.1

