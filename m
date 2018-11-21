Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E07C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D4A2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9kkLApP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D4A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeKURoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:44:25 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42926 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeKURoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:44:25 -0500
Received: by mail-pl1-f193.google.com with SMTP id x21-v6so4122240pln.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 23:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bWfac+VLsU8QkqH+s4FgI4jbp5HCAdqVgdk/4NwZ1Fs=;
        b=E9kkLApPUYTbxSAReYBIJ45IdhhzfYU2myPaa6qqrWYedI3iyy21FsYCF/RIut1iZs
         wAo1v9lchsRHCqbkuxit3sg5AFAVp+Vndp72nef2QCHF7/G3VRSN+vBF91fauu6BDN4l
         TESkDK1Y72IfQZGxJLwHEoWCuCMR1doQ1T0Sg0UjWEQNqr4lN0mF26+dxwwSvtC8XuIj
         jglCtg6wAdhrsQ+uDVvyVOdDz9msQiqKfaVaD630TyGv9o/aRqYP2SB8SF/rvN+hUcD8
         ggBuzQPEw0UtPr4V4FKSBUtCjYuin8uYi4LFE0YqKi3KvBVSUEFds+94yzhXL+Fvkr99
         Y/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bWfac+VLsU8QkqH+s4FgI4jbp5HCAdqVgdk/4NwZ1Fs=;
        b=aG+2AN1lGScOyXrLQWkVMb/Vni5wut5WYgVMbz40zXaBsF2hV8PLj2L6EkfSbuOy43
         tFrciuFNi10uGJVBQdcCSU/oi1RlYCvYckRXPBSSKD8Uaa6okJkT3sMK27WPzQaFLQQn
         WNsk7GI44+YOXMn6KvJsEIIF8YJhXGgVkmrIpVj28PkE209DfjkHZbTc+EEQ1h4golyC
         zAQwNRh7LP0W/iykbqQhcaenJl01Xfb1cP2tC7Ucvj/EnqBH9RPuEhPVm9zdLwaPPkbz
         nAIZJC/riryJpfu7MNLJ3yoHtIvAZ9jclpm3h+/8eYgSBp+ynB5rKS8s5XHwXQyyC5Fp
         VWSg==
X-Gm-Message-State: AA+aEWaOL2MFb/p0nYsZoF45FUlCjxp6aQbRfdGF4Azo9rQtlS4J+g3X
        m0xhCaS9voX+Tsq5aOGVZm8=
X-Google-Smtp-Source: AFSGD/Vjo1uQHsLKIioJVP7Dbr9LsqxNZE42bsL+v9Yxh6bbKoePWu/d6svJfNCyIll/91TDImGOVg==
X-Received: by 2002:a17:902:a50a:: with SMTP id s10mr5358007plq.278.1542784266704;
        Tue, 20 Nov 2018 23:11:06 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([45.251.60.195])
        by smtp.gmail.com with ESMTPSA id y88-v6sm56078992pfd.104.2018.11.20.23.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 23:11:06 -0800 (PST)
Date:   Wed, 21 Nov 2018 12:41:03 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, Jerry.Zhang@amd.com,
        leo.liu@amd.com, andrey.grodzovsky@amd.com, Emily.Deng@amd.com,
        Rex.Zhu@amd.com
Cc:     jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] drm/amd/amdgpu/vce_v3_0.c: Remove duplicate header
Message-ID: <20181121071103.GA2622@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove gca/gfx_8_0_d.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 6dbd39730070..4e4289a06a53 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -37,7 +37,6 @@
 #include "gca/gfx_8_0_d.h"
 #include "smu/smu_7_1_2_d.h"
 #include "smu/smu_7_1_2_sh_mask.h"
-#include "gca/gfx_8_0_d.h"
 #include "gca/gfx_8_0_sh_mask.h"
 #include "ivsrcid/ivsrcid_vislands30.h"
 
-- 
2.17.1

