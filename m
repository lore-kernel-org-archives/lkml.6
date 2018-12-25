Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F20FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 13:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCBE2173B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 13:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLk1endK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbeLYNXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 08:23:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34380 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeLYNXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 08:23:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id j10so6575750pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 05:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=x/nmkKvo+mfsClEJZpa29cFhq7pU6wbhmTLwMhbCRTc=;
        b=NLk1endKp6KohO7sbQeMje3PrpVdfec/30GifmndDXSUwpb9w9mkTnoaIqDdYBDAlL
         xVTUv4YRejUiOZFgtyPOR4CdKxY6JUKbq/FEn676wBT6F6H/lcVb6RDsoiaMG6O4ldYn
         AHOSgtYsdfEnsG14E3Pp7SKZEqfI8Veh5/goRDql5PDJZivQZjYnM+T84GiQm04qTCSH
         D57iUH1hwJq1xVP9HrL192NIf+LeItjC4MSnV1gZI3QWeJ1O4fXQYdwrzWs/LSHI8Zxg
         i1VQHtQ+zQO7pVvG43tSv1EBtK0Mv0PrRgl6fI8oXRoFZJBeBaopuk+E8HXigeqJIc7q
         ytkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=x/nmkKvo+mfsClEJZpa29cFhq7pU6wbhmTLwMhbCRTc=;
        b=lVemM4ymk+q2o0BgPIOy/bJ/hTCOymFvDnmBHWqVKFgmUL6/m1jCeyKWAsPByhuQJN
         Z+pbd+vSDdNgwaxEgt6XR7+n8PstILVB92LgXRv3MzzDEuaMpQni4kuhPY+KXe2oZ6uG
         HDQKTBjCWh9uRaZozep4jDfWVn0TVQqb9S8BMD0tBxVgX5D2pMXn+NWceMDfyE4Out8K
         lVuZDA9DlU9whdFOyeOMLcUgVMfXM0hjyhhuHzSg+gGAOAwKJQ2kKfC8iOwSLyTNdRFw
         hKwoh1eJSk9eor0bkiMbQZd2cjLYMoI0bS1vATlPDQfIfBl82FKXkQyADOjbwIQRNjjr
         ASIw==
X-Gm-Message-State: AA+aEWZT1z4nmSW4U6MiQ/58OH8R15PqX1UQ8BV1Bp11lZD1FeKWkLi5
        zJlqBrOPm14h7+7ihHezTb4=
X-Google-Smtp-Source: AFSGD/UmdHjN7rGcuIaTpwTuvWTcIOC+Kup9rWKXnUC3KWOZRe4Ec3MitReKtAWFKiPHlocyGFiCeA==
X-Received: by 2002:a62:9683:: with SMTP id s3mr16590123pfk.60.1545744226651;
        Tue, 25 Dec 2018 05:23:46 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([2405:204:441f:8d5d:c539:b11b:afea:4db3])
        by smtp.gmail.com with ESMTPSA id d18sm46834732pfj.47.2018.12.25.05.23.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Dec 2018 05:23:45 -0800 (PST)
Date:   Tue, 25 Dec 2018 18:53:40 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie
Cc:     jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] drm/i915_request.h: Remove duplicate header
Message-ID: <20181225132340.GA2584@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove i915_scheduler.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/i915/i915_request.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_request.h b/drivers/gpu/drm/i915/i915_request.h
index 7fa94b024968..3d9d225bc5fc 100644
--- a/drivers/gpu/drm/i915/i915_request.h
+++ b/drivers/gpu/drm/i915/i915_request.h
@@ -30,7 +30,6 @@
 #include "i915_gem.h"
 #include "i915_scheduler.h"
 #include "i915_sw_fence.h"
-#include "i915_scheduler.h"
 
 #include <uapi/drm/i915_drm.h>
 
-- 
2.17.1

