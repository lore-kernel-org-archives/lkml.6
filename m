Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9283FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5EF2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+kcajeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5EF2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbeKVA00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:26:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37578 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbeKVA00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:26:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so5654749plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 05:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cETyAdPLrLTj0wzmDmaxzOJk55XPIRRxIlHTFh1H2r4=;
        b=d+kcajeq5S7J3WFU7KkCrbpL4Pb4jlGFSCpI+TjuQ8aWtsY3SPqRGzrvQf4jvstLOq
         soyRIQu/PSU8IzhJweloKKXHSJrVfgl1warXSjfvKAt99DJ9PRprkAPvMcazI2lMY7Us
         QThgWwlUNvXvGtO3AeNQ9/wsSVfDLWE6uI8HAb89ca3l0Lb8T3IzvTXIzuGwnC5pss58
         /+61XFxKL3O8O1d0ggBFxt0hJWX0fo8wIuQytV3tT69gm3YN+d49do8Z/YFwkvplVx34
         nPfaAPtdCus2rdJwyZYcbPLeoCsQ4qy9QzyWzUoh5pktuJOn3BSvAIc5Y8jkjq5EbOey
         k+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cETyAdPLrLTj0wzmDmaxzOJk55XPIRRxIlHTFh1H2r4=;
        b=XuTr0sJS6d57ot0CAb9UKnCBu7V6hiziQX65eUQ1M6X6Mca//7dXRwwnP93Ykb2w4k
         sMXSi+rax+cfNRpVTWI1ZAvVe8e6xy43GxqOTl3NC4w4Tgdnicg1Bo/Qddrab4gv0NWT
         gCpm0WejDm7F9Bo+zoZW9xprnayTPGRcqynL6NZJicd0sWftnDnz17bjXY+9EpmqGkXW
         AVQhBePtcYzpZF1fWNFFQWu66yjZxgeiL+yyTe4qoZsCZfApJGZb1XK6nXEf6vCA9uwm
         NWldEpsuNIcNIMyVuuqDgSUN9isGC2vnJP4/yAqzy1nCYRRfe/CVjUd7S2ICf5sCAZoC
         fz5A==
X-Gm-Message-State: AA+aEWYsKLG56RwzNAm0M84xzlvLEL7Amwt717Ukze2nV4M3n/jh5Z+M
        zSZWW253NvFfV7n5Z16dMyk=
X-Google-Smtp-Source: AFSGD/Xldf0My1L1M9IY5kkVMojTtlSoWsy4B82HAjnWqcL4RK7DjG83Y3ZAeJpGGK0GxbkNL5mwLg==
X-Received: by 2002:a63:83c1:: with SMTP id h184mr5968333pge.437.1542808315957;
        Wed, 21 Nov 2018 05:51:55 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([45.251.62.8])
        by smtp.gmail.com with ESMTPSA id a9sm18943242pgq.20.2018.11.21.05.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 05:51:55 -0800 (PST)
Date:   Wed, 21 Nov 2018 19:21:52 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, andrey.grodzovsky@amd.com,
        Pixel.Ding@amd.com, Monk.Liu@amd.com
Cc:     jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] drm/amd/amdgpu: Remove duplicate header
Message-ID: <20181121135151.GA2536@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove gca/gfx_8_0_sh_mask.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index 64e875d528dd..6a0fcd67662a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -37,7 +37,6 @@
 #include "gmc/gmc_8_2_sh_mask.h"
 #include "oss/oss_3_0_d.h"
 #include "oss/oss_3_0_sh_mask.h"
-#include "gca/gfx_8_0_sh_mask.h"
 #include "dce/dce_10_0_d.h"
 #include "dce/dce_10_0_sh_mask.h"
 #include "smu/smu_7_1_3_d.h"
-- 
2.17.1

