Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0F7C5AC75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0388F2184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2LIFhCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeLXOcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 09:32:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35317 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeLXOcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 09:32:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so5656154pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 06:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=J/+fOrtwNwGwbdFwJAS0lsNmr2aCS8I6d6/0qkR3YFw=;
        b=d2LIFhCddg+rMCCfxqSilvwVpTQ6QAi5GxvRv+Fjo0/9PCpHOsODzAr+9Jce6JRFGA
         6aSIWgZ7L6rroEJoeoVEc7OgjBYHDJadDC9me6yaPgjBXx/Ve0Pno0JFElN+6No4qSMt
         mUZ/rscqTi/5W1HJc1ulY/Wg/dM+gPcLvz6WFOhNu24WD0E9e6UeVPD0bHzmirK8k4j+
         gllRdLRlI5lpxCfxnwVBZ+gddwms0zOgCKw6q/I5D1fy/Kg9w04DVG7pQkg+Ol+6zRPk
         kDWtjrLqkiKAoYYzS9bmINsBP00cdZtvi/iDHbFlPRhOUaiztJFf5LL4rPQG/IhzysxR
         VPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=J/+fOrtwNwGwbdFwJAS0lsNmr2aCS8I6d6/0qkR3YFw=;
        b=lxzV0ORXyXtIKHS1N82fUyG50c7rFi6X2aTkzTQTc2jh3HpGEFNsXKD+658t/hUaCm
         bQa6LOVSymHEl0IN2atRjqj1YJBYfBGBT70suFXVySYXfW76HozAAAV2UMZDopTfY0sm
         OuG5L9oQMgPT+weJgTMZxzVpLCBcDVqhWEORJFWWUOptcwcd2aWePLRZtP5NigPykiho
         CSbXoyaPjEn5t5BOgj0sW68WyZh1YAi64JO0fK0aTOEydvAB0BeQYvl78eZ3u9Ziku8e
         yVEYx9NLW0SGPAs0MBJklYhc6nhHy+THpzRRT/DiC6M7Ta8t78N/EtsIk6pzZbazV29t
         NadQ==
X-Gm-Message-State: AA+aEWaxAnplo4Cn1Omaawx5hiM+LyT04yvTE/L/XmRSqAriTbDimPol
        wy2i3735hYV1+GLEyO4wJvI+V9Ii
X-Google-Smtp-Source: AFSGD/XZCPU3m5nQDIS7fHuqOerTfSXK6AzKamzyQTEsza8Agu225bUkf9YQ2Lo2LCDP3MjZWhxoGA==
X-Received: by 2002:a62:4851:: with SMTP id v78mr13462092pfa.97.1545661943570;
        Mon, 24 Dec 2018 06:32:23 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([2405:204:4426:2a30:1140:b12d:deb2:6ca8])
        by smtp.gmail.com with ESMTPSA id 24sm96118331pfl.32.2018.12.24.06.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 06:32:22 -0800 (PST)
Date:   Mon, 24 Dec 2018 20:02:18 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie
Cc:     jrdr.linux@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: [PATCH] drm/bridge/panel: Remove duplicate header
Message-ID: <20181224143218.GA3170@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove drm/drm_panel.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/bridge/panel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 7cbaba213ef6..402b318eeeb2 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -15,7 +15,6 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_modeset_helper_vtables.h>
-#include <drm/drm_panel.h>
 
 struct panel_bridge {
 	struct drm_bridge bridge;
-- 
2.17.1

