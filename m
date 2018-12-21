Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB33C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC9621908
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiNVOpab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbeLUJTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:19:16 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37465 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731604AbeLUJTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:19:16 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so2329192pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MtWazEeQsn5yRMZWiwR22g78z8Cx/7F1Y492tFu4o4g=;
        b=NiNVOpabNaud2oJbCgAt4ne7+Jv1tJF4c0wOUMpWDA0j8ISTb0PLYob9u30P2AbKp7
         qoLIhHOuczWWKuOdX0c2aQsuR+g2K4Xs9EK8uIl6+ip+V9X5DvIVpE8pHyJLVoJTuh7L
         DLAw6942l1IgCeZV0gQy+tiLGkjcwfIf6sXfsji0Tu8CuflpMLhGulj1qUw5XYB1shqP
         ASy6YQzDSLNPDlHaXRM7a5AUEDaMpku5jgXDGMIA1pBghjuM4bAAU+PIeLzKjNsEQySb
         cBzPkElL06mELN40a3svgYqlUGPv/aNPwydjhXGKYYqUywM62ZQZNISd4YkJoK8AFozr
         oVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MtWazEeQsn5yRMZWiwR22g78z8Cx/7F1Y492tFu4o4g=;
        b=R6imD9QIfZWz+1VJcBqywzvI4QUM/NsuiQZF9BNefKZfUaYn0mCVM+TyM0aE2CaH8m
         AtpK0WYzp6Mxj9TgDV9eqGk0UR5+50xWaI3pGaJCF+6yX9Pg2MQ/1GLH7rQAAhH4oJx0
         SgR5jD9c6J7ZOusJMzNgmmnxfTkF4HPY2HY3S4z5muCbT9kFVsxuwr1EZ2CiXxP/Pasp
         hX7lmMXyVamF5qizeLDKjnnBgzNucNYH6oibJfp1NSesT3j96ZcRrItplNvlxK+9HOtr
         UJWXkF8O8IG/CgM+X0jK04GYgZrJfGla/evoj9VpZZhOeY9F6jCz8dj2YtAqArLGQaF9
         VA3w==
X-Gm-Message-State: AJcUukdmPdbWZiEMcfrNFV+WtSimmI9TG8iaAtUG4ioTnFXvN5gz61GC
        ZSuosdX2X410Cs1VaYy9jYo=
X-Google-Smtp-Source: AFSGD/Uhe/iBXtkfGLDGGKJ6Z94dzrcDV5QG0dVZQS0EysZB2AHq6tFD1iNzNtMff/nrAf4ds5wjFw==
X-Received: by 2002:a62:1212:: with SMTP id a18mr1744516pfj.217.1545383955162;
        Fri, 21 Dec 2018 01:19:15 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([2405:205:639e:5755:9c01:6fce:8e97:1323])
        by smtp.gmail.com with ESMTPSA id q5sm40117712pfi.165.2018.12.21.01.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 01:19:14 -0800 (PST)
Date:   Fri, 21 Dec 2018 14:48:54 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     rex.zhu@amd.com, evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie,
        Hawking.Zhang@amd.com, ray.huang@amd.com
Cc:     jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] drm/amd/powerplay: Remove duplicate header
Message-ID: <20181221091853.GA2319@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove hwmgr_ppt.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
index e5a60aa44b5d..07d180ce4d18 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -28,7 +28,6 @@
 #include "hardwaremanager.h"
 #include "hwmgr_ppt.h"
 #include "ppatomctrl.h"
-#include "hwmgr_ppt.h"
 #include "power_state.h"
 #include "smu_helper.h"
 
-- 
2.17.1

