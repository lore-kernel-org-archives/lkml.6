Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AECC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2235121917
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549558725;
	bh=Ab70bes007kjcTyNHtg8mIvWToqJ2ERrEz4rHnoLROE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A+3XLsftBhmgCpXJjd6SU9UlMtFDpMPKE7SURqMczDEtg8/CFJ9IBTFEbMBp+wg4X
	 GxTtfPxCHMPxra/VAV8UD+2wPQTLS4BpdLTd/b716ZNuhGiiH3E+pQRqDc1NC2ZyOe
	 N9e4rwyIvx3a3bfNxwREgv+q2yKLuRzwLFzGOVNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfBGQ6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:58:43 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33442 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfBGQ6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:58:42 -0500
Received: by mail-lj1-f193.google.com with SMTP id f24-v6so523484ljk.0;
        Thu, 07 Feb 2019 08:58:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FliQqFtnS1E4x64NUItgNgFUPTbrV6CBgmMP0IcTLO8=;
        b=kaTNuqG07TYCau+/luqsfAjf/BVY/p9CdDxU+hsKTwsfkp/DRmIb3kWgFgQ1CPjLRw
         qiPt47JzbB0t301th4HeJVQi+ka966edmsLo3qmFQlxMWsNYFJZx2/r1Ue61pU/YnXix
         NsLmD7sTHAYy0zUAVNT8eVzdJ1RfsVLPdiPNfDbe0mb3VsyoD4lva7EVqAec8dsLB7wq
         eVMGaW2CcQDGbiIhJYdXB04c8QhnL40qDKYuQpxMxq2OA1sFVxz1bYTzH0CmrH5Sujat
         50SBbuhen3pNDdmBt2Ndzlqseffb+tkKL9evD6P+fbWAa/v8CBW8Guv/SGJszYmwT72f
         Mw5w==
X-Gm-Message-State: AHQUAuZTcoSW3fV2Ucgm3DtWQ7WD6bYDqKUVnP91SIYUHjvPCbwkVFc4
        uBxXP6EfpcKxAO5hAwkaPAQ=
X-Google-Smtp-Source: AHgI3IbSuEZC7B9Lwuq6j2dgQE4wQ8Jnr4zgljOdme1cHRMVuwxYI/qhqgxRDreI2Q4U6p1+u1SRRw==
X-Received: by 2002:a2e:9c87:: with SMTP id x7-v6mr10267580lji.196.1549558720691;
        Thu, 07 Feb 2019 08:58:40 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id d137sm2670136lfd.38.2019.02.07.08.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 08:58:39 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1grn0Y-0000Pt-5a; Thu, 07 Feb 2019 17:58:38 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/3] ASoC: msm8916-wcd-analog: add missing license information
Date:   Thu,  7 Feb 2019 17:57:53 +0100
Message-Id: <20190207165755.1548-2-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207165755.1548-1-johan@kernel.org>
References: <20190207165755.1548-1-johan@kernel.org>
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
 sound/soc/codecs/msm8916-wcd-analog.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index b7cf7cce95fe..1261ddff75eb 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -1,3 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2016, The Linux Foundation. All rights reserved.
+ */
+
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
-- 
2.20.1

