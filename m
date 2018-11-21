Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48308C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6892146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLq/F7Ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6892146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeKUR6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:58:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40607 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeKUR6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:58:33 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22-v6so4186476pls.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 23:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hjs6e+34+F5HLbMhxhfF0KqM0OnTCnmOp0cB2CC4F2c=;
        b=mLq/F7HtCsk4TPh7nJ31cYq+CC2qbh8RuWl6H+z8gDkFJA0zLecEF6wOtxeSh5L0w8
         gHicyCfthhUQ5R58n67OFFA/8//phSFJHdoZPOd0AusFCPz8YxoIlHVzK3JtflmSMC2O
         Krixs2YWk2aye2PNwQp4g9bf2E4Mi6F4FJvUFWIx8SxXKurPvuZ8wZniwyaUHdrdHNtx
         rPMQIxdXflbmWMCnaTvZMdGEotqDqWEWtHX8HiucrTBI829IpmBlD0+ZYOOQnPaLsLk+
         gOlvJDjzEfaEptLrxonWw3MpAleQ5qB7z5pKEGaUolilgjSm8skxkEQ6gkdDLyBfBYzF
         Daaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hjs6e+34+F5HLbMhxhfF0KqM0OnTCnmOp0cB2CC4F2c=;
        b=SQPc0dUxBjp0JOUuLI2oTnvEcvfYHoni4DoP4FhYm182TjK9H0zsBViMUL6/hydkK7
         wV+CUue5EEZyvLrrXQDbLCv/18c9Hs1svYWcK2B4f+PzNUv3d6dG03XyTPiMcPIFEMs7
         k1ji2asVDpTX3mPE3ysBCAuCgAw/eY9dEHN+j2zCMHbwWeXDFjuKd3lbT1/FTkgJ4CQJ
         ggGYArKIfCwmlEQppxXryc2h1UVGdEp6/otouuE8b8SD6IqFm370wA6+bfS7FMKRXZcG
         9xC8rnjugpJI+PfcKRdlm6o6p7y7RoRv41MxvtAwwpnTWFF0CKyA7jz8jkOhEM/BnN2I
         SXGw==
X-Gm-Message-State: AGRZ1gIHni/QT6zfsxhaHQKbt2LihheEkkdXX4dLYYUNkkDMxaJ8H7KA
        slqVxS82iY2hi9XELec+yew=
X-Google-Smtp-Source: AJdET5crsvOcH61dRLy0woCwWldy/coOoQGA/Ia23mG0JBjF/xfv+PwquUp3WDizAtDRhkAoTu+BdQ==
X-Received: by 2002:a62:6547:: with SMTP id z68-v6mr5480484pfb.169.1542785112769;
        Tue, 20 Nov 2018 23:25:12 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([45.251.60.195])
        by smtp.gmail.com with ESMTPSA id h134sm27432395pfe.27.2018.11.20.23.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 23:25:12 -0800 (PST)
Date:   Wed, 21 Nov 2018 12:55:08 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, Tony.Cheng@amd.com,
        mikita.lipski@amd.com, shirish.s@amd.com,
        Bhawanpreet.Lakha@amd.com, David.Francis@amd.com,
        Anthony.Koo@amd.com
Cc:     jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] drm/amd/display/amdgpu_dm/amdgpu_dm.c: Remove duplicate
 header
Message-ID: <20181121072508.GA2948@hp-pavilion-15-notebook-pc-brajeswar>
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

