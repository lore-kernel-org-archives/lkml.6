Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE98BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D7F206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6xOuqMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D7F206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbeKWAqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:46:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37067 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeKWAqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:46:48 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so9341350plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1VpbQAbb4/f8gjNHW66DzLa9BjTq95gaQLZAq0eAIUY=;
        b=E6xOuqMehnYyiiEh/bqc1FZoHkPTkRsYznkEPrhn1N5ksnMP6OKHiNJDReiWcn6Ygi
         uxRF4m8pUDKfM4lvA+GdXh4z8sTgAJU/ObLL7nSyLfuIMSYoXBAsBiFGez/dBPYkUgHD
         m0X882Hbzl/yNDTK35ahoTCWN8VBH7n/SzzDdN4eQ3xa9zdWoDq7gSo/3H/0jbo64lFc
         kQNMLgJr++5exyBKDm+jfKCYHF6lx9bqp3iW1LSUjA1JsFxBJcKOWCttH/va6XIc0zZK
         TtBvVY0zK8mYZcTZsLl9Re4QU3d1BhfjEMFxu3AMaUk5ypdxQCcO1wxjzEUiS8L9LBZO
         W88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1VpbQAbb4/f8gjNHW66DzLa9BjTq95gaQLZAq0eAIUY=;
        b=f/Y+vbA/BjgN1tpfU3pvcOL+14sWZP4IaORkruCG7ZawXbyr6bs7HfqMB2KqRBUMDk
         a9hf+JvyCuNIXm43vJFovXWkK2HvRvESv9SGvtFkCiASQxOY8b4AzCFbC05q4Vz8BJ4U
         gEk6/u6vMJoWyWqo8YMcfjVPtKZFgUdDA8b6/CunclQ49AmDJTdDktKS9XRg2O/KH6Yu
         3lTgK+hQgYuW/AMU+LDFjKXrY/I0jHAocuPYZdGQU6LNkZgN7IsuUbCNjw4ppQydug+Z
         Z8Q/xUgk9eG3MwB4FR3zniOVZkL9GxDK80Tgh3+DA+rY0vrJUzEIglT0eP4X/BZOls1j
         dDKw==
X-Gm-Message-State: AA+aEWZGqDfl90xKCHV4NepsZlf2c0kp+otO+0BHlIa6YloPy1YzmzOQ
        z/TE+p8Ik78x7pYItgEvv9XJmktI
X-Google-Smtp-Source: AFSGD/Xudk6jdE5k1bpJrHFy3JLb8L0cCl7UO2s/rx0zLbrS4k2WFlQYF3eD0ZiJxgEQlVuN5UO/YQ==
X-Received: by 2002:a17:902:b092:: with SMTP id p18-v6mr11455380plr.190.1542895637941;
        Thu, 22 Nov 2018 06:07:17 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([45.251.61.83])
        by smtp.gmail.com with ESMTPSA id e23sm66276852pfh.68.2018.11.22.06.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 06:07:17 -0800 (PST)
Date:   Thu, 22 Nov 2018 19:37:14 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     oded.gabbay@gmail.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie
Cc:     jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] drm/amd/amdkfd: Remove duplicate header
Message-ID: <20181122140714.GA3219@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove gca/gfx_8_0_enum.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
index fd60a116be37..c3a5dcfe877a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
@@ -24,7 +24,6 @@
 #include "kfd_device_queue_manager.h"
 #include "gca/gfx_8_0_enum.h"
 #include "gca/gfx_8_0_sh_mask.h"
-#include "gca/gfx_8_0_enum.h"
 #include "oss/oss_3_0_sh_mask.h"
 
 static bool set_cache_memory_policy_vi(struct device_queue_manager *dqm,
-- 
2.17.1

