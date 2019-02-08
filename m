Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534AEC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F65205C9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549639047;
	bh=QfqY9QJgxxZ7HAFzvUaH9/TT+HcaSxdD+VOLBLYhigE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B+OHUhLCnHcE6ltIwjEeb4eo1WiIWPrZOmRjDEMn9haXQ6IoMdzN0ZEJc1p8N29yA
	 IIh4FA2OQIR76CxJIt+IBuHaarqjUPU1rZDuj384cbbiF1B4PNLouOg3FsWDksNtbo
	 zERm5jBrOPkc9thw7yG+0L2R3ICTgAy/60PtU98E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfBHPRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:17:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40693 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfBHPRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:17:18 -0500
Received: by mail-lf1-f66.google.com with SMTP id t14so2787817lfk.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 07:17:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QnjIDXgRWNWjvTXldHI84YCSiOOYFJ6u69v3q3ucNrE=;
        b=Fl+s0/CFudXY9Sros6gtaw7hx2GXnOvbcDm7++N3HcBLGPKSm9H8IqZzGiWqgCqJW4
         o8ApKgKfqgnrhYs/1Q+wa/q2Csf/+XsptPZ5KqNhOfKuI4ADCOFIv917VMfoLFCVZGfk
         x1wD50IIRK2Fpx/7jD4kjKiWH1DD4IK2k2PPoufzoSGRA0AHWNJKotPC3Ejp8GFgMmCJ
         tligfLmyiy67yeZcwLUqfmRkQhXSETi1hpoQ0RzJMpTDv5Vj2AVTCcnxQFKNrg+Cw9rG
         yNp4FkrQJ6eP1aCEzvIAA7DjwJSf1xKYF8E6dGwoCuOaLVIEu/qgoweuV3lkW7t4TkRM
         uQig==
X-Gm-Message-State: AHQUAuYP3EdT6PGVQqNSM+oVZ/k9yea97WxpRrZMxhfGoHn+hlXkV9Eq
        D7aXvBznHqLYkorWy98bsbY=
X-Google-Smtp-Source: AHgI3Iamv6MSo0wh/kdwKgNcI6D40n2AD3Ezim8rAWxDv5mx72+PHez65iM5SzxOf0KSiwloSgoidg==
X-Received: by 2002:ac2:4318:: with SMTP id l24mr6560964lfh.75.1549639036387;
        Fri, 08 Feb 2019 07:17:16 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id r10-v6sm416231ljj.71.2019.02.08.07.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 07:17:15 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gs7ty-0006y8-5T; Fri, 08 Feb 2019 16:17:14 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 1/2] ASoC: msm8916-wcd-analog: add missing license information
Date:   Fri,  8 Feb 2019 16:16:55 +0100
Message-Id: <20190208151656.26735-2-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208151656.26735-1-johan@kernel.org>
References: <20190208151656.26735-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing license and copyright information which never made it
into the analog driver when the original driver was split in two as part
of the review process.

Link: https://lkml.kernel.org/r/1465582725-30183-3-git-send-email-srinivas.kandagatla@linaro.org
Fixes: 585e881e5b9e ("ASoC: codecs: Add msm8916-wcd analog codec")
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index b7cf7cce95fe..368b6c09474b 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -1,3 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2016, The Linux Foundation. All rights reserved.
+
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
-- 
2.20.1

