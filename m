Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BB2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5FB2080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0T52tq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeLSH5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:57:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32784 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLSH5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:57:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so9476473pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 23:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bwjsM6UOxYz/q3EiTnYTPSrdzyEMThfdXPURld13E2I=;
        b=Y0T52tq6EFcbixt9h02+wQcW3+OtmOVM1Lc0Fyjr/fucksstDyT8aSNFByGqSO7XoO
         g4XRrXgxVjg2Kh23HUdv15RAqPHNwAisDq5OEGW7tXbM76j5XA0NQrOb/sraXPROik9R
         UspvogX1xkvT/Js0d57YpEYbzC15uG5hgWXaLXCRPLuP8bDq9tlDQgSDW/Wt1sz/oTI0
         +cruIk8Aab3GPrenKLc3Gi97ILQHmkuCrKToMw+xV8+sCxa8On2IHdvz2uGdJLQlVIdo
         hC227gN36i+zYGnsaXH1thiUIoidPXTgiJfX2euxQjt/ztq0zVS7ySHZAjpjEzgG4H1W
         f4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bwjsM6UOxYz/q3EiTnYTPSrdzyEMThfdXPURld13E2I=;
        b=DzS0wJ/Kvv9B3WeDzAKqYDIgh6NCyf39cKmWVRFgUpQ0RlaRnqC9xmnHm8y3zZ1j2M
         OHwshfrr3czP0dKVb2H4p4bNj1B4qr/UX7uUhOCfs1wvE1bpoQnpQQfVGj1Ur2Usi94L
         DGxoE9/LWtIbLgyBjL3qremf8NMMWo5AG2UFJ4X/5oW1uKbygOhPE0Zl4KXrqceL5Joa
         5xUO8Fb8QkOjT5lyD4UkrcQv7hNiqTEwQLPjPyQ8fFcYhr4Y2bwA7pjPfhrB8/unSbWl
         WM+kF2nqAko5OcYcHFx+wiFoYiQV1EuZipOoLZR982iRvk0h5VJr3P9NdxQq1zgLm+yJ
         XAAA==
X-Gm-Message-State: AA+aEWbXk0jeLSPP4/gDtUtk8GFzSswaVO0KyP52RNChOF2HURMZ+09s
        Jfm1rCynxeriwRtLa6hIZpk=
X-Google-Smtp-Source: AFSGD/Xm8FNqMOGohsK5pJrUJ9KKHm8O3Y0ortGtw2L3GwGtgsTLs49nwUuX+oSHAntzl6P4yd+q4w==
X-Received: by 2002:a63:2946:: with SMTP id p67mr18801555pgp.317.1545206239696;
        Tue, 18 Dec 2018 23:57:19 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([2405:205:611e:b8f0:d98f:6e2c:1ee0:6ffc])
        by smtp.gmail.com with ESMTPSA id b2sm32667973pfm.3.2018.12.18.23.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 23:57:18 -0800 (PST)
Date:   Wed, 19 Dec 2018 13:27:13 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, Tony.Cheng@amd.com,
        Dmytro.Laktyushkin@amd.com, yongqiang.sun@amd.com,
        eric.bernstein@amd.com, Eric.Yang2@amd.com, Anthony.Koo@amd.com,
        nikola.cornij@amd.com
Cc:     jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] drm/amd/display: Remove duplicate header
Message-ID: <20181219075713.GA2259@hp-pavilion-15-notebook-pc-brajeswar>
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
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 193184affefb..3e21c2d26998 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
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

