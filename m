Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7423C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18F3217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9CQAuI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbeLTM2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:28:49 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45983 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbeLTM2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:28:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so812174plm.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=k9rHEbKegA6s5RLNH5t9xEJfhxHQlkBEBWy7Dog/10c=;
        b=e9CQAuI7yj8QUDQ3g26gY7Kmacyu0jtduQJOkRzcXv11m2UzHgKs/14foc69U1AJXv
         z4h72oaq+5LvkMcBrl9+ko8A337+qxdzgmWabwZKHbt8FPrNDdupHmKIF1q92cAWAOzW
         wfk9f0Fc8mEeEqfTTEJIZqCcnG+FTQ62257l8vIVldHyNJjlG0oQAHWI6pq36bT3GTi2
         4INa7ovWFqmMOvcR94JMjH8k6pYcsni5Spdso8xQ1YVageUWr6zfWK3JHmotGgfp2cgD
         o5e5y6BAeN2HEQM7AA6/HZD/GO9dpZ1R4dATcrFmULV+QpnmgvDp3ggyA1U+DoHzpEQJ
         ifcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=k9rHEbKegA6s5RLNH5t9xEJfhxHQlkBEBWy7Dog/10c=;
        b=cXH3S05cZXY9HYiNDMBJw07REXlloEpAVWWbBiIO+WkiX/khI97K/x9eVsc4HRln02
         pqG0L+JXE3Qfir4r7TuX9hX/CnvcmsfHZ0lamk0UVH81wB0HHI2aqwqmUqZtKbWlFqjE
         qR0KoabAJjS5uCAp4mR8f8YyrjinTmJcFMKKBJMzJeZNxtvzFRq9ulXfHR1B64aPTO85
         odehxg+2q6ltEBEMdWzDwg/K/h/aF6f8lAaCQzRWSKwSJwYvIq9YGKOKVY9WNWw7AbWN
         yYZLZLQiDXY0bgtFRganpCV9Ua5jPTPLnyq48/kmRLB8wT6xIMnC1H/h+VaQtpwiWvPp
         uB9w==
X-Gm-Message-State: AA+aEWZdooAcwvIWrUZxfJfu5uikkL2RzkTPcmpkQf7mqUWIsX7no7A3
        bBu8R8yrujBmvL5s0umoAPjKsNiW
X-Google-Smtp-Source: AFSGD/W8qBeb0JiIu68vRaRdiYM+3QuplEitSv/3wtfoN9RzuBvQ++mnoaxuuLcYvGOkpg6GaURCuw==
X-Received: by 2002:a17:902:a601:: with SMTP id u1mr23900102plq.77.1545308928478;
        Thu, 20 Dec 2018 04:28:48 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([2409:4061:61f:c77a:7447:88ff:6435:ef2b])
        by smtp.gmail.com with ESMTPSA id d13sm11087113pfd.58.2018.12.20.04.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 04:28:47 -0800 (PST)
Date:   Thu, 20 Dec 2018 17:58:41 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, Bhawanpreet.Lakha@amd.com,
        Wesley.Chalmers@amd.com
Cc:     jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] drm/amd/display/dcn10_hw_sequencer_debug: Remove duplicate
 header
Message-ID: <20181220122841.GA24907@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove custom_float.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index 64158900730f..5a563e231be8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -40,7 +40,6 @@
 #include "ipp.h"
 #include "mpc.h"
 #include "reg_helper.h"
-#include "custom_float.h"
 #include "dcn10_hubp.h"
 #include "dcn10_hubbub.h"
 #include "dcn10_cm_common.h"
-- 
2.17.1

