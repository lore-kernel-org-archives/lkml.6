Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB779C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FDB20855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549639043;
	bh=JF15M1Mj5xNcHtRF3OhR1s+NsNIwt3cGm445lTkfupU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h6jtQb6pSW3VV6c+ehCDpkCdm00+opyNE/FPAYBKpxDimfBLnyg0Cm11VuYaeh2+H
	 jdo3W+NDXrnusB6eJjNgkgVtPmR4jMLDh9BpYln/4BUDg/3mcccBvZ50pnedcwvD7q
	 0DYvYF9rDw1oFAwvT4s9VIcl5LTAhO/nqN54YkwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfBHPRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:17:21 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38542 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfBHPRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:17:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so3305974lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 07:17:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OIqaNH7T0Yvyd0k647oV4FxuaOIgQRT+wKS8ZLb/KxQ=;
        b=MvxUFZRwaAIsguS6O3DBDKuRO2AtAyaLQ6k0UZ+iaNTzYnNJgM5e9Q0rz5tngaNLXW
         gnYVYHogp+lV+GTxKRZ9KB/5VKJWw/Xx3HJyGbjKEr6LQ614syigoX226GtEssjGLoB+
         Pus1EZZ2b31FhRWIBPCX9nXP3k1eXT9wszOaZfB8J/EbV0It0A2v5YT6vN76wuH/HHLM
         cK7KDVpC2llM9tJu4c9VRuwXfyJ7wh1/MW5dzNXaPJ7Uagtaqwghz19zYPZZdg/7+FTb
         LxJa034xcoD849x3vTaiGVaxp8ECJh8lPvwlwdYZTH4PBJ9qkkdsrsPlVIZt02/nJ+bo
         eGYA==
X-Gm-Message-State: AHQUAubOB9hO90ZS1IYvZJ5Nl8CQ0px31Qzi+ymGcxVAK7hb3PDwtz5J
        CrHyJsz5P9zFeg/KPIMJ4fU=
X-Google-Smtp-Source: AHgI3IasVIihGqOUvWAwNxnNIdud3GoPtIJ+1Us6FZnIxK9CPWBxFzRVLagHLba/9u6MjzP12D3UwQ==
X-Received: by 2002:a2e:9f0b:: with SMTP id u11-v6mr12785491ljk.99.1549639037352;
        Fri, 08 Feb 2019 07:17:17 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id x11sm463325lfd.81.2019.02.08.07.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 07:17:16 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gs7ty-0006yD-Rs; Fri, 08 Feb 2019 16:17:14 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 2/2] ASoC: msm8916-wcd-digital: convert license header to SPDX
Date:   Fri,  8 Feb 2019 16:16:56 +0100
Message-Id: <20190208151656.26735-3-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208151656.26735-1-johan@kernel.org>
References: <20190208151656.26735-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the GPLv2-only license header to SPDX.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index 3063dedd21cf..3e7409c85dd2 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -1,14 +1,5 @@
-/* Copyright (c) 2016, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2016, The Linux Foundation. All rights reserved.
 
 #include <linux/module.h>
 #include <linux/err.h>
-- 
2.20.1

