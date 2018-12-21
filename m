Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84589C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51ADF21920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TM6XErG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390863AbeLUOL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:11:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45702 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388961AbeLUOL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:11:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so2565193pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 06:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4D4gJSNdXtzGM2YZNkSpdlHyLpp7ysvLtBWrdRCKS8Q=;
        b=TM6XErG8CbrAZVcJkh6mJ2xCkfD2+UroblueFp/g9IH0xz7lk0k4nT/Ry0gUJXTNb1
         fqpGCUIJUFEcrCDhm/UY/GPF8Y9EsknyeDF1adEjEUq9lIWkhCh4aC1nT6q3QCGeyU38
         7IBGe/4Wcuu4YeHHSftOChOS/yuzSY+Ajs8w0rHzCo+EoAkWCWjSXg4PJoiJ8KyL5Ltk
         2L0GZFng4xMjhMnzWyj8HNL6iT+1shPlewxjO0qI3AfCmMOdOBHvnzdC6K2Dvn0NSWAu
         zwxTPIQfbd9M+p1DMvgemY4UpUVGuUzCEKON0WA+adi+EXYDXrFJKoYh+0chP0ku9hqH
         qLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4D4gJSNdXtzGM2YZNkSpdlHyLpp7ysvLtBWrdRCKS8Q=;
        b=mrwS24d+VZyYqEut7FPyyTBtpqgRe1NyapfaRvCdKUrQgQmOx1lkaHhfrJ/vaU6jq5
         +UHFyC82ChXvIsjglBRPwhQxWP+FNan8Fyu2oW+yEXvK06s22dJAEhheW9b1F4Bwyrv+
         uzIC/XbFMs/beMBmEmiaD+hd2Uij+Xi+XLEAEYduepAkVNaah13Y5MkZWuFSvH/N0to0
         woskGUT32TcUQWzM5k1JTbWy5G82fqbrcZtG2LDtJwGbRSr6if01swzXHlcGR6G9yq+j
         fMzvG5pZtoCw6D3YWaSTQVb6990UySkFbVj9iTn2f9y5aGqfLABnZC2oQ+NVpaB4CfNH
         /y9Q==
X-Gm-Message-State: AA+aEWb+WfDkaxBzwaWYEy/HWcYhdE06pnYZ8o8O9JuY56mnG8cIsFtw
        udbYErJig8K5R3h1GQiRSdkVdKeN
X-Google-Smtp-Source: AFSGD/WgCBdBrB9hGCNYSDerg11DCSH21chXVYEImlTCK8jlCIG1/BQ+6IhtUebMwlwsLLtD4/+IUw==
X-Received: by 2002:a62:32c4:: with SMTP id y187mr2779283pfy.195.1545401517413;
        Fri, 21 Dec 2018 06:11:57 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([2405:205:639e:5755:50b0:344c:3ddd:ad0e])
        by smtp.gmail.com with ESMTPSA id x3sm77918037pgt.45.2018.12.21.06.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 06:11:56 -0800 (PST)
Date:   Fri, 21 Dec 2018 19:41:50 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     rex.zhu@amd.com, evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie,
        ray.huang@amd.com
Cc:     jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] drm/amd/powerplay/polaris10_smumgr: Remove duplicate
Message-ID: <20181221141150.GA2872@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ppatomctrl.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
index 872d3824337b..2b2c26616902 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
@@ -44,7 +44,6 @@
 
 #include "smu7_hwmgr.h"
 #include "hardwaremanager.h"
-#include "ppatomctrl.h"
 #include "atombios.h"
 #include "pppcielanes.h"
 
-- 
2.17.1

