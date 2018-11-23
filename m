Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44B3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 03:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8847620864
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 03:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hm/6Qhpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8847620864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408030AbeKWOA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 09:00:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45547 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731670AbeKWOA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 09:00:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so2687926pfd.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 19:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xUDENgctdgjBBXz8A4lFhbVhjs4qM3NtkZOrYf6xwoU=;
        b=Hm/6QhpxTqHrRWT/OFTIjyQO2oxByLUD4rWTdg01Ekc2G/CSNggvm/Ia7keCskv483
         +FIED5HghImK18wPehpirHfEc1CHKOOfrXySBzY6Q+G6aXbAhM453LZbvM8PmplNQFk8
         OxnR0CLt+4/xpIsBpzcrChzVDtIxGy/y6JUrPKcZyBrSZJAr5122/FgwPsx+wqE04YU7
         49E8TiujbeemT6dTpTiYwH6UInWRkMwCTHSwtmePv+YXkkf9uIja0m+erd1uIz70nZ13
         nNWqmJDqu1s4/kj+18PBgT+lLRMkULjHTlvyTOMPvO7afi0fQ8rxS9zgU5tXqV1Vwe8J
         bUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xUDENgctdgjBBXz8A4lFhbVhjs4qM3NtkZOrYf6xwoU=;
        b=n0ovBB38YHMGQ+8NpT+cxYSE2E1fr15G5AE7IqfZr+JXVjcPGdX7lXacZf+L3odtNZ
         lDeF0eYd4y1H3fVgGrO8ffBKtOk6QUoq4+Y76FlavpfnPGiKVlVMAURGq1C41ATV5mbh
         Ol+d0gJgMkaczrh0sGfrXXXNEvhieQC4h5VogmkvfjalNUKSBFMopSC/ZENEPCTeXZTd
         8OX+ogOXi5p9aER7PCeZM0s4flGEq8D1O+qRVOmlJMP9SKi+hexX50ejTJ8inmzhub4/
         H/r6p+SBg16hYewgMVQn9syaVbhINIrPnHqo6CcIXkI4lWRISyjWt2/m/c+ReHEMQOwW
         vTlg==
X-Gm-Message-State: AA+aEWYUUj0sXUERqrM8zbPelQk3ZTvTj7aLMIi816PEs6tPzbBRbz+0
        RcB+aKTQx7yBgAtxk4R4CVA37IrF
X-Google-Smtp-Source: AFSGD/V/ZVCDFG4NVAy/DhvIuVuFgbwTe/HBw+oOz5TxLnhazKIxVNL3vWN3TktiJvDlM/ys3Q0TAQ==
X-Received: by 2002:a63:da45:: with SMTP id l5mr12607614pgj.111.1542943115138;
        Thu, 22 Nov 2018 19:18:35 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([45.251.60.215])
        by smtp.gmail.com with ESMTPSA id v62sm35146598pfd.163.2018.11.22.19.18.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 19:18:34 -0800 (PST)
Date:   Fri, 23 Nov 2018 08:48:31 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, Samuel.Li@amd.com,
        michel.daenzer@amd.com, harry.wentland@amd.com, noralf@tronnes.org
Cc:     jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] drm/amd/amdgpu: Remove duplicate header
Message-ID: <20181123031831.GA2470@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove drm/drm_fb_helper.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index b9e9e8b02fb7..1cac12a26a4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -38,7 +38,6 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_plane_helper.h>
-#include <drm/drm_fb_helper.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 #include <linux/hrtimer.h>
-- 
2.17.1

