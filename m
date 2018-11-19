Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA711C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED95205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOBiq0i1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED95205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbeKTEbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:31:09 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45525 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730065AbeKTC4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:56:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so14054162pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 08:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rxuiUkzekigpd/TGuvUA3rcP4FRrmO2rAGerDiV3AiM=;
        b=YOBiq0i12wDOavCL0tK7kqeVkT924jwkKVDU1IvPaZKQItLk+bt+a4BTpqPUhSAKWZ
         avkzVzHVkh4ZyhjbQkSY2p86wbYIV8+COOhS90x0EHILhExKRSArLZD+gVPfSLI/MSnj
         CQOhHVdr2l3yPeg3SgRN6/enCRAMRbrubMsi0PkKiG/xt0BKd1j19mDhD9bkefLPWpd+
         68gu3/ZVub7qc1WZ9RAMi8cEifCEgEyTh92RoDECQkGVs8wlKDG+d846vRWt6H+kfamX
         1b+vbX+TqnHsSOZcwSty0Sxo9VkDH6ZdVCXMxLTVyEoPT3cYLNGM7RD4ry/4wBKJRslC
         0nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rxuiUkzekigpd/TGuvUA3rcP4FRrmO2rAGerDiV3AiM=;
        b=NkXVMnJWIXaHY9cj1m9mBLIa1lO8zsUi5YQFHiRHoYGEleZlM0sWecXSs7YKEgHg3D
         6TWeyKSePLAqsELG6lwCyFlkzSQskMSI5b2yRD7v6nJ/4b1TXWYUe8wUPVd5GvEMZHtS
         Gb8VN7ScZHjUZrgHJs7P5m8jmBK9UNDbNDEKZ6AQcXUkKa8weMB7yutyRJRTJIEn/nvh
         JEWavR+vfwS3BFKh7p9C7/h6t+sgGIHG038gAKBPwnsxkQAY2QJFetGg5FshFHiIwmzb
         mK0vjsCqk7nWmeIfIQJJYIwpOKwAfraGD9lroH1xxiSV2iUox0w7I/0cBU3TlMx4xK1u
         /meA==
X-Gm-Message-State: AGRZ1gIVsPptWB/RD19BkrOLCXNXyC3b08dE7vD+fBjwIYW0iRIJQYxD
        l1qxm+MH3Kes9ITy8LOP3oQ=
X-Google-Smtp-Source: AJdET5dMisSGD2LPr8cZfJG+5B+COkZp9m2CreiFqtoR2xPJVOQUtX4Hs4Wo4OOs4Ng6l4IYdl/eGg==
X-Received: by 2002:a63:ba48:: with SMTP id l8mr20407884pgu.72.1542645142679;
        Mon, 19 Nov 2018 08:32:22 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([45.251.61.181])
        by smtp.gmail.com with ESMTPSA id c4sm1260377pfm.151.2018.11.19.08.32.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 08:32:21 -0800 (PST)
Date:   Mon, 19 Nov 2018 22:02:19 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, Rex.Zhu@amd.com,
        andrey.grodzovsky@amd.com, leo.liu@amd.com, David.Panariti@amd.com,
        shirish.s@amd.com
Cc:     jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: Remove duplicate
 header
Message-ID: <20181119163219.GA26520@hp-pavilion-15-notebook-pc-brajeswar>
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
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 3d0f277a6523..4ca1ecf1ffd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -44,7 +44,6 @@
 #include "gca/gfx_8_0_d.h"
 #include "gca/gfx_8_0_enum.h"
 #include "gca/gfx_8_0_sh_mask.h"
-#include "gca/gfx_8_0_enum.h"
 
 #include "dce/dce_10_0_d.h"
 #include "dce/dce_10_0_sh_mask.h"
-- 
2.17.1

