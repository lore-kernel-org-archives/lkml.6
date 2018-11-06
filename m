Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A7CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2892081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zIaNLWmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2892081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbeKFTE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:04:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44595 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbeKFTE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:04:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id j17-v6so7515806wrq.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 01:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=HfNnbHeKEcbPNJPvCyFTqb9/GOXtzkY2zjSPRrdIZ0U=;
        b=zIaNLWmPg4aQ/VbeWJHTDHYHF1KEiyhyptyM6clSeuWQbA1gF8kKv/xFpnkiCGBfvW
         WNPLQFVnPwKVnhwcB+ewvvrwYHxEHRW/W3AmND8ZtG8ud6+PvPtoavYtSdGEW+e2WZNj
         0t0zr0xiAB890DUbEiR1agXFaonAoHtyCGk0S9V9X+gS46vtdscc3bGC37YE0a/j7CSS
         /U2zDpE1OdLtET5DccS5IlqBsu5iUH5hKBT8Km3XcKKFQhIOHi2xm4xsU5gEIJ9oKSip
         TfpREGnsNmC3NnW6zQCz7ABq72kAe5+5jLU4Lnrw1YvMKETbosbafhDhij2X3y8SY8Q/
         +LZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HfNnbHeKEcbPNJPvCyFTqb9/GOXtzkY2zjSPRrdIZ0U=;
        b=A1mTM/Lmb63wx3JRormQz/vNYwhEjWsM6IHoprRdVGjxJ9P25B9o6yW+oxYwc48L4t
         A+ZUYUouY2OHJcp5T0/6lh9hRiL/hF6qTUR0OiEi0SmFc1oMnapGID+oHCqvzXaXOUwF
         UJj2wKsqUk7PeWmHk9gfxHcTKyGK1V854a+DeedVnD11VqJCMPHUT8ocoGOQPxyw+bON
         0Tn1u6cAvw/MoazN2VNeiS83YBMwZxFTfqUxJyNIrCvJJ4fnhwDqmZEJssY/pWojD4nX
         8IOcTrn1UATgqOC80Ld7hZUbMDq8Tkl6j7gw5SpO/g/3o5Nc6Tlc1yXfiQYI+yOOW4j8
         XRLg==
X-Gm-Message-State: AGRZ1gK0OTc9LwUNtdthzC8TsRSu4ILiqaNJqldxsopeYf0WblIgK1FP
        7NfUrE0F1yDw6C3SUHP4wI9Jxg==
X-Google-Smtp-Source: AJdET5deUI1UAnHLkabLrYT3aEMYhbX/f3/WJb0MAx6ub55jn+fAOA/XU42/vnrFMVBPgDUQvhZ+RQ==
X-Received: by 2002:a5d:6a8d:: with SMTP id s13-v6mr7707642wru.179.1541497205423;
        Tue, 06 Nov 2018 01:40:05 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u13-v6sm29682434wrn.11.2018.11.06.01.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 01:40:04 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] drm/meson: Add support for Overlay and OSD Plane scaling
Date:   Tue,  6 Nov 2018 10:39:59 +0100
Message-Id: <1541497202-20570-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie adds support for :
- Overlay Plane blended with the primary plane, we can describe as "behind"
- Primary Plane up-scaling up to 5x factor to support the OSD plane being
  upscaled from 1920x1080 when the display mode is set as 3840x2160.

These patches depends on the "drm/meson: Allow using optional canvas provider"
patchset from Maxime Jourdan at [1]

[1] https://patchwork.kernel.org/project/linux-amlogic/list/?series=38355

Neil Armstrong (3):
  drm/meson: Support Overlay plane for video rendering
  drm/meson: move OSD scaler management into plane atomic update
  drm/meson: Add primary plane scaling

 drivers/gpu/drm/meson/Makefile          |   2 +-
 drivers/gpu/drm/meson/meson_canvas.c    |   7 +-
 drivers/gpu/drm/meson/meson_canvas.h    |  11 +-
 drivers/gpu/drm/meson/meson_crtc.c      | 251 +++++++++++++-
 drivers/gpu/drm/meson/meson_drv.c       |  29 +-
 drivers/gpu/drm/meson/meson_drv.h       |  62 ++++
 drivers/gpu/drm/meson/meson_overlay.c   | 586 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/meson/meson_overlay.h   |  14 +
 drivers/gpu/drm/meson/meson_plane.c     | 177 ++++++++--
 drivers/gpu/drm/meson/meson_registers.h |   3 +
 drivers/gpu/drm/meson/meson_viu.c       |  15 +
 drivers/gpu/drm/meson/meson_vpp.c       |  90 +++--
 12 files changed, 1156 insertions(+), 91 deletions(-)
 create mode 100644 drivers/gpu/drm/meson/meson_overlay.c
 create mode 100644 drivers/gpu/drm/meson/meson_overlay.h

-- 
2.7.4

