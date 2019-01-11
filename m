Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2A9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2888B206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRUhRlGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391374AbfAKOpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:45:36 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46974 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731160AbfAKOnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:43:51 -0500
Received: by mail-qk1-f196.google.com with SMTP id q1so6603557qkf.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bR3O/ILMKXurufv9EY0PLhXSu6qNHdsYELjz/AC8CYc=;
        b=iRUhRlGE0ErZu6di59ViUz+1pIrOa2UddJsVySuws0esGjzRlF4Lek5ynMN2gK0Lo5
         dj13ru4xIAbNNyOTC446ONoOlrwWkDjeJYRfXNDzRdBonlTzoQczezuxPfyuw4KeNNA0
         MnhEUvzdtJ22KL2uEcn0+T99adVYrR6/6PhGkQcNIvO59WSGQToj+hn3FYKJMm3JBf8Z
         rWtfEfzy2P7K6hU7Y3FcVFzuANptTuj/lFcVAcqQomrtbmzKN8pDbOHz8F2wv1RLil1U
         EVb5fFx6Wyqdas2BB/9C7BXZ7rwHPaKlhv0Lcmq4ImWrzb9mkBNGcV+5xa7nfZ7ienjx
         CyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bR3O/ILMKXurufv9EY0PLhXSu6qNHdsYELjz/AC8CYc=;
        b=TjDPBCPmmrUiyHmAF4yvPB7gKDOmRIKVbNsq/pf3UTK4Ccxczd6qI7+4c5VwSzPrx2
         DBiz8Hco1zqwqqTi0TWOCLHUzqD0CuvyR6vw2fJnasKfLi3VkThyR7nBO2Rqd7U4A6Aq
         QFL/MG5xZMD131eZ0zZy0+AzYe2PHKYtqGl61JD7NibGEU4N4dWCfz8JMdf2oXXoDZ7J
         Z2rEXNmI8MeLSaNYZsWo8y7mafWiRPpjprPr8f8fO5GsG1ZnvH3gFJWa+pp3jvyxeXWI
         IaqXsV5W+4mO6ZAGPYtijVu97/qSHT9nOD8l45YX2a80ek67lfCpu2zL6EJg4Gv70wDe
         Ouig==
X-Gm-Message-State: AJcUukd//y31sZLWHSfQwDHC3Nqe4MT5HVfAEPLMxSQ2R8m0Rd2bXhIH
        mIOgCVckwDaPuWoNyOKHSTE=
X-Google-Smtp-Source: ALg8bN5TM7LR5TzWLbmloPSnbtjP2KDx3tFVnMZPCvECjs3B0p40TNwuxPIeiEZwFJLuywpqMVJa9w==
X-Received: by 2002:a37:9e0d:: with SMTP id h13mr13316288qke.260.1547217830250;
        Fri, 11 Jan 2019 06:43:50 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id u67sm39059418qki.22.2019.01.11.06.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:43:49 -0800 (PST)
Date:   Fri, 11 Jan 2019 12:43:42 -0200
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
Subject: [PATCH v5 0/3] drm: Remove drm_mode_object dependency from
 drm_display_mode
Message-ID: <cover.1547214023.git.shayenneluzmoura@gmail.com>
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

Changes in v5:
  - Add patch to cleanup armada driver

Shayenne Moura (3):
  drm: armada: Cleanup drm_display_mode print str
  drm: Remove use of drm_mode_object
  drm: Complete remove drm_mode_object dependency

 drivers/gpu/drm/armada/armada_crtc.c |  8 +-------
 drivers/gpu/drm/drm_crtc_helper.c    |  5 ++---
 drivers/gpu/drm/drm_modes.c          |  9 ---------
 include/drm/drm_modes.h              | 21 +++------------------
 4 files changed, 6 insertions(+), 37 deletions(-)

-- 
2.17.1

