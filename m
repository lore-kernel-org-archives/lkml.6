Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976E3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4786320878
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUO7y4c8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4786320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbeKUWnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:43:25 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35708 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeKUWnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:43:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id v1-v6so5295122plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 04:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hjs6e+34+F5HLbMhxhfF0KqM0OnTCnmOp0cB2CC4F2c=;
        b=HUO7y4c8yRAQDg4/vtzCW9HFg7ulIy5YUsBLASSXgrzYyGFQtM8TWj+LnMLTNGhiU/
         20FTR+CDWYlaCEzeJghgMdFw9coKxhuUU9HkrYhldMUI30Px203IPSiEO72f6Di6KAY1
         1Map88h4KIdt7vnqv66LGm6pJx7YyfBNNFGYsfUxIClPgJ717jJVXSfT81zOIYhnoSTH
         lLO46TfZVJP4X7xe7EAg7TUginxuaIRoGLPquF1RdBc+pYDknRQUmIGHNyycRDmdZo0g
         wZSm7eAc49Z4Vdps42v8Aa4wqhw78EA7FWa9klUZH2iXsVvFO4PSs/LWmskzUmBxEwAN
         G6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hjs6e+34+F5HLbMhxhfF0KqM0OnTCnmOp0cB2CC4F2c=;
        b=Kb0amxnQpPbfuZPZF1+WelRXlv1+OdJwawzo4lYOedLPvt3gDhv7vvlR0Vxp9gbNgt
         v/2MxKtrs3UdPVTcj4ZpGo/SaZSw1CxItN6Ak1/WSiT/8WvJyRqERlV53HR9oWXiXDPT
         K/CUAjPlY+T61DNtMriL2kAahnyR0qzRtbgxWz63o8L6+RbM99c9mIqIJ/ZQVtE9K1O3
         9BteZizf27dnUBcqjeZAfAvPcwf2ht6THrnWy4I6cyKJ27M92Ae845kRtWmGgQUTH9nC
         NR9KiKiAzlseck9aYpw3sekD85WQ1oNA0CRmzpmO+XI3if1fR4M6AX8rl9Le4EgPtjUb
         4t9Q==
X-Gm-Message-State: AA+aEWYM4DefyjIusU4rcRT4fcMpXhHBIWal1LfHkPANFcFcRr05BGl5
        keSd1aUIUj2yfKL5+mWdxO8=
X-Google-Smtp-Source: AFSGD/V4bcFeYvIS8P8Z8blEE2QttipuHPqPDP/76gDpYo/CW0Ivd98JFGClW+xtEkh/EjiD5W0jdQ==
X-Received: by 2002:a63:5b1f:: with SMTP id p31mr5723135pgb.56.1542802156952;
        Wed, 21 Nov 2018 04:09:16 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([45.251.61.116])
        by smtp.gmail.com with ESMTPSA id x7sm47279673pga.68.2018.11.21.04.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 04:09:16 -0800 (PST)
Date:   Wed, 21 Nov 2018 17:39:13 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, Tony.Cheng@amd.com,
        shirish.s@amd.com, Bhawanpreet.Lakha@amd.com,
        David.Francis@amd.com, Anthony.Koo@amd.com
Cc:     jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] drm/amd/display/amdgpu_dm/amdgpu_dm.c: Remove duplicate
 header
Message-ID: <20181121120913.GA2289@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dm_services_types.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e224f23e2215..62a96c683584 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -38,7 +38,6 @@
 #include "amd_shared.h"
 #include "amdgpu_dm_irq.h"
 #include "dm_helpers.h"
-#include "dm_services_types.h"
 #include "amdgpu_dm_mst_types.h"
 #if defined(CONFIG_DEBUG_FS)
 #include "amdgpu_dm_debugfs.h"
-- 
2.17.1

